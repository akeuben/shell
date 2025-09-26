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

        constructor(data: string[]) {
            super();

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
            this.m_songs = songData.map(d => new Song(d));
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

        private m_current_song?: Song = undefined;
        private m_queue: Queue
        private m_connected: boolean = false;

        private _client: Gio.SocketClient;
        private _host: string;
        private _port: number;
        private _ctrlConn: Gio.SocketConnection | null;
        private _ctrlIn: Gio.DataInputStream | null;
        private _ctrlOut: Gio.OutputStream | null;
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
            this._ctrlConn = null;   // commands
            this._ctrlIn = null;
            this._ctrlOut = null;

            this._idleConn = null;   // idle events
            this._idleIn = null;
            this._idleOut = null;

            this.activate().then(async () => {
                await this._updateCurrentSong();
                await this._updateQueue();

                this._sendIdle();
            })

        }
        
        async activate() {
            try {

                // --- Control connection
                [this._ctrlConn, this._ctrlIn, this._ctrlOut] = await this._createConnection();
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
            console.log(`Connected to ${version}`);

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

        async _execute_queue() {
            if(this._queue_executing)
                return;

            this._queue_executing = true;

            [this._ctrlConn, this._ctrlIn, this._ctrlOut] = await this._createConnection();
            
            while(this._command_queue.length > 0) {
                const {cmd, callback} = this._command_queue.shift() as {cmd: string, callback: (arg0: string[]) => any};
                
                if (!this._ctrlOut) return [];
                try {
                    this._ctrlOut.write_all(cmd, null);
                } catch(e) {
                    console.error("FAILED TO WRITE TO OUT!");
                    return;
                }

                let message: string[] = [];
                try {
                    message = await this._readMessage(this._ctrlIn as any);
                } catch(e) {
                    console.error("FAILED TO READ FROM IN!");
                    return;
                }

                callback(message);
            }

            this._ctrlConn.close(null);

            this._queue_executing = false;
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
            
            return new Promise((resolve) => {
                this._command_queue.push({cmd: data, callback: resolve});
                this._execute_queue();
            })
            
        }

        async sendCommandUnsafe(cmd: string, ...args: string[]): Promise<string[]> {
            let data = `${cmd} ${args.map(arg => arg.includes(" ") ? `"${arg}"` : arg).join(" ")}\n`;
            
            return new Promise((resolve) => {
                this._command_queue.push({cmd: data, callback: resolve});
                this._execute_queue();
            })
            
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

                GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
                    this._sendIdle();
                    return GLib.SOURCE_REMOVE;
                });

            } catch(e) {
                console.log("error", e);
            }

        }

        close() {
            if (this._ctrlConn) {
                this._ctrlConn.close(null);
                this._ctrlConn = null;
            }
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
            return songData.map(d => new Song(d));
        }

        public async pause() {
            await this.sendCommand("pause", "1")
        }

        async _updateCurrentSong() {
            const data = await this.sendCommand("currentsong");
            this.m_current_song = new Song(data || []);
            this.notify("current_song");
        }

        async _updateQueue() {
            this.m_queue._updateSongList();
        }
    }
}
