import { Gdk } from "ags/gtk4";
import Gio from "gi://Gio?version=2.0";
import GLib from "gi://GLib?version=2.0";
import GObject, { getter, register, setter } from "gnim/gobject";

export namespace KappashellMPD {

    let instance: MPDClient = null as any;

    export function get_default() {
        if(!instance) {
            instance = new MPDClient({host: "localhost", port: 6600});
        }

        return instance;
    }

    @register() 
    export class Song extends GObject.Object {
        declare static $gtype: GObject.GType<Song>;

        @getter(String)
        get file() {
            return this.m_file;
        }
        private m_file: string = "";

        @getter(String)
        get last_modified() {
            return this.m_last_modified;
        }
        private m_last_modified: string = "";
        @getter(String)
        get added() {
            return this.m_added;
        }
        private m_added: string = "";
        @getter(String)
        get format() {
            return this.m_format;
        }
        private m_format: string = "";
        @getter(String)
        get artist() {
            return this.m_artist;
        }
        private m_artist: string = "";
        @getter(String)
        get album() {
            return this.m_album;
        }
        private m_album: string = "";
        @getter(String)
        get title() {
            return this.m_title;
        }
        private m_title: string = "";
        @getter(String)
        get track() {
            return this.m_track;
        }
        private m_track: string = "";
        @getter(String)
        get date() {
            return this.m_date;
        }
        private m_date: string = "";
        @getter(String)
        get composer() {
            return this.m_composer;
        }
        private m_composer: string = "";
        @getter(String)
        get disc() {
            return this.m_disc;
        }
        private m_disc: string = "";
        @getter(String)
        get time() {
            return this.m_time;
        }
        private m_time: string = "";
        @getter(String)
        get duration() {
            return this.m_duration;
        }
        private m_duration: string = "";
        @getter(String)
        get pos() {
            return this.m_pos;
        }
        private m_pos: string = "";
        @getter(String)
        get id() {
            return this.m_id;
        }
        private m_id: string = "";

        @getter(Gdk.Paintable)
        get album_art() {
            if(!this.art_loaded) {
                throw new Error("Art must be loaded with $load_album_art() before reading $album_art.");
            }

            return this.m_album_art;
        }
        private m_album_art: Gdk.Paintable;

        private art_loaded: boolean = false;

        private client: MPDClient;

        constructor(client: MPDClient, data: string[]) {
            super();

            this.client = client;
            this.m_album_art = Gdk.MemoryTexture.new(1, 1, Gdk.MemoryFormat.R8G8B8A8, new Uint8Array([
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            ]), 4);

            for(const line of data) {
                const start = line.split(": ")[0];
                const data = line.split(": ")[1];
                switch(start) {
                    case "file":
                        this.m_file = data;
                        break;
                    case "Last-Modified":
                        this.m_last_modified = data;
                        break;
                    case "Added":
                        this.m_added = data;
                        break;
                    case "Format":
                        this.m_format = data;
                        break;
                    case "Artist":
                        this.m_artist = data;
                        break;
                    case "Album":
                        this.m_album = data;
                        break;
                    case "Title":
                        this.m_title = data;
                        break;
                    case "Track":
                        this.m_track = data;
                        break;
                    case "Date":
                        this.m_date = data;
                        break;
                    case "Composer":
                        this.m_composer = data;
                        break;
                    case "Disc":
                        this.m_disc = data;
                        break;
                    case "Time":
                        this.m_time = data;
                        break;
                    case "duration":
                        this.m_duration = data;
                        break;
                    case "Pos":
                        this.m_pos = data;
                        break;
                    case "Id":
                        this.m_id = data;
                        break;
                }
            }
        }

        public async load_album_art() {
            if(this.art_loaded) return;
            const bytes = await this.client.sendBinaryCommand("readpicture", this.file);
            this.m_album_art = Gdk.Texture.new_from_bytes(bytes);
            this.art_loaded = true;
        }
    }

    @register()
    export class Queue extends GObject.Object {
        declare static $gtype: GObject.GType<Queue>;
        
        @getter(Array<Song>)
        get songs() {
            return this.m_songs;
        }

        @setter(Array<Song>)
        set songs(songs: Song[]) {
            this._set_songs(songs);
        }

        private m_songs: Song[] = [];

        private client: MPDClient;

        constructor(client: MPDClient) {
            super();

            this.client = client;
        }

        async _updateSongList() {
            let data: string[] = [];
            try {
                data = await this.client.sendCommand("playlistinfo");
            } catch {
                console.log("failed go get playlistinfo");
            }

            const songData: string[][] = [];
            let i = -1;
            for(const line of data) {
                if(line.startsWith("file:")) {
                    i++;
                    songData.push([]);
                }
                songData[i].push(line);
            }
            this.m_songs = songData.map(d => new Song(this.client, d));
            try {
                this.notify("songs");
            } catch(_) {
                console.log("error");
            }
        }

        async _set_songs(songs: Song[]) {
            this.client._lock_count++;
            await this.client.sendCommandUnsafe("clear");
            for(const song of songs) {
                await this.client.sendCommandUnsafe("add", song.file);
            }
            this.client._lock_count--;

            if(this.client._lock_count == 0) {
                for(const cb of this.client._lock_callbacks) {
                    cb();
                }
            }
        }

        public async remove(song: string | number | Song) {
            if(typeof song === "number" || typeof song === "string") {
                await this.client.sendCommand("delete", `${song}`);
            } else {
                await this.client.sendCommand("delete", `${song.pos}`);
            }
        }

        public async add(song: Song | string, position = "") {
            let file = "";
            if(typeof song === "string") {
                file = song;
            } else {
                file = song.file;
            }

            const length = this.songs.length;

            await this.client.sendCommand("add", file, length === 0 ? "" : position);

            if(length == 0) {
                await this.client.sendCommand("play", "0");
            }
        }

        public async clear() {
            this.client.sendCommand("clear");
        }

        public async swap(song1: string | number | Song, song2: string | number | Song) {
            let pos1 = "0";
            let pos2 = "0";

            if(typeof song1 === "string" || typeof song1 === "number") {
                pos1 = `${song1}`;
            } else {
                pos1 = song1.pos;
            }
            if(typeof song2 === "string" || typeof song2 === "number") {
                pos2 = `${song2}`;
            } else {
                pos2 = song2.pos;
            }
            
            this.client.sendCommand("move", pos1, pos2);
        }
    }

    @register()
    export class Playlist extends GObject.Object {
        declare static $gtype: GObject.GType<Playlist>;

        @getter(String)
        get name() {
            return this.m_name;
        }

        @setter(String)
        set name(name: string) {
            this._set_name(name);
            this.m_name = name;
            this.notify("name");
        }

        @getter(Array<Song>)
        get songs() {
            return this.m_songs;
        }

        @setter(Array<Song>)
        set songs(songs: Song[]) {
            this._set_songs(songs);
        }

        private m_songs: Song[] = [];
        private m_name: string;

        private client: MPDClient;

        public constructor(client: MPDClient, name: string) {
            super();

            this.m_name = name;
            this.client = client;

            this._updateSongList();
        }

        async _set_name(name: string) {
            this.client._lock_count++;
            await this.client.sendCommandUnsafe("rename", this.m_name, name);
            this.client._lock_count--;

            if(this.client._lock_count == 0) {
                for(const cb of this.client._lock_callbacks) {
                    cb();
                }
            }
        }

        async _updateSongList() {
            let data: string[] = [];
            try {
                data = await this.client.sendCommand("listplaylistinfo", this.name);
            } catch {
                console.log("failed go get listplaylistinfo");
            }

            const songData: string[][] = [];
            let i = -1;
            for(const line of data) {
                if(line.startsWith("file:")) {
                    i++;
                    songData.push([]);
                }
                songData[i].push(line);
            }
            this.m_songs = songData.map(d => new Song(this.client, d));
            try {
                this.notify("songs");
            } catch(_) {
                console.log("error");
            }
        }

        async _set_songs(songs: Song[]) {
            this.client._lock_count++;
            await this.client.sendCommandUnsafe("playlistclear", this.name);
            for(const song of songs) {
                await this.client.sendCommandUnsafe("playlistadd", this.name, song.file);
            }
            this.client._lock_count--;

            if(this.client._lock_count == 0) {
                for(const cb of this.client._lock_callbacks) {
                    cb();
                }
            }
        }

        async play() {
            await this.client.sendCommand("clear");
            await this.client.sendCommand("load", this.name);
            await this.client.sendCommand("play", "0");
        }

        async delete() {
            await this.client.sendCommand("rm", this.name);
            this.client.notify("playlists");
        }

        async add_song(song: string | Song) {
            let s = "";
            if(typeof song === "string") {
                s = song;
            } else {
                s = song.file;
            }

            await this.client.sendCommand("playlistadd", this.name, s);

            this.notify("songs");
        }

        async remove_song(index: number) {
            await this.client.sendCommand("playlistdelete", this.name, `${index}`);
        }
    }

    @register()
    export class MPDClient extends GObject.Object {
        declare static $gtype: GObject.GType<MPDClient>;

        @getter(Song)
        get current_song() {
            return this.m_current_song as Song;
        }

        @getter(Queue)
        get queue() {
            return this.m_queue;
        }

        @getter(Boolean)
        get connected() {
            return this.m_connected;
        }

        @getter(Array<Playlist>)
        get playlists() {
            return this.m_playlists;
        }

        private m_current_song?: Song = undefined;
        private m_queue: Queue
        private m_connected: boolean = false;
        private m_playlists: Array<Playlist> = [];

        private _client: Gio.SocketClient;
        private _host: string;
        private _port: number;
        private _idleConn: Gio.SocketConnection | null;
        private _idleIn: Gio.DataInputStream | null;
        private _idleOut: Gio.OutputStream | null;
        private _command_queue: {cmd: string, callback: (arg0: string[]) => void}[] = [];
        private _queue_executing: boolean = false;
        _lock_count: number = 0;
        _lock_callbacks: ((arg0?: unknown) => void)[] = [];
        
        constructor(params: {host?: string, port?: number} = {}) {
            super();

            this.m_queue = new Queue(this);

            this._client = new Gio.SocketClient();
            this._host = params.host || "127.0.0.1";
            this._port = params.port || 6600;

            this._idleConn = null;   // idle events
            this._idleIn = null;
            this._idleOut = null;

            this.activate().then(async () => {
                await this._updateCurrentSong();
                await this._updateQueue();
                await this._updatePlaylists();

                this._sendIdle();
            })

        }
        
        async activate() {
            try {
                [this._idleConn, this._idleIn, this._idleOut] = await this._createConnection();

                this.m_connected = true;
                this.notify("connected");
            } catch (_) {}
        }

        async _createConnection(): Promise<[Gio.SocketConnection, Gio.DataInputStream, Gio.OutputStream]> {
            const conn = this._client.connect_to_host(this._host, this._port, null);
            const inStream = new Gio.DataInputStream({
                base_stream: conn.get_input_stream(),
            });
            const outStream = conn.get_output_stream();

            const version = await this._readLine(inStream);

            return [conn, inStream, outStream];
        }

        async _readLine(stream: Gio.DataInputStream): Promise<string> {
            return new Promise((resolve, reject) => {
                stream.read_line_async(GLib.PRIORITY_DEFAULT, null, (_a, res) => {
                    const [data, _] = stream.read_line_finish_utf8(res);
                    if(data)
                        resolve(data);
                    else 
                        reject(data);

                });
            });
        }
        async _readBinary(stream: Gio.DataInputStream, length: number): Promise<GLib.Bytes> {
            return new Promise((resolve) => {
                stream.read_bytes_async(length, GLib.PRIORITY_DEFAULT, null, (_a, res) => {
                    const bytes = stream.read_bytes_finish(res);
                    resolve(bytes);
                })
            });
        }

        async _readMessage(stream: Gio.DataInputStream): Promise<string[]> {
            const result: string[] = []
            while(true) {
                const line = await this._readLine(stream);

                if(line.includes("OK") || line.includes("ACK")) {
                    return result;
                }

                result.push(line);
            }
        }

        // --- Command interface
        async sendCommand(cmd: string, ...args: string[]): Promise<string[]> {
            if(this._lock_count > 0) {
                const lock = new Promise((resolve) => {
                    this._lock_callbacks.push(resolve);
                })

                await lock;
            }

            let data = `${cmd} ${args.map(arg => arg.includes(" ") ? `"${arg}"` : arg).join(" ")}\n`;
            
            const [ctrlConn, ctrlIn, ctrlOut] = await this._createConnection();
            ctrlOut.write_all(data, null);

            const message = await this._readMessage(ctrlIn as any);
            ctrlConn.close(null);

            return message;
        }

        async _get_binary_length(stream: Gio.DataInputStream): Promise<{total_size: number, chunk_size: number}> {
            const result: {total_size: number, chunk_size: number} = {
                total_size: -1,
                chunk_size: -1,
            }
            while(true) {
                const line = await this._readLine(stream);

                if(line.startsWith("binary")) {
                    result.chunk_size = parseInt(line.split(": ")[1].trim());

                    if(result.total_size == -1) {
                        result.total_size = result.chunk_size;
                    }


                    return result;
                }
                if(line.startsWith("size")) {
                    result.total_size = parseInt(line.split(": ")[1].trim());
                }

                if(line.startsWith("OK") || line.startsWith("ACK")) {
                    throw new Error("Failed to read binary data from input stream.");
                }
            }
        }

        async sendBinaryCommand(cmd: string, ...args: string[]): Promise<GLib.Bytes> {
            if(this._lock_count > 0) {
                const lock = new Promise((resolve) => {
                    this._lock_callbacks.push(resolve);
                })

                await lock;
            }

            let data = `${cmd} ${args.map(arg => arg.includes(" ") ? `"${arg}"` : arg).join(" ")}`;
            
            const [ctrlConn, ctrlIn, ctrlOut] = await this._createConnection();

            let offset = 0;

            const binaryChunks: GLib.Bytes[] = [];
            
            while(true) {
                const sending = `${data.trim()} ${offset}\n`;
                ctrlOut.write_all(sending, null);
                
                const {total_size, chunk_size} = await this._get_binary_length(ctrlIn);

                const binaryChunk = await this._readBinary(ctrlIn, chunk_size);
                binaryChunks.push(binaryChunk);

                if(offset + chunk_size >= total_size) break;

                offset += chunk_size;

                await new Promise((resolve) => ctrlIn.read_bytes_async(1, GLib.PRIORITY_DEFAULT, null, (_, res) => {
                    ctrlIn.read_all_finish(res);
                    resolve({});
                }));

                await this._readMessage(ctrlIn);
            }
            
            ctrlConn.close(null);

            const totalByteSize = binaryChunks.reduce((sum, b) => sum + b.get_size(), 0);

            let combined = new Uint8Array(totalByteSize);

            offset = 0;
            for(let b of binaryChunks) {
                let chunk = b.toArray();
                combined.set(chunk, offset);
                offset += chunk.length;
            }

            return new GLib.Bytes(combined);
        }

        async sendCommandUnsafe(cmd: string, ...args: string[]): Promise<string[]> {
            let data = `${cmd} ${args.map(arg => arg.includes(" ") ? `"${arg}"` : arg).join(" ")}\n`;
            
            const [ctrlConn, ctrlIn, ctrlOut] = await this._createConnection();
            ctrlOut.write_all(data, null);

            const message = await this._readMessage(ctrlIn as any);

            ctrlConn.close(null);

            return message;
            
        }

        // --- Idle interface
        async _sendIdle() {
            try {
                if (!this._idleOut) return;
                this._idleOut.write_all("idle\n", null);
                const data = await this._readMessage(this._idleIn as any);
                const changed = data.filter(d => d.includes("changed"))
                    .map(d => d.split(": ")[1])

                if(changed.includes("player")) {
                    await this._updateCurrentSong();
                }
                if(changed.includes("playlist")) {
                    await this._updateQueue();
                }
                if(changed.includes("stored_playlist")) {
                    await this._updatePlaylists();
                }

                GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
                    this._sendIdle();
                    return GLib.SOURCE_REMOVE;
                });

            } catch(e) {
                console.log("error", e);
            }

        }

        close() {
            if (this._idleConn) {
                this._idleConn.close(null);
                this._idleConn = null;
            }
        }

        public async flush() {
            
        }

        public async toggle() {
            await this.sendCommand("pause");
        }

        public async resume() {
            await this.sendCommand("pause", "0")
        }

        public async play(pos: string | number = "0") {
            await this.sendCommand("play", `${pos}`)
        }

        public async next() {
            await this.sendCommand("next");
        }

        public async prev() {
            await this.sendCommand("previous");
        }

        public async search_songs(term: string, field: 'title' | 'artist' | 'album') {
            let data = await this.sendCommand("search", `(${field} contains '${term}')`);

            const songData: string[][] = [];
            let i = -1;
            for(const line of data) {
                if(line.startsWith("file:")) {
                    i++;
                    songData.push([]);
                }
                songData[i].push(line);
            }
            return songData.map(d => new Song(this, d)).filter((s, i, l) => i === l.findIndex(s2 => s2.file === s.file));
        }

        public async pause() {
            await this.sendCommand("pause", "1")
        }

        async _updateCurrentSong() {
            const data = await this.sendCommand("currentsong");
            this.m_current_song = new Song(this, data || []);
            this.notify("current_song");
        }

        async _updateQueue() {
            this.m_queue._updateSongList();
        }

        async _updatePlaylists() {
            const data = await this.sendCommand("listplaylists");

            let new_playlists = data.filter(line => line.startsWith("playlist: "))
                .map(line => line.substring(line.indexOf(":") + 2));


            this.m_playlists = this.m_playlists.filter(pl => new_playlists.includes(pl.name));

            await Promise.all(this.m_playlists.map(async (pl) => await pl._updateSongList()));
            
            for(const pl of new_playlists) {
                if(this.m_playlists.findIndex(p => p.name === pl) === -1) {
                    this.m_playlists.push(new Playlist(this, pl));
                }
            }

            this.notify("playlists");
        }
    }
}
