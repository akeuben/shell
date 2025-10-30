pub const ext = @import("ext.zig");
const camel = @This();

const std = @import("std");
const compat = @import("compat");
const libxml2 = @import("libxml22");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
pub const _block_t = u32;

pub const _hash_t = u32;

pub const _key_t = u32;

pub const Address = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.AddressClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.AddressPrivate,

    pub const virtual_methods = struct {
        /// Concatenate one address onto another. The addresses must
        /// be of the same type.
        pub const cat = struct {
            pub fn call(p_class: anytype, p_dest: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *camel.Address) c_int {
                return gobject.ext.as(Address.Class, p_class).f_cat.?(gobject.ext.as(Address, p_dest), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dest: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *camel.Address) callconv(.c) c_int) void {
                gobject.ext.as(Address.Class, p_class).f_cat = @ptrCast(p_implementation);
            }
        };

        /// Construct a new address from a raw address field.
        pub const decode = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_raw: [*:0]const u8) c_int {
                return gobject.ext.as(Address.Class, p_class).f_decode.?(gobject.ext.as(Address, p_addr), p_raw);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_raw: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Address.Class, p_class).f_decode = @ptrCast(p_implementation);
            }
        };

        /// Encode an address in a format suitable for a raw header.
        pub const encode = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(Address.Class, p_class).f_encode.?(gobject.ext.as(Address, p_addr));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Address.Class, p_class).f_encode = @ptrCast(p_implementation);
            }
        };

        /// Format an address in a format suitable for display.
        pub const format = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(Address.Class, p_class).f_format.?(gobject.ext.as(Address, p_addr));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Address.Class, p_class).f_format = @ptrCast(p_implementation);
            }
        };

        /// Get the number of addresses stored in the address `addr`.
        pub const length = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Address.Class, p_class).f_length.?(gobject.ext.as(Address, p_addr));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Address.Class, p_class).f_length = @ptrCast(p_implementation);
            }
        };

        /// Remove an address by index, or all addresses.
        pub const remove = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_int) void {
                return gobject.ext.as(Address.Class, p_class).f_remove.?(gobject.ext.as(Address, p_addr), p_index);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_int) callconv(.c) void) void {
                gobject.ext.as(Address.Class, p_class).f_remove = @ptrCast(p_implementation);
            }
        };

        /// Attempt to convert a previously formatted and/or edited
        /// address back into internal form.
        pub const unformat = struct {
            pub fn call(p_class: anytype, p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_raw: [*:0]const u8) c_int {
                return gobject.ext.as(Address.Class, p_class).f_unformat.?(gobject.ext.as(Address, p_addr), p_raw);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_addr: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_raw: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Address.Class, p_class).f_unformat = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.Address` object.
    extern fn camel_address_new() *camel.Address;
    pub const new = camel_address_new;

    /// Concatenate one address onto another. The addresses must
    /// be of the same type.
    extern fn camel_address_cat(p_dest: *Address, p_source: *camel.Address) c_int;
    pub const cat = camel_address_cat;

    /// Copy the contents of one address into another.
    extern fn camel_address_copy(p_dest: *Address, p_source: *camel.Address) c_int;
    pub const copy = camel_address_copy;

    /// Construct a new address from a raw address field.
    extern fn camel_address_decode(p_addr: *Address, p_raw: [*:0]const u8) c_int;
    pub const decode = camel_address_decode;

    /// Encode an address in a format suitable for a raw header.
    extern fn camel_address_encode(p_addr: *Address) [*:0]u8;
    pub const encode = camel_address_encode;

    /// Format an address in a format suitable for display.
    extern fn camel_address_format(p_addr: *Address) [*:0]u8;
    pub const format = camel_address_format;

    /// Get the number of addresses stored in the address `addr`.
    extern fn camel_address_length(p_addr: *Address) c_int;
    pub const length = camel_address_length;

    /// Clone an existing address type.
    extern fn camel_address_new_clone(p_addr: *Address) *camel.Address;
    pub const newClone = camel_address_new_clone;

    /// Remove an address by index, or all addresses.
    extern fn camel_address_remove(p_addr: *Address, p_index: c_int) void;
    pub const remove = camel_address_remove;

    /// Attempt to convert a previously formatted and/or edited
    /// address back into internal form.
    extern fn camel_address_unformat(p_addr: *Address, p_raw: [*:0]const u8) c_int;
    pub const unformat = camel_address_unformat;

    extern fn camel_address_get_type() usize;
    pub const getGObjectType = camel_address_get_type;

    extern fn g_object_ref(p_self: *camel.Address) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Address) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Address, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockFile = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.BlockFileClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.BlockFilePrivate,

    pub const virtual_methods = struct {
        pub const init_root = struct {
            pub fn call(p_class: anytype, p_bs: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(BlockFile.Class, p_class).f_init_root.?(gobject.ext.as(BlockFile, p_bs));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_bs: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(BlockFile.Class, p_class).f_init_root = @ptrCast(p_implementation);
            }
        };

        pub const validate_root = struct {
            pub fn call(p_class: anytype, p_bs: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(BlockFile.Class, p_class).f_validate_root.?(gobject.ext.as(BlockFile, p_bs));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_bs: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(BlockFile.Class, p_class).f_validate_root = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Allocate a new block file, stored at `path`.  `version` contains an 8 character
    /// version string which must match the head of the file, or the file will be
    /// intitialised.
    ///
    /// `block_size` is currently ignored and is set to CAMEL_BLOCK_SIZE.
    extern fn camel_block_file_new(p_path: [*:0]const u8, p_flags: c_int, p_version: [*:0]const u8, p_block_size: usize) ?*camel.BlockFile;
    pub const new = camel_block_file_new;

    /// Reattach a block that has been detached.
    extern fn camel_block_file_attach_block(p_bs: *BlockFile, p_bl: *camel.Block) void;
    pub const attachBlock = camel_block_file_attach_block;

    /// Deletes existing block file.
    extern fn camel_block_file_delete(p_bs: *BlockFile) c_int;
    pub const delete = camel_block_file_delete;

    /// Detatch a block from the block file's cache.  The block should
    /// be unref'd or attached when finished with.  The block file will
    /// perform no writes of this block or flushing of it if the cache
    /// fills.
    extern fn camel_block_file_detach_block(p_bs: *BlockFile, p_bl: *camel.Block) void;
    pub const detachBlock = camel_block_file_detach_block;

    extern fn camel_block_file_free_block(p_bs: *BlockFile, p_id: camel._block_t) c_int;
    pub const freeBlock = camel_block_file_free_block;

    /// Retreive a block `id`.
    extern fn camel_block_file_get_block(p_bs: *BlockFile, p_id: camel._block_t) ?*camel.Block;
    pub const getBlock = camel_block_file_get_block;

    extern fn camel_block_file_get_cache_limit(p_bs: *BlockFile) c_int;
    pub const getCacheLimit = camel_block_file_get_cache_limit;

    extern fn camel_block_file_get_root(p_bs: *BlockFile) *camel.BlockRoot;
    pub const getRoot = camel_block_file_get_root;

    extern fn camel_block_file_get_root_block(p_bs: *BlockFile) *camel.Block;
    pub const getRootBlock = camel_block_file_get_root_block;

    /// Allocate a new block, return a pointer to it.  Old blocks
    /// may be flushed to disk during this call.
    extern fn camel_block_file_new_block(p_bs: *BlockFile) ?*camel.Block;
    pub const newBlock = camel_block_file_new_block;

    /// Renames existing block file to a new `path`.
    extern fn camel_block_file_rename(p_bs: *BlockFile, p_path: [*:0]const u8) c_int;
    pub const rename = camel_block_file_rename;

    /// Sets a new block cache limit for `bs`.
    extern fn camel_block_file_set_cache_limit(p_bs: *BlockFile, p_block_cache_limit: c_int) void;
    pub const setCacheLimit = camel_block_file_set_cache_limit;

    /// Sync all dirty blocks to disk, including the root block.
    extern fn camel_block_file_sync(p_bs: *BlockFile) c_int;
    pub const sync = camel_block_file_sync;

    /// Flush a block to disk immediately.  The block will only
    /// be flushed to disk if it is marked as dirty (touched).
    extern fn camel_block_file_sync_block(p_bs: *BlockFile, p_bl: *camel.Block) c_int;
    pub const syncBlock = camel_block_file_sync_block;

    /// Mark a block as dirty.  The block will be written to disk if
    /// it ever expires from the cache.
    extern fn camel_block_file_touch_block(p_bs: *BlockFile, p_bl: *camel.Block) void;
    pub const touchBlock = camel_block_file_touch_block;

    /// Mark a block as unused.  If a block is used it will not be
    /// written to disk, or flushed from memory.
    ///
    /// If a block is detatched and this is the last reference, the
    /// block will be freed.
    extern fn camel_block_file_unref_block(p_bs: *BlockFile, p_bl: *camel.Block) void;
    pub const unrefBlock = camel_block_file_unref_block;

    extern fn camel_block_file_get_type() usize;
    pub const getGObjectType = camel_block_file_get_type;

    extern fn g_object_ref(p_self: *camel.BlockFile) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.BlockFile) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BlockFile, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertDB = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.CertDBClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.CertDBPrivate,

    pub const virtual_methods = struct {
        pub const cert_load = struct {
            pub fn call(p_class: anytype, p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_istream: ?*anyopaque) *camel.Cert {
                return gobject.ext.as(CertDB.Class, p_class).f_cert_load.?(gobject.ext.as(CertDB, p_certdb), p_istream);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_istream: ?*anyopaque) callconv(.c) *camel.Cert) void {
                gobject.ext.as(CertDB.Class, p_class).f_cert_load = @ptrCast(p_implementation);
            }
        };

        pub const cert_save = struct {
            pub fn call(p_class: anytype, p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cert: *camel.Cert, p_ostream: ?*anyopaque) c_int {
                return gobject.ext.as(CertDB.Class, p_class).f_cert_save.?(gobject.ext.as(CertDB, p_certdb), p_cert, p_ostream);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cert: *camel.Cert, p_ostream: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(CertDB.Class, p_class).f_cert_save = @ptrCast(p_implementation);
            }
        };

        pub const header_load = struct {
            pub fn call(p_class: anytype, p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_istream: ?*anyopaque) c_int {
                return gobject.ext.as(CertDB.Class, p_class).f_header_load.?(gobject.ext.as(CertDB, p_certdb), p_istream);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_istream: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(CertDB.Class, p_class).f_header_load = @ptrCast(p_implementation);
            }
        };

        pub const header_save = struct {
            pub fn call(p_class: anytype, p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ostream: ?*anyopaque) c_int {
                return gobject.ext.as(CertDB.Class, p_class).f_header_save.?(gobject.ext.as(CertDB, p_certdb), p_ostream);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_certdb: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ostream: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(CertDB.Class, p_class).f_header_save = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// FIXME Document me!
    extern fn camel_certdb_get_default() *camel.CertDB;
    pub const getDefault = camel_certdb_get_default;

    extern fn camel_certdb_new() *camel.CertDB;
    pub const new = camel_certdb_new;

    extern fn camel_certdb_clear(p_certdb: *CertDB) void;
    pub const clear = camel_certdb_clear;

    extern fn camel_certdb_get_host(p_certdb: *CertDB, p_hostname: [*:0]const u8, p_fingerprint: [*:0]const u8) ?*camel.Cert;
    pub const getHost = camel_certdb_get_host;

    /// Gathers a list of known certificates. Each certificate in the returned `glib.SList`
    /// is referenced, thus unref it with `camel.Cert.unref` when done with it, the same
    /// as free the list itself.
    extern fn camel_certdb_list_certs(p_certdb: *CertDB) *glib.SList;
    pub const listCerts = camel_certdb_list_certs;

    extern fn camel_certdb_load(p_certdb: *CertDB) c_int;
    pub const load = camel_certdb_load;

    /// Puts a certificate to the database. In case there exists a certificate
    /// with the same hostname and fingerprint, then it is replaced. This adds
    /// its own reference on the `cert`.
    extern fn camel_certdb_put(p_certdb: *CertDB, p_cert: *camel.Cert) void;
    pub const put = camel_certdb_put;

    /// Removes a certificate identified by the `hostname` and `fingerprint`.
    extern fn camel_certdb_remove_host(p_certdb: *CertDB, p_hostname: [*:0]const u8, p_fingerprint: [*:0]const u8) void;
    pub const removeHost = camel_certdb_remove_host;

    extern fn camel_certdb_save(p_certdb: *CertDB) c_int;
    pub const save = camel_certdb_save;

    extern fn camel_certdb_set_default(p_certdb: *CertDB) void;
    pub const setDefault = camel_certdb_set_default;

    extern fn camel_certdb_set_filename(p_certdb: *CertDB, p_filename: [*:0]const u8) void;
    pub const setFilename = camel_certdb_set_filename;

    extern fn camel_certdb_touch(p_certdb: *CertDB) void;
    pub const touch = camel_certdb_touch;

    extern fn camel_certdb_get_type() usize;
    pub const getGObjectType = camel_certdb_get_type;

    extern fn g_object_ref(p_self: *camel.CertDB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.CertDB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CertDB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherContext = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.CipherContextClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.CipherContextPrivate,

    pub const virtual_methods = struct {
        /// Decrypts `ipart` into `opart`.
        pub const decrypt_sync = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.CipherValidity {
                return gobject.ext.as(CipherContext.Class, p_class).f_decrypt_sync.?(gobject.ext.as(CipherContext, p_context), p_ipart, p_opart, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.CipherValidity) void {
                gobject.ext.as(CipherContext.Class, p_class).f_decrypt_sync = @ptrCast(p_implementation);
            }
        };

        /// Encrypts the clear-text `ipart` and writes the resulting cipher-text to `opart`.
        ///
        /// Note: The `userid` is unused, `NULL` should be passed for it.
        pub const encrypt_sync = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_userid: ?[*:0]const u8, p_recipients: *glib.PtrArray, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CipherContext.Class, p_class).f_encrypt_sync.?(gobject.ext.as(CipherContext, p_context), p_userid, p_recipients, p_ipart, p_opart, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_userid: ?[*:0]const u8, p_recipients: *glib.PtrArray, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CipherContext.Class, p_class).f_encrypt_sync = @ptrCast(p_implementation);
            }
        };

        pub const hash_to_id = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_hash: camel.CipherHash) [*:0]const u8 {
                return gobject.ext.as(CipherContext.Class, p_class).f_hash_to_id.?(gobject.ext.as(CipherContext, p_context), p_hash);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_hash: camel.CipherHash) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(CipherContext.Class, p_class).f_hash_to_id = @ptrCast(p_implementation);
            }
        };

        pub const id_to_hash = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: [*:0]const u8) camel.CipherHash {
                return gobject.ext.as(CipherContext.Class, p_class).f_id_to_hash.?(gobject.ext.as(CipherContext, p_context), p_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: [*:0]const u8) callconv(.c) camel.CipherHash) void {
                gobject.ext.as(CipherContext.Class, p_class).f_id_to_hash = @ptrCast(p_implementation);
            }
        };

        /// Converts the (unsigned) part `ipart` into a new self-contained MIME
        /// part `opart`.  This may be a multipart/signed part, or a simple part
        /// for enveloped types.
        pub const sign_sync = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_userid: [*:0]const u8, p_hash: camel.CipherHash, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CipherContext.Class, p_class).f_sign_sync.?(gobject.ext.as(CipherContext, p_context), p_userid, p_hash, p_ipart, p_opart, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_userid: [*:0]const u8, p_hash: camel.CipherHash, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CipherContext.Class, p_class).f_sign_sync = @ptrCast(p_implementation);
            }
        };

        /// Verifies the signature.
        pub const verify_sync = struct {
            pub fn call(p_class: anytype, p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ipart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.CipherValidity {
                return gobject.ext.as(CipherContext.Class, p_class).f_verify_sync.?(gobject.ext.as(CipherContext, p_context), p_ipart, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_context: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_ipart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.CipherValidity) void {
                gobject.ext.as(CipherContext.Class, p_class).f_verify_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const session = struct {
            pub const name = "session";

            pub const Type = ?*camel.Session;
        };
    };

    pub const signals = struct {};

    extern fn camel_cipher_context_error_quark() glib.Quark;
    pub const errorQuark = camel_cipher_context_error_quark;

    /// This creates a new CamelCipherContext object which is used to sign,
    /// verify, encrypt and decrypt streams.
    extern fn camel_cipher_context_new(p_session: ?*camel.Session) *camel.CipherContext;
    pub const new = camel_cipher_context_new;

    /// Asynchronously decrypts `ipart` into `opart`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.CipherContext.decryptFinish` to get the result of
    /// the operation.
    extern fn camel_cipher_context_decrypt(p_context: *CipherContext, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const decrypt = camel_cipher_context_decrypt;

    /// Finishes the operation started with `camel.CipherContext.decrypt`.
    extern fn camel_cipher_context_decrypt_finish(p_context: *CipherContext, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.CipherValidity;
    pub const decryptFinish = camel_cipher_context_decrypt_finish;

    /// Decrypts `ipart` into `opart`.
    extern fn camel_cipher_context_decrypt_sync(p_context: *CipherContext, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.CipherValidity;
    pub const decryptSync = camel_cipher_context_decrypt_sync;

    /// Asynchronously encrypts the clear-text `ipart` and
    /// writes the resulting cipher-text to `opart`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.CipherContext.encryptFinish` to get the result of
    /// the operation.
    ///
    /// Note: The `userid` is unused, `NULL` should be passed for it.
    extern fn camel_cipher_context_encrypt(p_context: *CipherContext, p_userid: ?[*:0]const u8, p_recipients: *glib.PtrArray, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const encrypt = camel_cipher_context_encrypt;

    /// Finishes the operation started with `camel.CipherContext.encrypt`.
    extern fn camel_cipher_context_encrypt_finish(p_context: *CipherContext, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const encryptFinish = camel_cipher_context_encrypt_finish;

    /// Encrypts the clear-text `ipart` and writes the resulting cipher-text to `opart`.
    ///
    /// Note: The `userid` is unused, `NULL` should be passed for it.
    extern fn camel_cipher_context_encrypt_sync(p_context: *CipherContext, p_userid: ?[*:0]const u8, p_recipients: *glib.PtrArray, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const encryptSync = camel_cipher_context_encrypt_sync;

    extern fn camel_cipher_context_get_session(p_context: *CipherContext) ?*camel.Session;
    pub const getSession = camel_cipher_context_get_session;

    extern fn camel_cipher_context_hash_to_id(p_context: *CipherContext, p_hash: camel.CipherHash) [*:0]const u8;
    pub const hashToId = camel_cipher_context_hash_to_id;

    extern fn camel_cipher_context_id_to_hash(p_context: *CipherContext, p_id: [*:0]const u8) camel.CipherHash;
    pub const idToHash = camel_cipher_context_id_to_hash;

    /// Asynchronously converts the (unsigned) part `ipart` into a new
    /// self-contained MIME part `opart`.  This may be a multipart/signed part,
    /// or a simple part for enveloped types.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.CipherContext.signFinish` to get the result of the operation.
    extern fn camel_cipher_context_sign(p_context: *CipherContext, p_userid: [*:0]const u8, p_hash: camel.CipherHash, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sign = camel_cipher_context_sign;

    /// Finishes the operation started with `camel.CipherContext.sign`.
    extern fn camel_cipher_context_sign_finish(p_context: *CipherContext, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const signFinish = camel_cipher_context_sign_finish;

    /// Converts the (unsigned) part `ipart` into a new self-contained MIME
    /// part `opart`.  This may be a multipart/signed part, or a simple part
    /// for enveloped types.
    extern fn camel_cipher_context_sign_sync(p_context: *CipherContext, p_userid: [*:0]const u8, p_hash: camel.CipherHash, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const signSync = camel_cipher_context_sign_sync;

    /// Asynchronously verifies the signature.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.CipherContext.verifyFinish` to get the result of
    /// the operation.
    extern fn camel_cipher_context_verify(p_context: *CipherContext, p_ipart: *camel.MimePart, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const verify = camel_cipher_context_verify;

    /// Finishes the operation started with `camel.CipherContext.verify`.
    extern fn camel_cipher_context_verify_finish(p_context: *CipherContext, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.CipherValidity;
    pub const verifyFinish = camel_cipher_context_verify_finish;

    /// Verifies the signature.
    extern fn camel_cipher_context_verify_sync(p_context: *CipherContext, p_ipart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.CipherValidity;
    pub const verifySync = camel_cipher_context_verify_sync;

    extern fn camel_cipher_context_get_type() usize;
    pub const getGObjectType = camel_cipher_context_get_type;

    extern fn g_object_ref(p_self: *camel.CipherContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.CipherContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CipherContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DB = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.DBClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.DBPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Frees the `record` and all of its associated data.
    extern fn camel_db_camel_mir_free(p_record: ?*camel.MIRecord) void;
    pub const camelMirFree = camel_db_camel_mir_free;

    extern fn camel_db_error_quark() glib.Quark;
    pub const errorQuark = camel_db_error_quark;

    /// Frees a string previosuly returned by `camel.DB.sqlizeString`.
    extern fn camel_db_free_sqlized_string(p_string: ?[*:0]u8) void;
    pub const freeSqlizedString = camel_db_free_sqlized_string;

    /// Traverses column name from index `index` into an enum
    /// `camel.DBKnownColumnNames` value.  The `col_names` contains `ncols` columns.
    /// First time this is called is created the `hash` from col_names indexes into
    /// the enum, and this is reused for every other call.  The function expects
    /// that column names are returned always in the same order.  When all rows
    /// are read the `hash` table can be freed with `glib.hashTableDestroy`.
    extern fn camel_db_get_column_ident(p_hash: **glib.HashTable, p_index: c_int, p_ncols: c_int, p_col_names: [*][*:0]u8) camel.DBKnownColumnNames;
    pub const getColumnIdent = camel_db_get_column_ident;

    extern fn camel_db_get_column_name(p_raw_name: [*:0]const u8) ?[*:0]u8;
    pub const getColumnName = camel_db_get_column_name;

    /// Instructs sqlite to release its memory, if possible. This can be avoided
    /// when CAMEL_SQLITE_FREE_CACHE environment variable is set.
    extern fn camel_db_release_cache_memory() void;
    pub const releaseCacheMemory = camel_db_release_cache_memory;

    /// Converts the `string` to be usable in the SQLite statements.
    extern fn camel_db_sqlize_string(p_string: [*:0]const u8) [*:0]u8;
    pub const sqlizeString = camel_db_sqlize_string;

    extern fn camel_db_new(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) ?*camel.DB;
    pub const new = camel_db_new;

    /// Ends an ongoing transaction by ignoring the changes.
    extern fn camel_db_abort_transaction(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const abortTransaction = camel_db_abort_transaction;

    /// Adds a statement to an ongoing transaction.
    extern fn camel_db_add_to_transaction(p_cdb: *DB, p_query: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const addToTransaction = camel_db_add_to_transaction;

    /// Begins transaction. End it with `camel.DB.endTransaction` or `camel.DB.abortTransaction`.
    extern fn camel_db_begin_transaction(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const beginTransaction = camel_db_begin_transaction;

    /// Deletes the given folder from the 'folders' table and empties
    /// its message info table.
    extern fn camel_db_clear_folder_summary(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const clearFolderSummary = camel_db_clear_folder_summary;

    /// Executes an SQLite command.
    extern fn camel_db_command(p_cdb: *DB, p_stmt: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const command = camel_db_command;

    /// Counts how many deleted messages is stored in the given table.
    extern fn camel_db_count_deleted_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countDeletedMessageInfo = camel_db_count_deleted_message_info;

    /// Counts how many junk messages is stored in the given table.
    extern fn camel_db_count_junk_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countJunkMessageInfo = camel_db_count_junk_message_info;

    extern fn camel_db_count_junk_not_deleted_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countJunkNotDeletedMessageInfo = camel_db_count_junk_not_deleted_message_info;

    /// Executes a `COUNT` query (like "SELECT COUNT(*) FROM table") and provides
    /// the result of it as an unsigned 32-bit integer.
    extern fn camel_db_count_message_info(p_cdb: *DB, p_query: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countMessageInfo = camel_db_count_message_info;

    /// Counts how many messages is stored in the given table.
    extern fn camel_db_count_total_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countTotalMessageInfo = camel_db_count_total_message_info;

    /// Counts how many unread messages is stored in the given table.
    extern fn camel_db_count_unread_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countUnreadMessageInfo = camel_db_count_unread_message_info;

    /// Counts how many visible (not deleted and not junk) messages is stored in the given table.
    extern fn camel_db_count_visible_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countVisibleMessageInfo = camel_db_count_visible_message_info;

    /// Counts how many visible (not deleted and not junk) and unread messages is stored in the given table.
    extern fn camel_db_count_visible_unread_message_info(p_cdb: *DB, p_table_name: [*:0]const u8, p_count: *u32, p_error: ?*?*glib.Error) c_int;
    pub const countVisibleUnreadMessageInfo = camel_db_count_visible_unread_message_info;

    /// Creates a 'folders' table, if it doesn't exist yet.
    extern fn camel_db_create_folders_table(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const createFoldersTable = camel_db_create_folders_table;

    /// Deletes the given folder from the 'folders' table and also drops
    /// its message info table.
    extern fn camel_db_delete_folder(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deleteFolder = camel_db_delete_folder;

    /// Deletes single mesage info in the given folder with
    /// the given UID.
    extern fn camel_db_delete_uid(p_cdb: *DB, p_folder_name: [*:0]const u8, p_uid: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deleteUid = camel_db_delete_uid;

    /// Deletes a list of message UIDs as one transaction.
    extern fn camel_db_delete_uids(p_cdb: *DB, p_folder_name: [*:0]const u8, p_uids: *const glib.List, p_error: ?*?*glib.Error) c_int;
    pub const deleteUids = camel_db_delete_uids;

    /// Ends an ongoing transaction by committing the changes.
    extern fn camel_db_end_transaction(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const endTransaction = camel_db_end_transaction;

    /// A pair function for `camel.DB.startInMemoryTransactions`,
    /// to commit the changes to `folder_name` and free the in-memory table.
    extern fn camel_db_flush_in_memory_transactions(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const flushInMemoryTransactions = camel_db_flush_in_memory_transactions;

    extern fn camel_db_get_filename(p_cdb: *DB) [*:0]const u8;
    pub const getFilename = camel_db_get_filename;

    extern fn camel_db_get_folder_deleted_uids(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const getFolderDeletedUids = camel_db_get_folder_deleted_uids;

    extern fn camel_db_get_folder_junk_uids(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const getFolderJunkUids = camel_db_get_folder_junk_uids;

    /// Fills hash with uid->GUINT_TO_POINTER (flag). Use `camel.pstringFree`
    /// to free the keys of the `hash`.
    extern fn camel_db_get_folder_uids(p_cdb: *DB, p_folder_name: [*:0]const u8, p_sort_by: ?[*:0]const u8, p_collate: ?[*:0]const u8, p_hash: *glib.HashTable, p_error: ?*?*glib.Error) c_int;
    pub const getFolderUids = camel_db_get_folder_uids;

    /// Runs a `cdb` maintenance, which includes vacuum, if necessary.
    extern fn camel_db_maybe_run_maintenance(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const maybeRunMaintenance = camel_db_maybe_run_maintenance;

    /// Prepares message info table for the given folder.
    extern fn camel_db_prepare_message_info_table(p_cdb: *DB, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const prepareMessageInfoTable = camel_db_prepare_message_info_table;

    /// reads folder information for the given folder and stores it into the `record`.
    extern fn camel_db_read_folder_info_record(p_cdb: *DB, p_folder_name: [*:0]const u8, p_record: *camel.FIRecord, p_error: ?*?*glib.Error) c_int;
    pub const readFolderInfoRecord = camel_db_read_folder_info_record;

    /// Selects single message info for the given `uid` in folder `folder_name` and calls
    /// the `callback` for it.
    extern fn camel_db_read_message_info_record_with_uid(p_cdb: *DB, p_folder_name: [*:0]const u8, p_uid: [*:0]const u8, p_user_data: ?*anyopaque, p_callback: camel.DBSelectCB, p_error: ?*?*glib.Error) c_int;
    pub const readMessageInfoRecordWithUid = camel_db_read_message_info_record_with_uid;

    /// Reads all mesasge info records for the given folder and calls `callback` for them.
    extern fn camel_db_read_message_info_records(p_cdb: *DB, p_folder_name: [*:0]const u8, p_user_data: ?*anyopaque, p_callback: camel.DBSelectCB, p_error: ?*?*glib.Error) c_int;
    pub const readMessageInfoRecords = camel_db_read_message_info_records;

    /// Renames tables for the `old_folder_name` to be used with `new_folder_name`.
    extern fn camel_db_rename_folder(p_cdb: *DB, p_old_folder_name: [*:0]const u8, p_new_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const renameFolder = camel_db_rename_folder;

    /// Sets a version number for the given folder.
    extern fn camel_db_reset_folder_version(p_cdb: *DB, p_folder_name: [*:0]const u8, p_reset_version: c_int, p_error: ?*?*glib.Error) c_int;
    pub const resetFolderVersion = camel_db_reset_folder_version;

    /// Executes a SELECT staement and calls the `callback` for each selected row.
    extern fn camel_db_select(p_cdb: *DB, p_stmt: [*:0]const u8, p_callback: camel.DBSelectCB, p_user_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const select = camel_db_select;

    /// Defines a collation `collate`, which can be used in SQL (SQLite)
    /// statement as a collation function. The `func` is called when
    /// colation is used.
    extern fn camel_db_set_collate(p_cdb: *DB, p_col: [*:0]const u8, p_collate: [*:0]const u8, p_func: camel.DBCollate) c_int;
    pub const setCollate = camel_db_set_collate;

    /// Creates an in-memory table for a batch transactions. Use `camel.DB.flushInMemoryTransactions`
    /// to commit the changes and free the in-memory table.
    extern fn camel_db_start_in_memory_transactions(p_cdb: *DB, p_error: ?*?*glib.Error) c_int;
    pub const startInMemoryTransactions = camel_db_start_in_memory_transactions;

    /// Runs the list of commands as a single transaction.
    extern fn camel_db_transaction_command(p_cdb: *DB, p_qry_list: *const glib.List, p_error: ?*?*glib.Error) c_int;
    pub const transactionCommand = camel_db_transaction_command;

    /// Write the `record` to the 'folders' table.
    extern fn camel_db_write_folder_info_record(p_cdb: *DB, p_record: *camel.FIRecord, p_error: ?*?*glib.Error) c_int;
    pub const writeFolderInfoRecord = camel_db_write_folder_info_record;

    /// Write the `record` to the message info table of the given folder.
    extern fn camel_db_write_message_info_record(p_cdb: *DB, p_folder_name: [*:0]const u8, p_record: *camel.MIRecord, p_error: ?*?*glib.Error) c_int;
    pub const writeMessageInfoRecord = camel_db_write_message_info_record;

    extern fn camel_db_get_type() usize;
    pub const getGObjectType = camel_db_get_type;

    extern fn g_object_ref(p_self: *camel.DB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.DB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCache = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.DataCacheClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.DataCachePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const expire_enabled = struct {
            pub const name = "expire-enabled";

            pub const Type = c_int;
        };

        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Create a new data cache.
    extern fn camel_data_cache_new(p_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*camel.DataCache;
    pub const new = camel_data_cache_new;

    /// Add a new item to the cache, returning a `gio.IOStream` to the new item.
    ///
    /// The key and the path combine to form a unique key used to store the item.
    ///
    /// Potentially, expiry processing will be performed while this call is
    /// executing.
    ///
    /// The returned `gio.IOStream` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_data_cache_add(p_cdc: *DataCache, p_path: [*:0]const u8, p_key: [*:0]const u8, p_error: ?*?*glib.Error) ?*gio.IOStream;
    pub const add = camel_data_cache_add;

    /// Clear cache's content in `path`.
    extern fn camel_data_cache_clear(p_cdc: *DataCache, p_path: [*:0]const u8) void;
    pub const clear = camel_data_cache_clear;

    /// Traverses the `cdc` sub-cache identified by `path` and calls `func` for each found file.
    /// If the `func` returns `TRUE`, then the file is removed, if `FALSE`, it's kept in the cache.
    extern fn camel_data_cache_foreach_remove(p_cdc: *DataCache, p_path: [*:0]const u8, p_func: camel.DataCacheRemoveFunc, p_user_data: ?*anyopaque) void;
    pub const foreachRemove = camel_data_cache_foreach_remove;

    /// Lookup an item in the cache.  If the item exists, a `gio.IOStream` is returned
    /// for the item.  The stream may be shared by multiple callers, so ensure the
    /// stream is in a valid state through external locking.
    ///
    /// The returned `gio.IOStream` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_data_cache_get(p_cdc: *DataCache, p_path: [*:0]const u8, p_key: [*:0]const u8, p_error: ?*?*glib.Error) ?*gio.IOStream;
    pub const get = camel_data_cache_get;

    /// Gets whether expire of cache data is enabled.
    ///
    /// This is a complementary property for `camel.DataCache.setExpireAge`
    /// and `camel.DataCache.setExpireAccess`, which allows to disable expiry
    /// without touching the two values. Having expire enabled, but not have set
    /// any of the two times, still behaves like not having expiry enabled.
    extern fn camel_data_cache_get_expire_enabled(p_cdc: *DataCache) c_int;
    pub const getExpireEnabled = camel_data_cache_get_expire_enabled;

    /// Lookup the filename for an item in the cache
    extern fn camel_data_cache_get_filename(p_cdc: *DataCache, p_path: [*:0]const u8, p_key: [*:0]const u8) [*:0]u8;
    pub const getFilename = camel_data_cache_get_filename;

    /// Returns the path to the data cache.
    extern fn camel_data_cache_get_path(p_cdc: *DataCache) [*:0]const u8;
    pub const getPath = camel_data_cache_get_path;

    /// Remove/expire a cache item.
    extern fn camel_data_cache_remove(p_cdc: *DataCache, p_path: [*:0]const u8, p_key: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const remove = camel_data_cache_remove;

    /// Set the cache expiration policy for access times.
    ///
    /// Items in the cache which haven't been accessed for `when`
    /// seconds may be expired at any time.  Items are expired in a lazy
    /// manner, so it is indeterminate when the items will
    /// physically be removed.
    ///
    /// Note you can set both an age and an access limit.  The
    /// age acts as a hard limit on cache entries.
    extern fn camel_data_cache_set_expire_access(p_cdc: *DataCache, p_when: std.posix.time_t) void;
    pub const setExpireAccess = camel_data_cache_set_expire_access;

    /// Set the cache expiration policy for aged entries.
    ///
    /// Items in the cache older than `when` seconds may be
    /// flushed at any time.  Items are expired in a lazy
    /// manner, so it is indeterminate when the items will
    /// physically be removed.
    ///
    /// Note you can set both an age and an access limit.  The
    /// age acts as a hard limit on cache entries.
    extern fn camel_data_cache_set_expire_age(p_cdc: *DataCache, p_when: std.posix.time_t) void;
    pub const setExpireAge = camel_data_cache_set_expire_age;

    /// Sets whether expire of cache data is enabled.
    ///
    /// This is a complementary property for `camel.DataCache.setExpireAge`
    /// and `camel.DataCache.setExpireAccess`, which allows to disable expiry
    /// without touching the two values. Having expire enabled, but not have set
    /// any of the two times, still behaves like not having expiry enabled.
    extern fn camel_data_cache_set_expire_enabled(p_cdc: *DataCache, p_expire_enabled: c_int) void;
    pub const setExpireEnabled = camel_data_cache_set_expire_enabled;

    /// Sets the path to the data cache.
    extern fn camel_data_cache_set_path(p_cdc: *DataCache, p_path: [*:0]const u8) void;
    pub const setPath = camel_data_cache_set_path;

    extern fn camel_data_cache_get_type() usize;
    pub const getGObjectType = camel_data_cache_get_type;

    extern fn g_object_ref(p_self: *camel.DataCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.DataCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataWrapper = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.DataWrapperClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.DataWrapperPrivate,

    pub const virtual_methods = struct {
        /// Constructs the content of `data_wrapper` from `input_stream`.
        pub const construct_from_input_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_input_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataWrapper.Class, p_class).f_construct_from_input_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_input_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_input_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_construct_from_input_stream_sync = @ptrCast(p_implementation);
            }
        };

        /// Constructs the content of `data_wrapper` from the given `stream`.
        pub const construct_from_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataWrapper.Class, p_class).f_construct_from_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_construct_from_stream_sync = @ptrCast(p_implementation);
            }
        };

        /// Writes the decoded data content to `output_stream`.
        ///
        /// <note>
        ///   <para>
        ///     This function may block even if the given output stream does not.
        ///     For example, the content may have to be fetched across a network
        ///     before it can be written to `output_stream`.
        ///   </para>
        /// </note>
        pub const decode_to_output_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(DataWrapper.Class, p_class).f_decode_to_output_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_output_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_decode_to_output_stream_sync = @ptrCast(p_implementation);
            }
        };

        /// Writes the decoded data content to `stream`.
        ///
        /// <note>
        ///   <para>
        ///     This function may block even if the given output stream does not.
        ///     For example, the content may have to be fetched across a network
        ///     before it can be written to `stream`.
        ///   </para>
        /// </note>
        pub const decode_to_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(DataWrapper.Class, p_class).f_decode_to_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_decode_to_stream_sync = @ptrCast(p_implementation);
            }
        };

        pub const get_mime_type = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(DataWrapper.Class, p_class).f_get_mime_type.?(gobject.ext.as(DataWrapper, p_data_wrapper));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_get_mime_type = @ptrCast(p_implementation);
            }
        };

        pub const get_mime_type_field = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*camel.ContentType {
                return gobject.ext.as(DataWrapper.Class, p_class).f_get_mime_type_field.?(gobject.ext.as(DataWrapper, p_data_wrapper));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*camel.ContentType) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_get_mime_type_field = @ptrCast(p_implementation);
            }
        };

        pub const is_offline = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(DataWrapper.Class, p_class).f_is_offline.?(gobject.ext.as(DataWrapper, p_data_wrapper));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_is_offline = @ptrCast(p_implementation);
            }
        };

        /// This sets the data wrapper's MIME type.
        ///
        /// It might fail, but you won't know. It will allow you to set
        /// Content-Type parameters on the data wrapper, which are meaningless.
        /// You should not be allowed to change the MIME type of a data wrapper
        /// that contains data, or at least, if you do, it should invalidate the
        /// data.
        pub const set_mime_type = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) void {
                return gobject.ext.as(DataWrapper.Class, p_class).f_set_mime_type.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_mime_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_set_mime_type = @ptrCast(p_implementation);
            }
        };

        /// This sets the data wrapper's MIME type. It adds its own reference
        /// to `mime_type`, if not `NULL`.
        ///
        /// It suffers from the same flaws as `camel.DataWrapper.setMimeType`.
        pub const set_mime_type_field = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: ?*camel.ContentType) void {
                return gobject.ext.as(DataWrapper.Class, p_class).f_set_mime_type_field.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_mime_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: ?*camel.ContentType) callconv(.c) void) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_set_mime_type_field = @ptrCast(p_implementation);
            }
        };

        /// Writes the content of `data_wrapper` to `output_stream` in a
        /// machine-independent format appropriate for the data.
        ///
        /// <note>
        ///   <para>
        ///     This function may block even if the given output stream does not.
        ///     For example, the content may have to be fetched across a network
        ///     before it can be written to `output_stream`.
        ///   </para>
        /// </note>
        pub const write_to_output_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(DataWrapper.Class, p_class).f_write_to_output_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_output_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_write_to_output_stream_sync = @ptrCast(p_implementation);
            }
        };

        /// Writes the content of `data_wrapper` to `stream` in a machine-independent
        /// format appropriate for the data.  It should be possible to construct an
        /// equivalent data wrapper object later by passing this stream to
        /// `camel.DataWrapper.constructFromStreamSync`.
        ///
        /// <note>
        ///   <para>
        ///     This function may block even if the given output stream does not.
        ///     For example, the content may have to be fetched across a network
        ///     before it can be written to `stream`.
        ///   </para>
        /// </note>
        pub const write_to_stream_sync = struct {
            pub fn call(p_class: anytype, p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(DataWrapper.Class, p_class).f_write_to_stream_sync.?(gobject.ext.as(DataWrapper, p_data_wrapper), p_stream, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_wrapper: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(DataWrapper.Class, p_class).f_write_to_stream_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.DataWrapper` object.
    extern fn camel_data_wrapper_new() *camel.DataWrapper;
    pub const new = camel_data_wrapper_new;

    /// Calculates decoded size of the `data_wrapper` by saving it to a null-stream
    /// and returns how many bytes had been written. It's using
    /// `camel.DataWrapper.decodeToStreamSync` internally.
    extern fn camel_data_wrapper_calculate_decoded_size_sync(p_data_wrapper: *DataWrapper, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) usize;
    pub const calculateDecodedSizeSync = camel_data_wrapper_calculate_decoded_size_sync;

    /// Calculates size of the `data_wrapper` by saving it to a null-stream
    /// and returns how many bytes had been written. It's using
    /// `camel.DataWrapper.writeToStreamSync` internally.
    extern fn camel_data_wrapper_calculate_size_sync(p_data_wrapper: *DataWrapper, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) usize;
    pub const calculateSizeSync = camel_data_wrapper_calculate_size_sync;

    /// Constructs the content of `data_wrapper` from `data` of length `data_len`.
    extern fn camel_data_wrapper_construct_from_data_sync(p_data_wrapper: *DataWrapper, p_data: *const anyopaque, p_data_len: isize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const constructFromDataSync = camel_data_wrapper_construct_from_data_sync;

    /// Asynchronously constructs the content of `data_wrapper` from `input_stream`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.constructFromInputStreamFinish` to get the
    /// result of the operation.
    extern fn camel_data_wrapper_construct_from_input_stream(p_data_wrapper: *DataWrapper, p_input_stream: *gio.InputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const constructFromInputStream = camel_data_wrapper_construct_from_input_stream;

    /// Finishes the operation started with
    /// `camel.DataWrapper.constructFromInputStream`.
    extern fn camel_data_wrapper_construct_from_input_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const constructFromInputStreamFinish = camel_data_wrapper_construct_from_input_stream_finish;

    /// Constructs the content of `data_wrapper` from `input_stream`.
    extern fn camel_data_wrapper_construct_from_input_stream_sync(p_data_wrapper: *DataWrapper, p_input_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const constructFromInputStreamSync = camel_data_wrapper_construct_from_input_stream_sync;

    /// Asynchronously constructs the content of `data_wrapper` from the given
    /// `stream`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.constructFromStreamFinish` to get the result
    /// of the operation.
    extern fn camel_data_wrapper_construct_from_stream(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const constructFromStream = camel_data_wrapper_construct_from_stream;

    /// Finishes the operation started with
    /// `camel.DataWrapper.constructFromStream`.
    extern fn camel_data_wrapper_construct_from_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const constructFromStreamFinish = camel_data_wrapper_construct_from_stream_finish;

    /// Constructs the content of `data_wrapper` from the given `stream`.
    extern fn camel_data_wrapper_construct_from_stream_sync(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const constructFromStreamSync = camel_data_wrapper_construct_from_stream_sync;

    /// Asynchronously writes the decoded data content to `output_stream`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.decodeToOutputStreamFinish` to get the result
    /// of the operation.
    extern fn camel_data_wrapper_decode_to_output_stream(p_data_wrapper: *DataWrapper, p_output_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const decodeToOutputStream = camel_data_wrapper_decode_to_output_stream;

    /// Finishes the operation started with
    /// `camel.DataWrapper.decodeToOutputStream`.
    extern fn camel_data_wrapper_decode_to_output_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) isize;
    pub const decodeToOutputStreamFinish = camel_data_wrapper_decode_to_output_stream_finish;

    /// Writes the decoded data content to `output_stream`.
    ///
    /// <note>
    ///   <para>
    ///     This function may block even if the given output stream does not.
    ///     For example, the content may have to be fetched across a network
    ///     before it can be written to `output_stream`.
    ///   </para>
    /// </note>
    extern fn camel_data_wrapper_decode_to_output_stream_sync(p_data_wrapper: *DataWrapper, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const decodeToOutputStreamSync = camel_data_wrapper_decode_to_output_stream_sync;

    /// Asynchronously writes the decoded data content to `stream`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.decodeToStreamFinish` to get the result of
    /// the operation.
    extern fn camel_data_wrapper_decode_to_stream(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const decodeToStream = camel_data_wrapper_decode_to_stream;

    /// Finishes the operation started with `camel.DataWrapper.decodeToStream`.
    extern fn camel_data_wrapper_decode_to_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) isize;
    pub const decodeToStreamFinish = camel_data_wrapper_decode_to_stream_finish;

    /// Writes the decoded data content to `stream`.
    ///
    /// <note>
    ///   <para>
    ///     This function may block even if the given output stream does not.
    ///     For example, the content may have to be fetched across a network
    ///     before it can be written to `stream`.
    ///   </para>
    /// </note>
    extern fn camel_data_wrapper_decode_to_stream_sync(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const decodeToStreamSync = camel_data_wrapper_decode_to_stream_sync;

    /// Returns the `glib.ByteArray` being used to hold the contents of `data_wrapper`.
    ///
    /// Note, it's up to the caller to use this in a thread-safe manner.
    extern fn camel_data_wrapper_get_byte_array(p_data_wrapper: *DataWrapper) *glib.ByteArray;
    pub const getByteArray = camel_data_wrapper_get_byte_array;

    extern fn camel_data_wrapper_get_encoding(p_data_wrapper: *DataWrapper) camel.TransferEncoding;
    pub const getEncoding = camel_data_wrapper_get_encoding;

    extern fn camel_data_wrapper_get_mime_type(p_data_wrapper: *DataWrapper) [*:0]u8;
    pub const getMimeType = camel_data_wrapper_get_mime_type;

    extern fn camel_data_wrapper_get_mime_type_field(p_data_wrapper: *DataWrapper) ?*camel.ContentType;
    pub const getMimeTypeField = camel_data_wrapper_get_mime_type_field;

    extern fn camel_data_wrapper_is_offline(p_data_wrapper: *DataWrapper) c_int;
    pub const isOffline = camel_data_wrapper_is_offline;

    /// Sets encoding (`camel.TransferEncoding`) for the `data_wrapper`.
    /// It doesn't re-encode the content, if the encoding changes.
    extern fn camel_data_wrapper_set_encoding(p_data_wrapper: *DataWrapper, p_encoding: camel.TransferEncoding) void;
    pub const setEncoding = camel_data_wrapper_set_encoding;

    /// This sets the data wrapper's MIME type.
    ///
    /// It might fail, but you won't know. It will allow you to set
    /// Content-Type parameters on the data wrapper, which are meaningless.
    /// You should not be allowed to change the MIME type of a data wrapper
    /// that contains data, or at least, if you do, it should invalidate the
    /// data.
    extern fn camel_data_wrapper_set_mime_type(p_data_wrapper: *DataWrapper, p_mime_type: [*:0]const u8) void;
    pub const setMimeType = camel_data_wrapper_set_mime_type;

    /// This sets the data wrapper's MIME type. It adds its own reference
    /// to `mime_type`, if not `NULL`.
    ///
    /// It suffers from the same flaws as `camel.DataWrapper.setMimeType`.
    extern fn camel_data_wrapper_set_mime_type_field(p_data_wrapper: *DataWrapper, p_mime_type: ?*camel.ContentType) void;
    pub const setMimeTypeField = camel_data_wrapper_set_mime_type_field;

    /// Sets whether the `data_wrapper` is "offline". It applies only to this
    /// concrete instance. See `camel.DataWrapper.isOffline`.
    extern fn camel_data_wrapper_set_offline(p_data_wrapper: *DataWrapper, p_offline: c_int) void;
    pub const setOffline = camel_data_wrapper_set_offline;

    /// Sets mime-type filed to be `mime_type` and consumes it, aka unlike
    /// `camel.DataWrapper.setMimeTypeField`, this doesn't add its own
    /// reference to `mime_type`.
    ///
    /// It suffers from the same flaws as `camel.DataWrapper.setMimeType`.
    extern fn camel_data_wrapper_take_mime_type_field(p_data_wrapper: *DataWrapper, p_mime_type: ?*camel.ContentType) void;
    pub const takeMimeTypeField = camel_data_wrapper_take_mime_type_field;

    /// Asynchronously writes the content of `data_wrapper` to `output_stream` in
    /// a machine-independent format appropriate for the data.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.writeToOutputStreamFinish` to get the result
    /// of the operation.
    extern fn camel_data_wrapper_write_to_output_stream(p_data_wrapper: *DataWrapper, p_output_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const writeToOutputStream = camel_data_wrapper_write_to_output_stream;

    /// Finishes the operation started with
    /// `camel.DataWrapper.writeToOutputStream`.
    extern fn camel_data_wrapper_write_to_output_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) isize;
    pub const writeToOutputStreamFinish = camel_data_wrapper_write_to_output_stream_finish;

    /// Writes the content of `data_wrapper` to `output_stream` in a
    /// machine-independent format appropriate for the data.
    ///
    /// <note>
    ///   <para>
    ///     This function may block even if the given output stream does not.
    ///     For example, the content may have to be fetched across a network
    ///     before it can be written to `output_stream`.
    ///   </para>
    /// </note>
    extern fn camel_data_wrapper_write_to_output_stream_sync(p_data_wrapper: *DataWrapper, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const writeToOutputStreamSync = camel_data_wrapper_write_to_output_stream_sync;

    /// Asynchronously writes the content of `data_wrapper` to `stream` in a
    /// machine-independent format appropriate for the data.  It should be
    /// possible to construct an equivalent data wrapper object later by
    /// passing this stream to `camel.DataWrapper.constructFromStream`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.DataWrapper.writeToStreamFinish` to get the result of
    /// the operation.
    extern fn camel_data_wrapper_write_to_stream(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const writeToStream = camel_data_wrapper_write_to_stream;

    /// Finishes the operation started with `camel.DataWrapper.writeToStream`.
    extern fn camel_data_wrapper_write_to_stream_finish(p_data_wrapper: *DataWrapper, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) isize;
    pub const writeToStreamFinish = camel_data_wrapper_write_to_stream_finish;

    /// Writes the content of `data_wrapper` to `stream` in a machine-independent
    /// format appropriate for the data.  It should be possible to construct an
    /// equivalent data wrapper object later by passing this stream to
    /// `camel.DataWrapper.constructFromStreamSync`.
    ///
    /// <note>
    ///   <para>
    ///     This function may block even if the given output stream does not.
    ///     For example, the content may have to be fetched across a network
    ///     before it can be written to `stream`.
    ///   </para>
    /// </note>
    extern fn camel_data_wrapper_write_to_stream_sync(p_data_wrapper: *DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const writeToStreamSync = camel_data_wrapper_write_to_stream_sync;

    extern fn camel_data_wrapper_get_type() usize;
    pub const getGObjectType = camel_data_wrapper_get_type;

    extern fn g_object_ref(p_self: *camel.DataWrapper) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.DataWrapper) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataWrapper, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterDriver = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.FilterDriverClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.FilterDriverPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_filter_driver_new(p_session: *camel.Session) *camel.FilterDriver;
    pub const new = camel_filter_driver_new;

    /// Adds a new rule to set of rules to process by the filter driver.
    extern fn camel_filter_driver_add_rule(p_d: *FilterDriver, p_name: [*:0]const u8, p_match: [*:0]const u8, p_action: [*:0]const u8) void;
    pub const addRule = camel_filter_driver_add_rule;

    /// Filters a folder based on rules defined in the FilterDriver
    /// object.
    extern fn camel_filter_driver_filter_folder(p_driver: *FilterDriver, p_folder: *camel.Folder, p_cache: *camel.UIDCache, p_uids: ?*glib.PtrArray, p_remove: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const filterFolder = camel_filter_driver_filter_folder;

    /// Filters an mbox file based on rules defined in the FilterDriver
    /// object. Is more efficient as it doesn't need to open the folder
    /// through Camel directly.
    extern fn camel_filter_driver_filter_mbox(p_driver: *FilterDriver, p_mbox: [*:0]const u8, p_original_source_url: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const filterMbox = camel_filter_driver_filter_mbox;

    /// Filters a message based on rules defined in the FilterDriver
    /// object. If the source folder (`source`) and the uid (`uid`) are
    /// provided, the filter will operate on the CamelFolder (which in
    /// certain cases is more efficient than using the default
    /// `camel.Folder.appendMessage` function).
    extern fn camel_filter_driver_filter_message(p_driver: *FilterDriver, p_message: ?*camel.MimeMessage, p_info: ?*camel.MessageInfo, p_uid: ?[*:0]const u8, p_source: ?*camel.Folder, p_store_uid: ?[*:0]const u8, p_original_store_uid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const filterMessage = camel_filter_driver_filter_message;

    /// Flush all of the only-once filter actions.
    extern fn camel_filter_driver_flush(p_driver: *FilterDriver, p_error: ?*?*glib.Error) void;
    pub const flush = camel_filter_driver_flush;

    /// Logs an informational message to a filter log. The function does
    /// nothing when `driver` is `NULL` or when there is no log file being
    /// set in `driver`.
    extern fn camel_filter_driver_log_info(p_driver: ?*FilterDriver, p_format: [*:0]const u8, ...) void;
    pub const logInfo = camel_filter_driver_log_info;

    /// Removes a rule by name, added by `camel.FilterDriver.addRule`.
    extern fn camel_filter_driver_remove_rule_by_name(p_d: *FilterDriver, p_name: [*:0]const u8) c_int;
    pub const removeRuleByName = camel_filter_driver_remove_rule_by_name;

    /// Sets a default folder for the driver. The function adds
    /// its own reference for the folder.
    extern fn camel_filter_driver_set_default_folder(p_d: *FilterDriver, p_def: ?*camel.Folder) void;
    pub const setDefaultFolder = camel_filter_driver_set_default_folder;

    /// Sets a callback (of type `camel.FilterGetFolderFunc`) to get a folder.
    extern fn camel_filter_driver_set_folder_func(p_d: *FilterDriver, p_get_folder: camel.FilterGetFolderFunc, p_user_data: ?*anyopaque) void;
    pub const setFolderFunc = camel_filter_driver_set_folder_func;

    /// Sets a log file to use for logging.
    extern fn camel_filter_driver_set_logfile(p_d: *FilterDriver, p_logfile: ?*anyopaque) void;
    pub const setLogfile = camel_filter_driver_set_logfile;

    /// Sets a callback to call when a play of a sound is requested.
    extern fn camel_filter_driver_set_play_sound_func(p_d: *FilterDriver, p_func: camel.FilterPlaySoundFunc, p_user_data: ?*anyopaque) void;
    pub const setPlaySoundFunc = camel_filter_driver_set_play_sound_func;

    /// Sets a shell command callback, which is called when a shell command
    /// execution is requested.
    extern fn camel_filter_driver_set_shell_func(p_d: *FilterDriver, p_func: camel.FilterShellFunc, p_user_data: ?*anyopaque) void;
    pub const setShellFunc = camel_filter_driver_set_shell_func;

    /// Sets a status callback, which is used to report progress/status.
    extern fn camel_filter_driver_set_status_func(p_d: *FilterDriver, p_func: camel.FilterStatusFunc, p_user_data: ?*anyopaque) void;
    pub const setStatusFunc = camel_filter_driver_set_status_func;

    /// Sets a callback to use for system beep.
    extern fn camel_filter_driver_set_system_beep_func(p_d: *FilterDriver, p_func: camel.FilterSystemBeepFunc, p_user_data: ?*anyopaque) void;
    pub const setSystemBeepFunc = camel_filter_driver_set_system_beep_func;

    extern fn camel_filter_driver_get_type() usize;
    pub const getGObjectType = camel_filter_driver_get_type;

    extern fn g_object_ref(p_self: *camel.FilterDriver) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.FilterDriver) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FilterDriver, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterInputStream = extern struct {
    pub const Parent = gio.FilterInputStream;
    pub const Implements = [_]type{};
    pub const Class = camel.FilterInputStreamClass;
    f_parent: gio.FilterInputStream,
    f_priv: ?*camel.FilterInputStreamPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const filter = struct {
            pub const name = "filter";

            pub const Type = ?*camel.MimeFilter;
        };
    };

    pub const signals = struct {};

    /// Creates a new filtered input stream for the `base_stream`.
    extern fn camel_filter_input_stream_new(p_base_stream: *gio.InputStream, p_filter: *camel.MimeFilter) *camel.FilterInputStream;
    pub const new = camel_filter_input_stream_new;

    /// Gets the `camel.MimeFilter` that is used by `filter_stream`.
    extern fn camel_filter_input_stream_get_filter(p_filter_stream: *FilterInputStream) *camel.MimeFilter;
    pub const getFilter = camel_filter_input_stream_get_filter;

    extern fn camel_filter_input_stream_get_type() usize;
    pub const getGObjectType = camel_filter_input_stream_get_type;

    extern fn g_object_ref(p_self: *camel.FilterInputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.FilterInputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FilterInputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterOutputStream = extern struct {
    pub const Parent = gio.FilterOutputStream;
    pub const Implements = [_]type{};
    pub const Class = camel.FilterOutputStreamClass;
    f_parent: gio.FilterOutputStream,
    f_priv: ?*camel.FilterOutputStreamPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const filter = struct {
            pub const name = "filter";

            pub const Type = ?*camel.MimeFilter;
        };
    };

    pub const signals = struct {};

    /// Creates a new filtered output stream for the `base_stream`.
    extern fn camel_filter_output_stream_new(p_base_stream: *gio.OutputStream, p_filter: *camel.MimeFilter) *camel.FilterOutputStream;
    pub const new = camel_filter_output_stream_new;

    /// Gets the `camel.MimeFilter` that is used by `filter_stream`.
    extern fn camel_filter_output_stream_get_filter(p_filter_stream: *FilterOutputStream) *camel.MimeFilter;
    pub const getFilter = camel_filter_output_stream_get_filter;

    extern fn camel_filter_output_stream_get_type() usize;
    pub const getGObjectType = camel_filter_output_stream_get_type;

    extern fn g_object_ref(p_self: *camel.FilterOutputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.FilterOutputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FilterOutputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Folder = extern struct {
    pub const Parent = camel.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.FolderClass;
    f_parent: camel.Object,
    f_priv: ?*camel.FolderPrivate,

    pub const virtual_methods = struct {
        /// Appends `message` to `folder`.  Only the flag and tag data from `info`
        /// are used.  If `info` is `NULL`, no flags or tags will be set.
        pub const append_message_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_info: ?*camel.MessageInfo, p_appended_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_append_message_sync.?(gobject.ext.as(Folder, p_folder), p_message, p_info, p_appended_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_info: ?*camel.MessageInfo, p_appended_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_append_message_sync = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Folder.signals.changed` signal from an idle source on the
        /// main loop.  The idle source's priority is `G_PRIORITY_LOW`.
        pub const changed = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_changes: *camel.FolderChangeInfo) void {
                return gobject.ext.as(Folder.Class, p_class).f_changed.?(gobject.ext.as(Folder, p_folder), p_changes);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_changes: *camel.FolderChangeInfo) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        /// Compares two uids. The return value meaning is the same as in any other compare function.
        ///
        /// Note that the default compare function expects a decimal number at the beginning of a uid,
        /// thus if provider uses different uid values, then it should subclass this function.
        pub const cmp_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid1: [*:0]const u8, p_uid2: [*:0]const u8) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_cmp_uids.?(gobject.ext.as(Folder, p_folder), p_uid1, p_uid2);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid1: [*:0]const u8, p_uid2: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_cmp_uids = @ptrCast(p_implementation);
            }
        };

        /// Searches the folder for count of messages matching the given search expression.
        pub const count_by_expression = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) u32 {
                return gobject.ext.as(Folder.Class, p_class).f_count_by_expression.?(gobject.ext.as(Folder, p_folder), p_expression, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) u32) void {
                gobject.ext.as(Folder.Class, p_class).f_count_by_expression = @ptrCast(p_implementation);
            }
        };

        pub const delete_ = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Folder.Class, p_class).f_delete_.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_delete_ = @ptrCast(p_implementation);
            }
        };

        pub const deleted = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Folder.Class, p_class).f_deleted.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_deleted = @ptrCast(p_implementation);
            }
        };

        /// Deletes messages which have been marked as "DELETED".
        pub const expunge_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_expunge_sync.?(gobject.ext.as(Folder, p_folder), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_expunge_sync = @ptrCast(p_implementation);
            }
        };

        /// Frees the summary array returned by `camel.Folder.getSummary`.
        pub const free_summary = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *glib.PtrArray) void {
                return gobject.ext.as(Folder.Class, p_class).f_free_summary.?(gobject.ext.as(Folder, p_folder), p_array);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *glib.PtrArray) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_free_summary = @ptrCast(p_implementation);
            }
        };

        /// Frees the array of UIDs returned by `camel.Folder.getUids`.
        pub const free_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *glib.PtrArray) void {
                return gobject.ext.as(Folder.Class, p_class).f_free_uids.?(gobject.ext.as(Folder, p_folder), p_array);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *glib.PtrArray) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_free_uids = @ptrCast(p_implementation);
            }
        };

        /// Freezes the folder so that a series of operation can be performed
        /// without "folder_changed" signals being emitted.  When the folder is
        /// later thawed with `camel.Folder.thaw`, the suppressed signals will
        /// be emitted.
        pub const freeze = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Folder.Class, p_class).f_freeze.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_freeze = @ptrCast(p_implementation);
            }
        };

        pub const get_filename = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8 {
                return gobject.ext.as(Folder.Class, p_class).f_get_filename.?(gobject.ext.as(Folder, p_folder), p_uid, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(Folder.Class, p_class).f_get_filename = @ptrCast(p_implementation);
            }
        };

        /// Similar to the `camel.Folder.getFullName`, only returning
        /// full path to the `folder` suitable for the display to a user.
        pub const get_full_display_name = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Folder.Class, p_class).f_get_full_display_name.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Folder.Class, p_class).f_get_full_display_name = @ptrCast(p_implementation);
            }
        };

        /// Gets the message corresponding to `message_uid` from the `folder` cache,
        /// if available locally. This should not do any network I/O, only check
        /// if message is already downloaded and return it quickly, not being
        /// blocked by the folder's lock. Returning NULL is not considered as
        /// an error, it just means that the message is still to-be-downloaded.
        ///
        /// Note: This function is called automatically within `camel.Folder.getMessageSync`.
        pub const get_message_cached = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable) ?*camel.MimeMessage {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_cached.?(gobject.ext.as(Folder, p_folder), p_message_uid, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable) callconv(.c) ?*camel.MimeMessage) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_cached = @ptrCast(p_implementation);
            }
        };

        pub const get_message_count = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_count.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_count = @ptrCast(p_implementation);
            }
        };

        pub const get_message_flags = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) u32 {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_flags.?(gobject.ext.as(Folder, p_folder), p_uid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) callconv(.c) u32) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_flags = @ptrCast(p_implementation);
            }
        };

        /// Retrieve the `camel.MessageInfo` for the specified `uid`.
        pub const get_message_info = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) ?*camel.MessageInfo {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_info.?(gobject.ext.as(Folder, p_folder), p_uid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) callconv(.c) ?*camel.MessageInfo) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_info = @ptrCast(p_implementation);
            }
        };

        /// Gets the message corresponding to `message_uid` from `folder`.
        pub const get_message_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.MimeMessage {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_sync.?(gobject.ext.as(Folder, p_folder), p_message_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.MimeMessage) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_sync = @ptrCast(p_implementation);
            }
        };

        pub const get_message_user_flag = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_user_flag.?(gobject.ext.as(Folder, p_folder), p_uid, p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_user_flag = @ptrCast(p_implementation);
            }
        };

        pub const get_message_user_tag = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8) [*:0]const u8 {
                return gobject.ext.as(Folder.Class, p_class).f_get_message_user_tag.?(gobject.ext.as(Folder, p_folder), p_uid, p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Folder.Class, p_class).f_get_message_user_tag = @ptrCast(p_implementation);
            }
        };

        pub const get_permanent_flags = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) u32 {
                return gobject.ext.as(Folder.Class, p_class).f_get_permanent_flags.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) u32) void {
                gobject.ext.as(Folder.Class, p_class).f_get_permanent_flags = @ptrCast(p_implementation);
            }
        };

        /// Gets a list of known quotas for `folder`.  Free the returned
        /// `camel.FolderQuotaInfo` struct with `camel.FolderQuotaInfo.free`.
        ///
        /// If quotas are not supported for `folder`, the function returns `NULL`
        /// and sets `error` to `G_IO_ERROR_NOT_SUPPORTED`.
        pub const get_quota_info_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderQuotaInfo {
                return gobject.ext.as(Folder.Class, p_class).f_get_quota_info_sync.?(gobject.ext.as(Folder, p_folder), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderQuotaInfo) void {
                gobject.ext.as(Folder.Class, p_class).f_get_quota_info_sync = @ptrCast(p_implementation);
            }
        };

        /// This returns the summary information for the folder. This array
        /// should not be modified, and must be freed with
        /// `camel.Folder.freeSummary`.
        pub const get_summary = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.PtrArray {
                return gobject.ext.as(Folder.Class, p_class).f_get_summary.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(Folder.Class, p_class).f_get_summary = @ptrCast(p_implementation);
            }
        };

        /// Get the list of UIDs available in a folder. This routine is useful
        /// for finding what messages are available when the folder does not
        /// support summaries. The returned array should not be modified, and
        /// must be freed by passing it to `camel.Folder.freeUids`.
        pub const get_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.PtrArray {
                return gobject.ext.as(Folder.Class, p_class).f_get_uids.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(Folder.Class, p_class).f_get_uids = @ptrCast(p_implementation);
            }
        };

        /// Returns the known-uncached uids from a list of uids. It may return uids
        /// which are locally cached but should never filter out a uid which is not
        /// locally cached. Free the result by called `camel.Folder.freeUids`.
        /// Frees the array of UIDs returned by `camel.Folder.getUids`.
        pub const get_uncached_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *glib.PtrArray, p_error: ?*?*glib.Error) ?*glib.PtrArray {
                return gobject.ext.as(Folder.Class, p_class).f_get_uncached_uids.?(gobject.ext.as(Folder, p_folder), p_uids, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *glib.PtrArray, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray) void {
                gobject.ext.as(Folder.Class, p_class).f_get_uncached_uids = @ptrCast(p_implementation);
            }
        };

        pub const has_search_capability = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_has_search_capability.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_has_search_capability = @ptrCast(p_implementation);
            }
        };

        pub const is_frozen = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_is_frozen.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_is_frozen = @ptrCast(p_implementation);
            }
        };

        /// Lets the `folder` know that it should refresh its content
        /// the next time from fresh. This is useful for remote accounts,
        /// to fully re-check the folder content against the server.
        pub const prepare_content_refresh = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Folder.Class, p_class).f_prepare_content_refresh.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_prepare_content_refresh = @ptrCast(p_implementation);
            }
        };

        /// Delete the local cache of all messages between these uids.
        pub const purge_message_cache_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_uid: [*:0]u8, p_end_uid: [*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_purge_message_cache_sync.?(gobject.ext.as(Folder, p_folder), p_start_uid, p_end_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_uid: [*:0]u8, p_end_uid: [*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_purge_message_cache_sync = @ptrCast(p_implementation);
            }
        };

        /// Synchronizes a folder's summary with its backing store.
        pub const refresh_info_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_refresh_info_sync.?(gobject.ext.as(Folder, p_folder), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_refresh_info_sync = @ptrCast(p_implementation);
            }
        };

        /// Marks `folder` as renamed.
        ///
        /// This also emits the `camel.Folder.signals.renamed` signal from an idle source on
        /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// NOTE: This is an internal function used by camel stores, no locking
        /// is performed on the folder.
        pub const rename = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_new_name: [*:0]const u8) void {
                return gobject.ext.as(Folder.Class, p_class).f_rename.?(gobject.ext.as(Folder, p_folder), p_new_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_new_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_rename = @ptrCast(p_implementation);
            }
        };

        pub const renamed = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8) void {
                return gobject.ext.as(Folder.Class, p_class).f_renamed.?(gobject.ext.as(Folder, p_folder), p_old_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_renamed = @ptrCast(p_implementation);
            }
        };

        /// Searches the folder for messages matching the given search expression.
        pub const search_by_expression = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.PtrArray {
                return gobject.ext.as(Folder.Class, p_class).f_search_by_expression.?(gobject.ext.as(Folder, p_folder), p_expression, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray) void {
                gobject.ext.as(Folder.Class, p_class).f_search_by_expression = @ptrCast(p_implementation);
            }
        };

        /// Search a subset of uid's for an expression match.
        pub const search_by_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_uids: *glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.PtrArray {
                return gobject.ext.as(Folder.Class, p_class).f_search_by_uids.?(gobject.ext.as(Folder, p_folder), p_expression, p_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8, p_uids: *glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray) void {
                gobject.ext.as(Folder.Class, p_class).f_search_by_uids = @ptrCast(p_implementation);
            }
        };

        /// Free the result of a search as gotten by `camel.Folder.searchByExpression`
        /// or `camel.Folder.searchByUids`.
        pub const search_free = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *glib.PtrArray) void {
                return gobject.ext.as(Folder.Class, p_class).f_search_free.?(gobject.ext.as(Folder, p_folder), p_result);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *glib.PtrArray) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_search_free = @ptrCast(p_implementation);
            }
        };

        /// Sets those flags specified by `mask` to the values specified by `set`
        /// on the indicated message. (This may or may not persist after the
        /// folder or store is closed. See `camel.Folder.getPermanentFlags`)
        ///
        /// E.g. to set the deleted flag and clear the draft flag, use
        /// camel_folder_set_message_flags (folder, uid, CAMEL_MESSAGE_DELETED|CAMEL_MESSAGE_DRAFT, CAMEL_MESSAGE_DELETED);
        pub const set_message_flags = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_mask: u32, p_set: u32) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_set_message_flags.?(gobject.ext.as(Folder, p_folder), p_uid, p_mask, p_set);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_mask: u32, p_set: u32) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_set_message_flags = @ptrCast(p_implementation);
            }
        };

        pub const set_message_user_flag = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: c_int) void {
                return gobject.ext.as(Folder.Class, p_class).f_set_message_user_flag.?(gobject.ext.as(Folder, p_folder), p_uid, p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: c_int) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_set_message_user_flag = @ptrCast(p_implementation);
            }
        };

        pub const set_message_user_tag = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: [*:0]const u8) void {
                return gobject.ext.as(Folder.Class, p_class).f_set_message_user_tag.?(gobject.ext.as(Folder, p_folder), p_uid, p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_set_message_user_tag = @ptrCast(p_implementation);
            }
        };

        /// Sorts the array of UIDs.
        pub const sort_uids = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *glib.PtrArray) void {
                return gobject.ext.as(Folder.Class, p_class).f_sort_uids.?(gobject.ext.as(Folder, p_folder), p_uids);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *glib.PtrArray) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_sort_uids = @ptrCast(p_implementation);
            }
        };

        /// Ensure that a message identified by `message_uid` has been synchronized in
        /// `folder` so that calling `camel.Folder.getMessage` on it later will work
        /// in offline mode.
        pub const synchronize_message_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_synchronize_message_sync.?(gobject.ext.as(Folder, p_folder), p_message_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_synchronize_message_sync = @ptrCast(p_implementation);
            }
        };

        /// Synchronizes any changes that have been made to `folder` to its
        /// backing store, optionally expunging deleted messages as well.
        pub const synchronize_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_synchronize_sync.?(gobject.ext.as(Folder, p_folder), p_expunge, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_synchronize_sync = @ptrCast(p_implementation);
            }
        };

        /// Thaws the folder and emits any pending folder_changed
        /// signals.
        pub const thaw = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Folder.Class, p_class).f_thaw.?(gobject.ext.as(Folder, p_folder));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Folder.Class, p_class).f_thaw = @ptrCast(p_implementation);
            }
        };

        /// Copies or moves messages from one folder to another.  If the
        /// `source` and `destination` folders have the same parent_store, this
        /// may be more efficient than using `camel.Folder.appendMessageSync`.
        pub const transfer_messages_to_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uids: *glib.PtrArray, p_destination: *camel.Folder, p_delete_originals: c_int, p_transferred_uids: ?**glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Folder.Class, p_class).f_transfer_messages_to_sync.?(gobject.ext.as(Folder, p_source), p_message_uids, p_destination, p_delete_originals, p_transferred_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_uids: *glib.PtrArray, p_destination: *camel.Folder, p_delete_originals: c_int, p_transferred_uids: ?**glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Folder.Class, p_class).f_transfer_messages_to_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The folder's description.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The folder's display name.
        pub const display_name = struct {
            pub const name = "display-name";

            pub const Type = ?[*:0]u8;
        };

        /// The folder's fully qualified name.
        pub const full_name = struct {
            pub const name = "full-name";

            pub const Type = ?[*:0]u8;
        };

        /// A `camel.ThreeState` persistent option of the folder,
        /// which can override global option to mark messages
        /// as seen after certain interval.
        pub const mark_seen = struct {
            pub const name = "mark-seen";

            pub const Type = camel.ThreeState;
        };

        /// Timeout in milliseconds for marking messages as seen.
        pub const mark_seen_timeout = struct {
            pub const name = "mark-seen-timeout";

            pub const Type = c_int;
        };

        /// The `camel.Store` to which the folder belongs.
        pub const parent_store = struct {
            pub const name = "parent-store";

            pub const Type = ?*camel.Store;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_changes: *camel.FolderChangeInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Folder, p_instance))),
                    gobject.signalLookup("changed", Folder.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const deleted = struct {
            pub const name = "deleted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Folder, p_instance))),
                    gobject.signalLookup("deleted", Folder.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const renamed = struct {
            pub const name = "renamed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_old_name: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Folder, p_instance))),
                    gobject.signalLookup("renamed", Folder.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn camel_folder_threaded_messages_dump(p_c: *camel.FolderThreadNode) c_int;
    pub const threadedMessagesDump = camel_folder_threaded_messages_dump;

    /// Appends `message` to `folder` asynchronously.  Only the flag and tag data
    /// from `info` are used.  If `info` is `NULL`, no flags or tags will be set.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Folder.appendMessageFinish` to get the result of
    /// the operation.
    extern fn camel_folder_append_message(p_folder: *Folder, p_message: *camel.MimeMessage, p_info: ?*camel.MessageInfo, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const appendMessage = camel_folder_append_message;

    /// Finishes the operation started with `camel.Folder.appendMessageFinish`.
    extern fn camel_folder_append_message_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_appended_uid: ?*[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const appendMessageFinish = camel_folder_append_message_finish;

    /// Appends `message` to `folder`.  Only the flag and tag data from `info`
    /// are used.  If `info` is `NULL`, no flags or tags will be set.
    extern fn camel_folder_append_message_sync(p_folder: *Folder, p_message: *camel.MimeMessage, p_info: ?*camel.MessageInfo, p_appended_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const appendMessageSync = camel_folder_append_message_sync;

    /// Emits the `camel.Folder.signals.changed` signal from an idle source on the
    /// main loop.  The idle source's priority is `G_PRIORITY_LOW`.
    extern fn camel_folder_changed(p_folder: *Folder, p_changes: *camel.FolderChangeInfo) void;
    pub const changed = camel_folder_changed;

    /// Compares two uids. The return value meaning is the same as in any other compare function.
    ///
    /// Note that the default compare function expects a decimal number at the beginning of a uid,
    /// thus if provider uses different uid values, then it should subclass this function.
    extern fn camel_folder_cmp_uids(p_folder: *Folder, p_uid1: [*:0]const u8, p_uid2: [*:0]const u8) c_int;
    pub const cmpUids = camel_folder_cmp_uids;

    /// Searches the folder for count of messages matching the given search expression.
    extern fn camel_folder_count_by_expression(p_folder: *Folder, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) u32;
    pub const countByExpression = camel_folder_count_by_expression;

    /// Marks `folder` as deleted and performs any required cleanup.
    ///
    /// This also emits the `camel.Folder.signals.deleted` signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    extern fn camel_folder_delete(p_folder: *Folder) void;
    pub const delete = camel_folder_delete;

    /// Thread-safe variation of `camel.Folder.getDescription`.
    /// Use this function when accessing `folder` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_folder_dup_description(p_folder: *Folder) [*:0]u8;
    pub const dupDescription = camel_folder_dup_description;

    /// Thread-safe variation of `camel.Folder.getDisplayName`.
    /// Use this function when accessing `folder` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_folder_dup_display_name(p_folder: *Folder) [*:0]u8;
    pub const dupDisplayName = camel_folder_dup_display_name;

    /// Thread-safe variation of `camel.Folder.getFullName`.
    /// Use this function when accessing `folder` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_folder_dup_full_name(p_folder: *Folder) [*:0]u8;
    pub const dupFullName = camel_folder_dup_full_name;

    /// Asynchronously deletes messages which have been marked as "DELETED".
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.expungeFinish` to get the result of the operation.
    extern fn camel_folder_expunge(p_folder: *Folder, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const expunge = camel_folder_expunge;

    /// Finishes the operation started with `camel.Folder.expunge`.
    extern fn camel_folder_expunge_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const expungeFinish = camel_folder_expunge_finish;

    /// Deletes messages which have been marked as "DELETED".
    extern fn camel_folder_expunge_sync(p_folder: *Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const expungeSync = camel_folder_expunge_sync;

    /// Frees the provided array and its contents. Used by `camel.Folder`
    /// subclasses as an implementation for free_uids when the provided
    /// information was created explicitly by the corresponding get_ call.
    extern fn camel_folder_free_deep(p_folder: *Folder, p_array: *glib.PtrArray) void;
    pub const freeDeep = camel_folder_free_deep;

    /// Frees the provided array but not its contents. Used by `camel.Folder`
    /// subclasses as an implementation for free_uids or free_summary when
    /// the returned array needs to be freed but its contents come from
    /// "static" information.
    extern fn camel_folder_free_shallow(p_folder: *Folder, p_array: *glib.PtrArray) void;
    pub const freeShallow = camel_folder_free_shallow;

    /// Frees the summary array returned by `camel.Folder.getSummary`.
    extern fn camel_folder_free_summary(p_folder: *Folder, p_array: *glib.PtrArray) void;
    pub const freeSummary = camel_folder_free_summary;

    /// Frees the array of UIDs returned by `camel.Folder.getUids`.
    extern fn camel_folder_free_uids(p_folder: *Folder, p_array: *glib.PtrArray) void;
    pub const freeUids = camel_folder_free_uids;

    /// Freezes the folder so that a series of operation can be performed
    /// without "folder_changed" signals being emitted.  When the folder is
    /// later thawed with `camel.Folder.thaw`, the suppressed signals will
    /// be emitted.
    extern fn camel_folder_freeze(p_folder: *Folder) void;
    pub const freeze = camel_folder_freeze;

    extern fn camel_folder_get_deleted_message_count(p_folder: *Folder) c_int;
    pub const getDeletedMessageCount = camel_folder_get_deleted_message_count;

    /// Returns a description of the folder suitable for displaying to the user.
    extern fn camel_folder_get_description(p_folder: *Folder) [*:0]const u8;
    pub const getDescription = camel_folder_get_description;

    /// Returns the display name for the folder.  The fully qualified name
    /// can be obtained with `camel.Folder.getFullName`.
    extern fn camel_folder_get_display_name(p_folder: *Folder) [*:0]const u8;
    pub const getDisplayName = camel_folder_get_display_name;

    extern fn camel_folder_get_filename(p_folder: *Folder, p_uid: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getFilename = camel_folder_get_filename;

    extern fn camel_folder_get_flags(p_folder: *Folder) u32;
    pub const getFlags = camel_folder_get_flags;

    extern fn camel_folder_get_folder_summary(p_folder: *Folder) *camel.FolderSummary;
    pub const getFolderSummary = camel_folder_get_folder_summary;

    extern fn camel_folder_get_frozen_count(p_folder: *Folder) c_int;
    pub const getFrozenCount = camel_folder_get_frozen_count;

    /// Similar to the `camel.Folder.getFullName`, only returning
    /// full path to the `folder` suitable for the display to a user.
    extern fn camel_folder_get_full_display_name(p_folder: *Folder) [*:0]const u8;
    pub const getFullDisplayName = camel_folder_get_full_display_name;

    /// Returns the fully qualified name of the folder.
    extern fn camel_folder_get_full_name(p_folder: *Folder) [*:0]const u8;
    pub const getFullName = camel_folder_get_full_name;

    extern fn camel_folder_get_mark_seen(p_folder: *Folder) camel.ThreeState;
    pub const getMarkSeen = camel_folder_get_mark_seen;

    extern fn camel_folder_get_mark_seen_timeout(p_folder: *Folder) c_int;
    pub const getMarkSeenTimeout = camel_folder_get_mark_seen_timeout;

    /// Asynchronously gets the message corresponding to `message_uid` from `folder`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.getMessageFinish` to get the result of the operation.
    extern fn camel_folder_get_message(p_folder: *Folder, p_message_uid: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getMessage = camel_folder_get_message;

    /// Gets the message corresponding to `message_uid` from the `folder` cache,
    /// if available locally. This should not do any network I/O, only check
    /// if message is already downloaded and return it quickly, not being
    /// blocked by the folder's lock. Returning NULL is not considered as
    /// an error, it just means that the message is still to-be-downloaded.
    ///
    /// Note: This function is called automatically within `camel.Folder.getMessageSync`.
    extern fn camel_folder_get_message_cached(p_folder: *Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable) ?*camel.MimeMessage;
    pub const getMessageCached = camel_folder_get_message_cached;

    extern fn camel_folder_get_message_count(p_folder: *Folder) c_int;
    pub const getMessageCount = camel_folder_get_message_count;

    /// Finishes the operation started with `camel.Folder.getMessage`.
    extern fn camel_folder_get_message_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.MimeMessage;
    pub const getMessageFinish = camel_folder_get_message_finish;

    extern fn camel_folder_get_message_flags(p_folder: *Folder, p_uid: [*:0]const u8) u32;
    pub const getMessageFlags = camel_folder_get_message_flags;

    /// Retrieve the `camel.MessageInfo` for the specified `uid`.
    extern fn camel_folder_get_message_info(p_folder: *Folder, p_uid: [*:0]const u8) ?*camel.MessageInfo;
    pub const getMessageInfo = camel_folder_get_message_info;

    /// Gets the message corresponding to `message_uid` from `folder`.
    extern fn camel_folder_get_message_sync(p_folder: *Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.MimeMessage;
    pub const getMessageSync = camel_folder_get_message_sync;

    extern fn camel_folder_get_message_user_flag(p_folder: *Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8) c_int;
    pub const getMessageUserFlag = camel_folder_get_message_user_flag;

    extern fn camel_folder_get_message_user_tag(p_folder: *Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8) [*:0]const u8;
    pub const getMessageUserTag = camel_folder_get_message_user_tag;

    extern fn camel_folder_get_parent_store(p_folder: *Folder) ?*anyopaque;
    pub const getParentStore = camel_folder_get_parent_store;

    extern fn camel_folder_get_permanent_flags(p_folder: *Folder) u32;
    pub const getPermanentFlags = camel_folder_get_permanent_flags;

    /// Asynchronously gets a list of known quotas for `folder`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Folder.getQuotaInfoFinish` to get the result of
    /// the operation.
    extern fn camel_folder_get_quota_info(p_folder: *Folder, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getQuotaInfo = camel_folder_get_quota_info;

    /// Finishes the operation started with `camel.Folder.getQuotaInfo`.
    /// Free the returned `camel.FolderQuotaInfo` struct with
    /// `camel.FolderQuotaInfo.free`.
    ///
    /// If quotas are not supported for `folder`, the function returns `NULL`
    /// and sets `error` to `G_IO_ERROR_NOT_SUPPORTED`.
    extern fn camel_folder_get_quota_info_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.FolderQuotaInfo;
    pub const getQuotaInfoFinish = camel_folder_get_quota_info_finish;

    /// Gets a list of known quotas for `folder`.  Free the returned
    /// `camel.FolderQuotaInfo` struct with `camel.FolderQuotaInfo.free`.
    ///
    /// If quotas are not supported for `folder`, the function returns `NULL`
    /// and sets `error` to `G_IO_ERROR_NOT_SUPPORTED`.
    extern fn camel_folder_get_quota_info_sync(p_folder: *Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderQuotaInfo;
    pub const getQuotaInfoSync = camel_folder_get_quota_info_sync;

    /// This returns the summary information for the folder. This array
    /// should not be modified, and must be freed with
    /// `camel.Folder.freeSummary`.
    extern fn camel_folder_get_summary(p_folder: *Folder) *glib.PtrArray;
    pub const getSummary = camel_folder_get_summary;

    /// Get the list of UIDs available in a folder. This routine is useful
    /// for finding what messages are available when the folder does not
    /// support summaries. The returned array should not be modified, and
    /// must be freed by passing it to `camel.Folder.freeUids`.
    extern fn camel_folder_get_uids(p_folder: *Folder) *glib.PtrArray;
    pub const getUids = camel_folder_get_uids;

    /// Returns the known-uncached uids from a list of uids. It may return uids
    /// which are locally cached but should never filter out a uid which is not
    /// locally cached. Free the result by called `camel.Folder.freeUids`.
    /// Frees the array of UIDs returned by `camel.Folder.getUids`.
    extern fn camel_folder_get_uncached_uids(p_folder: *Folder, p_uids: *glib.PtrArray, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const getUncachedUids = camel_folder_get_uncached_uids;

    extern fn camel_folder_get_unread_message_count(p_folder: *Folder) c_int;
    pub const getUnreadMessageCount = camel_folder_get_unread_message_count;

    /// Get whether or not the folder has a summary.
    extern fn camel_folder_has_summary_capability(p_folder: *Folder) c_int;
    pub const hasSummaryCapability = camel_folder_has_summary_capability;

    extern fn camel_folder_is_frozen(p_folder: *Folder) c_int;
    pub const isFrozen = camel_folder_is_frozen;

    /// Locks `folder`. Unlock it with `camel.Folder.unlock`.
    extern fn camel_folder_lock(p_folder: *Folder) void;
    pub const lock = camel_folder_lock;

    /// Lets the `folder` know that it should refresh its content
    /// the next time from fresh. This is useful for remote accounts,
    /// to fully re-check the folder content against the server.
    extern fn camel_folder_prepare_content_refresh(p_folder: *Folder) void;
    pub const prepareContentRefresh = camel_folder_prepare_content_refresh;

    /// Delete the local cache of all messages between these uids.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.purgeMessageCacheFinish` to get the result of the
    /// operation.
    extern fn camel_folder_purge_message_cache(p_folder: *Folder, p_start_uid: [*:0]u8, p_end_uid: [*:0]u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const purgeMessageCache = camel_folder_purge_message_cache;

    /// Finishes the operation started with `camel.Folder.purgeMessageCache`.
    extern fn camel_folder_purge_message_cache_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const purgeMessageCacheFinish = camel_folder_purge_message_cache_finish;

    /// Delete the local cache of all messages between these uids.
    extern fn camel_folder_purge_message_cache_sync(p_folder: *Folder, p_start_uid: [*:0]u8, p_end_uid: [*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const purgeMessageCacheSync = camel_folder_purge_message_cache_sync;

    /// Asynchronously synchronizes a folder's summary with its backing store.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.refreshInfoFinish` to get the result of the operation.
    extern fn camel_folder_refresh_info(p_folder: *Folder, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refreshInfo = camel_folder_refresh_info;

    /// Finishes the operation started with `camel.Folder.refreshInfo`.
    extern fn camel_folder_refresh_info_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshInfoFinish = camel_folder_refresh_info_finish;

    /// Synchronizes a folder's summary with its backing store.
    extern fn camel_folder_refresh_info_sync(p_folder: *Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshInfoSync = camel_folder_refresh_info_sync;

    /// Marks `folder` as renamed.
    ///
    /// This also emits the `camel.Folder.signals.renamed` signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// NOTE: This is an internal function used by camel stores, no locking
    /// is performed on the folder.
    extern fn camel_folder_rename(p_folder: *Folder, p_new_name: [*:0]const u8) void;
    pub const rename = camel_folder_rename;

    /// Searches the folder for messages matching the given search expression.
    extern fn camel_folder_search_by_expression(p_folder: *Folder, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const searchByExpression = camel_folder_search_by_expression;

    /// Search a subset of uid's for an expression match.
    extern fn camel_folder_search_by_uids(p_folder: *Folder, p_expression: [*:0]const u8, p_uids: *glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const searchByUids = camel_folder_search_by_uids;

    /// Free the result of a search as gotten by `camel.Folder.searchByExpression`
    /// or `camel.Folder.searchByUids`.
    extern fn camel_folder_search_free(p_folder: *Folder, p_result: *glib.PtrArray) void;
    pub const searchFree = camel_folder_search_free;

    /// Sets a description of the folder suitable for displaying to the user.
    extern fn camel_folder_set_description(p_folder: *Folder, p_description: [*:0]const u8) void;
    pub const setDescription = camel_folder_set_description;

    /// Sets the display name for the folder.
    extern fn camel_folder_set_display_name(p_folder: *Folder, p_display_name: [*:0]const u8) void;
    pub const setDisplayName = camel_folder_set_display_name;

    /// Sets folder flags (bit-or of `camel.FolderFlags`) for the `folder`.
    extern fn camel_folder_set_flags(p_folder: *Folder, p_folder_flags: u32) void;
    pub const setFlags = camel_folder_set_flags;

    /// Sets the fully qualified name of the folder.
    extern fn camel_folder_set_full_name(p_folder: *Folder, p_full_name: [*:0]const u8) void;
    pub const setFullName = camel_folder_set_full_name;

    /// Sets whether folder locking (`camel.Folder.lock` and `camel.Folder.unlock`)
    /// should be used. When set to `FALSE`, the two functions do nothing and simply
    /// return.
    extern fn camel_folder_set_lock_async(p_folder: *Folder, p_skip_folder_lock: c_int) void;
    pub const setLockAsync = camel_folder_set_lock_async;

    /// Sets whether the messages in this `folder` should be marked
    /// as seen automatically. An inconsistent state means to use
    /// global option.
    extern fn camel_folder_set_mark_seen(p_folder: *Folder, p_mark_seen: camel.ThreeState) void;
    pub const setMarkSeen = camel_folder_set_mark_seen;

    /// Sets the `timeout` in milliseconds for marking messages
    /// as seen in this `folder`. Whether the timeout is used
    /// depends on `camel.Folder.getMarkSeen`.
    extern fn camel_folder_set_mark_seen_timeout(p_folder: *Folder, p_timeout: c_int) void;
    pub const setMarkSeenTimeout = camel_folder_set_mark_seen_timeout;

    /// Sets those flags specified by `mask` to the values specified by `set`
    /// on the indicated message. (This may or may not persist after the
    /// folder or store is closed. See `camel.Folder.getPermanentFlags`)
    ///
    /// E.g. to set the deleted flag and clear the draft flag, use
    /// camel_folder_set_message_flags (folder, uid, CAMEL_MESSAGE_DELETED|CAMEL_MESSAGE_DRAFT, CAMEL_MESSAGE_DELETED);
    extern fn camel_folder_set_message_flags(p_folder: *Folder, p_uid: [*:0]const u8, p_mask: u32, p_set: u32) c_int;
    pub const setMessageFlags = camel_folder_set_message_flags;

    extern fn camel_folder_set_message_user_flag(p_folder: *Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: c_int) void;
    pub const setMessageUserFlag = camel_folder_set_message_user_flag;

    extern fn camel_folder_set_message_user_tag(p_folder: *Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setMessageUserTag = camel_folder_set_message_user_tag;

    /// Sorts the array of UIDs.
    extern fn camel_folder_sort_uids(p_folder: *Folder, p_uids: *glib.PtrArray) void;
    pub const sortUids = camel_folder_sort_uids;

    /// Synchronizes any changes that have been made to `folder` to its backing
    /// store asynchronously, optionally expunging deleted messages as well.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.synchronizeFinish` to get the result of the operation.
    extern fn camel_folder_synchronize(p_folder: *Folder, p_expunge: c_int, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const synchronize = camel_folder_synchronize;

    /// Finishes the operation started with `camel.Folder.synchronize`.
    extern fn camel_folder_synchronize_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeFinish = camel_folder_synchronize_finish;

    /// Asynchronously ensure that a message identified by `message_uid` has been
    /// synchronized in `folder` so that calling `camel.Folder.getMessage` on it
    /// later will work in offline mode.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.synchronizeMessageFinish` to get the result of the
    /// operation.
    extern fn camel_folder_synchronize_message(p_folder: *Folder, p_message_uid: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const synchronizeMessage = camel_folder_synchronize_message;

    /// Finishes the operation started with `camel.Folder.synchronizeMessage`.
    extern fn camel_folder_synchronize_message_finish(p_folder: *Folder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeMessageFinish = camel_folder_synchronize_message_finish;

    /// Ensure that a message identified by `message_uid` has been synchronized in
    /// `folder` so that calling `camel.Folder.getMessage` on it later will work
    /// in offline mode.
    extern fn camel_folder_synchronize_message_sync(p_folder: *Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeMessageSync = camel_folder_synchronize_message_sync;

    /// Synchronizes any changes that have been made to `folder` to its
    /// backing store, optionally expunging deleted messages as well.
    extern fn camel_folder_synchronize_sync(p_folder: *Folder, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeSync = camel_folder_synchronize_sync;

    /// Sets a `camel.FolderSummary` of the folder. It consumes the `summary`.
    ///
    /// This is supposed to be called only by the descendants of
    /// the `camel.Folder` and only at the construction time. Calling
    /// this function twice yeilds to an error.
    extern fn camel_folder_take_folder_summary(p_folder: *Folder, p_summary: *camel.FolderSummary) void;
    pub const takeFolderSummary = camel_folder_take_folder_summary;

    /// Thaws the folder and emits any pending folder_changed
    /// signals.
    extern fn camel_folder_thaw(p_folder: *Folder) void;
    pub const thaw = camel_folder_thaw;

    /// Asynchronously copies or moves messages from one folder to another.
    /// If the `source` or `destination` folders have the same parent store,
    /// this may be more efficient than using `camel.Folder.appendMessage`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Folder.transferMessagesToFinish` to get the result of the
    /// operation.
    extern fn camel_folder_transfer_messages_to(p_source: *Folder, p_message_uids: *glib.PtrArray, p_destination: *camel.Folder, p_delete_originals: c_int, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const transferMessagesTo = camel_folder_transfer_messages_to;

    /// Finishes the operation started with `camel.Folder.transferMessagesTo`.
    extern fn camel_folder_transfer_messages_to_finish(p_source: *Folder, p_result: *gio.AsyncResult, p_transferred_uids: ?**glib.PtrArray, p_error: ?*?*glib.Error) c_int;
    pub const transferMessagesToFinish = camel_folder_transfer_messages_to_finish;

    /// Copies or moves messages from one folder to another.  If the
    /// `source` and `destination` folders have the same parent_store, this
    /// may be more efficient than using `camel.Folder.appendMessageSync`.
    extern fn camel_folder_transfer_messages_to_sync(p_source: *Folder, p_message_uids: *glib.PtrArray, p_destination: *camel.Folder, p_delete_originals: c_int, p_transferred_uids: ?**glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const transferMessagesToSync = camel_folder_transfer_messages_to_sync;

    /// Unlocks `folder`, previously locked with `camel.Folder.lock`.
    extern fn camel_folder_unlock(p_folder: *Folder) void;
    pub const unlock = camel_folder_unlock;

    extern fn camel_folder_get_type() usize;
    pub const getGObjectType = camel_folder_get_type;

    extern fn g_object_ref(p_self: *camel.Folder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Folder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Folder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSearch = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.FolderSearchClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.FolderSearchPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Increases time `t` by the given number of months (or decreases, if
    /// `months` is negative).
    extern fn camel_folder_search_util_add_months(p_t: std.posix.time_t, p_months: c_int) std.posix.time_t;
    pub const utilAddMonths = camel_folder_search_util_add_months;

    /// Compares date portion of the two date-time values, first converted
    /// into the local time zone. The returned value is like with `strcmp`.
    extern fn camel_folder_search_util_compare_date(p_datetime1: i64, p_datetime2: i64) c_int;
    pub const utilCompareDate = camel_folder_search_util_compare_date;

    /// Calculates a hash of the Message-ID header value `message_id`.
    extern fn camel_folder_search_util_hash_message_id(p_message_id: [*:0]const u8, p_needs_decode: c_int) u64;
    pub const utilHashMessageId = camel_folder_search_util_hash_message_id;

    /// Implementation of 'make-time' function, which expects one argument,
    /// a string or an integer, to be converted into time_t.
    extern fn camel_folder_search_util_make_time(p_argc: c_int, p_argv: **camel.SExpResult) std.posix.time_t;
    pub const utilMakeTime = camel_folder_search_util_make_time;

    /// Create a new CamelFolderSearch object.
    ///
    /// A CamelFolderSearch is a subclassable, extensible s-exp
    /// evaluator which enforces a particular set of s-expressions.
    /// Particular methods may be overriden by an implementation to
    /// implement a search for any sort of backend.
    extern fn camel_folder_search_new() *camel.FolderSearch;
    pub const new = camel_folder_search_new;

    /// Run a search.  Search must have had Folder already set on it, and
    /// it must implement summaries.
    extern fn camel_folder_search_count(p_search: *FolderSearch, p_expr: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) u32;
    pub const count = camel_folder_search_count;

    /// Frees result of `camel.FolderSearch.search` call.
    extern fn camel_folder_search_free_result(p_search: *FolderSearch, p_result: ?*glib.PtrArray) void;
    pub const freeResult = camel_folder_search_free_result;

    extern fn camel_folder_search_get_current_message_info(p_search: *FolderSearch) ?*camel.MessageInfo;
    pub const getCurrentMessageInfo = camel_folder_search_get_current_message_info;

    extern fn camel_folder_search_get_current_summary(p_search: *FolderSearch) *glib.PtrArray;
    pub const getCurrentSummary = camel_folder_search_get_current_summary;

    extern fn camel_folder_search_get_folder(p_search: *FolderSearch) *camel.Folder;
    pub const getFolder = camel_folder_search_get_folder;

    extern fn camel_folder_search_get_only_cached_messages(p_search: *FolderSearch) c_int;
    pub const getOnlyCachedMessages = camel_folder_search_get_only_cached_messages;

    extern fn camel_folder_search_get_summary(p_search: *FolderSearch) *glib.PtrArray;
    pub const getSummary = camel_folder_search_get_summary;

    extern fn camel_folder_search_get_summary_empty(p_search: *FolderSearch) c_int;
    pub const getSummaryEmpty = camel_folder_search_get_summary_empty;

    /// Run a search.  Search must have had Folder already set on it, and
    /// it must implement summaries.
    extern fn camel_folder_search_search(p_search: *FolderSearch, p_expr: [*:0]const u8, p_uids: *glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const search = camel_folder_search_search;

    /// Set the index representing the contents of all messages
    /// in this folder.  If this is not set, then the folder implementation
    /// should sub-class the CamelFolderSearch and provide its own
    /// body-contains function.
    extern fn camel_folder_search_set_body_index(p_search: *FolderSearch, p_body_index: ?*camel.Index) void;
    pub const setBodyIndex = camel_folder_search_set_body_index;

    /// Sets, or unsets, the `info` as the currently processing `camel.MessageInfo`.
    /// The function adds its own reference to `info`, if not `NULL`.
    extern fn camel_folder_search_set_current_message_info(p_search: *FolderSearch, p_info: ?*camel.MessageInfo) void;
    pub const setCurrentMessageInfo = camel_folder_search_set_current_message_info;

    /// Set the folder attribute of the search. This can be used to perform a slow-search
    /// when indexes and so forth are not available. Or for use by subclasses.
    extern fn camel_folder_search_set_folder(p_search: *FolderSearch, p_folder: *camel.Folder) void;
    pub const setFolder = camel_folder_search_set_folder;

    /// Sets whether only locally cached messages can be searched. The default
    /// value is `FALSE`, which means that when a message is required and it is
    /// not available locally, then it is downloaded from the server, if possible.
    extern fn camel_folder_search_set_only_cached_messages(p_search: *FolderSearch, p_only_cached_messages: c_int) void;
    pub const setOnlyCachedMessages = camel_folder_search_set_only_cached_messages;

    /// Set the array of summary objects representing the span of the search.
    ///
    /// If this is not set, then a subclass must provide the functions
    /// for searching headers and for the match-all operator.
    extern fn camel_folder_search_set_summary(p_search: *FolderSearch, p_summary: *glib.PtrArray) void;
    pub const setSummary = camel_folder_search_set_summary;

    /// Sets, or unsets, the `info` as the currently processing `camel.MessageInfo`.
    /// Unlike `camel.FolderSearch.setCurrentMessageInfo`, this function
    /// assumes ownership of the `info`, if not `NULL`.
    extern fn camel_folder_search_take_current_message_info(p_search: *FolderSearch, p_info: ?*camel.MessageInfo) void;
    pub const takeCurrentMessageInfo = camel_folder_search_take_current_message_info;

    extern fn camel_folder_search_get_type() usize;
    pub const getGObjectType = camel_folder_search_get_type;

    extern fn g_object_ref(p_self: *camel.FolderSearch) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.FolderSearch) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FolderSearch, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSummary = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.FolderSummaryClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.FolderSummaryPrivate,

    pub const virtual_methods = struct {
        /// Retrieve a summary item by uid.
        ///
        /// A referenced to the summary item is returned, which may be
        /// ref'd or free'd as appropriate.
        pub const message_info_from_uid = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) ?*camel.MessageInfo {
                return gobject.ext.as(FolderSummary.Class, p_class).f_message_info_from_uid.?(gobject.ext.as(FolderSummary, p_summary), p_uid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) callconv(.c) ?*camel.MessageInfo) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_message_info_from_uid = @ptrCast(p_implementation);
            }
        };

        /// Create a new info record from a header.
        pub const message_info_new_from_headers = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: *const camel.NameValueArray) *camel.MessageInfo {
                return gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_headers.?(gobject.ext.as(FolderSummary, p_summary), p_headers);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: *const camel.NameValueArray) callconv(.c) *camel.MessageInfo) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_headers = @ptrCast(p_implementation);
            }
        };

        /// Create a summary item from a message.
        pub const message_info_new_from_message = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage) *camel.MessageInfo {
                return gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_message.?(gobject.ext.as(FolderSummary, p_summary), p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage) callconv(.c) *camel.MessageInfo) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_message = @ptrCast(p_implementation);
            }
        };

        /// Create a new info record from a parser.  If the parser cannot
        /// determine a uid, then none will be assigned.
        ///
        /// If indexing is enabled, and the parser cannot determine a new uid, then
        /// one is automatically assigned.
        ///
        /// If indexing is enabled, then the content will be indexed based
        /// on this new uid.  In this case, the message info MUST be
        /// added using :`add`.
        ///
        /// Once complete, the parser will be positioned at the end of
        /// the message.
        pub const message_info_new_from_parser = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser) *camel.MessageInfo {
                return gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_parser.?(gobject.ext.as(FolderSummary, p_summary), p_parser);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser) callconv(.c) *camel.MessageInfo) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_message_info_new_from_parser = @ptrCast(p_implementation);
            }
        };

        /// Retrieve the next uid, but as a formatted string.
        pub const next_uid_string = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FolderSummary.Class, p_class).f_next_uid_string.?(gobject.ext.as(FolderSummary, p_summary));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_next_uid_string = @ptrCast(p_implementation);
            }
        };

        pub const prepare_fetch_all = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(FolderSummary.Class, p_class).f_prepare_fetch_all.?(gobject.ext.as(FolderSummary, p_summary));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_prepare_fetch_all = @ptrCast(p_implementation);
            }
        };

        pub const summary_header_load = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fir: ?*anyopaque) c_int {
                return gobject.ext.as(FolderSummary.Class, p_class).f_summary_header_load.?(gobject.ext.as(FolderSummary, p_summary), p_fir);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fir: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_summary_header_load = @ptrCast(p_implementation);
            }
        };

        pub const summary_header_save = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) ?*anyopaque {
                return gobject.ext.as(FolderSummary.Class, p_class).f_summary_header_save.?(gobject.ext.as(FolderSummary, p_summary), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) callconv(.c) ?*anyopaque) void {
                gobject.ext.as(FolderSummary.Class, p_class).f_summary_header_save = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// How many deleted infos is saved in a summary.
        pub const deleted_count = struct {
            pub const name = "deleted-count";

            pub const Type = c_uint;
        };

        /// The `camel.Folder` to which the folder summary belongs.
        pub const folder = struct {
            pub const name = "folder";

            pub const Type = ?*camel.Folder;
        };

        /// How many junk infos is saved in a summary.
        pub const junk_count = struct {
            pub const name = "junk-count";

            pub const Type = c_uint;
        };

        /// How many junk and not deleted infos is saved in a summary.
        pub const junk_not_deleted_count = struct {
            pub const name = "junk-not-deleted-count";

            pub const Type = c_uint;
        };

        /// How many infos is saved in a summary.
        pub const saved_count = struct {
            pub const name = "saved-count";

            pub const Type = c_uint;
        };

        /// How many unread infos is saved in a summary.
        pub const unread_count = struct {
            pub const name = "unread-count";

            pub const Type = c_uint;
        };

        /// How many visible (not deleted and not junk) infos is saved in a summary.
        pub const visible_count = struct {
            pub const name = "visible-count";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FolderSummary, p_instance))),
                    gobject.signalLookup("changed", FolderSummary.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Free's array and its elements returned from `camel.FolderSummary.getArray`.
    extern fn camel_folder_summary_free_array(p_array: *glib.PtrArray) void;
    pub const freeArray = camel_folder_summary_free_array;

    /// Create a new `camel.FolderSummary` object.
    extern fn camel_folder_summary_new(p_folder: *camel.Folder) *camel.FolderSummary;
    pub const new = camel_folder_summary_new;

    /// Adds a new `info` record to the summary. If the `force_keep_uid` is `FALSE`,
    /// then a new uid is automatically re-assigned by calling
    /// `camel.FolderSummary.nextUidString`. It's an error to use
    /// `force_keep_uid` when the `info` has none set.
    ///
    /// The `summary` adds its own reference to `info`, if needed, and any
    /// previously loaded info is replaced with the new one.
    extern fn camel_folder_summary_add(p_summary: *FolderSummary, p_info: *camel.MessageInfo, p_force_keep_uid: c_int) void;
    pub const add = camel_folder_summary_add;

    /// Check if the uid is valid. This isn't very efficient, so it shouldn't be called iteratively.
    extern fn camel_folder_summary_check_uid(p_summary: *FolderSummary, p_uid: [*:0]const u8) c_int;
    pub const checkUid = camel_folder_summary_check_uid;

    /// Empty the summary contents.
    extern fn camel_folder_summary_clear(p_summary: *FolderSummary, p_error: ?*?*glib.Error) c_int;
    pub const clear = camel_folder_summary_clear;

    /// Get the number of summary items stored in this summary.
    extern fn camel_folder_summary_count(p_summary: *FolderSummary) c_uint;
    pub const count = camel_folder_summary_count;

    /// Retrieve a summary item by uid.
    ///
    /// A referenced to the summary item is returned, which may be
    /// ref'd or free'd as appropriate.
    extern fn camel_folder_summary_get(p_summary: *FolderSummary, p_uid: [*:0]const u8) ?*camel.MessageInfo;
    pub const get = camel_folder_summary_get;

    /// Obtain a copy of the summary array.  This is done atomically,
    /// so cannot contain empty entries.
    ///
    /// Free with `camel.FolderSummary.freeArray`
    extern fn camel_folder_summary_get_array(p_summary: *FolderSummary) *glib.PtrArray;
    pub const getArray = camel_folder_summary_get_array;

    /// Returns an array of changed UID-s. A UID is considered changed
    /// when its corresponding CamelMesageInfo is 'dirty' or when it has
    /// set the `CAMEL_MESSAGE_FOLDER_FLAGGED` flag.
    extern fn camel_folder_summary_get_changed(p_summary: *FolderSummary) *glib.PtrArray;
    pub const getChanged = camel_folder_summary_get_changed;

    extern fn camel_folder_summary_get_deleted_count(p_summary: *FolderSummary) u32;
    pub const getDeletedCount = camel_folder_summary_get_deleted_count;

    extern fn camel_folder_summary_get_flags(p_summary: *FolderSummary) u32;
    pub const getFlags = camel_folder_summary_get_flags;

    extern fn camel_folder_summary_get_folder(p_summary: *FolderSummary) ?*anyopaque;
    pub const getFolder = camel_folder_summary_get_folder;

    /// Returns hash of current stored 'uids' in summary, where key is 'uid'
    /// from the string pool, and value is 1. The returned pointer should
    /// be freed with `glib.hashTableDestroy`.
    ///
    /// Note: When searching for values always use uids from the string pool.
    extern fn camel_folder_summary_get_hash(p_summary: *FolderSummary) *glib.HashTable;
    pub const getHash = camel_folder_summary_get_hash;

    extern fn camel_folder_summary_get_index(p_summary: *FolderSummary) ?*camel.Index;
    pub const getIndex = camel_folder_summary_get_index;

    /// Retrieve CamelMessageInfo::flags for a message info with UID `uid`.
    /// This is much quicker than `camel.FolderSummary.get`, because it
    /// doesn't require reading the message info from a disk.
    extern fn camel_folder_summary_get_info_flags(p_summary: *FolderSummary, p_uid: [*:0]const u8) u32;
    pub const getInfoFlags = camel_folder_summary_get_info_flags;

    extern fn camel_folder_summary_get_junk_count(p_summary: *FolderSummary) u32;
    pub const getJunkCount = camel_folder_summary_get_junk_count;

    extern fn camel_folder_summary_get_junk_not_deleted_count(p_summary: *FolderSummary) u32;
    pub const getJunkNotDeletedCount = camel_folder_summary_get_junk_not_deleted_count;

    extern fn camel_folder_summary_get_next_uid(p_summary: *FolderSummary) u32;
    pub const getNextUid = camel_folder_summary_get_next_uid;

    extern fn camel_folder_summary_get_saved_count(p_summary: *FolderSummary) u32;
    pub const getSavedCount = camel_folder_summary_get_saved_count;

    extern fn camel_folder_summary_get_timestamp(p_summary: *FolderSummary) i64;
    pub const getTimestamp = camel_folder_summary_get_timestamp;

    extern fn camel_folder_summary_get_unread_count(p_summary: *FolderSummary) u32;
    pub const getUnreadCount = camel_folder_summary_get_unread_count;

    extern fn camel_folder_summary_get_version(p_summary: *FolderSummary) u32;
    pub const getVersion = camel_folder_summary_get_version;

    extern fn camel_folder_summary_get_visible_count(p_summary: *FolderSummary) u32;
    pub const getVisibleCount = camel_folder_summary_get_visible_count;

    /// Loads a summary header for the `summary`, which corresponds to `folder_name`
    /// provided by `store`.
    extern fn camel_folder_summary_header_load(p_summary: *FolderSummary, p_store: ?*anyopaque, p_folder_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const headerLoad = camel_folder_summary_header_load;

    /// Saves summary header information into the disk. The function does
    /// nothing, if the summary doesn't support save to disk.
    extern fn camel_folder_summary_header_save(p_summary: *FolderSummary, p_error: ?*?*glib.Error) c_int;
    pub const headerSave = camel_folder_summary_header_save;

    /// Create a new info record from a header.
    extern fn camel_folder_summary_info_new_from_headers(p_summary: *FolderSummary, p_headers: *const camel.NameValueArray) *camel.MessageInfo;
    pub const infoNewFromHeaders = camel_folder_summary_info_new_from_headers;

    /// Create a summary item from a message.
    extern fn camel_folder_summary_info_new_from_message(p_summary: *FolderSummary, p_message: *camel.MimeMessage) *camel.MessageInfo;
    pub const infoNewFromMessage = camel_folder_summary_info_new_from_message;

    /// Create a new info record from a parser.  If the parser cannot
    /// determine a uid, then none will be assigned.
    ///
    /// If indexing is enabled, and the parser cannot determine a new uid, then
    /// one is automatically assigned.
    ///
    /// If indexing is enabled, then the content will be indexed based
    /// on this new uid.  In this case, the message info MUST be
    /// added using :`add`.
    ///
    /// Once complete, the parser will be positioned at the end of
    /// the message.
    extern fn camel_folder_summary_info_new_from_parser(p_summary: *FolderSummary, p_parser: *camel.MimeParser) *camel.MessageInfo;
    pub const infoNewFromParser = camel_folder_summary_info_new_from_parser;

    /// Loads the summary from the disk. It also saves any pending
    /// changes first.
    extern fn camel_folder_summary_load(p_summary: *FolderSummary, p_error: ?*?*glib.Error) c_int;
    pub const load = camel_folder_summary_load;

    /// Locks `summary`. Unlock it with `camel.FolderSummary.unlock`.
    extern fn camel_folder_summary_lock(p_summary: *FolderSummary) void;
    pub const lock = camel_folder_summary_lock;

    /// Generate a new unique uid value as an integer.  This
    /// may be used to create a unique sequence of numbers.
    extern fn camel_folder_summary_next_uid(p_summary: *FolderSummary) u32;
    pub const nextUid = camel_folder_summary_next_uid;

    /// Retrieve the next uid, but as a formatted string.
    extern fn camel_folder_summary_next_uid_string(p_summary: *FolderSummary) [*:0]u8;
    pub const nextUidString = camel_folder_summary_next_uid_string;

    extern fn camel_folder_summary_peek_loaded(p_summary: *FolderSummary, p_uid: [*:0]const u8) ?*camel.MessageInfo;
    pub const peekLoaded = camel_folder_summary_peek_loaded;

    /// Loads all infos into memory, if they are not yet and ensures
    /// they will not be freed in next couple minutes. Call this function
    /// before any mass operation or when all message infos will be needed,
    /// for better performance.
    extern fn camel_folder_summary_prepare_fetch_all(p_summary: *FolderSummary, p_error: ?*?*glib.Error) void;
    pub const prepareFetchAll = camel_folder_summary_prepare_fetch_all;

    /// Remove a specific `info` record from the summary.
    extern fn camel_folder_summary_remove(p_summary: *FolderSummary, p_info: *camel.MessageInfo) c_int;
    pub const remove = camel_folder_summary_remove;

    /// Remove a specific info record from the summary, by `uid`.
    extern fn camel_folder_summary_remove_uid(p_summary: *FolderSummary, p_uid: [*:0]const u8) c_int;
    pub const removeUid = camel_folder_summary_remove_uid;

    /// Remove a specific info record from the summary, by `uid`.
    extern fn camel_folder_summary_remove_uids(p_summary: *FolderSummary, p_uids: *glib.List) c_int;
    pub const removeUids = camel_folder_summary_remove_uids;

    /// Updates internal counts based on the flags in `info`.
    extern fn camel_folder_summary_replace_flags(p_summary: *FolderSummary, p_info: *camel.MessageInfo) c_int;
    pub const replaceFlags = camel_folder_summary_replace_flags;

    /// Saves the content of the `summary` to disk. It does nothing,
    /// when the summary is not changed or when it doesn't support
    /// permanent save.
    extern fn camel_folder_summary_save(p_summary: *FolderSummary, p_error: ?*?*glib.Error) c_int;
    pub const save = camel_folder_summary_save;

    /// Sets flags of the `summary`, a bit-or of `camel.FolderSummaryFlags`.
    extern fn camel_folder_summary_set_flags(p_summary: *FolderSummary, p_flags: u32) void;
    pub const setFlags = camel_folder_summary_set_flags;

    /// Set the index used to index body content.  If the index is `NULL`, or
    /// not set (the default), no indexing of body content will take place.
    extern fn camel_folder_summary_set_index(p_summary: *FolderSummary, p_index: ?*camel.Index) void;
    pub const setIndex = camel_folder_summary_set_index;

    /// Set the next minimum uid available.  This can be used to
    /// ensure new uid's do not clash with existing uid's.
    extern fn camel_folder_summary_set_next_uid(p_summary: *FolderSummary, p_uid: u32) void;
    pub const setNextUid = camel_folder_summary_set_next_uid;

    /// Sets timestamp of the `summary`, provided by the descendants. This doesn't
    /// change the 'dirty' flag of the `summary`.
    extern fn camel_folder_summary_set_timestamp(p_summary: *FolderSummary, p_timestamp: i64) void;
    pub const setTimestamp = camel_folder_summary_set_timestamp;

    /// Sets version of the `summary`.
    extern fn camel_folder_summary_set_version(p_summary: *FolderSummary, p_version: u32) void;
    pub const setVersion = camel_folder_summary_set_version;

    /// Mark the summary as changed, so that a save will force it to be
    /// written back to disk.
    extern fn camel_folder_summary_touch(p_summary: *FolderSummary) void;
    pub const touch = camel_folder_summary_touch;

    /// Unlocks `summary`, previously locked with `camel.FolderSummary.lock`.
    extern fn camel_folder_summary_unlock(p_summary: *FolderSummary) void;
    pub const unlock = camel_folder_summary_unlock;

    extern fn camel_folder_summary_get_type() usize;
    pub const getGObjectType = camel_folder_summary_get_type;

    extern fn g_object_ref(p_self: *camel.FolderSummary) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.FolderSummary) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FolderSummary, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GpgContext = extern struct {
    pub const Parent = camel.CipherContext;
    pub const Implements = [_]type{};
    pub const Class = camel.GpgContextClass;
    f_parent: camel.CipherContext,
    f_priv: ?*camel.GpgContextPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const always_trust = struct {
            pub const name = "always-trust";

            pub const Type = c_int;
        };

        pub const locate_keys = struct {
            pub const name = "locate-keys";

            pub const Type = c_int;
        };

        pub const prefer_inline = struct {
            pub const name = "prefer-inline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new gpg cipher context object.
    extern fn camel_gpg_context_new(p_session: ?*camel.Session) *camel.GpgContext;
    pub const new = camel_gpg_context_new;

    extern fn camel_gpg_context_get_always_trust(p_context: *GpgContext) c_int;
    pub const getAlwaysTrust = camel_gpg_context_get_always_trust;

    /// Receives information about a key stored in `data` of size `data_size`.
    ///
    /// The `flags` argument is currently unused and should be set to 0.
    ///
    /// Free the returned `out_infos` with g_slist_free_full (infos, camel_gpg_key_info_free);
    /// when no longer needed.
    extern fn camel_gpg_context_get_key_data_info_sync(p_context: *GpgContext, p_data: *const u8, p_data_size: usize, p_flags: u32, p_out_infos: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getKeyDataInfoSync = camel_gpg_context_get_key_data_info_sync;

    /// Returns, whether gpg can locate keys using Web Key Directory (WKD) lookup
    /// when encrypting messages. The default is `TRUE`.
    extern fn camel_gpg_context_get_locate_keys(p_context: *GpgContext) c_int;
    pub const getLocateKeys = camel_gpg_context_get_locate_keys;

    extern fn camel_gpg_context_get_prefer_inline(p_context: *GpgContext) c_int;
    pub const getPreferInline = camel_gpg_context_get_prefer_inline;

    /// Receives information about a key `keyid`.
    ///
    /// The `keyid` can be either key ID or an email address.
    ///
    /// The `flags` argument is currently unused and should be set to 0.
    ///
    /// Free the returned `out_infos` with g_slist_free_full (infos, camel_gpg_key_info_free);
    /// when no longer needed.
    extern fn camel_gpg_context_get_public_key_info_sync(p_context: *GpgContext, p_keyid: [*:0]const u8, p_flags: u32, p_out_infos: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getPublicKeyInfoSync = camel_gpg_context_get_public_key_info_sync;

    /// Returns a public key with `keyid`.
    ///
    /// The `keyid` can be either key ID or an email address.
    ///
    /// The `flags` argument is currently unused and should be set to 0.
    ///
    /// The `out_data` content should be freed with `glib.free`, when
    /// no longer needed.
    extern fn camel_gpg_context_get_public_key_sync(p_context: *GpgContext, p_keyid: [*:0]const u8, p_flags: u32, p_out_data: **u8, p_out_data_size: *usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getPublicKeySync = camel_gpg_context_get_public_key_sync;

    /// Checks whether there exists a public key with `keyid`.
    ///
    /// The `keyid` can be either key ID or an email address.
    extern fn camel_gpg_context_has_public_key_sync(p_context: *GpgContext, p_keyid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const hasPublicKeySync = camel_gpg_context_has_public_key_sync;

    /// Imports a (public) key provided in a binary form stored in the `data`
    /// of size `data_size`.
    extern fn camel_gpg_context_import_key_sync(p_context: *GpgContext, p_data: *const u8, p_data_size: usize, p_flags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const importKeySync = camel_gpg_context_import_key_sync;

    /// Sets the `always_trust` flag on the gpg context which is used for
    /// encryption.
    extern fn camel_gpg_context_set_always_trust(p_context: *GpgContext, p_always_trust: c_int) void;
    pub const setAlwaysTrust = camel_gpg_context_set_always_trust;

    /// Sets `trust` level on the key `keyid`.
    ///
    /// The `keyid` can be either key ID or an email address.
    extern fn camel_gpg_context_set_key_trust_sync(p_context: *GpgContext, p_keyid: [*:0]const u8, p_trust: camel.GpgTrust, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setKeyTrustSync = camel_gpg_context_set_key_trust_sync;

    /// Sets the `locate_keys` on the gpg context which is used to instruct
    /// gpg to locate keys using Web Key Directory (WKD) lookup when encrypting
    /// messages.
    extern fn camel_gpg_context_set_locate_keys(p_context: *GpgContext, p_locate_keys: c_int) void;
    pub const setLocateKeys = camel_gpg_context_set_locate_keys;

    /// Sets the `prefer_inline` flag on the gpg context.
    extern fn camel_gpg_context_set_prefer_inline(p_context: *GpgContext, p_prefer_inline: c_int) void;
    pub const setPreferInline = camel_gpg_context_set_prefer_inline;

    extern fn camel_gpg_context_get_type() usize;
    pub const getGObjectType = camel_gpg_context_get_type;

    extern fn g_object_ref(p_self: *camel.GpgContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.GpgContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GpgContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HTMLParser = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.HTMLParserClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.HTMLParserPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new CamelHTMLParser object.
    extern fn camel_html_parser_new() *camel.HTMLParser;
    pub const new = camel_html_parser_new;

    extern fn camel_html_parser_attr(p_hp: *HTMLParser, p_name: [*:0]const u8) [*:0]const u8;
    pub const attr = camel_html_parser_attr;

    /// Provides parsed array of values and attributes. Both arrays are
    /// owned by the `hp`.
    extern fn camel_html_parser_attr_list(p_hp: *HTMLParser, p_values: ?**const glib.PtrArray) *const glib.PtrArray;
    pub const attrList = camel_html_parser_attr_list;

    extern fn camel_html_parser_left(p_hp: *HTMLParser, p_lenp: *c_int) [*:0]const u8;
    pub const left = camel_html_parser_left;

    extern fn camel_html_parser_set_data(p_hp: *HTMLParser, p_start: [*:0]const u8, p_len: c_int, p_last: c_int) void;
    pub const setData = camel_html_parser_set_data;

    extern fn camel_html_parser_step(p_hp: *HTMLParser, p_datap: *[*:0]const u8, p_lenp: *c_int) camel.HTMLParserState;
    pub const step = camel_html_parser_step;

    extern fn camel_html_parser_tag(p_hp: *HTMLParser) [*:0]const u8;
    pub const tag = camel_html_parser_tag;

    extern fn camel_html_parser_get_type() usize;
    pub const getGObjectType = camel_html_parser_get_type;

    extern fn g_object_ref(p_self: *camel.HTMLParser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.HTMLParser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HTMLParser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Index = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.IndexClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.IndexPrivate,
    f_path: ?[*:0]u8,
    f_version: u32,
    f_flags: u32,
    f_state: u32,
    f_normalize: ?camel.IndexNorm,
    f_normalize_data: ?*anyopaque,

    pub const virtual_methods = struct {
        pub const add_name = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?*camel.IndexName {
                return gobject.ext.as(Index.Class, p_class).f_add_name.?(gobject.ext.as(Index, p_index), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?*camel.IndexName) void {
                gobject.ext.as(Index.Class, p_class).f_add_name = @ptrCast(p_implementation);
            }
        };

        pub const compress = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Index.Class, p_class).f_compress.?(gobject.ext.as(Index, p_index));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_compress = @ptrCast(p_implementation);
            }
        };

        pub const delete_ = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Index.Class, p_class).f_delete_.?(gobject.ext.as(Index, p_index));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_delete_ = @ptrCast(p_implementation);
            }
        };

        /// Deletes the given `name` from `index`.
        pub const delete_name = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) void {
                return gobject.ext.as(Index.Class, p_class).f_delete_name.?(gobject.ext.as(Index, p_index), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Index.Class, p_class).f_delete_name = @ptrCast(p_implementation);
            }
        };

        pub const find = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_word: [*:0]const u8) ?*camel.IndexCursor {
                return gobject.ext.as(Index.Class, p_class).f_find.?(gobject.ext.as(Index, p_index), p_word);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_word: [*:0]const u8) callconv(.c) ?*camel.IndexCursor) void {
                gobject.ext.as(Index.Class, p_class).f_find = @ptrCast(p_implementation);
            }
        };

        pub const find_name = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?*camel.IndexCursor {
                return gobject.ext.as(Index.Class, p_class).f_find_name.?(gobject.ext.as(Index, p_index), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?*camel.IndexCursor) void {
                gobject.ext.as(Index.Class, p_class).f_find_name = @ptrCast(p_implementation);
            }
        };

        pub const has_name = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) c_int {
                return gobject.ext.as(Index.Class, p_class).f_has_name.?(gobject.ext.as(Index, p_index), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_has_name = @ptrCast(p_implementation);
            }
        };

        pub const rename = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_path: [*:0]const u8) c_int {
                return gobject.ext.as(Index.Class, p_class).f_rename.?(gobject.ext.as(Index, p_index), p_path);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_path: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_rename = @ptrCast(p_implementation);
            }
        };

        pub const sync = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Index.Class, p_class).f_sync.?(gobject.ext.as(Index, p_index));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_sync = @ptrCast(p_implementation);
            }
        };

        pub const words = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*camel.IndexCursor {
                return gobject.ext.as(Index.Class, p_class).f_words.?(gobject.ext.as(Index, p_index));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*camel.IndexCursor) void {
                gobject.ext.as(Index.Class, p_class).f_words = @ptrCast(p_implementation);
            }
        };

        pub const write_name = struct {
            pub fn call(p_class: anytype, p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_idn: *camel.IndexName) c_int {
                return gobject.ext.as(Index.Class, p_class).f_write_name.?(gobject.ext.as(Index, p_index), p_idn);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_index: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_idn: *camel.IndexName) callconv(.c) c_int) void {
                gobject.ext.as(Index.Class, p_class).f_write_name = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_index_add_name(p_index: *Index, p_name: [*:0]const u8) ?*camel.IndexName;
    pub const addName = camel_index_add_name;

    extern fn camel_index_compress(p_index: *Index) c_int;
    pub const compress = camel_index_compress;

    extern fn camel_index_construct(p_index: *Index, p_path: [*:0]const u8, p_flags: c_int) void;
    pub const construct = camel_index_construct;

    extern fn camel_index_delete(p_index: *Index) c_int;
    pub const delete = camel_index_delete;

    /// Deletes the given `name` from `index`.
    extern fn camel_index_delete_name(p_index: *Index, p_name: [*:0]const u8) void;
    pub const deleteName = camel_index_delete_name;

    extern fn camel_index_find(p_index: *Index, p_word: [*:0]const u8) ?*camel.IndexCursor;
    pub const find = camel_index_find;

    extern fn camel_index_find_name(p_index: *Index, p_name: [*:0]const u8) ?*camel.IndexCursor;
    pub const findName = camel_index_find_name;

    extern fn camel_index_has_name(p_index: *Index, p_name: [*:0]const u8) c_int;
    pub const hasName = camel_index_has_name;

    extern fn camel_index_rename(p_index: *Index, p_path: [*:0]const u8) c_int;
    pub const rename = camel_index_rename;

    extern fn camel_index_set_normalize(p_index: *Index, p_func: camel.IndexNorm, p_user_data: ?*anyopaque) void;
    pub const setNormalize = camel_index_set_normalize;

    extern fn camel_index_sync(p_index: *Index) c_int;
    pub const sync = camel_index_sync;

    extern fn camel_index_words(p_index: *Index) ?*camel.IndexCursor;
    pub const words = camel_index_words;

    extern fn camel_index_write_name(p_index: *Index, p_idn: *camel.IndexName) c_int;
    pub const writeName = camel_index_write_name;

    extern fn camel_index_get_type() usize;
    pub const getGObjectType = camel_index_get_type;

    extern fn g_object_ref(p_self: *camel.Index) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Index) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Index, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexCursor = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.IndexCursorClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.IndexCursorPrivate,
    f_index: ?*camel.Index,

    pub const virtual_methods = struct {
        pub const next = struct {
            pub fn call(p_class: anytype, p_idc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(IndexCursor.Class, p_class).f_next.?(gobject.ext.as(IndexCursor, p_idc));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_idc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(IndexCursor.Class, p_class).f_next = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_index_cursor_next(p_idc: *IndexCursor) [*:0]const u8;
    pub const next = camel_index_cursor_next;

    extern fn camel_index_cursor_get_type() usize;
    pub const getGObjectType = camel_index_cursor_get_type;

    extern fn g_object_ref(p_self: *camel.IndexCursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.IndexCursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IndexCursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexName = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.IndexNameClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.IndexNamePrivate,
    f_index: ?*camel.Index,
    f_name: ?[*:0]u8,
    f_buffer: ?*glib.ByteArray,
    f_words: ?*glib.HashTable,

    pub const virtual_methods = struct {
        pub const add_buffer = struct {
            pub fn call(p_class: anytype, p_name: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*:0]const u8, p_len: usize) usize {
                return gobject.ext.as(IndexName.Class, p_class).f_add_buffer.?(gobject.ext.as(IndexName, p_name), p_buffer, p_len);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_name: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*:0]const u8, p_len: usize) callconv(.c) usize) void {
                gobject.ext.as(IndexName.Class, p_class).f_add_buffer = @ptrCast(p_implementation);
            }
        };

        pub const add_word = struct {
            pub fn call(p_class: anytype, p_name: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_word: [*:0]const u8) void {
                return gobject.ext.as(IndexName.Class, p_class).f_add_word.?(gobject.ext.as(IndexName, p_name), p_word);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_name: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_word: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(IndexName.Class, p_class).f_add_word = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_index_name_add_buffer(p_name: *IndexName, p_buffer: [*:0]const u8, p_len: usize) usize;
    pub const addBuffer = camel_index_name_add_buffer;

    extern fn camel_index_name_add_word(p_name: *IndexName, p_word: [*:0]const u8) void;
    pub const addWord = camel_index_name_add_word;

    extern fn camel_index_name_get_type() usize;
    pub const getGObjectType = camel_index_name_get_type;

    extern fn g_object_ref(p_self: *camel.IndexName) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.IndexName) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IndexName, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InternetAddress = extern struct {
    pub const Parent = camel.Address;
    pub const Implements = [_]type{};
    pub const Class = camel.InternetAddressClass;
    f_parent: camel.Address,
    f_priv: ?*camel.InternetAddressPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Encode a single address ready for internet usage.  Header folding
    /// as per rfc822 is also performed, based on the length *`len`.  If `len`
    /// is `NULL`, then no folding will occur.
    ///
    /// Note: The value at *`in` will be updated based on any linewrapping done
    extern fn camel_internet_address_encode_address(p_len: ?*c_int, p_name: [*:0]const u8, p_addr: [*:0]const u8) [*:0]u8;
    pub const encodeAddress = camel_internet_address_encode_address;

    /// Function to format a single address, suitable for display.
    extern fn camel_internet_address_format_address(p_name: [*:0]const u8, p_addr: [*:0]const u8) [*:0]u8;
    pub const formatAddress = camel_internet_address_format_address;

    /// Create a new `camel.InternetAddress` object.
    extern fn camel_internet_address_new() *camel.InternetAddress;
    pub const new = camel_internet_address_new;

    /// Add a new internet address to `addr`.
    extern fn camel_internet_address_add(p_addr: *InternetAddress, p_name: [*:0]const u8, p_address: [*:0]const u8) c_int;
    pub const add = camel_internet_address_add;

    /// Ensures that all email address' domains will be ASCII encoded,
    /// which means that any non-ASCII letters will be properly encoded.
    /// This includes IDN (Internationalized Domain Names).
    extern fn camel_internet_address_ensure_ascii_domains(p_addr: *InternetAddress) void;
    pub const ensureAsciiDomains = camel_internet_address_ensure_ascii_domains;

    /// Find an address by address.
    extern fn camel_internet_address_find_address(p_addr: *InternetAddress, p_address: [*:0]const u8, p_namep: ?*[*:0]const u8) c_int;
    pub const findAddress = camel_internet_address_find_address;

    /// Find address by real name.
    extern fn camel_internet_address_find_name(p_addr: *InternetAddress, p_name: [*:0]const u8, p_addressp: ?*[*:0]const u8) c_int;
    pub const findName = camel_internet_address_find_name;

    /// Get the address at `index`.
    extern fn camel_internet_address_get(p_addr: *InternetAddress, p_index: c_int, p_namep: ?*[*:0]const u8, p_addressp: ?*[*:0]const u8) c_int;
    pub const get = camel_internet_address_get;

    /// Checks the addresses in `addr` for any suspicious characters in the domain
    /// name and coverts those domains into their representation. In contrast to
    /// `camel.InternetAddress.ensureAsciiDomains`, this converts the domains
    /// into ASCII only when needed, as returned by `camel.hostnameUtilsRequiresAscii`.
    extern fn camel_internet_address_sanitize_ascii_domain(p_addr: *InternetAddress) c_int;
    pub const sanitizeAsciiDomain = camel_internet_address_sanitize_ascii_domain;

    extern fn camel_internet_address_get_type() usize;
    pub const getGObjectType = camel_internet_address_get_type;

    extern fn g_object_ref(p_self: *camel.InternetAddress) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.InternetAddress) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InternetAddress, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyFile = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.KeyFileClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.KeyFilePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new key file.  A linked list of record blocks.
    extern fn camel_key_file_new(p_path: [*:0]const u8, p_flags: c_int, p_version: [*:0]const u8) ?*camel.KeyFile;
    pub const new = camel_key_file_new;

    extern fn camel_key_file_delete(p_kf: *KeyFile) c_int;
    pub const delete = camel_key_file_delete;

    /// Read the next block of data from the key file.  Returns the number of
    /// records.
    extern fn camel_key_file_read(p_kf: *KeyFile, p_start: *camel._block_t, p_len: *usize, p_records: ?[*]*camel._key_t) c_int;
    pub const read = camel_key_file_read;

    extern fn camel_key_file_rename(p_kf: *KeyFile, p_path: [*:0]const u8) c_int;
    pub const rename = camel_key_file_rename;

    /// Write a new list of records to the key file.
    extern fn camel_key_file_write(p_kf: *KeyFile, p_parent: *camel._block_t, p_len: usize, p_records: [*]camel._key_t) c_int;
    pub const write = camel_key_file_write;

    extern fn camel_key_file_get_type() usize;
    pub const getGObjectType = camel_key_file_get_type;

    extern fn g_object_ref(p_self: *camel.KeyFile) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.KeyFile) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *KeyFile, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyTable = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.KeyTableClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.KeyTablePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_key_table_new(p_bs: *camel.BlockFile, p_root: camel._block_t) *camel.KeyTable;
    pub const new = camel_key_table_new;

    extern fn camel_key_table_add(p_ki: *KeyTable, p_key: [*:0]const u8, p_data: camel._block_t, p_flags: c_uint) camel._key_t;
    pub const add = camel_key_table_add;

    extern fn camel_key_table_lookup(p_ki: *KeyTable, p_keyid: camel._key_t, p_key: *[*:0]u8, p_flags: *c_uint) camel._block_t;
    pub const lookup = camel_key_table_lookup;

    extern fn camel_key_table_next(p_ki: *KeyTable, p_next: camel._key_t, p_keyp: *[*:0]u8, p_flagsp: *c_uint, p_datap: *camel._block_t) camel._key_t;
    pub const next = camel_key_table_next;

    extern fn camel_key_table_set_data(p_ki: *KeyTable, p_keyid: camel._key_t, p_data: camel._block_t) c_int;
    pub const setData = camel_key_table_set_data;

    extern fn camel_key_table_set_flags(p_ki: *KeyTable, p_keyid: camel._key_t, p_flags: c_uint, p_set: c_uint) c_int;
    pub const setFlags = camel_key_table_set_flags;

    extern fn camel_key_table_sync(p_ki: *KeyTable) c_int;
    pub const sync = camel_key_table_sync;

    extern fn camel_key_table_get_type() usize;
    pub const getGObjectType = camel_key_table_get_type;

    extern fn g_object_ref(p_self: *camel.KeyTable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.KeyTable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *KeyTable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const LocalSettings = extern struct {
    pub const Parent = camel.StoreSettings;
    pub const Implements = [_]type{};
    pub const Class = camel.LocalSettingsClass;
    f_parent: camel.StoreSettings,
    f_priv: ?*camel.LocalSettingsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const filter_all = struct {
            pub const name = "filter-all";

            pub const Type = c_int;
        };

        pub const filter_junk = struct {
            pub const name = "filter-junk";

            pub const Type = c_int;
        };

        pub const maildir_alt_flag_sep = struct {
            pub const name = "maildir-alt-flag-sep";

            pub const Type = c_int;
        };

        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `camel.LocalSettings.getPath`.
    /// Use this function when accessing `settings` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_local_settings_dup_path(p_settings: *LocalSettings) [*:0]u8;
    pub const dupPath = camel_local_settings_dup_path;

    /// Returns whether apply filters in all folders.
    extern fn camel_local_settings_get_filter_all(p_settings: *LocalSettings) c_int;
    pub const getFilterAll = camel_local_settings_get_filter_all;

    /// Returns whether to check new messages for junk.
    extern fn camel_local_settings_get_filter_junk(p_settings: *LocalSettings) c_int;
    pub const getFilterJunk = camel_local_settings_get_filter_junk;

    /// Returns, whether the Maildir provider should use alternative
    /// flag separator in the file name. When `TRUE`, uses an exclamation
    /// mark (!), when `FALSE`, uses the colon (:). The default
    /// is `FALSE`, to be consistent with the Maildir specification.
    /// The flag separator is flipped on the Windows build.
    extern fn camel_local_settings_get_maildir_alt_flag_sep(p_settings: *LocalSettings) c_int;
    pub const getMaildirAltFlagSep = camel_local_settings_get_maildir_alt_flag_sep;

    /// Returns the file path to the root of the local mail store.
    extern fn camel_local_settings_get_path(p_settings: *LocalSettings) [*:0]const u8;
    pub const getPath = camel_local_settings_get_path;

    /// Sets whether to apply filters in all folders.
    extern fn camel_local_settings_set_filter_all(p_settings: *LocalSettings, p_filter_all: c_int) void;
    pub const setFilterAll = camel_local_settings_set_filter_all;

    /// Sets whether to check new messages for junk.
    extern fn camel_local_settings_set_filter_junk(p_settings: *LocalSettings, p_filter_junk: c_int) void;
    pub const setFilterJunk = camel_local_settings_set_filter_junk;

    /// Sets whether Maildir should use alternative flag separator.
    /// See `camel.LocalSettings.getMaildirAltFlagSep` for more
    /// information on what it means.
    ///
    /// Note: Change to this setting takes effect only for newly created
    ///     Maildir stores.
    extern fn camel_local_settings_set_maildir_alt_flag_sep(p_settings: *LocalSettings, p_maildir_alt_flag_sep: c_int) void;
    pub const setMaildirAltFlagSep = camel_local_settings_set_maildir_alt_flag_sep;

    /// Sets the file path to the root of the local mail store.  Any
    /// trailing directory separator characters will be stripped off
    /// of the `camel.LocalSettings.properties.path` property.
    extern fn camel_local_settings_set_path(p_settings: *LocalSettings, p_path: [*:0]const u8) void;
    pub const setPath = camel_local_settings_set_path;

    extern fn camel_local_settings_get_type() usize;
    pub const getGObjectType = camel_local_settings_get_type;

    extern fn g_object_ref(p_self: *camel.LocalSettings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.LocalSettings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LocalSettings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Medium = extern struct {
    pub const Parent = camel.DataWrapper;
    pub const Implements = [_]type{};
    pub const Class = camel.MediumClass;
    f_parent: camel.DataWrapper,
    f_priv: ?*camel.MediumPrivate,

    pub const virtual_methods = struct {
        /// Adds a header to a `camel.Medium`.
        pub const add_header = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: [*:0]const u8) void {
                return gobject.ext.as(Medium.Class, p_class).f_add_header.?(gobject.ext.as(Medium, p_medium), p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Medium.Class, p_class).f_add_header = @ptrCast(p_implementation);
            }
        };

        /// Gets an array of all header name/value pairs. The values will be
        /// decoded to UTF-8 for any headers that are recognized by Camel.
        /// See also `camel.Medium.getHeaders`.
        pub const dup_headers = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *camel.NameValueArray {
                return gobject.ext.as(Medium.Class, p_class).f_dup_headers.?(gobject.ext.as(Medium, p_medium));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *camel.NameValueArray) void {
                gobject.ext.as(Medium.Class, p_class).f_dup_headers = @ptrCast(p_implementation);
            }
        };

        /// Gets a data wrapper that represents the content of the medium,
        /// without its headers.
        pub const get_content = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*camel.DataWrapper {
                return gobject.ext.as(Medium.Class, p_class).f_get_content.?(gobject.ext.as(Medium, p_medium));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*camel.DataWrapper) void {
                gobject.ext.as(Medium.Class, p_class).f_get_content = @ptrCast(p_implementation);
            }
        };

        /// Gets the value of the named header in the medium, or `NULL` if
        /// it is unset. The caller should not modify or free the data.
        ///
        /// If the header occurs more than once, only retrieve the first
        /// instance of the header.  For multi-occuring headers, use
        /// `camel.Medium.dupHeaders` or `camel.Medium.getHeaders`.
        pub const get_header = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?[*:0]const u8 {
                return gobject.ext.as(Medium.Class, p_class).f_get_header.?(gobject.ext.as(Medium, p_medium), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Medium.Class, p_class).f_get_header = @ptrCast(p_implementation);
            }
        };

        /// Gets an array of all header name/value pairs. The values will be
        /// decoded to UTF-8 for any headers that are recognized by Camel.
        /// See also `camel.Medium.dupHeaders`.
        pub const get_headers = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *const camel.NameValueArray {
                return gobject.ext.as(Medium.Class, p_class).f_get_headers.?(gobject.ext.as(Medium, p_medium));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *const camel.NameValueArray) void {
                gobject.ext.as(Medium.Class, p_class).f_get_headers = @ptrCast(p_implementation);
            }
        };

        /// Removes the named header from the medium.  All occurances of the
        /// header are removed.
        pub const remove_header = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) void {
                return gobject.ext.as(Medium.Class, p_class).f_remove_header.?(gobject.ext.as(Medium, p_medium), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Medium.Class, p_class).f_remove_header = @ptrCast(p_implementation);
            }
        };

        /// Sets the content of `medium` to be `content`.
        pub const set_content = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_content: ?*camel.DataWrapper) void {
                return gobject.ext.as(Medium.Class, p_class).f_set_content.?(gobject.ext.as(Medium, p_medium), p_content);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_content: ?*camel.DataWrapper) callconv(.c) void) void {
                gobject.ext.as(Medium.Class, p_class).f_set_content = @ptrCast(p_implementation);
            }
        };

        /// Sets the value of a header.  Any other occurances of the header
        /// will be removed.  Setting a `NULL` header can be used to remove
        /// the header also.
        pub const set_header = struct {
            pub fn call(p_class: anytype, p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void {
                return gobject.ext.as(Medium.Class, p_class).f_set_header.?(gobject.ext.as(Medium, p_medium), p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_medium: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Medium.Class, p_class).f_set_header = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*camel.DataWrapper;
        };
    };

    pub const signals = struct {};

    /// Adds a header to a `camel.Medium`.
    extern fn camel_medium_add_header(p_medium: *Medium, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const addHeader = camel_medium_add_header;

    /// Gets an array of all header name/value pairs. The values will be
    /// decoded to UTF-8 for any headers that are recognized by Camel.
    /// See also `camel.Medium.getHeaders`.
    extern fn camel_medium_dup_headers(p_medium: *Medium) *camel.NameValueArray;
    pub const dupHeaders = camel_medium_dup_headers;

    /// Gets a data wrapper that represents the content of the medium,
    /// without its headers.
    extern fn camel_medium_get_content(p_medium: *Medium) ?*camel.DataWrapper;
    pub const getContent = camel_medium_get_content;

    /// Gets the value of the named header in the medium, or `NULL` if
    /// it is unset. The caller should not modify or free the data.
    ///
    /// If the header occurs more than once, only retrieve the first
    /// instance of the header.  For multi-occuring headers, use
    /// `camel.Medium.dupHeaders` or `camel.Medium.getHeaders`.
    extern fn camel_medium_get_header(p_medium: *Medium, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getHeader = camel_medium_get_header;

    /// Gets an array of all header name/value pairs. The values will be
    /// decoded to UTF-8 for any headers that are recognized by Camel.
    /// See also `camel.Medium.dupHeaders`.
    extern fn camel_medium_get_headers(p_medium: *Medium) *const camel.NameValueArray;
    pub const getHeaders = camel_medium_get_headers;

    /// Removes the named header from the medium.  All occurances of the
    /// header are removed.
    extern fn camel_medium_remove_header(p_medium: *Medium, p_name: [*:0]const u8) void;
    pub const removeHeader = camel_medium_remove_header;

    /// Sets the content of `medium` to be `content`.
    extern fn camel_medium_set_content(p_medium: *Medium, p_content: ?*camel.DataWrapper) void;
    pub const setContent = camel_medium_set_content;

    /// Sets the value of a header.  Any other occurances of the header
    /// will be removed.  Setting a `NULL` header can be used to remove
    /// the header also.
    extern fn camel_medium_set_header(p_medium: *Medium, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const setHeader = camel_medium_set_header;

    extern fn camel_medium_get_type() usize;
    pub const getGObjectType = camel_medium_get_type;

    extern fn g_object_ref(p_self: *camel.Medium) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Medium) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Medium, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfo = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.MessageInfoClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.MessageInfoPrivate,

    pub const virtual_methods = struct {
        /// Clones the `mi` as a new `camel.MessageInfo` and eventually assigns
        /// a new `camel.FolderSummary` to it. If it's not set, then the same
        /// summary as the one with `mi` is used.
        pub const clone = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_assign_summary: ?*camel.FolderSummary) *camel.MessageInfo {
                return gobject.ext.as(MessageInfo.Class, p_class).f_clone.?(gobject.ext.as(MessageInfo, p_mi), p_assign_summary);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_assign_summary: ?*camel.FolderSummary) callconv(.c) *camel.MessageInfo) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_clone = @ptrCast(p_implementation);
            }
        };

        pub const dup_user_flags = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*camel.NamedFlags {
                return gobject.ext.as(MessageInfo.Class, p_class).f_dup_user_flags.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*camel.NamedFlags) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_dup_user_flags = @ptrCast(p_implementation);
            }
        };

        pub const dup_user_tags = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*camel.NameValueArray {
                return gobject.ext.as(MessageInfo.Class, p_class).f_dup_user_tags.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*camel.NameValueArray) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_dup_user_tags = @ptrCast(p_implementation);
            }
        };

        pub const get_cc = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_cc.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_cc = @ptrCast(p_implementation);
            }
        };

        pub const get_date_received = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) i64 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_date_received.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) i64) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_date_received = @ptrCast(p_implementation);
            }
        };

        pub const get_date_sent = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) i64 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_date_sent.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) i64) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_date_sent = @ptrCast(p_implementation);
            }
        };

        pub const get_flags = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) u32 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_flags.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) u32) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_flags = @ptrCast(p_implementation);
            }
        };

        pub const get_from = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_from.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_from = @ptrCast(p_implementation);
            }
        };

        pub const get_headers = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*const camel.NameValueArray {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_headers.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*const camel.NameValueArray) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_headers = @ptrCast(p_implementation);
            }
        };

        /// Encoded Message-ID of the associated message as a guint64 number,
        /// partial MD5 sum. The value can be cast to `camel.SummaryMessageID`.
        pub const get_message_id = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) u64 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_message_id.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) u64) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_message_id = @ptrCast(p_implementation);
            }
        };

        pub const get_mlist = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_mlist.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_mlist = @ptrCast(p_implementation);
            }
        };

        pub const get_preview = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?[*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_preview.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_preview = @ptrCast(p_implementation);
            }
        };

        /// Gets encoded In-Reply-To and References headers of the associated
        /// message as an array of guint64 numbers, partial MD5 sums. Each value
        /// can be cast to `camel.SummaryMessageID`.
        pub const get_references = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*const glib.Array {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_references.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*const glib.Array) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_references = @ptrCast(p_implementation);
            }
        };

        pub const get_size = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) u32 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_size.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) u32) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_size = @ptrCast(p_implementation);
            }
        };

        pub const get_subject = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_subject.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_subject = @ptrCast(p_implementation);
            }
        };

        pub const get_to = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_to.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_to = @ptrCast(p_implementation);
            }
        };

        pub const get_user_flag = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_flag.?(gobject.ext.as(MessageInfo, p_mi), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_flag = @ptrCast(p_implementation);
            }
        };

        pub const get_user_flags = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*const camel.NamedFlags {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_flags.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*const camel.NamedFlags) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_flags = @ptrCast(p_implementation);
            }
        };

        pub const get_user_header = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?[*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_header.?(gobject.ext.as(MessageInfo, p_mi), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_header = @ptrCast(p_implementation);
            }
        };

        pub const get_user_headers = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*const camel.NameValueArray {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_headers.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*const camel.NameValueArray) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_headers = @ptrCast(p_implementation);
            }
        };

        pub const get_user_tag = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?[*:0]const u8 {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_tag.?(gobject.ext.as(MessageInfo, p_mi), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_tag = @ptrCast(p_implementation);
            }
        };

        pub const get_user_tags = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*const camel.NameValueArray {
                return gobject.ext.as(MessageInfo.Class, p_class).f_get_user_tags.?(gobject.ext.as(MessageInfo, p_mi));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*const camel.NameValueArray) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_get_user_tags = @ptrCast(p_implementation);
            }
        };

        /// Load content of `mi` from the data stored in `record`. The `bdata_ptr` points
        /// to the current position of the record->bdata, where the read can continue.
        /// Use helper functions `camel.utilBdataGetNumber` and `camel.utilBdataGetString`
        /// to read data from it and also move forward the *bdata_ptr.
        ///
        /// After successful load of the `mi`, the 'dirty' flag is unset.
        pub const load = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_record: ?*const camel.MIRecord, p_bdata_ptr: *[*:0]u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_load.?(gobject.ext.as(MessageInfo, p_mi), p_record, p_bdata_ptr);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_record: ?*const camel.MIRecord, p_bdata_ptr: *[*:0]u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_load = @ptrCast(p_implementation);
            }
        };

        /// Save the `mi` content to the message info record `record`. It can populate all
        /// but the record->bdata value, which is set fro mthe `bdata_str`. Use helper functions
        /// `camel.utilBdataPutNumber` and `camel.utilBdataPutString` to put data into the `bdata_str`.
        pub const save = struct {
            pub fn call(p_class: anytype, p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_record: ?*camel.MIRecord, p_bdata_str: *glib.String) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_save.?(gobject.ext.as(MessageInfo, p_mi), p_record, p_bdata_str);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *const @typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_record: ?*camel.MIRecord, p_bdata_str: *glib.String) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_save = @ptrCast(p_implementation);
            }
        };

        /// Sets CC from the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_cc = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cc: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_cc.?(gobject.ext.as(MessageInfo, p_mi), p_cc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cc: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_cc = @ptrCast(p_implementation);
            }
        };

        /// Sets received date (the Received header) of the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_date_received = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_date_received: i64) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_date_received.?(gobject.ext.as(MessageInfo, p_mi), p_date_received);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_date_received: i64) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_date_received = @ptrCast(p_implementation);
            }
        };

        /// Sets sent date (the Date header) of the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_date_sent = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_date_sent: i64) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_date_sent.?(gobject.ext.as(MessageInfo, p_mi), p_date_sent);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_date_sent: i64) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_date_sent = @ptrCast(p_implementation);
            }
        };

        /// Change the state of the flags on the `mi`. Both `mask` and `set` are bit-or
        /// of `camel.MessageFlags`.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is also emitted
        /// folder's "changed" signal for this `mi`, if necessary. In case
        /// the CAMEL_MESSAGE_FOLDER_FLAGGED flag would be set and the `mi` is
        /// not aborting notifications, the 'folder-flagged-stamp' changes too.
        pub const set_flags = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mask: u32, p_set: u32) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_flags.?(gobject.ext.as(MessageInfo, p_mi), p_mask, p_set);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mask: u32, p_set: u32) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_flags = @ptrCast(p_implementation);
            }
        };

        /// Sets From from the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_from = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_from: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_from.?(gobject.ext.as(MessageInfo, p_mi), p_from);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_from: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_from = @ptrCast(p_implementation);
            }
        };

        /// Sets encoded Message-ID of the associated message as a guint64 number,
        /// partial MD5 sum. The value can be cast to `camel.SummaryMessageID`.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_message_id = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_id: u64) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_message_id.?(gobject.ext.as(MessageInfo, p_mi), p_message_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message_id: u64) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_message_id = @ptrCast(p_implementation);
            }
        };

        /// Sets mesage list address from the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_mlist = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mlist: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_mlist.?(gobject.ext.as(MessageInfo, p_mi), p_mlist);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mlist: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_mlist = @ptrCast(p_implementation);
            }
        };

        /// Set `preview` as the body preview of the associated message. Use `NULL` or an empty
        /// string to unset the value.
        ///
        /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
        /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
        pub const set_preview = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_preview: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_preview.?(gobject.ext.as(MessageInfo, p_mi), p_preview);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_preview: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_preview = @ptrCast(p_implementation);
            }
        };

        /// Sets size of the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_size = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_size: u32) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_size.?(gobject.ext.as(MessageInfo, p_mi), p_size);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_size: u32) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_size = @ptrCast(p_implementation);
            }
        };

        /// Sets Subject from the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_subject = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subject: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_subject.?(gobject.ext.as(MessageInfo, p_mi), p_subject);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subject: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_subject = @ptrCast(p_implementation);
            }
        };

        /// Sets To from the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        pub const set_to = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_to: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_to.?(gobject.ext.as(MessageInfo, p_mi), p_to);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_to: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_to = @ptrCast(p_implementation);
            }
        };

        /// Change `state` of the flag named `name`. Unlike user tags, user flags
        /// can only be set or unset, while the user tags can contain certain values.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is also emitted
        /// folder's "changed" signal for this `mi`, if necessary.
        pub const set_user_flag = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_state: c_int) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_user_flag.?(gobject.ext.as(MessageInfo, p_mi), p_name, p_state);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_state: c_int) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_user_flag = @ptrCast(p_implementation);
            }
        };

        /// Set `value` for a single user-defined message header of the associated message.
        /// When the `value` is `NULL`, the header `name` is removed from the user-defined
        /// headers.
        ///
        /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
        /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
        pub const set_user_header = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_user_header.?(gobject.ext.as(MessageInfo, p_mi), p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_user_header = @ptrCast(p_implementation);
            }
        };

        /// Set user tag `name` to `value`, or remove it, if `value` is `NULL`.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is also emitted
        /// folder's "changed" signal for this `mi`, if necessary.
        pub const set_user_tag = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_set_user_tag.?(gobject.ext.as(MessageInfo, p_mi), p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_set_user_tag = @ptrCast(p_implementation);
            }
        };

        /// Takes headers of the associated message.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        ///
        /// Note that it's not safe to use the `headers` after the call to this function,
        /// because it can be freed due to no change.
        pub const take_headers = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*camel.NameValueArray) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_take_headers.?(gobject.ext.as(MessageInfo, p_mi), p_headers);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*camel.NameValueArray) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_take_headers = @ptrCast(p_implementation);
            }
        };

        /// Takes encoded In-Reply-To and References headers of the associated message
        /// as an array of guint64 numbers, partial MD5 sums. Each value can be
        /// cast to `camel.SummaryMessageID`.
        ///
        /// This property is considered static, in a meaning that it should
        /// not change during the life-time of the `mi`, the same as it doesn't
        /// change in the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is not emitted
        /// folder's "changed" signal for this `mi`.
        ///
        /// Note that it's not safe to use the `references` after the call to this function,
        /// because it can be freed due to no change.
        pub const take_references = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_references: ?*glib.Array) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_take_references.?(gobject.ext.as(MessageInfo, p_mi), p_references);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_references: ?*glib.Array) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_take_references = @ptrCast(p_implementation);
            }
        };

        /// Takes all the `user_flags`, which replaces any current user flags on the `mi`.
        /// The passed-in `user_flags` is consumed by the `mi`, which becomes an owner
        /// of it. The caller should not change `user_flags` afterwards.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is also emitted
        /// folder's "changed" signal for this `mi`, if necessary.
        ///
        /// Note that it's not safe to use the `user_flags` after the call to this function,
        /// because it can be freed due to no change.
        pub const take_user_flags = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_user_flags: ?*camel.NamedFlags) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_take_user_flags.?(gobject.ext.as(MessageInfo, p_mi), p_user_flags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_user_flags: ?*camel.NamedFlags) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_take_user_flags = @ptrCast(p_implementation);
            }
        };

        /// Takes user-defined message headers of the associated message.
        ///
        /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
        /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
        ///
        /// Note that it's not safe to use the `headers` after the call to this function,
        /// because it can be freed due to no change.
        pub const take_user_headers = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*camel.NameValueArray) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_take_user_headers.?(gobject.ext.as(MessageInfo, p_mi), p_headers);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*camel.NameValueArray) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_take_user_headers = @ptrCast(p_implementation);
            }
        };

        /// Takes all the `user_tags`, which replaces any current user tags on the `mi`.
        /// The passed-in `user_tags` is consumed by the `mi`, which becomes an owner
        /// of it. The caller should not change `user_tags` afterwards.
        ///
        /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
        /// set automatically, unless the `mi` is aborting notifications. There is also emitted
        /// folder's "changed" signal for this `mi`, if necessary.
        ///
        /// Note that it's not safe to use the `user_tags` after the call to this function,
        /// because it can be freed due to no change.
        pub const take_user_tags = struct {
            pub fn call(p_class: anytype, p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_user_tags: ?*camel.NameValueArray) c_int {
                return gobject.ext.as(MessageInfo.Class, p_class).f_take_user_tags.?(gobject.ext.as(MessageInfo, p_mi), p_user_tags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mi: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_user_tags: ?*camel.NameValueArray) callconv(.c) c_int) void {
                gobject.ext.as(MessageInfo.Class, p_class).f_take_user_tags = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Flag, whether the info is currently aborting notifications. It is used to avoid
        /// unnecessary 'folder-flagged' and 'dirty' flags changes and also to avoid
        /// associated folder's "changed" signal.
        /// f
        pub const abort_notifications = struct {
            pub const name = "abort-notifications";

            pub const Type = c_int;
        };

        /// CC address of the associated message.
        pub const cc = struct {
            pub const name = "cc";

            pub const Type = ?[*:0]u8;
        };

        /// Received date of the associated message.
        pub const date_received = struct {
            pub const name = "date-received";

            pub const Type = i64;
        };

        /// Sent Date of the associated message.
        pub const date_sent = struct {
            pub const name = "date-sent";

            pub const Type = i64;
        };

        /// Flag, whether the info is changed and requires save to disk.
        /// Compare with CamelMessageInfo:folder-flagged
        pub const dirty = struct {
            pub const name = "dirty";

            pub const Type = c_int;
        };

        /// Bit-or of `camel.MessageFlags`.
        pub const flags = struct {
            pub const name = "flags";

            pub const Type = camel.MessageFlags;
        };

        /// Flag, whether the info is changed and requires save to
        /// the destination store/server. This is different from
        /// the CamelMessageInfo:dirty, which takes care of the local
        /// information only.
        pub const folder_flagged = struct {
            pub const name = "folder-flagged";

            pub const Type = c_int;
        };

        /// The 'folder-flagged-stamp' is a stamp of the 'folder-flagged' flag. This stamp
        /// changes whenever anything would mark the `mi` 'folder-flagged', regardless the `mi`
        /// being already 'folder-flagged'. It can be used to recognize changes
        /// on the 'folder-flagged' flag during the time.
        pub const folder_flagged_stamp = struct {
            pub const name = "folder-flagged-stamp";

            pub const Type = c_uint;
        };

        /// From address of the associated message.
        pub const from = struct {
            pub const name = "from";

            pub const Type = ?[*:0]u8;
        };

        /// Headers of the associated message. Can be `NULL`.
        pub const headers = struct {
            pub const name = "headers";

            pub const Type = ?*camel.NameValueArray;
        };

        /// Encoded Message-ID of the associated message as a guint64 number,
        /// partial MD5 sum. The value can be cast to `camel.SummaryMessageID`.
        pub const message_id = struct {
            pub const name = "message-id";

            pub const Type = u64;
        };

        /// Mailing list address of the associated message.
        pub const mlist = struct {
            pub const name = "mlist";

            pub const Type = ?[*:0]u8;
        };

        /// Body preview of the associated message. Can be `NULL`.
        pub const preview = struct {
            pub const name = "preview";

            pub const Type = ?[*:0]u8;
        };

        /// Encoded In-Reply-To and References headers of the associated message
        /// as an array of guint64 numbers, partial MD5 sums. Each value can be
        /// cast to `camel.SummaryMessageID`.
        pub const references = struct {
            pub const name = "references";

            pub const Type = ?[*]*anyopaque;
        };

        /// Size of the associated message.
        pub const size = struct {
            pub const name = "size";

            pub const Type = c_uint;
        };

        /// Subject of the associated message.
        pub const subject = struct {
            pub const name = "subject";

            pub const Type = ?[*:0]u8;
        };

        /// The `camel.FolderSummary` to which the message info belongs, or `NULL`.
        /// It can be set only during construction of the object.
        pub const summary = struct {
            pub const name = "summary";

            pub const Type = ?*camel.FolderSummary;
        };

        /// To address of the associated message.
        pub const to = struct {
            pub const name = "to";

            pub const Type = ?[*:0]u8;
        };

        /// A unique ID of the message in its folder.
        pub const uid = struct {
            pub const name = "uid";

            pub const Type = ?[*:0]u8;
        };

        /// User flags for the associated message. Can be `NULL`.
        /// Unlike user-tags, which can contain various values, the user-flags
        /// can only be set or not.
        pub const user_flags = struct {
            pub const name = "user-flags";

            pub const Type = ?*camel.NamedFlags;
        };

        /// User-defined headers of the associated message. Can be `NULL`.
        pub const user_headers = struct {
            pub const name = "user-headers";

            pub const Type = ?*camel.NameValueArray;
        };

        /// User tags for the associated message. Can be `NULL`.
        /// Unlike user-flags, which can be set or not, the user-tags
        /// can contain various values.
        pub const user_tags = struct {
            pub const name = "user-tags";

            pub const Type = ?*camel.NameValueArray;
        };
    };

    pub const signals = struct {};

    /// Create a new `camel.MessageInfo` object, optionally for given `summary`.
    extern fn camel_message_info_new(p_summary: ?*camel.FolderSummary) *camel.MessageInfo;
    pub const new = camel_message_info_new;

    /// Create a new `camel.MessageInfo` pre-populated with info from
    /// `headers`.
    extern fn camel_message_info_new_from_headers(p_summary: ?*camel.FolderSummary, p_headers: *const camel.NameValueArray) *camel.MessageInfo;
    pub const newFromHeaders = camel_message_info_new_from_headers;

    /// Create a new `camel.MessageInfo` pre-populated with info from
    /// `message`.
    extern fn camel_message_info_new_from_message(p_summary: ?*camel.FolderSummary, p_message: *camel.MimeMessage) *camel.MessageInfo;
    pub const newFromMessage = camel_message_info_new_from_message;

    /// Clones the `mi` as a new `camel.MessageInfo` and eventually assigns
    /// a new `camel.FolderSummary` to it. If it's not set, then the same
    /// summary as the one with `mi` is used.
    extern fn camel_message_info_clone(p_mi: *const MessageInfo, p_assign_summary: ?*camel.FolderSummary) *camel.MessageInfo;
    pub const clone = camel_message_info_clone;

    /// Dumps the mesasge info `mi` to stdout. This is meand for debugging
    /// purposes only.
    extern fn camel_message_info_dump(p_mi: *MessageInfo) void;
    pub const dump = camel_message_info_dump;

    /// Duplicates array of headers for the `mi`.
    extern fn camel_message_info_dup_headers(p_mi: *const MessageInfo) ?*camel.NameValueArray;
    pub const dupHeaders = camel_message_info_dup_headers;

    extern fn camel_message_info_dup_preview(p_mi: *const MessageInfo) ?[*:0]u8;
    pub const dupPreview = camel_message_info_dup_preview;

    /// Duplicates encoded In-Reply-To and References headers of the associated
    /// message as an array of guint64 numbers, partial MD5 sums. Each value
    /// can be cast to `camel.SummaryMessageID`.
    extern fn camel_message_info_dup_references(p_mi: *const MessageInfo) ?*glib.Array;
    pub const dupReferences = camel_message_info_dup_references;

    extern fn camel_message_info_dup_user_flags(p_mi: *const MessageInfo) ?*camel.NamedFlags;
    pub const dupUserFlags = camel_message_info_dup_user_flags;

    extern fn camel_message_info_dup_user_header(p_mi: *const MessageInfo, p_name: [*:0]const u8) ?[*:0]u8;
    pub const dupUserHeader = camel_message_info_dup_user_header;

    extern fn camel_message_info_dup_user_headers(p_mi: *const MessageInfo) ?*camel.NameValueArray;
    pub const dupUserHeaders = camel_message_info_dup_user_headers;

    extern fn camel_message_info_dup_user_tag(p_mi: *const MessageInfo, p_name: [*:0]const u8) ?[*:0]u8;
    pub const dupUserTag = camel_message_info_dup_user_tag;

    extern fn camel_message_info_dup_user_tags(p_mi: *const MessageInfo) ?*camel.NameValueArray;
    pub const dupUserTags = camel_message_info_dup_user_tags;

    /// Freezes all the notifications until the `camel.MessageInfo.thawNotifications` is called.
    /// This function can be called multiple times, where the last thaw will do the notifications.
    extern fn camel_message_info_freeze_notifications(p_mi: *MessageInfo) void;
    pub const freezeNotifications = camel_message_info_freeze_notifications;

    extern fn camel_message_info_get_abort_notifications(p_mi: *const MessageInfo) c_int;
    pub const getAbortNotifications = camel_message_info_get_abort_notifications;

    extern fn camel_message_info_get_cc(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getCc = camel_message_info_get_cc;

    extern fn camel_message_info_get_date_received(p_mi: *const MessageInfo) i64;
    pub const getDateReceived = camel_message_info_get_date_received;

    extern fn camel_message_info_get_date_sent(p_mi: *const MessageInfo) i64;
    pub const getDateSent = camel_message_info_get_date_sent;

    extern fn camel_message_info_get_dirty(p_mi: *const MessageInfo) c_int;
    pub const getDirty = camel_message_info_get_dirty;

    extern fn camel_message_info_get_flags(p_mi: *const MessageInfo) u32;
    pub const getFlags = camel_message_info_get_flags;

    /// The folder flagged flag is used to mark the message infor as being changed
    /// and this change should be propagated to the remote store (server). This is
    /// different from the 'dirty' flag, which is set for local changes only. It
    /// can happen that the 'folder-flagged' flag is set, but the 'dirty' flag not.
    ///
    /// This is only a convenient wrapper around CAMEL_MESSAGE_FOLDER_FLAGGED flag,
    /// for better readiness of the code.
    extern fn camel_message_info_get_folder_flagged(p_mi: *const MessageInfo) c_int;
    pub const getFolderFlagged = camel_message_info_get_folder_flagged;

    /// The 'folder-flagged-stamp' is a stamp of the 'folder-flagged' flag. This stamp
    /// changes whenever anything would mark the `mi` as 'folder-flagged', regardless
    /// the `mi` being already 'folder-flagged'. It can be used to recognize changes
    /// on the 'folder-flagged' flag during the time.
    extern fn camel_message_info_get_folder_flagged_stamp(p_mi: *const MessageInfo) c_uint;
    pub const getFolderFlaggedStamp = camel_message_info_get_folder_flagged_stamp;

    extern fn camel_message_info_get_from(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getFrom = camel_message_info_get_from;

    extern fn camel_message_info_get_headers(p_mi: *const MessageInfo) ?*const camel.NameValueArray;
    pub const getHeaders = camel_message_info_get_headers;

    /// Encoded Message-ID of the associated message as a guint64 number,
    /// partial MD5 sum. The value can be cast to `camel.SummaryMessageID`.
    extern fn camel_message_info_get_message_id(p_mi: *const MessageInfo) u64;
    pub const getMessageId = camel_message_info_get_message_id;

    extern fn camel_message_info_get_mlist(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getMlist = camel_message_info_get_mlist;

    extern fn camel_message_info_get_notifications_frozen(p_mi: *const MessageInfo) c_int;
    pub const getNotificationsFrozen = camel_message_info_get_notifications_frozen;

    extern fn camel_message_info_get_preview(p_mi: *const MessageInfo) ?[*:0]const u8;
    pub const getPreview = camel_message_info_get_preview;

    /// Gets encoded In-Reply-To and References headers of the associated
    /// message as an array of guint64 numbers, partial MD5 sums. Each value
    /// can be cast to `camel.SummaryMessageID`.
    extern fn camel_message_info_get_references(p_mi: *const MessageInfo) ?*const glib.Array;
    pub const getReferences = camel_message_info_get_references;

    extern fn camel_message_info_get_size(p_mi: *const MessageInfo) u32;
    pub const getSize = camel_message_info_get_size;

    extern fn camel_message_info_get_subject(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getSubject = camel_message_info_get_subject;

    extern fn camel_message_info_get_to(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getTo = camel_message_info_get_to;

    /// Get the UID of the `mi`.
    extern fn camel_message_info_get_uid(p_mi: *const MessageInfo) [*:0]const u8;
    pub const getUid = camel_message_info_get_uid;

    extern fn camel_message_info_get_user_flag(p_mi: *const MessageInfo, p_name: [*:0]const u8) c_int;
    pub const getUserFlag = camel_message_info_get_user_flag;

    extern fn camel_message_info_get_user_flags(p_mi: *const MessageInfo) ?*const camel.NamedFlags;
    pub const getUserFlags = camel_message_info_get_user_flags;

    extern fn camel_message_info_get_user_header(p_mi: *const MessageInfo, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getUserHeader = camel_message_info_get_user_header;

    extern fn camel_message_info_get_user_headers(p_mi: *const MessageInfo) ?*const camel.NameValueArray;
    pub const getUserHeaders = camel_message_info_get_user_headers;

    extern fn camel_message_info_get_user_tag(p_mi: *const MessageInfo, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getUserTag = camel_message_info_get_user_tag;

    extern fn camel_message_info_get_user_tags(p_mi: *const MessageInfo) ?*const camel.NameValueArray;
    pub const getUserTags = camel_message_info_get_user_tags;

    /// Load content of `mi` from the data stored in `record`. The `bdata_ptr` points
    /// to the current position of the record->bdata, where the read can continue.
    /// Use helper functions `camel.utilBdataGetNumber` and `camel.utilBdataGetString`
    /// to read data from it and also move forward the *bdata_ptr.
    ///
    /// After successful load of the `mi`, the 'dirty' flag is unset.
    extern fn camel_message_info_load(p_mi: *MessageInfo, p_record: *const camel.MIRecord, p_bdata_ptr: *[*:0]u8) c_int;
    pub const load = camel_message_info_load;

    /// Get the UID of the `mi`, duplicated on the Camel's string pool.
    /// This is good for thread safety, though the UID should not change once set.
    extern fn camel_message_info_pooldup_uid(p_mi: *const MessageInfo) [*:0]const u8;
    pub const pooldupUid = camel_message_info_pooldup_uid;

    /// Acquires a property lock, which is used to ensure thread safety
    /// when properties are changing. Release the lock with
    /// `camel.MessageInfo.propertyUnlock`.
    ///
    /// Note: Make sure the CamelFolderSummary lock is held before this lock,
    /// if there will be called any 'set' function on the `mi`, to avoid deadlock
    /// when the summary would be set as dirty while another thread might try
    /// to read values from the `mi`, waiting for the property lock and holding
    /// the summary lock at the same time.
    extern fn camel_message_info_property_lock(p_mi: *const MessageInfo) void;
    pub const propertyLock = camel_message_info_property_lock;

    /// Releases a property lock, previously acquired with
    /// `camel.MessageInfo.propertyLock`.
    extern fn camel_message_info_property_unlock(p_mi: *const MessageInfo) void;
    pub const propertyUnlock = camel_message_info_property_unlock;

    extern fn camel_message_info_ref_summary(p_mi: *const MessageInfo) ?*anyopaque;
    pub const refSummary = camel_message_info_ref_summary;

    /// Save the `mi` content to the message info record `record`. It can populate all
    /// but the record->bdata value, which is set fro mthe `bdata_str`. Use helper functions
    /// `camel.utilBdataPutNumber` and `camel.utilBdataPutString` to put data into the `bdata_str`.
    extern fn camel_message_info_save(p_mi: *const MessageInfo, p_record: *camel.MIRecord, p_bdata_str: *glib.String) c_int;
    pub const save = camel_message_info_save;

    /// Marks the `mi` to abort any notifications, which means that it
    /// will not influence 'dirty' and 'folder-flagged' flags in
    /// the set/take functions, neither it will emit any GObject::notify
    /// signals on change, nor associated folder's "changed" signal.
    extern fn camel_message_info_set_abort_notifications(p_mi: *MessageInfo, p_abort_notifications: c_int) void;
    pub const setAbortNotifications = camel_message_info_set_abort_notifications;

    /// Sets CC from the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_cc(p_mi: *MessageInfo, p_cc: ?[*:0]const u8) c_int;
    pub const setCc = camel_message_info_set_cc;

    /// Sets received date (the Received header) of the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_date_received(p_mi: *MessageInfo, p_date_received: i64) c_int;
    pub const setDateReceived = camel_message_info_set_date_received;

    /// Sets sent date (the Date header) of the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_date_sent(p_mi: *MessageInfo, p_date_sent: i64) c_int;
    pub const setDateSent = camel_message_info_set_date_sent;

    /// Marks the `mi` as dirty, which means a save to the local summary
    /// is required.
    extern fn camel_message_info_set_dirty(p_mi: *MessageInfo, p_dirty: c_int) void;
    pub const setDirty = camel_message_info_set_dirty;

    /// Change the state of the flags on the `mi`. Both `mask` and `set` are bit-or
    /// of `camel.MessageFlags`.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is also emitted
    /// folder's "changed" signal for this `mi`, if necessary. In case
    /// the CAMEL_MESSAGE_FOLDER_FLAGGED flag would be set and the `mi` is
    /// not aborting notifications, the 'folder-flagged-stamp' changes too.
    extern fn camel_message_info_set_flags(p_mi: *MessageInfo, p_mask: u32, p_set: u32) c_int;
    pub const setFlags = camel_message_info_set_flags;

    /// Changes the folder-flagged flag to the `folder_flagged` value. See
    /// `camel.MessageInfo.getFolderFlagged` for more information about
    /// the use of this flag.
    ///
    /// This is only a convenient wrapper around CAMEL_MESSAGE_FOLDER_FLAGGED flag,
    /// for better readiness of the code.
    extern fn camel_message_info_set_folder_flagged(p_mi: *MessageInfo, p_folder_flagged: c_int) c_int;
    pub const setFolderFlagged = camel_message_info_set_folder_flagged;

    /// Sets From from the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_from(p_mi: *MessageInfo, p_from: ?[*:0]const u8) c_int;
    pub const setFrom = camel_message_info_set_from;

    /// Sets encoded Message-ID of the associated message as a guint64 number,
    /// partial MD5 sum. The value can be cast to `camel.SummaryMessageID`.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_message_id(p_mi: *MessageInfo, p_message_id: u64) c_int;
    pub const setMessageId = camel_message_info_set_message_id;

    /// Sets mesage list address from the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_mlist(p_mi: *MessageInfo, p_mlist: ?[*:0]const u8) c_int;
    pub const setMlist = camel_message_info_set_mlist;

    /// Set `preview` as the body preview of the associated message. Use `NULL` or an empty
    /// string to unset the value.
    ///
    /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
    /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_preview(p_mi: *MessageInfo, p_preview: ?[*:0]const u8) c_int;
    pub const setPreview = camel_message_info_set_preview;

    /// Sets size of the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_size(p_mi: *MessageInfo, p_size: u32) c_int;
    pub const setSize = camel_message_info_set_size;

    /// Sets Subject from the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_subject(p_mi: *MessageInfo, p_subject: ?[*:0]const u8) c_int;
    pub const setSubject = camel_message_info_set_subject;

    /// Sets To from the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_to(p_mi: *MessageInfo, p_to: ?[*:0]const u8) c_int;
    pub const setTo = camel_message_info_set_to;

    /// Changes UID of the `mi` to `uid`. If it changes, the 'dirty' flag
    /// of the `mi` is set too, unless the `mi` is aborting notifications. This change
    /// does not influence the 'folder-flagged' flag.
    extern fn camel_message_info_set_uid(p_mi: *MessageInfo, p_uid: [*:0]const u8) c_int;
    pub const setUid = camel_message_info_set_uid;

    /// Change `state` of the flag named `name`. Unlike user tags, user flags
    /// can only be set or unset, while the user tags can contain certain values.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is also emitted
    /// folder's "changed" signal for this `mi`, if necessary.
    extern fn camel_message_info_set_user_flag(p_mi: *MessageInfo, p_name: [*:0]const u8, p_state: c_int) c_int;
    pub const setUserFlag = camel_message_info_set_user_flag;

    /// Set `value` for a single user-defined message header of the associated message.
    /// When the `value` is `NULL`, the header `name` is removed from the user-defined
    /// headers.
    ///
    /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
    /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
    extern fn camel_message_info_set_user_header(p_mi: *MessageInfo, p_name: [*:0]const u8, p_value: ?[*:0]const u8) c_int;
    pub const setUserHeader = camel_message_info_set_user_header;

    /// Set user tag `name` to `value`, or remove it, if `value` is `NULL`.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is also emitted
    /// folder's "changed" signal for this `mi`, if necessary.
    extern fn camel_message_info_set_user_tag(p_mi: *MessageInfo, p_name: [*:0]const u8, p_value: ?[*:0]const u8) c_int;
    pub const setUserTag = camel_message_info_set_user_tag;

    /// Takes headers of the associated message.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    ///
    /// Note that it's not safe to use the `headers` after the call to this function,
    /// because it can be freed due to no change.
    extern fn camel_message_info_take_headers(p_mi: *MessageInfo, p_headers: ?*camel.NameValueArray) c_int;
    pub const takeHeaders = camel_message_info_take_headers;

    /// Takes encoded In-Reply-To and References headers of the associated message
    /// as an array of guint64 numbers, partial MD5 sums. Each value can be
    /// cast to `camel.SummaryMessageID`.
    ///
    /// This property is considered static, in a meaning that it should
    /// not change during the life-time of the `mi`, the same as it doesn't
    /// change in the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is not emitted
    /// folder's "changed" signal for this `mi`.
    ///
    /// Note that it's not safe to use the `references` after the call to this function,
    /// because it can be freed due to no change.
    extern fn camel_message_info_take_references(p_mi: *MessageInfo, p_references: ?*glib.Array) c_int;
    pub const takeReferences = camel_message_info_take_references;

    /// Takes all the `user_flags`, which replaces any current user flags on the `mi`.
    /// The passed-in `user_flags` is consumed by the `mi`, which becomes an owner
    /// of it. The caller should not change `user_flags` afterwards.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is also emitted
    /// folder's "changed" signal for this `mi`, if necessary.
    ///
    /// Note that it's not safe to use the `user_flags` after the call to this function,
    /// because it can be freed due to no change.
    extern fn camel_message_info_take_user_flags(p_mi: *MessageInfo, p_user_flags: ?*camel.NamedFlags) c_int;
    pub const takeUserFlags = camel_message_info_take_user_flags;

    /// Takes user-defined message headers of the associated message.
    ///
    /// If the `mi` changed, the 'dirty' flag is set automatically, unless the `mi` is
    /// aborting notifications. There is not emitted folder's "changed" signal for this `mi`.
    ///
    /// Note that it's not safe to use the `headers` after the call to this function,
    /// because it can be freed due to no change.
    extern fn camel_message_info_take_user_headers(p_mi: *MessageInfo, p_headers: ?*camel.NameValueArray) c_int;
    pub const takeUserHeaders = camel_message_info_take_user_headers;

    /// Takes all the `user_tags`, which replaces any current user tags on the `mi`.
    /// The passed-in `user_tags` is consumed by the `mi`, which becomes an owner
    /// of it. The caller should not change `user_tags` afterwards.
    ///
    /// If the `mi` changed, the 'dirty' flag and the 'folder-flagged' flag are
    /// set automatically, unless the `mi` is aborting notifications. There is also emitted
    /// folder's "changed" signal for this `mi`, if necessary.
    ///
    /// Note that it's not safe to use the `user_tags` after the call to this function,
    /// because it can be freed due to no change.
    extern fn camel_message_info_take_user_tags(p_mi: *MessageInfo, p_user_tags: ?*camel.NameValueArray) c_int;
    pub const takeUserTags = camel_message_info_take_user_tags;

    /// Reverses the call of the `camel.MessageInfo.freezeNotifications`.
    /// If this is the last freeze, then the associated folder is also notified
    /// about the change, if any happened during the freeze.
    extern fn camel_message_info_thaw_notifications(p_mi: *MessageInfo) void;
    pub const thawNotifications = camel_message_info_thaw_notifications;

    extern fn camel_message_info_get_type() usize;
    pub const getGObjectType = camel_message_info_get_type;

    extern fn g_object_ref(p_self: *camel.MessageInfo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MessageInfo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MessageInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfoBase = extern struct {
    pub const Parent = camel.MessageInfo;
    pub const Implements = [_]type{};
    pub const Class = camel.MessageInfoBaseClass;
    f_parent: camel.MessageInfo,
    f_priv: ?*camel.MessageInfoBasePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_message_info_base_get_type() usize;
    pub const getGObjectType = camel_message_info_base_get_type;

    extern fn g_object_ref(p_self: *camel.MessageInfoBase) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MessageInfoBase) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MessageInfoBase, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilter = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.MimeFilterPrivate,
    f_outreal: ?[*:0]u8,
    f_outbuf: ?[*:0]u8,
    f_outptr: ?[*:0]u8,
    f_outsize: usize,
    f_outpre: usize,
    f_backbuf: ?[*:0]u8,
    f_backsize: usize,
    f_backlen: usize,

    pub const virtual_methods = struct {
        /// Passes the input buffer, `in`, through `filter` and generates an
        /// output buffer, `out` and makes sure that all data is flushed to the
        /// output buffer. This must be the last filtering call made, no
        /// further calls to `camel.MimeFilter.filter` may be called on `filter`
        /// until `filter` has been reset using `camel.MimeFilter.reset`.
        pub const complete = struct {
            pub fn call(p_class: anytype, p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) void {
                return gobject.ext.as(MimeFilter.Class, p_class).f_complete.?(gobject.ext.as(MimeFilter, p_filter), p_in, p_len, p_prespace, p_out, p_outlen, p_outprespace);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) callconv(.c) void) void {
                gobject.ext.as(MimeFilter.Class, p_class).f_complete = @ptrCast(p_implementation);
            }
        };

        /// Passes the input buffer, `in`, through `filter` and generates an
        /// output buffer, `out`.
        pub const filter = struct {
            pub fn call(p_class: anytype, p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) void {
                return gobject.ext.as(MimeFilter.Class, p_class).f_filter.?(gobject.ext.as(MimeFilter, p_filter), p_in, p_len, p_prespace, p_out, p_outlen, p_outprespace);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) callconv(.c) void) void {
                gobject.ext.as(MimeFilter.Class, p_class).f_filter = @ptrCast(p_implementation);
            }
        };

        /// Resets the state on `filter` so that it may be used again.
        pub const reset = struct {
            pub fn call(p_class: anytype, p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(MimeFilter.Class, p_class).f_reset.?(gobject.ext.as(MimeFilter, p_filter));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(MimeFilter.Class, p_class).f_reset = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilter` object.
    extern fn camel_mime_filter_new() *camel.MimeFilter;
    pub const new = camel_mime_filter_new;

    /// Saves `data` to be used as prespace input data to the next call to
    /// `camel.MimeFilter.filter` or `camel.MimeFilter.complete`.
    ///
    /// Note: New calls replace old data.
    extern fn camel_mime_filter_backup(p_filter: *MimeFilter, p_data: [*]const u8, p_length: usize) void;
    pub const backup = camel_mime_filter_backup;

    /// Passes the input buffer, `in`, through `filter` and generates an
    /// output buffer, `out` and makes sure that all data is flushed to the
    /// output buffer. This must be the last filtering call made, no
    /// further calls to `camel.MimeFilter.filter` may be called on `filter`
    /// until `filter` has been reset using `camel.MimeFilter.reset`.
    extern fn camel_mime_filter_complete(p_filter: *MimeFilter, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) void;
    pub const complete = camel_mime_filter_complete;

    /// Passes the input buffer, `in`, through `filter` and generates an
    /// output buffer, `out`.
    extern fn camel_mime_filter_filter(p_filter: *MimeFilter, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) void;
    pub const filter = camel_mime_filter_filter;

    /// Returns whether the `filter` requested stop further processing
    /// with `camel.MimeFilter.setRequestStop`.
    extern fn camel_mime_filter_get_request_stop(p_filter: *MimeFilter) c_int;
    pub const getRequestStop = camel_mime_filter_get_request_stop;

    /// Resets the state on `filter` so that it may be used again.
    extern fn camel_mime_filter_reset(p_filter: *MimeFilter) void;
    pub const reset = camel_mime_filter_reset;

    /// Sets whether the `filter` requests, or not, stop further processing.
    /// This can be used to stop before all the data is filtered.
    extern fn camel_mime_filter_set_request_stop(p_filter: *MimeFilter, p_request_stop: c_int) void;
    pub const setRequestStop = camel_mime_filter_set_request_stop;

    /// Ensure that `filter` has enough storage space to store `size` bytes
    /// for filter output.
    extern fn camel_mime_filter_set_size(p_filter: *MimeFilter, p_size: usize, p_keep: c_int) void;
    pub const setSize = camel_mime_filter_set_size;

    extern fn camel_mime_filter_get_type() usize;
    pub const getGObjectType = camel_mime_filter_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBasic = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterBasicClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterBasicPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterBasic` object of type `type`.
    extern fn camel_mime_filter_basic_new(p_type: camel.MimeFilterBasicType) *camel.MimeFilterBasic;
    pub const new = camel_mime_filter_basic_new;

    extern fn camel_mime_filter_basic_get_type() usize;
    pub const getGObjectType = camel_mime_filter_basic_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterBasic) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterBasic) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterBasic, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBestenc = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterBestencClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterBestencPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterBestenc` object.
    extern fn camel_mime_filter_bestenc_new(p_flags: c_uint) *camel.MimeFilterBestenc;
    pub const new = camel_mime_filter_bestenc_new;

    /// Gets the best charset that can be used to contain this content.
    extern fn camel_mime_filter_bestenc_get_best_charset(p_filter: *MimeFilterBestenc) [*:0]const u8;
    pub const getBestCharset = camel_mime_filter_bestenc_get_best_charset;

    /// Get the best encoding, given specific constraints, that can be used to
    /// encode a stream of bytes.
    extern fn camel_mime_filter_bestenc_get_best_encoding(p_filter: *MimeFilterBestenc, p_required: camel.BestencEncoding) camel.TransferEncoding;
    pub const getBestEncoding = camel_mime_filter_bestenc_get_best_encoding;

    /// Set the flags for subsequent operations.
    extern fn camel_mime_filter_bestenc_set_flags(p_filter: *MimeFilterBestenc, p_flags: c_uint) void;
    pub const setFlags = camel_mime_filter_bestenc_set_flags;

    extern fn camel_mime_filter_bestenc_get_type() usize;
    pub const getGObjectType = camel_mime_filter_bestenc_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterBestenc) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterBestenc) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterBestenc, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCRLF = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterCRLFClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterCRLFPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterCRLF` object.
    extern fn camel_mime_filter_crlf_new(p_direction: camel.MimeFilterCRLFDirection, p_mode: camel.MimeFilterCRLFMode) *camel.MimeFilterCRLF;
    pub const new = camel_mime_filter_crlf_new;

    extern fn camel_mime_filter_crlf_get_ensure_crlf_end(p_filter: *MimeFilterCRLF) c_int;
    pub const getEnsureCrlfEnd = camel_mime_filter_crlf_get_ensure_crlf_end;

    /// When set to true, the filter will ensure that the output stream will
    /// end with CRLF, in case it does not. The default is to not do that.
    /// The option is used only when encoding the stream.
    extern fn camel_mime_filter_crlf_set_ensure_crlf_end(p_filter: *MimeFilterCRLF, p_ensure_crlf_end: c_int) void;
    pub const setEnsureCrlfEnd = camel_mime_filter_crlf_set_ensure_crlf_end;

    extern fn camel_mime_filter_crlf_get_type() usize;
    pub const getGObjectType = camel_mime_filter_crlf_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterCRLF) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterCRLF) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterCRLF, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCanon = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterCanonClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterCanonPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new filter to canonicalise an input stream.
    extern fn camel_mime_filter_canon_new(p_flags: u32) *camel.MimeFilterCanon;
    pub const new = camel_mime_filter_canon_new;

    extern fn camel_mime_filter_canon_get_type() usize;
    pub const getGObjectType = camel_mime_filter_canon_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterCanon) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterCanon) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterCanon, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCharset = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterCharsetClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterCharsetPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterCharset` object to convert text from
    /// `from_charset` to `to_charset`.
    extern fn camel_mime_filter_charset_new(p_from_charset: [*:0]const u8, p_to_charset: [*:0]const u8) *camel.MimeFilterCharset;
    pub const new = camel_mime_filter_charset_new;

    extern fn camel_mime_filter_charset_get_type() usize;
    pub const getGObjectType = camel_mime_filter_charset_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterCharset) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterCharset) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterCharset, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterEnriched = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterEnrichedClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterEnrichedPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterEnriched` object to convert input text
    /// streams from text/plain into text/enriched or text/richtext.
    extern fn camel_mime_filter_enriched_new(p_flags: u32) *camel.MimeFilterEnriched;
    pub const new = camel_mime_filter_enriched_new;

    extern fn camel_mime_filter_enriched_get_type() usize;
    pub const getGObjectType = camel_mime_filter_enriched_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterEnriched) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterEnriched) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterEnriched, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterFrom = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterFromClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterFromPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterFrom` object.
    extern fn camel_mime_filter_from_new() *camel.MimeFilterFrom;
    pub const new = camel_mime_filter_from_new;

    extern fn camel_mime_filter_from_get_type() usize;
    pub const getGObjectType = camel_mime_filter_from_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterFrom) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterFrom) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterFrom, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterGZip = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterGZipClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterGZipPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new gzip (or gunzip) filter.
    extern fn camel_mime_filter_gzip_new(p_mode: camel.MimeFilterGZipMode, p_level: c_int) *camel.MimeFilterGZip;
    pub const new = camel_mime_filter_gzip_new;

    extern fn camel_mime_filter_gzip_get_type() usize;
    pub const getGObjectType = camel_mime_filter_gzip_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterGZip) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterGZip) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterGZip, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterHTML = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterHTMLClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterHTMLPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterHTML` object.
    extern fn camel_mime_filter_html_new() *camel.MimeFilterHTML;
    pub const new = camel_mime_filter_html_new;

    extern fn camel_mime_filter_html_get_type() usize;
    pub const getGObjectType = camel_mime_filter_html_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterHTML) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterHTML) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterHTML, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterIndex = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterIndexClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterIndexPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterIndex` based on `index`.
    extern fn camel_mime_filter_index_new(p_index: *camel.Index) *camel.MimeFilterIndex;
    pub const new = camel_mime_filter_index_new;

    /// Set `index` on `filter`.
    extern fn camel_mime_filter_index_set_index(p_filter: *MimeFilterIndex, p_index: *camel.Index) void;
    pub const setIndex = camel_mime_filter_index_set_index;

    /// Set the match name for any indexed words.
    extern fn camel_mime_filter_index_set_name(p_filter: *MimeFilterIndex, p_name: *camel.IndexName) void;
    pub const setName = camel_mime_filter_index_set_name;

    extern fn camel_mime_filter_index_get_type() usize;
    pub const getGObjectType = camel_mime_filter_index_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterIndex) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterIndex) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterIndex, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterLinewrap = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterLinewrapClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterLinewrapPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_mime_filter_linewrap_new(p_preferred_len: c_uint, p_max_len: c_uint, p_indent_char: u8, p_flags: u32) *camel.MimeFilterLinewrap;
    pub const new = camel_mime_filter_linewrap_new;

    extern fn camel_mime_filter_linewrap_get_type() usize;
    pub const getGObjectType = camel_mime_filter_linewrap_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterLinewrap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterLinewrap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterLinewrap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPgp = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterPgpClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterPgpPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_mime_filter_pgp_new() *camel.MimeFilterPgp;
    pub const new = camel_mime_filter_pgp_new;

    extern fn camel_mime_filter_pgp_get_type() usize;
    pub const getGObjectType = camel_mime_filter_pgp_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterPgp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterPgp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterPgp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPreview = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterPreviewClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterPreviewPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `camel.MimeFilterPreview` object. It filters passed-in
    /// data into a text suitable for a message content preview.
    extern fn camel_mime_filter_preview_new(p_limit: c_uint) *camel.MimeFilterPreview;
    pub const new = camel_mime_filter_preview_new;

    /// Returns set limit for the text length, in characters.
    /// Zero means unlimited length.
    extern fn camel_mime_filter_preview_get_limit(p_self: *MimeFilterPreview) c_uint;
    pub const getLimit = camel_mime_filter_preview_get_limit;

    /// Returns read text until now.
    extern fn camel_mime_filter_preview_get_text(p_self: *MimeFilterPreview) ?[*:0]const u8;
    pub const getText = camel_mime_filter_preview_get_text;

    /// Sets limit for the text length, in characters. Zero
    /// means unlimited length.
    extern fn camel_mime_filter_preview_set_limit(p_self: *MimeFilterPreview, p_limit: c_uint) void;
    pub const setLimit = camel_mime_filter_preview_set_limit;

    extern fn camel_mime_filter_preview_get_type() usize;
    pub const getGObjectType = camel_mime_filter_preview_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterPreview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterPreview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterPreview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterProgress = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterProgressClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterProgressPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterProgress` object that will report streaming
    /// progress.  While the function will silently accept `cancellable` being
    /// `NULL` or a plain `gio.Cancellable` for convenience sake, no progress will be
    /// reported unless `cancellable` is a `camel.Operation`.
    extern fn camel_mime_filter_progress_new(p_cancellable: ?*gio.Cancellable, p_total: usize) *camel.MimeFilterProgress;
    pub const new = camel_mime_filter_progress_new;

    extern fn camel_mime_filter_progress_get_type() usize;
    pub const getGObjectType = camel_mime_filter_progress_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterProgress) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterProgress) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterProgress, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterToHTML = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterToHTMLClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterToHTMLPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterToHTML` object to convert plain text
    /// into HTML.
    extern fn camel_mime_filter_tohtml_new(p_flags: camel.MimeFilterToHTMLFlags, p_color: u32) *camel.MimeFilterToHTML;
    pub const new = camel_mime_filter_tohtml_new;

    extern fn camel_mime_filter_tohtml_get_type() usize;
    pub const getGObjectType = camel_mime_filter_tohtml_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterToHTML) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterToHTML) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterToHTML, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterWindows = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterWindowsClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterWindowsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterWindows` object that will analyse
    /// whether or not the text is really encoded in `claimed_charset`.
    extern fn camel_mime_filter_windows_new(p_claimed_charset: [*:0]const u8) *camel.MimeFilterWindows;
    pub const new = camel_mime_filter_windows_new;

    /// Get whether or not the textual content filtered by `filter` is
    /// really in a Microsoft Windows charset rather than the claimed ISO
    /// charset.
    extern fn camel_mime_filter_windows_is_windows_charset(p_filter: *MimeFilterWindows) c_int;
    pub const isWindowsCharset = camel_mime_filter_windows_is_windows_charset;

    /// Get the name of the actual charset used to encode the textual
    /// content filtered by `filter` (it will either be the original
    /// claimed_charset passed in at creation time or the Windows-CP125x
    /// equivalent).
    extern fn camel_mime_filter_windows_real_charset(p_filter: *MimeFilterWindows) [*:0]const u8;
    pub const realCharset = camel_mime_filter_windows_real_charset;

    extern fn camel_mime_filter_windows_get_type() usize;
    pub const getGObjectType = camel_mime_filter_windows_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterWindows) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterWindows) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterWindows, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterYenc = extern struct {
    pub const Parent = camel.MimeFilter;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeFilterYencClass;
    f_parent: camel.MimeFilter,
    f_priv: ?*camel.MimeFilterYencPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeFilterYenc` filter object.
    extern fn camel_mime_filter_yenc_new(p_direction: camel.MimeFilterYencDirection) *camel.MimeFilterYenc;
    pub const new = camel_mime_filter_yenc_new;

    /// Get the computed crc or (`guint32`) -1 on fail.
    extern fn camel_mime_filter_yenc_get_crc(p_yenc: *MimeFilterYenc) u32;
    pub const getCrc = camel_mime_filter_yenc_get_crc;

    /// Get the computed part crc or (`guint32`) -1 on fail.
    extern fn camel_mime_filter_yenc_get_pcrc(p_yenc: *MimeFilterYenc) u32;
    pub const getPcrc = camel_mime_filter_yenc_get_pcrc;

    /// Sets the current crc32 value on the yEnc filter `yenc` to `crc`.
    extern fn camel_mime_filter_yenc_set_crc(p_yenc: *MimeFilterYenc, p_crc: u32) void;
    pub const setCrc = camel_mime_filter_yenc_set_crc;

    /// Sets the current state of the yencoder/ydecoder
    extern fn camel_mime_filter_yenc_set_state(p_yenc: *MimeFilterYenc, p_state: c_int) void;
    pub const setState = camel_mime_filter_yenc_set_state;

    extern fn camel_mime_filter_yenc_get_type() usize;
    pub const getGObjectType = camel_mime_filter_yenc_get_type;

    extern fn g_object_ref(p_self: *camel.MimeFilterYenc) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeFilterYenc) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeFilterYenc, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeMessage = extern struct {
    pub const Parent = camel.MimePart;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeMessageClass;
    f_parent: camel.MimePart,
    f_priv: ?*camel.MimeMessagePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MimeMessage` object.
    extern fn camel_mime_message_new() *camel.MimeMessage;
    pub const new = camel_mime_message_new;

    /// Build an MBox from-line from `message`.
    extern fn camel_mime_message_build_mbox_from(p_message: *MimeMessage) [*:0]u8;
    pub const buildMboxFrom = camel_mime_message_build_mbox_from;

    /// Dump information about the mime message to stdout.
    ///
    /// If body is TRUE, then dump body content of the message as well.
    extern fn camel_mime_message_dump(p_message: *MimeMessage, p_body: c_int) void;
    pub const dump = camel_mime_message_dump;

    /// Encode all message parts to a suitable transfer encoding for transport (7bit clean).
    extern fn camel_mime_message_encode_8bit_parts(p_message: *MimeMessage) void;
    pub const encode8bitParts = camel_mime_message_encode_8bit_parts;

    /// Calls `callback` for each part of the `message`, including the message itself.
    /// The traverse of the `message` parts can be stopped when the `callback`
    /// returns `FALSE`.
    extern fn camel_mime_message_foreach_part(p_message: *MimeMessage, p_callback: camel.ForeachPartFunc, p_user_data: ?*anyopaque) void;
    pub const foreachPart = camel_mime_message_foreach_part;

    /// Get the date and UTC offset of a message.
    /// See `camel.MimeMessage.setDate` for information about the `offset` format.
    extern fn camel_mime_message_get_date(p_message: *MimeMessage, p_offset: *c_int) std.posix.time_t;
    pub const getDate = camel_mime_message_get_date;

    /// Get the received date and UTC offset of a message.
    /// See `camel.MimeMessage.setDate` for information about the `offset` format.
    extern fn camel_mime_message_get_date_received(p_message: *MimeMessage, p_offset: *c_int) std.posix.time_t;
    pub const getDateReceived = camel_mime_message_get_date_received;

    /// Get the from address of a message.
    extern fn camel_mime_message_get_from(p_message: *MimeMessage) ?*camel.InternetAddress;
    pub const getFrom = camel_mime_message_get_from;

    /// Get the message-id of a message.
    extern fn camel_mime_message_get_message_id(p_message: *MimeMessage) ?[*:0]const u8;
    pub const getMessageId = camel_mime_message_get_message_id;

    /// Get a MIME part by id from a message.
    extern fn camel_mime_message_get_part_by_content_id(p_message: *MimeMessage, p_content_id: [*:0]const u8) ?*camel.MimePart;
    pub const getPartByContentId = camel_mime_message_get_part_by_content_id;

    /// Get the message recipients of a specified type.
    extern fn camel_mime_message_get_recipients(p_message: *MimeMessage, p_type: [*:0]const u8) ?*camel.InternetAddress;
    pub const getRecipients = camel_mime_message_get_recipients;

    /// Get the Reply-To of a message.
    extern fn camel_mime_message_get_reply_to(p_message: *MimeMessage) ?*camel.InternetAddress;
    pub const getReplyTo = camel_mime_message_get_reply_to;

    /// Get the UID of the source account of the message.
    extern fn camel_mime_message_get_source(p_message: *MimeMessage) ?[*:0]const u8;
    pub const getSource = camel_mime_message_get_source;

    /// Get the UTF-8 subject text of a message.
    extern fn camel_mime_message_get_subject(p_message: *MimeMessage) ?[*:0]const u8;
    pub const getSubject = camel_mime_message_get_subject;

    /// Find out if a message contains 8bit or binary encoded parts.
    extern fn camel_mime_message_has_8bit_parts(p_message: *MimeMessage) c_int;
    pub const has8bitParts = camel_mime_message_has_8bit_parts;

    /// Returns whether message contains at least one attachment part.
    extern fn camel_mime_message_has_attachment(p_message: *MimeMessage) c_int;
    pub const hasAttachment = camel_mime_message_has_attachment;

    /// Re-encode all message parts to conform with the required encoding rules.
    ///
    /// If `enctype` is `CAMEL_BESTENC_7BIT`, then all parts will be re-encoded into
    /// one of the 7bit transfer encodings. If `enctype` is `CAMEL_BESTENC_8BIT`, all
    /// parts will be re-encoded to either a 7bit encoding or, if the part is 8bit
    /// text, allowed to stay 8bit. If `enctype` is `CAMEL_BESTENC_BINARY`, then binary
    /// parts will be encoded as binary and 8bit textual parts will be encoded as 8bit.
    extern fn camel_mime_message_set_best_encoding(p_message: *MimeMessage, p_required: camel.BestencRequired, p_enctype: camel.BestencEncoding) void;
    pub const setBestEncoding = camel_mime_message_set_best_encoding;

    /// Set the date on a message.
    ///
    /// In most cases, this is used to set the current date:
    /// ```
    /// camel_mime_message_set_date (message, CAMEL_MESSAGE_DATE_CURRENT, 0);
    /// ```
    extern fn camel_mime_message_set_date(p_message: *MimeMessage, p_date: std.posix.time_t, p_offset: c_int) void;
    pub const setDate = camel_mime_message_set_date;

    /// Set the from address of a message.
    extern fn camel_mime_message_set_from(p_message: *MimeMessage, p_from: ?*camel.InternetAddress) void;
    pub const setFrom = camel_mime_message_set_from;

    /// Set the message-id on a message.
    extern fn camel_mime_message_set_message_id(p_message: *MimeMessage, p_message_id: ?[*:0]const u8) void;
    pub const setMessageId = camel_mime_message_set_message_id;

    /// Set the recipients of a message.
    extern fn camel_mime_message_set_recipients(p_message: *MimeMessage, p_type: [*:0]const u8, p_recipients: ?*camel.InternetAddress) void;
    pub const setRecipients = camel_mime_message_set_recipients;

    /// Set the Reply-To of a message.
    extern fn camel_mime_message_set_reply_to(p_message: *MimeMessage, p_reply_to: ?*camel.InternetAddress) void;
    pub const setReplyTo = camel_mime_message_set_reply_to;

    /// Set the UID of the source account of the message.
    extern fn camel_mime_message_set_source(p_message: *MimeMessage, p_source_uid: ?[*:0]const u8) void;
    pub const setSource = camel_mime_message_set_source;

    /// Set the subject text of a message.
    extern fn camel_mime_message_set_subject(p_message: *MimeMessage, p_subject: ?[*:0]const u8) void;
    pub const setSubject = camel_mime_message_set_subject;

    extern fn camel_mime_message_get_type() usize;
    pub const getGObjectType = camel_mime_message_get_type;

    extern fn g_object_ref(p_self: *camel.MimeMessage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeMessage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeMessage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeParser = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.MimeParserClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.MimeParserPrivate,

    pub const virtual_methods = struct {
        pub const content = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(MimeParser.Class, p_class).f_content.?(gobject.ext.as(MimeParser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(MimeParser.Class, p_class).f_content = @ptrCast(p_implementation);
            }
        };

        pub const message = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*anyopaque) void {
                return gobject.ext.as(MimeParser.Class, p_class).f_message.?(gobject.ext.as(MimeParser, p_parser), p_headers);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_headers: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(MimeParser.Class, p_class).f_message = @ptrCast(p_implementation);
            }
        };

        pub const part = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(MimeParser.Class, p_class).f_part.?(gobject.ext.as(MimeParser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(MimeParser.Class, p_class).f_part = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new CamelMimeParser object.
    extern fn camel_mime_parser_new() *camel.MimeParser;
    pub const new = camel_mime_parser_new;

    /// Get the content type defined in the current part.
    extern fn camel_mime_parser_content_type(p_parser: *MimeParser) ?*camel.ContentType;
    pub const contentType = camel_mime_parser_content_type;

    /// Drop the last step call.  This should only be used
    /// in conjunction with seeking of the stream as the
    /// stream may be in an undefined state relative to the
    /// state of the parser.
    ///
    /// Use this call with care.
    extern fn camel_mime_parser_drop_step(p_parser: *MimeParser) void;
    pub const dropStep = camel_mime_parser_drop_step;

    /// Get the list of the raw headers which are defined for the
    /// current state of the parser.  These headers are valid
    /// until the next call to `camel.MimeParser.step`, or `camel.MimeParser.dropStep`.
    extern fn camel_mime_parser_dup_headers(p_m: *MimeParser) ?*camel.NameValueArray;
    pub const dupHeaders = camel_mime_parser_dup_headers;

    extern fn camel_mime_parser_errno(p_parser: *MimeParser) c_int;
    pub const errno = camel_mime_parser_errno;

    /// Add a filter that will be applied to any body content before it is passed
    /// to the caller.  Filters may be pipelined to perform multi-pass operations
    /// on the content, and are applied in the order they were added.
    ///
    /// Note that filters are only applied to the body content of messages, and once
    /// a filter has been set, all content returned by a `camel.MimeParser.step`
    /// with a state of CAMEL_MIME_PARSER_STATE_BODY will have passed through the
    /// filter.
    extern fn camel_mime_parser_filter_add(p_m: *MimeParser, p_mf: *camel.MimeFilter) c_int;
    pub const filterAdd = camel_mime_parser_filter_add;

    /// Remove a processing filter from the pipeline.  There is no
    /// restriction on the order the filters can be removed.
    extern fn camel_mime_parser_filter_remove(p_m: *MimeParser, p_id: c_int) void;
    pub const filterRemove = camel_mime_parser_filter_remove;

    /// Get the last scanned "From " line, from a recently scanned from.
    /// This should only be called in the CAMEL_MIME_PARSER_STATE_FROM state.  The
    /// from line will include the closing \n found (if there was one).
    ///
    /// The return value will remain valid while in the CAMEL_MIME_PARSER_STATE_FROM
    /// state, or any deeper state.
    extern fn camel_mime_parser_from_line(p_m: *MimeParser) ?[*:0]const u8;
    pub const fromLine = camel_mime_parser_from_line;

    /// Lookup a header by name.
    extern fn camel_mime_parser_header(p_m: *MimeParser, p_name: [*:0]const u8, p_offset: *c_int) ?[*:0]const u8;
    pub const header = camel_mime_parser_header;

    /// Convenience function creates a `gio.MemoryInputStream` from `bytes` and hands
    /// it off to `camel.MimeParser.initWithInputStream`.
    extern fn camel_mime_parser_init_with_bytes(p_parser: *MimeParser, p_bytes: *glib.Bytes) void;
    pub const initWithBytes = camel_mime_parser_init_with_bytes;

    /// Initialise the scanner with an fd.  The scanner's offsets
    /// will be relative to the current file position of the file
    /// descriptor.  As a result, seekable descritors should
    /// be seeked using the parser seek functions.
    extern fn camel_mime_parser_init_with_fd(p_m: *MimeParser, p_fd: c_int) c_int;
    pub const initWithFd = camel_mime_parser_init_with_fd;

    /// Initialize the scanner with `input_stream`.  The scanner's offsets will
    /// be relative to the current file position of the stream.  As a result,
    /// seekable streams should only be seeked using the parser seek function.
    extern fn camel_mime_parser_init_with_input_stream(p_parser: *MimeParser, p_input_stream: *gio.InputStream) void;
    pub const initWithInputStream = camel_mime_parser_init_with_input_stream;

    /// Initialise the scanner with a source stream.  The scanner's
    /// offsets will be relative to the current file position of
    /// the stream.  As a result, seekable streams should only
    /// be seeked using the parser seek function.
    extern fn camel_mime_parser_init_with_stream(p_m: *MimeParser, p_stream: *camel.Stream, p_error: ?*?*glib.Error) c_int;
    pub const initWithStream = camel_mime_parser_init_with_stream;

    /// Retrieve the postface text for the current multipart.
    /// Only returns valid data when the current state if
    /// CAMEL_MIME_PARSER_STATE_MULTIPART_END.
    extern fn camel_mime_parser_postface(p_m: *MimeParser) ?[*:0]const u8;
    pub const postface = camel_mime_parser_postface;

    /// Retrieve the preface text for the current multipart.
    /// Can only be used when the state is CAMEL_MIME_PARSER_STATE_MULTIPART_END.
    extern fn camel_mime_parser_preface(p_m: *MimeParser) ?[*:0]const u8;
    pub const preface = camel_mime_parser_preface;

    /// Pre-load a new parser state.  Used to post-parse multipart content
    /// without headers.
    extern fn camel_mime_parser_push_state(p_mp: *MimeParser, p_newstate: camel.MimeParserState, p_boundary: [*:0]const u8) void;
    pub const pushState = camel_mime_parser_push_state;

    /// Read at most `len` bytes from the internal mime parser buffer.
    ///
    /// Returns the address of the internal buffer in `databuffer`,
    /// and the length of useful data.
    ///
    /// `len` may be specified as `G_MAXSSIZE`, in which case you will
    /// get the full remainder of the buffer at each call.
    ///
    /// Note that no parsing of the data read through this function
    /// occurs, so no state changes occur, but the seek position
    /// is updated appropriately.
    extern fn camel_mime_parser_read(p_parser: *MimeParser, p_databuffer: *[*]const u8, p_len: isize, p_error: ?*?*glib.Error) isize;
    pub const read = camel_mime_parser_read;

    /// Tell the scanner if it should scan "^From " lines or not.
    ///
    /// If the scanner is scanning from lines, two additional
    /// states CAMEL_MIME_PARSER_STATE_FROM and CAMEL_MIME_PARSER_STATE_FROM_END will be returned
    /// to the caller during parsing.
    ///
    /// This may also be preceeded by an optional
    /// CAMEL_MIME_PARSER_STATE_PRE_FROM state which contains the scanned data
    /// found before the From line is encountered.  See also
    /// `camel.MimeParser.scanPreFrom`.
    extern fn camel_mime_parser_scan_from(p_parser: *MimeParser, p_scan_from: c_int) void;
    pub const scanFrom = camel_mime_parser_scan_from;

    /// Tell the scanner whether we want to know abou the pre-from
    /// data during a scan.  If we do, then we may get an additional
    /// state CAMEL_MIME_PARSER_STATE_PRE_FROM which returns the specified data.
    extern fn camel_mime_parser_scan_pre_from(p_parser: *MimeParser, p_scan_pre_from: c_int) void;
    pub const scanPreFrom = camel_mime_parser_scan_pre_from;

    /// Reset the source position to a known value.
    ///
    /// Note that if the source stream/descriptor was not
    /// positioned at 0 to begin with, and an absolute seek
    /// is specified (whence != SEEK_CUR), then the seek
    /// position may not match the desired seek position.
    extern fn camel_mime_parser_seek(p_parser: *MimeParser, p_offset: i64, p_whence: c_int) i64;
    pub const seek = camel_mime_parser_seek;

    extern fn camel_mime_parser_set_header_regex(p_parser: *MimeParser, p_matchstr: [*:0]u8) c_int;
    pub const setHeaderRegex = camel_mime_parser_set_header_regex;

    /// Get the current parser state.
    extern fn camel_mime_parser_state(p_parser: *MimeParser) camel.MimeParserState;
    pub const state = camel_mime_parser_state;

    /// Parse the next part of the MIME message.  If `camel.MimeParser.unstep`
    /// has been called, then continue to return the same state
    /// for that many calls.
    ///
    /// If the step is CAMEL_MIME_PARSER_STATE_BODY then the databuffer and datalength
    /// pointers will be setup to point to the internal data buffer
    /// of the scanner and may be processed as required.  Any
    /// filters will have already been applied to this data.
    ///
    /// Refer to the state diagram elsewhere for a full listing of
    /// the states an application is gauranteed to get from the
    /// scanner.
    extern fn camel_mime_parser_step(p_parser: *MimeParser, p_databuffer: ?*[*]u8, p_datalength: ?*usize) camel.MimeParserState;
    pub const step = camel_mime_parser_step;

    /// Get the stream, if any, the parser has been initialised
    /// with.  May be used to setup sub-streams, but should not
    /// be read from directly (without saving and restoring
    /// the seek position in between).
    extern fn camel_mime_parser_stream(p_parser: *MimeParser) ?*camel.Stream;
    pub const stream = camel_mime_parser_stream;

    /// Return the current scanning offset.  The meaning of this
    /// value will depend on the current state of the parser.
    ///
    /// An incomplete listing of the states:
    ///
    /// CAMEL_MIME_PARSER_STATE_INITIAL, The start of the current message.
    /// CAMEL_MIME_PARSER_STATE_HEADER, CAMEL_MIME_PARSER_STATE_MESSAGE, CAMEL_MIME_PARSER_STATE_MULTIPART, the character
    /// position immediately after the end of the header.
    /// CAMEL_MIME_PARSER_STATE_BODY, Position within the message of the start
    /// of the current data block.
    /// CAMEL_MIME_PARSER_STATE_*_END, The position of the character starting
    /// the next section of the scan (the last position + 1 of
    /// the respective current state).
    extern fn camel_mime_parser_tell(p_parser: *MimeParser) i64;
    pub const tell = camel_mime_parser_tell;

    /// When parsing a multipart, this returns the start of the last
    /// boundary.
    extern fn camel_mime_parser_tell_start_boundary(p_parser: *MimeParser) i64;
    pub const tellStartBoundary = camel_mime_parser_tell_start_boundary;

    /// If the parser is scanning From lines, then this returns
    /// the position of the start of the From line.
    extern fn camel_mime_parser_tell_start_from(p_parser: *MimeParser) i64;
    pub const tellStartFrom = camel_mime_parser_tell_start_from;

    /// Find out the position within the file of where the
    /// headers started, this is cached by the parser
    /// at the time.
    extern fn camel_mime_parser_tell_start_headers(p_parser: *MimeParser) i64;
    pub const tellStartHeaders = camel_mime_parser_tell_start_headers;

    /// Cause the last step operation to repeat itself.  If this is
    /// called repeated times, then the same step will be repeated
    /// that many times.
    ///
    /// Note that it is not possible to scan back using this function,
    /// only to have a way of peeking the next state.
    extern fn camel_mime_parser_unstep(p_parser: *MimeParser) void;
    pub const unstep = camel_mime_parser_unstep;

    extern fn camel_mime_parser_get_type() usize;
    pub const getGObjectType = camel_mime_parser_get_type;

    extern fn g_object_ref(p_self: *camel.MimeParser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimeParser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimeParser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimePart = extern struct {
    pub const Parent = camel.Medium;
    pub const Implements = [_]type{};
    pub const Class = camel.MimePartClass;
    f_parent: camel.Medium,
    f_priv: ?*camel.MimePartPrivate,

    pub const virtual_methods = struct {
        /// Constructs a MIME part from a parser.
        pub const construct_from_parser_sync = struct {
            pub fn call(p_class: anytype, p_mime_part: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(MimePart.Class, p_class).f_construct_from_parser_sync.?(gobject.ext.as(MimePart, p_mime_part), p_parser, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mime_part: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(MimePart.Class, p_class).f_construct_from_parser_sync = @ptrCast(p_implementation);
            }
        };

        /// Generates preview of the `mime_part`, to be used in the interface,
        /// read by the users.
        ///
        /// The optional `func` can be used to override default preview generation
        /// function. If provided, it's always called as the first try on the parts.
        pub const generate_preview = struct {
            pub fn call(p_class: anytype, p_mime_part: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) ?[*:0]u8 {
                return gobject.ext.as(MimePart.Class, p_class).f_generate_preview.?(gobject.ext.as(MimePart, p_mime_part), p_func, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_mime_part: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(MimePart.Class, p_class).f_generate_preview = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const content_id = struct {
            pub const name = "content-id";

            pub const Type = ?[*:0]u8;
        };

        pub const content_md5 = struct {
            pub const name = "content-md5";

            pub const Type = ?[*:0]u8;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        pub const disposition = struct {
            pub const name = "disposition";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Create a new MIME part.
    extern fn camel_mime_part_new() *camel.MimePart;
    pub const new = camel_mime_part_new;

    /// Constructs the contnet of `mime_part` from the given mime parser.
    extern fn camel_mime_part_construct_content_from_parser(p_mime_part: *MimePart, p_mp: *camel.MimeParser, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const constructContentFromParser = camel_mime_part_construct_content_from_parser;

    /// Asynchronously constructs a MIME part from a parser.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.MimePart.constructFromParserFinish` to get the result of
    /// the operation.
    extern fn camel_mime_part_construct_from_parser(p_mime_part: *MimePart, p_parser: *camel.MimeParser, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const constructFromParser = camel_mime_part_construct_from_parser;

    /// Finishes the operation started with `camel.MimePart.constructFromParser`.
    extern fn camel_mime_part_construct_from_parser_finish(p_mime_part: *MimePart, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const constructFromParserFinish = camel_mime_part_construct_from_parser_finish;

    /// Constructs a MIME part from a parser.
    extern fn camel_mime_part_construct_from_parser_sync(p_mime_part: *MimePart, p_parser: *camel.MimeParser, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const constructFromParserSync = camel_mime_part_construct_from_parser_sync;

    /// Generates preview of the `mime_part`, to be used in the interface,
    /// read by the users.
    ///
    /// The optional `func` can be used to override default preview generation
    /// function. If provided, it's always called as the first try on the parts.
    extern fn camel_mime_part_generate_preview(p_mime_part: *MimePart, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) ?[*:0]u8;
    pub const generatePreview = camel_mime_part_generate_preview;

    /// Get the disposition of the MIME part as a structure.
    /// Returned pointer is owned by `mime_part`.
    extern fn camel_mime_part_get_content_disposition(p_mime_part: *MimePart) ?*const camel.ContentDisposition;
    pub const getContentDisposition = camel_mime_part_get_content_disposition;

    /// Get the content-id field of a MIME part.
    extern fn camel_mime_part_get_content_id(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getContentId = camel_mime_part_get_content_id;

    /// Get the Content-Languages set on the MIME part.
    extern fn camel_mime_part_get_content_languages(p_mime_part: *MimePart) ?*const glib.List;
    pub const getContentLanguages = camel_mime_part_get_content_languages;

    /// Get the content-location field of a MIME part.
    extern fn camel_mime_part_get_content_location(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getContentLocation = camel_mime_part_get_content_location;

    /// Get the content-md5 field of the MIME part.
    extern fn camel_mime_part_get_content_md5(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getContentMd5 = camel_mime_part_get_content_md5;

    /// Get the Content-Type of a MIME part.
    extern fn camel_mime_part_get_content_type(p_mime_part: *MimePart) ?*camel.ContentType;
    pub const getContentType = camel_mime_part_get_content_type;

    /// Get the description of the MIME part.
    extern fn camel_mime_part_get_description(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getDescription = camel_mime_part_get_description;

    /// Get the disposition of the MIME part.
    extern fn camel_mime_part_get_disposition(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getDisposition = camel_mime_part_get_disposition;

    /// Get the Content-Transfer-Encoding of a MIME part.
    extern fn camel_mime_part_get_encoding(p_mime_part: *MimePart) camel.TransferEncoding;
    pub const getEncoding = camel_mime_part_get_encoding;

    /// Get the filename of a MIME part.
    extern fn camel_mime_part_get_filename(p_mime_part: *MimePart) ?[*:0]const u8;
    pub const getFilename = camel_mime_part_get_filename;

    /// Utility function used to set the content of a mime part object to
    /// be the provided data. If `length` is 0, this routine can be used as
    /// a way to remove old content (in which case `data` and `type` are
    /// ignored and may be `NULL`).
    extern fn camel_mime_part_set_content(p_mime_part: *MimePart, p_data: ?[*]const u8, p_length: c_int, p_type: ?[*:0]const u8) void;
    pub const setContent = camel_mime_part_set_content;

    /// Set the content-id field on a MIME part.
    extern fn camel_mime_part_set_content_id(p_mime_part: *MimePart, p_contentid: ?[*:0]const u8) void;
    pub const setContentId = camel_mime_part_set_content_id;

    /// Set the Content-Languages field of a MIME part.
    extern fn camel_mime_part_set_content_languages(p_mime_part: *MimePart, p_content_languages: ?*glib.List) void;
    pub const setContentLanguages = camel_mime_part_set_content_languages;

    /// Set the content-location field of the MIME part.
    extern fn camel_mime_part_set_content_location(p_mime_part: *MimePart, p_location: ?[*:0]const u8) void;
    pub const setContentLocation = camel_mime_part_set_content_location;

    /// Set the content-md5 field of the MIME part.
    extern fn camel_mime_part_set_content_md5(p_mime_part: *MimePart, p_md5sum: ?[*:0]const u8) void;
    pub const setContentMd5 = camel_mime_part_set_content_md5;

    /// Set the content-type on a MIME part.
    extern fn camel_mime_part_set_content_type(p_mime_part: *MimePart, p_content_type: ?[*:0]const u8) void;
    pub const setContentType = camel_mime_part_set_content_type;

    /// Set a description on the MIME part.
    extern fn camel_mime_part_set_description(p_mime_part: *MimePart, p_description: [*:0]const u8) void;
    pub const setDescription = camel_mime_part_set_description;

    /// Set a disposition on the MIME part.
    extern fn camel_mime_part_set_disposition(p_mime_part: *MimePart, p_disposition: ?[*:0]const u8) void;
    pub const setDisposition = camel_mime_part_set_disposition;

    /// Set the Content-Transfer-Encoding to use on a MIME part.
    extern fn camel_mime_part_set_encoding(p_mime_part: *MimePart, p_encoding: camel.TransferEncoding) void;
    pub const setEncoding = camel_mime_part_set_encoding;

    /// Set the filename on a MIME part.
    extern fn camel_mime_part_set_filename(p_mime_part: *MimePart, p_filename: ?[*:0]const u8) void;
    pub const setFilename = camel_mime_part_set_filename;

    extern fn camel_mime_part_get_type() usize;
    pub const getGObjectType = camel_mime_part_get_type;

    extern fn g_object_ref(p_self: *camel.MimePart) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MimePart) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MimePart, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Multipart = extern struct {
    pub const Parent = camel.DataWrapper;
    pub const Implements = [_]type{};
    pub const Class = camel.MultipartClass;
    f_parent: camel.DataWrapper,
    f_priv: ?*camel.MultipartPrivate,

    pub const virtual_methods = struct {
        /// Appends the part to the multipart object.
        pub const add_part = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: *camel.MimePart) void {
                return gobject.ext.as(Multipart.Class, p_class).f_add_part.?(gobject.ext.as(Multipart, p_multipart), p_part);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: *camel.MimePart) callconv(.c) void) void {
                gobject.ext.as(Multipart.Class, p_class).f_add_part = @ptrCast(p_implementation);
            }
        };

        /// Construct a multipart from a parser.
        pub const construct_from_parser = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser) c_int {
                return gobject.ext.as(Multipart.Class, p_class).f_construct_from_parser.?(gobject.ext.as(Multipart, p_multipart), p_parser);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parser: *camel.MimeParser) callconv(.c) c_int) void {
                gobject.ext.as(Multipart.Class, p_class).f_construct_from_parser = @ptrCast(p_implementation);
            }
        };

        /// Generates preview of the `multipart`, to be used in the interface,
        /// read by the users.
        ///
        /// The optional `func` can be used to override default preview generation
        /// function. If provided, it's always called as the first try on the parts.
        pub const generate_preview = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) ?[*:0]u8 {
                return gobject.ext.as(Multipart.Class, p_class).f_generate_preview.?(gobject.ext.as(Multipart, p_multipart), p_func, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(Multipart.Class, p_class).f_generate_preview = @ptrCast(p_implementation);
            }
        };

        pub const get_boundary = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Multipart.Class, p_class).f_get_boundary.?(gobject.ext.as(Multipart, p_multipart));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Multipart.Class, p_class).f_get_boundary = @ptrCast(p_implementation);
            }
        };

        pub const get_number = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_uint {
                return gobject.ext.as(Multipart.Class, p_class).f_get_number.?(gobject.ext.as(Multipart, p_multipart));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_uint) void {
                gobject.ext.as(Multipart.Class, p_class).f_get_number = @ptrCast(p_implementation);
            }
        };

        pub const get_part = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_uint) ?*camel.MimePart {
                return gobject.ext.as(Multipart.Class, p_class).f_get_part.?(gobject.ext.as(Multipart, p_multipart), p_index);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_uint) callconv(.c) ?*camel.MimePart) void {
                gobject.ext.as(Multipart.Class, p_class).f_get_part = @ptrCast(p_implementation);
            }
        };

        /// Sets the message boundary for `multipart` to `boundary`. This should
        /// be a string which does not occur anywhere in any of `multipart`'s
        /// subparts. If `boundary` is `NULL`, a randomly-generated boundary will
        /// be used.
        pub const set_boundary = struct {
            pub fn call(p_class: anytype, p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_boundary: ?[*:0]const u8) void {
                return gobject.ext.as(Multipart.Class, p_class).f_set_boundary.?(gobject.ext.as(Multipart, p_multipart), p_boundary);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_multipart: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_boundary: ?[*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Multipart.Class, p_class).f_set_boundary = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.Multipart` object.
    extern fn camel_multipart_new() *camel.Multipart;
    pub const new = camel_multipart_new;

    /// Appends the part to the multipart object.
    extern fn camel_multipart_add_part(p_multipart: *Multipart, p_part: *camel.MimePart) void;
    pub const addPart = camel_multipart_add_part;

    /// Construct a multipart from a parser.
    extern fn camel_multipart_construct_from_parser(p_multipart: *Multipart, p_parser: *camel.MimeParser) c_int;
    pub const constructFromParser = camel_multipart_construct_from_parser;

    /// Generates preview of the `multipart`, to be used in the interface,
    /// read by the users.
    ///
    /// The optional `func` can be used to override default preview generation
    /// function. If provided, it's always called as the first try on the parts.
    extern fn camel_multipart_generate_preview(p_multipart: *Multipart, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) ?[*:0]u8;
    pub const generatePreview = camel_multipart_generate_preview;

    extern fn camel_multipart_get_boundary(p_multipart: *Multipart) [*:0]const u8;
    pub const getBoundary = camel_multipart_get_boundary;

    extern fn camel_multipart_get_number(p_multipart: *Multipart) c_uint;
    pub const getNumber = camel_multipart_get_number;

    extern fn camel_multipart_get_part(p_multipart: *Multipart, p_index: c_uint) ?*camel.MimePart;
    pub const getPart = camel_multipart_get_part;

    /// Returns the postface text for `multipart`.
    extern fn camel_multipart_get_postface(p_multipart: *Multipart) [*:0]const u8;
    pub const getPostface = camel_multipart_get_postface;

    /// Returns the preface text for `multipart`.
    extern fn camel_multipart_get_preface(p_multipart: *Multipart) [*:0]const u8;
    pub const getPreface = camel_multipart_get_preface;

    /// Sets the message boundary for `multipart` to `boundary`. This should
    /// be a string which does not occur anywhere in any of `multipart`'s
    /// subparts. If `boundary` is `NULL`, a randomly-generated boundary will
    /// be used.
    extern fn camel_multipart_set_boundary(p_multipart: *Multipart, p_boundary: ?[*:0]const u8) void;
    pub const setBoundary = camel_multipart_set_boundary;

    /// Set the postface text for this multipart.  Will be written out after
    /// the last boundary of the multipart, and ignored by any MIME mail
    /// client.
    ///
    /// Generally postface texts should not be sent with multipart messages.
    extern fn camel_multipart_set_postface(p_multipart: *Multipart, p_postface: [*:0]const u8) void;
    pub const setPostface = camel_multipart_set_postface;

    /// Set the preface text for this multipart.  Will be written out infront
    /// of the multipart.  This text should only include US-ASCII strings, and
    /// be relatively short, and will be ignored by any MIME mail client.
    extern fn camel_multipart_set_preface(p_multipart: *Multipart, p_preface: [*:0]const u8) void;
    pub const setPreface = camel_multipart_set_preface;

    extern fn camel_multipart_get_type() usize;
    pub const getGObjectType = camel_multipart_get_type;

    extern fn g_object_ref(p_self: *camel.Multipart) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Multipart) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Multipart, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartEncrypted = extern struct {
    pub const Parent = camel.Multipart;
    pub const Implements = [_]type{};
    pub const Class = camel.MultipartEncryptedClass;
    f_parent: camel.Multipart,
    f_priv: ?*camel.MultipartEncryptedPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MultipartEncrypted` object.
    ///
    /// A MultipartEncrypted should be used to store and create parts of
    /// type "multipart/encrypted".
    extern fn camel_multipart_encrypted_new() *camel.MultipartEncrypted;
    pub const new = camel_multipart_encrypted_new;

    extern fn camel_multipart_encrypted_get_type() usize;
    pub const getGObjectType = camel_multipart_encrypted_get_type;

    extern fn g_object_ref(p_self: *camel.MultipartEncrypted) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MultipartEncrypted) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MultipartEncrypted, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartSigned = extern struct {
    pub const Parent = camel.Multipart;
    pub const Implements = [_]type{};
    pub const Class = camel.MultipartSignedClass;
    f_parent: camel.Multipart,
    f_priv: ?*camel.MultipartSignedPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.MultipartSigned` object.
    ///
    /// A MultipartSigned should be used to store and create parts of
    /// type "multipart/signed".  This is because multipart/signed is
    /// entirely broken-by-design (tm) and uses completely
    /// different semantics to other mutlipart types.  It must be treated
    /// as opaque data by any transport.  See rfc 3156 for details.
    ///
    /// There are 3 ways to create the part:
    /// Use construct_from_stream.  If this is used, then you must
    /// set the mime_type appropriately to match the data uses, so
    /// that the multiple parts my be extracted.
    ///
    /// Use construct_from_parser.  The parser MUST be in the `CAMEL_MIME_PARSER_STATE_HEADER`
    /// state, and the current content_type MUST be "multipart/signed" with
    /// the appropriate boundary and it SHOULD include the appropriate protocol
    /// and hash specifiers.
    ///
    /// Use sign_part.  A signature part will automatically be created
    /// and the whole part may be written using write_to_stream to
    /// create a 'transport-safe' version (as safe as can be expected with
    /// such a broken specification).
    extern fn camel_multipart_signed_new() *camel.MultipartSigned;
    pub const new = camel_multipart_signed_new;

    /// Get the raw signed content stream of the multipart/signed MIME part
    /// suitable for use with verification of the signature.
    extern fn camel_multipart_signed_get_content_stream(p_mps: *MultipartSigned, p_error: ?*?*glib.Error) ?*camel.Stream;
    pub const getContentStream = camel_multipart_signed_get_content_stream;

    /// Explicits sets the raw signed content stream of the multipart/signed
    /// MIME part.
    extern fn camel_multipart_signed_set_content_stream(p_mps: *MultipartSigned, p_content_stream: *camel.Stream) void;
    pub const setContentStream = camel_multipart_signed_set_content_stream;

    /// Explicitly sets the signature part of `mps`.
    extern fn camel_multipart_signed_set_signature(p_mps: *MultipartSigned, p_signature: *camel.MimePart) void;
    pub const setSignature = camel_multipart_signed_set_signature;

    extern fn camel_multipart_signed_get_type() usize;
    pub const getGObjectType = camel_multipart_signed_get_type;

    extern fn g_object_ref(p_self: *camel.MultipartSigned) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.MultipartSigned) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MultipartSigned, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NNTPAddress = extern struct {
    pub const Parent = camel.Address;
    pub const Implements = [_]type{};
    pub const Class = camel.NNTPAddressClass;
    f_parent: camel.Address,
    f_priv: ?*camel.NNTPAddressPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new CamelNNTPAddress object.
    extern fn camel_nntp_address_new() *camel.NNTPAddress;
    pub const new = camel_nntp_address_new;

    /// Add a new nntp address to the address object.  Duplicates are not added twice.
    extern fn camel_nntp_address_add(p_addr: *NNTPAddress, p_name: [*:0]const u8) c_int;
    pub const add = camel_nntp_address_add;

    /// Get the address at `index`.
    extern fn camel_nntp_address_get(p_addr: *NNTPAddress, p_index: c_int, p_namep: *[*:0]const u8) c_int;
    pub const get = camel_nntp_address_get;

    extern fn camel_nntp_address_get_type() usize;
    pub const getGObjectType = camel_nntp_address_get_type;

    extern fn g_object_ref(p_self: *camel.NNTPAddress) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.NNTPAddress) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NNTPAddress, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NullOutputStream = extern struct {
    pub const Parent = gio.OutputStream;
    pub const Implements = [_]type{};
    pub const Class = camel.NullOutputStreamClass;
    f_parent: gio.OutputStream,
    f_priv: ?*camel.NullOutputStreamPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new "null" output stream.
    extern fn camel_null_output_stream_new() *camel.NullOutputStream;
    pub const new = camel_null_output_stream_new;

    /// Gets the total number of bytes written to `null_stream`.
    extern fn camel_null_output_stream_get_bytes_written(p_null_stream: *NullOutputStream) usize;
    pub const getBytesWritten = camel_null_output_stream_get_bytes_written;

    extern fn camel_null_output_stream_get_ends_with_crlf(p_null_stream: *NullOutputStream) c_int;
    pub const getEndsWithCrlf = camel_null_output_stream_get_ends_with_crlf;

    extern fn camel_null_output_stream_get_type() usize;
    pub const getGObjectType = camel_null_output_stream_get_type;

    extern fn g_object_ref(p_self: *camel.NullOutputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.NullOutputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NullOutputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Object = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.ObjectClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.ObjectPrivate,

    pub const virtual_methods = struct {
        pub const state_read = struct {
            pub fn call(p_class: anytype, p_object: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fp: ?*anyopaque) c_int {
                return gobject.ext.as(Object.Class, p_class).f_state_read.?(gobject.ext.as(Object, p_object), p_fp);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_object: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fp: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(Object.Class, p_class).f_state_read = @ptrCast(p_implementation);
            }
        };

        pub const state_write = struct {
            pub fn call(p_class: anytype, p_object: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fp: ?*anyopaque) c_int {
                return gobject.ext.as(Object.Class, p_class).f_state_write.?(gobject.ext.as(Object, p_object), p_fp);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_object: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fp: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(Object.Class, p_class).f_state_write = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The file in which to store persistent property values for this
        /// instance.
        pub const state_filename = struct {
            pub const name = "state-filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Returns the name of the file in which persistent property values for
    /// `object` are stored.  The file is used by `camel.Object.stateWrite`
    /// and `camel.Object.stateRead` to save and restore object state.
    extern fn camel_object_get_state_filename(p_object: *Object) [*:0]const u8;
    pub const getStateFilename = camel_object_get_state_filename;

    /// Sets the name of the file in which persistent property values for
    /// `object` are stored.  The file is used by `camel.Object.stateWrite`
    /// and `camel.Object.stateRead` to save and restore object state.
    extern fn camel_object_set_state_filename(p_object: *Object, p_state_filename: [*:0]const u8) void;
    pub const setStateFilename = camel_object_set_state_filename;

    /// Read persistent object state from `camel.Object.properties.state`-filename.
    extern fn camel_object_state_read(p_object: *Object) c_int;
    pub const stateRead = camel_object_state_read;

    /// Write persistent object state `camel.Object.properties.state`-filename.
    extern fn camel_object_state_write(p_object: *Object) c_int;
    pub const stateWrite = camel_object_state_write;

    extern fn camel_object_get_type() usize;
    pub const getGObjectType = camel_object_get_type;

    extern fn g_object_ref(p_self: *camel.Object) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Object) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Object, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineFolder = extern struct {
    pub const Parent = camel.Folder;
    pub const Implements = [_]type{};
    pub const Class = camel.OfflineFolderClass;
    f_parent: camel.Folder,
    f_priv: ?*camel.OfflineFolderPrivate,

    pub const virtual_methods = struct {
        /// Synchronizes messages in `folder` described by the search `expression` to
        /// the local machine for offline availability.
        pub const downsync_sync = struct {
            pub fn call(p_class: anytype, p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(OfflineFolder.Class, p_class).f_downsync_sync.?(gobject.ext.as(OfflineFolder, p_folder), p_expression, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_folder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(OfflineFolder.Class, p_class).f_downsync_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const offline_sync = struct {
            pub const name = "offline-sync";

            pub const Type = camel.ThreeState;
        };
    };

    pub const signals = struct {};

    /// Checks whether the `folder` can run downsync according to its
    /// settings (`camel.OfflineFolder.getOfflineSync`) and to
    /// the parent's `camel.OfflineStore` settings (`camel.OfflineSettings.getStaySynchronized`).
    extern fn camel_offline_folder_can_downsync(p_folder: *OfflineFolder) c_int;
    pub const canDownsync = camel_offline_folder_can_downsync;

    /// Synchronizes messages in `folder` described by the search `expression` to
    /// the local machine asynchronously for offline availability.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.OfflineFolder.downsyncFinish` to get the result of the
    /// operation.
    extern fn camel_offline_folder_downsync(p_folder: *OfflineFolder, p_expression: ?[*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const downsync = camel_offline_folder_downsync;

    /// Finishes the operation started with `camel.OfflineFolder.downsync`.
    extern fn camel_offline_folder_downsync_finish(p_folder: *OfflineFolder, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const downsyncFinish = camel_offline_folder_downsync_finish;

    /// Synchronizes messages in `folder` described by the search `expression` to
    /// the local machine for offline availability.
    extern fn camel_offline_folder_downsync_sync(p_folder: *OfflineFolder, p_expression: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const downsyncSync = camel_offline_folder_downsync_sync;

    extern fn camel_offline_folder_get_offline_sync(p_folder: *OfflineFolder) camel.ThreeState;
    pub const getOfflineSync = camel_offline_folder_get_offline_sync;

    /// The `CAMEL_THREE_STATE_INCONSISTENT` means what the parent store has set.
    extern fn camel_offline_folder_set_offline_sync(p_folder: *OfflineFolder, p_offline_sync: camel.ThreeState) void;
    pub const setOfflineSync = camel_offline_folder_set_offline_sync;

    extern fn camel_offline_folder_get_type() usize;
    pub const getGObjectType = camel_offline_folder_get_type;

    extern fn g_object_ref(p_self: *camel.OfflineFolder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.OfflineFolder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OfflineFolder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const OfflineSettings = extern struct {
    pub const Parent = camel.StoreSettings;
    pub const Implements = [_]type{};
    pub const Class = camel.OfflineSettingsClass;
    f_parent: camel.StoreSettings,
    f_priv: ?*camel.OfflineSettingsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const limit_by_age = struct {
            pub const name = "limit-by-age";

            pub const Type = c_int;
        };

        pub const limit_unit = struct {
            pub const name = "limit-unit";

            pub const Type = camel.TimeUnit;
        };

        pub const limit_value = struct {
            pub const name = "limit-value";

            pub const Type = c_int;
        };

        pub const stay_synchronized = struct {
            pub const name = "stay-synchronized";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn camel_offline_settings_get_limit_by_age(p_settings: *OfflineSettings) c_int;
    pub const getLimitByAge = camel_offline_settings_get_limit_by_age;

    extern fn camel_offline_settings_get_limit_unit(p_settings: *OfflineSettings) camel.TimeUnit;
    pub const getLimitUnit = camel_offline_settings_get_limit_unit;

    extern fn camel_offline_settings_get_limit_value(p_settings: *OfflineSettings) c_int;
    pub const getLimitValue = camel_offline_settings_get_limit_value;

    /// Returns whether to synchronize the local cache with the remote server
    /// before switching to offline mode, so the store's content can still be
    /// read while offline.
    extern fn camel_offline_settings_get_stay_synchronized(p_settings: *OfflineSettings) c_int;
    pub const getStaySynchronized = camel_offline_settings_get_stay_synchronized;

    /// Returns the interval, in seconds, for the changes in the folder being
    /// saved automatically. 0 means immediately, while -1 means turning off
    /// automatic folder change saving.
    extern fn camel_offline_settings_get_store_changes_interval(p_settings: *OfflineSettings) c_int;
    pub const getStoreChangesInterval = camel_offline_settings_get_store_changes_interval;

    /// Set whether the messages to download for offline should be limited
    /// by age. If set to `TRUE`, then messages older than 'limit-value'
    /// will not be downloaded automatically.
    extern fn camel_offline_settings_set_limit_by_age(p_settings: *OfflineSettings, p_limit_by_age: c_int) void;
    pub const setLimitByAge = camel_offline_settings_set_limit_by_age;

    /// Set the limit unit to use when interpreting 'limit-value'.
    extern fn camel_offline_settings_set_limit_unit(p_settings: *OfflineSettings, p_limit_unit: camel.TimeUnit) void;
    pub const setLimitUnit = camel_offline_settings_set_limit_unit;

    /// Set the limit, in 'limit-unit', to use when 'limit-by-age' is set to `TRUE`.
    extern fn camel_offline_settings_set_limit_value(p_settings: *OfflineSettings, p_limit_value: c_int) void;
    pub const setLimitValue = camel_offline_settings_set_limit_value;

    /// Sets whether to synchronize the local cache with the remote server before
    /// switching to offline mode, so the store's content can still be read while
    /// offline.
    extern fn camel_offline_settings_set_stay_synchronized(p_settings: *OfflineSettings, p_stay_synchronized: c_int) void;
    pub const setStaySynchronized = camel_offline_settings_set_stay_synchronized;

    /// Sets the interval, in seconds, for the changes in the folder being
    /// saved automatically. 0 means immediately, while -1 means turning off
    /// automatic folder change saving.
    extern fn camel_offline_settings_set_store_changes_interval(p_settings: *OfflineSettings, p_interval: c_int) void;
    pub const setStoreChangesInterval = camel_offline_settings_set_store_changes_interval;

    extern fn camel_offline_settings_get_type() usize;
    pub const getGObjectType = camel_offline_settings_get_type;

    extern fn g_object_ref(p_self: *camel.OfflineSettings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.OfflineSettings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OfflineSettings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineStore = extern struct {
    pub const Parent = camel.Store;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = camel.OfflineStoreClass;
    f_parent: camel.Store,
    f_priv: ?*camel.OfflineStorePrivate,

    pub const virtual_methods = struct {
        /// Returns a `glib.PtrArray` of `camel.Folder` objects which should be checked
        /// for offline synchronization. Free the returned pointer with the below
        /// calls, when no longer needed:
        ///
        /// ```
        ///     g_ptr_array_foreach (array, (GFunc) g_object_unref, NULL);
        ///     g_ptr_array_free (array, TRUE);
        /// ```
        pub const dup_downsync_folders = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.PtrArray {
                return gobject.ext.as(OfflineStore.Class, p_class).f_dup_downsync_folders.?(gobject.ext.as(OfflineStore, p_store));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(OfflineStore.Class, p_class).f_dup_downsync_folders = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const online = struct {
            pub const name = "online";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns a `glib.PtrArray` of `camel.Folder` objects which should be checked
    /// for offline synchronization. Free the returned pointer with the below
    /// calls, when no longer needed:
    ///
    /// ```
    ///     g_ptr_array_foreach (array, (GFunc) g_object_unref, NULL);
    ///     g_ptr_array_free (array, TRUE);
    /// ```
    extern fn camel_offline_store_dup_downsync_folders(p_store: *OfflineStore) *glib.PtrArray;
    pub const dupDownsyncFolders = camel_offline_store_dup_downsync_folders;

    /// Returns `TRUE` if `store` is online.
    extern fn camel_offline_store_get_online(p_store: *OfflineStore) c_int;
    pub const getOnline = camel_offline_store_get_online;

    /// Downloads messages for offline, when setup to do so and when
    /// the host is reachable.
    extern fn camel_offline_store_prepare_for_offline_sync(p_store: *OfflineStore, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const prepareForOfflineSync = camel_offline_store_prepare_for_offline_sync;

    /// Check whether the `store` requires synchronization for offline usage.
    /// This is not blocking, it only checks settings on the store and its
    /// currently opened folders.
    ///
    /// Returns `TRUE` if the `store` requires synchronization for offline usage
    extern fn camel_offline_store_requires_downsync(p_store: *OfflineStore) c_int;
    pub const requiresDownsync = camel_offline_store_requires_downsync;

    /// An asynchronous variant of `camel.OfflineStore.setOnlineSync`.
    /// Call `camel.OfflineStore.setOnlineFinish` from within the `callback`.
    extern fn camel_offline_store_set_online(p_store: *OfflineStore, p_online: c_int, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const setOnline = camel_offline_store_set_online;

    /// Finishes the operation started with `camel.OfflineStore.setOnline`.
    extern fn camel_offline_store_set_online_finish(p_store: *OfflineStore, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setOnlineFinish = camel_offline_store_set_online_finish;

    /// Sets the online/offline state of `store` according to `online`.
    extern fn camel_offline_store_set_online_sync(p_store: *OfflineStore, p_online: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setOnlineSync = camel_offline_store_set_online_sync;

    extern fn camel_offline_store_get_type() usize;
    pub const getGObjectType = camel_offline_store_get_type;

    extern fn g_object_ref(p_self: *camel.OfflineStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.OfflineStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OfflineStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Operation = extern struct {
    pub const Parent = gio.Cancellable;
    pub const Implements = [_]type{};
    pub const Class = camel.OperationClass;
    f_parent: gio.Cancellable,
    f_priv: ?*camel.OperationPrivate,

    pub const virtual_methods = struct {
        pub const status = struct {
            pub fn call(p_class: anytype, p_operation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_what: [*:0]const u8, p_pc: c_int) void {
                return gobject.ext.as(Operation.Class, p_class).f_status.?(gobject.ext.as(Operation, p_operation), p_what, p_pc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_operation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_what: [*:0]const u8, p_pc: c_int) callconv(.c) void) void {
                gobject.ext.as(Operation.Class, p_class).f_status = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const pop_message = struct {
            pub const name = "pop-message";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Operation, p_instance))),
                    gobject.signalLookup("pop-message", Operation.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const progress = struct {
            pub const name = "progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Operation, p_instance))),
                    gobject.signalLookup("progress", Operation.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const push_message = struct {
            pub const name = "push-message";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Operation, p_instance))),
                    gobject.signalLookup("push-message", Operation.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const status = struct {
            pub const name = "status";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Operation, p_instance))),
                    gobject.signalLookup("status", Operation.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Cancel all outstanding operations.
    extern fn camel_operation_cancel_all() void;
    pub const cancelAll = camel_operation_cancel_all;

    /// Duplicates current operation message, or returns `NULL`, if no such is available.
    /// The message as the last text set by `camel.Operation.pushMessage`.
    ///
    /// Free the returned text with `glib.free`, when no longer needed.
    ///
    /// This function only works if `cancellable` is a `camel.Operation` cast as a
    /// `gio.Cancellable`.  If `cancellable` is a plain `gio.Cancellable` or `NULL`, the
    /// function does nothing and returns silently.
    extern fn camel_operation_dup_message(p_cancellable: ?*gio.Cancellable) ?[*:0]u8;
    pub const dupMessage = camel_operation_dup_message;

    /// Pops the most recently pushed message.
    ///
    /// This function only works if `cancellable` is a `camel.Operation` cast as a
    /// `gio.Cancellable`.  If `cancellable` is a plain `gio.Cancellable` or `NULL`, the
    /// function does nothing and returns silently.
    extern fn camel_operation_pop_message(p_cancellable: ?*gio.Cancellable) void;
    pub const popMessage = camel_operation_pop_message;

    /// Report progress on the current operation.  `percent` reports the current
    /// percentage of completion, which should be in the range of 0 to 100.
    ///
    /// This function only works if `cancellable` is a `camel.Operation` cast as a
    /// `gio.Cancellable`.  If `cancellable` is a plain `gio.Cancellable` or `NULL`, the
    /// function does nothing and returns silently.
    extern fn camel_operation_progress(p_cancellable: ?*gio.Cancellable, p_percent: c_int) void;
    pub const progress = camel_operation_progress;

    /// Call this function to describe an operation being performed.
    /// Call `camel.Operation.progress` to report progress on the operation.
    /// Call `camel.Operation.popMessage` when the operation is complete.
    ///
    /// This function only works if `cancellable` is a `camel.Operation` cast as a
    /// `gio.Cancellable`.  If `cancellable` is a plain `gio.Cancellable` or `NULL`, the
    /// function does nothing and returns silently.
    extern fn camel_operation_push_message(p_cancellable: ?*gio.Cancellable, p_format: [*:0]const u8, ...) void;
    pub const pushMessage = camel_operation_push_message;

    /// Create a new camel operation handle.  Camel operation handles can
    /// be used in a multithreaded application (or a single operation
    /// handle can be used in a non threaded appliation) to cancel running
    /// operations and to obtain notification messages of the internal
    /// status of messages.
    extern fn camel_operation_new() *camel.Operation;
    pub const new = camel_operation_new;

    /// Proxies the `cancellable` in a way that if it is cancelled,
    /// then the returned cancellable is also cancelled, but when
    /// the returned cancellable is cancelled, then it doesn't
    /// influence the original cancellable. Other CamelOperation
    /// actions being done on the returned cancellable are also
    /// propagated to the `cancellable`.
    ///
    /// The passed-in `cancellable` can be `NULL`, in which case
    /// a plain CamelOperation is returned.
    ///
    /// This is useful when some operation can be cancelled from
    /// elsewhere (like by a user), but also by the code on its own,
    /// when it doesn't make sense to cancel also any larger operation
    /// to which the passed-in cancellable belongs.
    extern fn camel_operation_new_proxy(p_cancellable: ?*gio.Cancellable) *camel.Operation;
    pub const newProxy = camel_operation_new_proxy;

    extern fn camel_operation_get_type() usize;
    pub const getGObjectType = camel_operation_get_type;

    extern fn g_object_ref(p_self: *camel.Operation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Operation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Operation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionTable = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.PartitionTableClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.PartitionTablePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_partition_table_new(p_bs: *camel.BlockFile, p_root: camel._block_t) *camel.PartitionTable;
    pub const new = camel_partition_table_new;

    extern fn camel_partition_table_add(p_cpi: *PartitionTable, p_key: [*:0]const u8, p_keyid: camel._key_t) c_int;
    pub const add = camel_partition_table_add;

    extern fn camel_partition_table_lookup(p_cpi: *PartitionTable, p_key: [*:0]const u8) camel._key_t;
    pub const lookup = camel_partition_table_lookup;

    extern fn camel_partition_table_remove(p_cpi: *PartitionTable, p_key: [*:0]const u8) c_int;
    pub const remove = camel_partition_table_remove;

    extern fn camel_partition_table_sync(p_cpi: *PartitionTable) c_int;
    pub const sync = camel_partition_table_sync;

    extern fn camel_partition_table_get_type() usize;
    pub const getGObjectType = camel_partition_table_get_type;

    extern fn g_object_ref(p_self: *camel.PartitionTable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.PartitionTable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PartitionTable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SExp = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.SExpClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.SExpPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Encode a bool into an s-expression `string`.  Bools are
    /// encoded using `t` `f` syntax.
    extern fn camel_sexp_encode_bool(p_string: *glib.String, p_v_bool: c_int) void;
    pub const encodeBool = camel_sexp_encode_bool;

    /// Add a c string `v_string` to the s-expression stored in
    /// the gstring `s`.  Quotes are added, and special characters
    /// are escaped appropriately.
    extern fn camel_sexp_encode_string(p_string: *glib.String, p_v_string: [*:0]const u8) void;
    pub const encodeString = camel_sexp_encode_string;

    /// Converts a search expression to an SQL 'WHERE' part statement,
    /// without the 'WHERE' keyword.
    extern fn camel_sexp_to_sql_sexp(p_sexp: [*:0]const u8) ?[*:0]u8;
    pub const toSqlSexp = camel_sexp_to_sql_sexp;

    extern fn camel_sexp_new() *camel.SExp;
    pub const new = camel_sexp_new;

    /// Adds a function symbol which can not perform short evaluation.
    /// Use `camel.SExp.addIfunction` for functions which can.
    extern fn camel_sexp_add_function(p_sexp: *SExp, p_scope: c_uint, p_name: [*:0]const u8, p_func: camel.SExpFunc, p_user_data: ?*anyopaque) void;
    pub const addFunction = camel_sexp_add_function;

    /// Adds a function symbol which can perform short evaluation,
    /// or doesn't execute everything. Use `camel.SExp.addFunction`
    /// for any other types of the function symbols.
    extern fn camel_sexp_add_ifunction(p_sexp: *SExp, p_scope: c_uint, p_name: [*:0]const u8, p_ifunc: camel.SExpIFunc, p_user_data: ?*anyopaque) void;
    pub const addIfunction = camel_sexp_add_ifunction;

    /// Adds a variable named `name` to the given `scope`, set to the given `value`.
    extern fn camel_sexp_add_variable(p_sexp: *SExp, p_scope: c_uint, p_name: [*:0]const u8, p_value: *camel.SExpTerm) void;
    pub const addVariable = camel_sexp_add_variable;

    extern fn camel_sexp_error(p_sexp: *SExp) ?[*:0]const u8;
    pub const @"error" = camel_sexp_error;

    extern fn camel_sexp_eval(p_sexp: *SExp) *camel.SExpResult;
    pub const eval = camel_sexp_eval;

    extern fn camel_sexp_evaluate_occur_times(p_sexp: *SExp, p_start: *std.posix.time_t, p_end: *std.posix.time_t) c_int;
    pub const evaluateOccurTimes = camel_sexp_evaluate_occur_times;

    /// Sets an error from the given format and stops execution.
    /// Int replaces previously set error, if any.
    extern fn camel_sexp_fatal_error(p_sexp: *SExp, p_why: [*:0]const u8, ...) void;
    pub const fatalError = camel_sexp_fatal_error;

    /// Prepares to scan a file.
    extern fn camel_sexp_input_file(p_sexp: *SExp, p_fd: c_int) void;
    pub const inputFile = camel_sexp_input_file;

    /// Prepares to scan a text buffer.
    extern fn camel_sexp_input_text(p_sexp: *SExp, p_text: [*:0]const u8, p_len: c_int) void;
    pub const inputText = camel_sexp_input_text;

    extern fn camel_sexp_parse(p_sexp: *SExp) c_int;
    pub const parse = camel_sexp_parse;

    extern fn camel_sexp_parse_value(p_sexp: *SExp) ?*camel.SExpTerm;
    pub const parseValue = camel_sexp_parse_value;

    /// Revoes a symbol from a scope.
    extern fn camel_sexp_remove_symbol(p_sexp: *SExp, p_scope: c_uint, p_name: [*:0]const u8) void;
    pub const removeSymbol = camel_sexp_remove_symbol;

    /// Frees the `result` and its internal data. Does nothing,
    /// when the `result` is `NULL`.
    extern fn camel_sexp_result_free(p_sexp: *SExp, p_result: ?*camel.SExpResult) void;
    pub const resultFree = camel_sexp_result_free;

    extern fn camel_sexp_result_new(p_sexp: *SExp, p_type: c_int) *camel.SExpResult;
    pub const resultNew = camel_sexp_result_new;

    /// Frees an array of results.
    extern fn camel_sexp_resultv_free(p_sexp: *SExp, p_argc: c_int, p_argv: [*]*camel.SExpResult) void;
    pub const resultvFree = camel_sexp_resultv_free;

    /// sets the current scope for the scanner.
    extern fn camel_sexp_set_scope(p_sexp: *SExp, p_scope: c_uint) c_int;
    pub const setScope = camel_sexp_set_scope;

    /// Evaluates a part of the expression.
    extern fn camel_sexp_term_eval(p_sexp: *SExp, p_term: *camel.SExpTerm) *camel.SExpResult;
    pub const termEval = camel_sexp_term_eval;

    extern fn camel_sexp_get_type() usize;
    pub const getGObjectType = camel_sexp_get_type;

    extern fn g_object_ref(p_self: *camel.SExp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SExp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SExp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SMIMEContext = extern struct {
    pub const Parent = camel.CipherContext;
    pub const Implements = [_]type{};
    pub const Class = camel.SMIMEContextClass;
    f_parent: camel.CipherContext,
    f_priv: ?*camel.SMIMEContextPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Utility function to get a localized text description for an error code
    /// returned by `PORT_GetError`.
    ///
    /// Note: the function returns always NULL when the library was not compiled
    ///   with S/MIME support.
    extern fn camel_smime_context_util_nss_error_to_string(p_nss_error_code: c_int) ?[*:0]const u8;
    pub const utilNssErrorToString = camel_smime_context_util_nss_error_to_string;

    /// Creates a new sm cipher context object.
    extern fn camel_smime_context_new(p_session: *camel.Session) *camel.SMIMEContext;
    pub const new = camel_smime_context_new;

    extern fn camel_smime_context_describe_part(p_context: *SMIMEContext, p_part: ?*anyopaque) u32;
    pub const describePart = camel_smime_context_describe_part;

    extern fn camel_smime_context_set_encrypt_key(p_context: *SMIMEContext, p_use: c_int, p_key: [*:0]const u8) void;
    pub const setEncryptKey = camel_smime_context_set_encrypt_key;

    extern fn camel_smime_context_set_sign_mode(p_context: *SMIMEContext, p_type: camel.SMIMESign) void;
    pub const setSignMode = camel_smime_context_set_sign_mode;

    extern fn camel_smime_context_get_type() usize;
    pub const getGObjectType = camel_smime_context_get_type;

    extern fn g_object_ref(p_self: *camel.SMIMEContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SMIMEContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SMIMEContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Sasl = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.SaslPrivate,

    pub const virtual_methods = struct {
        /// If `token` is `NULL`, generate the initial SASL message to send to
        /// the server.  (This will be `NULL` if the client doesn't initiate the
        /// exchange.)  Otherwise, `token` is a challenge from the server, and
        /// the return value is the response.
        ///
        /// Free the returned `glib.ByteArray` with `glib.byteArrayFree`.
        pub const challenge_sync = struct {
            pub fn call(p_class: anytype, p_sasl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_token: ?*glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.ByteArray {
                return gobject.ext.as(Sasl.Class, p_class).f_challenge_sync.?(gobject.ext.as(Sasl, p_sasl), p_token, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_sasl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_token: ?*glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.ByteArray) void {
                gobject.ext.as(Sasl.Class, p_class).f_challenge_sync = @ptrCast(p_implementation);
            }
        };

        pub const try_empty_password_sync = struct {
            pub fn call(p_class: anytype, p_sasl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Sasl.Class, p_class).f_try_empty_password_sync.?(gobject.ext.as(Sasl, p_sasl), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_sasl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Sasl.Class, p_class).f_try_empty_password_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const authenticated = struct {
            pub const name = "authenticated";

            pub const Type = c_int;
        };

        pub const mechanism = struct {
            pub const name = "mechanism";

            pub const Type = ?[*:0]u8;
        };

        pub const service = struct {
            pub const name = "service";

            pub const Type = ?*camel.Service;
        };

        pub const service_name = struct {
            pub const name = "service-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn camel_sasl_authtype(p_mechanism: [*:0]const u8) ?*camel.ServiceAuthType;
    pub const authtype = camel_sasl_authtype;

    extern fn camel_sasl_authtype_list(p_include_plain: c_int) *glib.List;
    pub const authtypeList = camel_sasl_authtype_list;

    /// Checks whether exists a `camel.Sasl` method for the `mechanism` and
    /// whether it derives from `camel.SaslXOAuth2`. Such mechanisms are
    /// also treated as XOAUTH2, even their real name is different.
    extern fn camel_sasl_is_xoauth2_alias(p_mechanism: ?[*:0]const u8) c_int;
    pub const isXoauth2Alias = camel_sasl_is_xoauth2_alias;

    extern fn camel_sasl_new(p_service_name: [*:0]const u8, p_mechanism: [*:0]const u8, p_service: *camel.Service) ?*camel.Sasl;
    pub const new = camel_sasl_new;

    /// If `token` is `NULL`, asynchronously generate the initial SASL message
    /// to send to the server.  (This will be `NULL` if the client doesn't
    /// initiate the exchange.)  Otherwise, `token` is a challenge from the
    /// server, and the asynchronous result is the response.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Sasl.challengeFinish` to get the result of the operation.
    extern fn camel_sasl_challenge(p_sasl: *Sasl, p_token: ?*glib.ByteArray, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const challenge = camel_sasl_challenge;

    /// As with `camel.Sasl.challenge`, but the challenge `token` and the
    /// response are both base64-encoded.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Sasl.challengeBase64Finish` to get the result of
    /// the operation.
    extern fn camel_sasl_challenge_base64(p_sasl: *Sasl, p_token: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const challengeBase64 = camel_sasl_challenge_base64;

    /// Finishes the operation started with `camel.Sasl.challengeBase64`.
    extern fn camel_sasl_challenge_base64_finish(p_sasl: *Sasl, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const challengeBase64Finish = camel_sasl_challenge_base64_finish;

    /// As with `camel.Sasl.challengeSync`, but the challenge `token` and the
    /// response are both base64-encoded.
    extern fn camel_sasl_challenge_base64_sync(p_sasl: *Sasl, p_token: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const challengeBase64Sync = camel_sasl_challenge_base64_sync;

    /// Finishes the operation started with `camel.Sasl.challenge`.  Free the
    /// returned `glib.ByteArray` with `glib.byteArrayFree`.
    extern fn camel_sasl_challenge_finish(p_sasl: *Sasl, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.ByteArray;
    pub const challengeFinish = camel_sasl_challenge_finish;

    /// If `token` is `NULL`, generate the initial SASL message to send to
    /// the server.  (This will be `NULL` if the client doesn't initiate the
    /// exchange.)  Otherwise, `token` is a challenge from the server, and
    /// the return value is the response.
    ///
    /// Free the returned `glib.ByteArray` with `glib.byteArrayFree`.
    extern fn camel_sasl_challenge_sync(p_sasl: *Sasl, p_token: ?*glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.ByteArray;
    pub const challengeSync = camel_sasl_challenge_sync;

    extern fn camel_sasl_get_authenticated(p_sasl: *Sasl) c_int;
    pub const getAuthenticated = camel_sasl_get_authenticated;

    extern fn camel_sasl_get_mechanism(p_sasl: *Sasl) [*:0]const u8;
    pub const getMechanism = camel_sasl_get_mechanism;

    extern fn camel_sasl_get_service(p_sasl: *Sasl) *camel.Service;
    pub const getService = camel_sasl_get_service;

    extern fn camel_sasl_get_service_name(p_sasl: *Sasl) [*:0]const u8;
    pub const getServiceName = camel_sasl_get_service_name;

    extern fn camel_sasl_set_authenticated(p_sasl: *Sasl, p_authenticated: c_int) void;
    pub const setAuthenticated = camel_sasl_set_authenticated;

    /// Asynchronously determine whether `sasl` can be used for password-less
    /// authentication, for example single-sign-on using system credentials.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Sasl.tryEmptyPasswordFinish` to get the result of the
    /// operation.
    extern fn camel_sasl_try_empty_password(p_sasl: *Sasl, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const tryEmptyPassword = camel_sasl_try_empty_password;

    /// Finishes the operation started with `camel.Sasl.tryEmptyPassword`.
    extern fn camel_sasl_try_empty_password_finish(p_sasl: *Sasl, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const tryEmptyPasswordFinish = camel_sasl_try_empty_password_finish;

    extern fn camel_sasl_try_empty_password_sync(p_sasl: *Sasl, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tryEmptyPasswordSync = camel_sasl_try_empty_password_sync;

    extern fn camel_sasl_get_type() usize;
    pub const getGObjectType = camel_sasl_get_type;

    extern fn g_object_ref(p_self: *camel.Sasl) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Sasl) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Sasl, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslAnonymous = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslAnonymousClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslAnonymousPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.SaslAnonymous` object.
    extern fn camel_sasl_anonymous_new(p_type: camel.SaslAnonTraceType, p_trace_info: [*:0]const u8) *camel.SaslAnonymous;
    pub const new = camel_sasl_anonymous_new;

    extern fn camel_sasl_anonymous_get_type() usize;
    pub const getGObjectType = camel_sasl_anonymous_get_type;

    extern fn g_object_ref(p_self: *camel.SaslAnonymous) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslAnonymous) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslAnonymous, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslCramMd5 = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslCramMd5Class;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslCramMd5Private,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_cram_md5_get_type() usize;
    pub const getGObjectType = camel_sasl_cram_md5_get_type;

    extern fn g_object_ref(p_self: *camel.SaslCramMd5) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslCramMd5) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslCramMd5, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslDigestMd5 = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslDigestMd5Class;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslDigestMd5Private,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_digest_md5_get_type() usize;
    pub const getGObjectType = camel_sasl_digest_md5_get_type;

    extern fn g_object_ref(p_self: *camel.SaslDigestMd5) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslDigestMd5) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslDigestMd5, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslGssapi = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslGssapiClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslGssapiPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_gssapi_is_available() c_int;
    pub const isAvailable = camel_sasl_gssapi_is_available;

    /// Set host and user to use, instead of those in CamelService's settings.
    /// It's both or none, aka either set both, or the settings values are used.
    /// This is used to not require CamelService instance at all.
    extern fn camel_sasl_gssapi_override_host_and_user(p_sasl: *SaslGssapi, p_override_host: ?[*:0]const u8, p_override_user: ?[*:0]const u8) void;
    pub const overrideHostAndUser = camel_sasl_gssapi_override_host_and_user;

    extern fn camel_sasl_gssapi_get_type() usize;
    pub const getGObjectType = camel_sasl_gssapi_get_type;

    extern fn g_object_ref(p_self: *camel.SaslGssapi) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslGssapi) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslGssapi, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslLogin = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslLoginClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslLoginPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_login_get_type() usize;
    pub const getGObjectType = camel_sasl_login_get_type;

    extern fn g_object_ref(p_self: *camel.SaslLogin) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslLogin) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslLogin, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslNTLM = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslNTLMClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslNTLMPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_ntlm_get_type() usize;
    pub const getGObjectType = camel_sasl_ntlm_get_type;

    extern fn g_object_ref(p_self: *camel.SaslNTLM) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslNTLM) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslNTLM, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPOPB4SMTP = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslPOPB4SMTPClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslPOPB4SMTPPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_popb4smtp_get_type() usize;
    pub const getGObjectType = camel_sasl_popb4smtp_get_type;

    extern fn g_object_ref(p_self: *camel.SaslPOPB4SMTP) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslPOPB4SMTP) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslPOPB4SMTP, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPlain = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslPlainClass;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslPlainPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_plain_get_type() usize;
    pub const getGObjectType = camel_sasl_plain_get_type;

    extern fn g_object_ref(p_self: *camel.SaslPlain) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslPlain) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslPlain, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2 = extern struct {
    pub const Parent = camel.Sasl;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslXOAuth2Class;
    f_parent: camel.Sasl,
    f_priv: ?*camel.SaslXOAuth2Private,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_xoauth2_get_type() usize;
    pub const getGObjectType = camel_sasl_xoauth2_get_type;

    extern fn g_object_ref(p_self: *camel.SaslXOAuth2) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslXOAuth2) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslXOAuth2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2Google = extern struct {
    pub const Parent = camel.SaslXOAuth2;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslXOAuth2GoogleClass;
    f_parent: camel.SaslXOAuth2,
    f_priv: ?*camel.SaslXOAuth2GooglePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_xoauth2_google_get_type() usize;
    pub const getGObjectType = camel_sasl_xoauth2_google_get_type;

    extern fn g_object_ref(p_self: *camel.SaslXOAuth2Google) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslXOAuth2Google) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslXOAuth2Google, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2Outlook = extern struct {
    pub const Parent = camel.SaslXOAuth2;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslXOAuth2OutlookClass;
    f_parent: camel.SaslXOAuth2,
    f_priv: ?*camel.SaslXOAuth2OutlookPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_xoauth2_outlook_get_type() usize;
    pub const getGObjectType = camel_sasl_xoauth2_outlook_get_type;

    extern fn g_object_ref(p_self: *camel.SaslXOAuth2Outlook) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslXOAuth2Outlook) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslXOAuth2Outlook, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2Yahoo = extern struct {
    pub const Parent = camel.SaslXOAuth2;
    pub const Implements = [_]type{};
    pub const Class = camel.SaslXOAuth2YahooClass;
    f_parent: camel.SaslXOAuth2,
    f_priv: ?*camel.SaslXOAuth2YahooPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_sasl_xoauth2_yahoo_get_type() usize;
    pub const getGObjectType = camel_sasl_xoauth2_yahoo_get_type;

    extern fn g_object_ref(p_self: *camel.SaslXOAuth2Yahoo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.SaslXOAuth2Yahoo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaslXOAuth2Yahoo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Service = extern struct {
    pub const Parent = camel.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = camel.ServiceClass;
    f_parent: camel.Object,
    f_priv: ?*camel.ServicePrivate,

    pub const virtual_methods = struct {
        /// Attempts to authenticate `service` using `mechanism` and, if necessary,
        /// `service`'s `camel.Service.properties.password` property.  The function makes only
        /// ONE attempt at authentication and does not loop.
        ///
        /// If the authentication attempt completed and the server accepted the
        /// credentials, the function returns `CAMEL_AUTHENTICATION_ACCEPTED`.
        ///
        /// If the authentication attempt completed but the server rejected the
        /// credentials, the function returns `CAMEL_AUTHENTICATION_REJECTED`.
        ///
        /// If the authentication attempt failed to complete due to a network
        /// communication issue or some other mishap, the function sets `error`
        /// and returns `CAMEL_AUTHENTICATION_ERROR`.
        ///
        /// Generally this function should only be called from a `camel.Session`
        /// subclass in order to implement its own authentication loop.
        pub const authenticate_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) camel.AuthenticationResult {
                return gobject.ext.as(Service.Class, p_class).f_authenticate_sync.?(gobject.ext.as(Service, p_service), p_mechanism, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) camel.AuthenticationResult) void {
                gobject.ext.as(Service.Class, p_class).f_authenticate_sync = @ptrCast(p_implementation);
            }
        };

        /// Connects `service` to a remote server using the information in its
        /// `camel.Service.properties.settings` instance.
        ///
        /// If a connect operation is already in progress when this function is
        /// called, its results will be reflected in this connect operation.
        pub const connect_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Service.Class, p_class).f_connect_sync.?(gobject.ext.as(Service, p_service), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Service.Class, p_class).f_connect_sync = @ptrCast(p_implementation);
            }
        };

        /// Disconnect from the service. If `clean` is `FALSE`, it should not
        /// try to do any synchronizing or other cleanup of the connection.
        ///
        /// If a disconnect operation is already in progress when this function is
        /// called, its results will be reflected in this disconnect operation.
        ///
        /// If any connect operations are in progress when this function is called,
        /// they will be cancelled.
        pub const disconnect_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clean: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Service.Class, p_class).f_disconnect_sync.?(gobject.ext.as(Service, p_service), p_clean, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clean: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Service.Class, p_class).f_disconnect_sync = @ptrCast(p_implementation);
            }
        };

        /// This gets the name of the service in a "friendly" (suitable for
        /// humans) form. If `brief` is `TRUE`, this should be a brief description
        /// such as for use in the folder tree. If `brief` is `FALSE`, it should
        /// be a more complete and mostly unambiguous description.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_brief: c_int) [*:0]u8 {
                return gobject.ext.as(Service.Class, p_class).f_get_name.?(gobject.ext.as(Service, p_service), p_brief);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_brief: c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Service.Class, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// Obtains a list of authentication types supported by `service`.
        /// Free the returned list with `glib.List.free`.
        pub const query_auth_types_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.List {
                return gobject.ext.as(Service.Class, p_class).f_query_auth_types_sync.?(gobject.ext.as(Service, p_service), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.List) void {
                gobject.ext.as(Service.Class, p_class).f_query_auth_types_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const connection_status = struct {
            pub const name = "connection-status";

            pub const Type = camel.ServiceConnectionStatus;
        };

        pub const display_name = struct {
            pub const name = "display-name";

            pub const Type = ?[*:0]u8;
        };

        pub const password = struct {
            pub const name = "password";

            pub const Type = ?[*:0]u8;
        };

        pub const provider = struct {
            pub const name = "provider";

            pub const Type = ?*camel.Provider;
        };

        pub const proxy_resolver = struct {
            pub const name = "proxy-resolver";

            pub const Type = ?*gio.ProxyResolver;
        };

        pub const session = struct {
            pub const name = "session";

            pub const Type = ?*camel.Session;
        };

        pub const settings = struct {
            pub const name = "settings";

            pub const Type = ?*camel.Settings;
        };

        pub const uid = struct {
            pub const name = "uid";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Asynchronously attempts to authenticate `service` using `mechanism` and,
    /// if necessary, `service`'s `camel.Service.properties.password` property.  The function
    /// makes only ONE attempt at authentication and does not loop.
    ///
    /// Generally this function should only be called from a `camel.Session`
    /// subclass in order to implement its own authentication loop.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Service.authenticateFinish` to get the result of
    /// the operation.
    extern fn camel_service_authenticate(p_service: *Service, p_mechanism: ?[*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const authenticate = camel_service_authenticate;

    /// Finishes the operation started with `camel.Service.authenticate`.
    ///
    /// If the authentication attempt completed and the server accepted the
    /// credentials, the function returns `CAMEL_AUTHENTICATION_ACCEPTED`.
    ///
    /// If the authentication attempt completed but the server rejected the
    /// credentials, the function returns `CAMEL_AUTHENTICATION_REJECTED`.
    ///
    /// If the authentication attempt failed to complete due to a network
    /// communication issue or some other mishap, the function sets `error`
    /// and returns `CAMEL_AUTHENTICATION_ERROR`.
    extern fn camel_service_authenticate_finish(p_service: *Service, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) camel.AuthenticationResult;
    pub const authenticateFinish = camel_service_authenticate_finish;

    /// Attempts to authenticate `service` using `mechanism` and, if necessary,
    /// `service`'s `camel.Service.properties.password` property.  The function makes only
    /// ONE attempt at authentication and does not loop.
    ///
    /// If the authentication attempt completed and the server accepted the
    /// credentials, the function returns `CAMEL_AUTHENTICATION_ACCEPTED`.
    ///
    /// If the authentication attempt completed but the server rejected the
    /// credentials, the function returns `CAMEL_AUTHENTICATION_REJECTED`.
    ///
    /// If the authentication attempt failed to complete due to a network
    /// communication issue or some other mishap, the function sets `error`
    /// and returns `CAMEL_AUTHENTICATION_ERROR`.
    ///
    /// Generally this function should only be called from a `camel.Session`
    /// subclass in order to implement its own authentication loop.
    extern fn camel_service_authenticate_sync(p_service: *Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) camel.AuthenticationResult;
    pub const authenticateSync = camel_service_authenticate_sync;

    /// Asynchronously connects `service` to a remote server using the information
    /// in its `camel.Service.properties.settings` instance.
    ///
    /// If a connect operation is already in progress when this function is
    /// called, its results will be reflected in this connect operation.
    ///
    /// If any disconnect operations are in progress when this function is
    /// called, they will be cancelled.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Service.connectFinish` to get the result of the
    /// operation.
    extern fn camel_service_connect(p_service: *Service, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const connect = camel_service_connect;

    /// Finishes the operation started with `camel.Service.connect`.
    extern fn camel_service_connect_finish(p_service: *Service, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const connectFinish = camel_service_connect_finish;

    /// Connects `service` to a remote server using the information in its
    /// `camel.Service.properties.settings` instance.
    ///
    /// If a connect operation is already in progress when this function is
    /// called, its results will be reflected in this connect operation.
    extern fn camel_service_connect_sync(p_service: *Service, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const connectSync = camel_service_connect_sync;

    /// If a disconnect operation is already in progress when this function is
    /// called, its results will be reflected in this disconnect operation.
    ///
    /// If any connect operations are in progress when this function is called,
    /// they will be cancelled.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Service.disconnectFinish` to get the result of the
    /// operation.
    extern fn camel_service_disconnect(p_service: *Service, p_clean: c_int, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const disconnect = camel_service_disconnect;

    /// Finishes the operation started with `camel.Service.disconnect`.
    extern fn camel_service_disconnect_finish(p_service: *Service, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const disconnectFinish = camel_service_disconnect_finish;

    /// Disconnect from the service. If `clean` is `FALSE`, it should not
    /// try to do any synchronizing or other cleanup of the connection.
    ///
    /// If a disconnect operation is already in progress when this function is
    /// called, its results will be reflected in this disconnect operation.
    ///
    /// If any connect operations are in progress when this function is called,
    /// they will be cancelled.
    extern fn camel_service_disconnect_sync(p_service: *Service, p_clean: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const disconnectSync = camel_service_disconnect_sync;

    /// Thread-safe variation of `camel.Service.getDisplayName`.
    /// Use this function when accessing `service` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_service_dup_display_name(p_service: *Service) ?[*:0]u8;
    pub const dupDisplayName = camel_service_dup_display_name;

    /// Thread-safe variation of `camel.Service.getPassword`.
    /// Use this function when accessing `service` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_service_dup_password(p_service: *Service) [*:0]u8;
    pub const dupPassword = camel_service_dup_password;

    /// Returns the connection status for `service`.
    extern fn camel_service_get_connection_status(p_service: *Service) camel.ServiceConnectionStatus;
    pub const getConnectionStatus = camel_service_get_connection_status;

    /// Returns the display name for `service`, or `NULL` if `service` has not
    /// been given a display name.  The display name is intended for use in
    /// a user interface and should generally be given a user-defined name.
    ///
    /// Compare this with `camel.Service.getName`, which returns a built-in
    /// description of the type of service (IMAP, SMTP, etc.).
    extern fn camel_service_get_display_name(p_service: *Service) ?[*:0]const u8;
    pub const getDisplayName = camel_service_get_display_name;

    /// This gets the name of the service in a "friendly" (suitable for
    /// humans) form. If `brief` is `TRUE`, this should be a brief description
    /// such as for use in the folder tree. If `brief` is `FALSE`, it should
    /// be a more complete and mostly unambiguous description.
    extern fn camel_service_get_name(p_service: *Service, p_brief: c_int) [*:0]u8;
    pub const getName = camel_service_get_name;

    /// Returns the password for `service`.  Some SASL mechanisms use this
    /// when attempting to authenticate.
    extern fn camel_service_get_password(p_service: *Service) [*:0]const u8;
    pub const getPassword = camel_service_get_password;

    /// Gets the `camel.Provider` associated with the service.
    extern fn camel_service_get_provider(p_service: *Service) *camel.Provider;
    pub const getProvider = camel_service_get_provider;

    /// Gets the unique identifier string associated with the service.
    extern fn camel_service_get_uid(p_service: *Service) [*:0]const u8;
    pub const getUid = camel_service_get_uid;

    /// Returns the base directory under which to store cache data
    /// for `service`.  The directory is formed by appending the directory
    /// returned by `camel.Session.getUserCacheDir` with the service's
    /// `camel.Service.properties.uid` value.
    extern fn camel_service_get_user_cache_dir(p_service: *Service) [*:0]const u8;
    pub const getUserCacheDir = camel_service_get_user_cache_dir;

    /// Returns the base directory under which to store user-specific data
    /// for `service`.  The directory is formed by appending the directory
    /// returned by `camel.Session.getUserDataDir` with the service's
    /// `camel.Service.properties.uid` value.
    extern fn camel_service_get_user_data_dir(p_service: *Service) [*:0]const u8;
    pub const getUserDataDir = camel_service_get_user_data_dir;

    /// Performs any necessary file migrations for `service`.  This should be
    /// called after installing or configuring the `service`'s `camel.Settings`,
    /// since it requires building a URL string for `service`.
    extern fn camel_service_migrate_files(p_service: *Service) void;
    pub const migrateFiles = camel_service_migrate_files;

    /// Returns a new `camel.URL` representing `service`.
    /// Free the returned `camel.URL` with `camel.URL.free`.
    extern fn camel_service_new_camel_url(p_service: *Service) *camel.URL;
    pub const newCamelUrl = camel_service_new_camel_url;

    /// Asynchronously obtains a list of authentication types supported by
    /// `service`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Service.queryAuthTypesFinish` to get the result
    /// of the operation.
    extern fn camel_service_query_auth_types(p_service: *Service, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const queryAuthTypes = camel_service_query_auth_types;

    /// Finishes the operation started with `camel.Service.queryAuthTypes`.
    /// Free the returned list with `glib.List.free`.
    extern fn camel_service_query_auth_types_finish(p_service: *Service, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.List;
    pub const queryAuthTypesFinish = camel_service_query_auth_types_finish;

    /// Obtains a list of authentication types supported by `service`.
    /// Free the returned list with `glib.List.free`.
    extern fn camel_service_query_auth_types_sync(p_service: *Service, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.List;
    pub const queryAuthTypesSync = camel_service_query_auth_types_sync;

    /// Adds `task` to a queue of waiting tasks with the same source object.
    /// Queued tasks execute one at a time in the order they were added.  When
    /// `task` reaches the front of the queue, it will be dispatched by invoking
    /// `task_func` in a separate thread.  If `task` is cancelled while queued,
    /// it will complete immediately with an appropriate error.
    ///
    /// This is primarily intended for use by `camel.Store`, `camel.Transport` and
    /// `camel.Folder` to achieve ordered invocation of synchronous class methods.
    extern fn camel_service_queue_task(p_service: *Service, p_task: *gio.Task, p_task_func: gio.TaskThreadFunc) void;
    pub const queueTask = camel_service_queue_task;

    /// Returns the `gio.ProxyResolver` for `service`.  If an application needs to
    /// override this, it should do so prior to calling functions on `service`
    /// that may require a network connection.
    ///
    /// The returned `gio.ProxyResolver` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_service_ref_proxy_resolver(p_service: *Service) ?*gio.ProxyResolver;
    pub const refProxyResolver = camel_service_ref_proxy_resolver;

    /// Returns the `camel.Session` associated with the service.
    ///
    /// The returned `camel.Session` is referenced for thread-safety.  Unreference
    /// the `camel.Session` with `gobject.Object.unref` when finished with it.
    extern fn camel_service_ref_session(p_service: *Service) *camel.Session;
    pub const refSession = camel_service_ref_session;

    /// Returns the `camel.Settings` instance associated with the service.
    ///
    /// The returned `camel.Settings` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_service_ref_settings(p_service: *Service) *camel.Settings;
    pub const refSettings = camel_service_ref_settings;

    /// Assigns a UTF-8 display name to `service`.  The display name is intended
    /// for use in a user interface and should generally be given a user-defined
    /// name.
    ///
    /// Compare this with `camel.Service.getName`, which returns a built-in
    /// description of the type of service (IMAP, SMTP, etc.).
    extern fn camel_service_set_display_name(p_service: *Service, p_display_name: ?[*:0]const u8) void;
    pub const setDisplayName = camel_service_set_display_name;

    /// Sets the password for `service`.  Use this function to cache the password
    /// in memory after obtaining it through `camel.Session.getPassword`.  Some
    /// SASL mechanisms use this when attempting to authenticate.
    extern fn camel_service_set_password(p_service: *Service, p_password: [*:0]const u8) void;
    pub const setPassword = camel_service_set_password;

    /// Sets the `gio.ProxyResolver` for `service`.  If an application needs to
    /// override this, it should do so prior to calling functions on `service`
    /// that may require a network connection.
    extern fn camel_service_set_proxy_resolver(p_service: *Service, p_proxy_resolver: ?*gio.ProxyResolver) void;
    pub const setProxyResolver = camel_service_set_proxy_resolver;

    /// Associates a new `camel.Settings` instance with the service.
    /// The `settings` instance must match the settings type defined in
    /// `camel.ServiceClass`.  If `settings` is `NULL`, a new `camel.Settings`
    /// instance of the appropriate type is created with all properties
    /// set to defaults.
    extern fn camel_service_set_settings(p_service: *Service, p_settings: ?*camel.Settings) void;
    pub const setSettings = camel_service_set_settings;

    extern fn camel_service_get_type() usize;
    pub const getGObjectType = camel_service_get_type;

    extern fn g_object_ref(p_self: *camel.Service) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Service) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Service, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Session = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.SessionClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.SessionPrivate,

    pub const virtual_methods = struct {
        /// Instantiates a new `camel.Service` for `session`.  The `uid` identifies the
        /// service for future lookup.  The `protocol` indicates which `camel.Provider`
        /// holds the `gobject.Type` of the `camel.Service` subclass to instantiate.  The `type`
        /// explicitly designates the service as a `camel.Store` or `camel.Transport`.
        ///
        /// If the given `uid` has already been added, the existing `camel.Service`
        /// with that `uid` is returned regardless of whether it agrees with the
        /// given `protocol` and `type`.
        ///
        /// If no `camel.Provider` is available to handle the given `protocol`, or
        /// if the `camel.Provider` does not specify a valid `gobject.Type` for `type`, the
        /// function sets `error` and returns `NULL`.
        ///
        /// The returned `camel.Service` is referenced for thread-safety and must be
        /// unreferenced with `gobject.Object.unref` when finished with it.
        pub const add_service = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_protocol: [*:0]const u8, p_type: camel.ProviderType, p_error: ?*?*glib.Error) ?*camel.Service {
                return gobject.ext.as(Session.Class, p_class).f_add_service.?(gobject.ext.as(Session, p_session), p_uid, p_protocol, p_type, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_protocol: [*:0]const u8, p_type: camel.ProviderType, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Service) void {
                gobject.ext.as(Session.Class, p_class).f_add_service = @ptrCast(p_implementation);
            }
        };

        /// Look up in an address book `book_uid` for an address `email_address`
        /// and returns whether any such contact exists.
        ///
        /// The `book_uid` can be either one of the special constants
        /// `CAMEL_SESSION_BOOK_UID_ANY` or `CAMEL_SESSION_BOOK_UID_COMPLETION`,
        /// or it can be a UID of a configured address book.
        ///
        /// The `email_address` can contain multiple addresses, then the function
        /// checks whether any of the given addresses is in the address book.
        pub const addressbook_contains_sync = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book_uid: [*:0]const u8, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_addressbook_contains_sync.?(gobject.ext.as(Session, p_session), p_book_uid, p_email_address, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book_uid: [*:0]const u8, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_addressbook_contains_sync = @ptrCast(p_implementation);
            }
        };

        /// Authenticates `service`, which may involve repeated calls to
        /// `camel.Service.authenticate` or `camel.Service.authenticateSync`.
        /// A `camel.Session` subclass is largely responsible for implementing this,
        /// and should handle things like user prompts and secure password storage.
        /// These issues are out-of-scope for Camel.
        ///
        /// If an error occurs, or if authentication is aborted, the function sets
        /// `error` and returns `FALSE`.
        pub const authenticate_sync = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_authenticate_sync.?(gobject.ext.as(Session, p_session), p_service, p_mechanism, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_authenticate_sync = @ptrCast(p_implementation);
            }
        };

        /// This function is used by a `camel.Service` to tell the application
        /// that the authentication information it provided via
        /// `camel.Session.getPassword` was rejected by the service. If the
        /// application was caching this information, it should stop,
        /// and if the service asks for it again, it should ask the user.
        ///
        /// `service` and `item` identify the rejected authentication information,
        /// as with `camel.Session.getPassword`.
        pub const forget_password = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_item: [*:0]const u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_forget_password.?(gobject.ext.as(Session, p_session), p_service, p_item, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_item: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_forget_password = @ptrCast(p_implementation);
            }
        };

        /// Forwards `message` in `folder` to the email address(es) given by `address`.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const forward_to_sync = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_forward_to_sync.?(gobject.ext.as(Session, p_session), p_folder, p_message, p_address, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_forward_to_sync = @ptrCast(p_implementation);
            }
        };

        /// The optional `for_folder` can be used to determine which filters
        /// to add and which not.
        pub const get_filter_driver = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_type: [*:0]const u8, p_for_folder: ?*camel.Folder, p_error: ?*?*glib.Error) ?*camel.FilterDriver {
                return gobject.ext.as(Session.Class, p_class).f_get_filter_driver.?(gobject.ext.as(Session, p_session), p_type, p_for_folder, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_type: [*:0]const u8, p_for_folder: ?*camel.Folder, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FilterDriver) void {
                gobject.ext.as(Session.Class, p_class).f_get_filter_driver = @ptrCast(p_implementation);
            }
        };

        /// Obtains the OAuth 2.0 access token for `service` along with its expiry
        /// in seconds from the current time (or 0 if unknown).
        ///
        /// Free the returned access token with `glib.free` when no longer needed.
        pub const get_oauth2_access_token_sync = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_get_oauth2_access_token_sync.?(gobject.ext.as(Session, p_session), p_service, p_out_access_token, p_out_expires_in, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_get_oauth2_access_token_sync = @ptrCast(p_implementation);
            }
        };

        /// This function is used by a `camel.Service` to ask the application and
        /// the user for a password or other authentication data.
        ///
        /// `service` and `item` together uniquely identify the piece of data the
        /// caller is concerned with.
        ///
        /// `prompt` is a question to ask the user (if the application doesn't
        /// already have the answer cached). If `CAMEL_SESSION_PASSWORD_SECRET`
        /// is set, the user's input will not be echoed back.
        ///
        /// If `CAMEL_SESSION_PASSWORD_STATIC` is set, it means the password returned
        /// will be stored statically by the caller automatically, for the current
        /// session.
        ///
        /// The authenticator should set `error` to `G_IO_ERROR_CANCELLED` if
        /// the user did not provide the information. The caller must `glib.free`
        /// the information returned when it is done with it.
        pub const get_password = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_prompt: [*:0]const u8, p_item: [*:0]const u8, p_flags: u32, p_error: ?*?*glib.Error) ?[*:0]u8 {
                return gobject.ext.as(Session.Class, p_class).f_get_password.?(gobject.ext.as(Session, p_session), p_service, p_prompt, p_item, p_flags, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_prompt: [*:0]const u8, p_item: [*:0]const u8, p_flags: u32, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(Session.Class, p_class).f_get_password = @ptrCast(p_implementation);
            }
        };

        /// Searches for S/MIME certificates or PGP keys for the given `recipients`,
        /// which are returned as base64 encoded strings in `out_certificates`.
        /// This is used when encrypting messages. The `flags` influence what
        /// the `out_certificates` will contain. The order of items in `out_certificates`
        /// should match the order of items in `recipients`, with `NULL` data for those
        /// which could not be found.
        ///
        /// The function should return failure only if some fatal error happened.
        /// It's not an error when certificates for some, or all, recipients
        /// could not be found.
        ///
        /// This method is optional and the default implementation returns `TRUE`
        /// and sets the `out_certificates` to `NULL`. It's the only exception
        /// when the length of `recipients` and `out_certificates` can differ.
        /// In all other cases the length of the two should match.
        ///
        /// The `out_certificates` will be freed with g_slist_free_full (certificates, g_free);
        /// when done with it.
        pub const get_recipient_certificates_sync = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_flags: u32, p_recipients: *const glib.PtrArray, p_out_certificates: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Session.Class, p_class).f_get_recipient_certificates_sync.?(gobject.ext.as(Session, p_session), p_flags, p_recipients, p_out_certificates, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_flags: u32, p_recipients: *const glib.PtrArray, p_out_certificates: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_get_recipient_certificates_sync = @ptrCast(p_implementation);
            }
        };

        pub const job_finished = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: *const glib.Error) void {
                return gobject.ext.as(Session.Class, p_class).f_job_finished.?(gobject.ext.as(Session, p_session), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_job_finished = @ptrCast(p_implementation);
            }
        };

        pub const job_started = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(Session.Class, p_class).f_job_started.?(gobject.ext.as(Session, p_session), p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_job_started = @ptrCast(p_implementation);
            }
        };

        /// Looks up for the `name` in address books.
        pub const lookup_addressbook = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) c_int {
                return gobject.ext.as(Session.Class, p_class).f_lookup_addressbook.?(gobject.ext.as(Session, p_session), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Session.Class, p_class).f_lookup_addressbook = @ptrCast(p_implementation);
            }
        };

        /// Removes a `camel.Service` previously added by `camel.Session.addService`.
        pub const remove_service = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service) void {
                return gobject.ext.as(Session.Class, p_class).f_remove_service.?(gobject.ext.as(Session, p_session), p_service);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_remove_service = @ptrCast(p_implementation);
            }
        };

        /// Prompts the user whether to accept `certificate` for `service`.  The
        /// set of flags given in `errors` indicate why the `certificate` failed
        /// validation.
        ///
        /// If an error occurs during prompting or if the user declines to respond,
        /// the function returns `CAMEL_CERT_TRUST_UNKNOWN` and the certificate will
        /// be rejected.
        pub const trust_prompt = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_certificate: *gio.TlsCertificate, p_errors: gio.TlsCertificateFlags) camel.CertTrust {
                return gobject.ext.as(Session.Class, p_class).f_trust_prompt.?(gobject.ext.as(Session, p_session), p_service, p_certificate, p_errors);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_certificate: *gio.TlsCertificate, p_errors: gio.TlsCertificateFlags) callconv(.c) camel.CertTrust) void {
                gobject.ext.as(Session.Class, p_class).f_trust_prompt = @ptrCast(p_implementation);
            }
        };

        /// Emits a `camel.Session.properties.user_alert` signal from an idle source on the main
        /// loop.  The idle source's priority is `G_PRIORITY_LOW`.
        ///
        /// The purpose of the signal is to propagate a server-issued alert message
        /// from `service` to a user interface.  The `type` hints at the nature of the
        /// alert message.
        pub const user_alert = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_type: camel.SessionAlertType, p_message: [*:0]const u8) void {
                return gobject.ext.as(Session.Class, p_class).f_user_alert.?(gobject.ext.as(Session, p_session), p_service, p_type, p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_service: *camel.Service, p_type: camel.SessionAlertType, p_message: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_user_alert = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const junk_filter = struct {
            pub const name = "junk-filter";

            pub const Type = ?*camel.JunkFilter;
        };

        pub const main_context = struct {
            pub const name = "main-context";

            pub const Type = ?*glib.MainContext;
        };

        pub const network_monitor = struct {
            pub const name = "network-monitor";

            pub const Type = ?*gio.NetworkMonitor;
        };

        pub const online = struct {
            pub const name = "online";

            pub const Type = c_int;
        };

        pub const user_cache_dir = struct {
            pub const name = "user-cache-dir";

            pub const Type = ?[*:0]u8;
        };

        pub const user_data_dir = struct {
            pub const name = "user-data-dir";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const job_finished = struct {
            pub const name = "job-finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: ?*gio.Cancellable, p_p0: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("job-finished", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const job_started = struct {
            pub const name = "job-started";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: ?*gio.Cancellable, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("job-started", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This purpose of this signal is to propagate a server-issued alert
        /// message from `service` to a user interface.  The `type` hints at the
        /// severity of the alert message.
        pub const user_alert = struct {
            pub const name = "user-alert";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_service: *camel.Service, p_type: camel.SessionAlertType, p_message: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("user-alert", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Instantiates a new `camel.Service` for `session`.  The `uid` identifies the
    /// service for future lookup.  The `protocol` indicates which `camel.Provider`
    /// holds the `gobject.Type` of the `camel.Service` subclass to instantiate.  The `type`
    /// explicitly designates the service as a `camel.Store` or `camel.Transport`.
    ///
    /// If the given `uid` has already been added, the existing `camel.Service`
    /// with that `uid` is returned regardless of whether it agrees with the
    /// given `protocol` and `type`.
    ///
    /// If no `camel.Provider` is available to handle the given `protocol`, or
    /// if the `camel.Provider` does not specify a valid `gobject.Type` for `type`, the
    /// function sets `error` and returns `NULL`.
    ///
    /// The returned `camel.Service` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_session_add_service(p_session: *Session, p_uid: [*:0]const u8, p_protocol: [*:0]const u8, p_type: camel.ProviderType, p_error: ?*?*glib.Error) ?*camel.Service;
    pub const addService = camel_session_add_service;

    /// Look up in an address book `book_uid` for an address `email_address`
    /// and returns whether any such contact exists.
    ///
    /// The `book_uid` can be either one of the special constants
    /// `CAMEL_SESSION_BOOK_UID_ANY` or `CAMEL_SESSION_BOOK_UID_COMPLETION`,
    /// or it can be a UID of a configured address book.
    ///
    /// The `email_address` can contain multiple addresses, then the function
    /// checks whether any of the given addresses is in the address book.
    extern fn camel_session_addressbook_contains_sync(p_session: *Session, p_book_uid: [*:0]const u8, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addressbookContainsSync = camel_session_addressbook_contains_sync;

    /// Asynchronously authenticates `service`, which may involve repeated calls
    /// to `camel.Service.authenticate` or `camel.Service.authenticateSync`.
    /// A `camel.Session` subclass is largely responsible for implementing this,
    /// and should handle things like user prompts and secure password storage.
    /// These issues are out-of-scope for Camel.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Session.authenticateFinish` to get the result of
    /// the operation.
    extern fn camel_session_authenticate(p_session: *Session, p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const authenticate = camel_session_authenticate;

    /// Finishes the operation started with `camel.Session.authenticate`.
    ///
    /// If an error occurred, or if authentication was aborted, the function
    /// sets `error` and returns `FALSE`.
    extern fn camel_session_authenticate_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const authenticateFinish = camel_session_authenticate_finish;

    /// Authenticates `service`, which may involve repeated calls to
    /// `camel.Service.authenticate` or `camel.Service.authenticateSync`.
    /// A `camel.Session` subclass is largely responsible for implementing this,
    /// and should handle things like user prompts and secure password storage.
    /// These issues are out-of-scope for Camel.
    ///
    /// If an error occurs, or if authentication is aborted, the function sets
    /// `error` and returns `FALSE`.
    extern fn camel_session_authenticate_sync(p_session: *Session, p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const authenticateSync = camel_session_authenticate_sync;

    /// This function is used by a `camel.Service` to tell the application
    /// that the authentication information it provided via
    /// `camel.Session.getPassword` was rejected by the service. If the
    /// application was caching this information, it should stop,
    /// and if the service asks for it again, it should ask the user.
    ///
    /// `service` and `item` identify the rejected authentication information,
    /// as with `camel.Session.getPassword`.
    extern fn camel_session_forget_password(p_session: *Session, p_service: *camel.Service, p_item: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const forgetPassword = camel_session_forget_password;

    /// Asynchronously forwards `message` in `folder` to the email address(s)
    /// given by `address`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Session.forwardToFinish` to get the result of the
    /// operation.
    extern fn camel_session_forward_to(p_session: *Session, p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_address: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const forwardTo = camel_session_forward_to;

    /// Finishes the operation started with `camel.Session.forwardTo`.
    ///
    /// If an error occurred, the function sets `error` and returns `FALSE`.
    extern fn camel_session_forward_to_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const forwardToFinish = camel_session_forward_to_finish;

    /// Forwards `message` in `folder` to the email address(es) given by `address`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn camel_session_forward_to_sync(p_session: *Session, p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const forwardToSync = camel_session_forward_to_sync;

    /// The optional `for_folder` can be used to determine which filters
    /// to add and which not.
    extern fn camel_session_get_filter_driver(p_session: *Session, p_type: [*:0]const u8, p_for_folder: ?*camel.Folder, p_error: ?*?*glib.Error) ?*camel.FilterDriver;
    pub const getFilterDriver = camel_session_get_filter_driver;

    /// Returns the `camel.JunkFilter` instance used to classify messages as
    /// junk or not junk during filtering.
    ///
    /// Note that `camel.JunkFilter` itself is just an interface.  The application
    /// must implement the interface and install a `camel.JunkFilter` instance for
    /// junk filtering to take place.
    extern fn camel_session_get_junk_filter(p_session: *Session) ?*camel.JunkFilter;
    pub const getJunkFilter = camel_session_get_junk_filter;

    extern fn camel_session_get_junk_headers(p_session: *Session) *const glib.HashTable;
    pub const getJunkHeaders = camel_session_get_junk_headers;

    /// Obtains the OAuth 2.0 access token for `service` along with its expiry
    /// in seconds from the current time (or 0 if unknown).
    ///
    /// Free the returned access token with `glib.free` when no longer needed.
    extern fn camel_session_get_oauth2_access_token_sync(p_session: *Session, p_service: *camel.Service, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getOauth2AccessTokenSync = camel_session_get_oauth2_access_token_sync;

    extern fn camel_session_get_online(p_session: *Session) c_int;
    pub const getOnline = camel_session_get_online;

    /// This function is used by a `camel.Service` to ask the application and
    /// the user for a password or other authentication data.
    ///
    /// `service` and `item` together uniquely identify the piece of data the
    /// caller is concerned with.
    ///
    /// `prompt` is a question to ask the user (if the application doesn't
    /// already have the answer cached). If `CAMEL_SESSION_PASSWORD_SECRET`
    /// is set, the user's input will not be echoed back.
    ///
    /// If `CAMEL_SESSION_PASSWORD_STATIC` is set, it means the password returned
    /// will be stored statically by the caller automatically, for the current
    /// session.
    ///
    /// The authenticator should set `error` to `G_IO_ERROR_CANCELLED` if
    /// the user did not provide the information. The caller must `glib.free`
    /// the information returned when it is done with it.
    extern fn camel_session_get_password(p_session: *Session, p_service: *camel.Service, p_prompt: [*:0]const u8, p_item: [*:0]const u8, p_flags: u32, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getPassword = camel_session_get_password;

    /// Searches for S/MIME certificates or PGP keys for the given `recipients`,
    /// which are returned as base64 encoded strings in `out_certificates`.
    /// This is used when encrypting messages. The `flags` influence what
    /// the `out_certificates` will contain. The order of items in `out_certificates`
    /// should match the order of items in `recipients`, with `NULL` data for those
    /// which could not be found.
    ///
    /// The function should return failure only if some fatal error happened.
    /// It's not an error when certificates for some, or all, recipients
    /// could not be found.
    ///
    /// This method is optional and the default implementation returns `TRUE`
    /// and sets the `out_certificates` to `NULL`. It's the only exception
    /// when the length of `recipients` and `out_certificates` can differ.
    /// In all other cases the length of the two should match.
    ///
    /// The `out_certificates` will be freed with g_slist_free_full (certificates, g_free);
    /// when done with it.
    extern fn camel_session_get_recipient_certificates_sync(p_session: *Session, p_flags: u32, p_recipients: *const glib.PtrArray, p_out_certificates: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getRecipientCertificatesSync = camel_session_get_recipient_certificates_sync;

    /// Returns the base directory under which to store user-specific mail cache.
    extern fn camel_session_get_user_cache_dir(p_session: *Session) [*:0]const u8;
    pub const getUserCacheDir = camel_session_get_user_cache_dir;

    /// Returns the base directory under which to store user-specific mail data.
    extern fn camel_session_get_user_data_dir(p_session: *Session) [*:0]const u8;
    pub const getUserDataDir = camel_session_get_user_data_dir;

    /// Adds a function to be called whenever there are no higher priority events
    /// pending.  If `function` returns `FALSE` it is automatically removed from the
    /// list of event sources and will not be called again.
    ///
    /// This internally creates a main loop source using `glib.idleSourceNew`
    /// and attaches it to `session`'s own `camel.Session.properties.main`-context using
    /// `glib.Source.attach`.
    ///
    /// The `priority` is typically in the range between `G_PRIORITY_DEFAULT_IDLE`
    /// and `G_PRIORITY_HIGH_IDLE`.
    extern fn camel_session_idle_add(p_session: *Session, p_priority: c_int, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
    pub const idleAdd = camel_session_idle_add;

    /// Returns a list of all `camel.Service` objects previously added using
    /// `camel.Session.addService`.
    ///
    /// The services returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned list itself with `glib.List.free`.
    ///
    /// An easy way to free the list property in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn camel_session_list_services(p_session: *Session) *glib.List;
    pub const listServices = camel_session_list_services;

    /// Looks up for the `name` in address books.
    extern fn camel_session_lookup_addressbook(p_session: *Session, p_name: [*:0]const u8) c_int;
    pub const lookupAddressbook = camel_session_lookup_addressbook;

    /// Returns the `glib.MainContext` on which event sources for `session` are to
    /// be attached.
    extern fn camel_session_ref_main_context(p_session: *Session) *glib.MainContext;
    pub const refMainContext = camel_session_ref_main_context;

    /// References a `gio.NetworkMonitor` instance, which had been previously set
    /// by `camel.Session.setNetworkMonitor`. If none is set, then the default
    /// `gio.NetworkMonitor` is returned, as provided by `gio.networkMonitorGetDefault`.
    /// The returned pointer is referenced for thread safety, unref it with
    /// `gobject.Object.unref` when no longer needed.
    extern fn camel_session_ref_network_monitor(p_session: *Session) *gio.NetworkMonitor;
    pub const refNetworkMonitor = camel_session_ref_network_monitor;

    /// Looks up a `camel.Service` by its unique identifier string.  The service
    /// must have been previously added using `camel.Session.addService`.
    ///
    /// The returned `camel.Service` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_session_ref_service(p_session: *Session, p_uid: [*:0]const u8) ?*camel.Service;
    pub const refService = camel_session_ref_service;

    /// Looks up a `camel.Service` by trying to match its `camel.URL` against the
    /// given `url` and then checking that the object is of the desired `type`.
    /// The service must have been previously added using
    /// `camel.Session.addService`.
    ///
    /// The returned `camel.Service` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// Note this function is significantly slower than `camel.Session.refService`.
    extern fn camel_session_ref_service_by_url(p_session: *Session, p_url: *camel.URL, p_type: camel.ProviderType) ?*camel.Service;
    pub const refServiceByUrl = camel_session_ref_service_by_url;

    /// Removes a `camel.Service` previously added by `camel.Session.addService`.
    extern fn camel_session_remove_service(p_session: *Session, p_service: *camel.Service) void;
    pub const removeService = camel_session_remove_service;

    /// Removes all `camel.Service` instances added by `camel.Session.addService`.
    ///
    /// This can be useful during application shutdown to ensure all `camel.Service`
    /// instances are freed properly, especially since `camel.Session` instances are
    /// prone to reference cycles.
    extern fn camel_session_remove_services(p_session: *Session) void;
    pub const removeServices = camel_session_remove_services;

    /// Installs the `camel.JunkFilter` instance used to classify messages as
    /// junk or not junk during filtering.
    ///
    /// Note that `camel.JunkFilter` itself is just an interface.  The application
    /// must implement the interface and install a `camel.JunkFilter` instance for
    /// junk filtering to take place.
    extern fn camel_session_set_junk_filter(p_session: *Session, p_junk_filter: ?*camel.JunkFilter) void;
    pub const setJunkFilter = camel_session_set_junk_filter;

    extern fn camel_session_set_junk_headers(p_session: *Session, p_headers: [*][*:0]const u8, p_values: [*][*:0]const u8, p_len: c_int) void;
    pub const setJunkHeaders = camel_session_set_junk_headers;

    /// Sets a network monitor instance for the `session`. This can be used
    /// to override which `gio.NetworkMonitor` should be used to check network
    /// availability and whether a server is reachable.
    extern fn camel_session_set_network_monitor(p_session: *Session, p_network_monitor: ?*gio.NetworkMonitor) void;
    pub const setNetworkMonitor = camel_session_set_network_monitor;

    /// Sets the online status of `session` to `online`.
    extern fn camel_session_set_online(p_session: *Session, p_online: c_int) void;
    pub const setOnline = camel_session_set_online;

    /// This function provides a simple mechanism for providers to initiate
    /// low-priority background jobs.  Jobs can be submitted from any thread,
    /// but execution of the jobs is always as follows:
    ///
    /// 1) The `camel.Session.properties.job`-started signal is emitted from the thread
    ///    in which `session` was created.  This is typically the same thread
    ///    that hosts the global default `glib.MainContext`, or "main" thread.
    ///
    /// 2) The `callback` function is invoked from a different thread where
    ///    it's safe to call synchronous functions.
    ///
    /// 3) Once `callback` has returned, the `CamelSesson.properties.job`-finished signal
    ///    is emitted from the same thread as `camel.Session.properties.job`-started was
    ///    emitted.
    ///
    /// 4) Finally if a `notify` function was provided, it is invoked and
    ///    passed `user_data` so that `user_data` can be freed.
    extern fn camel_session_submit_job(p_session: *Session, p_description: [*:0]const u8, p_callback: camel.SessionCallback, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
    pub const submitJob = camel_session_submit_job;

    /// Prompts the user whether to accept `certificate` for `service`.  The
    /// set of flags given in `errors` indicate why the `certificate` failed
    /// validation.
    ///
    /// If an error occurs during prompting or if the user declines to respond,
    /// the function returns `CAMEL_CERT_TRUST_UNKNOWN` and the certificate will
    /// be rejected.
    extern fn camel_session_trust_prompt(p_session: *Session, p_service: *camel.Service, p_certificate: *gio.TlsCertificate, p_errors: gio.TlsCertificateFlags) camel.CertTrust;
    pub const trustPrompt = camel_session_trust_prompt;

    /// Emits a `camel.Session.properties.user_alert` signal from an idle source on the main
    /// loop.  The idle source's priority is `G_PRIORITY_LOW`.
    ///
    /// The purpose of the signal is to propagate a server-issued alert message
    /// from `service` to a user interface.  The `type` hints at the nature of the
    /// alert message.
    extern fn camel_session_user_alert(p_session: *Session, p_service: *camel.Service, p_type: camel.SessionAlertType, p_message: [*:0]const u8) void;
    pub const userAlert = camel_session_user_alert;

    extern fn camel_session_get_type() usize;
    pub const getGObjectType = camel_session_get_type;

    extern fn g_object_ref(p_self: *camel.Session) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Session) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Session, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Settings = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.SettingsClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.SettingsPrivate,

    pub const virtual_methods = struct {
        /// Creates a copy of `settings`, such that passing `settings` and the
        /// copied instance to `camel.Settings.equal` would return `TRUE`.
        ///
        /// By default, this creates a new settings instance with the same `gobject.Type`
        /// as `settings`, and copies all `gobject.Object` property values from `settings`
        /// to the new instance.
        pub const clone = struct {
            pub fn call(p_class: anytype, p_settings: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *camel.Settings {
                return gobject.ext.as(Settings.Class, p_class).f_clone.?(gobject.ext.as(Settings, p_settings));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_settings: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *camel.Settings) void {
                gobject.ext.as(Settings.Class, p_class).f_clone = @ptrCast(p_implementation);
            }
        };

        /// Returns `TRUE` if `settings_a` and `settings_b` are equal.
        ///
        /// By default, equality requires both instances to have the same `gobject.Type`
        /// with the same set of `gobject.Object` properties, and each property value in
        /// `settings_a` is equal to the corresponding value in `settings_b`.
        pub const equal = struct {
            pub fn call(p_class: anytype, p_settings_a: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_settings_b: *camel.Settings) c_int {
                return gobject.ext.as(Settings.Class, p_class).f_equal.?(gobject.ext.as(Settings, p_settings_a), p_settings_b);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_settings_a: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_settings_b: *camel.Settings) callconv(.c) c_int) void {
                gobject.ext.as(Settings.Class, p_class).f_equal = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a copy of `settings`, such that passing `settings` and the
    /// copied instance to `camel.Settings.equal` would return `TRUE`.
    ///
    /// By default, this creates a new settings instance with the same `gobject.Type`
    /// as `settings`, and copies all `gobject.Object` property values from `settings`
    /// to the new instance.
    extern fn camel_settings_clone(p_settings: *Settings) *camel.Settings;
    pub const clone = camel_settings_clone;

    /// Returns `TRUE` if `settings_a` and `settings_b` are equal.
    ///
    /// By default, equality requires both instances to have the same `gobject.Type`
    /// with the same set of `gobject.Object` properties, and each property value in
    /// `settings_a` is equal to the corresponding value in `settings_b`.
    extern fn camel_settings_equal(p_settings_a: *Settings, p_settings_b: *camel.Settings) c_int;
    pub const equal = camel_settings_equal;

    extern fn camel_settings_get_type() usize;
    pub const getGObjectType = camel_settings_get_type;

    extern fn g_object_ref(p_self: *camel.Settings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Settings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Settings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Store = extern struct {
    pub const Parent = camel.Service;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = camel.StoreClass;
    f_parent: camel.Service,
    f_priv: ?*camel.StorePrivate,

    pub const virtual_methods = struct {
        /// Returns if this folder (param info) should be checked for new mail or not.
        /// It should not look into sub infos (info->child) or next infos, it should
        /// return value only for the actual folder info.
        /// Default behavior is that all Inbox folders are intended to be refreshed.
        pub const can_refresh_folder = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.FolderInfo, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Store.Class, p_class).f_can_refresh_folder.?(gobject.ext.as(Store, p_store), p_info, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.FolderInfo, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_can_refresh_folder = @ptrCast(p_implementation);
            }
        };

        /// Creates a new folder as a child of an existing folder.
        /// `parent_name` can be `NULL` to create a new top-level folder.
        /// The returned `camel.FolderInfo` struct should be freed with
        /// `camel.FolderInfo.free`.
        pub const create_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parent_name: ?[*:0]const u8, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderInfo {
                return gobject.ext.as(Store.Class, p_class).f_create_folder_sync.?(gobject.ext.as(Store, p_store), p_parent_name, p_folder_name, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parent_name: ?[*:0]const u8, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderInfo) void {
                gobject.ext.as(Store.Class, p_class).f_create_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Deletes the folder described by `folder_name`.  The folder must be empty.
        pub const delete_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Store.Class, p_class).f_delete_folder_sync.?(gobject.ext.as(Store, p_store), p_folder_name, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_delete_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Store.signals.folder`-created signal from an idle source on
        /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_created = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) void {
                return gobject.ext.as(Store.Class, p_class).f_folder_created.?(gobject.ext.as(Store, p_store), p_folder_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) callconv(.c) void) void {
                gobject.ext.as(Store.Class, p_class).f_folder_created = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Store.signals.folder`-deleted signal from an idle source on
        /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_deleted = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) void {
                return gobject.ext.as(Store.Class, p_class).f_folder_deleted.?(gobject.ext.as(Store, p_store), p_folder_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) callconv(.c) void) void {
                gobject.ext.as(Store.Class, p_class).f_folder_deleted = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Store.signals.folder`-info-stale signal from an idle source
        /// on the main loop.  The idle source's priority is `G_PRIORITY_LOW`.
        ///
        /// See the `camel.Store.signals.folder`-info-stale documentation for details on
        /// when to use this signal.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_info_stale = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Store.Class, p_class).f_folder_info_stale.?(gobject.ext.as(Store, p_store));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Store.Class, p_class).f_folder_info_stale = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Store.signals.folder`-opened signal from an idle source on
        /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_opened = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder: *camel.Folder) void {
                return gobject.ext.as(Store.Class, p_class).f_folder_opened.?(gobject.ext.as(Store, p_store), p_folder);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder: *camel.Folder) callconv(.c) void) void {
                gobject.ext.as(Store.Class, p_class).f_folder_opened = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Store.signals.folder`-renamed signal from an idle source on
        /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_renamed = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8, p_folder_info: *camel.FolderInfo) void {
                return gobject.ext.as(Store.Class, p_class).f_folder_renamed.?(gobject.ext.as(Store, p_store), p_old_name, p_folder_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8, p_folder_info: *camel.FolderInfo) callconv(.c) void) void {
                gobject.ext.as(Store.Class, p_class).f_folder_renamed = @ptrCast(p_implementation);
            }
        };

        /// Returns whether there can be done automatic save of folder changes.
        /// Default is TRUE. The descendants can overwrite it with CamelStoreClass::`get_can_auto_save_changes`.
        pub const get_can_auto_save_changes = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Store.Class, p_class).f_get_can_auto_save_changes.?(gobject.ext.as(Store, p_store));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_get_can_auto_save_changes = @ptrCast(p_implementation);
            }
        };

        /// This fetches information about the folder structure of `store`,
        /// starting with `top`, and returns a tree of `camel.FolderInfo`
        /// structures. If `flags` includes `CAMEL_STORE_FOLDER_INFO_SUBSCRIBED`,
        /// only subscribed folders will be listed.   If the store doesn't support
        /// subscriptions, then it will list all folders.  If `flags` includes
        /// `CAMEL_STORE_FOLDER_INFO_RECURSIVE`, the returned tree will include
        /// all levels of hierarchy below `top`. If not, it will only include
        /// the immediate subfolders of `top`. If `flags` includes
        /// `CAMEL_STORE_FOLDER_INFO_FAST`, the unread_message_count fields of
        /// some or all of the structures may be set to -1, if the store cannot
        /// determine that information quickly.  If `flags` includes
        /// `CAMEL_STORE_FOLDER_INFO_NO_VIRTUAL`, don't include special virtual
        /// folders (such as vTrash or vJunk).
        ///
        /// The returned `camel.FolderInfo` tree should be freed with
        /// `camel.FolderInfo.free`.
        ///
        /// The CAMEL_STORE_FOLDER_INFO_FAST flag should be considered
        /// deprecated; most backends will behave the same whether it is
        /// supplied or not.  The only guaranteed way to get updated folder
        /// counts is to both open the folder and invoke `camel.Folder.refreshInfo` it.
        pub const get_folder_info_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_top: ?[*:0]const u8, p_flags: camel.StoreGetFolderInfoFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderInfo {
                return gobject.ext.as(Store.Class, p_class).f_get_folder_info_sync.?(gobject.ext.as(Store, p_store), p_top, p_flags, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_top: ?[*:0]const u8, p_flags: camel.StoreGetFolderInfoFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderInfo) void {
                gobject.ext.as(Store.Class, p_class).f_get_folder_info_sync = @ptrCast(p_implementation);
            }
        };

        /// Gets a specific folder object from `store` by name.
        pub const get_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_flags: camel.StoreGetFolderFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder {
                return gobject.ext.as(Store.Class, p_class).f_get_folder_sync.?(gobject.ext.as(Store, p_store), p_folder_name, p_flags, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_flags: camel.StoreGetFolderFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder) void {
                gobject.ext.as(Store.Class, p_class).f_get_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Gets the folder in `store` into which new mail is delivered.
        pub const get_inbox_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder {
                return gobject.ext.as(Store.Class, p_class).f_get_inbox_folder_sync.?(gobject.ext.as(Store, p_store), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder) void {
                gobject.ext.as(Store.Class, p_class).f_get_inbox_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Gets the folder in `store` into which junk is delivered.
        pub const get_junk_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder {
                return gobject.ext.as(Store.Class, p_class).f_get_junk_folder_sync.?(gobject.ext.as(Store, p_store), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder) void {
                gobject.ext.as(Store.Class, p_class).f_get_junk_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Gets the folder in `store` into which trash is delivered.
        pub const get_trash_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder {
                return gobject.ext.as(Store.Class, p_class).f_get_trash_folder_sync.?(gobject.ext.as(Store, p_store), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder) void {
                gobject.ext.as(Store.Class, p_class).f_get_trash_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Runs initial setup for the `store`. It's meant to preset some
        /// values the first time the account connects to the server after
        /// it had been created. The function should return `TRUE` even if
        /// it didn't populate anything. The default implementation does
        /// just that.
        ///
        /// The save_setup result, if not `NULL`, should be freed using
        /// `glib.hashTableDestroy`. It's not an error to have it `NULL`,
        /// it only means the `store` doesn't have anything to save.
        /// Both the key and the value in the hash are newly allocated
        /// UTF-8 strings, owned by the hash table.
        ///
        /// The `store` advertises support of this function by including
        /// CAMEL_STORE_SUPPORTS_INITIAL_SETUP in CamelStore::flags.
        pub const initial_setup_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_save_setup: *glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Store.Class, p_class).f_initial_setup_sync.?(gobject.ext.as(Store, p_store), p_out_save_setup, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_save_setup: *glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_initial_setup_sync = @ptrCast(p_implementation);
            }
        };

        /// Renames the folder described by `old_name` to `new_name`.
        pub const rename_folder_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8, p_new_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Store.Class, p_class).f_rename_folder_sync.?(gobject.ext.as(Store, p_store), p_old_name, p_new_name, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_name: [*:0]const u8, p_new_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_rename_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Synchronizes any changes that have been made to `store` and its folders
        /// with the real store.
        pub const synchronize_sync = struct {
            pub fn call(p_class: anytype, p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Store.Class, p_class).f_synchronize_sync.?(gobject.ext.as(Store, p_store), p_expunge, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_store: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Store.Class, p_class).f_synchronize_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const folder_created = struct {
            pub const name = "folder-created";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *camel.FolderInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Store, p_instance))),
                    gobject.signalLookup("folder-created", Store.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const folder_deleted = struct {
            pub const name = "folder-deleted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *camel.FolderInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Store, p_instance))),
                    gobject.signalLookup("folder-deleted", Store.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal indicates significant changes have occurred to
        /// the folder hierarchy of `store`, and that previously fetched
        /// `camel.FolderInfo` data should be considered stale.
        ///
        /// Applications should handle this signal by replacing cached
        /// `camel.FolderInfo` data for `store` with fresh data by way of
        /// `camel.Store.getFolderInfo`.
        ///
        /// More often than not this signal will be emitted as a result of
        /// user preference changes rather than actual server-side changes.
        /// For example, a user may change a preference that reveals a set
        /// of folders previously hidden from view, or that alters whether
        /// to augment the `store` with virtual Junk and Trash folders.
        pub const folder_info_stale = struct {
            pub const name = "folder-info-stale";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Store, p_instance))),
                    gobject.signalLookup("folder-info-stale", Store.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const folder_opened = struct {
            pub const name = "folder-opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *camel.Folder, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Store, p_instance))),
                    gobject.signalLookup("folder-opened", Store.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const folder_renamed = struct {
            pub const name = "folder-renamed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: *camel.FolderInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Store, p_instance))),
                    gobject.signalLookup("folder-renamed", Store.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns if this folder (param info) should be checked for new mail or not.
    /// It should not look into sub infos (info->child) or next infos, it should
    /// return value only for the actual folder info.
    /// Default behavior is that all Inbox folders are intended to be refreshed.
    extern fn camel_store_can_refresh_folder(p_store: *Store, p_info: *camel.FolderInfo, p_error: ?*?*glib.Error) c_int;
    pub const canRefreshFolder = camel_store_can_refresh_folder;

    /// Asynchronously creates a new folder as a child of an existing folder.
    /// `parent_name` can be `NULL` to create a new top-level folder.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Store.createFolderFinish` to get the result of the operation.
    extern fn camel_store_create_folder(p_store: *Store, p_parent_name: ?[*:0]const u8, p_folder_name: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createFolder = camel_store_create_folder;

    /// Finishes the operation started with `camel.Store.createFolder`.
    /// The returned `camel.FolderInfo` struct should be freed with
    /// `camel.FolderInfo.free`.
    extern fn camel_store_create_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.FolderInfo;
    pub const createFolderFinish = camel_store_create_folder_finish;

    /// Creates a new folder as a child of an existing folder.
    /// `parent_name` can be `NULL` to create a new top-level folder.
    /// The returned `camel.FolderInfo` struct should be freed with
    /// `camel.FolderInfo.free`.
    extern fn camel_store_create_folder_sync(p_store: *Store, p_parent_name: ?[*:0]const u8, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderInfo;
    pub const createFolderSync = camel_store_create_folder_sync;

    /// Deletes local data for the given `folder_name`. The folder should
    /// be part of the opened folders.
    ///
    /// It doesn't delete the folder in the store (server) as such.
    /// Use `camel.Store.deleteFolder`, or its synchronous variant,
    /// if you want to do that instead.
    extern fn camel_store_delete_cached_folder(p_store: *Store, p_folder_name: [*:0]const u8) void;
    pub const deleteCachedFolder = camel_store_delete_cached_folder;

    /// Asynchronously deletes the folder described by `folder_name`.  The
    /// folder must be empty.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Store.deleteFolderFinish` to get the result of the operation.
    extern fn camel_store_delete_folder(p_store: *Store, p_folder_name: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const deleteFolder = camel_store_delete_folder;

    /// Finishes the operation started with `camel.Store.deleteFolder`.
    extern fn camel_store_delete_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const deleteFolderFinish = camel_store_delete_folder_finish;

    /// Deletes the folder described by `folder_name`.  The folder must be empty.
    extern fn camel_store_delete_folder_sync(p_store: *Store, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteFolderSync = camel_store_delete_folder_sync;

    /// Returns a `glib.PtrArray` of all the opened folders for the `store`. The caller owns
    /// both the array and the folder references, so to free the array use:
    ///
    /// ```
    ///     g_ptr_array_foreach (array, (GFunc) g_object_unref, NULL);
    ///     g_ptr_array_free (array, TRUE);
    /// ```
    extern fn camel_store_dup_opened_folders(p_store: *Store) *glib.PtrArray;
    pub const dupOpenedFolders = camel_store_dup_opened_folders;

    /// Emits the `camel.Store.signals.folder`-created signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_store_folder_created(p_store: *Store, p_folder_info: *camel.FolderInfo) void;
    pub const folderCreated = camel_store_folder_created;

    /// Emits the `camel.Store.signals.folder`-deleted signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_store_folder_deleted(p_store: *Store, p_folder_info: *camel.FolderInfo) void;
    pub const folderDeleted = camel_store_folder_deleted;

    /// Emits the `camel.Store.signals.folder`-info-stale signal from an idle source
    /// on the main loop.  The idle source's priority is `G_PRIORITY_LOW`.
    ///
    /// See the `camel.Store.signals.folder`-info-stale documentation for details on
    /// when to use this signal.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_store_folder_info_stale(p_store: *Store) void;
    pub const folderInfoStale = camel_store_folder_info_stale;

    /// Emits the `camel.Store.signals.folder`-opened signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_store_folder_opened(p_store: *Store, p_folder: *camel.Folder) void;
    pub const folderOpened = camel_store_folder_opened;

    /// Emits the `camel.Store.signals.folder`-renamed signal from an idle source on
    /// the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_store_folder_renamed(p_store: *Store, p_old_name: [*:0]const u8, p_folder_info: *camel.FolderInfo) void;
    pub const folderRenamed = camel_store_folder_renamed;

    /// Returns whether there can be done automatic save of folder changes.
    /// Default is TRUE. The descendants can overwrite it with CamelStoreClass::`get_can_auto_save_changes`.
    extern fn camel_store_get_can_auto_save_changes(p_store: *Store) c_int;
    pub const getCanAutoSaveChanges = camel_store_get_can_auto_save_changes;

    extern fn camel_store_get_db(p_store: *Store) *camel.DB;
    pub const getDb = camel_store_get_db;

    extern fn camel_store_get_flags(p_store: *Store) u32;
    pub const getFlags = camel_store_get_flags;

    /// Asynchronously gets a specific folder object from `store` by name.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Store.getFolderFinish` to get the result of the operation.
    extern fn camel_store_get_folder(p_store: *Store, p_folder_name: [*:0]const u8, p_flags: camel.StoreGetFolderFlags, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getFolder = camel_store_get_folder;

    /// Finishes the operation started with `camel.Store.getFolder`.
    extern fn camel_store_get_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getFolderFinish = camel_store_get_folder_finish;

    /// Asynchronously fetches information about the folder structure of `store`,
    /// starting with `top`.  For details of the behavior, see
    /// `camel.Store.getFolderInfoSync`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Store.getFolderInfoFinish` to get the result of
    /// the operation.
    extern fn camel_store_get_folder_info(p_store: *Store, p_top: ?[*:0]const u8, p_flags: camel.StoreGetFolderInfoFlags, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getFolderInfo = camel_store_get_folder_info;

    /// Finishes the operation started with `camel.Store.getFolderInfo`.
    /// The returned `camel.FolderInfo` tree should be freed with
    /// `camel.FolderInfo.free`.
    extern fn camel_store_get_folder_info_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.FolderInfo;
    pub const getFolderInfoFinish = camel_store_get_folder_info_finish;

    /// This fetches information about the folder structure of `store`,
    /// starting with `top`, and returns a tree of `camel.FolderInfo`
    /// structures. If `flags` includes `CAMEL_STORE_FOLDER_INFO_SUBSCRIBED`,
    /// only subscribed folders will be listed.   If the store doesn't support
    /// subscriptions, then it will list all folders.  If `flags` includes
    /// `CAMEL_STORE_FOLDER_INFO_RECURSIVE`, the returned tree will include
    /// all levels of hierarchy below `top`. If not, it will only include
    /// the immediate subfolders of `top`. If `flags` includes
    /// `CAMEL_STORE_FOLDER_INFO_FAST`, the unread_message_count fields of
    /// some or all of the structures may be set to -1, if the store cannot
    /// determine that information quickly.  If `flags` includes
    /// `CAMEL_STORE_FOLDER_INFO_NO_VIRTUAL`, don't include special virtual
    /// folders (such as vTrash or vJunk).
    ///
    /// The returned `camel.FolderInfo` tree should be freed with
    /// `camel.FolderInfo.free`.
    ///
    /// The CAMEL_STORE_FOLDER_INFO_FAST flag should be considered
    /// deprecated; most backends will behave the same whether it is
    /// supplied or not.  The only guaranteed way to get updated folder
    /// counts is to both open the folder and invoke `camel.Folder.refreshInfo` it.
    extern fn camel_store_get_folder_info_sync(p_store: *Store, p_top: ?[*:0]const u8, p_flags: camel.StoreGetFolderInfoFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.FolderInfo;
    pub const getFolderInfoSync = camel_store_get_folder_info_sync;

    /// Gets a specific folder object from `store` by name.
    extern fn camel_store_get_folder_sync(p_store: *Store, p_folder_name: [*:0]const u8, p_flags: camel.StoreGetFolderFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getFolderSync = camel_store_get_folder_sync;

    extern fn camel_store_get_folders_bag(p_store: *Store) *camel.ObjectBag;
    pub const getFoldersBag = camel_store_get_folders_bag;

    /// Asynchronously gets the folder in `store` into which new mail is delivered.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Store.getInboxFolderFinish` to get the result of
    /// the operation.
    extern fn camel_store_get_inbox_folder(p_store: *Store, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getInboxFolder = camel_store_get_inbox_folder;

    /// Finishes the operation started with `camel.Store.getInboxFolder`.
    extern fn camel_store_get_inbox_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getInboxFolderFinish = camel_store_get_inbox_folder_finish;

    /// Gets the folder in `store` into which new mail is delivered.
    extern fn camel_store_get_inbox_folder_sync(p_store: *Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getInboxFolderSync = camel_store_get_inbox_folder_sync;

    /// Asynchronously gets the folder in `store` into which junk is delivered.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Store.getJunkFolderFinish` to get the result of
    /// the operation.
    extern fn camel_store_get_junk_folder(p_store: *Store, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getJunkFolder = camel_store_get_junk_folder;

    /// Finishes the operation started with `camel.Store.getJunkFolder`.
    extern fn camel_store_get_junk_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getJunkFolderFinish = camel_store_get_junk_folder_finish;

    /// Gets the folder in `store` into which junk is delivered.
    extern fn camel_store_get_junk_folder_sync(p_store: *Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getJunkFolderSync = camel_store_get_junk_folder_sync;

    extern fn camel_store_get_permissions(p_store: *Store) u32;
    pub const getPermissions = camel_store_get_permissions;

    /// Asynchronously gets the folder in `store` into which trash is delivered.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `camel.Store.getTrashFolderFinish` to get the result of
    /// the operation.
    extern fn camel_store_get_trash_folder(p_store: *Store, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getTrashFolder = camel_store_get_trash_folder;

    /// Finishes the operation started with `camel.Store.getTrashFolder`.
    extern fn camel_store_get_trash_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getTrashFolderFinish = camel_store_get_trash_folder_finish;

    /// Gets the folder in `store` into which trash is delivered.
    extern fn camel_store_get_trash_folder_sync(p_store: *Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*camel.Folder;
    pub const getTrashFolderSync = camel_store_get_trash_folder_sync;

    /// Runs initial setup for the `store` asynchronously.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `camel.Store.initialSetupFinish` to get the result of the operation.
    ///
    /// The `store` advertises support of this function by including
    /// CAMEL_STORE_SUPPORTS_INITIAL_SETUP in CamelStore::flags.
    extern fn camel_store_initial_setup(p_store: *Store, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const initialSetup = camel_store_initial_setup;

    /// Finishes the operation started with `camel.Store.initialSetup`.
    ///
    /// The save_setup result, if not `NULL`, should be freed using
    /// `glib.hashTableDestroy`. It's not an error to have it `NULL`,
    /// it only means the `store` doesn't have anything to save.
    extern fn camel_store_initial_setup_finish(p_store: *Store, p_result: *gio.AsyncResult, p_out_save_setup: **glib.HashTable, p_error: ?*?*glib.Error) c_int;
    pub const initialSetupFinish = camel_store_initial_setup_finish;

    /// Runs initial setup for the `store`. It's meant to preset some
    /// values the first time the account connects to the server after
    /// it had been created. The function should return `TRUE` even if
    /// it didn't populate anything. The default implementation does
    /// just that.
    ///
    /// The save_setup result, if not `NULL`, should be freed using
    /// `glib.hashTableDestroy`. It's not an error to have it `NULL`,
    /// it only means the `store` doesn't have anything to save.
    /// Both the key and the value in the hash are newly allocated
    /// UTF-8 strings, owned by the hash table.
    ///
    /// The `store` advertises support of this function by including
    /// CAMEL_STORE_SUPPORTS_INITIAL_SETUP in CamelStore::flags.
    extern fn camel_store_initial_setup_sync(p_store: *Store, p_out_save_setup: **glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const initialSetupSync = camel_store_initial_setup_sync;

    /// Checks the state of the current CamelDB used for the `store` and eventually
    /// runs maintenance routines on it.
    extern fn camel_store_maybe_run_db_maintenance(p_store: *Store, p_error: ?*?*glib.Error) c_int;
    pub const maybeRunDbMaintenance = camel_store_maybe_run_db_maintenance;

    /// Asynchronously renames the folder described by `old_name` to `new_name`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Store.renameFolderFinish` to get the result of the operation.
    extern fn camel_store_rename_folder(p_store: *Store, p_old_name: [*:0]const u8, p_new_name: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const renameFolder = camel_store_rename_folder;

    /// Finishes the operation started with `camel.Store.renameFolder`.
    extern fn camel_store_rename_folder_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const renameFolderFinish = camel_store_rename_folder_finish;

    /// Renames the folder described by `old_name` to `new_name`.
    extern fn camel_store_rename_folder_sync(p_store: *Store, p_old_name: [*:0]const u8, p_new_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const renameFolderSync = camel_store_rename_folder_sync;

    /// Sets flags for the `store`, a bit-or of `camel.StoreFlags`.
    extern fn camel_store_set_flags(p_store: *Store, p_flags: u32) void;
    pub const setFlags = camel_store_set_flags;

    /// Sets permissions for the `store`, a bit-or of `camel.StorePermissionFlags`
    extern fn camel_store_set_permissions(p_store: *Store, p_permissions: u32) void;
    pub const setPermissions = camel_store_set_permissions;

    /// Synchronizes any changes that have been made to `store` and its folders
    /// with the real store asynchronously.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Store.synchronizeFinish` to get the result of the operation.
    extern fn camel_store_synchronize(p_store: *Store, p_expunge: c_int, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const synchronize = camel_store_synchronize;

    /// Finishes the operation started with `camel.Store.synchronize`.
    extern fn camel_store_synchronize_finish(p_store: *Store, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeFinish = camel_store_synchronize_finish;

    /// Synchronizes any changes that have been made to `store` and its folders
    /// with the real store.
    extern fn camel_store_synchronize_sync(p_store: *Store, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const synchronizeSync = camel_store_synchronize_sync;

    extern fn camel_store_get_type() usize;
    pub const getGObjectType = camel_store_get_type;

    extern fn g_object_ref(p_self: *camel.Store) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Store) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Store, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const StoreSettings = extern struct {
    pub const Parent = camel.Settings;
    pub const Implements = [_]type{};
    pub const Class = camel.StoreSettingsClass;
    f_parent: camel.Settings,
    f_priv: ?*camel.StoreSettingsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const filter_inbox = struct {
            pub const name = "filter-inbox";

            pub const Type = c_int;
        };

        pub const store_changes_interval = struct {
            pub const name = "store-changes-interval";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns whether to automatically apply filters to newly arrived messages
    /// in the store's Inbox folder (assuming it has an Inbox folder).
    extern fn camel_store_settings_get_filter_inbox(p_settings: *StoreSettings) c_int;
    pub const getFilterInbox = camel_store_settings_get_filter_inbox;

    /// Returns the interval, in seconds, for the changes in the folder being
    /// saved automatically. 0 means immediately, while -1 means turning off
    /// automatic folder change saving.
    extern fn camel_store_settings_get_store_changes_interval(p_settings: *StoreSettings) c_int;
    pub const getStoreChangesInterval = camel_store_settings_get_store_changes_interval;

    /// Sets whether to automatically apply filters to newly arrived messages
    /// in the store's Inbox folder (assuming it has an Inbox folder).
    extern fn camel_store_settings_set_filter_inbox(p_settings: *StoreSettings, p_filter_inbox: c_int) void;
    pub const setFilterInbox = camel_store_settings_set_filter_inbox;

    /// Sets the interval, in seconds, for the changes in the folder being
    /// saved automatically. 0 means immediately, while -1 means turning off
    /// automatic folder change saving.
    extern fn camel_store_settings_set_store_changes_interval(p_settings: *StoreSettings, p_interval: c_int) void;
    pub const setStoreChangesInterval = camel_store_settings_set_store_changes_interval;

    extern fn camel_store_settings_get_type() usize;
    pub const getGObjectType = camel_store_settings_get_type;

    extern fn g_object_ref(p_self: *camel.StoreSettings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StoreSettings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StoreSettings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreSummary = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.StoreSummaryClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.StoreSummaryPrivate,

    pub const virtual_methods = struct {
        pub const store_info_free = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.StoreInfo) void {
                return gobject.ext.as(StoreSummary.Class, p_class).f_store_info_free.?(gobject.ext.as(StoreSummary, p_summary), p_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.StoreInfo) callconv(.c) void) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_store_info_free = @ptrCast(p_implementation);
            }
        };

        pub const store_info_load = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) *camel.StoreInfo {
                return gobject.ext.as(StoreSummary.Class, p_class).f_store_info_load.?(gobject.ext.as(StoreSummary, p_summary), p_file);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) callconv(.c) *camel.StoreInfo) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_store_info_load = @ptrCast(p_implementation);
            }
        };

        pub const store_info_new = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_path: [*:0]const u8) *camel.StoreInfo {
                return gobject.ext.as(StoreSummary.Class, p_class).f_store_info_new.?(gobject.ext.as(StoreSummary, p_summary), p_path);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_path: [*:0]const u8) callconv(.c) *camel.StoreInfo) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_store_info_new = @ptrCast(p_implementation);
            }
        };

        pub const store_info_save = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque, p_info: *camel.StoreInfo) c_int {
                return gobject.ext.as(StoreSummary.Class, p_class).f_store_info_save.?(gobject.ext.as(StoreSummary, p_summary), p_file, p_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque, p_info: *camel.StoreInfo) callconv(.c) c_int) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_store_info_save = @ptrCast(p_implementation);
            }
        };

        pub const store_info_set_value = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.StoreInfo, p_type: c_int, p_value: [*:0]const u8) void {
                return gobject.ext.as(StoreSummary.Class, p_class).f_store_info_set_value.?(gobject.ext.as(StoreSummary, p_summary), p_info, p_type, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_info: *camel.StoreInfo, p_type: c_int, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_store_info_set_value = @ptrCast(p_implementation);
            }
        };

        pub const summary_header_load = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) c_int {
                return gobject.ext.as(StoreSummary.Class, p_class).f_summary_header_load.?(gobject.ext.as(StoreSummary, p_summary), p_file);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_summary_header_load = @ptrCast(p_implementation);
            }
        };

        pub const summary_header_save = struct {
            pub fn call(p_class: anytype, p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) c_int {
                return gobject.ext.as(StoreSummary.Class, p_class).f_summary_header_save.?(gobject.ext.as(StoreSummary, p_summary), p_file);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_summary: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: ?*anyopaque) callconv(.c) c_int) void {
                gobject.ext.as(StoreSummary.Class, p_class).f_summary_header_save = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.StoreSummary` object.
    extern fn camel_store_summary_new() *camel.StoreSummary;
    pub const new = camel_store_summary_new;

    /// The `info` record should have been generated by calling one of the
    /// info_new_*() functions, as it will be free'd based on the summary
    /// class.  And MUST NOT be allocated directly using malloc.
    extern fn camel_store_summary_add(p_summary: *StoreSummary, p_info: *camel.StoreInfo) void;
    pub const add = camel_store_summary_add;

    /// Build a new info record based on the name, and add it to the summary.
    extern fn camel_store_summary_add_from_path(p_summary: *StoreSummary, p_path: [*:0]const u8) ?*camel.StoreInfo;
    pub const addFromPath = camel_store_summary_add_from_path;

    /// Obtain a copy of the summary array.  This is done atomically,
    /// so cannot contain empty entries.
    ///
    /// It must be freed using `glib.PtrArray.unref`.
    extern fn camel_store_summary_array(p_summary: *StoreSummary) *glib.PtrArray;
    pub const array = camel_store_summary_array;

    /// Free the folder summary array.
    extern fn camel_store_summary_array_free(p_summary: *StoreSummary, p_array: *glib.PtrArray) void;
    pub const arrayFree = camel_store_summary_array_free;

    /// Connects listeners for count changes on `folder_summary` to keep
    /// CamelStoreInfo.total and CamelStoreInfo.unread in sync transparently.
    /// The `folder_summary` is stored in `summary` as `path`. Use
    /// `camel.StoreSummary.disconnectFolderSummary` to disconnect from
    /// listening.
    extern fn camel_store_summary_connect_folder_summary(p_summary: *StoreSummary, p_path: [*:0]const u8, p_folder_summary: *camel.FolderSummary) c_int;
    pub const connectFolderSummary = camel_store_summary_connect_folder_summary;

    /// Get the number of summary items stored in this summary.
    extern fn camel_store_summary_count(p_summary: *StoreSummary) c_int;
    pub const count = camel_store_summary_count;

    /// Diconnects count change listeners previously connected
    /// by `camel.StoreSummary.connectFolderSummary`.
    extern fn camel_store_summary_disconnect_folder_summary(p_summary: *StoreSummary, p_folder_summary: *camel.FolderSummary) c_int;
    pub const disconnectFolderSummary = camel_store_summary_disconnect_folder_summary;

    /// Allocate a new `camel.StoreInfo`, suitable for adding to this
    /// summary.
    extern fn camel_store_summary_info_new(p_summary: *StoreSummary) *camel.StoreInfo;
    pub const infoNew = camel_store_summary_info_new;

    /// Add an extra reference to `info`.
    extern fn camel_store_summary_info_ref(p_summary: *StoreSummary, p_info: *camel.StoreInfo) *camel.StoreInfo;
    pub const infoRef = camel_store_summary_info_ref;

    /// Unref and potentially free `info`, and all associated memory.
    extern fn camel_store_summary_info_unref(p_summary: *StoreSummary, p_info: *camel.StoreInfo) void;
    pub const infoUnref = camel_store_summary_info_unref;

    /// Load the summary off disk.
    extern fn camel_store_summary_load(p_summary: *StoreSummary) c_int;
    pub const load = camel_store_summary_load;

    /// Retrieve a summary item by path name.
    ///
    /// The returned `camel.StoreInfo` is referenced for thread-safety and should be
    /// unreferenced with `camel.StoreInfo.unref` when finished with it.
    extern fn camel_store_summary_path(p_summary: *StoreSummary, p_path: [*:0]const u8) ?*camel.StoreInfo;
    pub const path = camel_store_summary_path;

    /// Remove a specific `info` record from the summary.
    extern fn camel_store_summary_remove(p_summary: *StoreSummary, p_info: *camel.StoreInfo) void;
    pub const remove = camel_store_summary_remove;

    /// Remove a specific info record from the summary, by `path`.
    extern fn camel_store_summary_remove_path(p_summary: *StoreSummary, p_path: [*:0]const u8) void;
    pub const removePath = camel_store_summary_remove_path;

    /// Writes the summary to disk.  The summary is only written if changes
    /// have occurred.
    extern fn camel_store_summary_save(p_summary: *StoreSummary) c_int;
    pub const save = camel_store_summary_save;

    /// Set the filename where the summary will be loaded to/saved from.
    extern fn camel_store_summary_set_filename(p_summary: *StoreSummary, p_filename: [*:0]const u8) void;
    pub const setFilename = camel_store_summary_set_filename;

    /// Sorts the array of the folders using the `compare_func`.
    extern fn camel_store_summary_sort(p_summary: *StoreSummary, p_compare_func: glib.CompareDataFunc, p_user_data: ?*anyopaque) void;
    pub const sort = camel_store_summary_sort;

    /// Mark the summary as changed, so that a save will force it to be
    /// written back to disk.
    extern fn camel_store_summary_touch(p_summary: *StoreSummary) void;
    pub const touch = camel_store_summary_touch;

    extern fn camel_store_summary_get_type() usize;
    pub const getGObjectType = camel_store_summary_get_type;

    extern fn g_object_ref(p_self: *camel.StoreSummary) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StoreSummary) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StoreSummary, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Stream = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.StreamPrivate,

    pub const virtual_methods = struct {
        /// Closes the stream.
        pub const close = struct {
            pub fn call(p_class: anytype, p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Stream.Class, p_class).f_close.?(gobject.ext.as(Stream, p_stream), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Stream.Class, p_class).f_close = @ptrCast(p_implementation);
            }
        };

        /// Tests if there are bytes left to read on the `stream` object.
        pub const eos = struct {
            pub fn call(p_class: anytype, p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Stream.Class, p_class).f_eos.?(gobject.ext.as(Stream, p_stream));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Stream.Class, p_class).f_eos = @ptrCast(p_implementation);
            }
        };

        /// Flushes any buffered data to the stream's backing store.  Only
        /// meaningful for writable streams.
        pub const flush = struct {
            pub fn call(p_class: anytype, p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Stream.Class, p_class).f_flush.?(gobject.ext.as(Stream, p_stream), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Stream.Class, p_class).f_flush = @ptrCast(p_implementation);
            }
        };

        /// Attempts to read up to `n` bytes from `stream` into `buffer`.
        pub const read = struct {
            pub fn call(p_class: anytype, p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(Stream.Class, p_class).f_read.?(gobject.ext.as(Stream, p_stream), p_buffer, p_n, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(Stream.Class, p_class).f_read = @ptrCast(p_implementation);
            }
        };

        /// Attempts to write up to `n` bytes of `buffer` into `stream`.
        pub const write = struct {
            pub fn call(p_class: anytype, p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]const u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize {
                return gobject.ext.as(Stream.Class, p_class).f_write.?(gobject.ext.as(Stream, p_stream), p_buffer, p_n, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]const u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize) void {
                gobject.ext.as(Stream.Class, p_class).f_write = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const base_stream = struct {
            pub const name = "base-stream";

            pub const Type = ?*gio.IOStream;
        };
    };

    pub const signals = struct {};

    /// Creates a `camel.Stream` as a thin wrapper for `base_stream`.
    extern fn camel_stream_new(p_base_stream: *gio.IOStream) *camel.Stream;
    pub const new = camel_stream_new;

    /// Closes the stream.
    extern fn camel_stream_close(p_stream: *Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const close = camel_stream_close;

    /// Tests if there are bytes left to read on the `stream` object.
    extern fn camel_stream_eos(p_stream: *Stream) c_int;
    pub const eos = camel_stream_eos;

    /// Flushes any buffered data to the stream's backing store.  Only
    /// meaningful for writable streams.
    extern fn camel_stream_flush(p_stream: *Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const flush = camel_stream_flush;

    /// Attempts to read up to `n` bytes from `stream` into `buffer`.
    extern fn camel_stream_read(p_stream: *Stream, p_buffer: [*]u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const read = camel_stream_read;

    /// Returns the `gio.IOStream` for `stream`.  This is only valid if `stream` was
    /// created with `camel.Stream.new`.  For all other `camel.Stream` subclasses
    /// this function returns `NULL`.
    ///
    /// The returned `gio.IOStream` is referenced for thread-safety and should be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_stream_ref_base_stream(p_stream: *Stream) ?*gio.IOStream;
    pub const refBaseStream = camel_stream_ref_base_stream;

    /// Replaces the `gio.IOStream` passed to `camel.Stream.new` with `base_stream`.
    /// The new `base_stream` should wrap the original `gio.IOStream`, such as when
    /// adding Transport Layer Security after issuing a STARTTLS command.
    extern fn camel_stream_set_base_stream(p_stream: *Stream, p_base_stream: *gio.IOStream) void;
    pub const setBaseStream = camel_stream_set_base_stream;

    /// Attempts to write up to `n` bytes of `buffer` into `stream`.
    extern fn camel_stream_write(p_stream: *Stream, p_buffer: [*]const u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const write = camel_stream_write;

    /// Writes the string to the stream.
    extern fn camel_stream_write_string(p_stream: *Stream, p_string: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const writeString = camel_stream_write_string;

    /// Write all of a stream (until eos) into another stream, in a
    /// blocking fashion.
    extern fn camel_stream_write_to_stream(p_stream: *Stream, p_output_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const writeToStream = camel_stream_write_to_stream;

    extern fn camel_stream_get_type() usize;
    pub const getGObjectType = camel_stream_get_type;

    extern fn g_object_ref(p_self: *camel.Stream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Stream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Stream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamBuffer = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamBufferClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamBufferPrivate,

    pub const virtual_methods = struct {
        pub const init = struct {
            pub fn call(p_class: anytype, p_stream_buffer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode) void {
                return gobject.ext.as(StreamBuffer.Class, p_class).f_init.?(gobject.ext.as(StreamBuffer, p_stream_buffer), p_stream, p_mode);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream_buffer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode) callconv(.c) void) void {
                gobject.ext.as(StreamBuffer.Class, p_class).f_init = @ptrCast(p_implementation);
            }
        };

        pub const init_vbuf = struct {
            pub fn call(p_class: anytype, p_stream_buffer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode, p_buf: [*:0]u8, p_size: u32) void {
                return gobject.ext.as(StreamBuffer.Class, p_class).f_init_vbuf.?(gobject.ext.as(StreamBuffer, p_stream_buffer), p_stream, p_mode, p_buf, p_size);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_stream_buffer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode, p_buf: [*:0]u8, p_size: u32) callconv(.c) void) void {
                gobject.ext.as(StreamBuffer.Class, p_class).f_init_vbuf = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new buffered stream of another stream.  A default
    /// buffer size (1024 bytes), automatically managed will be used
    /// for buffering.
    ///
    /// The following values are available for `mode`:
    ///
    /// `CAMEL_STREAM_BUFFER_BUFFER`, Buffer the input/output in blocks.
    /// `CAMEL_STREAM_BUFFER_NEWLINE`, Buffer on newlines (for output).
    /// `CAMEL_STREAM_BUFFER_NONE`, Perform no buffering.
    ///
    /// Note that currently this is ignored and `CAMEL_STREAM_BUFFER_BUFFER`
    /// is always used.
    ///
    /// In addition, one of the following mode options should be or'd
    /// together with the buffering mode:
    ///
    /// `CAMEL_STREAM_BUFFER_WRITE`, Buffer in write mode.
    /// `CAMEL_STREAM_BUFFER_READ`, Buffer in read mode.
    ///
    /// Buffering can only be done in one direction for any
    /// buffer instance.
    extern fn camel_stream_buffer_new(p_stream: *camel.Stream, p_mode: camel.StreamBufferMode) *camel.StreamBuffer;
    pub const new = camel_stream_buffer_new;

    /// Discards any cached data in the `sbf`. The next read reads
    /// from the stream.
    extern fn camel_stream_buffer_discard_cache(p_sbf: *StreamBuffer) void;
    pub const discardCache = camel_stream_buffer_discard_cache;

    /// Read a line of characters up to the next newline character or
    /// `max`-1 characters.
    ///
    /// If the newline character is encountered, then it will be
    /// included in the buffer `buf`.  The buffer will be `NULL` terminated.
    extern fn camel_stream_buffer_gets(p_sbf: *StreamBuffer, p_buf: [*]u8, p_max: c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const gets = camel_stream_buffer_gets;

    /// This function reads a complete newline-terminated line from the stream
    /// and returns it in allocated memory. The trailing newline (and carriage
    /// return if any) are not included in the returned string.
    extern fn camel_stream_buffer_read_line(p_sbf: *StreamBuffer, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const readLine = camel_stream_buffer_read_line;

    extern fn camel_stream_buffer_get_type() usize;
    pub const getGObjectType = camel_stream_buffer_get_type;

    extern fn g_object_ref(p_self: *camel.StreamBuffer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamBuffer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamBuffer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFilter = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamFilterClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamFilterPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.StreamFilter` object. The `source` stream
    /// is referenced, thus the caller can unref it, if not needed.
    extern fn camel_stream_filter_new(p_source: *camel.Stream) *camel.StreamFilter;
    pub const new = camel_stream_filter_new;

    /// Add a new `camel.MimeFilter` to execute during the processing of this
    /// stream.  Each filter added is processed after the previous one.
    ///
    /// Note that a filter should only be added to a single stream
    /// at a time, otherwise unpredictable results may occur.
    extern fn camel_stream_filter_add(p_stream: *StreamFilter, p_filter: *camel.MimeFilter) c_int;
    pub const add = camel_stream_filter_add;

    extern fn camel_stream_filter_get_source(p_stream: *StreamFilter) *camel.Stream;
    pub const getSource = camel_stream_filter_get_source;

    /// Remove a processing filter from the stream by id.
    extern fn camel_stream_filter_remove(p_stream: *StreamFilter, p_id: c_int) void;
    pub const remove = camel_stream_filter_remove;

    extern fn camel_stream_filter_get_type() usize;
    pub const getGObjectType = camel_stream_filter_get_type;

    extern fn g_object_ref(p_self: *camel.StreamFilter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamFilter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamFilter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFs = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamFsClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamFsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new fs stream using the given file descriptor `fd` as the
    /// backing store. When the stream is destroyed, the file descriptor
    /// will be closed.
    extern fn camel_stream_fs_new_with_fd(p_fd: c_int) *camel.StreamFs;
    pub const newWithFd = camel_stream_fs_new_with_fd;

    /// Creates a new `camel.StreamFs` corresponding to the named file, flags,
    /// and mode.
    extern fn camel_stream_fs_new_with_name(p_name: [*:0]const u8, p_flags: c_int, p_mode: u32, p_error: ?*?*glib.Error) ?*camel.StreamFs;
    pub const newWithName = camel_stream_fs_new_with_name;

    extern fn camel_stream_fs_get_fd(p_stream: *StreamFs) c_int;
    pub const getFd = camel_stream_fs_get_fd;

    extern fn camel_stream_fs_get_type() usize;
    pub const getGObjectType = camel_stream_fs_get_type;

    extern fn g_object_ref(p_self: *camel.StreamFs) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamFs) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamFs, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamMem = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamMemClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamMemPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `camel.StreamMem` object.
    extern fn camel_stream_mem_new() *camel.StreamMem;
    pub const new = camel_stream_mem_new;

    /// Create a new memory stream using `buffer` as the stream data.
    ///
    /// Note: `buffer` will be copied into an internal `glib.ByteArray` structure
    /// for use as the stream backing. This may have resource implications
    /// you may wish to consider.
    extern fn camel_stream_mem_new_with_buffer(p_buffer: [*]const u8, p_len: usize) *camel.StreamMem;
    pub const newWithBuffer = camel_stream_mem_new_with_buffer;

    /// Create a new `camel.StreamMem` using `buffer` as the stream data.
    ///
    /// Note: The newly created `camel.StreamMem` will destroy `buffer`
    /// when destroyed.
    extern fn camel_stream_mem_new_with_byte_array(p_buffer: *glib.ByteArray) *camel.StreamMem;
    pub const newWithByteArray = camel_stream_mem_new_with_byte_array;

    extern fn camel_stream_mem_get_byte_array(p_mem: *StreamMem) *glib.ByteArray;
    pub const getByteArray = camel_stream_mem_get_byte_array;

    /// Set `buffer` to be the backing data to the existing `camel.StreamMem`, `mem`.
    ///
    /// Note: `buffer` will be copied into an internal `glib.ByteArray` structure
    /// and so may have resource implications to consider.
    extern fn camel_stream_mem_set_buffer(p_mem: *StreamMem, p_buffer: [*]const u8, p_len: usize) void;
    pub const setBuffer = camel_stream_mem_set_buffer;

    /// Set `buffer` to be the backing data to the existing `camel.StreamMem`, `mem`.
    ///
    /// Note: `mem` will not take ownership of `buffer` and so will need to
    /// be freed separately from `mem`.
    extern fn camel_stream_mem_set_byte_array(p_mem: *StreamMem, p_buffer: *glib.ByteArray) void;
    pub const setByteArray = camel_stream_mem_set_byte_array;

    /// Mark the memory stream as secure.  At the very least this means the
    /// data in the buffer will be cleared when the buffer is finalized.
    /// This only applies to buffers owned by the stream.
    extern fn camel_stream_mem_set_secure(p_mem: *StreamMem) void;
    pub const setSecure = camel_stream_mem_set_secure;

    extern fn camel_stream_mem_get_type() usize;
    pub const getGObjectType = camel_stream_mem_get_type;

    extern fn g_object_ref(p_self: *camel.StreamMem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamMem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamMem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamNull = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamNullClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamNullPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a null stream.  A null stream is always at eof, and
    /// always returns success for all reads and writes.
    extern fn camel_stream_null_new() *camel.StreamNull;
    pub const new = camel_stream_null_new;

    extern fn camel_stream_null_get_bytes_written(p_stream_null: *StreamNull) usize;
    pub const getBytesWritten = camel_stream_null_get_bytes_written;

    extern fn camel_stream_null_get_ends_with_crlf(p_stream_null: *StreamNull) c_int;
    pub const getEndsWithCrlf = camel_stream_null_get_ends_with_crlf;

    extern fn camel_stream_null_get_type() usize;
    pub const getGObjectType = camel_stream_null_get_type;

    extern fn g_object_ref(p_self: *camel.StreamNull) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamNull) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamNull, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamProcess = extern struct {
    pub const Parent = camel.Stream;
    pub const Implements = [_]type{gio.Seekable};
    pub const Class = camel.StreamProcessClass;
    f_parent: camel.Stream,
    f_priv: ?*camel.StreamProcessPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a PROCESS stream.
    extern fn camel_stream_process_new() *camel.StreamProcess;
    pub const new = camel_stream_process_new;

    extern fn camel_stream_process_connect(p_stream: *StreamProcess, p_command: [*:0]const u8, p_env: *[*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const connect = camel_stream_process_connect;

    extern fn camel_stream_process_get_type() usize;
    pub const getGObjectType = camel_stream_process_get_type;

    extern fn g_object_ref(p_self: *camel.StreamProcess) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.StreamProcess) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamProcess, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndex = extern struct {
    pub const Parent = camel.Index;
    pub const Implements = [_]type{};
    pub const Class = camel.TextIndexClass;
    f_parent: camel.Index,
    f_priv: ?*camel.TextIndexPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_text_index_check(p_path: [*:0]const u8) c_int;
    pub const check = camel_text_index_check;

    extern fn camel_text_index_remove(p_old: [*:0]const u8) c_int;
    pub const remove = camel_text_index_remove;

    extern fn camel_text_index_rename(p_old: [*:0]const u8, p_new_: [*:0]const u8) c_int;
    pub const rename = camel_text_index_rename;

    extern fn camel_text_index_new(p_path: [*:0]const u8, p_flags: c_int) *camel.TextIndex;
    pub const new = camel_text_index_new;

    extern fn camel_text_index_dump(p_idx: *TextIndex) void;
    pub const dump = camel_text_index_dump;

    extern fn camel_text_index_info(p_idx: *TextIndex) void;
    pub const info = camel_text_index_info;

    extern fn camel_text_index_validate(p_idx: *TextIndex) void;
    pub const validate = camel_text_index_validate;

    extern fn camel_text_index_get_type() usize;
    pub const getGObjectType = camel_text_index_get_type;

    extern fn g_object_ref(p_self: *camel.TextIndex) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.TextIndex) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TextIndex, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexCursor = extern struct {
    pub const Parent = camel.IndexCursor;
    pub const Implements = [_]type{};
    pub const Class = camel.TextIndexCursorClass;
    f_parent: camel.IndexCursor,
    f_priv: ?*camel.TextIndexCursorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_text_index_cursor_get_type() usize;
    pub const getGObjectType = camel_text_index_cursor_get_type;

    extern fn g_object_ref(p_self: *camel.TextIndexCursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.TextIndexCursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TextIndexCursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexKeyCursor = extern struct {
    pub const Parent = camel.IndexCursor;
    pub const Implements = [_]type{};
    pub const Class = camel.TextIndexKeyCursorClass;
    f_parent: camel.IndexCursor,
    f_priv: ?*camel.TextIndexKeyCursorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_text_index_key_cursor_get_type() usize;
    pub const getGObjectType = camel_text_index_key_cursor_get_type;

    extern fn g_object_ref(p_self: *camel.TextIndexKeyCursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.TextIndexKeyCursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TextIndexKeyCursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexName = extern struct {
    pub const Parent = camel.IndexName;
    pub const Implements = [_]type{};
    pub const Class = camel.TextIndexNameClass;
    f_parent: camel.IndexName,
    f_priv: ?*camel.TextIndexNamePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_text_index_name_get_type() usize;
    pub const getGObjectType = camel_text_index_name_get_type;

    extern fn g_object_ref(p_self: *camel.TextIndexName) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.TextIndexName) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TextIndexName, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Transport = extern struct {
    pub const Parent = camel.Service;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = camel.TransportClass;
    f_parent: camel.Service,
    f_priv: ?*camel.TransportPrivate,

    pub const virtual_methods = struct {
        /// Sends the message to the given recipients, regardless of the contents
        /// of `message`.  If the message contains a "Bcc" header, the transport
        /// is responsible for stripping it.
        pub const send_to_sync = struct {
            pub fn call(p_class: anytype, p_transport: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_from: *camel.Address, p_recipients: *camel.Address, p_out_sent_message_saved: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Transport.Class, p_class).f_send_to_sync.?(gobject.ext.as(Transport, p_transport), p_message, p_from, p_recipients, p_out_sent_message_saved, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_transport: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_from: *camel.Address, p_recipients: *camel.Address, p_out_sent_message_saved: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Transport.Class, p_class).f_send_to_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns whether should request Delivery Status Notification
    /// in the "send_to" operation.
    extern fn camel_transport_get_request_dsn(p_transport: *Transport) c_int;
    pub const getRequestDsn = camel_transport_get_request_dsn;

    /// Sends the message asynchronously to the given recipients, regardless of
    /// the contents of `message`.  If the message contains a "Bcc" header, the
    /// transport is responsible for stripping it.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Transport.sendToFinish` to get the result of the operation.
    extern fn camel_transport_send_to(p_transport: *Transport, p_message: *camel.MimeMessage, p_from: *camel.Address, p_recipients: *camel.Address, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendTo = camel_transport_send_to;

    /// Finishes the operation started with `camel.Transport.sendTo`.
    extern fn camel_transport_send_to_finish(p_transport: *Transport, p_result: *gio.AsyncResult, p_out_sent_message_saved: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const sendToFinish = camel_transport_send_to_finish;

    /// Sends the message to the given recipients, regardless of the contents
    /// of `message`.  If the message contains a "Bcc" header, the transport
    /// is responsible for stripping it.
    extern fn camel_transport_send_to_sync(p_transport: *Transport, p_message: *camel.MimeMessage, p_from: *camel.Address, p_recipients: *camel.Address, p_out_sent_message_saved: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const sendToSync = camel_transport_send_to_sync;

    /// Sets whether should request Delivery Status Notification
    /// during the "send_to" operation.
    extern fn camel_transport_set_request_dsn(p_transport: *Transport, p_request_dsn: c_int) void;
    pub const setRequestDsn = camel_transport_set_request_dsn;

    extern fn camel_transport_get_type() usize;
    pub const getGObjectType = camel_transport_get_type;

    extern fn g_object_ref(p_self: *camel.Transport) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Transport) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Transport, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VTrashFolder = extern struct {
    pub const Parent = camel.VeeFolder;
    pub const Implements = [_]type{};
    pub const Class = camel.VTrashFolderClass;
    f_parent: camel.VeeFolder,
    f_priv: ?*camel.VTrashFolderPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new CamelVTrashFolder object.
    extern fn camel_vtrash_folder_new(p_parent_store: *camel.Store, p_type: camel.VTrashFolderType) *camel.VTrashFolder;
    pub const new = camel_vtrash_folder_new;

    extern fn camel_vtrash_folder_get_folder_type(p_vtrash_folder: *VTrashFolder) camel.VTrashFolderType;
    pub const getFolderType = camel_vtrash_folder_get_folder_type;

    extern fn camel_vtrash_folder_get_type() usize;
    pub const getGObjectType = camel_vtrash_folder_get_type;

    extern fn g_object_ref(p_self: *camel.VTrashFolder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VTrashFolder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VTrashFolder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const VeeDataCache = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeDataCacheClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.VeeDataCachePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_vee_data_cache_new() *camel.VeeDataCache;
    pub const new = camel_vee_data_cache_new;

    /// Adds the `subfolder` to the `data_cache` to be tracked by it. The `subfolder`
    /// is referenced for later use. The function does nothing when the `subfolder`
    /// is already in the `data_cache`. The subfolders can be removed with
    /// `camel.VeeDataCache.removeSubfolder`.
    extern fn camel_vee_data_cache_add_subfolder(p_data_cache: *VeeDataCache, p_subfolder: *camel.Folder) void;
    pub const addSubfolder = camel_vee_data_cache_add_subfolder;

    /// Returns whether data_cache contains given `orig_message_uid` for the given `folder`.
    /// Unlike `camel.VeeDataCache.getMessageInfoData`, this only
    /// returns `FALSE` if not, while `camel.VeeDataCache.getMessageInfoData`
    /// auto-adds it to data_cache.
    extern fn camel_vee_data_cache_contains_message_info_data(p_data_cache: *VeeDataCache, p_folder: *camel.Folder, p_orig_message_uid: [*:0]const u8) c_int;
    pub const containsMessageInfoData = camel_vee_data_cache_contains_message_info_data;

    /// Calls the `func` for each message info data from the given `fromfolder`
    extern fn camel_vee_data_cache_foreach_message_info_data(p_data_cache: *VeeDataCache, p_fromfolder: *camel.Folder, p_func: camel.ForeachInfoData, p_user_data: ?*anyopaque) void;
    pub const foreachMessageInfoData = camel_vee_data_cache_foreach_message_info_data;

    /// Returns a referenced `camel.VeeMessageInfoData` referencing the given `folder`
    /// and `orig_message_uid`. If it's not part of the `data_cache`, then it is
    /// created and auto-added. Use `camel.VeeDataCache.containsMessageInfoData`
    /// when you only want to check the existence, without adding it to the `data_cache`.
    extern fn camel_vee_data_cache_get_message_info_data(p_data_cache: *VeeDataCache, p_folder: *camel.Folder, p_orig_message_uid: [*:0]const u8) *camel.VeeMessageInfoData;
    pub const getMessageInfoData = camel_vee_data_cache_get_message_info_data;

    extern fn camel_vee_data_cache_get_message_info_data_by_vuid(p_data_cache: *VeeDataCache, p_vee_message_uid: [*:0]const u8) ?*camel.VeeMessageInfoData;
    pub const getMessageInfoDataByVuid = camel_vee_data_cache_get_message_info_data_by_vuid;

    /// Returns a `camel.VeeSubfolderData` for the given `folder`.
    extern fn camel_vee_data_cache_get_subfolder_data(p_data_cache: *VeeDataCache, p_folder: *camel.Folder) *camel.VeeSubfolderData;
    pub const getSubfolderData = camel_vee_data_cache_get_subfolder_data;

    /// Removes given `mi_data` from the `data_cache`.
    extern fn camel_vee_data_cache_remove_message_info_data(p_data_cache: *VeeDataCache, p_mi_data: *camel.VeeMessageInfoData) void;
    pub const removeMessageInfoData = camel_vee_data_cache_remove_message_info_data;

    /// Removes given `subfolder` from the `data_cache`, which had been
    /// previously added with `camel.VeeDataCache.addSubfolder`.
    /// The function does nothing, when the `subfolder` is not part
    /// of the `data_cache`.
    extern fn camel_vee_data_cache_remove_subfolder(p_data_cache: *VeeDataCache, p_subfolder: *camel.Folder) void;
    pub const removeSubfolder = camel_vee_data_cache_remove_subfolder;

    extern fn camel_vee_data_cache_get_type() usize;
    pub const getGObjectType = camel_vee_data_cache_get_type;

    extern fn g_object_ref(p_self: *camel.VeeDataCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeDataCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeDataCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeFolder = extern struct {
    pub const Parent = camel.Folder;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeFolderClass;
    f_parent: camel.Folder,
    f_priv: ?*camel.VeeFolderPrivate,

    pub const virtual_methods = struct {
        /// Adds `subfolder` as a source folder to `vfolder`.
        pub const add_folder = struct {
            pub fn call(p_class: anytype, p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(VeeFolder.Class, p_class).f_add_folder.?(gobject.ext.as(VeeFolder, p_vfolder), p_subfolder, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(VeeFolder.Class, p_class).f_add_folder = @ptrCast(p_implementation);
            }
        };

        pub const folder_changed = struct {
            pub fn call(p_class: anytype, p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_changes: *camel.FolderChangeInfo) void {
                return gobject.ext.as(VeeFolder.Class, p_class).f_folder_changed.?(gobject.ext.as(VeeFolder, p_vfolder), p_subfolder, p_changes);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_changes: *camel.FolderChangeInfo) callconv(.c) void) void {
                gobject.ext.as(VeeFolder.Class, p_class).f_folder_changed = @ptrCast(p_implementation);
            }
        };

        /// Rebuild the folder `subfolder`, if it should be.
        pub const rebuild_folder = struct {
            pub fn call(p_class: anytype, p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(VeeFolder.Class, p_class).f_rebuild_folder.?(gobject.ext.as(VeeFolder, p_vfolder), p_subfolder, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(VeeFolder.Class, p_class).f_rebuild_folder = @ptrCast(p_implementation);
            }
        };

        /// Removed the source folder, `subfolder`, from the virtual folder, `vfolder`.
        pub const remove_folder = struct {
            pub fn call(p_class: anytype, p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(VeeFolder.Class, p_class).f_remove_folder.?(gobject.ext.as(VeeFolder, p_vfolder), p_subfolder, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(VeeFolder.Class, p_class).f_remove_folder = @ptrCast(p_implementation);
            }
        };

        /// Sets an SExp expression to be used for this `vfolder`
        pub const set_expression = struct {
            pub fn call(p_class: anytype, p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8) void {
                return gobject.ext.as(VeeFolder.Class, p_class).f_set_expression.?(gobject.ext.as(VeeFolder, p_vfolder), p_expression);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_vfolder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expression: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(VeeFolder.Class, p_class).f_set_expression = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const auto_update = struct {
            pub const name = "auto-update";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn camel_vee_folder_new(p_parent_store: *camel.Store, p_full: [*:0]const u8, p_flags: u32) *camel.VeeFolder;
    pub const new = camel_vee_folder_new;

    /// Adds `subfolder` as a source folder to `vfolder`.
    extern fn camel_vee_folder_add_folder(p_vfolder: *VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void;
    pub const addFolder = camel_vee_folder_add_folder;

    /// Adds the `mi_data` to the `vfolder`. The `changes` can be
    /// updated with the made change and later used to notify others
    /// with `camel.Folder.changed` on the `vfolder`. This can be used
    /// only for the Unmatched folder.
    extern fn camel_vee_folder_add_vuid(p_vfolder: *VeeFolder, p_mi_data: ?*anyopaque, p_changes: ?*camel.FolderChangeInfo) void;
    pub const addVuid = camel_vee_folder_add_vuid;

    /// Initializes internal structures of the `vf`. This is meant to be
    /// called by the descendants of `camel.VeeFolder`.
    extern fn camel_vee_folder_construct(p_vf: *VeeFolder, p_flags: u32) void;
    pub const construct = camel_vee_folder_construct;

    extern fn camel_vee_folder_get_auto_update(p_vfolder: *VeeFolder) c_int;
    pub const getAutoUpdate = camel_vee_folder_get_auto_update;

    extern fn camel_vee_folder_get_expression(p_vfolder: *VeeFolder) [*:0]const u8;
    pub const getExpression = camel_vee_folder_get_expression;

    extern fn camel_vee_folder_get_flags(p_vf: *VeeFolder) u32;
    pub const getFlags = camel_vee_folder_get_flags;

    /// Find the real folder (and message info UID) for the given `vinfo`.
    /// When the `realuid` is not `NULL` and it's set, then use `glib.free` to
    /// free it, when no longer needed.
    extern fn camel_vee_folder_get_location(p_vf: *VeeFolder, p_vinfo: *const camel.VeeMessageInfo, p_realuid: ?*[*:0]u8) *camel.Folder;
    pub const getLocation = camel_vee_folder_get_location;

    extern fn camel_vee_folder_get_vee_uid_folder(p_vfolder: *VeeFolder, p_vee_message_uid: [*:0]const u8) ?*camel.Folder;
    pub const getVeeUidFolder = camel_vee_folder_get_vee_uid_folder;

    /// The next `subfolder`-'s 'changed' event will be silently ignored. This
    /// is usually used in virtual folders when the change was done in them,
    /// but it is neither vTrash nor vJunk folder. Doing this avoids unnecessary
    /// removals of messages which don't satisfy search criteria anymore,
    /// which could be done on asynchronous delivery of folder's 'changed' signal.
    /// These ignored changes are accumulated and used on folder refresh.
    extern fn camel_vee_folder_ignore_next_changed_event(p_vfolder: *VeeFolder, p_subfolder: *camel.Folder) void;
    pub const ignoreNextChangedEvent = camel_vee_folder_ignore_next_changed_event;

    /// Propagate any skipped changes into the `vf`. The skipped changes are used to not
    /// hide the messages from the search folder unexpectedly. The function does nothing
    /// when there are no changes to be propagated.
    extern fn camel_vee_folder_propagate_skipped_changes(p_vf: *VeeFolder) void;
    pub const propagateSkippedChanges = camel_vee_folder_propagate_skipped_changes;

    /// Rebuild the folder `subfolder`, if it should be.
    extern fn camel_vee_folder_rebuild_folder(p_vfolder: *VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void;
    pub const rebuildFolder = camel_vee_folder_rebuild_folder;

    /// Returns a `glib.List` of all folders of this `vfolder`, which
    /// are used to populate it. These are in no particular order.
    ///
    /// Free the returned `glib.List` with
    /// g_list_free_full (folders, g_object_unref);
    /// when no longer needed.
    extern fn camel_vee_folder_ref_folders(p_vfolder: *VeeFolder) *glib.List;
    pub const refFolders = camel_vee_folder_ref_folders;

    /// Removed the source folder, `subfolder`, from the virtual folder, `vfolder`.
    extern fn camel_vee_folder_remove_folder(p_vfolder: *VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) void;
    pub const removeFolder = camel_vee_folder_remove_folder;

    /// Make sure the next `subfolder`-'s 'changed' event will not be silently ignored.
    /// This is a counter-part function of `camel.VeeFolder.ignoreNextChangedEvent`,
    /// when there was expected a change, which did not happen, to take back the previous
    /// ignore event request.
    extern fn camel_vee_folder_remove_from_ignore_changed_event(p_vfolder: *VeeFolder, p_subfolder: *camel.Folder) void;
    pub const removeFromIgnoreChangedEvent = camel_vee_folder_remove_from_ignore_changed_event;

    /// Removes given `mi_data` from the `vfolder`. The `changes` can be
    /// updated with the made change and later used to notify others
    /// with `camel.Folder.changed` on the `vfolder`. This can be used
    /// only for the Unmatched folder.
    extern fn camel_vee_folder_remove_vuid(p_vfolder: *VeeFolder, p_mi_data: ?*anyopaque, p_changes: ?*camel.FolderChangeInfo) void;
    pub const removeVuid = camel_vee_folder_remove_vuid;

    /// Sets whether the `vfolder` can automatically update when of its
    /// subfolders changes.
    extern fn camel_vee_folder_set_auto_update(p_vfolder: *VeeFolder, p_auto_update: c_int) void;
    pub const setAutoUpdate = camel_vee_folder_set_auto_update;

    /// Sets an SExp expression to be used for this `vfolder`
    extern fn camel_vee_folder_set_expression(p_vfolder: *VeeFolder, p_expression: [*:0]const u8) void;
    pub const setExpression = camel_vee_folder_set_expression;

    /// Set the whole list of folder sources on a vee folder.
    extern fn camel_vee_folder_set_folders(p_vfolder: *VeeFolder, p_folders: *glib.List, p_cancellable: ?*gio.Cancellable) void;
    pub const setFolders = camel_vee_folder_set_folders;

    extern fn camel_vee_folder_get_type() usize;
    pub const getGObjectType = camel_vee_folder_get_type;

    extern fn g_object_ref(p_self: *camel.VeeFolder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeFolder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeFolder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeMessageInfo = extern struct {
    pub const Parent = camel.MessageInfo;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeMessageInfoClass;
    f_parent: camel.MessageInfo,
    f_priv: ?*camel.VeeMessageInfoPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new instance of `camel.VeeMessageInfo` which references
    /// a message from the `original_summary` internally.
    ///
    /// The `vuid` should be encoded in a way which the vFolder understands,
    /// which is like the one returned by `camel.VeeMessageInfoData.getVeeMessageUid`.
    extern fn camel_vee_message_info_new(p_summary: *camel.FolderSummary, p_original_summary: *camel.FolderSummary, p_vuid: [*:0]const u8) *camel.VeeMessageInfo;
    pub const new = camel_vee_message_info_new;

    extern fn camel_vee_message_info_get_original_folder(p_vmi: *const VeeMessageInfo) *camel.Folder;
    pub const getOriginalFolder = camel_vee_message_info_get_original_folder;

    extern fn camel_vee_message_info_get_original_summary(p_vmi: *const VeeMessageInfo) *camel.FolderSummary;
    pub const getOriginalSummary = camel_vee_message_info_get_original_summary;

    extern fn camel_vee_message_info_get_type() usize;
    pub const getGObjectType = camel_vee_message_info_get_type;

    extern fn g_object_ref(p_self: *camel.VeeMessageInfo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeMessageInfo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeMessageInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const VeeMessageInfoData = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeMessageInfoDataClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.VeeMessageInfoDataPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn camel_vee_message_info_data_new(p_subfolder_data: *camel.VeeSubfolderData, p_orig_message_uid: [*:0]const u8) *camel.VeeMessageInfoData;
    pub const new = camel_vee_message_info_data_new;

    extern fn camel_vee_message_info_data_get_orig_message_uid(p_data: *VeeMessageInfoData) [*:0]const u8;
    pub const getOrigMessageUid = camel_vee_message_info_data_get_orig_message_uid;

    extern fn camel_vee_message_info_data_get_subfolder_data(p_data: *VeeMessageInfoData) *camel.VeeSubfolderData;
    pub const getSubfolderData = camel_vee_message_info_data_get_subfolder_data;

    extern fn camel_vee_message_info_data_get_vee_message_uid(p_data: *VeeMessageInfoData) [*:0]const u8;
    pub const getVeeMessageUid = camel_vee_message_info_data_get_vee_message_uid;

    extern fn camel_vee_message_info_data_get_type() usize;
    pub const getGObjectType = camel_vee_message_info_data_get_type;

    extern fn g_object_ref(p_self: *camel.VeeMessageInfoData) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeMessageInfoData) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeMessageInfoData, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeStore = extern struct {
    pub const Parent = camel.Store;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = camel.VeeStoreClass;
    f_parent: camel.Store,
    f_priv: ?*camel.VeeStorePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const unmatched_enabled = struct {
            pub const name = "unmatched-enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `camel.VeeStore` object.
    extern fn camel_vee_store_new() *camel.VeeStore;
    pub const new = camel_vee_store_new;

    extern fn camel_vee_store_get_unmatched_enabled(p_vstore: *VeeStore) c_int;
    pub const getUnmatchedEnabled = camel_vee_store_get_unmatched_enabled;

    extern fn camel_vee_store_get_unmatched_folder(p_vstore: *VeeStore) ?*anyopaque;
    pub const getUnmatchedFolder = camel_vee_store_get_unmatched_folder;

    extern fn camel_vee_store_get_vee_data_cache(p_vstore: *VeeStore) *camel.VeeFolder;
    pub const getVeeDataCache = camel_vee_store_get_vee_data_cache;

    /// This is a counter part of `camel.VeeStore.noteSubfolderUsed`. Once
    /// the `subfolder` is claimed to be not used by all folders its message infos
    /// are removed from the Unmatched folder.
    extern fn camel_vee_store_note_subfolder_unused(p_vstore: *VeeStore, p_subfolder: *camel.Folder, p_unused_by: *camel.VeeFolder) void;
    pub const noteSubfolderUnused = camel_vee_store_note_subfolder_unused;

    /// Notes that the `subfolder` is used by `used_by` folder, which
    /// is used to determine what folders will be included in
    /// the Unmatched folders.
    extern fn camel_vee_store_note_subfolder_used(p_vstore: *VeeStore, p_subfolder: *camel.Folder, p_used_by: *camel.VeeFolder) void;
    pub const noteSubfolderUsed = camel_vee_store_note_subfolder_used;

    /// A counter part of `camel.VeeStore.noteVuidUsed`. Once the `unused_by`
    /// claims the `mi_data` is not used by it anymore, and neither any other
    /// virtual folder is using it, then the Unmatched folder will have it added.
    extern fn camel_vee_store_note_vuid_unused(p_vstore: *VeeStore, p_mi_data: *camel.VeeMessageInfoData, p_unused_by: *camel.VeeFolder) void;
    pub const noteVuidUnused = camel_vee_store_note_vuid_unused;

    /// Notes the `mi_data` is used by the `used_by` virtual folder, which
    /// removes it from the Unmatched folder, if not used anywhere else.
    extern fn camel_vee_store_note_vuid_used(p_vstore: *VeeStore, p_mi_data: *camel.VeeMessageInfoData, p_used_by: *camel.VeeFolder) void;
    pub const noteVuidUsed = camel_vee_store_note_vuid_used;

    /// Let's the `vstore` know to rebuild the Unmatched folder. This is done
    /// as a separate job, when the `cancellable` is `NULL`, otherwise it's run
    /// synchronously.
    extern fn camel_vee_store_rebuild_unmatched_folder(p_vstore: *VeeStore, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) void;
    pub const rebuildUnmatchedFolder = camel_vee_store_rebuild_unmatched_folder;

    /// Sets whether the Unmatched folder processing is enabled.
    extern fn camel_vee_store_set_unmatched_enabled(p_vstore: *VeeStore, p_is_enabled: c_int) void;
    pub const setUnmatchedEnabled = camel_vee_store_set_unmatched_enabled;

    extern fn camel_vee_store_get_type() usize;
    pub const getGObjectType = camel_vee_store_get_type;

    extern fn g_object_ref(p_self: *camel.VeeStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const VeeSubfolderData = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeSubfolderDataClass;
    f_parent: gobject.Object,
    f_priv: ?*camel.VeeSubfolderDataPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `camel.VeeSubfolderData` object for the given `folder`.
    /// The `folder` is referenced for later use.
    extern fn camel_vee_subfolder_data_new(p_folder: *camel.Folder) *camel.VeeSubfolderData;
    pub const new = camel_vee_subfolder_data_new;

    extern fn camel_vee_subfolder_data_get_folder(p_data: *VeeSubfolderData) *camel.Folder;
    pub const getFolder = camel_vee_subfolder_data_get_folder;

    extern fn camel_vee_subfolder_data_get_folder_id(p_data: *VeeSubfolderData) [*:0]const u8;
    pub const getFolderId = camel_vee_subfolder_data_get_folder_id;

    extern fn camel_vee_subfolder_data_get_type() usize;
    pub const getGObjectType = camel_vee_subfolder_data_get_type;

    extern fn g_object_ref(p_self: *camel.VeeSubfolderData) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeSubfolderData) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeSubfolderData, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeSummary = extern struct {
    pub const Parent = camel.FolderSummary;
    pub const Implements = [_]type{};
    pub const Class = camel.VeeSummaryClass;
    f_parent: camel.FolderSummary,
    f_priv: ?*camel.VeeSummaryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This will create a new CamelVeeSummary object and read in the
    /// summary data from disk, if it exists.
    extern fn camel_vee_summary_new(p_parent: *camel.Folder) *camel.VeeSummary;
    pub const new = camel_vee_summary_new;

    /// Unref returned pointer with `gobject.Object.unref`
    extern fn camel_vee_summary_add(p_summary: *VeeSummary, p_mi_data: *camel.VeeMessageInfoData) *camel.VeeMessageInfo;
    pub const add = camel_vee_summary_add;

    /// Returns a hash table of all virtual message info UID-s known to the `summary`.
    /// The key of the hash table is the virtual message info UID, the value is
    /// only the number 1.
    extern fn camel_vee_summary_get_uids_for_subfolder(p_summary: *VeeSummary, p_subfolder: *camel.Folder) *glib.HashTable;
    pub const getUidsForSubfolder = camel_vee_summary_get_uids_for_subfolder;

    /// Removes the given `vuid` of the `subfolder` from the `summary`.
    extern fn camel_vee_summary_remove(p_summary: *VeeSummary, p_vuid: [*:0]const u8, p_subfolder: *camel.Folder) void;
    pub const remove = camel_vee_summary_remove;

    /// Makes sure `summary` flags on `uid` corresponds to those
    /// in the subfolder of vee-folder, and updates internal counts
    /// on `summary` as well.
    extern fn camel_vee_summary_replace_flags(p_summary: *VeeSummary, p_uid: [*:0]const u8) void;
    pub const replaceFlags = camel_vee_summary_replace_flags;

    extern fn camel_vee_summary_get_type() usize;
    pub const getGObjectType = camel_vee_summary_get_type;

    extern fn g_object_ref(p_self: *camel.VeeSummary) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.VeeSummary) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VeeSummary, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const JunkFilter = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = camel.JunkFilterInterface;
    pub const virtual_methods = struct {
        /// Classifies `message` as junk, not junk or inconclusive.
        ///
        /// If an error occurs, the function sets `error` and returns
        /// `CAMEL_JUNK_STATUS_ERROR`.
        pub const classify = struct {
            pub fn call(p_class: anytype, p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) camel.JunkStatus {
                return gobject.ext.as(JunkFilter.Iface, p_class).f_classify.?(gobject.ext.as(JunkFilter, p_junk_filter), p_message, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) camel.JunkStatus) void {
                gobject.ext.as(JunkFilter.Iface, p_class).f_classify = @ptrCast(p_implementation);
            }
        };

        /// Instructs `junk_filter` to classify `message` as junk.  If using an
        /// adaptive junk filtering algorithm, explicitly marking `message` as
        /// junk will influence the classification of future messages.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const learn_junk = struct {
            pub fn call(p_class: anytype, p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(JunkFilter.Iface, p_class).f_learn_junk.?(gobject.ext.as(JunkFilter, p_junk_filter), p_message, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(JunkFilter.Iface, p_class).f_learn_junk = @ptrCast(p_implementation);
            }
        };

        /// Instructs `junk_filter` to classify `message` as not junk.  If using an
        /// adaptive junk filtering algorithm, explicitly marking `message` as not
        /// junk will influence the classification of future messages.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const learn_not_junk = struct {
            pub fn call(p_class: anytype, p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(JunkFilter.Iface, p_class).f_learn_not_junk.?(gobject.ext.as(JunkFilter, p_junk_filter), p_message, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(JunkFilter.Iface, p_class).f_learn_not_junk = @ptrCast(p_implementation);
            }
        };

        /// Instructs `junk_filter` to flush any in-memory caches to disk, if
        /// applicable.  When filtering many messages, delaying this step until
        /// all messages have been classified can improve performance.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const synchronize = struct {
            pub fn call(p_class: anytype, p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(JunkFilter.Iface, p_class).f_synchronize.?(gobject.ext.as(JunkFilter, p_junk_filter), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_junk_filter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(JunkFilter.Iface, p_class).f_synchronize = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Classifies `message` as junk, not junk or inconclusive.
    ///
    /// If an error occurs, the function sets `error` and returns
    /// `CAMEL_JUNK_STATUS_ERROR`.
    extern fn camel_junk_filter_classify(p_junk_filter: *JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) camel.JunkStatus;
    pub const classify = camel_junk_filter_classify;

    /// Instructs `junk_filter` to classify `message` as junk.  If using an
    /// adaptive junk filtering algorithm, explicitly marking `message` as
    /// junk will influence the classification of future messages.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn camel_junk_filter_learn_junk(p_junk_filter: *JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const learnJunk = camel_junk_filter_learn_junk;

    /// Instructs `junk_filter` to classify `message` as not junk.  If using an
    /// adaptive junk filtering algorithm, explicitly marking `message` as not
    /// junk will influence the classification of future messages.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn camel_junk_filter_learn_not_junk(p_junk_filter: *JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const learnNotJunk = camel_junk_filter_learn_not_junk;

    /// Instructs `junk_filter` to flush any in-memory caches to disk, if
    /// applicable.  When filtering many messages, delaying this step until
    /// all messages have been classified can improve performance.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn camel_junk_filter_synchronize(p_junk_filter: *JunkFilter, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const synchronize = camel_junk_filter_synchronize;

    extern fn camel_junk_filter_get_type() usize;
    pub const getGObjectType = camel_junk_filter_get_type;

    extern fn g_object_ref(p_self: *camel.JunkFilter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.JunkFilter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *JunkFilter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkService = opaque {
    pub const Prerequisites = [_]type{camel.Service};
    pub const Iface = camel.NetworkServiceInterface;
    pub const virtual_methods = struct {
        /// Attempts to establish a network connection to the server described by
        /// `service`, using the preferred `camel.NetworkSettings.properties.security`-method to
        /// secure the connection.  If a connection cannot be established, or the
        /// connection attempt is cancelled, the function sets `error` and returns
        /// `NULL`.
        pub const connect_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gio.IOStream {
                return gobject.ext.as(NetworkService.Iface, p_class).f_connect_sync.?(gobject.ext.as(NetworkService, p_service), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*gio.IOStream) void {
                gobject.ext.as(NetworkService.Iface, p_class).f_connect_sync = @ptrCast(p_implementation);
            }
        };

        /// Returns the default network port number for `service` and the security
        /// method `method`, as defined in /etc/services.  For example, the default
        /// port for unencrypted IMAP or encrypted IMAP using STARTTLS is 143, but
        /// the default port for IMAP over SSL is 993.
        pub const get_default_port = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_method: camel.NetworkSecurityMethod) u16 {
                return gobject.ext.as(NetworkService.Iface, p_class).f_get_default_port.?(gobject.ext.as(NetworkService, p_service), p_method);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_method: camel.NetworkSecurityMethod) callconv(.c) u16) void {
                gobject.ext.as(NetworkService.Iface, p_class).f_get_default_port = @ptrCast(p_implementation);
            }
        };

        /// Returns the standard network service name for `service` and the security
        /// method `method`, as defined in /etc/services.  For example, the service
        /// name for unencrypted IMAP or encrypted IMAP using STARTTLS is "imap",
        /// but the service name for IMAP over SSL is "imaps".
        pub const get_service_name = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_method: camel.NetworkSecurityMethod) ?[*:0]const u8 {
                return gobject.ext.as(NetworkService.Iface, p_class).f_get_service_name.?(gobject.ext.as(NetworkService, p_service), p_method);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_method: camel.NetworkSecurityMethod) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(NetworkService.Iface, p_class).f_get_service_name = @ptrCast(p_implementation);
            }
        };

        pub const new_connectable = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gio.SocketConnectable {
                return gobject.ext.as(NetworkService.Iface, p_class).f_new_connectable.?(gobject.ext.as(NetworkService, p_service));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gio.SocketConnectable) void {
                gobject.ext.as(NetworkService.Iface, p_class).f_new_connectable = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const connectable = struct {
            pub const name = "connectable";

            pub const Type = ?*gio.SocketConnectable;
        };

        pub const host_reachable = struct {
            pub const name = "host-reachable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Asynchronously attempts to determine whether or not the host described by
    /// `service`'s `camel.NetworkService.properties.connectable` property can be reached, without
    /// actually trying to connect to it.
    ///
    /// For more details, see `camel.NetworkService.canReachSync`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.NetworkService.canReachFinish` to get the result of the
    /// operation.
    extern fn camel_network_service_can_reach(p_service: *NetworkService, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const canReach = camel_network_service_can_reach;

    /// Finishes the operation started with `camel.NetworkService.canReach`.
    extern fn camel_network_service_can_reach_finish(p_service: *NetworkService, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const canReachFinish = camel_network_service_can_reach_finish;

    /// Attempts to determine whether or not the host described by `service`'s
    /// `camel.NetworkService.properties.connectable` property can be reached, without actually
    /// trying to connect to it.
    ///
    /// If `service` believes an attempt to connect will succeed, the function
    /// returns `TRUE`.  Otherwise the function returns `FALSE` and sets `error`
    /// to an appropriate error (such as `G_IO_ERROR_HOST_UNREACHABLE`).
    ///
    /// The function will also update the `service`'s
    /// `camel.NetworkService.properties.host`-reachable property based on the result.
    extern fn camel_network_service_can_reach_sync(p_service: *NetworkService, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const canReachSync = camel_network_service_can_reach_sync;

    /// Attempts to establish a network connection to the server described by
    /// `service`, using the preferred `camel.NetworkSettings.properties.security`-method to
    /// secure the connection.  If a connection cannot be established, or the
    /// connection attempt is cancelled, the function sets `error` and returns
    /// `NULL`.
    extern fn camel_network_service_connect_sync(p_service: *NetworkService, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gio.IOStream;
    pub const connectSync = camel_network_service_connect_sync;

    /// Returns the default network port number for `service` and the security
    /// method `method`, as defined in /etc/services.  For example, the default
    /// port for unencrypted IMAP or encrypted IMAP using STARTTLS is 143, but
    /// the default port for IMAP over SSL is 993.
    extern fn camel_network_service_get_default_port(p_service: *NetworkService, p_method: camel.NetworkSecurityMethod) u16;
    pub const getDefaultPort = camel_network_service_get_default_port;

    /// Returns `TRUE` if `service` believes that the host pointed to by
    /// `camel.NetworkService.properties.connectable` can be reached.  This property
    /// is updated automatically as network conditions change.
    extern fn camel_network_service_get_host_reachable(p_service: *NetworkService) c_int;
    pub const getHostReachable = camel_network_service_get_host_reachable;

    /// Returns the standard network service name for `service` and the security
    /// method `method`, as defined in /etc/services.  For example, the service
    /// name for unencrypted IMAP or encrypted IMAP using STARTTLS is "imap",
    /// but the service name for IMAP over SSL is "imaps".
    extern fn camel_network_service_get_service_name(p_service: *NetworkService, p_method: camel.NetworkSecurityMethod) ?[*:0]const u8;
    pub const getServiceName = camel_network_service_get_service_name;

    /// Returns the socket endpoint for the network service to which `service`
    /// is a client.
    ///
    /// The returned `gio.SocketConnectable` is referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn camel_network_service_ref_connectable(p_service: *NetworkService) *gio.SocketConnectable;
    pub const refConnectable = camel_network_service_ref_connectable;

    /// Sets the socket endpoint for the network service to which `service` is
    /// a client.  If `connectable` is `NULL`, a `gio.SocketConnectable` is derived
    /// from the `service`'s `camel.NetworkSettings`.
    extern fn camel_network_service_set_connectable(p_service: *NetworkService, p_connectable: ?*gio.SocketConnectable) void;
    pub const setConnectable = camel_network_service_set_connectable;

    /// Creates a `gio.TlsClientConnection` wrapping `base_stream`, which is
    /// assumed to communicate with the server identified by `service`'s
    /// `camel.NetworkService.properties.connectable`.
    ///
    /// This should typically be called after issuing a STARTTLS command
    /// to a server to initiate a Transport Layer Security handshake.
    extern fn camel_network_service_starttls(p_service: *NetworkService, p_base_stream: *gio.IOStream, p_error: ?*?*glib.Error) ?*gio.IOStream;
    pub const starttls = camel_network_service_starttls;

    extern fn camel_network_service_get_type() usize;
    pub const getGObjectType = camel_network_service_get_type;

    extern fn g_object_ref(p_self: *camel.NetworkService) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.NetworkService) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NetworkService, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkSettings = opaque {
    pub const Prerequisites = [_]type{camel.Settings};
    pub const Iface = camel.NetworkSettingsInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const auth_mechanism = struct {
            pub const name = "auth-mechanism";

            pub const Type = ?[*:0]u8;
        };

        pub const host = struct {
            pub const name = "host";

            pub const Type = ?[*:0]u8;
        };

        pub const port = struct {
            pub const name = "port";

            pub const Type = c_uint;
        };

        pub const security_method = struct {
            pub const name = "security-method";

            pub const Type = camel.NetworkSecurityMethod;
        };

        pub const user = struct {
            pub const name = "user";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `camel.NetworkSettings.getAuthMechanism`.
    /// Use this function when accessing `settings` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_network_settings_dup_auth_mechanism(p_settings: *NetworkSettings) ?[*:0]u8;
    pub const dupAuthMechanism = camel_network_settings_dup_auth_mechanism;

    /// Thread-safe variation of `camel.NetworkSettings.getHost`.
    /// Use this function when accessing `settings` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_network_settings_dup_host(p_settings: *NetworkSettings) [*:0]u8;
    pub const dupHost = camel_network_settings_dup_host;

    /// Just like `camel.NetworkSettings.dupHost`, only makes sure that
    /// the returned host name will be converted into its ASCII form in case
    /// of IDNA value.
    extern fn camel_network_settings_dup_host_ensure_ascii(p_settings: *NetworkSettings) [*:0]u8;
    pub const dupHostEnsureAscii = camel_network_settings_dup_host_ensure_ascii;

    /// Thread-safe variation of `camel.NetworkSettings.getUser`.
    /// Use this function when accessing `settings` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn camel_network_settings_dup_user(p_settings: *NetworkSettings) [*:0]u8;
    pub const dupUser = camel_network_settings_dup_user;

    /// Returns the mechanism name used to authenticate to a network service.
    /// Often this refers to a SASL mechanism such as "LOGIN" or "GSSAPI".
    extern fn camel_network_settings_get_auth_mechanism(p_settings: *NetworkSettings) ?[*:0]const u8;
    pub const getAuthMechanism = camel_network_settings_get_auth_mechanism;

    /// Returns the host name used to authenticate to a network service.
    extern fn camel_network_settings_get_host(p_settings: *NetworkSettings) [*:0]const u8;
    pub const getHost = camel_network_settings_get_host;

    /// Returns the port number used to authenticate to a network service.
    extern fn camel_network_settings_get_port(p_settings: *NetworkSettings) u16;
    pub const getPort = camel_network_settings_get_port;

    /// Returns the method used to establish a secure (or unsecure) network
    /// connection.
    extern fn camel_network_settings_get_security_method(p_settings: *NetworkSettings) camel.NetworkSecurityMethod;
    pub const getSecurityMethod = camel_network_settings_get_security_method;

    /// Returns the user name used to authenticate to a network service.
    extern fn camel_network_settings_get_user(p_settings: *NetworkSettings) [*:0]const u8;
    pub const getUser = camel_network_settings_get_user;

    /// Sets the mechanism name used to authenticate to a network service.
    /// Often this refers to a SASL mechanism such as "LOGIN" or "GSSAPI".
    /// The `camel.NetworkSettings.properties.auth`-mechanism property is automatically
    /// stripped of leading and trailing whitespace.
    extern fn camel_network_settings_set_auth_mechanism(p_settings: *NetworkSettings, p_auth_mechanism: ?[*:0]const u8) void;
    pub const setAuthMechanism = camel_network_settings_set_auth_mechanism;

    /// Sets the host name used to authenticate to a network service.  The
    /// `camel.NetworkSettings.properties.host` property is automatically stripped of
    /// leading and trailing whitespace.
    extern fn camel_network_settings_set_host(p_settings: *NetworkSettings, p_host: ?[*:0]const u8) void;
    pub const setHost = camel_network_settings_set_host;

    /// Sets the port number used to authenticate to a network service.
    extern fn camel_network_settings_set_port(p_settings: *NetworkSettings, p_port: u16) void;
    pub const setPort = camel_network_settings_set_port;

    /// Sets the method used to establish a secure (or unsecure) network
    /// connection.  Note that changing this setting has no effect on an
    /// already-established network connection.
    extern fn camel_network_settings_set_security_method(p_settings: *NetworkSettings, p_method: camel.NetworkSecurityMethod) void;
    pub const setSecurityMethod = camel_network_settings_set_security_method;

    /// Sets the user name used to authenticate to a network service.  The
    /// `camel.NetworkSettings.properties.user` property is automatically stripped of
    /// leading and trailing whitespace.
    extern fn camel_network_settings_set_user(p_settings: *NetworkSettings, p_user: ?[*:0]const u8) void;
    pub const setUser = camel_network_settings_set_user;

    extern fn camel_network_settings_get_type() usize;
    pub const getGObjectType = camel_network_settings_get_type;

    extern fn g_object_ref(p_self: *camel.NetworkSettings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.NetworkSettings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NetworkSettings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Subscribable = opaque {
    pub const Prerequisites = [_]type{camel.Store};
    pub const Iface = camel.SubscribableInterface;
    pub const virtual_methods = struct {
        /// Find out if a folder has been subscribed to.
        pub const folder_is_subscribed = struct {
            pub fn call(p_class: anytype, p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8) c_int {
                return gobject.ext.as(Subscribable.Iface, p_class).f_folder_is_subscribed.?(gobject.ext.as(Subscribable, p_subscribable), p_folder_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Subscribable.Iface, p_class).f_folder_is_subscribed = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Subscribable.signals.folder`-subscribed signal from an idle source
        /// on the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_subscribed = struct {
            pub fn call(p_class: anytype, p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) void {
                return gobject.ext.as(Subscribable.Iface, p_class).f_folder_subscribed.?(gobject.ext.as(Subscribable, p_subscribable), p_folder_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) callconv(.c) void) void {
                gobject.ext.as(Subscribable.Iface, p_class).f_folder_subscribed = @ptrCast(p_implementation);
            }
        };

        /// Emits the `camel.Subscribable.signals.folder`-unsubscribed signal from an idle source
        /// on the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
        ///
        /// This function is only intended for Camel providers.
        pub const folder_unsubscribed = struct {
            pub fn call(p_class: anytype, p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) void {
                return gobject.ext.as(Subscribable.Iface, p_class).f_folder_unsubscribed.?(gobject.ext.as(Subscribable, p_subscribable), p_folder_info);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_info: *camel.FolderInfo) callconv(.c) void) void {
                gobject.ext.as(Subscribable.Iface, p_class).f_folder_unsubscribed = @ptrCast(p_implementation);
            }
        };

        /// Subscribes to the folder described by `folder_name`.
        pub const subscribe_folder_sync = struct {
            pub fn call(p_class: anytype, p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Subscribable.Iface, p_class).f_subscribe_folder_sync.?(gobject.ext.as(Subscribable, p_subscribable), p_folder_name, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Subscribable.Iface, p_class).f_subscribe_folder_sync = @ptrCast(p_implementation);
            }
        };

        /// Unsubscribes from the folder described by `folder_name`.
        pub const unsubscribe_folder_sync = struct {
            pub fn call(p_class: anytype, p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Subscribable.Iface, p_class).f_unsubscribe_folder_sync.?(gobject.ext.as(Subscribable, p_subscribable), p_folder_name, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subscribable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Subscribable.Iface, p_class).f_unsubscribe_folder_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const folder_subscribed = struct {
            pub const name = "folder-subscribed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *camel.FolderInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Subscribable, p_instance))),
                    gobject.signalLookup("folder-subscribed", Subscribable.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const folder_unsubscribed = struct {
            pub const name = "folder-unsubscribed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *camel.FolderInfo, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Subscribable, p_instance))),
                    gobject.signalLookup("folder-unsubscribed", Subscribable.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Find out if a folder has been subscribed to.
    extern fn camel_subscribable_folder_is_subscribed(p_subscribable: *Subscribable, p_folder_name: [*:0]const u8) c_int;
    pub const folderIsSubscribed = camel_subscribable_folder_is_subscribed;

    /// Emits the `camel.Subscribable.signals.folder`-subscribed signal from an idle source
    /// on the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_subscribable_folder_subscribed(p_subscribable: *Subscribable, p_folder_info: *camel.FolderInfo) void;
    pub const folderSubscribed = camel_subscribable_folder_subscribed;

    /// Emits the `camel.Subscribable.signals.folder`-unsubscribed signal from an idle source
    /// on the main loop.  The idle source's priority is `G_PRIORITY_HIGH_IDLE`.
    ///
    /// This function is only intended for Camel providers.
    extern fn camel_subscribable_folder_unsubscribed(p_subscribable: *Subscribable, p_folder_info: *camel.FolderInfo) void;
    pub const folderUnsubscribed = camel_subscribable_folder_unsubscribed;

    /// Asynchronously subscribes to the folder described by `folder_name`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Subscribable.subscribeFolderFinish` to get the result of
    /// the operation.
    extern fn camel_subscribable_subscribe_folder(p_subscribable: *Subscribable, p_folder_name: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const subscribeFolder = camel_subscribable_subscribe_folder;

    /// Finishes the operation started with `camel.Subscribable.subscribeFolder`.
    extern fn camel_subscribable_subscribe_folder_finish(p_subscribable: *Subscribable, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const subscribeFolderFinish = camel_subscribable_subscribe_folder_finish;

    /// Subscribes to the folder described by `folder_name`.
    extern fn camel_subscribable_subscribe_folder_sync(p_subscribable: *Subscribable, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const subscribeFolderSync = camel_subscribable_subscribe_folder_sync;

    /// Asynchronously unsubscribes from the folder described by `folder_name`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `camel.Subscribable.unsubscribeFolderFinish` to get the result of
    /// the operation.
    extern fn camel_subscribable_unsubscribe_folder(p_subscribable: *Subscribable, p_folder_name: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const unsubscribeFolder = camel_subscribable_unsubscribe_folder;

    /// Finishes the operation started with `camel.Subscribable.unsubscribeFolder`.
    extern fn camel_subscribable_unsubscribe_folder_finish(p_subscribable: *Subscribable, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const unsubscribeFolderFinish = camel_subscribable_unsubscribe_folder_finish;

    /// Unsubscribes from the folder described by `folder_name`.
    extern fn camel_subscribable_unsubscribe_folder_sync(p_subscribable: *Subscribable, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const unsubscribeFolderSync = camel_subscribable_unsubscribe_folder_sync;

    extern fn camel_subscribable_get_type() usize;
    pub const getGObjectType = camel_subscribable_get_type;

    extern fn g_object_ref(p_self: *camel.Subscribable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *camel.Subscribable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Subscribable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AddressClass = extern struct {
    pub const Instance = camel.Address;

    f_parent_class: gobject.ObjectClass,
    f_length: ?*const fn (p_addr: *camel.Address) callconv(.c) c_int,
    f_decode: ?*const fn (p_addr: *camel.Address, p_raw: [*:0]const u8) callconv(.c) c_int,
    f_encode: ?*const fn (p_addr: *camel.Address) callconv(.c) [*:0]u8,
    f_unformat: ?*const fn (p_addr: *camel.Address, p_raw: [*:0]const u8) callconv(.c) c_int,
    f_format: ?*const fn (p_addr: *camel.Address) callconv(.c) [*:0]u8,
    f_cat: ?*const fn (p_dest: *camel.Address, p_source: *camel.Address) callconv(.c) c_int,
    f_remove: ?*const fn (p_addr: *camel.Address, p_index: c_int) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *AddressClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AddressPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const AsyncClosure = opaque {
    /// Pass this function as the `gio.AsyncReadyCallback` argument of an asynchronous
    /// function, and the `camel.AsyncClosure` as the data argument.
    ///
    /// This causes `camel.AsyncClosure.wait` to terminate and return `result`.
    extern fn camel_async_closure_callback(p_source_object: ?*gobject.Object, p_result: *gio.AsyncResult, p_closure: ?*anyopaque) void;
    pub const callback = camel_async_closure_callback;

    /// Creates a new `camel.AsyncClosure` for use with asynchronous functions.
    extern fn camel_async_closure_new() *camel.AsyncClosure;
    pub const new = camel_async_closure_new;

    /// Frees the `closure` and the resources it holds.
    extern fn camel_async_closure_free(p_closure: *AsyncClosure) void;
    pub const free = camel_async_closure_free;

    /// Call this function immediately after starting an asynchronous operation.
    /// The function waits for the asynchronous operation to complete and returns
    /// its `gio.AsyncResult` to be passed to the operation's "finish" function.
    ///
    /// This function can be called repeatedly on the same `camel.AsyncClosure` to
    /// easily string together multiple asynchronous operations.
    extern fn camel_async_closure_wait(p_closure: *AsyncClosure) *gio.AsyncResult;
    pub const wait = camel_async_closure_wait;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Block = extern struct {
    f_id: camel._block_t,
    f_flags: camel.BlockFlags,
    f_refcount: u32,
    f_align00: u32,
    f_data: [1024]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockFileClass = extern struct {
    pub const Instance = camel.BlockFile;

    f_parent_class: gobject.ObjectClass,
    f_validate_root: ?*const fn (p_bs: *camel.BlockFile) callconv(.c) c_int,
    f_init_root: ?*const fn (p_bs: *camel.BlockFile) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *BlockFileClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockFilePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockRoot = extern struct {
    f_version: [8]u8,
    f_flags: u32,
    f_block_size: u32,
    f_free: camel._block_t,
    f_last: camel._block_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Cert = extern struct {
    f_refcount: c_int,
    f_issuer: ?[*:0]u8,
    f_subject: ?[*:0]u8,
    f_hostname: ?[*:0]u8,
    f_fingerprint: ?[*:0]u8,
    f_trust: camel.CertTrust,
    f_rawcert: ?*glib.Bytes,

    extern fn camel_cert_new() *camel.Cert;
    pub const new = camel_cert_new;

    extern fn camel_cert_load_cert_file(p_cert: *Cert, p_error: ?*?*glib.Error) c_int;
    pub const loadCertFile = camel_cert_load_cert_file;

    extern fn camel_cert_ref(p_cert: *Cert) *camel.Cert;
    pub const ref = camel_cert_ref;

    extern fn camel_cert_save_cert_file(p_cert: *Cert, p_der_data: *const glib.ByteArray, p_error: ?*?*glib.Error) c_int;
    pub const saveCertFile = camel_cert_save_cert_file;

    extern fn camel_cert_unref(p_cert: *Cert) void;
    pub const unref = camel_cert_unref;

    extern fn camel_cert_get_type() usize;
    pub const getGObjectType = camel_cert_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertDBClass = extern struct {
    pub const Instance = camel.CertDB;

    f_parent_class: gobject.ObjectClass,
    f_header_load: ?*const fn (p_certdb: *camel.CertDB, p_istream: ?*anyopaque) callconv(.c) c_int,
    f_header_save: ?*const fn (p_certdb: *camel.CertDB, p_ostream: ?*anyopaque) callconv(.c) c_int,
    f_cert_load: ?*const fn (p_certdb: *camel.CertDB, p_istream: ?*anyopaque) callconv(.c) *camel.Cert,
    f_cert_save: ?*const fn (p_certdb: *camel.CertDB, p_cert: *camel.Cert, p_ostream: ?*anyopaque) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *CertDBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertDBPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Charset = extern struct {
    f_mask: c_uint,
    f_level: c_int,

    /// Finds the minimum charset for this string NULL means US-ASCII.
    extern fn camel_charset_best(p_in: [*]const u8, p_len: c_int) ?[*:0]const u8;
    pub const best = camel_charset_best;

    extern fn camel_charset_iso_to_windows(p_isocharset: [*:0]const u8) [*:0]const u8;
    pub const isoToWindows = camel_charset_iso_to_windows;

    extern fn camel_charset_best_name(p_charset: *Charset) [*:0]const u8;
    pub const bestName = camel_charset_best_name;

    extern fn camel_charset_init(p_c: *Charset) void;
    pub const init = camel_charset_init;

    /// Processes more input text with the `cc`.
    extern fn camel_charset_step(p_cc: *Charset, p_in: [*]const u8, p_len: c_int) void;
    pub const step = camel_charset_step;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherCertInfo = extern struct {
    f_name: ?[*:0]u8,
    f_email: ?[*:0]u8,
    f_cert_data: ?*anyopaque,
    f_cert_data_free: ?glib.DestroyNotify,
    f_cert_data_clone: ?camel.CipherCloneFunc,
    f_properties: ?*glib.SList,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherCertInfoProperty = extern struct {
    f_name: ?[*:0]u8,
    f_value: ?*anyopaque,
    f_value_free: ?glib.DestroyNotify,
    f_value_clone: ?camel.CipherCloneFunc,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherContextClass = extern struct {
    pub const Instance = camel.CipherContext;

    f_parent_class: gobject.ObjectClass,
    f_sign_protocol: ?[*:0]const u8,
    f_encrypt_protocol: ?[*:0]const u8,
    f_key_protocol: ?[*:0]const u8,
    f_id_to_hash: ?*const fn (p_context: *camel.CipherContext, p_id: [*:0]const u8) callconv(.c) camel.CipherHash,
    f_hash_to_id: ?*const fn (p_context: *camel.CipherContext, p_hash: camel.CipherHash) callconv(.c) [*:0]const u8,
    f_sign_sync: ?*const fn (p_context: *camel.CipherContext, p_userid: [*:0]const u8, p_hash: camel.CipherHash, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_verify_sync: ?*const fn (p_context: *camel.CipherContext, p_ipart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.CipherValidity,
    f_encrypt_sync: ?*const fn (p_context: *camel.CipherContext, p_userid: ?[*:0]const u8, p_recipients: *glib.PtrArray, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_decrypt_sync: ?*const fn (p_context: *camel.CipherContext, p_ipart: *camel.MimePart, p_opart: *camel.MimePart, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.CipherValidity,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *CipherContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherContextPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherValidity = extern struct {
    f_children: glib.Queue,
    f_sign: ?*anyopaque,
    f_encrypt: ?*anyopaque,

    extern fn camel_cipher_validity_new() *camel.CipherValidity;
    pub const new = camel_cipher_validity_new;

    /// Add a cert info to the signer or encrypter info.
    extern fn camel_cipher_validity_add_certinfo(p_vin: *CipherValidity, p_mode: camel.CipherValidityMode, p_name: [*:0]const u8, p_email: [*:0]const u8) c_int;
    pub const addCertinfo = camel_cipher_validity_add_certinfo;

    /// Add a cert info to the signer or encrypter info, with extended data set.
    extern fn camel_cipher_validity_add_certinfo_ex(p_vin: *CipherValidity, p_mode: camel.CipherValidityMode, p_name: [*:0]const u8, p_email: [*:0]const u8, p_cert_data: ?*anyopaque, p_cert_data_free: ?glib.DestroyNotify, p_cert_data_clone: ?camel.CipherCloneFunc) c_int;
    pub const addCertinfoEx = camel_cipher_validity_add_certinfo_ex;

    extern fn camel_cipher_validity_clear(p_validity: *CipherValidity) void;
    pub const clear = camel_cipher_validity_clear;

    extern fn camel_cipher_validity_clone(p_vin: *CipherValidity) *camel.CipherValidity;
    pub const clone = camel_cipher_validity_clone;

    /// Calculate a conglomerate validity based on wrapping one secure part inside
    /// another one.
    extern fn camel_cipher_validity_envelope(p_parent: *CipherValidity, p_valid: *camel.CipherValidity) void;
    pub const envelope = camel_cipher_validity_envelope;

    extern fn camel_cipher_validity_free(p_validity: *CipherValidity) void;
    pub const free = camel_cipher_validity_free;

    /// Gets a named property `name` value for the given `info_index` of the `mode` validity part.
    extern fn camel_cipher_validity_get_certinfo_property(p_vin: *CipherValidity, p_mode: camel.CipherValidityMode, p_info_index: c_int, p_name: [*:0]const u8) ?*anyopaque;
    pub const getCertinfoProperty = camel_cipher_validity_get_certinfo_property;

    extern fn camel_cipher_validity_get_description(p_validity: *CipherValidity) [*:0]const u8;
    pub const getDescription = camel_cipher_validity_get_description;

    extern fn camel_cipher_validity_get_valid(p_validity: *CipherValidity) c_int;
    pub const getValid = camel_cipher_validity_get_valid;

    extern fn camel_cipher_validity_init(p_validity: *CipherValidity) void;
    pub const init = camel_cipher_validity_init;

    /// Sets a named property `name` value `value` for the given `info_index`
    /// of the `mode` validity part. If the `value` is `NULL`, then the property
    /// is removed. With a non-`NULL` `value` also `value_free` and `value_clone`
    /// functions cannot be `NULL`.
    extern fn camel_cipher_validity_set_certinfo_property(p_vin: *CipherValidity, p_mode: camel.CipherValidityMode, p_info_index: c_int, p_name: [*:0]const u8, p_value: ?*anyopaque, p_value_free: ?glib.DestroyNotify, p_value_clone: ?camel.CipherCloneFunc) void;
    pub const setCertinfoProperty = camel_cipher_validity_set_certinfo_property;

    extern fn camel_cipher_validity_set_description(p_validity: *CipherValidity, p_description: [*:0]const u8) void;
    pub const setDescription = camel_cipher_validity_set_description;

    extern fn camel_cipher_validity_set_valid(p_validity: *CipherValidity, p_valid: c_int) void;
    pub const setValid = camel_cipher_validity_set_valid;

    extern fn camel_cipher_validity_get_type() usize;
    pub const getGObjectType = camel_cipher_validity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContentDisposition = extern struct {
    f_disposition: ?[*:0]u8,
    f_params: ?*anyopaque,
    f_refcount: c_uint,

    extern fn camel_content_disposition_decode(p_in: [*:0]const u8) *camel.ContentDisposition;
    pub const decode = camel_content_disposition_decode;

    extern fn camel_content_disposition_new() *camel.ContentDisposition;
    pub const new = camel_content_disposition_new;

    extern fn camel_content_disposition_format(p_disposition: *ContentDisposition) [*:0]u8;
    pub const format = camel_content_disposition_format;

    extern fn camel_content_disposition_is_attachment(p_disposition: *const ContentDisposition, p_content_type: *const camel.ContentType) c_int;
    pub const isAttachment = camel_content_disposition_is_attachment;

    extern fn camel_content_disposition_is_attachment_ex(p_disposition: *const ContentDisposition, p_content_type: *const camel.ContentType, p_parent_content_type: *const camel.ContentType) c_int;
    pub const isAttachmentEx = camel_content_disposition_is_attachment_ex;

    extern fn camel_content_disposition_ref(p_disposition: *ContentDisposition) *camel.ContentDisposition;
    pub const ref = camel_content_disposition_ref;

    extern fn camel_content_disposition_unref(p_disposition: *ContentDisposition) void;
    pub const unref = camel_content_disposition_unref;

    extern fn camel_content_disposition_get_type() usize;
    pub const getGObjectType = camel_content_disposition_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContentType = extern struct {
    f_type: ?[*:0]u8,
    f_subtype: ?[*:0]u8,
    f_params: ?*anyopaque,
    f_refcount: c_uint,

    extern fn camel_content_type_decode(p_in: [*:0]const u8) *camel.ContentType;
    pub const decode = camel_content_type_decode;

    /// Create a new `camel.ContentType`.
    extern fn camel_content_type_new(p_type: [*:0]const u8, p_subtype: [*:0]const u8) *camel.ContentType;
    pub const new = camel_content_type_new;

    extern fn camel_content_type_dump(p_content_type: *ContentType) void;
    pub const dump = camel_content_type_dump;

    extern fn camel_content_type_format(p_content_type: *ContentType) [*:0]u8;
    pub const format = camel_content_type_format;

    /// The subtype of "*" will match any subtype.  If `ct` is `NULL`, then
    /// it will match the type "text/plain".
    extern fn camel_content_type_is(p_content_type: ?*const ContentType, p_type: [*:0]const u8, p_subtype: [*:0]const u8) c_int;
    pub const is = camel_content_type_is;

    /// Searches the params on s `camel.ContentType` for a param named `name`
    /// and gets the value.
    extern fn camel_content_type_param(p_content_type: *ContentType, p_name: [*:0]const u8) [*:0]const u8;
    pub const param = camel_content_type_param;

    /// Refs the content type.
    extern fn camel_content_type_ref(p_content_type: *ContentType) *camel.ContentType;
    pub const ref = camel_content_type_ref;

    /// Set a parameter on `content_type`.
    extern fn camel_content_type_set_param(p_content_type: *ContentType, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setParam = camel_content_type_set_param;

    extern fn camel_content_type_simple(p_content_type: *ContentType) [*:0]u8;
    pub const simple = camel_content_type_simple;

    /// Unrefs, and potentially frees, the content type.
    extern fn camel_content_type_unref(p_content_type: *ContentType) void;
    pub const unref = camel_content_type_unref;

    extern fn camel_content_type_get_type() usize;
    pub const getGObjectType = camel_content_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DBClass = extern struct {
    pub const Instance = camel.DB;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *DBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DBPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCacheClass = extern struct {
    pub const Instance = camel.DataCache;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *DataCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataWrapperClass = extern struct {
    pub const Instance = camel.DataWrapper;

    f_parent_class: gobject.ObjectClass,
    f_set_mime_type: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_mime_type: [*:0]const u8) callconv(.c) void,
    f_get_mime_type: ?*const fn (p_data_wrapper: *camel.DataWrapper) callconv(.c) [*:0]u8,
    f_get_mime_type_field: ?*const fn (p_data_wrapper: *camel.DataWrapper) callconv(.c) ?*camel.ContentType,
    f_set_mime_type_field: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_mime_type: ?*camel.ContentType) callconv(.c) void,
    f_is_offline: ?*const fn (p_data_wrapper: *camel.DataWrapper) callconv(.c) c_int,
    f_write_to_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_decode_to_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_construct_from_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_write_to_output_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_decode_to_output_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_output_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_construct_from_input_stream_sync: ?*const fn (p_data_wrapper: *camel.DataWrapper, p_input_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *DataWrapperClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataWrapperPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Values to store/load for single folder's `camel.FolderSummary` structure.
pub const FIRecord = extern struct {
    /// name of the folder
    f_folder_name: ?[*:0]u8,
    /// version of the saved information
    f_version: u32,
    /// folder flags
    f_flags: u32,
    /// next free uid
    f_nextuid: u32,
    /// timestamp of the summary
    f_timestamp: i64,
    /// count of all messages
    f_saved_count: u32,
    /// count of unread messages
    f_unread_count: u32,
    /// count of deleted messages
    f_deleted_count: u32,
    /// count of junk messages
    f_junk_count: u32,
    /// count of visible (not deleted and not junk) messages
    f_visible_count: u32,
    /// count of junk and not deleted messages
    f_jnd_count: u32,
    /// custom data of the `camel.FolderSummary` descendants
    f_bdata: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterDriverClass = extern struct {
    pub const Instance = camel.FilterDriver;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *FilterDriverClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterDriverPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterInputStreamClass = extern struct {
    pub const Instance = camel.FilterInputStream;

    f_parent_class: gio.FilterInputStreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *FilterInputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterInputStreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterOutputStreamClass = extern struct {
    pub const Instance = camel.FilterOutputStream;

    f_parent_class: gio.FilterOutputStreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *FilterOutputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FilterOutputStreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderChangeInfo = extern struct {
    f_uid_added: ?*glib.PtrArray,
    f_uid_removed: ?*glib.PtrArray,
    f_uid_changed: ?*glib.PtrArray,
    f_uid_recent: ?*glib.PtrArray,
    f_priv: ?*camel.FolderChangeInfoPrivate,

    /// Create a new folder change info structure.
    ///
    /// Change info structures are not MT-SAFE and must be
    /// locked for exclusive access externally.
    extern fn camel_folder_change_info_new() *camel.FolderChangeInfo;
    pub const new = camel_folder_change_info_new;

    /// Add a source uid for generating a changeset.
    extern fn camel_folder_change_info_add_source(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const addSource = camel_folder_change_info_add_source;

    /// Add a list of source uid's for generating a changeset.
    extern fn camel_folder_change_info_add_source_list(p_info: *FolderChangeInfo, p_list: *const glib.PtrArray) void;
    pub const addSourceList = camel_folder_change_info_add_source_list;

    /// Add a new uid to the changeinfo.
    extern fn camel_folder_change_info_add_uid(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const addUid = camel_folder_change_info_add_uid;

    /// Add a uid from the updated list, used to generate a changeset diff.
    extern fn camel_folder_change_info_add_update(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const addUpdate = camel_folder_change_info_add_update;

    /// Add a list of uid's from the updated list.
    extern fn camel_folder_change_info_add_update_list(p_info: *FolderChangeInfo, p_list: *const glib.PtrArray) void;
    pub const addUpdateList = camel_folder_change_info_add_update_list;

    /// Compare the source uid set to the updated uid set and generate the
    /// differences into the added and removed lists.
    extern fn camel_folder_change_info_build_diff(p_info: *FolderChangeInfo) void;
    pub const buildDiff = camel_folder_change_info_build_diff;

    /// Concatenate one change info onto antoher. Can be used to copy them
    /// too.
    extern fn camel_folder_change_info_cat(p_info: *FolderChangeInfo, p_src: *camel.FolderChangeInfo) void;
    pub const cat = camel_folder_change_info_cat;

    /// Add a uid to the changed uid list.
    extern fn camel_folder_change_info_change_uid(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const changeUid = camel_folder_change_info_change_uid;

    /// Gets whether or not there have been any changes.
    extern fn camel_folder_change_info_changed(p_info: *FolderChangeInfo) c_int;
    pub const changed = camel_folder_change_info_changed;

    /// Empty out the change info; called after changes have been
    /// processed.
    extern fn camel_folder_change_info_clear(p_info: *FolderChangeInfo) void;
    pub const clear = camel_folder_change_info_clear;

    /// Creates a copy of the `src`.
    extern fn camel_folder_change_info_copy(p_src: *FolderChangeInfo) *camel.FolderChangeInfo;
    pub const copy = camel_folder_change_info_copy;

    /// Free memory associated with the folder change info lists.
    extern fn camel_folder_change_info_free(p_info: *FolderChangeInfo) void;
    pub const free = camel_folder_change_info_free;

    /// Returns an array of added messages UIDs. The returned array, the same as its content,
    /// is owned by the `info`.
    extern fn camel_folder_change_info_get_added_uids(p_info: *FolderChangeInfo) *glib.PtrArray;
    pub const getAddedUids = camel_folder_change_info_get_added_uids;

    /// Returns an array of changed messages UIDs. The returned array, the same as its content,
    /// is owned by the `info`.
    extern fn camel_folder_change_info_get_changed_uids(p_info: *FolderChangeInfo) *glib.PtrArray;
    pub const getChangedUids = camel_folder_change_info_get_changed_uids;

    /// Returns an array of recent messages UIDs. The returned array, the same as its content,
    /// is owned by the `info`.
    extern fn camel_folder_change_info_get_recent_uids(p_info: *FolderChangeInfo) *glib.PtrArray;
    pub const getRecentUids = camel_folder_change_info_get_recent_uids;

    /// Returns an array of removed messages UIDs. The returned array, the same as its content,
    /// is owned by the `info`.
    extern fn camel_folder_change_info_get_removed_uids(p_info: *FolderChangeInfo) *glib.PtrArray;
    pub const getRemovedUids = camel_folder_change_info_get_removed_uids;

    /// Add a recent uid to the changedinfo.
    /// This will also add the uid to the uid_filter array for potential
    /// filtering
    extern fn camel_folder_change_info_recent_uid(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const recentUid = camel_folder_change_info_recent_uid;

    /// Add a uid to the removed uid list.
    extern fn camel_folder_change_info_remove_uid(p_info: *FolderChangeInfo, p_uid: [*:0]const u8) void;
    pub const removeUid = camel_folder_change_info_remove_uid;

    extern fn camel_folder_change_info_get_type() usize;
    pub const getGObjectType = camel_folder_change_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderChangeInfoPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderClass = extern struct {
    pub const Instance = camel.Folder;

    f_parent_class: camel.ObjectClass,
    f_get_message_count: ?*const fn (p_folder: *camel.Folder) callconv(.c) c_int,
    f_get_permanent_flags: ?*const fn (p_folder: *camel.Folder) callconv(.c) u32,
    f_get_message_flags: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8) callconv(.c) u32,
    f_set_message_flags: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_mask: u32, p_set: u32) callconv(.c) c_int,
    f_get_message_user_flag: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8) callconv(.c) c_int,
    f_set_message_user_flag: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: c_int) callconv(.c) void,
    f_get_message_user_tag: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8) callconv(.c) [*:0]const u8,
    f_set_message_user_tag: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void,
    f_get_uids: ?*const fn (p_folder: *camel.Folder) callconv(.c) *glib.PtrArray,
    f_free_uids: ?*const fn (p_folder: *camel.Folder, p_array: *glib.PtrArray) callconv(.c) void,
    f_cmp_uids: ?*const fn (p_folder: *camel.Folder, p_uid1: [*:0]const u8, p_uid2: [*:0]const u8) callconv(.c) c_int,
    f_sort_uids: ?*const fn (p_folder: *camel.Folder, p_uids: *glib.PtrArray) callconv(.c) void,
    f_get_summary: ?*const fn (p_folder: *camel.Folder) callconv(.c) *glib.PtrArray,
    f_free_summary: ?*const fn (p_folder: *camel.Folder, p_array: *glib.PtrArray) callconv(.c) void,
    f_has_search_capability: ?*const fn (p_folder: *camel.Folder) callconv(.c) c_int,
    f_search_by_expression: ?*const fn (p_folder: *camel.Folder, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray,
    f_search_by_uids: ?*const fn (p_folder: *camel.Folder, p_expression: [*:0]const u8, p_uids: *glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray,
    f_search_free: ?*const fn (p_folder: *camel.Folder, p_result: *glib.PtrArray) callconv(.c) void,
    f_get_message_info: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8) callconv(.c) ?*camel.MessageInfo,
    f_delete_: ?*const fn (p_folder: *camel.Folder) callconv(.c) void,
    f_rename: ?*const fn (p_folder: *camel.Folder, p_new_name: [*:0]const u8) callconv(.c) void,
    f_freeze: ?*const fn (p_folder: *camel.Folder) callconv(.c) void,
    f_thaw: ?*const fn (p_folder: *camel.Folder) callconv(.c) void,
    f_is_frozen: ?*const fn (p_folder: *camel.Folder) callconv(.c) c_int,
    f_count_by_expression: ?*const fn (p_folder: *camel.Folder, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) u32,
    f_get_uncached_uids: ?*const fn (p_folder: *camel.Folder, p_uids: *glib.PtrArray, p_error: ?*?*glib.Error) callconv(.c) ?*glib.PtrArray,
    f_get_filename: ?*const fn (p_folder: *camel.Folder, p_uid: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8,
    f_get_message_cached: ?*const fn (p_folder: *camel.Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable) callconv(.c) ?*camel.MimeMessage,
    f_append_message_sync: ?*const fn (p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_info: ?*camel.MessageInfo, p_appended_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_expunge_sync: ?*const fn (p_folder: *camel.Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_message_sync: ?*const fn (p_folder: *camel.Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.MimeMessage,
    f_get_quota_info_sync: ?*const fn (p_folder: *camel.Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderQuotaInfo,
    f_purge_message_cache_sync: ?*const fn (p_folder: *camel.Folder, p_start_uid: [*:0]u8, p_end_uid: [*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_refresh_info_sync: ?*const fn (p_folder: *camel.Folder, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_synchronize_sync: ?*const fn (p_folder: *camel.Folder, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_synchronize_message_sync: ?*const fn (p_folder: *camel.Folder, p_message_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_transfer_messages_to_sync: ?*const fn (p_source: *camel.Folder, p_message_uids: *glib.PtrArray, p_destination: *camel.Folder, p_delete_originals: c_int, p_transferred_uids: ?**glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_prepare_content_refresh: ?*const fn (p_folder: *camel.Folder) callconv(.c) void,
    f_get_full_display_name: ?*const fn (p_folder: *camel.Folder) callconv(.c) [*:0]const u8,
    f_reserved_methods: [19]*anyopaque,
    f_changed: ?*const fn (p_folder: *camel.Folder, p_changes: *camel.FolderChangeInfo) callconv(.c) void,
    f_deleted: ?*const fn (p_folder: *camel.Folder) callconv(.c) void,
    f_renamed: ?*const fn (p_folder: *camel.Folder, p_old_name: [*:0]const u8) callconv(.c) void,
    f_reserved_signals: [20]*anyopaque,

    pub fn as(p_instance: *FolderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderInfo = extern struct {
    f_next: ?*anyopaque,
    f_parent: ?*anyopaque,
    f_child: ?*anyopaque,
    f_full_name: ?[*:0]u8,
    f_display_name: ?[*:0]u8,
    f_flags: camel.FolderInfoFlags,
    f_unread: i32,
    f_total: i32,

    /// This takes an array of folders and attaches them together according
    /// to the hierarchy described by their full_names and `separator`. If
    /// `namespace_` is non-`NULL`, then it will be ignored as a full_name
    /// prefix, for purposes of comparison. If necessary,
    /// `camel.folderInfoBuild` will create additional `camel.FolderInfo` with
    /// `NULL` urls to fill in gaps in the tree. The value of `short_names`
    /// is used in constructing the names of these intermediate folders.
    extern fn camel_folder_info_build(p_folders: *glib.PtrArray, p_namespace_: [*:0]const u8, p_separator: u8, p_short_names: c_int) *camel.FolderInfo;
    pub const build = camel_folder_info_build;

    /// Allocates a new `camel.FolderInfo` instance.  Free it with
    /// `camel.FolderInfo.free`.
    extern fn camel_folder_info_new() *camel.FolderInfo;
    pub const new = camel_folder_info_new;

    /// Clones `fi` recursively.
    extern fn camel_folder_info_clone(p_fi: *FolderInfo) *camel.FolderInfo;
    pub const clone = camel_folder_info_clone;

    /// Frees `fi`.
    extern fn camel_folder_info_free(p_fi: *FolderInfo) void;
    pub const free = camel_folder_info_free;

    extern fn camel_folder_info_get_type() usize;
    pub const getGObjectType = camel_folder_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderQuotaInfo = extern struct {
    /// name, aka identification, of the quota type
    f_name: ?[*:0]u8,
    /// how many bytes is currently in use
    f_used: u64,
    /// what is the maximum quota to use
    f_total: u64,
    /// a reference to a follwing `camel.FolderQuotaInfo`
    f_next: ?*anyopaque,

    extern fn camel_folder_quota_info_new(p_name: [*:0]const u8, p_used: u64, p_total: u64) *camel.FolderQuotaInfo;
    pub const new = camel_folder_quota_info_new;

    /// Makes a copy of the given info and all next-s.
    extern fn camel_folder_quota_info_clone(p_info: *const FolderQuotaInfo) *camel.FolderQuotaInfo;
    pub const clone = camel_folder_quota_info_clone;

    /// Frees this and all next objects.
    extern fn camel_folder_quota_info_free(p_info: *FolderQuotaInfo) void;
    pub const free = camel_folder_quota_info_free;

    extern fn camel_folder_quota_info_get_type() usize;
    pub const getGObjectType = camel_folder_quota_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSearchClass = extern struct {
    pub const Instance = camel.FolderSearch;

    f_parent_class: gobject.ObjectClass,
    f_and_: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_or_: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_not_: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_lt: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_gt: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_eq: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_match_all: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_match_threads: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpTerm, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_body_contains: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_body_regex: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_contains: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_matches: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_starts_with: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_ends_with: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_exists: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_soundex: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_regex: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_header_full_regex: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_user_flag: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_user_tag: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_system_flag: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_get_sent_date: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_get_received_date: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_get_current_date: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_get_relative_months: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_get_size: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_uid: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_message_location: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_make_time: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_compare_date: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_addressbook_contains: ?*const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: **camel.SExpResult, p_search: *camel.FolderSearch) callconv(.c) *camel.SExpResult,
    f_reserved: [17]*anyopaque,

    pub fn as(p_instance: *FolderSearchClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSearchPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSummaryClass = extern struct {
    pub const Instance = camel.FolderSummary;

    f_parent_class: gobject.ObjectClass,
    f_message_info_type: usize,
    f_collate: ?[*:0]const u8,
    f_sort_by: ?[*:0]const u8,
    f_summary_header_load: ?*const fn (p_summary: *camel.FolderSummary, p_fir: ?*anyopaque) callconv(.c) c_int,
    f_summary_header_save: ?*const fn (p_summary: *camel.FolderSummary, p_error: ?*?*glib.Error) callconv(.c) ?*anyopaque,
    f_message_info_new_from_headers: ?*const fn (p_summary: *camel.FolderSummary, p_headers: *const camel.NameValueArray) callconv(.c) *camel.MessageInfo,
    f_message_info_new_from_parser: ?*const fn (p_summary: *camel.FolderSummary, p_parser: *camel.MimeParser) callconv(.c) *camel.MessageInfo,
    f_message_info_new_from_message: ?*const fn (p_summary: *camel.FolderSummary, p_message: *camel.MimeMessage) callconv(.c) *camel.MessageInfo,
    f_message_info_from_uid: ?*const fn (p_summary: *camel.FolderSummary, p_uid: [*:0]const u8) callconv(.c) ?*camel.MessageInfo,
    f_next_uid_string: ?*const fn (p_summary: *camel.FolderSummary) callconv(.c) [*:0]u8,
    f_prepare_fetch_all: ?*const fn (p_summary: *camel.FolderSummary) callconv(.c) void,
    f_reserved: [19]*anyopaque,

    pub fn as(p_instance: *FolderSummaryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSummaryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderThread = extern struct {
    f_refcount: @compileError("can't translate bitfields unless backed by guint"),
    f_subject: @compileError("can't translate bitfields unless backed by guint"),
    f_tree: ?*anyopaque,
    f_node_chunks: ?*camel.MemChunk,
    f_folder: ?*camel.Folder,
    f_summary: ?*glib.PtrArray,

    /// Thread a (subset) of the messages in a folder.  And sort the result
    /// in summary order.
    ///
    /// If `thread_subject` is `TRUE`, messages with
    /// related subjects will also be threaded. The default behaviour is to
    /// only thread based on message-id.
    ///
    /// This function is probably to be removed soon.
    extern fn camel_folder_thread_messages_new(p_folder: *camel.Folder, p_uids: *glib.PtrArray, p_thread_subject: c_int) *camel.FolderThread;
    pub const new = camel_folder_thread_messages_new;

    /// Adds new `uids` into the threaded tree.
    extern fn camel_folder_thread_messages_apply(p_thread: *FolderThread, p_uids: *glib.PtrArray) void;
    pub const apply = camel_folder_thread_messages_apply;

    /// Increase the reference of `thread`
    extern fn camel_folder_thread_messages_ref(p_thread: *FolderThread) *camel.FolderThread;
    pub const ref = camel_folder_thread_messages_ref;

    /// Free all memory associated with the thread descriptor `thread`.
    extern fn camel_folder_thread_messages_unref(p_thread: *FolderThread) void;
    pub const unref = camel_folder_thread_messages_unref;

    extern fn camel_folder_thread_messages_get_type() usize;
    pub const getGObjectType = camel_folder_thread_messages_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderThreadNode = extern struct {
    f_next: ?*anyopaque,
    f_parent: ?*anyopaque,
    f_child: ?*anyopaque,
    f_message: ?*const camel.MessageInfo,
    f_root_subject: ?[*:0]u8,
    f_order: @compileError("can't translate bitfields unless backed by guint"),
    f_re: @compileError("can't translate bitfields unless backed by guint"),

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GpgContextClass = extern struct {
    pub const Instance = camel.GpgContext;

    f_parent_class: camel.CipherContextClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *GpgContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GpgContextPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque structure holding information about a user key.
pub const GpgKeyInfo = opaque {
    /// Copies the `src` to a new `camel.GpgKeyInfo` structure.
    extern fn camel_gpg_key_info_copy(p_src: ?*const GpgKeyInfo) ?*camel.GpgKeyInfo;
    pub const copy = camel_gpg_key_info_copy;

    /// Frees the `info` previously allocated by `camel.GpgContext.getPublicKeyInfoSync`,
    /// `camel.GpgContext.getKeyDataInfoSync` or `camel.GpgKeyInfo.copy`.
    extern fn camel_gpg_key_info_free(p_info: *GpgKeyInfo) void;
    pub const free = camel_gpg_key_info_free;

    /// Gets the key creating date, as seconds since the Unix Epoch.
    extern fn camel_gpg_key_info_get_creation_date(p_info: *const GpgKeyInfo) i64;
    pub const getCreationDate = camel_gpg_key_info_get_creation_date;

    /// Gets the key fingerprint.
    extern fn camel_gpg_key_info_get_fingerprint(p_info: *const GpgKeyInfo) [*:0]const u8;
    pub const getFingerprint = camel_gpg_key_info_get_fingerprint;

    /// Gets the key ID.
    extern fn camel_gpg_key_info_get_id(p_info: *const GpgKeyInfo) [*:0]const u8;
    pub const getId = camel_gpg_key_info_get_id;

    /// Gets the key trust level, as one of `camel.GpgTrust`.
    extern fn camel_gpg_key_info_get_trust(p_info: *const GpgKeyInfo) camel.GpgTrust;
    pub const getTrust = camel_gpg_key_info_get_trust;

    /// Gets the user IDs associated with the key.
    extern fn camel_gpg_key_info_get_user_ids(p_info: *const GpgKeyInfo) *glib.SList;
    pub const getUserIds = camel_gpg_key_info_get_user_ids;

    extern fn camel_gpg_key_info_get_type() usize;
    pub const getGObjectType = camel_gpg_key_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HTMLParserClass = extern struct {
    pub const Instance = camel.HTMLParser;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *HTMLParserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HTMLParserPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HeaderAddress = extern struct {
    f_next: ?*anyopaque,
    f_type: camel.HeaderAddressType,
    f_name: ?[*:0]u8,
    anon0: extern union {
        f_addr: ?[*:0]u8,
        f_members: ?*anyopaque,
    },
    f_refcount: c_uint,

    extern fn camel_header_address_decode(p_in: [*:0]const u8, p_charset: [*:0]const u8) *camel.HeaderAddress;
    pub const decode = camel_header_address_decode;

    extern fn camel_header_address_fold(p_in: [*:0]const u8, p_headerlen: usize) [*:0]u8;
    pub const fold = camel_header_address_fold;

    /// TODO: Document me.
    extern fn camel_header_address_list_append(p_addrlistp: [*]*camel.HeaderAddress, p_addr: *camel.HeaderAddress) void;
    pub const listAppend = camel_header_address_list_append;

    /// TODO: Document me.
    extern fn camel_header_address_list_append_list(p_addrlistp: [*]*camel.HeaderAddress, p_addrs: [*]*camel.HeaderAddress) void;
    pub const listAppendList = camel_header_address_list_append_list;

    /// TODO: Document me.
    extern fn camel_header_address_list_clear(p_addrlistp: [*]*camel.HeaderAddress) void;
    pub const listClear = camel_header_address_list_clear;

    /// TODO: Document me.
    extern fn camel_header_address_list_encode(p_addrlist: [*]camel.HeaderAddress) [*:0]u8;
    pub const listEncode = camel_header_address_list_encode;

    /// TODO: Document me.
    extern fn camel_header_address_list_format(p_addrlist: [*]camel.HeaderAddress) [*:0]u8;
    pub const listFormat = camel_header_address_list_format;

    extern fn camel_header_address_new() *camel.HeaderAddress;
    pub const new = camel_header_address_new;

    extern fn camel_header_address_new_group(p_name: [*:0]const u8) *camel.HeaderAddress;
    pub const newGroup = camel_header_address_new_group;

    extern fn camel_header_address_new_name(p_name: [*:0]const u8, p_addr: [*:0]const u8) *camel.HeaderAddress;
    pub const newName = camel_header_address_new_name;

    extern fn camel_header_address_add_member(p_addrlist: *HeaderAddress, p_member: *camel.HeaderAddress) void;
    pub const addMember = camel_header_address_add_member;

    extern fn camel_header_address_ref(p_addrlist: *HeaderAddress) *camel.HeaderAddress;
    pub const ref = camel_header_address_ref;

    extern fn camel_header_address_set_addr(p_addrlist: *HeaderAddress, p_addr: [*:0]const u8) void;
    pub const setAddr = camel_header_address_set_addr;

    /// TODO: Document me.
    extern fn camel_header_address_set_members(p_addrlist: *HeaderAddress, p_group: [*]camel.HeaderAddress) void;
    pub const setMembers = camel_header_address_set_members;

    extern fn camel_header_address_set_name(p_addrlist: *HeaderAddress, p_name: [*:0]const u8) void;
    pub const setName = camel_header_address_set_name;

    extern fn camel_header_address_unref(p_addrlist: *HeaderAddress) void;
    pub const unref = camel_header_address_unref;

    extern fn camel_header_address_get_type() usize;
    pub const getGObjectType = camel_header_address_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HeaderParam = extern struct {
    f_next: ?*anyopaque,
    f_name: ?[*:0]u8,
    f_value: ?[*:0]u8,

    extern fn camel_header_param_list_decode(p_in: ?[*:0]const u8) ?*anyopaque;
    pub const listDecode = camel_header_param_list_decode;

    extern fn camel_header_param_list_format(p_params: ?*anyopaque) [*:0]u8;
    pub const listFormat = camel_header_param_list_format;

    extern fn camel_header_param_list_format_append(p_out: *glib.String, p_params: ?*anyopaque) void;
    pub const listFormatAppend = camel_header_param_list_format_append;

    /// Free the list of params.
    extern fn camel_header_param_list_free(p_params: ?*anyopaque) void;
    pub const listFree = camel_header_param_list_free;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexClass = extern struct {
    pub const Instance = camel.Index;

    f_parent_class: gobject.ObjectClass,
    f_sync: ?*const fn (p_index: *camel.Index) callconv(.c) c_int,
    f_compress: ?*const fn (p_index: *camel.Index) callconv(.c) c_int,
    f_delete_: ?*const fn (p_index: *camel.Index) callconv(.c) c_int,
    f_rename: ?*const fn (p_index: *camel.Index, p_path: [*:0]const u8) callconv(.c) c_int,
    f_has_name: ?*const fn (p_index: *camel.Index, p_name: [*:0]const u8) callconv(.c) c_int,
    f_add_name: ?*const fn (p_index: *camel.Index, p_name: [*:0]const u8) callconv(.c) ?*camel.IndexName,
    f_write_name: ?*const fn (p_index: *camel.Index, p_idn: *camel.IndexName) callconv(.c) c_int,
    f_find_name: ?*const fn (p_index: *camel.Index, p_name: [*:0]const u8) callconv(.c) ?*camel.IndexCursor,
    f_delete_name: ?*const fn (p_index: *camel.Index, p_name: [*:0]const u8) callconv(.c) void,
    f_find: ?*const fn (p_index: *camel.Index, p_word: [*:0]const u8) callconv(.c) ?*camel.IndexCursor,
    f_words: ?*const fn (p_index: *camel.Index) callconv(.c) ?*camel.IndexCursor,

    pub fn as(p_instance: *IndexClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexCursorClass = extern struct {
    pub const Instance = camel.IndexCursor;

    f_parent: gobject.ObjectClass,
    f_next: ?*const fn (p_idc: *camel.IndexCursor) callconv(.c) [*:0]const u8,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *IndexCursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexCursorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexNameClass = extern struct {
    pub const Instance = camel.IndexName;

    f_parent: gobject.ObjectClass,
    f_add_word: ?*const fn (p_name: *camel.IndexName, p_word: [*:0]const u8) callconv(.c) void,
    f_add_buffer: ?*const fn (p_name: *camel.IndexName, p_buffer: [*:0]const u8, p_len: usize) callconv(.c) usize,

    pub fn as(p_instance: *IndexNameClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexNamePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IndexPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InternetAddressClass = extern struct {
    pub const Instance = camel.InternetAddress;

    f_parent_class: camel.AddressClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *InternetAddressClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InternetAddressPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const JunkFilterInterface = extern struct {
    pub const Instance = camel.JunkFilter;

    f_parent_interface: gobject.TypeInterface,
    f_classify: ?*const fn (p_junk_filter: *camel.JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) camel.JunkStatus,
    f_learn_junk: ?*const fn (p_junk_filter: *camel.JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_learn_not_junk: ?*const fn (p_junk_filter: *camel.JunkFilter, p_message: *camel.MimeMessage, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_synchronize: ?*const fn (p_junk_filter: *camel.JunkFilter, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *JunkFilterInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyBlock = extern struct {
    f_next: camel._block_t,
    f_used: u32,
    anon0: extern union {
        f_keys: [0]*anyopaque,
        f_keydata: [1016]u8,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyFileClass = extern struct {
    pub const Instance = camel.KeyFile;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *KeyFileClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyFilePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyRootBlock = extern struct {
    f_first: camel._block_t,
    f_last: camel._block_t,
    f_free: camel._key_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyTableClass = extern struct {
    pub const Instance = camel.KeyTable;

    f_parent: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *KeyTableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyTablePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LocalSettingsClass = extern struct {
    pub const Instance = camel.LocalSettings;

    f_parent_class: camel.StoreSettingsClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *LocalSettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LocalSettingsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The extensive DB format, supporting basic searching and sorting.
pub const MIRecord = extern struct {
    /// Message UID
    f_uid: ?[*:0]const u8,
    /// Camel Message info flags
    f_flags: u32,
    /// unused
    f_msg_type: u32,
    /// whether the message info requires upload to the server; it corresponds to `CAMEL_MESSAGE_FOLDER_FLAGGED`
    f_dirty: u32,
    /// boolean read status
    f_read: c_int,
    /// boolean deleted status
    f_deleted: c_int,
    /// boolean replied status
    f_replied: c_int,
    /// boolean important status
    f_important: c_int,
    /// boolean junk status
    f_junk: c_int,
    /// boolean attachment status
    f_attachment: c_int,
    /// size of the mail
    f_size: u32,
    /// date sent
    f_dsent: i64,
    /// date received
    f_dreceived: i64,
    /// subject of the mail
    f_subject: ?[*:0]const u8,
    /// sender
    f_from: ?[*:0]const u8,
    /// recipient
    f_to: ?[*:0]const u8,
    /// CC members
    f_cc: ?[*:0]const u8,
    /// message list headers
    f_mlist: ?[*:0]const u8,
    /// followup flag / also can be queried to see for followup or not
    f_followup_flag: ?[*:0]u8,
    /// completed date, can be used to see if completed
    f_followup_completed_on: ?[*:0]u8,
    /// to see the due by date
    f_followup_due_by: ?[*:0]u8,
    /// part / references / thread id
    f_part: ?[*:0]u8,
    /// labels of mails also called as userflags
    f_labels: ?[*:0]u8,
    /// composite string of user tags
    f_usertags: ?[*:0]u8,
    /// content info string - composite string
    f_cinfo: ?[*:0]u8,
    /// provider specific data
    f_bdata: ?[*:0]u8,
    /// value for user-defined message headers; Since: 3.42
    f_userheaders: ?[*:0]u8,
    /// message body preview; Since: 3.42
    f_preview: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MediumClass = extern struct {
    pub const Instance = camel.Medium;

    f_parent_class: camel.DataWrapperClass,
    f_add_header: ?*const fn (p_medium: *camel.Medium, p_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void,
    f_set_header: ?*const fn (p_medium: *camel.Medium, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) void,
    f_remove_header: ?*const fn (p_medium: *camel.Medium, p_name: [*:0]const u8) callconv(.c) void,
    f_get_header: ?*const fn (p_medium: *camel.Medium, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8,
    f_dup_headers: ?*const fn (p_medium: *camel.Medium) callconv(.c) *camel.NameValueArray,
    f_get_headers: ?*const fn (p_medium: *camel.Medium) callconv(.c) *const camel.NameValueArray,
    f_get_content: ?*const fn (p_medium: *camel.Medium) callconv(.c) ?*camel.DataWrapper,
    f_set_content: ?*const fn (p_medium: *camel.Medium, p_content: ?*camel.DataWrapper) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MediumClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MediumPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemChunk = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemPool = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageContentInfo = extern struct {
    f_next: ?*camel.MessageContentInfo,
    f_childs: ?*camel.MessageContentInfo,
    f_parent: ?*camel.MessageContentInfo,
    f_type: ?*camel.ContentType,
    f_disposition: ?*camel.ContentDisposition,
    f_id: ?[*:0]u8,
    f_description: ?[*:0]u8,
    f_encoding: ?[*:0]u8,
    f_size: u32,

    /// Allocate a new `camel.MessageContentInfo`.
    extern fn camel_message_content_info_new() *camel.MessageContentInfo;
    pub const new = camel_message_content_info_new;

    extern fn camel_message_content_info_new_from_headers(p_headers: *const camel.NameValueArray) *camel.MessageContentInfo;
    pub const newFromHeaders = camel_message_content_info_new_from_headers;

    extern fn camel_message_content_info_new_from_message(p_mime_part: *camel.MimePart) *camel.MessageContentInfo;
    pub const newFromMessage = camel_message_content_info_new_from_message;

    extern fn camel_message_content_info_new_from_parser(p_parser: *camel.MimeParser) *camel.MessageContentInfo;
    pub const newFromParser = camel_message_content_info_new_from_parser;

    extern fn camel_message_content_info_copy(p_src: ?*const MessageContentInfo) ?*camel.MessageContentInfo;
    pub const copy = camel_message_content_info_copy;

    extern fn camel_message_content_info_dump(p_ci: *MessageContentInfo, p_depth: c_int) void;
    pub const dump = camel_message_content_info_dump;

    /// Recursively frees the content info `ci`, and all associated memory.
    extern fn camel_message_content_info_free(p_ci: *MessageContentInfo) void;
    pub const free = camel_message_content_info_free;

    /// Calls the `func` for each `camel.MessageContentInfo`, including the top one.
    /// The `func` can return `TRUE` to continue processing or `FALSE` to stop it.
    extern fn camel_message_content_info_traverse(p_ci: *MessageContentInfo, p_func: camel.MessageContentInfoTraverseCallback, p_user_data: ?*anyopaque) c_int;
    pub const traverse = camel_message_content_info_traverse;

    extern fn camel_message_content_info_get_type() usize;
    pub const getGObjectType = camel_message_content_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfoBaseClass = extern struct {
    pub const Instance = camel.MessageInfoBase;

    f_parent_class: camel.MessageInfoClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MessageInfoBaseClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfoBasePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfoClass = extern struct {
    pub const Instance = camel.MessageInfo;

    f_parent_class: gobject.ObjectClass,
    f_clone: ?*const fn (p_mi: *const camel.MessageInfo, p_assign_summary: ?*camel.FolderSummary) callconv(.c) *camel.MessageInfo,
    f_load: ?*const fn (p_mi: *camel.MessageInfo, p_record: ?*const camel.MIRecord, p_bdata_ptr: *[*:0]u8) callconv(.c) c_int,
    f_save: ?*const fn (p_mi: *const camel.MessageInfo, p_record: ?*camel.MIRecord, p_bdata_str: *glib.String) callconv(.c) c_int,
    f_get_flags: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) u32,
    f_set_flags: ?*const fn (p_mi: *camel.MessageInfo, p_mask: u32, p_set: u32) callconv(.c) c_int,
    f_get_user_flag: ?*const fn (p_mi: *const camel.MessageInfo, p_name: [*:0]const u8) callconv(.c) c_int,
    f_set_user_flag: ?*const fn (p_mi: *camel.MessageInfo, p_name: [*:0]const u8, p_state: c_int) callconv(.c) c_int,
    f_get_user_flags: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*const camel.NamedFlags,
    f_dup_user_flags: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*camel.NamedFlags,
    f_take_user_flags: ?*const fn (p_mi: *camel.MessageInfo, p_user_flags: ?*camel.NamedFlags) callconv(.c) c_int,
    f_get_user_tag: ?*const fn (p_mi: *const camel.MessageInfo, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8,
    f_set_user_tag: ?*const fn (p_mi: *camel.MessageInfo, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) c_int,
    f_get_user_tags: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*const camel.NameValueArray,
    f_dup_user_tags: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*camel.NameValueArray,
    f_take_user_tags: ?*const fn (p_mi: *camel.MessageInfo, p_user_tags: ?*camel.NameValueArray) callconv(.c) c_int,
    f_get_subject: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) [*:0]const u8,
    f_set_subject: ?*const fn (p_mi: *camel.MessageInfo, p_subject: ?[*:0]const u8) callconv(.c) c_int,
    f_get_from: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) [*:0]const u8,
    f_set_from: ?*const fn (p_mi: *camel.MessageInfo, p_from: ?[*:0]const u8) callconv(.c) c_int,
    f_get_to: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) [*:0]const u8,
    f_set_to: ?*const fn (p_mi: *camel.MessageInfo, p_to: ?[*:0]const u8) callconv(.c) c_int,
    f_get_cc: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) [*:0]const u8,
    f_set_cc: ?*const fn (p_mi: *camel.MessageInfo, p_cc: ?[*:0]const u8) callconv(.c) c_int,
    f_get_mlist: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) [*:0]const u8,
    f_set_mlist: ?*const fn (p_mi: *camel.MessageInfo, p_mlist: ?[*:0]const u8) callconv(.c) c_int,
    f_get_size: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) u32,
    f_set_size: ?*const fn (p_mi: *camel.MessageInfo, p_size: u32) callconv(.c) c_int,
    f_get_date_sent: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) i64,
    f_set_date_sent: ?*const fn (p_mi: *camel.MessageInfo, p_date_sent: i64) callconv(.c) c_int,
    f_get_date_received: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) i64,
    f_set_date_received: ?*const fn (p_mi: *camel.MessageInfo, p_date_received: i64) callconv(.c) c_int,
    f_get_message_id: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) u64,
    f_set_message_id: ?*const fn (p_mi: *camel.MessageInfo, p_message_id: u64) callconv(.c) c_int,
    f_get_references: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*const glib.Array,
    f_take_references: ?*const fn (p_mi: *camel.MessageInfo, p_references: ?*glib.Array) callconv(.c) c_int,
    f_get_headers: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*const camel.NameValueArray,
    f_take_headers: ?*const fn (p_mi: *camel.MessageInfo, p_headers: ?*camel.NameValueArray) callconv(.c) c_int,
    f_get_user_header: ?*const fn (p_mi: *const camel.MessageInfo, p_name: [*:0]const u8) callconv(.c) ?[*:0]const u8,
    f_set_user_header: ?*const fn (p_mi: *camel.MessageInfo, p_name: [*:0]const u8, p_value: ?[*:0]const u8) callconv(.c) c_int,
    f_get_user_headers: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?*const camel.NameValueArray,
    f_take_user_headers: ?*const fn (p_mi: *camel.MessageInfo, p_headers: ?*camel.NameValueArray) callconv(.c) c_int,
    f_get_preview: ?*const fn (p_mi: *const camel.MessageInfo) callconv(.c) ?[*:0]const u8,
    f_set_preview: ?*const fn (p_mi: *camel.MessageInfo, p_preview: ?[*:0]const u8) callconv(.c) c_int,
    f_reserved: [14]*anyopaque,

    pub fn as(p_instance: *MessageInfoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageInfoPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBasicClass = extern struct {
    pub const Instance = camel.MimeFilterBasic;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterBasicClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBasicPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBestencClass = extern struct {
    pub const Instance = camel.MimeFilterBestenc;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterBestencClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBestencPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCRLFClass = extern struct {
    pub const Instance = camel.MimeFilterCRLF;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterCRLFClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCRLFPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCanonClass = extern struct {
    pub const Instance = camel.MimeFilterCanon;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterCanonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCanonPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCharsetClass = extern struct {
    pub const Instance = camel.MimeFilterCharset;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterCharsetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCharsetPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterClass = extern struct {
    pub const Instance = camel.MimeFilter;

    f_parent_class: gobject.ObjectClass,
    f_filter: ?*const fn (p_filter: *camel.MimeFilter, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) callconv(.c) void,
    f_complete: ?*const fn (p_filter: *camel.MimeFilter, p_in: [*]const u8, p_len: usize, p_prespace: usize, p_out: *[*]u8, p_outlen: *usize, p_outprespace: *usize) callconv(.c) void,
    f_reset: ?*const fn (p_filter: *camel.MimeFilter) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterEnrichedClass = extern struct {
    pub const Instance = camel.MimeFilterEnriched;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterEnrichedClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterEnrichedPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterFromClass = extern struct {
    pub const Instance = camel.MimeFilterFrom;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterFromClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterFromPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterGZipClass = extern struct {
    pub const Instance = camel.MimeFilterGZip;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterGZipClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterGZipPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterHTMLClass = extern struct {
    pub const Instance = camel.MimeFilterHTML;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterHTMLClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterHTMLPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterIndexClass = extern struct {
    pub const Instance = camel.MimeFilterIndex;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterIndexClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterIndexPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterLinewrapClass = extern struct {
    pub const Instance = camel.MimeFilterLinewrap;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterLinewrapClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterLinewrapPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPgpClass = extern struct {
    pub const Instance = camel.MimeFilterPgp;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterPgpClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPgpPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPreviewClass = extern struct {
    pub const Instance = camel.MimeFilterPreview;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [4]*anyopaque,

    pub fn as(p_instance: *MimeFilterPreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPreviewPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterProgressClass = extern struct {
    pub const Instance = camel.MimeFilterProgress;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterProgressClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterProgressPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterToHTMLClass = extern struct {
    pub const Instance = camel.MimeFilterToHTML;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterToHTMLClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterToHTMLPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterWindowsClass = extern struct {
    pub const Instance = camel.MimeFilterWindows;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterWindowsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterWindowsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterYencClass = extern struct {
    pub const Instance = camel.MimeFilterYenc;

    f_parent_class: camel.MimeFilterClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeFilterYencClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterYencPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeMessageClass = extern struct {
    pub const Instance = camel.MimeMessage;

    f_parent_class: camel.MimePartClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeMessageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeMessagePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeParserClass = extern struct {
    pub const Instance = camel.MimeParser;

    f_parent_class: gobject.ObjectClass,
    f_message: ?*const fn (p_parser: *camel.MimeParser, p_headers: ?*anyopaque) callconv(.c) void,
    f_part: ?*const fn (p_parser: *camel.MimeParser) callconv(.c) void,
    f_content: ?*const fn (p_parser: *camel.MimeParser) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MimeParserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeParserPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimePartClass = extern struct {
    pub const Instance = camel.MimePart;

    f_parent_class: camel.MediumClass,
    f_construct_from_parser_sync: ?*const fn (p_mime_part: *camel.MimePart, p_parser: *camel.MimeParser, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_generate_preview: ?*const fn (p_mime_part: *camel.MimePart, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8,
    f_reserved: [19]*anyopaque,

    pub fn as(p_instance: *MimePartClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimePartPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Msg = extern struct {
    /// a `camel.MsgPort` this `camel.Msg` belongs to
    f_reply_port: ?*camel.MsgPort,
    f_flags: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MsgPort = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartClass = extern struct {
    pub const Instance = camel.Multipart;

    f_parent_class: camel.DataWrapperClass,
    f_add_part: ?*const fn (p_multipart: *camel.Multipart, p_part: *camel.MimePart) callconv(.c) void,
    f_get_part: ?*const fn (p_multipart: *camel.Multipart, p_index: c_uint) callconv(.c) ?*camel.MimePart,
    f_get_number: ?*const fn (p_multipart: *camel.Multipart) callconv(.c) c_uint,
    f_get_boundary: ?*const fn (p_multipart: *camel.Multipart) callconv(.c) [*:0]const u8,
    f_set_boundary: ?*const fn (p_multipart: *camel.Multipart, p_boundary: ?[*:0]const u8) callconv(.c) void,
    f_construct_from_parser: ?*const fn (p_multipart: *camel.Multipart, p_parser: *camel.MimeParser) callconv(.c) c_int,
    f_generate_preview: ?*const fn (p_multipart: *camel.Multipart, p_func: ?camel.GeneratePreviewFunc, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8,
    f_reserved: [19]*anyopaque,

    pub fn as(p_instance: *MultipartClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartEncryptedClass = extern struct {
    pub const Instance = camel.MultipartEncrypted;

    f_parent_class: camel.MultipartClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MultipartEncryptedClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartEncryptedPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartSignedClass = extern struct {
    pub const Instance = camel.MultipartSigned;

    f_parent_class: camel.MultipartClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *MultipartSignedClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartSignedPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NNTPAddressClass = extern struct {
    pub const Instance = camel.NNTPAddress;

    f_parent_class: camel.AddressClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *NNTPAddressClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NNTPAddressPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NameValueArray = opaque {
    /// Creates a new `camel.NameValueArray`. The returned pointer should be freed
    /// with `camel.NameValueArray.free` when no longer needed.
    extern fn camel_name_value_array_new() *camel.NameValueArray;
    pub const new = camel_name_value_array_new;

    /// Creates a new `camel.NameValueArray`, which has reserved `reserve_size`
    /// elements. This value doesn't influence the `camel.NameValueArray.getLength`,
    /// which returns zero on the array returned from this function. The returned
    /// pointer should be freed with `camel.NameValueArray.free` when no longer needed.
    extern fn camel_name_value_array_new_sized(p_reserve_size: c_uint) *camel.NameValueArray;
    pub const newSized = camel_name_value_array_new_sized;

    /// Appends a new element of the name `name` and the value `value`
    /// at the end of `array`.
    ///
    /// See: camel_name_value_array_set_named
    extern fn camel_name_value_array_append(p_array: *NameValueArray, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const append = camel_name_value_array_append;

    /// Removes all elements of the `array`.
    extern fn camel_name_value_array_clear(p_array: *NameValueArray) void;
    pub const clear = camel_name_value_array_clear;

    /// Creates a new copy of the `array`. The returned pointer should be freed
    /// with `camel.NameValueArray.free` when no longer needed.
    extern fn camel_name_value_array_copy(p_array: ?*const NameValueArray) *camel.NameValueArray;
    pub const copy = camel_name_value_array_copy;

    /// Compares content of the two `camel.NameValueArray` and returns whether
    /// they equal. Note this is an expensive operation for large arrays.
    extern fn camel_name_value_array_equal(p_array_a: ?*const NameValueArray, p_array_b: ?*const camel.NameValueArray, p_compare_type: camel.CompareType) c_int;
    pub const equal = camel_name_value_array_equal;

    /// Frees the `array`, previously allocated by `camel.NameValueArray.new`,
    /// `camel.NameValueArray.newSized` or `camel.NameValueArray.copy`.
    /// If the `array` is `NULL`, then does nothing.
    extern fn camel_name_value_array_free(p_array: ?*NameValueArray) void;
    pub const free = camel_name_value_array_free;

    /// Returns the name and the value of the element at index `index`. Either
    /// of the `out_name` and `out_value` can be `NULL`, to not return that part.
    extern fn camel_name_value_array_get(p_array: *const NameValueArray, p_index: c_uint, p_out_name: ?*[*:0]const u8, p_out_value: ?*[*:0]const u8) c_int;
    pub const get = camel_name_value_array_get;

    extern fn camel_name_value_array_get_length(p_array: ?*const NameValueArray) c_uint;
    pub const getLength = camel_name_value_array_get_length;

    /// Returns the name of the element at index `index`.
    extern fn camel_name_value_array_get_name(p_array: *const NameValueArray, p_index: c_uint) ?[*:0]const u8;
    pub const getName = camel_name_value_array_get_name;

    /// Returns the value of the first element named `name`, or `NULL` when there
    /// is no element of such `name` in the `array`. The `compare_type` determines
    /// how to compare the names.
    extern fn camel_name_value_array_get_named(p_array: *const NameValueArray, p_compare_type: camel.CompareType, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getNamed = camel_name_value_array_get_named;

    /// Returns the value of the element at index `index`.
    extern fn camel_name_value_array_get_value(p_array: *const NameValueArray, p_index: c_uint) ?[*:0]const u8;
    pub const getValue = camel_name_value_array_get_value;

    /// Removes element at index `index`.
    extern fn camel_name_value_array_remove(p_array: *NameValueArray, p_index: c_uint) c_int;
    pub const remove = camel_name_value_array_remove;

    /// Removes elements of the `array` with the given `name`.
    /// The `compare_type` determines hot to compare the names.
    /// If the `all_occurrences` is set to `TRUE`, then every elements with the `name`
    /// are removed, otherwise only the first occurrence is removed.
    extern fn camel_name_value_array_remove_named(p_array: *NameValueArray, p_compare_type: camel.CompareType, p_name: [*:0]const u8, p_all_occurrences: c_int) c_uint;
    pub const removeNamed = camel_name_value_array_remove_named;

    /// Sets both the `name` and the `value` of the element at index `index`.
    extern fn camel_name_value_array_set(p_array: *NameValueArray, p_index: c_uint, p_name: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const set = camel_name_value_array_set;

    /// Sets the `name` of the element at index `index`.
    extern fn camel_name_value_array_set_name(p_array: *NameValueArray, p_index: c_uint, p_name: [*:0]const u8) c_int;
    pub const setName = camel_name_value_array_set_name;

    /// Finds an element named `name` and sets its value to `value`, or appends
    /// a new element, in case no such named element exists in the `array` yet.
    /// In case there are more elements named with `name` only the first
    /// occurrence is changed. The `compare_type` determines how to compare
    /// the names.
    extern fn camel_name_value_array_set_named(p_array: *NameValueArray, p_compare_type: camel.CompareType, p_name: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const setNamed = camel_name_value_array_set_named;

    /// Sets the `value` of the element at index `index`.
    extern fn camel_name_value_array_set_value(p_array: *NameValueArray, p_index: c_uint, p_value: [*:0]const u8) c_int;
    pub const setValue = camel_name_value_array_set_value;

    extern fn camel_name_value_array_get_type() usize;
    pub const getGObjectType = camel_name_value_array_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NamedFlags = opaque {
    /// Creates a new `camel.NamedFlags`.
    extern fn camel_named_flags_new() *camel.NamedFlags;
    pub const new = camel_named_flags_new;

    /// Created a new `camel.NamedFlags`, which has reserved `reserve_size`
    /// elements. This value doesn't influence the `camel.NamedFlags.getLength`,
    /// which returns zero on the array returned from this function.
    extern fn camel_named_flags_new_sized(p_reserve_size: c_uint) *camel.NamedFlags;
    pub const newSized = camel_named_flags_new_sized;

    /// Removes all the elements of the array.
    extern fn camel_named_flags_clear(p_named_flags: *NamedFlags) void;
    pub const clear = camel_named_flags_clear;

    extern fn camel_named_flags_contains(p_named_flags: *const NamedFlags, p_name: [*:0]const u8) c_int;
    pub const contains = camel_named_flags_contains;

    /// Creates a copy of the `named_flags` and returns it.
    extern fn camel_named_flags_copy(p_named_flags: ?*const NamedFlags) *camel.NamedFlags;
    pub const copy = camel_named_flags_copy;

    /// Compares content of the two `camel.NamedFlags` and returns whether
    /// they equal. Note this is an expensive operation for large sets.
    extern fn camel_named_flags_equal(p_named_flags_a: ?*const NamedFlags, p_named_flags_b: ?*const camel.NamedFlags) c_int;
    pub const equal = camel_named_flags_equal;

    /// Frees memory associated iwth the `named_flags`. Does nothing,
    /// if `named_flags` is `NULL`.
    extern fn camel_named_flags_free(p_named_flags: ?*NamedFlags) void;
    pub const free = camel_named_flags_free;

    extern fn camel_named_flags_get(p_named_flags: *const NamedFlags, p_index: c_uint) ?[*:0]const u8;
    pub const get = camel_named_flags_get;

    extern fn camel_named_flags_get_length(p_named_flags: ?*const NamedFlags) c_uint;
    pub const getLength = camel_named_flags_get_length;

    /// Inserts a flag named `name` into the `named_flags`, if it is not included
    /// already (comparing case sensitively), or does nothing otherwise.
    extern fn camel_named_flags_insert(p_named_flags: *NamedFlags, p_name: [*:0]const u8) c_int;
    pub const insert = camel_named_flags_insert;

    /// Removes a flag named `name` from the `named_flags`.
    extern fn camel_named_flags_remove(p_named_flags: *NamedFlags, p_name: [*:0]const u8) c_int;
    pub const remove = camel_named_flags_remove;

    extern fn camel_named_flags_get_type() usize;
    pub const getGObjectType = camel_named_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkServiceInterface = extern struct {
    pub const Instance = camel.NetworkService;

    f_parent_interface: gobject.TypeInterface,
    f_get_service_name: ?*const fn (p_service: *camel.NetworkService, p_method: camel.NetworkSecurityMethod) callconv(.c) ?[*:0]const u8,
    f_get_default_port: ?*const fn (p_service: *camel.NetworkService, p_method: camel.NetworkSecurityMethod) callconv(.c) u16,
    f_connect_sync: ?*const fn (p_service: *camel.NetworkService, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*gio.IOStream,
    f_new_connectable: ?*const fn (p_service: *camel.NetworkService) callconv(.c) *gio.SocketConnectable,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *NetworkServiceInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkSettingsInterface = extern struct {
    pub const Instance = camel.NetworkSettings;

    f_parent_interface: gobject.TypeInterface,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *NetworkSettingsInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NullOutputStreamClass = extern struct {
    pub const Instance = camel.NullOutputStream;

    f_parent_class: gio.OutputStreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *NullOutputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NullOutputStreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectBag = opaque {
    /// Returns a new object bag.  Object bags are keyed hash tables of objects
    /// that can be updated atomically using transaction semantics.  Use
    /// `camel.ObjectBag.destroy` to free the object bag.
    extern fn camel_object_bag_new(p_key_hash_func: glib.HashFunc, p_key_equal_func: glib.EqualFunc, p_key_copy_func: camel.CopyFunc, p_key_free_func: glib.FreeFunc) *camel.ObjectBag;
    pub const new = camel_object_bag_new;

    /// Aborts a key reservation.
    extern fn camel_object_bag_abort(p_bag: *ObjectBag, p_key: ?*const anyopaque) void;
    pub const abort = camel_object_bag_abort;

    /// Adds `object` to `bag`.  The `key` MUST have been previously reserved using
    /// `camel.ObjectBag.reserve`.
    extern fn camel_object_bag_add(p_bag: *ObjectBag, p_key: ?*const anyopaque, p_object: ?*anyopaque) void;
    pub const add = camel_object_bag_add;

    /// Frees `bag`.  As a precaution, the function will emit a warning to standard
    /// error and return without freeing `bag` if `bag` still has reserved keys.
    extern fn camel_object_bag_destroy(p_bag: *ObjectBag) void;
    pub const destroy = camel_object_bag_destroy;

    /// Lookup an object by `key`.  If the key is currently reserved, the function
    /// will block until another thread commits or aborts the reservation.  The
    /// caller owns the reference to the returned object.  Use g_object_unref ()
    /// to unreference it.
    extern fn camel_object_bag_get(p_bag: *ObjectBag, p_key: ?*const anyopaque) ?*anyopaque;
    pub const get = camel_object_bag_get;

    /// Returns a `glib.PtrArray` of all the objects in the bag.  The caller owns
    /// both the array and the object references, so to free the array use:
    ///
    /// ```
    ///     g_ptr_array_foreach (array, (GFunc) g_object_unref, NULL);
    ///     g_ptr_array_free (array, TRUE);
    /// ```
    extern fn camel_object_bag_list(p_bag: *ObjectBag) *glib.PtrArray;
    pub const list = camel_object_bag_list;

    /// Returns the object for `key` in `bag`, ignoring any reservations.  If it
    /// isn't committed, then it isn't considered.  This should only be used
    /// where reliable transactional-based state is not required.
    ///
    /// Unlink other "peek" operations, the caller owns the returned object
    /// reference.  Use g_object_unref () to unreference it.
    extern fn camel_object_bag_peek(p_bag: *ObjectBag, p_key: ?*const anyopaque) ?*anyopaque;
    pub const peek = camel_object_bag_peek;

    /// Changes the key for `object` to `new_key`, atomically.
    ///
    /// It is considered a programming error if `object` is not found in `bag`.
    /// In such case the function will emit a terminal warning and return.
    extern fn camel_object_bag_rekey(p_bag: *ObjectBag, p_object: ?*anyopaque, p_new_key: ?*const anyopaque) void;
    pub const rekey = camel_object_bag_rekey;

    /// Removes `object` from `bag`.
    extern fn camel_object_bag_remove(p_bag: *ObjectBag, p_object: ?*anyopaque) void;
    pub const remove = camel_object_bag_remove;

    /// Reserves `key` in `bag`.  If `key` is already reserved in another thread,
    /// then wait until the reservation has been committed.
    ///
    /// After reserving `key`, you either get a reference to the object
    /// corresponding to `key` (similar to `camel.ObjectBag.get`) or you get
    /// `NULL`, signifying that you MUST call either `camel.ObjectBag.add` or
    /// `camel.ObjectBag.abort`.
    extern fn camel_object_bag_reserve(p_bag: *ObjectBag, p_key: ?*const anyopaque) ?*anyopaque;
    pub const reserve = camel_object_bag_reserve;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectClass = extern struct {
    pub const Instance = camel.Object;

    f_parent_class: gobject.ObjectClass,
    f_state_read: ?*const fn (p_object: *camel.Object, p_fp: ?*anyopaque) callconv(.c) c_int,
    f_state_write: ?*const fn (p_object: *camel.Object, p_fp: ?*anyopaque) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *ObjectClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineFolderClass = extern struct {
    pub const Instance = camel.OfflineFolder;

    f_parent_class: camel.FolderClass,
    f_downsync_sync: ?*const fn (p_folder: *camel.OfflineFolder, p_expression: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *OfflineFolderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineFolderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineSettingsClass = extern struct {
    pub const Instance = camel.OfflineSettings;

    f_parent_class: camel.StoreSettingsClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *OfflineSettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineSettingsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineStoreClass = extern struct {
    pub const Instance = camel.OfflineStore;

    f_parent_class: camel.StoreClass,
    f_dup_downsync_folders: ?*const fn (p_store: *camel.OfflineStore) callconv(.c) *glib.PtrArray,
    f_reserved: [19]*anyopaque,

    pub fn as(p_instance: *OfflineStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OfflineStorePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OperationClass = extern struct {
    pub const Instance = camel.Operation;

    f_parent_class: gio.CancellableClass,
    f_status: ?*const fn (p_operation: *camel.Operation, p_what: [*:0]const u8, p_pc: c_int) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *OperationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OperationPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionKey = extern struct {
    f_hashid: camel._hash_t,
    f_keyid: camel._key_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionKeyBlock = extern struct {
    f_used: u32,
    f_keys: [0]*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionMap = extern struct {
    f_hashid: camel._hash_t,
    f_blockid: camel._block_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionMapBlock = extern struct {
    f_next: camel._block_t,
    f_used: u32,
    f_partition: [0]*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionTableClass = extern struct {
    pub const Instance = camel.PartitionTable;

    f_parent: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *PartitionTableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PartitionTablePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Provider = extern struct {
    f_protocol: ?[*:0]const u8,
    f_name: ?[*:0]const u8,
    f_description: ?[*:0]const u8,
    f_domain: ?[*:0]const u8,
    f_flags: camel.ProviderFlags,
    f_url_flags: camel.ProviderURLFlags,
    f_extra_conf: ?*camel.ProviderConfEntry,
    f_port_entries: ?*camel.ProviderPortEntry,
    f_auto_detect: ?camel.ProviderAutoDetectFunc,
    f_object_types: ?[*]usize,
    f_authtypes: ?*glib.List,
    f_url_hash: ?glib.HashFunc,
    f_url_equal: ?glib.EqualFunc,
    f_translation_domain: ?[*:0]const u8,
    f_priv: ?*anyopaque,

    /// Returns the registered `camel.Provider` for `protocol`, loading it
    /// from disk if necessary.  If no `camel.Provider` can be found for
    /// `protocol`, or the provider module fails to load, the function
    /// sets `error` and returns `NULL`.
    ///
    /// The returned `camel.Provider` is owned by Camel and should not be
    /// modified or freed.
    extern fn camel_provider_get(p_protocol: [*:0]const u8, p_error: ?*?*glib.Error) ?*camel.Provider;
    pub const get = camel_provider_get;

    /// Initialize the Camel provider system by reading in the .urls
    /// files in the provider directory and creating a hash table mapping
    /// URLs to module names.
    ///
    /// A .urls file has the same initial prefix as the shared library it
    /// correspond to, and consists of a series of lines containing the URL
    /// protocols that that library handles.
    ///
    /// TODO: This should be pathed?
    /// TODO: This should be plugin-d?
    extern fn camel_provider_init() void;
    pub const init = camel_provider_init;

    /// This returns a list of available providers. If `load` is `TRUE`, it will
    /// first load in all available providers that haven't yet been loaded.
    ///
    /// Free the returned list with `glib.List.free`.  The `camel.Provider` structs
    /// in the list are owned by Camel and should not be modified or freed.
    extern fn camel_provider_list(p_load: c_int) *glib.List;
    pub const list = camel_provider_list;

    /// Loads the provider at `path`, and calls its initialization function,
    /// passing `session` as an argument. The provider should then register
    /// itself with `session`.
    extern fn camel_provider_load(p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const load = camel_provider_load;

    /// After filling in the standard Username/Hostname/Port/Path settings
    /// (which must be set in `url`), if the provider supports it, you
    /// may wish to have the provider auto-detect further settings based on
    /// the aformentioned settings.
    ///
    /// If the provider does not support auto-detection, `auto_detected`
    /// will be set to `NULL`. Otherwise the provider will attempt to
    /// auto-detect whatever it can and file them into `auto_detected`. If
    /// for some reason it cannot auto-detect anything (not enough
    /// information provided in `url`?) then `auto_detected` will be
    /// set to `NULL` and an exception may be set to explain why it failed.
    extern fn camel_provider_auto_detect(p_provider: *Provider, p_url: *camel.URL, p_auto_detected: ?**glib.HashTable, p_error: ?*?*glib.Error) c_int;
    pub const autoDetect = camel_provider_auto_detect;

    /// Registers a provider.
    extern fn camel_provider_register(p_provider: *Provider) void;
    pub const register = camel_provider_register;

    extern fn camel_provider_get_type() usize;
    pub const getGObjectType = camel_provider_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderConfEntry = extern struct {
    f_type: camel.ProviderConfType,
    f_name: ?[*:0]const u8,
    f_depname: ?[*:0]const u8,
    f_text: ?[*:0]const u8,
    f_value: ?[*:0]const u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderModule = extern struct {
    f_path: ?[*:0]u8,
    f_types: ?*glib.SList,
    bitfields0: packed struct(c_uint) {
        f_loaded: u1,
        _: u31,
    },

    extern fn camel_provider_module_init() void;
    pub const init = camel_provider_module_init;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderPortEntry = extern struct {
    /// port number
    f_port: c_int,
    /// human description of the port
    f_desc: ?[*:0]const u8,
    /// a boolean whether the port is used together with TLS/SSL
    f_is_ssl: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SExpClass = extern struct {
    pub const Instance = camel.SExp;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SExpClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SExpPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SExpResult = extern struct {
    /// a `camel.SExpResultType`, defining the `value` type
    f_type: camel.SExpResultType,
    anon0: extern union {
        f_ptrarray: ?*glib.PtrArray,
        f_number: c_int,
        f_string: ?[*:0]u8,
        f_boolean: c_int,
        f_time: std.posix.time_t,
    },
    /// a boolean whether the occuring times are used
    f_time_generator: c_int,
    /// start time
    f_occuring_start: std.posix.time_t,
    /// end time
    f_occuring_end: std.posix.time_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a function or a variable symbol
pub const SExpSymbol = extern struct {
    /// a type of the symbol, either CAMEL_SEXP_TERM_FUNC or CAMEL_SEXP_TERM_VAR
    f_type: c_int,
    /// name of the symbol
    f_name: ?[*:0]u8,
    /// user data for the callback
    /// `f`.func: a `camel.SExpFunc` callback
    /// `f`.ifunc: a `camel.SExpIFunc` callback
    f_data: ?*anyopaque,
    anon0: extern union {
        f_func: ?camel.SExpFunc,
        f_ifunc: ?camel.SExpIFunc,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SExpTerm = extern struct {
    /// a type of the term; one of `camel.SExpTermType`
    f_type: camel.SExpTermType,
    anon0: extern union {
        f_string: ?[*:0]u8,
        f_number: c_int,
        f_boolean: c_int,
        f_time: std.posix.time_t,
        anon0: extern struct {
            f_sym: ?*camel.SExpSymbol,
            f_terms: ?**camel.SExpTerm,
            f_termcount: c_int,
        },
        f_var: ?*camel.SExpSymbol,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SMIMEContextClass = extern struct {
    pub const Instance = camel.SMIMEContext;

    f_parent_class: camel.CipherContextClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SMIMEContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SMIMEContextPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslAnonymousClass = extern struct {
    pub const Instance = camel.SaslAnonymous;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslAnonymousClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslAnonymousPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslClass = extern struct {
    pub const Instance = camel.Sasl;

    f_parent_class: gobject.ObjectClass,
    f_auth_type: ?*camel.ServiceAuthType,
    f_try_empty_password_sync: ?*const fn (p_sasl: *camel.Sasl, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_challenge_sync: ?*const fn (p_sasl: *camel.Sasl, p_token: ?*glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.ByteArray,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslCramMd5Class = extern struct {
    pub const Instance = camel.SaslCramMd5;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslCramMd5Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslCramMd5Private = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslDigestMd5Class = extern struct {
    pub const Instance = camel.SaslDigestMd5;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslDigestMd5Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslDigestMd5Private = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslGssapiClass = extern struct {
    pub const Instance = camel.SaslGssapi;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslGssapiClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslGssapiPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslLoginClass = extern struct {
    pub const Instance = camel.SaslLogin;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslLoginClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslLoginPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslNTLMClass = extern struct {
    pub const Instance = camel.SaslNTLM;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslNTLMClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslNTLMPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPOPB4SMTPClass = extern struct {
    pub const Instance = camel.SaslPOPB4SMTP;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslPOPB4SMTPClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPOPB4SMTPPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPlainClass = extern struct {
    pub const Instance = camel.SaslPlain;

    f_parent_class: camel.SaslClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *SaslPlainClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPlainPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2Class = extern struct {
    pub const Instance = camel.SaslXOAuth2;

    f_parent_class: camel.SaslClass,

    pub fn as(p_instance: *SaslXOAuth2Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2GoogleClass = extern struct {
    pub const Instance = camel.SaslXOAuth2Google;

    f_parent_class: camel.SaslXOAuth2Class,

    pub fn as(p_instance: *SaslXOAuth2GoogleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2GooglePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2OutlookClass = extern struct {
    pub const Instance = camel.SaslXOAuth2Outlook;

    f_parent_class: camel.SaslXOAuth2Class,

    pub fn as(p_instance: *SaslXOAuth2OutlookClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2OutlookPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2Private = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2YahooClass = extern struct {
    pub const Instance = camel.SaslXOAuth2Yahoo;

    f_parent_class: camel.SaslXOAuth2Class,

    pub fn as(p_instance: *SaslXOAuth2YahooClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslXOAuth2YahooPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServiceAuthType = extern struct {
    f_name: ?[*:0]const u8,
    f_description: ?[*:0]const u8,
    f_authproto: ?[*:0]const u8,
    f_need_password: c_int,

    /// Copies the `service_auth_type` struct.
    /// Does nothing and returns the given object in reality, needed for the introspection.
    extern fn camel_service_auth_type_copy(p_service_auth_type: *const ServiceAuthType) *camel.ServiceAuthType;
    pub const copy = camel_service_auth_type_copy;

    /// Frees the `service_auth_type` struct.
    /// Does nothing in reality, needed for the introspection.
    extern fn camel_service_auth_type_free(p_service_auth_type: *ServiceAuthType) void;
    pub const free = camel_service_auth_type_free;

    extern fn camel_service_auth_type_get_type() usize;
    pub const getGObjectType = camel_service_auth_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServiceClass = extern struct {
    pub const Instance = camel.Service;

    f_parent_class: camel.ObjectClass,
    f_settings_type: usize,
    f_get_name: ?*const fn (p_service: *camel.Service, p_brief: c_int) callconv(.c) [*:0]u8,
    f_connect_sync: ?*const fn (p_service: *camel.Service, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_disconnect_sync: ?*const fn (p_service: *camel.Service, p_clean: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_authenticate_sync: ?*const fn (p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) camel.AuthenticationResult,
    f_query_auth_types_sync: ?*const fn (p_service: *camel.Service, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*glib.List,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *ServiceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServicePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionClass = extern struct {
    pub const Instance = camel.Session;

    f_parent_class: gobject.ObjectClass,
    f_add_service: ?*const fn (p_session: *camel.Session, p_uid: [*:0]const u8, p_protocol: [*:0]const u8, p_type: camel.ProviderType, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Service,
    f_remove_service: ?*const fn (p_session: *camel.Session, p_service: *camel.Service) callconv(.c) void,
    f_get_password: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_prompt: [*:0]const u8, p_item: [*:0]const u8, p_flags: u32, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8,
    f_forget_password: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_item: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_trust_prompt: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_certificate: *gio.TlsCertificate, p_errors: gio.TlsCertificateFlags) callconv(.c) camel.CertTrust,
    f_get_filter_driver: ?*const fn (p_session: *camel.Session, p_type: [*:0]const u8, p_for_folder: ?*camel.Folder, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FilterDriver,
    f_lookup_addressbook: ?*const fn (p_session: *camel.Session, p_name: [*:0]const u8) callconv(.c) c_int,
    f_authenticate_sync: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_mechanism: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_forward_to_sync: ?*const fn (p_session: *camel.Session, p_folder: *camel.Folder, p_message: *camel.MimeMessage, p_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_oauth2_access_token_sync: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_recipient_certificates_sync: ?*const fn (p_session: *camel.Session, p_flags: u32, p_recipients: *const glib.PtrArray, p_out_certificates: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_addressbook_contains_sync: ?*const fn (p_session: *camel.Session, p_book_uid: [*:0]const u8, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved_methods: [18]*anyopaque,
    f_job_started: ?*const fn (p_session: *camel.Session, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    f_job_finished: ?*const fn (p_session: *camel.Session, p_cancellable: ?*gio.Cancellable, p_error: *const glib.Error) callconv(.c) void,
    f_user_alert: ?*const fn (p_session: *camel.Session, p_service: *camel.Service, p_type: camel.SessionAlertType, p_message: [*:0]const u8) callconv(.c) void,
    f_reserved_signals: [20]*anyopaque,

    pub fn as(p_instance: *SessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SettingsClass = extern struct {
    pub const Instance = camel.Settings;

    f_parent_class: gobject.ObjectClass,
    f_list_settings: ?*const fn (p_klass: *camel.SettingsClass, p_n_settings: *c_uint) callconv(.c) **gobject.ParamSpec,
    f_clone: ?*const fn (p_settings: *camel.Settings) callconv(.c) *camel.Settings,
    f_equal: ?*const fn (p_settings_a: *camel.Settings, p_settings_b: *camel.Settings) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    /// Returns an array of `gobject.ParamSpec` for properties of `class` which are
    /// considered to be settings.  By default all properties are considered
    /// to be settings, but subclasses may wish to exclude certain properties.
    /// Free the returned array with `glib.free`.
    extern fn camel_settings_class_list_settings(p_settings_class: *SettingsClass, p_n_settings: *c_uint) **gobject.ParamSpec;
    pub const listSettings = camel_settings_class_list_settings;

    pub fn as(p_instance: *SettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SettingsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreClass = extern struct {
    pub const Instance = camel.Store;

    f_parent_class: camel.ServiceClass,
    f_hash_folder_name: ?glib.HashFunc,
    f_equal_folder_name: ?glib.EqualFunc,
    f_can_refresh_folder: ?*const fn (p_store: *camel.Store, p_info: *camel.FolderInfo, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_folder_sync: ?*const fn (p_store: *camel.Store, p_folder_name: [*:0]const u8, p_flags: camel.StoreGetFolderFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder,
    f_get_folder_info_sync: ?*const fn (p_store: *camel.Store, p_top: ?[*:0]const u8, p_flags: camel.StoreGetFolderInfoFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderInfo,
    f_get_inbox_folder_sync: ?*const fn (p_store: *camel.Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder,
    f_get_junk_folder_sync: ?*const fn (p_store: *camel.Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder,
    f_get_trash_folder_sync: ?*const fn (p_store: *camel.Store, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder,
    f_create_folder_sync: ?*const fn (p_store: *camel.Store, p_parent_name: ?[*:0]const u8, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.FolderInfo,
    f_delete_folder_sync: ?*const fn (p_store: *camel.Store, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_rename_folder_sync: ?*const fn (p_store: *camel.Store, p_old_name: [*:0]const u8, p_new_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_synchronize_sync: ?*const fn (p_store: *camel.Store, p_expunge: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_initial_setup_sync: ?*const fn (p_store: *camel.Store, p_out_save_setup: *glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_can_auto_save_changes: ?*const fn (p_store: *camel.Store) callconv(.c) c_int,
    f_reserved_methods: [19]*anyopaque,
    f_folder_created: ?*const fn (p_store: *camel.Store, p_folder_info: *camel.FolderInfo) callconv(.c) void,
    f_folder_deleted: ?*const fn (p_store: *camel.Store, p_folder_info: *camel.FolderInfo) callconv(.c) void,
    f_folder_opened: ?*const fn (p_store: *camel.Store, p_folder: *camel.Folder) callconv(.c) void,
    f_folder_renamed: ?*const fn (p_store: *camel.Store, p_old_name: [*:0]const u8, p_folder_info: *camel.FolderInfo) callconv(.c) void,
    f_folder_info_stale: ?*const fn (p_store: *camel.Store) callconv(.c) void,
    f_reserved_signals: [20]*anyopaque,

    pub fn as(p_instance: *StoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreInfo = extern struct {
    f_refcount: c_int,
    f_summary: ?*camel.StoreSummary,
    f_path: ?[*:0]u8,
    f_flags: u32,
    f_unread: u32,
    f_total: u32,

    /// Returns the last segment of the path string from `info`.
    extern fn camel_store_info_name(p_summary: *camel.StoreSummary, p_info: *camel.StoreInfo) [*:0]const u8;
    pub const name = camel_store_info_name;

    /// Returns the path string from `info`.
    extern fn camel_store_info_path(p_summary: *camel.StoreSummary, p_info: *camel.StoreInfo) [*:0]const u8;
    pub const path = camel_store_info_path;

    /// Set a specific string on the `info`.
    extern fn camel_store_info_set_string(p_summary: *camel.StoreSummary, p_info: *camel.StoreInfo, p_type: c_int, p_value: [*:0]const u8) void;
    pub const setString = camel_store_info_set_string;

    /// Returns the last segment of the path string from `info`.
    extern fn camel_store_info_get_name(p_info: *StoreInfo) [*:0]const u8;
    pub const getName = camel_store_info_get_name;

    /// Returns the path string from `info`.
    extern fn camel_store_info_get_path(p_info: *StoreInfo) [*:0]const u8;
    pub const getPath = camel_store_info_get_path;

    /// Increase the reference count of `info`.
    extern fn camel_store_info_ref(p_info: *StoreInfo) *camel.StoreInfo;
    pub const ref = camel_store_info_ref;

    /// Set a specific string on the `info`.
    extern fn camel_store_info_set_value(p_info: *StoreInfo, p_type: c_int, p_value: [*:0]const u8) void;
    pub const setValue = camel_store_info_set_value;

    /// Unref and potentially free `info`, and all associated memory.
    extern fn camel_store_info_unref(p_info: *StoreInfo) void;
    pub const unref = camel_store_info_unref;

    extern fn camel_store_info_get_type() usize;
    pub const getGObjectType = camel_store_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StorePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreSettingsClass = extern struct {
    pub const Instance = camel.StoreSettings;

    f_parent_class: camel.SettingsClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StoreSettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreSettingsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreSummaryClass = extern struct {
    pub const Instance = camel.StoreSummary;

    f_parent_class: gobject.ObjectClass,
    f_store_info_size: usize,
    f_summary_header_load: ?*const fn (p_summary: *camel.StoreSummary, p_file: ?*anyopaque) callconv(.c) c_int,
    f_summary_header_save: ?*const fn (p_summary: *camel.StoreSummary, p_file: ?*anyopaque) callconv(.c) c_int,
    f_store_info_new: ?*const fn (p_summary: *camel.StoreSummary, p_path: [*:0]const u8) callconv(.c) *camel.StoreInfo,
    f_store_info_load: ?*const fn (p_summary: *camel.StoreSummary, p_file: ?*anyopaque) callconv(.c) *camel.StoreInfo,
    f_store_info_save: ?*const fn (p_summary: *camel.StoreSummary, p_file: ?*anyopaque, p_info: *camel.StoreInfo) callconv(.c) c_int,
    f_store_info_free: ?*const fn (p_summary: *camel.StoreSummary, p_info: *camel.StoreInfo) callconv(.c) void,
    f_store_info_set_value: ?*const fn (p_summary: *camel.StoreSummary, p_info: *camel.StoreInfo, p_type: c_int, p_value: [*:0]const u8) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StoreSummaryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreSummaryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamBufferClass = extern struct {
    pub const Instance = camel.StreamBuffer;

    f_parent_class: camel.StreamClass,
    f_init: ?*const fn (p_stream_buffer: *camel.StreamBuffer, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode) callconv(.c) void,
    f_init_vbuf: ?*const fn (p_stream_buffer: *camel.StreamBuffer, p_stream: *camel.Stream, p_mode: camel.StreamBufferMode, p_buf: [*:0]u8, p_size: u32) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamBufferClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamBufferPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamClass = extern struct {
    pub const Instance = camel.Stream;

    f_parent_class: gobject.ObjectClass,
    f_read: ?*const fn (p_stream: *camel.Stream, p_buffer: [*]u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_write: ?*const fn (p_stream: *camel.Stream, p_buffer: [*]const u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) isize,
    f_close: ?*const fn (p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_flush: ?*const fn (p_stream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_eos: ?*const fn (p_stream: *camel.Stream) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFilterClass = extern struct {
    pub const Instance = camel.StreamFilter;

    f_parent_class: camel.StreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamFilterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFilterPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFsClass = extern struct {
    pub const Instance = camel.StreamFs;

    f_parent_class: camel.StreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamFsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamFsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamMemClass = extern struct {
    pub const Instance = camel.StreamMem;

    f_parent_class: camel.StreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamMemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamMemPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamNullClass = extern struct {
    pub const Instance = camel.StreamNull;

    f_parent_class: camel.StreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamNullClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamNullPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamProcessClass = extern struct {
    pub const Instance = camel.StreamProcess;

    f_parent_class: camel.StreamClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *StreamProcessClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamProcessPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubscribableInterface = extern struct {
    pub const Instance = camel.Subscribable;

    f_parent_interface: gobject.TypeInterface,
    f_folder_is_subscribed: ?*const fn (p_subscribable: *camel.Subscribable, p_folder_name: [*:0]const u8) callconv(.c) c_int,
    f_subscribe_folder_sync: ?*const fn (p_subscribable: *camel.Subscribable, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_unsubscribe_folder_sync: ?*const fn (p_subscribable: *camel.Subscribable, p_folder_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved_methods: [20]*anyopaque,
    f_folder_subscribed: ?*const fn (p_subscribable: *camel.Subscribable, p_folder_info: *camel.FolderInfo) callconv(.c) void,
    f_folder_unsubscribed: ?*const fn (p_subscribable: *camel.Subscribable, p_folder_info: *camel.FolderInfo) callconv(.c) void,
    f_reserved_signals: [20]*anyopaque,

    pub fn as(p_instance: *SubscribableInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SummaryMessageID = extern struct {
    anon0: extern union {
        f_id: u64,
        f_hash: [8]u8,
        anon0: extern struct {
            f_hi: u32,
            f_lo: u32,
        },
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexClass = extern struct {
    pub const Instance = camel.TextIndex;

    f_parent_class: camel.IndexClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *TextIndexClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexCursorClass = extern struct {
    pub const Instance = camel.TextIndexCursor;

    f_parent_class: camel.IndexCursorClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *TextIndexCursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexCursorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexKeyCursorClass = extern struct {
    pub const Instance = camel.TextIndexKeyCursor;

    f_parent_class: camel.IndexCursorClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *TextIndexKeyCursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexKeyCursorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexNameClass = extern struct {
    pub const Instance = camel.TextIndexName;

    f_parent_class: camel.IndexNameClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *TextIndexNameClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexNamePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIndexPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TransportClass = extern struct {
    pub const Instance = camel.Transport;

    f_parent_class: camel.ServiceClass,
    f_send_to_sync: ?*const fn (p_transport: *camel.Transport, p_message: *camel.MimeMessage, p_from: *camel.Address, p_recipients: *camel.Address, p_out_sent_message_saved: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *TransportClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TransportPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A trie data structure.
pub const Trie = opaque {
    /// Creates a new `camel.Trie`. If `icase` is `TRUE`, then pattern matching
    /// done by the CamelTrie will be case insensitive.
    extern fn camel_trie_new(p_icase: c_int) *camel.Trie;
    pub const new = camel_trie_new;

    /// Add a new pattern to the `camel.Trie` `trie`.
    extern fn camel_trie_add(p_trie: *Trie, p_pattern: [*:0]const u8, p_pattern_id: c_int) void;
    pub const add = camel_trie_add;

    /// Frees the memory associated with the `camel.Trie` `trie`.
    extern fn camel_trie_free(p_trie: *Trie) void;
    pub const free = camel_trie_free;

    /// Try to match the string `buffer` with a pattern in `trie`.
    extern fn camel_trie_search(p_trie: *Trie, p_buffer: [*]const u8, p_buflen: usize, p_matched_id: *c_int) ?[*:0]const u8;
    pub const search = camel_trie_search;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UIDCache = extern struct {
    f_filename: ?[*:0]u8,
    f_uids: ?*glib.HashTable,
    f_level: c_uint,
    f_expired: usize,
    f_size: usize,
    f_fd: c_int,

    /// Frees the array of UIDs.
    extern fn camel_uid_cache_free_uids(p_uids: *glib.PtrArray) void;
    pub const freeUids = camel_uid_cache_free_uids;

    /// Creates a new UID cache, initialized from `filename`. If `filename`
    /// doesn't already exist, the UID cache will be empty. Otherwise, if
    /// it does exist but can't be read, the function will return `NULL`.
    extern fn camel_uid_cache_new(p_filename: [*:0]const u8) ?*camel.UIDCache;
    pub const new = camel_uid_cache_new;

    /// Destroys `cache` and frees its data.
    extern fn camel_uid_cache_destroy(p_cache: *UIDCache) void;
    pub const destroy = camel_uid_cache_destroy;

    /// Returns an array of UIDs from `uids` that are not in `cache`, and
    /// removes UIDs from `cache` that aren't in `uids`.
    extern fn camel_uid_cache_get_new_uids(p_cache: *UIDCache, p_uids: *glib.PtrArray) *glib.PtrArray;
    pub const getNewUids = camel_uid_cache_get_new_uids;

    /// Attempts to save `cache` back to disk.
    extern fn camel_uid_cache_save(p_cache: *UIDCache) c_int;
    pub const save = camel_uid_cache_save;

    /// Marks a uid for saving.
    extern fn camel_uid_cache_save_uid(p_cache: *UIDCache, p_uid: [*:0]const u8) void;
    pub const saveUid = camel_uid_cache_save_uid;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const URL = extern struct {
    f_protocol: ?[*:0]u8,
    f_user: ?[*:0]u8,
    f_authmech: ?[*:0]u8,
    f_host: ?[*:0]u8,
    f_port: c_int,
    f_path: ?[*:0]u8,
    f_params: ?*glib.Data,
    f_query: ?[*:0]u8,
    f_fragment: ?[*:0]u8,

    extern fn camel_url_addrspec_end(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const addrspecEnd = camel_url_addrspec_end;

    extern fn camel_url_addrspec_start(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const addrspecStart = camel_url_addrspec_start;

    /// &percnt;-decodes the passed-in URL *in place*. The decoded version is
    /// never longer than the encoded version, so there does not need to
    /// be any additional space at the end of the string.
    extern fn camel_url_decode(p_part: [*:0]u8) void;
    pub const decode = camel_url_decode;

    extern fn camel_url_decode_path(p_path: [*:0]const u8) [*:0]u8;
    pub const decodePath = camel_url_decode_path;

    /// This &percnt;-encodes the given URL part and returns the escaped version
    /// in allocated memory, which the caller must free when it is done.
    extern fn camel_url_encode(p_part: [*:0]const u8, p_escape_extra: ?[*:0]const u8) [*:0]u8;
    pub const encode = camel_url_encode;

    extern fn camel_url_file_end(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const fileEnd = camel_url_file_end;

    extern fn camel_url_file_start(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const fileStart = camel_url_file_start;

    extern fn camel_url_web_end(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const webEnd = camel_url_web_end;

    extern fn camel_url_web_start(p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) c_int;
    pub const webStart = camel_url_web_start;

    /// Parses an absolute URL.
    extern fn camel_url_new(p_url_string: [*:0]const u8, p_error: ?*?*glib.Error) ?*camel.URL;
    pub const new = camel_url_new;

    /// Copy a `camel.URL`.
    extern fn camel_url_copy(p_in: *URL) *camel.URL;
    pub const copy = camel_url_copy;

    extern fn camel_url_equal(p_u: *const URL, p_u2: *const camel.URL) c_int;
    pub const equal = camel_url_equal;

    /// Frees `url`.
    extern fn camel_url_free(p_url: *URL) void;
    pub const free = camel_url_free;

    /// Get the value of the specified param on the URL.
    extern fn camel_url_get_param(p_url: *URL, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getParam = camel_url_get_param;

    extern fn camel_url_hash(p_u: *const URL) c_uint;
    pub const hash = camel_url_hash;

    /// Parses `url_string` relative to `base`.
    extern fn camel_url_new_with_base(p_base: *URL, p_url_string: [*:0]const u8) *camel.URL;
    pub const newWithBase = camel_url_new_with_base;

    /// Set the authmech of a `camel.URL`.
    extern fn camel_url_set_authmech(p_url: *URL, p_authmech: [*:0]const u8) void;
    pub const setAuthmech = camel_url_set_authmech;

    /// Set the fragment of a `camel.URL`.
    extern fn camel_url_set_fragment(p_url: *URL, p_fragment: [*:0]const u8) void;
    pub const setFragment = camel_url_set_fragment;

    /// Set the hostname of a `camel.URL`.
    extern fn camel_url_set_host(p_url: *URL, p_host: [*:0]const u8) void;
    pub const setHost = camel_url_set_host;

    /// Set a param on the `camel.URL`.
    extern fn camel_url_set_param(p_url: *URL, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setParam = camel_url_set_param;

    /// Set the path component of a `camel.URL`.
    extern fn camel_url_set_path(p_url: *URL, p_path: [*:0]const u8) void;
    pub const setPath = camel_url_set_path;

    /// Set the port on a `camel.URL`.
    extern fn camel_url_set_port(p_url: *URL, p_port: c_int) void;
    pub const setPort = camel_url_set_port;

    /// Set the protocol of a `camel.URL`.
    extern fn camel_url_set_protocol(p_url: *URL, p_protocol: [*:0]const u8) void;
    pub const setProtocol = camel_url_set_protocol;

    /// Set the query of a `camel.URL`.
    extern fn camel_url_set_query(p_url: *URL, p_query: [*:0]const u8) void;
    pub const setQuery = camel_url_set_query;

    /// Set the user of a `camel.URL`.
    extern fn camel_url_set_user(p_url: *URL, p_user: [*:0]const u8) void;
    pub const setUser = camel_url_set_user;

    /// Flatten a `camel.URL` into a string.
    extern fn camel_url_to_string(p_url: *URL, p_flags: camel.URLFlags) [*:0]u8;
    pub const toString = camel_url_to_string;

    extern fn camel_url_get_type() usize;
    pub const getGObjectType = camel_url_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UrlMatch = extern struct {
    f_pattern: ?[*:0]const u8,
    f_prefix: ?[*:0]const u8,
    f_um_so: i64,
    f_um_eo: i64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UrlPattern = extern struct {
    f_pattern: ?[*:0]const u8,
    f_prefix: ?[*:0]const u8,
    f_start: ?camel.UrlScanFunc,
    f_end: ?camel.UrlScanFunc,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UrlScanner = opaque {
    extern fn camel_url_scanner_new() *camel.UrlScanner;
    pub const new = camel_url_scanner_new;

    /// Adds a new `pattern` into the scanner
    extern fn camel_url_scanner_add(p_scanner: *UrlScanner, p_pattern: *camel.UrlPattern) void;
    pub const add = camel_url_scanner_add;

    /// Frees the `scanner`.
    extern fn camel_url_scanner_free(p_scanner: *UrlScanner) void;
    pub const free = camel_url_scanner_free;

    /// Scan the `in` string with the `match` criterias.
    extern fn camel_url_scanner_scan(p_scanner: *UrlScanner, p_in: [*]const u8, p_inlen: usize, p_match: *camel.UrlMatch) c_int;
    pub const scan = camel_url_scanner_scan;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VTrashFolderClass = extern struct {
    pub const Instance = camel.VTrashFolder;

    f_parent_class: camel.VeeFolderClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VTrashFolderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VTrashFolderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeDataCacheClass = extern struct {
    pub const Instance = camel.VeeDataCache;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeDataCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeDataCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeFolderClass = extern struct {
    pub const Instance = camel.VeeFolder;

    f_parent_class: camel.FolderClass,
    f_add_folder: ?*const fn (p_vfolder: *camel.VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    f_remove_folder: ?*const fn (p_vfolder: *camel.VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    f_rebuild_folder: ?*const fn (p_vfolder: *camel.VeeFolder, p_subfolder: *camel.Folder, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    f_set_expression: ?*const fn (p_vfolder: *camel.VeeFolder, p_expression: [*:0]const u8) callconv(.c) void,
    f_folder_changed: ?*const fn (p_vfolder: *camel.VeeFolder, p_subfolder: *camel.Folder, p_changes: *camel.FolderChangeInfo) callconv(.c) void,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeFolderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeFolderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeMessageInfoClass = extern struct {
    pub const Instance = camel.VeeMessageInfo;

    f_parent_class: camel.MessageInfoClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeMessageInfoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeMessageInfoDataClass = extern struct {
    pub const Instance = camel.VeeMessageInfoData;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeMessageInfoDataClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeMessageInfoDataPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeMessageInfoPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeStoreClass = extern struct {
    pub const Instance = camel.VeeStore;

    f_parent_class: camel.StoreClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeStorePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeSubfolderDataClass = extern struct {
    pub const Instance = camel.VeeSubfolderData;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeSubfolderDataClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeSubfolderDataPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeSummaryClass = extern struct {
    pub const Instance = camel.VeeSummary;

    f_parent_class: camel.FolderSummaryClass,
    f_reserved: [20]*anyopaque,

    pub fn as(p_instance: *VeeSummaryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VeeSummaryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WeakRefGroup = opaque {
    extern fn camel_weak_ref_group_new() *camel.WeakRefGroup;
    pub const new = camel_weak_ref_group_new;

    extern fn camel_weak_ref_group_get(p_group: *WeakRefGroup) ?*anyopaque;
    pub const get = camel_weak_ref_group_get;

    /// Increases a reference count of the `group`.
    extern fn camel_weak_ref_group_ref(p_group: *WeakRefGroup) *camel.WeakRefGroup;
    pub const ref = camel_weak_ref_group_ref;

    /// Sets the `object` as the object help by this `group`. If
    /// the `object` is `NULL`, then unsets any previously set.
    extern fn camel_weak_ref_group_set(p_group: *WeakRefGroup, p_object: ?*anyopaque) void;
    pub const set = camel_weak_ref_group_set;

    /// Decreases a reference count of the `group`. The `group` is
    /// freed when the reference count reaches zero.
    extern fn camel_weak_ref_group_unref(p_group: *WeakRefGroup) void;
    pub const unref = camel_weak_ref_group_unref;

    extern fn camel_weak_ref_group_get_type() usize;
    pub const getGObjectType = camel_weak_ref_group_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _KeyKey = extern struct {
    f_data: camel._block_t,
    bitfields0: packed struct(c_uint) {
        f_offset: u10,
        f_flags: u22,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _LockHelperMsg = extern struct {
    f_magic: u32,
    f_seq: u32,
    f_id: u32,
    f_data: u32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const __search_word = extern struct {
    f_type: camel._search_word_t,
    f_word: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const __search_words = extern struct {
    f_len: c_int,
    f_type: camel._search_word_t,
    f_words: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _encrypt = extern struct {
    f_status: camel.CipherValidityEncrypt,
    f_description: ?[*:0]u8,
    f_encrypters: glib.Queue,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _sign = extern struct {
    f_status: camel.CipherValiditySign,
    f_description: ?[*:0]u8,
    f_signers: glib.Queue,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Authentication result codes used by `camel.Service`.
pub const AuthenticationResult = enum(c_int) {
    @"error" = 0,
    accepted = 1,
    rejected = 2,
    _,

    extern fn camel_authentication_result_get_type() usize;
    pub const getGObjectType = camel_authentication_result_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertTrust = enum(c_int) {
    unknown = 0,
    never = 1,
    marginal = 2,
    fully = 3,
    ultimate = 4,
    temporary = 5,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherContextError = enum(c_int) {
    cipher_context_error_key_not_found = 0,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherHash = enum(c_int) {
    default = 0,
    md2 = 1,
    md5 = 2,
    sha1 = 3,
    sha256 = 4,
    sha384 = 5,
    sha512 = 6,
    ripemd160 = 7,
    tiger192 = 8,
    haval5160 = 9,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherValidityEncrypt = enum(c_int) {
    none = 0,
    weak = 1,
    encrypted = 2,
    strong = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherValidityMode = enum(c_int) {
    sign = 0,
    encrypt = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CipherValiditySign = enum(c_int) {
    none = 0,
    good = 1,
    bad = 2,
    unknown = 3,
    need_public_key = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Declares the compare type to use.
pub const CompareType = enum(c_int) {
    insensitive = 0,
    sensitive = 1,
    _,

    extern fn camel_compare_type_get_type() usize;
    pub const getGObjectType = camel_compare_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DBError = enum(c_int) {
    db_error_corrupt = 0,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enum of all the known columns, which can be used for a quick column lookups.
pub const DBKnownColumnNames = enum(c_int) {
    unknown = -1,
    attachment = 0,
    bdata = 1,
    cinfo = 2,
    deleted = 3,
    deleted_count = 4,
    dreceived = 5,
    dsent = 6,
    flags = 7,
    folder_name = 8,
    followup_completed_on = 9,
    followup_due_by = 10,
    followup_flag = 11,
    important = 12,
    jnd_count = 13,
    junk = 14,
    junk_count = 15,
    labels = 16,
    mail_cc = 17,
    mail_from = 18,
    mail_to = 19,
    mlist = 20,
    nextuid = 21,
    part = 22,
    preview = 23,
    read = 24,
    replied = 25,
    saved_count = 26,
    size = 27,
    subject = 28,
    time = 29,
    uid = 30,
    unread_count = 31,
    userheaders = 32,
    usertags = 33,
    version = 34,
    visible_count = 35,
    vuid = 36,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Error = enum(c_int) {
    error_generic = 0,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes what headers to fetch when downloading message summaries.
pub const FetchHeadersType = enum(c_int) {
    basic = 0,
    basic_and_mailing_list = 1,
    all = 2,
    _,

    extern fn camel_fetch_headers_type_get_type() usize;
    pub const getGObjectType = camel_fetch_headers_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FetchType = enum(c_int) {
    old_messages = 0,
    new_messages = 1,
    _,

    extern fn camel_fetch_type_get_type() usize;
    pub const getGObjectType = camel_fetch_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderError = enum(c_int) {
    invalid = 0,
    invalid_state = 1,
    non_empty = 2,
    non_uid = 3,
    insufficient_permission = 4,
    invalid_path = 5,
    invalid_uid = 6,
    summary_invalid = 7,
    _,

    extern fn camel_folder_error_quark() glib.Quark;
    pub const quark = camel_folder_error_quark;

    extern fn camel_folder_error_get_type() usize;
    pub const getGObjectType = camel_folder_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// GPG key trust levels.
pub const GpgTrust = enum(c_int) {
    none = 0,
    unknown = 1,
    never = 2,
    marginal = 3,
    full = 4,
    ultimate = 5,
    _,

    extern fn camel_gpg_trust_get_type() usize;
    pub const getGObjectType = camel_gpg_trust_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HTMLParserState = enum(c_int) {
    data = 0,
    ent = 1,
    element = 2,
    tag = 3,
    dtdent = 4,
    comment0 = 5,
    comment = 6,
    attr0 = 7,
    attr = 8,
    val0 = 9,
    val = 10,
    val_ent = 11,
    eod = 12,
    eof = 13,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HeaderAddressType = enum(c_int) {
    none = 0,
    name = 1,
    group = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These are result codes used when passing messages through a junk filter.
pub const JunkStatus = enum(c_int) {
    @"error" = 0,
    inconclusive = 1,
    message_is_junk = 2,
    message_is_not_junk = 3,
    _,

    extern fn camel_junk_status_get_type() usize;
    pub const getGObjectType = camel_junk_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LockType = enum(c_int) {
    read = 0,
    write = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemPoolFlags = enum(c_int) {
    @"struct" = 0,
    word = 1,
    byte = 2,
    mask = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterBasicType = enum(c_int) {
    invalid = 0,
    base64_enc = 1,
    base64_dec = 2,
    qp_enc = 3,
    qp_dec = 4,
    uu_enc = 5,
    uu_dec = 6,
    _,

    extern fn camel_mime_filter_basic_type_get_type() usize;
    pub const getGObjectType = camel_mime_filter_basic_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCRLFDirection = enum(c_int) {
    encode = 0,
    decode = 1,
    _,

    extern fn camel_mime_filter_crlf_direction_get_type() usize;
    pub const getGObjectType = camel_mime_filter_crlf_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCRLFMode = enum(c_int) {
    dots = 0,
    only = 1,
    _,

    extern fn camel_mime_filter_crlf_mode_get_type() usize;
    pub const getGObjectType = camel_mime_filter_crlf_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterGZipMode = enum(c_int) {
    zip = 0,
    unzip = 1,
    _,

    extern fn camel_mime_filter_gzip_mode_get_type() usize;
    pub const getGObjectType = camel_mime_filter_gzip_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterYencDirection = enum(c_int) {
    encode = 0,
    decode = 1,
    _,

    extern fn camel_mime_filter_yenc_direction_get_type() usize;
    pub const getGObjectType = camel_mime_filter_yenc_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeParserState = enum(c_int) {
    initial = 0,
    pre_from = 1,
    from = 2,
    header = 3,
    body = 4,
    multipart = 5,
    message = 6,
    part = 7,
    end = 8,
    pre_from_end = 9,
    from_end = 10,
    header_end = 11,
    body_end = 12,
    multipart_end = 13,
    message_end = 14,
    _,

    pub const eof = MimeParserState.end;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Methods for establishing an encrypted (or unencrypted) network connection.
pub const NetworkSecurityMethod = enum(c_int) {
    none = 0,
    ssl_on_alternate_port = 1,
    starttls_on_standard_port = 2,
    _,

    extern fn camel_network_security_method_get_type() usize;
    pub const getGObjectType = camel_network_security_method_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderConfType = enum(c_int) {
    end = 0,
    section_start = 1,
    section_end = 2,
    checkbox = 3,
    checkspin = 4,
    entry = 5,
    label = 6,
    hidden = 7,
    options = 8,
    placeholder = 9,
    advanced_section_start = 10,
    _,

    extern fn camel_provider_conf_type_get_type() usize;
    pub const getGObjectType = camel_provider_conf_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderType = enum(c_int) {
    store = 0,
    transport = 1,
    _,

    extern fn camel_provider_type_get_type() usize;
    pub const getGObjectType = camel_provider_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines type of a `camel.SExpResult`.
pub const SExpResultType = enum(c_int) {
    array_ptr = 0,
    int = 1,
    string = 2,
    bool = 3,
    time = 4,
    undefined = 5,
    _,

    extern fn camel_sexp_result_type_get_type() usize;
    pub const getGObjectType = camel_sexp_result_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines type of a `camel.SExpTerm` and partly also `camel.SExpSymbol`
pub const SExpTermType = enum(c_int) {
    int = 0,
    bool = 1,
    string = 2,
    time = 3,
    func = 4,
    ifunc = 5,
    @"var" = 6,
    _,

    extern fn camel_sexp_term_type_get_type() usize;
    pub const getGObjectType = camel_sexp_term_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SMIMESign = enum(c_int) {
    clearsign = 0,
    enveloped = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaslAnonTraceType = enum(c_int) {
    email = 0,
    @"opaque" = 1,
    empty = 2,
    _,

    extern fn camel_sasl_anon_trace_type_get_type() usize;
    pub const getGObjectType = camel_sasl_anon_trace_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Connection status returned by `camel.Service.getConnectionStatus`.
pub const ServiceConnectionStatus = enum(c_int) {
    disconnected = 0,
    connecting = 1,
    connected = 2,
    disconnecting = 3,
    _,

    extern fn camel_service_connection_status_get_type() usize;
    pub const getGObjectType = camel_service_connection_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServiceError = enum(c_int) {
    invalid = 0,
    url_invalid = 1,
    unavailable = 2,
    cant_authenticate = 3,
    not_connected = 4,
    _,

    extern fn camel_service_error_quark() glib.Quark;
    pub const quark = camel_service_error_quark;

    extern fn camel_service_error_get_type() usize;
    pub const getGObjectType = camel_service_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionAlertType = enum(c_int) {
    info = 0,
    warning = 1,
    @"error" = 2,
    _,

    extern fn camel_session_alert_type_get_type() usize;
    pub const getGObjectType = camel_session_alert_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Determines the direction of a sort.
pub const SortType = enum(c_int) {
    ascending = 0,
    descending = 1,
    _,

    extern fn camel_sort_type_get_type() usize;
    pub const getGObjectType = camel_sort_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreError = enum(c_int) {
    invalid = 0,
    no_folder = 1,
    _,

    extern fn camel_store_error_quark() glib.Quark;
    pub const quark = camel_store_error_quark;

    extern fn camel_store_error_get_type() usize;
    pub const getGObjectType = camel_store_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamBufferMode = enum(c_int) {
    buffer = 0,
    none = 1,
    write = 128,
    _,

    pub const read = StreamBufferMode.buffer;
    pub const mode = StreamBufferMode.write;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a three-state value, which can be either Off, On or Inconsistent.
pub const ThreeState = enum(c_int) {
    off = 0,
    on = 1,
    inconsistent = 2,
    _,

    extern fn camel_three_state_get_type() usize;
    pub const getGObjectType = camel_three_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Declares time unit, which serves to interpret the time value,
/// like in `camel.OfflineSettings`.
pub const TimeUnit = enum(c_int) {
    days = 1,
    weeks = 2,
    months = 3,
    years = 4,
    _,

    extern fn camel_time_unit_get_type() usize;
    pub const getGObjectType = camel_time_unit_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TransferEncoding = enum(c_int) {
    encoding_default = 0,
    encoding_7bit = 1,
    encoding_8bit = 2,
    encoding_base64 = 3,
    encoding_quotedprintable = 4,
    encoding_binary = 5,
    encoding_uuencode = 6,
    num_encodings = 7,
    _,

    extern fn camel_transfer_encoding_from_string(p_string: [*:0]const u8) camel.TransferEncoding;
    pub const fromString = camel_transfer_encoding_from_string;

    extern fn camel_transfer_encoding_to_string(p_encoding: camel.TransferEncoding) [*:0]const u8;
    pub const toString = camel_transfer_encoding_to_string;

    extern fn camel_transfer_encoding_get_type() usize;
    pub const getGObjectType = camel_transfer_encoding_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VTrashFolderType = enum(c_int) {
    trash = 0,
    junk = 1,
    last = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _search_match_t = enum(c_int) {
    exact = 0,
    contains = 1,
    word = 2,
    starts = 3,
    ends = 4,
    soundex = 5,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _search_t = enum(c_int) {
    asis = 0,
    encoded = 1,
    address = 2,
    address_encoded = 3,
    mlist = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _search_word_t = enum(c_int) {
    simple = 1,
    complex = 2,
    @"8bit" = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BestencEncoding = packed struct(c_uint) {
    @"8bit": bool = false,
    binary: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    text: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_7bit: BestencEncoding = @bitCast(@as(c_uint, 0));
    pub const flags_8bit: BestencEncoding = @bitCast(@as(c_uint, 1));
    pub const flags_binary: BestencEncoding = @bitCast(@as(c_uint, 2));
    pub const flags_text: BestencEncoding = @bitCast(@as(c_uint, 256));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BestencRequired = packed struct(c_uint) {
    get_encoding: bool = false,
    get_charset: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    lf_is_crlf: bool = false,
    no_from: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_get_encoding: BestencRequired = @bitCast(@as(c_uint, 1));
    pub const flags_get_charset: BestencRequired = @bitCast(@as(c_uint, 2));
    pub const flags_lf_is_crlf: BestencRequired = @bitCast(@as(c_uint, 256));
    pub const flags_no_from: BestencRequired = @bitCast(@as(c_uint, 512));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockFileFlags = packed struct(c_uint) {
    block_file_sync: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_block_file_sync: BlockFileFlags = @bitCast(@as(c_uint, 1));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlockFlags = packed struct(c_uint) {
    dirty: bool = false,
    detached: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_dirty: BlockFlags = @bitCast(@as(c_uint, 1));
    pub const flags_detached: BlockFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderFlags = packed struct(c_uint) {
    has_summary_capability: bool = false,
    _padding1: bool = false,
    filter_recent: bool = false,
    has_been_deleted: bool = false,
    is_trash: bool = false,
    is_junk: bool = false,
    filter_junk: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_has_summary_capability: FolderFlags = @bitCast(@as(c_uint, 1));
    pub const flags_filter_recent: FolderFlags = @bitCast(@as(c_uint, 4));
    pub const flags_has_been_deleted: FolderFlags = @bitCast(@as(c_uint, 8));
    pub const flags_is_trash: FolderFlags = @bitCast(@as(c_uint, 16));
    pub const flags_is_junk: FolderFlags = @bitCast(@as(c_uint, 32));
    pub const flags_filter_junk: FolderFlags = @bitCast(@as(c_uint, 64));
    extern fn camel_folder_flags_get_type() usize;
    pub const getGObjectType = camel_folder_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These flags are abstractions.  It's up to the CamelProvider to give
/// them suitable interpretations.  Use `CAMEL_FOLDER_TYPE_MASK` to isolate
/// the folder's type.
pub const FolderInfoFlags = packed struct(c_uint) {
    noselect: bool = false,
    noinferiors: bool = false,
    children: bool = false,
    nochildren: bool = false,
    subscribed: bool = false,
    virtual: bool = false,
    system: bool = false,
    vtrash: bool = false,
    shared_to_me: bool = false,
    shared_by_me: bool = false,
    type_inbox: bool = false,
    type_outbox: bool = false,
    type_junk: bool = false,
    type_memos: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    readonly: bool = false,
    writeonly: bool = false,
    flagged: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    flags_last: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_noselect: FolderInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_noinferiors: FolderInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_children: FolderInfoFlags = @bitCast(@as(c_uint, 4));
    pub const flags_nochildren: FolderInfoFlags = @bitCast(@as(c_uint, 8));
    pub const flags_subscribed: FolderInfoFlags = @bitCast(@as(c_uint, 16));
    pub const flags_virtual: FolderInfoFlags = @bitCast(@as(c_uint, 32));
    pub const flags_system: FolderInfoFlags = @bitCast(@as(c_uint, 64));
    pub const flags_vtrash: FolderInfoFlags = @bitCast(@as(c_uint, 128));
    pub const flags_shared_to_me: FolderInfoFlags = @bitCast(@as(c_uint, 256));
    pub const flags_shared_by_me: FolderInfoFlags = @bitCast(@as(c_uint, 512));
    pub const flags_type_normal: FolderInfoFlags = @bitCast(@as(c_uint, 0));
    pub const flags_type_inbox: FolderInfoFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_type_outbox: FolderInfoFlags = @bitCast(@as(c_uint, 2048));
    pub const flags_type_trash: FolderInfoFlags = @bitCast(@as(c_uint, 3072));
    pub const flags_type_junk: FolderInfoFlags = @bitCast(@as(c_uint, 4096));
    pub const flags_type_sent: FolderInfoFlags = @bitCast(@as(c_uint, 5120));
    pub const flags_type_contacts: FolderInfoFlags = @bitCast(@as(c_uint, 6144));
    pub const flags_type_events: FolderInfoFlags = @bitCast(@as(c_uint, 7168));
    pub const flags_type_memos: FolderInfoFlags = @bitCast(@as(c_uint, 8192));
    pub const flags_type_tasks: FolderInfoFlags = @bitCast(@as(c_uint, 9216));
    pub const flags_type_all: FolderInfoFlags = @bitCast(@as(c_uint, 10240));
    pub const flags_type_archive: FolderInfoFlags = @bitCast(@as(c_uint, 11264));
    pub const flags_type_drafts: FolderInfoFlags = @bitCast(@as(c_uint, 12288));
    pub const flags_readonly: FolderInfoFlags = @bitCast(@as(c_uint, 65536));
    pub const flags_writeonly: FolderInfoFlags = @bitCast(@as(c_uint, 131072));
    pub const flags_flagged: FolderInfoFlags = @bitCast(@as(c_uint, 262144));
    pub const flags_flags_last: FolderInfoFlags = @bitCast(@as(c_uint, 16777216));
    extern fn camel_folder_info_flags_get_type() usize;
    pub const getGObjectType = camel_folder_info_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FolderSummaryFlags = packed struct(c_uint) {
    dirty: bool = false,
    in_memory_only: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_dirty: FolderSummaryFlags = @bitCast(@as(c_uint, 1));
    pub const flags_in_memory_only: FolderSummaryFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageFlags = packed struct(c_uint) {
    answered: bool = false,
    deleted: bool = false,
    draft: bool = false,
    flagged: bool = false,
    seen: bool = false,
    attachments: bool = false,
    answered_all: bool = false,
    junk: bool = false,
    secure: bool = false,
    notjunk: bool = false,
    forwarded: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    folder_flagged: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    junk_learn: bool = false,
    user: bool = false,

    pub const flags_answered: MessageFlags = @bitCast(@as(c_uint, 1));
    pub const flags_deleted: MessageFlags = @bitCast(@as(c_uint, 2));
    pub const flags_draft: MessageFlags = @bitCast(@as(c_uint, 4));
    pub const flags_flagged: MessageFlags = @bitCast(@as(c_uint, 8));
    pub const flags_seen: MessageFlags = @bitCast(@as(c_uint, 16));
    pub const flags_attachments: MessageFlags = @bitCast(@as(c_uint, 32));
    pub const flags_answered_all: MessageFlags = @bitCast(@as(c_uint, 64));
    pub const flags_junk: MessageFlags = @bitCast(@as(c_uint, 128));
    pub const flags_secure: MessageFlags = @bitCast(@as(c_uint, 256));
    pub const flags_notjunk: MessageFlags = @bitCast(@as(c_uint, 512));
    pub const flags_forwarded: MessageFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_folder_flagged: MessageFlags = @bitCast(@as(c_uint, 65536));
    pub const flags_junk_learn: MessageFlags = @bitCast(@as(c_uint, 1073741824));
    pub const flags_user: MessageFlags = @bitCast(@as(c_uint, 2147483648));
    extern fn camel_message_flags_get_type() usize;
    pub const getGObjectType = camel_message_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterCanonFlags = packed struct(c_uint) {
    crlf: bool = false,
    from: bool = false,
    strip: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_crlf: MimeFilterCanonFlags = @bitCast(@as(c_uint, 1));
    pub const flags_from: MimeFilterCanonFlags = @bitCast(@as(c_uint, 2));
    pub const flags_strip: MimeFilterCanonFlags = @bitCast(@as(c_uint, 4));
    extern fn camel_mime_filter_canon_flags_get_type() usize;
    pub const getGObjectType = camel_mime_filter_canon_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MimeFilterEnrichedFlags = packed struct(c_uint) {
    is_richtext: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_none: MimeFilterEnrichedFlags = @bitCast(@as(c_uint, 0));
    pub const flags_is_richtext: MimeFilterEnrichedFlags = @bitCast(@as(c_uint, 1));
    extern fn camel_mime_filter_enriched_flags_get_type() usize;
    pub const getGObjectType = camel_mime_filter_enriched_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for converting text/plain content into text/html.
pub const MimeFilterToHTMLFlags = packed struct(c_uint) {
    pre: bool = false,
    convert_nl: bool = false,
    convert_spaces: bool = false,
    convert_urls: bool = false,
    mark_citation: bool = false,
    convert_addresses: bool = false,
    escape_8bit: bool = false,
    cite: bool = false,
    preserve_8bit: bool = false,
    format_flowed: bool = false,
    quote_citation: bool = false,
    div: bool = false,
    preserve_tabs: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_pre: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 1));
    pub const flags_convert_nl: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 2));
    pub const flags_convert_spaces: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 4));
    pub const flags_convert_urls: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 8));
    pub const flags_mark_citation: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 16));
    pub const flags_convert_addresses: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 32));
    pub const flags_escape_8bit: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 64));
    pub const flags_cite: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 128));
    pub const flags_preserve_8bit: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 256));
    pub const flags_format_flowed: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 512));
    pub const flags_quote_citation: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_div: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 2048));
    pub const flags_preserve_tabs: MimeFilterToHTMLFlags = @bitCast(@as(c_uint, 4096));
    extern fn camel_mime_filter_to_html_flags_get_type() usize;
    pub const getGObjectType = camel_mime_filter_to_html_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These flags extend `gobject.ParamFlags`.  Most of the time you will use them
/// in conjunction with `gobject.ObjectClass.installProperty`.
pub const ParamFlags = packed struct(c_uint) {
    _padding0: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    param_persistent: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_param_persistent: ParamFlags = @bitCast(@as(c_uint, 256));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderFlags = packed struct(c_uint) {
    is_remote: bool = false,
    is_local: bool = false,
    is_external: bool = false,
    is_source: bool = false,
    is_storage: bool = false,
    supports_ssl: bool = false,
    has_license: bool = false,
    disable_sent_folder: bool = false,
    allow_real_trash_folder: bool = false,
    allow_real_junk_folder: bool = false,
    supports_mobile_devices: bool = false,
    supports_batch_fetch: bool = false,
    supports_purge_message_cache: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_is_remote: ProviderFlags = @bitCast(@as(c_uint, 1));
    pub const flags_is_local: ProviderFlags = @bitCast(@as(c_uint, 2));
    pub const flags_is_external: ProviderFlags = @bitCast(@as(c_uint, 4));
    pub const flags_is_source: ProviderFlags = @bitCast(@as(c_uint, 8));
    pub const flags_is_storage: ProviderFlags = @bitCast(@as(c_uint, 16));
    pub const flags_supports_ssl: ProviderFlags = @bitCast(@as(c_uint, 32));
    pub const flags_has_license: ProviderFlags = @bitCast(@as(c_uint, 64));
    pub const flags_disable_sent_folder: ProviderFlags = @bitCast(@as(c_uint, 128));
    pub const flags_allow_real_trash_folder: ProviderFlags = @bitCast(@as(c_uint, 256));
    pub const flags_allow_real_junk_folder: ProviderFlags = @bitCast(@as(c_uint, 512));
    pub const flags_supports_mobile_devices: ProviderFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_supports_batch_fetch: ProviderFlags = @bitCast(@as(c_uint, 2048));
    pub const flags_supports_purge_message_cache: ProviderFlags = @bitCast(@as(c_uint, 4096));
    extern fn camel_provider_flags_get_type() usize;
    pub const getGObjectType = camel_provider_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProviderURLFlags = packed struct(c_uint) {
    allow_user: bool = false,
    allow_auth: bool = false,
    allow_password: bool = false,
    allow_host: bool = false,
    allow_port: bool = false,
    allow_path: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    need_user: bool = false,
    need_auth: bool = false,
    need_password: bool = false,
    need_host: bool = false,
    need_port: bool = false,
    need_path: bool = false,
    need_path_dir: bool = false,
    _padding15: bool = false,
    hidden_user: bool = false,
    hidden_auth: bool = false,
    hidden_password: bool = false,
    hidden_host: bool = false,
    hidden_port: bool = false,
    hidden_path: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    fragment_is_path: bool = false,
    path_is_absolute: bool = false,

    pub const flags_allow_user: ProviderURLFlags = @bitCast(@as(c_uint, 1));
    pub const flags_allow_auth: ProviderURLFlags = @bitCast(@as(c_uint, 2));
    pub const flags_allow_password: ProviderURLFlags = @bitCast(@as(c_uint, 4));
    pub const flags_allow_host: ProviderURLFlags = @bitCast(@as(c_uint, 8));
    pub const flags_allow_port: ProviderURLFlags = @bitCast(@as(c_uint, 16));
    pub const flags_allow_path: ProviderURLFlags = @bitCast(@as(c_uint, 32));
    pub const flags_need_user: ProviderURLFlags = @bitCast(@as(c_uint, 256));
    pub const flags_need_auth: ProviderURLFlags = @bitCast(@as(c_uint, 512));
    pub const flags_need_password: ProviderURLFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_need_host: ProviderURLFlags = @bitCast(@as(c_uint, 2048));
    pub const flags_need_port: ProviderURLFlags = @bitCast(@as(c_uint, 4096));
    pub const flags_need_path: ProviderURLFlags = @bitCast(@as(c_uint, 8192));
    pub const flags_need_path_dir: ProviderURLFlags = @bitCast(@as(c_uint, 16384));
    pub const flags_hidden_user: ProviderURLFlags = @bitCast(@as(c_uint, 65536));
    pub const flags_hidden_auth: ProviderURLFlags = @bitCast(@as(c_uint, 131072));
    pub const flags_hidden_password: ProviderURLFlags = @bitCast(@as(c_uint, 262144));
    pub const flags_hidden_host: ProviderURLFlags = @bitCast(@as(c_uint, 524288));
    pub const flags_hidden_port: ProviderURLFlags = @bitCast(@as(c_uint, 1048576));
    pub const flags_hidden_path: ProviderURLFlags = @bitCast(@as(c_uint, 2097152));
    pub const flags_fragment_is_path: ProviderURLFlags = @bitCast(@as(c_uint, 1073741824));
    pub const flags_path_is_absolute: ProviderURLFlags = @bitCast(@as(c_uint, 2147483648));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags used to `camel.Session.getRecipientCertificatesSync` call.
pub const RecipientCertificateFlags = packed struct(c_uint) {
    smime: bool = false,
    pgp: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_smime: RecipientCertificateFlags = @bitCast(@as(c_uint, 1));
    pub const flags_pgp: RecipientCertificateFlags = @bitCast(@as(c_uint, 2));
    extern fn camel_recipient_certificate_flags_get_type() usize;
    pub const getGObjectType = camel_recipient_certificate_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SMIMEDescribe = packed struct(c_uint) {
    signed: bool = false,
    encrypted: bool = false,
    certs: bool = false,
    crls: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_signed: SMIMEDescribe = @bitCast(@as(c_uint, 1));
    pub const flags_encrypted: SMIMEDescribe = @bitCast(@as(c_uint, 2));
    pub const flags_certs: SMIMEDescribe = @bitCast(@as(c_uint, 4));
    pub const flags_crls: SMIMEDescribe = @bitCast(@as(c_uint, 8));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreFlags = packed struct(c_uint) {
    vtrash: bool = false,
    vjunk: bool = false,
    proxy: bool = false,
    is_migrating: bool = false,
    real_junk_folder: bool = false,
    can_edit_folders: bool = false,
    use_cache_dir: bool = false,
    can_delete_folders_at_once: bool = false,
    supports_initial_setup: bool = false,
    is_builtin: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_vtrash: StoreFlags = @bitCast(@as(c_uint, 1));
    pub const flags_vjunk: StoreFlags = @bitCast(@as(c_uint, 2));
    pub const flags_proxy: StoreFlags = @bitCast(@as(c_uint, 4));
    pub const flags_is_migrating: StoreFlags = @bitCast(@as(c_uint, 8));
    pub const flags_real_junk_folder: StoreFlags = @bitCast(@as(c_uint, 16));
    pub const flags_can_edit_folders: StoreFlags = @bitCast(@as(c_uint, 32));
    pub const flags_use_cache_dir: StoreFlags = @bitCast(@as(c_uint, 64));
    pub const flags_can_delete_folders_at_once: StoreFlags = @bitCast(@as(c_uint, 128));
    pub const flags_supports_initial_setup: StoreFlags = @bitCast(@as(c_uint, 256));
    pub const flags_is_builtin: StoreFlags = @bitCast(@as(c_uint, 512));
    extern fn camel_store_flags_get_type() usize;
    pub const getGObjectType = camel_store_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Open mode for folder.
pub const StoreGetFolderFlags = packed struct(c_uint) {
    create: bool = false,
    excl: bool = false,
    body_index: bool = false,
    private: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_none: StoreGetFolderFlags = @bitCast(@as(c_uint, 0));
    pub const flags_create: StoreGetFolderFlags = @bitCast(@as(c_uint, 1));
    pub const flags_excl: StoreGetFolderFlags = @bitCast(@as(c_uint, 2));
    pub const flags_body_index: StoreGetFolderFlags = @bitCast(@as(c_uint, 4));
    pub const flags_private: StoreGetFolderFlags = @bitCast(@as(c_uint, 8));
    extern fn camel_store_get_folder_flags_get_type() usize;
    pub const getGObjectType = camel_store_get_folder_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreGetFolderInfoFlags = packed struct(c_uint) {
    fast: bool = false,
    recursive: bool = false,
    subscribed: bool = false,
    no_virtual: bool = false,
    subscription_list: bool = false,
    refresh: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_fast: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_recursive: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_subscribed: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 4));
    pub const flags_no_virtual: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 8));
    pub const flags_subscription_list: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 16));
    pub const flags_refresh: StoreGetFolderInfoFlags = @bitCast(@as(c_uint, 32));
    extern fn camel_store_get_folder_info_flags_get_type() usize;
    pub const getGObjectType = camel_store_get_folder_info_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StoreInfoFlags = packed struct(c_uint) {
    noselect: bool = false,
    noinferiors: bool = false,
    children: bool = false,
    nochildren: bool = false,
    subscribed: bool = false,
    virtual: bool = false,
    system: bool = false,
    vtrash: bool = false,
    shared_to_me: bool = false,
    shared_by_me: bool = false,
    type_inbox: bool = false,
    type_outbox: bool = false,
    type_junk: bool = false,
    type_memos: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    readonly: bool = false,
    writeonly: bool = false,
    flagged: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_noselect: StoreInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_noinferiors: StoreInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_children: StoreInfoFlags = @bitCast(@as(c_uint, 4));
    pub const flags_nochildren: StoreInfoFlags = @bitCast(@as(c_uint, 8));
    pub const flags_subscribed: StoreInfoFlags = @bitCast(@as(c_uint, 16));
    pub const flags_virtual: StoreInfoFlags = @bitCast(@as(c_uint, 32));
    pub const flags_system: StoreInfoFlags = @bitCast(@as(c_uint, 64));
    pub const flags_vtrash: StoreInfoFlags = @bitCast(@as(c_uint, 128));
    pub const flags_shared_to_me: StoreInfoFlags = @bitCast(@as(c_uint, 256));
    pub const flags_shared_by_me: StoreInfoFlags = @bitCast(@as(c_uint, 512));
    pub const flags_type_normal: StoreInfoFlags = @bitCast(@as(c_uint, 0));
    pub const flags_type_inbox: StoreInfoFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_type_outbox: StoreInfoFlags = @bitCast(@as(c_uint, 2048));
    pub const flags_type_trash: StoreInfoFlags = @bitCast(@as(c_uint, 3072));
    pub const flags_type_junk: StoreInfoFlags = @bitCast(@as(c_uint, 4096));
    pub const flags_type_sent: StoreInfoFlags = @bitCast(@as(c_uint, 5120));
    pub const flags_type_contacts: StoreInfoFlags = @bitCast(@as(c_uint, 6144));
    pub const flags_type_events: StoreInfoFlags = @bitCast(@as(c_uint, 7168));
    pub const flags_type_memos: StoreInfoFlags = @bitCast(@as(c_uint, 8192));
    pub const flags_type_tasks: StoreInfoFlags = @bitCast(@as(c_uint, 9216));
    pub const flags_type_all: StoreInfoFlags = @bitCast(@as(c_uint, 10240));
    pub const flags_type_archive: StoreInfoFlags = @bitCast(@as(c_uint, 11264));
    pub const flags_type_drafts: StoreInfoFlags = @bitCast(@as(c_uint, 12288));
    pub const flags_readonly: StoreInfoFlags = @bitCast(@as(c_uint, 65536));
    pub const flags_writeonly: StoreInfoFlags = @bitCast(@as(c_uint, 131072));
    pub const flags_flagged: StoreInfoFlags = @bitCast(@as(c_uint, 262144));
    extern fn camel_store_info_flags_get_type() usize;
    pub const getGObjectType = camel_store_info_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StorePermissionFlags = packed struct(c_uint) {
    read: bool = false,
    write: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_read: StorePermissionFlags = @bitCast(@as(c_uint, 1));
    pub const flags_write: StorePermissionFlags = @bitCast(@as(c_uint, 2));
    extern fn camel_store_permission_flags_get_type() usize;
    pub const getGObjectType = camel_store_permission_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const URLFlags = packed struct(c_uint) {
    params: bool = false,
    auth: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_params: URLFlags = @bitCast(@as(c_uint, 1));
    pub const flags_auth: URLFlags = @bitCast(@as(c_uint, 2));
    extern fn camel_url_flags_get_type() usize;
    pub const getGObjectType = camel_url_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UUDecodeState = packed struct(c_uint) {
    _padding0: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    begin: bool = false,
    end: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_init: UUDecodeState = @bitCast(@as(c_uint, 0));
    pub const flags_begin: UUDecodeState = @bitCast(@as(c_uint, 65536));
    pub const flags_end: UUDecodeState = @bitCast(@as(c_uint, 131072));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _search_flags_t = packed struct(c_uint) {
    start: bool = false,
    end: bool = false,
    regex: bool = false,
    icase: bool = false,
    newline: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_start: _search_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_end: _search_flags_t = @bitCast(@as(c_uint, 2));
    pub const flags_regex: _search_flags_t = @bitCast(@as(c_uint, 4));
    pub const flags_icase: _search_flags_t = @bitCast(@as(c_uint, 8));
    pub const flags_newline: _search_flags_t = @bitCast(@as(c_uint, 16));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Thread safe variant of `gobject.Object.bindProperty`. See its documentation
/// for more information on arguments and return value.
extern fn camel_binding_bind_property(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags) *gobject.Binding;
pub const bindingBindProperty = camel_binding_bind_property;

/// Thread safe variant of `gobject.Object.bindPropertyFull`. See its documentation
/// for more information on arguments and return value.
extern fn camel_binding_bind_property_full(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags, p_transform_to: ?gobject.BindingTransformFunc, p_transform_from: ?gobject.BindingTransformFunc, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) *gobject.Binding;
pub const bindingBindPropertyFull = camel_binding_bind_property_full;

/// Thread safe variant of `gobject.Object.bindPropertyWithClosures`. See its
/// documentation for more information on arguments and return value.
extern fn camel_binding_bind_property_with_closures(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags, p_transform_to: *gobject.Closure, p_transform_from: *gobject.Closure) *gobject.Binding;
pub const bindingBindPropertyWithClosures = camel_binding_bind_property_with_closures;

extern fn camel_cipher_can_load_photos() c_int;
pub const cipherCanLoadPhotos = camel_cipher_can_load_photos;

/// Writes a part to a stream in a canonicalised format, suitable for signing/encrypting.
///
/// The transfer encoding paramaters for the part may be changed by this function.
extern fn camel_cipher_canonical_to_stream(p_part: *camel.MimePart, p_flags: u32, p_ostream: *camel.Stream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const cipherCanonicalToStream = camel_cipher_canonical_to_stream;

/// Gets a named property `name` value for the given `cert_info`.
extern fn camel_cipher_certinfo_get_property(p_cert_info: *camel.CipherCertInfo, p_name: [*:0]const u8) ?*anyopaque;
pub const cipherCertinfoGetProperty = camel_cipher_certinfo_get_property;

/// Sets a named property `name` value `value` for the given `cert_info`.
/// If the `value` is `NULL`, then the property is removed. With a non-`NULL`
/// `value` also `value_free` and `value_clone` functions cannot be `NULL`.
extern fn camel_cipher_certinfo_set_property(p_cert_info: *camel.CipherCertInfo, p_name: [*:0]const u8, p_value: ?*anyopaque, p_value_free: ?glib.DestroyNotify, p_value_clone: ?camel.CipherCloneFunc) void;
pub const cipherCertinfoSetProperty = camel_cipher_certinfo_set_property;

extern fn camel_content_transfer_encoding_decode(p_in: [*:0]const u8) [*:0]u8;
pub const contentTransferEncodingDecode = camel_content_transfer_encoding_decode;

/// Check to see if a debug mode is activated.  `mode` takes one of two forms,
/// a fully qualified 'module:target', or a wildcard 'module' name.  It
/// returns a boolean to indicate if the module or module and target is
/// currently activated for debug output.
extern fn camel_debug(p_mode: [*:0]const u8) c_int;
pub const debug = camel_debug;

/// Demangles `bt`, possibly got from `camel.debugGetRawBacktrace`, by
/// replacing addresses with actual function calls and eventually line numbers, if
/// available. It modifies lines of `bt`, but skips those it cannot parse.
///
/// Note: Getting backtraces only works if the library was
/// configured with --enable-backtraces.
///
/// See also `camel.debugGetRawBacktrace`
extern fn camel_debug_demangle_backtrace(p_bt: ?*glib.String) void;
pub const debugDemangleBacktrace = camel_debug_demangle_backtrace;

/// Call this when you're done with your debug output.  If and only if
/// you called camel_debug_start, and if it returns TRUE.
extern fn camel_debug_end() void;
pub const debugEnd = camel_debug_end;

/// Gets current backtrace leading to this function call and demangles it.
extern fn camel_debug_get_backtrace() ?*glib.String;
pub const debugGetBacktrace = camel_debug_get_backtrace;

/// Gets current raw backtrace leading to this function call.
/// This is quicker than `camel.debugGetBacktrace`, because it
/// doesn't demangle the backtrace. To demangle it (replace addresses
/// with actual function calls and eventually line numbers, if
/// available) call `camel.debugDemangleBacktrace`.
extern fn camel_debug_get_raw_backtrace() ?*glib.String;
pub const debugGetRawBacktrace = camel_debug_get_raw_backtrace;

/// Init camel debug.
///
/// CAMEL_DEBUG is set to a comma separated list of modules to debug.
/// The modules can contain module-specific specifiers after a ':', or
/// just act as a wildcard for the module or even specifier.  e.g. 'imap'
/// for imap debug, or 'imap:folder' for imap folder debug.  Additionaly,
/// ':folder' can be used for a wildcard for any folder operations.
extern fn camel_debug_init() void;
pub const debugInit = camel_debug_init;

/// Prints current backtraces stored with `camel.debugRefUnrefPushBacktrace`
/// or with `camel.debugRefUnrefPushBacktraceForObject`.
///
/// It's usually not needed to use this function, as the left backtraces, if any,
/// are printed at the end of the application.
extern fn camel_debug_ref_unref_dump_backtraces() void;
pub const debugRefUnrefDumpBacktraces = camel_debug_ref_unref_dump_backtraces;

/// Adds this backtrace into the set of backtraces related to some object
/// reference counting issues debugging. This is usually called inside `gobject.Object.ref`
/// and `gobject.Object.unref`. If the backtrace corresponds to a `gobject.Object.unref`
/// call, and a corresponding `gobject.Object.ref` backtrace is found in the current list,
/// then the previous backtrace is removed and this one is skipped.
///
/// Any left backtraces in the list are printed at the application end.
///
/// A convenient function `camel.debugRefUnrefPushBacktraceForObject`
/// is provided too.
extern fn camel_debug_ref_unref_push_backtrace(p_backtrace: *const glib.String, p_object_ref_count: c_uint) void;
pub const debugRefUnrefPushBacktrace = camel_debug_ref_unref_push_backtrace;

/// Gets current backtrace of this call and adds it to the list
/// of backtraces with `camel.debugRefUnrefPushBacktrace`.
///
/// Usual usage would be, once GNOME bug 758358 is applied to the GLib sources,
/// or a patched GLib is used, to call this function in an object `init` function,
/// like this:
///
/// static void
/// my_object_init (MyObject *obj)
/// {
///    camel_debug_ref_unref_push_backtrace_for_object (obj);
///    g_track_object_ref_unref (obj, (GFunc) camel_debug_ref_unref_push_backtrace_for_object, NULL);
/// }
///
/// Note that the `g_track_object_ref_unref` can track only one pointer, thus make
/// sure you track the right one (add some logic if multiple objects are created at once).
extern fn camel_debug_ref_unref_push_backtrace_for_object(p__object: ?*anyopaque) void;
pub const debugRefUnrefPushBacktraceForObject = camel_debug_ref_unref_push_backtrace_for_object;

/// Start debug output for a given mode, used to make sure debug output
/// is output atomically and not interspersed with unrelated stuff.
extern fn camel_debug_start(p_mode: [*:0]const u8) c_int;
pub const debugStart = camel_debug_start;

/// Convert `in` from text/plain into text/enriched or text/richtext
/// based on `flags`.
extern fn camel_enriched_to_html(p_in: [*:0]const u8, p_flags: u32) [*:0]u8;
pub const enrichedToHtml = camel_enriched_to_html;

extern fn camel_error_quark() glib.Quark;
pub const errorQuark = camel_error_quark;

/// Retrieve a gint32.
extern fn camel_file_util_decode_fixed_int32(p_in: ?*anyopaque, p_dest: *i32) c_int;
pub const fileUtilDecodeFixedInt32 = camel_file_util_decode_fixed_int32;

/// Decode a normal string from the input file.
extern fn camel_file_util_decode_fixed_string(p_in: ?*anyopaque, p_str: *[*:0]u8, p_len: usize) c_int;
pub const fileUtilDecodeFixedString = camel_file_util_decode_fixed_string;

/// Decode a gint64 type.
extern fn camel_file_util_decode_gint64(p_in: ?*anyopaque, p_dest: *i64) c_int;
pub const fileUtilDecodeGint64 = camel_file_util_decode_gint64;

/// Decode an gsize type.
extern fn camel_file_util_decode_gsize(p_in: ?*anyopaque, p_dest: *usize) c_int;
pub const fileUtilDecodeGsize = camel_file_util_decode_gsize;

/// Decode an off_t type.
extern fn camel_file_util_decode_off_t(p_in: ?*anyopaque, p_dest: *camel.off_t) c_int;
pub const fileUtilDecodeOffT = camel_file_util_decode_off_t;

/// Decode a normal string from the input file.
extern fn camel_file_util_decode_string(p_in: ?*anyopaque, p_str: *[*:0]u8) c_int;
pub const fileUtilDecodeString = camel_file_util_decode_string;

/// Decode a time_t value.
extern fn camel_file_util_decode_time_t(p_in: ?*anyopaque, p_dest: *std.posix.time_t) c_int;
pub const fileUtilDecodeTimeT = camel_file_util_decode_time_t;

/// Retrieve an encoded uint32 from a file.
extern fn camel_file_util_decode_uint32(p_in: ?*anyopaque, p_dest: *u32) c_int;
pub const fileUtilDecodeUint32 = camel_file_util_decode_uint32;

/// Encode a gint32, performing no compression, but converting
/// to network order.
extern fn camel_file_util_encode_fixed_int32(p_out: ?*anyopaque, p_value: i32) c_int;
pub const fileUtilEncodeFixedInt32 = camel_file_util_encode_fixed_int32;

/// Encode a normal string and save it in the output file.
/// Unlike `camel_file_util_encode_string`, it pads the
/// `str` with "NULL" bytes, if `len` is > strlen(str)
extern fn camel_file_util_encode_fixed_string(p_out: ?*anyopaque, p_str: [*:0]const u8, p_len: usize) c_int;
pub const fileUtilEncodeFixedString = camel_file_util_encode_fixed_string;

/// Encode a gint64 type.
extern fn camel_file_util_encode_gint64(p_out: ?*anyopaque, p_value: i64) c_int;
pub const fileUtilEncodeGint64 = camel_file_util_encode_gint64;

/// Encode an gsize type.
extern fn camel_file_util_encode_gsize(p_out: ?*anyopaque, p_value: usize) c_int;
pub const fileUtilEncodeGsize = camel_file_util_encode_gsize;

/// Encode an off_t type.
extern fn camel_file_util_encode_off_t(p_out: ?*anyopaque, p_value: camel.off_t) c_int;
pub const fileUtilEncodeOffT = camel_file_util_encode_off_t;

/// Encode a normal string and save it in the output file.
extern fn camel_file_util_encode_string(p_out: ?*anyopaque, p_str: [*:0]const u8) c_int;
pub const fileUtilEncodeString = camel_file_util_encode_string;

/// Encode a time_t value to the file.
extern fn camel_file_util_encode_time_t(p_out: ?*anyopaque, p_value: std.posix.time_t) c_int;
pub const fileUtilEncodeTimeT = camel_file_util_encode_time_t;

/// Utility function to save an uint32 to a file.
extern fn camel_file_util_encode_uint32(p_out: ?*anyopaque, p_value: u32) c_int;
pub const fileUtilEncodeUint32 = camel_file_util_encode_uint32;

/// 'Flattens' `name` into a safe filename string by hex encoding any
/// chars that may cause problems on the filesystem.
extern fn camel_file_util_safe_filename(p_name: [*:0]const u8) [*:0]u8;
pub const fileUtilSafeFilename = camel_file_util_safe_filename;

/// Builds a pathname where the basename is of the form ".#" + the
/// basename of `filename`, for instance used in a two-stage commit file
/// write.
extern fn camel_file_util_savename(p_filename: [*:0]const u8) [*:0]u8;
pub const fileUtilSavename = camel_file_util_savename;

extern fn camel_filter_search_match(p_session: ?*anyopaque, p_get_message: camel.FilterSearchGetMessageFunc, p_user_data: ?*anyopaque, p_info: *camel.MessageInfo, p_source: [*:0]const u8, p_folder: ?*anyopaque, p_expression: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const filterSearchMatch = camel_filter_search_match;

extern fn camel_filter_search_match_with_log(p_session: ?*anyopaque, p_get_message: camel.FilterSearchGetMessageFunc, p_user_data: ?*anyopaque, p_info: *camel.MessageInfo, p_source: [*:0]const u8, p_folder: ?*anyopaque, p_expression: [*:0]const u8, p_logfile: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const filterSearchMatchWithLog = camel_filter_search_match_with_log;

/// Frees a structure returned with `camel.getaddrinfo`. It does
/// nothing when the `host` is `NULL`.
extern fn camel_freeaddrinfo(p_host: ?*anyopaque) void;
pub const freeaddrinfo = camel_freeaddrinfo;

/// Resolves a host `name` and returns an information about its address.
extern fn camel_getaddrinfo(p_name: [*:0]const u8, p_service: [*:0]const u8, p_hints: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*anyopaque;
pub const getaddrinfo = camel_getaddrinfo;

/// Extract a content-id from `in`.
extern fn camel_header_contentid_decode(p_in: [*:0]const u8) [*:0]u8;
pub const headerContentidDecode = camel_header_contentid_decode;

/// Decodes the rfc822 date string and saves the GMT offset into
/// `tz_offset` if non-NULL.
extern fn camel_header_decode_date(p_str: [*:0]const u8, p_tz_offset: *c_int) std.posix.time_t;
pub const headerDecodeDate = camel_header_decode_date;

/// Extracts an integer token from `in` and updates the pointer to point
/// to after the end of the integer token (sort of like strtol).
extern fn camel_header_decode_int(p_in: *[*:0]const u8) c_int;
pub const headerDecodeInt = camel_header_decode_int;

/// Decodes rfc2047 encoded-word tokens
extern fn camel_header_decode_string(p_in: [*:0]const u8, p_default_charset: [*:0]const u8) [*:0]u8;
pub const headerDecodeString = camel_header_decode_string;

/// Encodes a 'phrase' header according to the rules in rfc2047.
extern fn camel_header_encode_phrase(p_in: *const u8) [*:0]u8;
pub const headerEncodePhrase = camel_header_encode_phrase;

/// Encodes a 'text' header according to the rules of rfc2047.
extern fn camel_header_encode_string(p_in: *const u8) [*:0]u8;
pub const headerEncodeString = camel_header_encode_string;

extern fn camel_header_fold(p_in: [*:0]const u8, p_headerlen: usize) [*:0]u8;
pub const headerFold = camel_header_fold;

/// Decodes a header which contains rfc2047 encoded-word tokens that
/// may or may not be within a comment.
extern fn camel_header_format_ctext(p_in: [*:0]const u8, p_default_charset: [*:0]const u8) [*:0]u8;
pub const headerFormatCtext = camel_header_format_ctext;

/// Allocates a string buffer containing the rfc822 formatted date
/// string represented by `time` and `tz_offset`.
extern fn camel_header_format_date(p_date: std.posix.time_t, p_tz_offset: c_int) [*:0]u8;
pub const headerFormatDate = camel_header_format_date;

extern fn camel_header_location_decode(p_in: [*:0]const u8) [*:0]u8;
pub const headerLocationDecode = camel_header_location_decode;

extern fn camel_header_mailbox_decode(p_in: [*:0]const u8, p_charset: [*:0]const u8) *camel.HeaderAddress;
pub const headerMailboxDecode = camel_header_mailbox_decode;

extern fn camel_header_mime_decode(p_in: [*:0]const u8, p_maj: *c_int, p_min: *c_int) void;
pub const headerMimeDecode = camel_header_mime_decode;

/// Extract a message-id token from `in`.
extern fn camel_header_msgid_decode(p_in: [*:0]const u8) [*:0]u8;
pub const headerMsgidDecode = camel_header_msgid_decode;

/// Either the `domain` is used, or the user's local hostname,
/// in case it's `NULL` or empty.
extern fn camel_header_msgid_generate(p_domain: ?[*:0]const u8) [*:0]u8;
pub const headerMsgidGenerate = camel_header_msgid_generate;

extern fn camel_header_newsgroups_decode(p_in: [*:0]const u8) *glib.SList;
pub const headerNewsgroupsDecode = camel_header_newsgroups_decode;

/// Searches `params` for a param named `name` and gets the value.
extern fn camel_header_param(p_params: ?*anyopaque, p_name: [*:0]const u8) [*:0]u8;
pub const headerParam = camel_header_param;

/// Generate a list of references, from most recent up.
extern fn camel_header_references_decode(p_in: [*:0]const u8) *glib.SList;
pub const headerReferencesDecode = camel_header_references_decode;

/// Set a parameter in the list.
extern fn camel_header_set_param(p_paramsp: ?*anyopaque, p_name: [*:0]const u8, p_value: [*:0]const u8) ?*anyopaque;
pub const headerSetParam = camel_header_set_param;

/// Gets the first token in the string according to the rules of
/// rfc0822.
extern fn camel_header_token_decode(p_in: [*:0]const u8) [*:0]u8;
pub const headerTokenDecode = camel_header_token_decode;

extern fn camel_header_unfold(p_in: [*:0]const u8) [*:0]u8;
pub const headerUnfold = camel_header_unfold;

/// Searches for a mailing list information among known headers and returns
/// a newly allocated string with its value.
extern fn camel_headers_dup_mailing_list(p_headers: *const camel.NameValueArray) ?[*:0]u8;
pub const headersDupMailingList = camel_headers_dup_mailing_list;

/// Converts IDN (Internationalized Domain Name) into ASCII representation.
/// If there's a failure or the `host` has only ASCII letters, then a copy
/// of `host` is returned.
extern fn camel_host_idna_to_ascii(p_host: ?[*:0]const u8) ?[*:0]u8;
pub const hostIdnaToAscii = camel_host_idna_to_ascii;

/// Check whether the hostname `host` is equal to or a subdomain of `domain`.
/// Both `host` and `domain` are UTF-8 strings and can be IDNs (which will be
/// punycode-encoded for comparison).
extern fn camel_hostname_utils_host_is_in_domain(p_host: ?[*:0]const u8, p_domain: ?[*:0]const u8) c_int;
pub const hostnameUtilsHostIsInDomain = camel_hostname_utils_host_is_in_domain;

/// Check whether the `hostname` requires conversion to ASCII. That can
/// be when a character in it can look like an ASCII character, even
/// it being a Unicode letter. This can be used to display host names
/// in a way of invulnerable to IDN homograph attacks.
extern fn camel_hostname_utils_requires_ascii(p_hostname: [*:0]const u8) c_int;
pub const hostnameUtilsRequiresAscii = camel_hostname_utils_requires_ascii;

extern fn camel_iconv(p_cd: glib.IConv, p_inbuf: *[*:0]const u8, p_inleft: *usize, p_outbuf: *[*:0]u8, p_outleft: *usize) usize;
pub const iconv = camel_iconv;

extern fn camel_iconv_charset_language(p_charset: [*:0]const u8) [*:0]const u8;
pub const iconvCharsetLanguage = camel_iconv_charset_language;

extern fn camel_iconv_charset_name(p_charset: [*:0]const u8) [*:0]const u8;
pub const iconvCharsetName = camel_iconv_charset_name;

extern fn camel_iconv_close(p_cd: glib.IConv) void;
pub const iconvClose = camel_iconv_close;

extern fn camel_iconv_locale_charset() [*:0]const u8;
pub const iconvLocaleCharset = camel_iconv_locale_charset;

extern fn camel_iconv_locale_language() [*:0]const u8;
pub const iconvLocaleLanguage = camel_iconv_locale_language;

extern fn camel_iconv_open(p_to: [*:0]const u8, p_from: [*:0]const u8) glib.IConv;
pub const iconvOpen = camel_iconv_open;

extern fn camel_init(p_certdb_dir: [*:0]const u8, p_nss_init: c_int) c_int;
pub const init = camel_init;

/// Converts the calendar time representation `tt` to a broken-down
/// time representation, stored in `tm`, and provides the offset in
/// seconds from UTC time, stored in `offset`.
extern fn camel_localtime_with_offset(p_tt: std.posix.time_t, p_tm: ?*anyopaque, p_offset: *c_int) void;
pub const localtimeWithOffset = camel_localtime_with_offset;

/// Create an exclusive lock using .lock semantics.
/// All locks are equivalent to write locks (exclusive).
///
/// The function does nothing and returns success (zero),
/// when dot locking had not been compiled.
extern fn camel_lock_dot(p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const lockDot = camel_lock_dot;

/// Create a lock using fcntl(2).
///
/// `type` is CAMEL_LOCK_WRITE or CAMEL_LOCK_READ,
/// to create exclusive or shared read locks
///
/// The function does nothing and returns success (zero),
/// when fcntl locking had not been compiled.
extern fn camel_lock_fcntl(p_fd: c_int, p_type: camel.LockType, p_error: ?*?*glib.Error) c_int;
pub const lockFcntl = camel_lock_fcntl;

/// Create a lock using flock(2).
///
/// `type` is CAMEL_LOCK_WRITE or CAMEL_LOCK_READ,
/// to create exclusive or shared read locks
///
/// The function does nothing and returns success (zero),
/// when flock locking had not been compiled.
extern fn camel_lock_flock(p_fd: c_int, p_type: camel.LockType, p_error: ?*?*glib.Error) c_int;
pub const lockFlock = camel_lock_flock;

/// Attempt to lock a folder, multiple attempts will be made using all
/// locking strategies available.
extern fn camel_lock_folder(p_path: [*:0]const u8, p_fd: c_int, p_type: camel.LockType, p_error: ?*?*glib.Error) c_int;
pub const lockFolder = camel_lock_folder;

extern fn camel_lock_helper_lock(p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const lockHelperLock = camel_lock_helper_lock;

extern fn camel_lock_helper_unlock(p_lockid: c_int) c_int;
pub const lockHelperUnlock = camel_lock_helper_unlock;

/// Allocate a new atom size block of memory from a `camel.MemChunk`.
/// Free the returned atom with `camel.memchunkFree`.
extern fn camel_memchunk_alloc(p_memchunk: *camel.MemChunk) ?*anyopaque;
pub const memchunkAlloc = camel_memchunk_alloc;

/// Allocate a new atom size block of memory from a `camel.MemChunk`,
/// and fill the memory with zeros.  Free the returned atom with
/// `camel.memchunkFree`.
extern fn camel_memchunk_alloc0(p_memchunk: *camel.MemChunk) ?*anyopaque;
pub const memchunkAlloc0 = camel_memchunk_alloc0;

/// Scan all empty blocks and check for blocks which can be free'd
/// back to the system.
///
/// This routine may take a while to run if there are many allocated
/// memory blocks (if the total number of allocations is many times
/// greater than atomcount).
extern fn camel_memchunk_clean(p_memchunk: *camel.MemChunk) void;
pub const memchunkClean = camel_memchunk_clean;

/// Free the memchunk header, and all associated memory.
extern fn camel_memchunk_destroy(p_memchunk: *camel.MemChunk) void;
pub const memchunkDestroy = camel_memchunk_destroy;

/// Clean out the memchunk buffers.  Marks all allocated memory as free blocks,
/// but does not give it back to the system.  Can be used if the memchunk
/// is to be used repeatedly.
extern fn camel_memchunk_empty(p_memchunk: *camel.MemChunk) void;
pub const memchunkEmpty = camel_memchunk_empty;

/// Free a single atom back to the free pool of atoms in the given
/// memchunk.
extern fn camel_memchunk_free(p_memchunk: *camel.MemChunk, p_mem: ?*anyopaque) void;
pub const memchunkFree = camel_memchunk_free;

/// Create a new `camel.MemChunk` header.  Memchunks are an efficient way to
/// allocate and deallocate identical sized blocks of memory quickly, and
/// space efficiently.
///
/// camel_memchunks are effectively the same as gmemchunks, only faster (much),
/// and they use less memory overhead for housekeeping.
extern fn camel_memchunk_new(p_atomcount: c_int, p_atomsize: c_int) *camel.MemChunk;
pub const memchunkNew = camel_memchunk_new;

/// Allocate a new data block in the mempool.  Size will
/// be rounded up to the mempool's alignment restrictions
/// before being used.
extern fn camel_mempool_alloc(p_pool: *camel.MemPool, p_size: c_int) ?*anyopaque;
pub const mempoolAlloc = camel_mempool_alloc;

/// Free all memory associated with a mempool.
extern fn camel_mempool_destroy(p_pool: *camel.MemPool) void;
pub const mempoolDestroy = camel_mempool_destroy;

/// Flush used memory and mark allocated blocks as free.
///
/// If `freeall` is `TRUE`, then all allocated blocks are free'd
/// as well.  Otherwise only blocks above the threshold are
/// actually freed, and the others are simply marked as empty.
extern fn camel_mempool_flush(p_pool: *camel.MemPool, p_freeall: c_int) void;
pub const mempoolFlush = camel_mempool_flush;

/// Create a new mempool header.  Mempools can be used to efficiently
/// allocate data which can then be freed as a whole.
///
/// Mempools can also be used to efficiently allocate arbitrarily
/// aligned data (such as strings) without incurring the space overhead
/// of aligning each allocation (which is not required for strings).
///
/// However, each allocation cannot be freed individually, only all
/// or nothing.
extern fn camel_mempool_new(p_blocksize: c_int, p_threshold: c_int, p_flags: camel.MemPoolFlags) *camel.MemPool;
pub const mempoolNew = camel_mempool_new;

extern fn camel_mempool_strdup(p_pool: *camel.MemPool, p_str: [*:0]const u8) [*:0]u8;
pub const mempoolStrdup = camel_mempool_strdup;

/// Like mktime(3), but assumes UTC instead of local timezone.
extern fn camel_mktime_utc(p_tm: ?*anyopaque) std.posix.time_t;
pub const mktimeUtc = camel_mktime_utc;

/// This copies an mbox file from a shared directory with multiple
/// readers and writers into a private (presumably Camel-controlled)
/// directory. Dot locking is used on the source file (but not the
/// destination).
extern fn camel_movemail(p_source: [*:0]const u8, p_dest: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const movemail = camel_movemail;

extern fn camel_msgport_destroy(p_msgport: *camel.MsgPort) void;
pub const msgportDestroy = camel_msgport_destroy;

extern fn camel_msgport_fd(p_msgport: *camel.MsgPort) c_int;
pub const msgportFd = camel_msgport_fd;

extern fn camel_msgport_new() *camel.MsgPort;
pub const msgportNew = camel_msgport_new;

extern fn camel_msgport_pop(p_msgport: *camel.MsgPort) *camel.Msg;
pub const msgportPop = camel_msgport_pop;

extern fn camel_msgport_prfd(p_msgport: *camel.MsgPort) ?*anyopaque;
pub const msgportPrfd = camel_msgport_prfd;

extern fn camel_msgport_push(p_msgport: *camel.MsgPort, p_msg: *camel.Msg) void;
pub const msgportPush = camel_msgport_push;

extern fn camel_msgport_reply(p_msg: *camel.Msg) void;
pub const msgportReply = camel_msgport_reply;

extern fn camel_msgport_timeout_pop(p_msgport: *camel.MsgPort, p_timeout: u64) *camel.Msg;
pub const msgportTimeoutPop = camel_msgport_timeout_pop;

extern fn camel_msgport_try_pop(p_msgport: *camel.MsgPort) *camel.Msg;
pub const msgportTryPop = camel_msgport_try_pop;

/// Prints information about currently stored pointers
/// in the pointer tracker. This is called automatically
/// on application exit if `camel_pointer_tracker_track` or
/// `camel.pointerTrackerTrackWithInfo` was called.
///
/// Note: If the library is configured with --enable-backtraces,
/// then also backtraces where the pointer was added is printed
/// in the summary.
extern fn camel_pointer_tracker_dump() void;
pub const pointerTrackerDump = camel_pointer_tracker_dump;

/// Adds pointer to the pointer tracker, with associated information,
/// which is printed in summary of pointer tracker printed by
/// `camel.pointerTrackerDump`. For convenience can be used
/// `camel_pointer_tracker_track`, which adds place of the caller
/// as `info`. Added pointer should be removed with pair function
/// `camel.pointerTrackerUntrack`.
extern fn camel_pointer_tracker_track_with_info(p_ptr: ?*anyopaque, p_info: [*:0]const u8) void;
pub const pointerTrackerTrackWithInfo = camel_pointer_tracker_track_with_info;

/// Removes pointer from the pointer tracker. It's an error to try
/// to remove pointer which was not added to the tracker by
/// `camel_pointer_tracker_track` or `camel.pointerTrackerTrackWithInfo`,
/// or a pointer which was already removed.
extern fn camel_pointer_tracker_untrack(p_ptr: ?*anyopaque) void;
pub const pointerTrackerUntrack = camel_pointer_tracker_untrack;

/// Add `string` to the pool.
///
/// The `NULL` and empty strings are special cased to constant values.
///
/// Unreference the returned string with `camel.pstringFree`.
extern fn camel_pstring_add(p_string: ?[*:0]u8, p_own: c_int) ?[*:0]const u8;
pub const pstringAdd = camel_pstring_add;

/// Returns whether the `string` exists in the string pool.
///
/// The `NULL` and empty strings are special cased to constant values.
extern fn camel_pstring_contains(p_string: ?[*:0]const u8) c_int;
pub const pstringContains = camel_pstring_contains;

/// Dumps to stdout memory statistic about the string pool.
extern fn camel_pstring_dump_stat() void;
pub const pstringDumpStat = camel_pstring_dump_stat;

/// Unreferences a pooled string.  If the string's reference count drops to
/// zero it will be deallocated.  `NULL` and the empty string are special cased.
extern fn camel_pstring_free(p_string: ?[*:0]const u8) void;
pub const pstringFree = camel_pstring_free;

/// Returns the canonicalized copy of `string` without increasing its
/// reference count in the string pool.  If necessary, `string` is first
/// added to the string pool.
///
/// The `NULL` and empty strings are special cased to constant values.
extern fn camel_pstring_peek(p_string: ?[*:0]const u8) ?[*:0]const u8;
pub const pstringPeek = camel_pstring_peek;

/// Create a new pooled string entry for `strings`.  A pooled string
/// is a table where common strings are canonicalized.  They are also
/// reference counted and freed when no longer referenced.
///
/// The `NULL` and empty strings are special cased to constant values.
///
/// Unreference the returned string with `camel.pstringFree`.
extern fn camel_pstring_strdup(p_string: ?[*:0]const u8) ?[*:0]const u8;
pub const pstringStrdup = camel_pstring_strdup;

/// Decodes a block of quoted-printable encoded data. Performs a
/// 'decode step' on a chunk of QP encoded data.
extern fn camel_quoted_decode_step(p_in: [*]u8, p_len: usize, p_out: *[*]u8, p_savestate: *c_int, p_saveme: *[*]c_int) usize;
pub const quotedDecodeStep = camel_quoted_decode_step;

/// Quoted-printable encodes a block of text. Call this when finished
/// encoding data with `camel.quotedEncodeStep` to flush off
/// the last little bit.
extern fn camel_quoted_encode_close(p_in: [*]u8, p_len: usize, p_out: *[*]u8, p_state: *c_int, p_save: *[*]c_int) usize;
pub const quotedEncodeClose = camel_quoted_encode_close;

/// Quoted-printable encodes a block of text. Performs an 'encode
/// step', saves left-over state in state and save (initialise to -1 on
/// first invocation).
extern fn camel_quoted_encode_step(p_in: [*]u8, p_len: usize, p_out: *[*]u8, p_state: *c_int, p_save: *[*]c_int) usize;
pub const quotedEncodeStep = camel_quoted_encode_step;

/// Cancellable libc `read` replacement.
///
/// Code that intends to be portable to Win32 should call this function
/// only on file descriptors returned from `open`, not on sockets.
extern fn camel_read(p_fd: c_int, p_buf: [*:0]u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
pub const read = camel_read;

extern fn camel_search_build_match_regex(p_pattern: *anyopaque, p_type: camel._search_flags_t, p_argc: c_int, p_argv: **camel.SExpResult, p_error: ?*?*glib.Error) c_int;
pub const searchBuildMatchRegex = camel_search_build_match_regex;

extern fn camel_search_camel_header_soundex(p_header: [*:0]const u8, p_match: [*:0]const u8) c_int;
pub const searchCamelHeaderSoundex = camel_search_camel_header_soundex;

extern fn camel_search_get_all_headers_decoded(p_message: *camel.MimeMessage) [*:0]u8;
pub const searchGetAllHeadersDecoded = camel_search_get_all_headers_decoded;

extern fn camel_search_get_default_charset_from_headers(p_headers: *const camel.NameValueArray) [*:0]const u8;
pub const searchGetDefaultCharsetFromHeaders = camel_search_get_default_charset_from_headers;

extern fn camel_search_get_default_charset_from_message(p_message: *camel.MimeMessage) [*:0]const u8;
pub const searchGetDefaultCharsetFromMessage = camel_search_get_default_charset_from_message;

/// Decodes `header_value`, if needed, either from an address header
/// or the Subject header. Other `header_name` headers are returned
/// as is.
extern fn camel_search_get_header_decoded(p_header_name: [*:0]const u8, p_header_value: [*:0]const u8, p_default_charset: ?[*:0]const u8) [*:0]u8;
pub const searchGetHeaderDecoded = camel_search_get_header_decoded;

extern fn camel_search_get_headers_decoded(p_headers: *const camel.NameValueArray, p_default_charset: ?[*:0]const u8) [*:0]u8;
pub const searchGetHeadersDecoded = camel_search_get_headers_decoded;

extern fn camel_search_header_is_address(p_header_name: [*:0]const u8) c_int;
pub const searchHeaderIsAddress = camel_search_header_is_address;

extern fn camel_search_header_match(p_value: [*:0]const u8, p_match: [*:0]const u8, p_how: camel._search_match_t, p_type: camel._search_t, p_default_charset: [*:0]const u8) c_int;
pub const searchHeaderMatch = camel_search_header_match;

extern fn camel_search_message_body_contains(p_object: *camel.DataWrapper, p_pattern: *anyopaque) c_int;
pub const searchMessageBodyContains = camel_search_message_body_contains;

extern fn camel_search_words_free(p_words: ?*anyopaque) void;
pub const searchWordsFree = camel_search_words_free;

extern fn camel_search_words_simple(p_words: ?*anyopaque) ?*anyopaque;
pub const searchWordsSimple = camel_search_words_simple;

extern fn camel_search_words_split(p_in: *const u8) ?*anyopaque;
pub const searchWordsSplit = camel_search_words_split;

extern fn camel_shutdown() void;
pub const shutdown = camel_shutdown;

extern fn camel_strcase_equal(p_a: ?*const anyopaque, p_b: ?*const anyopaque) c_int;
pub const strcaseEqual = camel_strcase_equal;

extern fn camel_strcase_hash(p_v: ?*const anyopaque) c_uint;
pub const strcaseHash = camel_strcase_hash;

extern fn camel_strdown(p_str: [*:0]u8) [*:0]const u8;
pub const strdown = camel_strdown;

extern fn camel_string_is_all_ascii(p_str: ?[*:0]const u8) c_int;
pub const stringIsAllAscii = camel_string_is_all_ascii;

extern fn camel_strstrcase(p_haystack: [*:0]const u8, p_needle: [*:0]const u8) [*:0]u8;
pub const strstrcase = camel_strstrcase;

extern fn camel_system_flag(p_name: [*:0]const u8) camel.MessageFlags;
pub const systemFlag = camel_system_flag;

/// Find the state of the flag `name` in `flags`.
extern fn camel_system_flag_get(p_flags: camel.MessageFlags, p_name: [*:0]const u8) c_int;
pub const systemFlagGet = camel_system_flag_get;

/// Convert `in` from plain text into HTML.
extern fn camel_text_to_html(p_in: [*:0]const u8, p_flags: camel.MimeFilterToHTMLFlags, p_color: u32) [*:0]u8;
pub const textToHtml = camel_text_to_html;

/// Applies the given time `value` in unit `unit` to the `src_time`.
/// Use negative value to subtract it. The time part is rounded
/// to the beginning of the day.
extern fn camel_time_value_apply(p_src_time: std.posix.time_t, p_unit: camel.TimeUnit, p_value: c_int) std.posix.time_t;
pub const timeValueApply = camel_time_value_apply;

/// Convert a ucs2 string into a UTF-8 one. The ucs2 string is treated
/// as network byte ordered, and terminated with a 16-bit `NULL`.
extern fn camel_ucs2_utf8(p_ptr: [*:0]const u8) [*:0]u8;
pub const ucs2Utf8 = camel_ucs2_utf8;

/// Attempt to unlock a .lock lock.
///
/// The function does nothing, when dot locking had not been compiled.
extern fn camel_unlock_dot(p_path: [*:0]const u8) void;
pub const unlockDot = camel_unlock_dot;

/// Unlock an fcntl lock.
///
/// The function does nothing, when fcntl locking had not been compiled.
extern fn camel_unlock_fcntl(p_fd: c_int) void;
pub const unlockFcntl = camel_unlock_fcntl;

/// Unlock an flock lock.
///
/// The function does nothing, when flock locking had not been compiled.
extern fn camel_unlock_flock(p_fd: c_int) void;
pub const unlockFlock = camel_unlock_flock;

/// Free a lock on a folder.
extern fn camel_unlock_folder(p_path: [*:0]const u8, p_fd: c_int) void;
pub const unlockFolder = camel_unlock_folder;

extern fn camel_ustrstrcase(p_haystack: [*:0]const u8, p_needle: [*:0]const u8) [*:0]const u8;
pub const ustrstrcase = camel_ustrstrcase;

/// Convert a modified UTF-7 string to UTF-8.  If the UTF-7 string
/// contains 8 bit characters, they are treated as iso-8859-1.
///
/// The IMAP rules [rfc2060] are used in the UTF-7 encoding.
extern fn camel_utf7_utf8(p_ptr: [*:0]const u8) [*:0]u8;
pub const utf7Utf8 = camel_utf7_utf8;

/// Get a Unicode character from a UTF-8 stream.  `ptr` will be advanced
/// to the next character position.  Invalid utf8 characters will be
/// silently skipped. The `ptr` should point to a NUL terminated array.
extern fn camel_utf8_getc(p_ptr: **const u8) u32;
pub const utf8Getc = camel_utf8_getc;

/// Get the next UTF-8 gchar at `ptr`, and return it, advancing `ptr` to
/// the next character. If `end` is reached before a full UTF-8
/// character can be read, then the invalid Unicode gchar 0xffff is
/// returned as a sentinel (Unicode 3.1, section 2.7), and `ptr` is not
/// advanced.
extern fn camel_utf8_getc_limit(p_ptr: **const u8, p_end: *const u8) u32;
pub const utf8GetcLimit = camel_utf8_getc_limit;

/// Ensures the returned text will be valid UTF-8 string, with incorrect letters
/// changed to question marks.
extern fn camel_utf8_make_valid(p_text: [*:0]const u8) [*:0]u8;
pub const utf8MakeValid = camel_utf8_make_valid;

/// Ensures the returned text will be valid UTF-8 string, with incorrect letters
/// changed to question marks.
extern fn camel_utf8_make_valid_len(p_text: [*:0]const u8, p_text_len: isize) [*:0]u8;
pub const utf8MakeValidLen = camel_utf8_make_valid_len;

/// Output a 32 bit unicode character as UTF-8 octets.  At most 4 octets will
/// be written to `ptr`. The `ptr` will be advanced to the next character position.
extern fn camel_utf8_putc(p_ptr: **u8, p_c: u32) void;
pub const utf8Putc = camel_utf8_putc;

/// Convert a UTF-8 string into a ucs2 one. The ucs string will be in
/// network byte order, and terminated with a 16-bit `NULL`.
extern fn camel_utf8_ucs2(p_ptr: [*:0]const u8) [*:0]u8;
pub const utf8Ucs2 = camel_utf8_ucs2;

/// Convert a UTF-8 string to a modified UTF-7 format.
///
/// The IMAP rules [rfc2060] are used in the UTF-7 encoding.
extern fn camel_utf8_utf7(p_ptr: [*:0]const u8) [*:0]u8;
pub const utf8Utf7 = camel_utf8_utf7;

/// Reads a numeric data from the `bdata_ptr` and moves the `bdata_ptr`
/// after that number. If the number cannot be read, then the `default_value`
/// is returned instead and the `bdata_ptr` is left unchanged. The number
/// might be previously stored with the `camel.utilBdataPutNumber`.
extern fn camel_util_bdata_get_number(p_bdata_ptr: *[*:0]u8, p_default_value: i64) i64;
pub const utilBdataGetNumber = camel_util_bdata_get_number;

/// Reads a string data from the `bdata_ptr` and moves the `bdata_ptr`
/// after that string. If the string cannot be read, then the `default_value`
/// is returned instead and the `bdata_ptr` is left unchanged. The string
/// might be previously stored with the `camel.utilBdataPutString`.
extern fn camel_util_bdata_get_string(p_bdata_ptr: *[*:0]u8, p_default_value: [*:0]const u8) [*:0]u8;
pub const utilBdataGetString = camel_util_bdata_get_string;

/// Puts the number `value` at the end of the `bdata_str`. In case the `bdata_str`
/// is not empty a space is added before the numeric `value`. The stored value
/// can be read back with the `camel.utilBdataGetNumber`.
extern fn camel_util_bdata_put_number(p_bdata_str: *glib.String, p_value: i64) void;
pub const utilBdataPutNumber = camel_util_bdata_put_number;

/// Puts the string `value` at the end of the `bdata_str`. In case the `bdata_str`
/// is not empty a space is added before the string `value`. The stored value
/// can be read back with the `camel.utilBdataGetString`.
///
/// The strings are encoded as "length-value", quotes for clarity only.
extern fn camel_util_bdata_put_string(p_bdata_str: *glib.String, p_value: [*:0]const u8) void;
pub const utilBdataPutString = camel_util_bdata_put_string;

/// Decode the values previously encoded by `camel.utilEncodeUserHeaderSetting`.
/// The `out_header_name` points to the `setting_value`, thus it's valid as long
/// as the `setting_value` is valid and unchanged.
///
/// The `out_header_name` can result in `NULL` when the `setting_value`
/// contains invalid data.
///
/// The `out_display_name` can result in `NULL` when the `setting_value`
/// does not contain the display name. In such case the header name can
/// be used as the display name.
extern fn camel_util_decode_user_header_setting(p_setting_value: [*:0]const u8, p_out_display_name: ?*[*:0]u8, p_out_header_name: *[*:0]const u8) void;
pub const utilDecodeUserHeaderSetting = camel_util_decode_user_header_setting;

/// Encode the optional `display_name` and the `header_name` to a value suitable
/// for GSettings schema org.gnome.evolution-data-server and key camel-message-info-user-headers.
///
/// Free the returned string with `glib.free`, when no longer needed.
extern fn camel_util_encode_user_header_setting(p_display_name: ?[*:0]const u8, p_header_name: [*:0]const u8) [*:0]u8;
pub const utilEncodeUserHeaderSetting = camel_util_encode_user_header_setting;

/// Fill `info` 's user-headers with the user-defined headers from
/// the `headers` array.
extern fn camel_util_fill_message_info_user_headers(p_info: *camel.MessageInfo, p_headers: *const camel.NameValueArray) c_int;
pub const utilFillMessageInfoUserHeaders = camel_util_fill_message_info_user_headers;

/// The `main_path` is a directory, which will be always used. It
/// should have as its prefix the `replace_prefix`, otherwise
/// the function returns only the `main_path` in the paths array.
///
/// When there's exported an environment variable EDS_EXTRA_PREFIXES,
/// it is used as a list of alternative prefixes where to look for
/// the `main_path` (rest after the `replace_prefix`).
///
/// When the `with_modules_dir` is `TRUE`, there's also added
/// `glib.getUserDataDir` + "evolution/modules/", aka
/// ~/.local/share/evolution/modules/, into the resulting array.
extern fn camel_util_get_directory_variants(p_main_path: [*:0]const u8, p_replace_prefix: [*:0]const u8, p_with_modules_dir: c_int) *glib.PtrArray;
pub const utilGetDirectoryVariants = camel_util_get_directory_variants;

/// Checks whether the domain in the `email_address` requires
/// conversion to ASCII and if it does it also converts it.
/// When the `do_format` is `TRUE`, the output string is formatted
/// for display, otherwise it's encoded for use in the message
/// headers. A `NULL` is returned when no conversion was needed.
extern fn camel_utils_sanitize_ascii_domain_in_address(p_email_address: ?[*:0]const u8, p_do_format: c_int) ?[*:0]u8;
pub const utilsSanitizeAsciiDomainInAddress = camel_utils_sanitize_ascii_domain_in_address;

/// Checks whether the host name of the `url` requires conversion
/// to ASCII and converts it, if needed.
extern fn camel_utils_sanitize_ascii_domain_in_url(p_url: *camel.URL) c_int;
pub const utilsSanitizeAsciiDomainInUrl = camel_utils_sanitize_ascii_domain_in_url;

/// Checks whether the host name of the `url_str` requires conversion
/// to ASCII and converts it if needed. Returns `NULL`, when no conversion
/// was required.
extern fn camel_utils_sanitize_ascii_domain_in_url_str(p_url_str: ?[*:0]const u8) ?[*:0]u8;
pub const utilsSanitizeAsciiDomainInUrlStr = camel_utils_sanitize_ascii_domain_in_url_str;

/// Frees a `gobject.WeakRef` created by `camel.utilsWeakRefNew`.
extern fn camel_utils_weak_ref_free(p_weak_ref: *gobject.WeakRef) void;
pub const utilsWeakRefFree = camel_utils_weak_ref_free;

/// Allocates a new `gobject.WeakRef` and calls `gobject.WeakRef.set` with `object`.
///
/// Free the returned `gobject.WeakRef` with `camel.utilsWeakRefFree`.
extern fn camel_utils_weak_ref_new(p_object: ?*anyopaque) *gobject.WeakRef;
pub const utilsWeakRefNew = camel_utils_weak_ref_new;

/// Uudecodes a chunk of data. Performs a 'decode step' on a chunk of
/// uuencoded data. Assumes the "begin mode filename" line has
/// been stripped off.
extern fn camel_uudecode_step(p_in: [*]u8, p_inlen: usize, p_out: *[*]u8, p_state: *c_int, p_save: *[*]u32) usize;
pub const uudecodeStep = camel_uudecode_step;

/// Uuencodes a chunk of data. Call this when finished encoding data
/// with `camel.uuencodeStep` to flush off the last little bit.
extern fn camel_uuencode_close(p_in: [*]u8, p_len: usize, p_out: *[*]u8, p_uubuf: *[60]u8, p_state: *c_int, p_save: *[*]u32) usize;
pub const uuencodeClose = camel_uuencode_close;

/// Uuencodes a chunk of data. Performs an 'encode step', only encodes
/// blocks of 45 characters to the output at a time, saves left-over
/// state in `uubuf`, `state` and `save` (initialize to 0 on first
/// invocation).
extern fn camel_uuencode_step(p_in: [*]u8, p_len: usize, p_out: *[*]u8, p_uubuf: *[60]u8, p_state: *c_int, p_save: *[*]u32) usize;
pub const uuencodeStep = camel_uuencode_step;

/// Cancellable libc `write` replacement.
///
/// Code that intends to be portable to Win32 should call this function
/// only on file descriptors returned from `open`, not on sockets.
extern fn camel_write(p_fd: c_int, p_buf: [*:0]const u8, p_n: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
pub const write = camel_write;

/// Performs a 'decode step' on a chunk of yEncoded data of length
/// `inlen` pointed to by `in` and writes to `out`. Assumes the =ybegin
/// and =ypart lines have already been stripped off.
///
/// To get the crc32 value of the part, use `CAMEL_MIME_YENCODE_CRC_FINAL`
/// (`pcrc`). If there are more parts, you should reuse `crc` without
/// re-initializing. Once all parts have been decoded, you may get the
/// combined crc32 value of all the parts using `CAMEL_MIME_YENCODE_CRC_FINAL`
/// (`crc`).
extern fn camel_ydecode_step(p_in: [*]const u8, p_inlen: usize, p_out: *[*]u8, p_state: *c_int, p_pcrc: *u32, p_crc: *u32) usize;
pub const ydecodeStep = camel_ydecode_step;

/// Call this function when finished encoding data with
/// `camel.yencodeStep` to flush off the remaining state.
///
/// `CAMEL_MIME_YENCODE_CRC_FINAL` (`pcrc`) will give you the crc32 of the
/// encoded "part". If there are more "parts" to encode, you should
/// re-use `crc` when encoding the next "parts" and then use
/// `CAMEL_MIME_YENCODE_CRC_FINAL` (`crc`) to get the combined crc32 value of
/// all the parts.
extern fn camel_yencode_close(p_in: [*]const u8, p_inlen: usize, p_out: *[*]u8, p_state: *c_int, p_pcrc: *u32, p_crc: *u32) usize;
pub const yencodeClose = camel_yencode_close;

/// Performs an yEncode 'encode step' on a chunk of raw data of length
/// `inlen` pointed to by `in` and writes to `out`.
///
/// `state` should be initialized to `CAMEL_MIME_YENCODE_STATE_INIT` before
/// beginning making the first call to this function. Subsequent calls
/// should reuse `state`.
///
/// Along the same lines, `pcrc` and `crc` should be initialized to
/// `CAMEL_MIME_YENCODE_CRC_INIT` before using.
extern fn camel_yencode_step(p_in: [*]const u8, p_inlen: usize, p_out: *[*]u8, p_state: *c_int, p_pcrc: *u32, p_crc: *u32) usize;
pub const yencodeStep = camel_yencode_step;

pub const CipherCloneFunc = *const fn (p_value: ?*anyopaque) callconv(.c) ?*anyopaque;

pub const CopyFunc = *const fn (p_object: ?*const anyopaque) callconv(.c) ?*anyopaque;

/// A collation callback function.
pub const DBCollate = *const fn (p_enc: ?*anyopaque, p_length1: c_int, p_data1: ?*const anyopaque, p_length2: c_int, p_data2: ?*const anyopaque) callconv(.c) c_int;

/// A callback called for the SELECT statements. The items at the same index of `colvalues`
/// and `colnames` correspond to each other.
pub const DBSelectCB = *const fn (p_user_data: ?*anyopaque, p_ncol: c_int, p_colvalues: [*][*:0]u8, p_colnames: [*][*:0]u8) callconv(.c) c_int;

/// A callback called for each found file in the cache, used
/// by `camel.DataCache.foreachRemove`. The `filename` corresponds
/// to the result of `camel.DataCache.getFilename`.
pub const DataCacheRemoveFunc = *const fn (p_cdc: *camel.DataCache, p_filename: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

pub const FilterGetFolderFunc = *const fn (p_driver: *camel.FilterDriver, p_uri: [*:0]const u8, p_user_data: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) ?*camel.Folder;

pub const FilterPlaySoundFunc = *const fn (p_driver: *camel.FilterDriver, p_filename: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

pub const FilterSearchGetMessageFunc = *const fn (p_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*camel.MimeMessage;

pub const FilterShellFunc = *const fn (p_driver: *camel.FilterDriver, p_argc: c_int, p_argv: *[*:0]u8, p_user_data: ?*anyopaque) callconv(.c) void;

pub const FilterStatusFunc = *const fn (p_driver: *camel.FilterDriver, p_status: ?*anyopaque, p_pc: c_int, p_desc: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

pub const FilterSystemBeepFunc = *const fn (p_driver: *camel.FilterDriver, p_user_data: ?*anyopaque) callconv(.c) void;

/// A callback prototype for `camel.VeeDataCache.foreachMessageInfoData`
pub const ForeachInfoData = *const fn (p_mi_data: *camel.VeeMessageInfoData, p_subfolder: *camel.Folder, p_user_data: ?*anyopaque) callconv(.c) void;

/// Callback used to traverse parts of the `message` using `camel.MimeMessage.foreachPart`.
pub const ForeachPartFunc = *const fn (p_message: *camel.MimeMessage, p_part: *camel.MimePart, p_parent_part: ?*camel.MimePart, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A custom function to generate preview text for the content
/// of the `part`. The `part` can be either a `camel.MimePart` or
/// a `camel.Multipart`, depending in which context it is called.
///
/// The preview is supposed to be up to `CAMEL_MAX_PREVIEW_LENGTH`
/// characters long, in a plain text format.
pub const GeneratePreviewFunc = *const fn (p_part: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8;

pub const IndexNorm = *const fn (p_index: *camel.Index, p_word: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) [*:0]u8;

/// This is the callback signature for `camel.MessageContentInfo.traverse`.
pub const MessageContentInfoTraverseCallback = *const fn (p_ci: *camel.MessageContentInfo, p_depth: c_int, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Function used in `camel.Provider.autoDetect`.
pub const ProviderAutoDetectFunc = *const fn (p_url: *camel.URL, p_auto_detected: ?**glib.HashTable, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Callback type for function symbols used with `camel.SExp.addFunction`.
pub const SExpFunc = *const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: [*]*camel.SExpResult, p_user_data: ?*anyopaque) callconv(.c) *camel.SExpResult;

/// Callback type for function symbols used with `camel.SExp.addIfunction`.
pub const SExpIFunc = *const fn (p_sexp: *camel.SExp, p_argc: c_int, p_argv: [*]*camel.SExpTerm, p_user_data: ?*anyopaque) callconv(.c) *camel.SExpResult;

/// This is the callback signature for jobs submitted to the CamelSession
/// via `camel.Session.submitJob`.  The `error` pointer is always non-`NULL`,
/// so it's safe to dereference to check if a `glib.Error` has been set.
pub const SessionCallback = *const fn (p_session: *camel.Session, p_cancellable: ?*gio.Cancellable, p_user_data: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) void;

pub const TextIndexFunc = *const fn (p_idx: *camel.TextIndex, p_word: [*:0]const u8, p_buffer: [*:0]u8) callconv(.c) void;

pub const UrlScanFunc = *const fn (p_in: [*:0]const u8, p_pos: [*:0]const u8, p_inend: [*:0]const u8, p_match: *camel.UrlMatch) callconv(.c) c_int;

pub const AI_CANONNAME = 2;
pub const AI_NUMERICHOST = 4;
pub const BLOCK_SIZE = 1024;
pub const BLOCK_SIZE_BITS = 10;
/// Name of the photo-filename property which can be stored
/// on a `camel.CipherCertInfo`.
pub const CIPHER_CERT_INFO_PROPERTY_PHOTO_FILENAME = "photo-filename";
/// A string containing a list of email addresses of all signers
/// including their alternative emails. Use `camel.Address.unformat`
/// to break them back into separate addresses. This can be set
/// only on the first signer of the first validity, even the addresses
/// can belong to a different signer.
pub const CIPHER_CERT_INFO_PROPERTY_SIGNERS_ALT_EMAILS = "signers-alt-emails";
pub const DB_FILE = "folders.db";
pub const DB_FREE_CACHE_SIZE = 2097152;
pub const DB_IN_MEMORY_DB = "EVO_IN_meM_hAnDlE";
pub const DB_IN_MEMORY_TABLE = "EVO_IN_meM_hAnDlE.temp";
pub const DB_IN_MEMORY_TABLE_LIMIT = 100000;
pub const DB_SLEEP_INTERVAL = 100;
pub const DEBUG_IMAP = "imap";
pub const DEBUG_IMAP_FOLDER = "imap:folder";
pub const DOT_LOCK_REFRESH = 30;
pub const EAI_ADDRFAMILY = -9;
pub const EAI_AGAIN = -3;
pub const EAI_BADFLAGS = -1;
pub const EAI_FAIL = -4;
pub const EAI_FAMILY = -6;
pub const EAI_MEMORY = -10;
pub const EAI_NODATA = -5;
pub const EAI_NONAME = -2;
pub const EAI_OVERFLOW = -12;
pub const EAI_SERVICE = -8;
pub const EAI_SOCKTYPE = -7;
pub const EAI_SYSTEM = -11;
/// This environment variable configures where the camel
/// provider modules are loaded from.
pub const EDS_CAMEL_PROVIDER_DIR = "EDS_CAMEL_PROVIDER_DIR";
/// The folder type bitshift value.
pub const FOLDER_TYPE_BIT = 10;
/// The folder type mask value.
pub const FOLDER_TYPE_MASK = 64512;
pub const FOLD_MAX_SIZE = 998;
pub const FOLD_SIZE = 77;
pub const INDEX_DELETED = 1;
pub const KEY_TABLE_MAX_KEY = 128;
pub const LOCK_DELAY = 2;
pub const LOCK_DOT_DELAY = 2;
pub const LOCK_DOT_RETRY = 5;
pub const LOCK_DOT_STALE = 60;
pub const LOCK_RETRY = 5;
/// Maximum length, in characters, of a mime part preview.
pub const MAX_PREVIEW_LENGTH = 256;
pub const MESSAGE_DATE_CURRENT = -1;
pub const MESSAGE_SYSTEM_MASK = 4294901760;
pub const MIME_YDECODE_STATE_BEGIN = 4096;
pub const MIME_YDECODE_STATE_DECODE = 16384;
pub const MIME_YDECODE_STATE_END = 32768;
pub const MIME_YDECODE_STATE_EOLN = 256;
pub const MIME_YDECODE_STATE_ESCAPE = 512;
pub const MIME_YDECODE_STATE_INIT = 0;
pub const MIME_YDECODE_STATE_PART = 8192;
pub const MIME_YENCODE_CRC_INIT = -1;
pub const MIME_YENCODE_STATE_INIT = 0;
pub const NI_DGRAM = 16;
pub const NI_NAMEREQD = 8;
pub const NI_NOFQDN = 4;
pub const NI_NUMERICHOST = 1;
pub const NI_NUMERICSERV = 2;
pub const O_BINARY = 0;
pub const RECIPIENT_TYPE_BCC = "Bcc";
pub const RECIPIENT_TYPE_CC = "Cc";
pub const RECIPIENT_TYPE_RESENT_BCC = "Resent-Bcc";
pub const RECIPIENT_TYPE_RESENT_CC = "Resent-Cc";
pub const RECIPIENT_TYPE_RESENT_TO = "Resent-To";
pub const RECIPIENT_TYPE_TO = "To";
/// Can be used with `camel.Session.addressbookContainsSync` as the book UID,
/// meaning to check in all configured address books.
pub const SESSION_BOOK_UID_ANY = "*any";
/// Can be used with `camel.Session.addressbookContainsSync` as the book UID,
/// meaning to check in all address books enabled for auto-completion.
pub const SESSION_BOOK_UID_COMPLETION = "*completion";
/// The folder store info type bitshift value.
pub const STORE_INFO_FOLDER_TYPE_BIT = 10;
/// The folder store info type mask value.
pub const STORE_INFO_FOLDER_TYPE_MASK = 64512;
pub const STORE_INFO_FOLDER_UNKNOWN = -1;
pub const STORE_SETUP_ARCHIVE_FOLDER = "Account:Mail Account:archive-folder:f";
pub const STORE_SETUP_DRAFTS_FOLDER = "Submission:Mail Composition:drafts-folder:f";
pub const STORE_SETUP_SENT_FOLDER = "Submission:Mail Submission:sent-folder:f";
pub const STORE_SETUP_TEMPLATES_FOLDER = "Submission:Mail Composition:templates-folder:f";
pub const UNMATCHED_NAME = "UNMATCHED";
pub const URL_HIDE_ALL = 3;
pub const URL_PART_AUTH = 2;
pub const URL_PART_HIDDEN = 8;
pub const URL_PART_HOST = 8;
pub const URL_PART_NEED = 8;
pub const URL_PART_PASSWORD = 4;
pub const URL_PART_PATH = 32;
pub const URL_PART_PATH_DIR = 64;
pub const URL_PART_PORT = 16;
pub const URL_PART_USER = 1;
pub const UTILS_MAX_USER_HEADERS = 3;
pub const UUDECODE_STATE_MASK = 196608;
pub const VJUNK_NAME = ".#evolution/Junk";
pub const VTRASH_NAME = ".#evolution/Trash";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
