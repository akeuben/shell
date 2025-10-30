pub const ext = @import("ext.zig");
const edatabook = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const edataserver = @import("edataserver1");
const libxml2 = @import("libxml22");
const soup = @import("soup3");
const json = @import("json1");
const camel = @import("camel1");
const ebookcontacts = @import("ebookcontacts1");
const ebackend = @import("ebackend1");
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BookBackend = extern struct {
    pub const Parent = ebackend.Backend;
    pub const Implements = [_]type{};
    pub const Class = edatabook.BookBackendClass;
    f_parent: ebackend.Backend,
    f_priv: ?*edatabook.BookBackendPrivate,

    pub const virtual_methods = struct {
        /// A signal notifying that the backend was closed
        pub const closed = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sender: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_closed.?(gobject.ext.as(BookBackend, p_backend), p_sender);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sender: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_closed = @ptrCast(p_implementation);
            }
        };

        /// For addressbook backends which support Direct Read Access, configure a
        ///                    backend instantiated on the client side for Direct Read Access, using data
        ///                    reported from the server via the `get_direct_book` method.
        pub const impl_configure_direct = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_config: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_configure_direct.?(gobject.ext.as(BookBackend, p_backend), p_config);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_config: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_configure_direct = @ptrCast(p_implementation);
            }
        };

        /// Checkes whether the backend contains an email address
        pub const impl_contains_email = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_email_address: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_contains_email.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_email_address);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_email_address: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_contains_email = @ptrCast(p_implementation);
            }
        };

        /// Add and store the passed vcards
        pub const impl_create_contacts = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_create_contacts.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_vcards, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_create_contacts = @ptrCast(p_implementation);
            }
        };

        /// Create an `edatabook.DataBookCursor`
        pub const impl_create_cursor = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sort_fields: *ebookcontacts.ContactField, p_sort_types: *ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.DataBookCursor {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_create_cursor.?(gobject.ext.as(BookBackend, p_backend), p_sort_fields, p_sort_types, p_n_fields, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sort_fields: *ebookcontacts.ContactField, p_sort_types: *ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) callconv(.c) ?*edatabook.DataBookCursor) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_create_cursor = @ptrCast(p_implementation);
            }
        };

        /// Delete an `edatabook.DataBookCursor` previously created by this backend
        pub const impl_delete_cursor = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cursor: *edatabook.DataBookCursor, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_delete_cursor.?(gobject.ext.as(BookBackend, p_backend), p_cursor, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cursor: *edatabook.DataBookCursor, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_delete_cursor = @ptrCast(p_implementation);
            }
        };

        /// Return the currently set locale setting (must be a string duplicate, for thread safety).
        pub const impl_dup_locale = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_locale.?(gobject.ext.as(BookBackend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_locale = @ptrCast(p_implementation);
            }
        };

        /// returns contacts in the given range of the sorted "manual query" view; default
        ///    implementation tracks view's connect and returns the contacts accordingly. Since: 3.50
        pub const impl_dup_view_contacts = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize, p_range_start: c_uint, p_range_length: c_uint) *glib.PtrArray {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_view_contacts.?(gobject.ext.as(BookBackend, p_backend), p_view_id, p_range_start, p_range_length);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize, p_range_start: c_uint, p_range_length: c_uint) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_view_contacts = @ptrCast(p_implementation);
            }
        };

        /// retrieve indexes into an alphabet for contacts in the "manual query" view; default
        ///    implementation returns value set by `edatabook.BookBackend.setViewIndices`. Since: 3.50
        pub const impl_dup_view_indices = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize) *ebookcontacts.BookIndices {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_view_indices.?(gobject.ext.as(BookBackend, p_backend), p_view_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize) callconv(.c) *ebookcontacts.BookIndices) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_dup_view_indices = @ptrCast(p_implementation);
            }
        };

        /// Fetch a property value by name from the backend
        pub const impl_get_backend_property = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8) [*:0]u8 {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_backend_property.?(gobject.ext.as(BookBackend, p_backend), p_prop_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8) callconv(.c) [*:0]u8) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_backend_property = @ptrCast(p_implementation);
            }
        };

        /// Fetch a contact by UID
        pub const impl_get_contact = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_id: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_id: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact = @ptrCast(p_implementation);
            }
        };

        /// Fetch a list of contacts based on a search expression
        pub const impl_get_contact_list = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact_list.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_query);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact_list = @ptrCast(p_implementation);
            }
        };

        /// Fetch a list of contact UIDs based on a search expression
        pub const impl_get_contact_list_uids = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact_list_uids.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_query);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_contact_list_uids = @ptrCast(p_implementation);
            }
        };

        /// For addressbook backends which support Direct Read Access,
        ///                   report some information on how to access the addressbook persistance directly
        pub const impl_get_direct_book = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *edatabook.DataBookDirect {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_direct_book.?(gobject.ext.as(BookBackend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *edatabook.DataBookDirect) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_direct_book = @ptrCast(p_implementation);
            }
        };

        /// retrieve how many contacts a "manual query" view has; default implementation
        ///    returns value set by `edatabook.BookBackend.setViewNTotal`. Since: 3.50
        pub const impl_get_view_n_total = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize) c_uint {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_get_view_n_total.?(gobject.ext.as(BookBackend, p_backend), p_view_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize) callconv(.c) c_uint) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_get_view_n_total = @ptrCast(p_implementation);
            }
        };

        /// Modify the existing contacts using the passed vcards
        pub const impl_modify_contacts = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_modify_contacts.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_vcards, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_modify_contacts = @ptrCast(p_implementation);
            }
        };

        /// Notify changes which might have occured for a given contact
        pub const impl_notify_update = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *const ebookcontacts.Contact) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_notify_update.?(gobject.ext.as(BookBackend, p_backend), p_contact);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *const ebookcontacts.Contact) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_notify_update = @ptrCast(p_implementation);
            }
        };

        /// Open the backend
        pub const impl_open = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_open.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_open = @ptrCast(p_implementation);
            }
        };

        /// Refresh the backend
        pub const impl_refresh = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_refresh.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_refresh = @ptrCast(p_implementation);
            }
        };

        /// Remove the contacts specified by the passed UIDs
        pub const impl_remove_contacts = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uids: *const [*:0]const u8, p_opflags: u32) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_remove_contacts.?(gobject.ext.as(BookBackend, p_backend), p_book, p_opid, p_cancellable, p_uids, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uids: *const [*:0]const u8, p_opflags: u32) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_remove_contacts = @ptrCast(p_implementation);
            }
        };

        /// Store & remember the passed locale setting
        pub const impl_set_locale = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_set_locale.?(gobject.ext.as(BookBackend, p_backend), p_locale, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_set_locale = @ptrCast(p_implementation);
            }
        };

        /// sets sort fields for "manual query" views; default implementation saves
        ///    the values into internal structures, which can be read back with `edatabook.BookBackend.dupViewSortFields`. Since 3.50
        pub const impl_set_view_sort_fields = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize, p_fields: *const ebookcontacts.BookClientViewSortFields) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_set_view_sort_fields.?(gobject.ext.as(BookBackend, p_backend), p_view_id, p_fields);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view_id: usize, p_fields: *const ebookcontacts.BookClientViewSortFields) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_set_view_sort_fields = @ptrCast(p_implementation);
            }
        };

        /// Start up the specified view
        pub const impl_start_view = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatabook.DataBookView) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_start_view.?(gobject.ext.as(BookBackend, p_backend), p_view);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatabook.DataBookView) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_start_view = @ptrCast(p_implementation);
            }
        };

        /// Stop the specified view
        pub const impl_stop_view = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatabook.DataBookView) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_impl_stop_view.?(gobject.ext.as(BookBackend, p_backend), p_view);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatabook.DataBookView) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_impl_stop_view = @ptrCast(p_implementation);
            }
        };

        /// A signal notifying that the backend is being shut down
        pub const shutdown = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(BookBackend.Class, p_class).f_shutdown.?(gobject.ext.as(BookBackend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(BookBackend.Class, p_class).f_shutdown = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const cache_dir = struct {
            pub const name = "cache-dir";

            pub const Type = ?[*:0]u8;
        };

        pub const proxy_resolver = struct {
            pub const name = "proxy-resolver";

            pub const Type = ?*gio.ProxyResolver;
        };

        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };

        pub const writable = struct {
            pub const name = "writable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when a client destroys its `EBookClient` for `backend`.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_sender: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookBackend, p_instance))),
                    gobject.signalLookup("closed", BookBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the last client destroys its `EBookClient` for
        /// `backend`.  This signals the `backend` to begin final cleanup
        /// tasks such as synchronizing data to permanent storage.
        pub const shutdown = struct {
            pub const name = "shutdown";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookBackend, p_instance))),
                    gobject.signalLookup("shutdown", BookBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Adds `view` to `backend` for querying.
    extern fn e_book_backend_add_view(p_backend: *BookBackend, p_view: *edatabook.DataBookView) void;
    pub const addView = e_book_backend_add_view;

    /// This method is called on `backend` in direct read access mode.
    /// The `config` argument is the same configuration string which
    /// the same backend reported in the `edatabook.DataBookDirect` returned
    /// by `edatabook.BookBackend.getDirectBook`.
    ///
    /// The configuration string is optional and is used to ensure
    /// that direct access backends are properly configured to
    /// interface with the same data as the running server side backend.
    extern fn e_book_backend_configure_direct(p_backend: *BookBackend, p_config: [*:0]const u8) void;
    pub const configureDirect = e_book_backend_configure_direct;

    /// Asynchronously checks whether contains an `email_address`. When the `email_address`
    /// contains multiple addresses, then returns `TRUE` when at least one
    /// address exists in the address book.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.containsEmailFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_contains_email(p_backend: *BookBackend, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const containsEmail = e_book_backend_contains_email;

    /// Finishes the operation started with `edatabook.BookBackend.containsEmail`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_contains_email_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const containsEmailFinish = e_book_backend_contains_email_finish;

    /// Checks whether contains an `email_address`. When the `email_address`
    /// contains multiple addresses, then returns `TRUE` when at least one
    /// address exists in the address book.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_contains_email_sync(p_backend: *BookBackend, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const containsEmailSync = e_book_backend_contains_email_sync;

    /// Asynchronously creates one or more new contacts from `vcards`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.createContactsFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_create_contacts(p_backend: *BookBackend, p_vcards: *const [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createContacts = e_book_backend_create_contacts;

    /// Finishes the operation started with `edatabook.BookBackend.createContacts`.
    ///
    /// An `ebookcontacts.Contact` instance for each newly-created contact is deposited in
    /// `out_contacts`.  The returned `ebookcontacts.Contact` instances are referenced for
    /// thread-safety and must be unreferenced with `gobject.Object.unref` when
    /// finished with them.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_create_contacts_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_out_contacts: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const createContactsFinish = e_book_backend_create_contacts_finish;

    /// Creates one or more new contacts from `vcards`, and deposits an `ebookcontacts.Contact`
    /// instance for each newly-created contact in `out_contacts`.
    ///
    /// The returned `ebookcontacts.Contact` instances are referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_create_contacts_sync(p_backend: *BookBackend, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createContactsSync = e_book_backend_create_contacts_sync;

    /// Creates a new `edatabook.DataBookCursor` for the given backend if the backend
    /// has cursor support. If the backend does not support cursors then
    /// an `E_CLIENT_ERROR_NOT_SUPPORTED` error will be set in `error`.
    ///
    /// Backends can also refuse to create cursors for some values of `sort_fields`
    /// and report more specific errors.
    ///
    /// The returned cursor belongs to `backend` and should be destroyed
    /// with `edatabook.BookBackend.deleteCursor` when no longer needed.
    extern fn e_book_backend_create_cursor(p_backend: *BookBackend, p_sort_fields: *ebookcontacts.ContactField, p_sort_types: *ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.DataBookCursor;
    pub const createCursor = e_book_backend_create_cursor;

    /// Requests `backend` to release and destroy `cursor`, this
    /// will trigger an `E_CLIENT_ERROR_INVALID_ARG` error if `cursor`
    /// is not owned by `backend`.
    extern fn e_book_backend_delete_cursor(p_backend: *BookBackend, p_cursor: *edatabook.DataBookCursor, p_error: ?*?*glib.Error) c_int;
    pub const deleteCursor = e_book_backend_delete_cursor;

    /// Thread-safe variation of `edatabook.BookBackend.getCacheDir`.
    /// Use this function when accessing `backend` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_book_backend_dup_cache_dir(p_backend: *BookBackend) [*:0]u8;
    pub const dupCacheDir = e_book_backend_dup_cache_dir;

    /// Fetches a copy of the currently configured locale for the addressbook
    extern fn e_book_backend_dup_locale(p_backend: *BookBackend) [*:0]u8;
    pub const dupLocale = e_book_backend_dup_locale;

    /// Returns `range_length` contacts from 0-based index `range_start`
    /// in the view identified by the `view_id`.
    /// When there are asked more than `edatabook.BookBackend.getViewNTotal`
    /// contacts only those up to the total number of contacts are read.
    /// Asking for out of range contacts results in an error, though
    /// it can return less than `range_length` contacts.
    ///
    /// The default implementation tracks the view's content in memory
    /// and returns the contacts as needed. The subclasses can do more
    /// efficient implementation.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_dup_view_contacts(p_backend: *BookBackend, p_view_id: usize, p_range_start: c_uint, p_range_length: c_uint) ?*glib.PtrArray;
    pub const dupViewContacts = e_book_backend_dup_view_contacts;

    /// Returns a list of `ebookcontacts.BookIndices` holding indices of the contacts
    /// in the view identified by `view_id`. The array is terminated by an item
    /// with chr member being `NULL`.
    ///
    /// The default implementation returns an array previously set
    /// by `edatabook.BookBackend.setViewIndices`.
    ///
    /// Free the returned array with `ebookcontacts.BookIndices.free`, when no longer needed.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_dup_view_indices(p_backend: *BookBackend, p_view_id: usize) ?*ebookcontacts.BookIndices;
    pub const dupViewIndices = e_book_backend_dup_view_indices;

    /// Returns currently used sort fields for manual query views. The returned
    /// array is NULL only if the view could not be found. The default sort is
    /// by the file-as filed in ascending order.
    ///
    /// The array is terminated by an item with an `E_CONTACT_FIELD_LAST` field.
    ///
    /// Free the returned array with `ebookcontacts.BookClientViewSortFields.free`,
    /// when no longer needed.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_dup_view_sort_fields(p_backend: *BookBackend, p_view_id: usize) *ebookcontacts.BookClientViewSortFields;
    pub const dupViewSortFields = e_book_backend_dup_view_sort_fields;

    /// Calls `func` for each existing view (as returned by `edatabook.BookBackend.listViews`).
    /// The `func` can return `FALSE` to stop early.
    extern fn e_book_backend_foreach_view(p_backend: *BookBackend, p_func: edatabook.BookBackendForeachViewFunc, p_user_data: ?*anyopaque) c_int;
    pub const foreachView = e_book_backend_foreach_view;

    /// Notifies each view of the `backend` about progress. When `only_completed_views`
    /// is `TRUE`, notifies only completed views.
    extern fn e_book_backend_foreach_view_notify_progress(p_backend: *BookBackend, p_only_completed_views: c_int, p_percent: c_int, p_message: ?[*:0]const u8) void;
    pub const foreachViewNotifyProgress = e_book_backend_foreach_view_notify_progress;

    /// Obtains the value of the backend property named `prop_name`.
    /// Freed the returned string with `glib.free` when finished with it.
    extern fn e_book_backend_get_backend_property(p_backend: *BookBackend, p_prop_name: [*:0]const u8) [*:0]u8;
    pub const getBackendProperty = e_book_backend_get_backend_property;

    /// Returns the cache directory path used by `backend`.
    extern fn e_book_backend_get_cache_dir(p_backend: *BookBackend) [*:0]const u8;
    pub const getCacheDir = e_book_backend_get_cache_dir;

    /// Asynchronously obtains an `ebookcontacts.Contact` for `uid`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edatabook.BookBackend.getContactFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_get_contact(p_backend: *BookBackend, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContact = e_book_backend_get_contact;

    /// Finishes the operation started with `edatabook.BookBackend.getContactFinish`.
    ///
    /// The returned `ebookcontacts.Contact` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// If an error occurred, the function will set `error` and return `NULL`.
    extern fn e_book_backend_get_contact_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*ebookcontacts.Contact;
    pub const getContactFinish = e_book_backend_get_contact_finish;

    /// Asynchronously obtains a set of `ebookcontacts.Contact` instances which satisfy the
    /// criteria specified in `query`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.getContactListFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_get_contact_list(p_backend: *BookBackend, p_query: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContactList = e_book_backend_get_contact_list;

    /// Finishes the operation started with `edatabook.BookBackend.getContactList`.
    ///
    /// The matching `ebookcontacts.Contact` instances are deposited in `out_contacts`.  The
    /// returned `ebookcontacts.Contact` instances are referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with them.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_get_contact_list_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_out_contacts: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const getContactListFinish = e_book_backend_get_contact_list_finish;

    /// Obtains a set of `ebookcontacts.Contact` instances which satisfy the criteria specified
    /// in `query`, and deposits them in `out_contacts`.
    ///
    /// The returned `ebookcontacts.Contact` instances are referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_get_contact_list_sync(p_backend: *BookBackend, p_query: [*:0]const u8, p_out_contacts: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactListSync = e_book_backend_get_contact_list_sync;

    /// Asynchronously obtains a set of ID strings for contacts which satisfy
    /// the criteria specified in `query`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.getContactListUidsFinish` to get the result of
    /// the operation.
    extern fn e_book_backend_get_contact_list_uids(p_backend: *BookBackend, p_query: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContactListUids = e_book_backend_get_contact_list_uids;

    /// Finishes the operation started with
    /// `edatabook.BookBackend.getContactListUidsFinish`.
    ///
    /// ID strings for the matching contacts are deposited in `out_uids`, and
    /// must be freed with `glib.free` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_get_contact_list_uids_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_out_uids: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const getContactListUidsFinish = e_book_backend_get_contact_list_uids_finish;

    /// Obtains a set of ID strings for contacts which satisfy the criteria
    /// specified in `query`, and deposits them in `out_uids`.
    ///
    /// The returned ID strings must be freed with `glib.free` with finished
    /// with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_get_contact_list_uids_sync(p_backend: *BookBackend, p_query: [*:0]const u8, p_out_uids: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactListUidsSync = e_book_backend_get_contact_list_uids_sync;

    /// Obtains an `ebookcontacts.Contact` for `uid`.
    ///
    /// The returned `ebookcontacts.Contact` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_book_backend_get_contact_sync(p_backend: *BookBackend, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebookcontacts.Contact;
    pub const getContactSync = e_book_backend_get_contact_sync;

    /// Tries to create an `edatabook.DataBookDirect` for `backend` if
    /// backend supports direct read access.
    extern fn e_book_backend_get_direct_book(p_backend: *BookBackend) ?*edatabook.DataBookDirect;
    pub const getDirectBook = e_book_backend_get_direct_book;

    /// Returns the data source registry to which `ebackend.Backend.properties.source` belongs.
    extern fn e_book_backend_get_registry(p_backend: *BookBackend) *edataserver.SourceRegistry;
    pub const getRegistry = e_book_backend_get_registry;

    /// Returns how many contacts the view identified by `view_id`
    /// contains.
    ///
    /// The default implementation of this virtual method returns
    /// the value previously set by `edatabook.BookBackend.setViewNTotal`.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_get_view_n_total(p_backend: *BookBackend, p_view_id: usize) c_uint;
    pub const getViewNTotal = e_book_backend_get_view_n_total;

    /// Returns whether `backend` will accept changes to its data content.
    extern fn e_book_backend_get_writable(p_backend: *BookBackend) c_int;
    pub const getWritable = e_book_backend_get_writable;

    /// Checks if `backend`'s storage has been opened (and
    /// authenticated, if necessary) and the backend itself
    /// is ready for accessing. This property is changed automatically
    /// after the `backend` is successfully opened.
    extern fn e_book_backend_is_opened(p_backend: *BookBackend) c_int;
    pub const isOpened = e_book_backend_is_opened;

    /// Checks if we can write to `backend`.
    extern fn e_book_backend_is_readonly(p_backend: *BookBackend) c_int;
    pub const isReadonly = e_book_backend_is_readonly;

    /// Returns a list of `edatabook.DataBookView` instances added with
    /// `edatabook.BookBackend.addView`.
    ///
    /// The views returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned list itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_book_backend_list_views(p_backend: *BookBackend) *glib.List;
    pub const listViews = e_book_backend_list_views;

    /// Asynchronously modifies one or more contacts according to `vcards`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.modifyContactsFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_modify_contacts(p_backend: *BookBackend, p_vcards: *const [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyContacts = e_book_backend_modify_contacts;

    /// Finishes the operation started with `edatabook.BookBackend.modifyContacts`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_modify_contacts_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactsFinish = e_book_backend_modify_contacts_finish;

    /// Modifies one or more contacts according to `vcards`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_modify_contacts_sync(p_backend: *BookBackend, p_vcards: *const [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactsSync = e_book_backend_modify_contacts_sync;

    /// Notifies all of `backend`'s book views that the current set of
    /// notifications is complete; use this after a series of
    /// `edatabook.BookBackend.notifyUpdate` and `edatabook.BookBackend.notifyRemove` calls.
    extern fn e_book_backend_notify_complete(p_backend: *BookBackend) void;
    pub const notifyComplete = e_book_backend_notify_complete;

    /// Notifies each backend listener about an error. This is meant to be used
    /// for cases where is no GError return possibility, to notify user about
    /// an issue.
    extern fn e_book_backend_notify_error(p_backend: *BookBackend, p_message: [*:0]const u8) void;
    pub const notifyError = e_book_backend_notify_error;

    /// Notifies clients about property value change.
    extern fn e_book_backend_notify_property_changed(p_backend: *BookBackend, p_prop_name: [*:0]const u8, p_prop_value: ?[*:0]const u8) void;
    pub const notifyPropertyChanged = e_book_backend_notify_property_changed;

    /// Notifies all of `backend`'s book views that the contact with UID
    /// `id` has been removed.
    ///
    /// `edatabook.DataBook.respondRemoveContacts` calls this function for you. You
    /// only need to call this from your backend if contacts are removed by
    /// another (non-PAS-using) client.
    extern fn e_book_backend_notify_remove(p_backend: *BookBackend, p_id: [*:0]const u8) void;
    pub const notifyRemove = e_book_backend_notify_remove;

    /// Notifies all of `backend`'s book views about the new or modified
    /// contacts `contact`.
    ///
    /// `edatabook.DataBook.respondCreateContacts` and `edatabook.DataBook.respondModifyContacts` call this
    /// function for you. You only need to call this from your backend if
    /// contacts are created or modified by another (non-PAS-using) client.
    extern fn e_book_backend_notify_update(p_backend: *BookBackend, p_contact: *const ebookcontacts.Contact) void;
    pub const notifyUpdate = e_book_backend_notify_update;

    /// Asynchronously "opens" the `backend`.  Opening a backend is something of
    /// an outdated concept, but the operation is hanging around for a little
    /// while longer.  This usually involves some custom initialization logic,
    /// and testing of remote authentication if applicable.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.openFinish` to get the result of the operation.
    extern fn e_book_backend_open(p_backend: *BookBackend, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const open = e_book_backend_open;

    /// Finishes the operation started with `edatabook.BookBackend.open`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_open_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const openFinish = e_book_backend_open_finish;

    /// "Opens" the `backend`.  Opening a backend is something of an outdated
    /// concept, but the operation is hanging around for a little while longer.
    /// This usually involves some custom initialization logic, and testing of
    /// remote authentication if applicable.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_open_sync(p_backend: *BookBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const openSync = e_book_backend_open_sync;

    /// Obtains the `gio.Task` for `opid`.
    ///
    /// <note>
    ///   <para>
    ///     This is a temporary function to serve `edatabook.DataBook`'s "respond"
    ///     functions until they can be removed.  Nothing else should be
    ///     calling this function.
    ///   </para>
    /// </note>
    extern fn e_book_backend_prepare_for_completion(p_backend: *BookBackend, p_opid: u32) *gio.Task;
    pub const prepareForCompletion = e_book_backend_prepare_for_completion;

    /// Returns the `edatabook.DataBook` for `backend`.  The `edatabook.DataBook` is essentially
    /// the glue between incoming D-Bus requests and `backend`'s native API.
    ///
    /// An `edatabook.DataBook` should be set only once after `backend` is first created.
    /// If an `edatabook.DataBook` has not yet been set, the function returns `NULL`.
    ///
    /// The returned `edatabook.DataBook` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_book_backend_ref_data_book(p_backend: *BookBackend) ?*edatabook.DataBook;
    pub const refDataBook = e_book_backend_ref_data_book;

    /// Returns the `gio.ProxyResolver` for `backend` (if applicable), as indicated
    /// by the `edataserver.SourceAuthentication.properties.proxy`-uid of `backend`'s `ebackend.Backend.properties.source`
    /// or one of its ancestors.
    ///
    /// The returned `gio.ProxyResolver` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_book_backend_ref_proxy_resolver(p_backend: *BookBackend) ?*gio.ProxyResolver;
    pub const refProxyResolver = e_book_backend_ref_proxy_resolver;

    /// References an `edatabook.DataBookView` by its identifier.
    ///
    /// Unref the returned non-NULL view with `gobject.Object.unref`,
    /// when no longer needed.
    extern fn e_book_backend_ref_view(p_backend: *BookBackend, p_view_id: usize) ?*edatabook.DataBookView;
    pub const refView = e_book_backend_ref_view;

    /// References user data previously set by `edatabook.BookBackend.takeViewUserData`
    /// for the `view_id`.
    ///
    /// Free the returned non-NULL object with `gobject.Object.unref`,
    /// when no longer needed.
    extern fn e_book_backend_ref_view_user_data(p_backend: *BookBackend, p_view_id: usize) *gobject.Object;
    pub const refViewUserData = e_book_backend_ref_view_user_data;

    /// Asynchronously initiates a refresh for `backend`, if the `backend` supports
    /// refreshing.  The actual refresh operation completes on its own time.  This
    /// function, along with `edatabook.BookBackend.refreshFinish`, merely initiates the
    /// operation.
    ///
    /// Once the refresh is initiated, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.refreshFinish` to get the result of the initiation.
    extern fn e_book_backend_refresh(p_backend: *BookBackend, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refresh = e_book_backend_refresh;

    /// Finishes the refresh initiation started with `edatabook.BookBackend.refresh`.
    ///
    /// If an error occurred while initiating the refresh, the function will set
    /// `error` and return `FALSE`.  If the `backend` does not support refreshing,
    /// the function will set an `E_CLIENT_ERROR_NOT_SUPPORTED` error and return
    /// `FALSE`.
    extern fn e_book_backend_refresh_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshFinish = e_book_backend_refresh_finish;

    /// Initiates a refresh for `backend`, if the `backend` supports refreshing.
    /// The actual refresh operation completes on its own time.  This function
    /// merely initiates the operation.
    ///
    /// If an error occurs while initiating the refresh, the function will set
    /// `error` and return `FALSE`.  If the `backend` does not support refreshing,
    /// the function will set an `E_CLIENT_ERROR_NOT_SUPPORTED` error and return
    /// `FALSE`.
    extern fn e_book_backend_refresh_sync(p_backend: *BookBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshSync = e_book_backend_refresh_sync;

    /// Asynchronously removes one or more contacts according to `uids`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatabook.BookBackend.removeContactsFinish` to get the result of the
    /// operation.
    extern fn e_book_backend_remove_contacts(p_backend: *BookBackend, p_uids: [*]const [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeContacts = e_book_backend_remove_contacts;

    /// Finishes the operation started with `edatabook.BookBackend.removeContacts`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_remove_contacts_finish(p_backend: *BookBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeContactsFinish = e_book_backend_remove_contacts_finish;

    /// Removes one or more contacts according to `uids`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_remove_contacts_sync(p_backend: *BookBackend, p_uids: *const [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContactsSync = e_book_backend_remove_contacts_sync;

    /// Removes `view` from `backend`.
    extern fn e_book_backend_remove_view(p_backend: *BookBackend, p_view: *edatabook.DataBookView) void;
    pub const removeView = e_book_backend_remove_view;

    /// Schedules user function `func` to be run in a dedicated thread as
    /// a blocking operation.
    ///
    /// The function adds its own reference to `use_cancellable`, if not `NULL`.
    ///
    /// The error returned from `func` is propagated to client using
    /// `edatabook.BookBackend.notifyError` function. If it's not desired,
    /// then left the error unchanged and notify about errors manually.
    extern fn e_book_backend_schedule_custom_operation(p_book_backend: *BookBackend, p_use_cancellable: ?*gio.Cancellable, p_func: edatabook.BookBackendCustomOpFunc, p_user_data: ?*anyopaque, p_user_data_free: ?glib.DestroyNotify) void;
    pub const scheduleCustomOperation = e_book_backend_schedule_custom_operation;

    /// Sets the cache directory path for use by `backend`.
    ///
    /// Note that `edatabook.BookBackend` is initialized with a default cache directory
    /// path which should suffice for most cases.  Backends should not override
    /// the default path without good reason.
    extern fn e_book_backend_set_cache_dir(p_backend: *BookBackend, p_cache_dir: [*:0]const u8) void;
    pub const setCacheDir = e_book_backend_set_cache_dir;

    /// Sets the `edatabook.DataBook` for `backend`.  The `edatabook.DataBook` is essentially the
    /// glue between incoming D-Bus requests and `backend`'s native API.
    ///
    /// An `edatabook.DataBook` should be set only once after `backend` is first created.
    extern fn e_book_backend_set_data_book(p_backend: *BookBackend, p_data_book: *edatabook.DataBook) void;
    pub const setDataBook = e_book_backend_set_data_book;

    /// Notify the addressbook backend that the current locale has
    /// changed, this is important for backends which support
    /// ordered result lists which are locale sensitive.
    extern fn e_book_backend_set_locale(p_backend: *BookBackend, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setLocale = e_book_backend_set_locale;

    /// Stores current `indices` for the view identified by the `view_id` and,
    /// if such exists, notifies about it also the corresponding `edatabook.DataBookView`.
    /// The array is terminated by an item with chr member being `NULL`.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_set_view_indices(p_backend: *BookBackend, p_view_id: usize, p_indices: ?*const ebookcontacts.BookIndices) void;
    pub const setViewIndices = e_book_backend_set_view_indices;

    /// Stores how many contacts the view identified by `view_id`
    /// contains. It also sets the `n_total` to the corresponding
    /// `edatabook.DataBookView`, if such exists. The function does nothing
    /// when the view cannot be found.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_set_view_n_total(p_backend: *BookBackend, p_view_id: usize, p_n_total: c_uint) void;
    pub const setViewNTotal = e_book_backend_set_view_n_total;

    /// Sets the sort fields for the view identified by the `view_id`.
    /// The `fields` array should be terminated by an item, which has
    /// the field member set to `E_CONTACT_FIELD_LAST`.
    ///
    /// When the `fields` is `NULL`, the sort by file-as in ascending order
    /// is used instead.
    ///
    /// The default implementation of this virtual method stores
    /// the `fields` into the internal structure for the `backend`,
    /// to be available by `edatabook.BookBackend.dupViewSortFields`.
    ///
    /// Note: This function should be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` views.
    extern fn e_book_backend_set_view_sort_fields(p_backend: *BookBackend, p_view_id: usize, p_fields: ?*const ebookcontacts.BookClientViewSortFields) void;
    pub const setViewSortFields = e_book_backend_set_view_sort_fields;

    /// Sets whether `backend` will accept changes to its data content.
    extern fn e_book_backend_set_writable(p_backend: *BookBackend, p_writable: c_int) void;
    pub const setWritable = e_book_backend_set_writable;

    /// Starts running the query specified by `view`, emitting signals for
    /// matching contacts.
    extern fn e_book_backend_start_view(p_backend: *BookBackend, p_view: *edatabook.DataBookView) void;
    pub const startView = e_book_backend_start_view;

    /// Stops running the query specified by `view`, emitting no more signals.
    extern fn e_book_backend_stop_view(p_backend: *BookBackend, p_view: *edatabook.DataBookView) void;
    pub const stopView = e_book_backend_stop_view;

    extern fn e_book_backend_sync(p_backend: *BookBackend) void;
    pub const sync = e_book_backend_sync;

    /// Sets the user data for the `view_id`. The function assumes ownership
    /// of the `user_data`. The `user_data` can be `NULL`, which unsets
    /// the current user data for the view.
    ///
    /// This is primarily aimed as a helper for backend implementations
    /// of the manual query views (`E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`).
    extern fn e_book_backend_take_view_user_data(p_backend: *BookBackend, p_view_id: usize, p_user_data: ?*gobject.Object) void;
    pub const takeViewUserData = e_book_backend_take_view_user_data;

    extern fn e_book_backend_get_type() usize;
    pub const getGObjectType = e_book_backend_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BookBackendFactory = extern struct {
    pub const Parent = ebackend.BackendFactory;
    pub const Implements = [_]type{};
    pub const Class = edatabook.BookBackendFactoryClass;
    f_parent: ebackend.BackendFactory,
    f_priv: ?*edatabook.BookBackendFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_book_backend_factory_get_type() usize;
    pub const getGObjectType = e_book_backend_factory_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookBackendFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookBackendFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookBackendFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendSExp = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatabook.BookBackendSExpClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.BookBackendSExpPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// A utility function, which compares only numbers from the `phone_value` with `lookup_value`
    /// using `compare_kind` method.
    extern fn e_book_backend_sexp_util_phone_compare(p_phone_value: [*:0]const u8, p_lookup_value: [*:0]const u8, p_compare_kind: edatabook.BookBackendSexpCompareKind) c_int;
    pub const utilPhoneCompare = e_book_backend_sexp_util_phone_compare;

    /// Creates a new `edatabook.BookBackendSExp` from `text`.
    extern fn e_book_backend_sexp_new(p_text: [*:0]const u8) *edatabook.BookBackendSExp;
    pub const new = e_book_backend_sexp_new;

    /// Locks the `sexp`. Other threads cannot use it until
    /// it's unlocked with `edatabook.BookBackendSExp.unlock`.
    extern fn e_book_backend_sexp_lock(p_sexp: *BookBackendSExp) void;
    pub const lock = e_book_backend_sexp_lock;

    /// Checks if `contact` matches `sexp`.
    extern fn e_book_backend_sexp_match_contact(p_sexp: *BookBackendSExp, p_contact: *ebookcontacts.Contact) c_int;
    pub const matchContact = e_book_backend_sexp_match_contact;

    /// Checks if `vcard` matches `sexp`.
    extern fn e_book_backend_sexp_match_vcard(p_sexp: *BookBackendSExp, p_vcard: [*:0]const u8) c_int;
    pub const matchVcard = e_book_backend_sexp_match_vcard;

    /// Retrieve the text expression for the given `edatabook.BookBackendSExp` object.
    extern fn e_book_backend_sexp_text(p_sexp: *BookBackendSExp) [*:0]const u8;
    pub const text = e_book_backend_sexp_text;

    /// Unlocks the `sexp`, previously locked by `edatabook.BookBackendSExp.lock`.
    extern fn e_book_backend_sexp_unlock(p_sexp: *BookBackendSExp) void;
    pub const unlock = e_book_backend_sexp_unlock;

    extern fn e_book_backend_sexp_get_type() usize;
    pub const getGObjectType = e_book_backend_sexp_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookBackendSExp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookBackendSExp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookBackendSExp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BookBackendSync = extern struct {
    pub const Parent = edatabook.BookBackend;
    pub const Implements = [_]type{};
    pub const Class = edatabook.BookBackendSyncClass;
    f_parent: edatabook.BookBackend,
    f_priv: ?*edatabook.BookBackendSyncPrivate,

    pub const virtual_methods = struct {
        pub const contains_email_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_contains_email_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_email_address, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_contains_email_sync = @ptrCast(p_implementation);
            }
        };

        /// Add and store the passed vcards
        pub const create_contacts_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_create_contacts_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_vcards, p_opflags, p_out_contacts, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_create_contacts_sync = @ptrCast(p_implementation);
            }
        };

        /// Fetch a list of contacts based on a search expression
        pub const get_contact_list_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_query: [*:0]const u8, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_list_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_query, p_out_contacts, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_query: [*:0]const u8, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_list_sync = @ptrCast(p_implementation);
            }
        };

        /// Fetch a list of contact UIDs based on a search expression (optional)
        pub const get_contact_list_uids_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_query: [*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_list_uids_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_query, p_out_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_query: [*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_list_uids_sync = @ptrCast(p_implementation);
            }
        };

        /// Fetch a contact by UID
        pub const get_contact_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebookcontacts.Contact {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*ebookcontacts.Contact) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_get_contact_sync = @ptrCast(p_implementation);
            }
        };

        /// Modify the existing contacts using the passed vcards
        pub const modify_contacts_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_modify_contacts_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_vcards, p_opflags, p_out_contacts, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_modify_contacts_sync = @ptrCast(p_implementation);
            }
        };

        /// Open the backend
        pub const open_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_open_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_open_sync = @ptrCast(p_implementation);
            }
        };

        /// Refresh the backend
        pub const refresh_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_refresh_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_refresh_sync = @ptrCast(p_implementation);
            }
        };

        /// Remove the contacts specified by the passed UIDs
        pub const remove_contacts_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const [*:0]const u8, p_opflags: u32, p_out_removed_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookBackendSync.Class, p_class).f_remove_contacts_sync.?(gobject.ext.as(BookBackendSync, p_backend), p_uids, p_opflags, p_out_removed_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const [*:0]const u8, p_opflags: u32, p_out_removed_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookBackendSync.Class, p_class).f_remove_contacts_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Checks whether contains an `email_address`. When the `email_address`
    /// contains multiple addresses, then returns `TRUE` when at least one
    /// address exists in the address book.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_sync_contains_email(p_backend: *BookBackendSync, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const containsEmail = e_book_backend_sync_contains_email;

    /// Creates one or more new contacts from `vcards`, and deposits an `ebookcontacts.Contact`
    /// instance for each newly-created contact in `out_contacts`.
    ///
    /// The returned `ebookcontacts.Contact` instances are referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_sync_create_contacts(p_backend: *BookBackendSync, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createContacts = e_book_backend_sync_create_contacts;

    /// Obtains an `ebookcontacts.Contact` for `uid`.
    ///
    /// The returned `ebookcontacts.Contact` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_book_backend_sync_get_contact(p_backend: *BookBackendSync, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebookcontacts.Contact;
    pub const getContact = e_book_backend_sync_get_contact;

    /// Obtains a set of `ebookcontacts.Contact` instances which satisfy the criteria specified
    /// in `query`, and deposits them in `out_contacts`.
    ///
    /// The returned `ebookcontacts.Contact` instances are referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_sync_get_contact_list(p_backend: *BookBackendSync, p_query: [*:0]const u8, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactList = e_book_backend_sync_get_contact_list;

    /// Obtains a set of ID strings for contacts which satisfy the criteria
    /// specified in `query`, and deposits them in `out_uids`.
    ///
    /// The returned ID strings must be freed with `glib.free` with finished
    /// with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_book_backend_sync_get_contact_list_uids(p_backend: *BookBackendSync, p_query: [*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactListUids = e_book_backend_sync_get_contact_list_uids;

    /// Modifies one or more contacts according to `vcards`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_sync_modify_contacts(p_backend: *BookBackendSync, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyContacts = e_book_backend_sync_modify_contacts;

    /// "Opens" the `backend`.  Opening a backend is something of an outdated
    /// concept, but the operation is hanging around for a little while longer.
    /// This usually involves some custom initialization logic, and testing of
    /// remote authentication if applicable.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_sync_open(p_backend: *BookBackendSync, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const open = e_book_backend_sync_open;

    /// Initiates a refresh for `backend`, if the `backend` supports refreshing.
    /// The actual refresh operation completes on its own time.  This function
    /// merely initiates the operation.
    ///
    /// If an error occurs while initiating the refresh, the function will set
    /// `error` and return `FALSE`.  If the `backend` does not support refreshing,
    /// the function will set an `E_CLIENT_ERROR_NOT_SUPPORTED` error and return
    /// `FALSE`.
    extern fn e_book_backend_sync_refresh(p_backend: *BookBackendSync, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refresh = e_book_backend_sync_refresh;

    /// Removes one or more contacts according to `uids`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_backend_sync_remove_contacts(p_backend: *BookBackendSync, p_uids: *const [*:0]const u8, p_opflags: u32, p_out_removed_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContacts = e_book_backend_sync_remove_contacts;

    extern fn e_book_backend_sync_get_type() usize;
    pub const getGObjectType = e_book_backend_sync_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookBackendSync) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookBackendSync) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookBackendSync, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below.
pub const BookCache = extern struct {
    pub const Parent = ebackend.Cache;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = edatabook.BookCacheClass;
    f_parent: ebackend.Cache,
    f_priv: ?*edatabook.BookCachePrivate,

    pub const virtual_methods = struct {
        pub const categories_changed = struct {
            pub fn call(p_class: anytype, p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_categories: [*:0]const u8) void {
                return gobject.ext.as(BookCache.Class, p_class).f_categories_changed.?(gobject.ext.as(BookCache, p_book_cache), p_categories);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_categories: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookCache.Class, p_class).f_categories_changed = @ptrCast(p_implementation);
            }
        };

        /// Returns the `contact` revision, used to detect changes.
        /// The returned string should be freed with `glib.free`, when
        /// no longer needed.
        pub const dup_contact_revision = struct {
            pub fn call(p_class: anytype, p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact) [*:0]u8 {
                return gobject.ext.as(BookCache.Class, p_class).f_dup_contact_revision.?(gobject.ext.as(BookCache, p_book_cache), p_contact);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact) callconv(.c) [*:0]u8) void {
                gobject.ext.as(BookCache.Class, p_class).f_dup_contact_revision = @ptrCast(p_implementation);
            }
        };

        pub const e164_changed = struct {
            pub fn call(p_class: anytype, p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact, p_is_replace: c_int) void {
                return gobject.ext.as(BookCache.Class, p_class).f_e164_changed.?(gobject.ext.as(BookCache, p_book_cache), p_contact, p_is_replace);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_book_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact, p_is_replace: c_int) callconv(.c) void) void {
                gobject.ext.as(BookCache.Class, p_class).f_e164_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const locale = struct {
            pub const name = "locale";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const categories_changed = struct {
            pub const name = "categories-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookCache, p_instance))),
                    gobject.signalLookup("categories-changed", BookCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const dup_contact_revision = struct {
            pub const name = "dup-contact-revision";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *ebookcontacts.Contact, P_Data) callconv(.c) [*:0]u8, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookCache, p_instance))),
                    gobject.signalLookup("dup-contact-revision", BookCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const e164_changed = struct {
            pub const name = "e164-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *ebookcontacts.Contact, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookCache, p_instance))),
                    gobject.signalLookup("e164-changed", BookCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `edatabook.BookCache` with the default summary configuration.
    ///
    /// Aside from the mandatory fields `E_CONTACT_UID`, `E_CONTACT_REV`,
    /// the default configuration stores the following fields for quick
    /// performance of searches: `E_CONTACT_FILE_AS`, `E_CONTACT_NICKNAME`,
    /// `E_CONTACT_FULL_NAME`, `E_CONTACT_GIVEN_NAME`, `E_CONTACT_FAMILY_NAME`,
    /// `E_CONTACT_EMAIL`, `E_CONTACT_TEL`, `E_CONTACT_IS_LIST`, `E_CONTACT_LIST_SHOW_ADDRESSES`,
    /// and `E_CONTACT_WANTS_HTML`.
    ///
    /// The fields `E_CONTACT_FULL_NAME` and `E_CONTACT_EMAIL` are configured
    /// to respond extra quickly with the `E_BOOK_INDEX_PREFIX` index flag.
    ///
    /// The fields `E_CONTACT_FILE_AS`, `E_CONTACT_FAMILY_NAME` and
    /// `E_CONTACT_GIVEN_NAME` are configured to perform well with
    /// the `edatabook.BookCacheCursor`, using the `E_BOOK_INDEX_SORT_KEY`
    /// index flag.
    extern fn e_book_cache_new(p_filename: [*:0]const u8, p_source: ?*edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.BookCache;
    pub const new = e_book_cache_new;

    /// Creates a new `edatabook.BookCache` with the given or the default summary configuration.
    ///
    /// Like `edatabook.BookSqlite.new`, but allows configuration of which contact fields
    /// will be stored for quick reference in the summary. The configuration indicated by
    /// `setup` will only be taken into account when initially creating the underlying table,
    /// further configurations will be ignored.
    ///
    /// The fields `E_CONTACT_UID` and `E_CONTACT_REV` are not optional,
    /// they will be stored in the summary regardless of this function's parameters.
    /// Only `EContactFields` with the type `G_TYPE_STRING`, `G_TYPE_BOOLEAN` or
    /// `E_TYPE_CONTACT_ATTR_LIST` are currently supported.
    extern fn e_book_cache_new_full(p_filename: [*:0]const u8, p_source: ?*edataserver.Source, p_setup: ?*ebookcontacts.SourceBackendSummarySetup, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.BookCache;
    pub const newFull = e_book_cache_new_full;

    /// Checks whether contains an `email_address`. When the `email_address`
    /// contains multiple addresses, then returns `TRUE` when at least one
    /// address exists in the cache.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_book_cache_contains_email(p_book_cache: *BookCache, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const containsEmail = e_book_cache_contains_email;

    /// Counts how many contacts satisfy the `sexp`.
    extern fn e_book_cache_count_query(p_book_cache: *BookCache, p_sexp: ?[*:0]const u8, p_out_n_total: *c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const countQuery = e_book_cache_count_query;

    /// Calculates the `out_total` amount of results for the `cursor`'s query expression,
    /// as well as the current `out_position` of `cursor` in the results. The `out_position` is
    /// represented as the amount of results which lead up to the current value
    /// of `cursor`, if `cursor` currently points to an exact contact, the position
    /// also includes the cursor contact.
    extern fn e_book_cache_cursor_calculate(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor, p_out_total: ?*c_int, p_out_position: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const cursorCalculate = e_book_cache_cursor_calculate;

    /// Compares `contact` with `cursor` and returns whether `contact` is less than, equal to, or greater
    /// than `cursor`.
    extern fn e_book_cache_cursor_compare_contact(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor, p_contact: *ebookcontacts.Contact, p_out_matches_sexp: ?*c_int) c_int;
    pub const cursorCompareContact = e_book_cache_cursor_compare_contact;

    /// Frees the `cursor`, previously allocated with `edatabook.BookCacheCursor.new`.
    extern fn e_book_cache_cursor_free(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor) void;
    pub const cursorFree = e_book_cache_cursor_free;

    /// Modifies the current query expression for `cursor`. This will not
    /// modify `cursor`'s state, but will change the outcome of any further
    /// calls to `edatabook.BookCache.cursorStep` or `edatabook.BookCache.cursorCalculate`.
    extern fn e_book_cache_cursor_set_sexp(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor, p_sexp: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const cursorSetSexp = e_book_cache_cursor_set_sexp;

    /// Sets the `cursor` position to an
    /// <link linkend="cursor-alphabet">Alphabetic Index</link>
    /// into the alphabet active in `book_cache`'s locale.
    ///
    /// After setting the target to an alphabetic index, for example the
    /// index for letter 'E', then further calls to `edatabook.BookCache.cursorStep`
    /// will return results starting with the letter 'E' (or results starting
    /// with the last result in 'D', if moving in a negative direction).
    ///
    /// The passed index must be a valid index in the active locale, knowledge
    /// on the currently active alphabet index must be obtained using `edataserver.Collator`
    /// APIs.
    ///
    /// Use `edatabook.BookCache.refCollator` to obtain the active collator for `book_cache`.
    extern fn e_book_cache_cursor_set_target_alphabetic_index(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor, p_idx: c_int) void;
    pub const cursorSetTargetAlphabeticIndex = e_book_cache_cursor_set_target_alphabetic_index;

    /// Steps `cursor` through its sorted query by a maximum of `count` contacts
    /// starting from `origin`.
    ///
    /// If `count` is negative, then the cursor will move through the list in reverse.
    ///
    /// If `cursor` reaches the beginning or end of the query results, then the
    /// returned list might not contain the amount of desired contacts, or might
    /// return no results if the cursor currently points to the last contact.
    /// Reaching the end of the list is not considered an error condition. Attempts
    /// to step beyond the end of the list after having reached the end of the list
    /// will however trigger an `E_CACHE_ERROR_END_OF_LIST` error.
    ///
    /// If `E_BOOK_CACHE_CURSOR_STEP_FETCH` is specified in `flags`, a pointer to
    /// a `NULL` `glib.SList` pointer should be provided for the `out_results` parameter.
    ///
    /// The result list will be stored to `out_results` and should be freed
    /// with g_slist_free_full (results, e_book_cache_search_data_free);
    /// when no longer needed.
    extern fn e_book_cache_cursor_step(p_book_cache: *BookCache, p_cursor: *edatabook.BookCacheCursor, p_flags: edatabook.BookCacheCursorStepFlags, p_origin: edatabook.BookCacheCursorOrigin, p_count: c_int, p_out_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const cursorStep = e_book_cache_cursor_step;

    /// Returns a comma-separated list of categories used by the contacts
    /// stored in the `book_cache`. Free the returned string with `glib.free`,
    /// when no longer needed.
    extern fn e_book_cache_dup_categories(p_book_cache: *BookCache) ?[*:0]u8;
    pub const dupCategories = e_book_cache_dup_categories;

    /// Returns the `contact` revision, used to detect changes.
    /// The returned string should be freed with `glib.free`, when
    /// no longer needed.
    extern fn e_book_cache_dup_contact_revision(p_book_cache: *BookCache, p_contact: *ebookcontacts.Contact) [*:0]u8;
    pub const dupContactRevision = e_book_cache_dup_contact_revision;

    extern fn e_book_cache_dup_locale(p_book_cache: *BookCache) [*:0]u8;
    pub const dupLocale = e_book_cache_dup_locale;

    /// Queries the `book_cache` for the contacts in the given range and order.
    /// The `sort_field` should be in the summary, otherwise an error
    /// is returned.
    ///
    /// Free the `out_contacts` with `g_ptr_aray_unref`, when no longer needed.
    extern fn e_book_cache_dup_query_contacts(p_book_cache: *BookCache, p_sexp: ?[*:0]const u8, p_sort_field: ebookcontacts.ContactField, p_sort_type: ebookcontacts.BookCursorSortType, p_n_offset: c_uint, p_n_limit: c_uint, p_out_contacts: **glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupQueryContacts = e_book_cache_dup_query_contacts;

    /// Queries the `book_cache` for a `summary_field` value for contacts in the given range and order.
    /// To get complete contacts use `edatabook.BookCache.dupQueryContacts`. Note the field value may
    /// not correspond precisely to the value stored in the vCard (it can be in lower case).
    ///
    /// Both `summary_field` and `sort_field` should be in the summary, otherwise an error
    /// is returned.
    ///
    /// The `out_uids` and `out_values` will have the same number of elements,
    /// the indexes corresponding to each other. Free the arrays with
    /// `g_ptr_aray_unref`, when no longer needed.
    extern fn e_book_cache_dup_query_field(p_book_cache: *BookCache, p_summary_field: ebookcontacts.ContactField, p_sexp: ?[*:0]const u8, p_sort_field: ebookcontacts.ContactField, p_sort_type: ebookcontacts.BookCursorSortType, p_n_offset: c_uint, p_n_limit: c_uint, p_out_uids: **glib.PtrArray, p_out_values: **glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupQueryField = e_book_cache_dup_query_field;

    /// Queries the `book_cache` for a `summary_field` value for contact with UID `uid`.
    /// Note the field value may not correspond precisely to the value stored
    /// in the vCard (it can be in lower case).
    ///
    /// Free the `out_value` with `glib.free`, when no longer needed.
    extern fn e_book_cache_dup_summary_field(p_book_cache: *BookCache, p_summary_field: ebookcontacts.ContactField, p_uid: [*:0]const u8, p_out_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupSummaryField = e_book_cache_dup_summary_field;

    /// Fetch the `ebookcontacts.Contact` specified by `uid` in `book_cache`.
    ///
    /// If `meta_contact` is specified, then a shallow `ebookcontacts.Contact` will be created
    /// holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_cache_get_contact(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_meta_contact: c_int, p_out_contact: **ebookcontacts.Contact, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContact = e_book_cache_get_contact;

    /// Gets the custom flags previously set for the `uid`, either with
    /// `edatabook.BookCache.setContactCustomFlags`, when adding contacts or
    /// when removing contacts in offline.
    extern fn e_book_cache_get_contact_custom_flags(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_out_custom_flags: *u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactCustomFlags = e_book_cache_get_contact_custom_flags;

    /// Fetches the extra data previously set for `uid`, either with
    /// `edatabook.BookCache.setContactExtra` or when adding contacts.
    extern fn e_book_cache_get_contact_extra(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactExtra = e_book_cache_get_contact_extra;

    /// Gets all the UID-s the `extra` data is set for.
    ///
    /// The `out_uids` should be freed with
    /// g_slist_free_full (uids, g_free);
    /// when no longer needed.
    extern fn e_book_cache_get_uids_with_extra(p_book_cache: *BookCache, p_extra: [*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getUidsWithExtra = e_book_cache_get_uids_with_extra;

    /// Fetch a vCard string for `uid` in `book_cache`.
    ///
    /// If `meta_contact` is specified, then a shallow vCard representation will be
    /// created holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_cache_get_vcard(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_meta_contact: c_int, p_out_vcard: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getVcard = e_book_cache_get_vcard;

    /// This is a convenience wrapper for `edatabook.BookCache.putContacts`,
    /// which is the preferred way to add or modify multiple contacts when possible.
    extern fn e_book_cache_put_contact(p_book_cache: *BookCache, p_contact: *ebookcontacts.Contact, p_extra: ?[*:0]const u8, p_custom_flags: u32, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putContact = e_book_cache_put_contact;

    /// Adds or replaces contacts in `book_cache`.
    ///
    /// If `extras` is specified, it must have an equal length as the `contacts` list.
    /// Similarly the non-NULL `custom_flags` length should be the same as the length of the `contacts`.
    /// Each element from the `extras` list and `custom_flags` list will be stored in association
    /// with its corresponding contact in the `contacts` list.
    extern fn e_book_cache_put_contacts(p_book_cache: *BookCache, p_contacts: *const glib.SList, p_extras: ?*const glib.SList, p_custom_flags: ?*const glib.SList, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putContacts = e_book_cache_put_contacts;

    /// References the currently active `edataserver.Collator` for `book_cache`,
    /// use `edataserver.Collator.unref` when finished using the returned collator.
    ///
    /// Note that the active collator will change with the active locale setting.
    extern fn e_book_cache_ref_collator(p_book_cache: *BookCache) *edataserver.Collator;
    pub const refCollator = e_book_cache_ref_collator;

    /// References the `edataserver.Source` to which `book_cache` is paired,
    /// use `gobject.Object.unref` when no longer needed.
    /// It can be `NULL` in some cases, like when running tests.
    extern fn e_book_cache_ref_source(p_book_cache: *BookCache) ?*edataserver.Source;
    pub const refSource = e_book_cache_ref_source;

    /// Removes the contact identified by `uid` from `book_cache`.
    extern fn e_book_cache_remove_contact(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_custom_flags: u32, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContact = e_book_cache_remove_contact;

    /// Removes the contacts indicated by `uids` from `book_cache`.
    /// The `custom_flags` is used, if not `NULL`, only if the `offline_flag`
    /// is `E_CACHE_IS_OFFLINE`. Otherwise it's ignored. The length of
    /// the `custom_flags` should match the length of `uids`, when not `NULL`.
    extern fn e_book_cache_remove_contacts(p_book_cache: *BookCache, p_uids: *const glib.SList, p_custom_flags: ?*const glib.SList, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContacts = e_book_cache_remove_contacts;

    /// Searches `book_cache` for contacts matching the search expression `sexp`.
    ///
    /// When `sexp` refers only to `EContactFields` configured in the summary of `book_cache`,
    /// the search should always be quick, when searching for other `EContactFields`
    /// a fallback will be used.
    ///
    /// The returned `out_list` list should be freed with g_slist_free_full (list, e_book_cache_search_data_free)
    /// when no longer needed.
    ///
    /// If `meta_contact` is specified, then shallow vCard representations will be
    /// created holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_cache_search(p_book_cache: *BookCache, p_sexp: ?[*:0]const u8, p_meta_contacts: c_int, p_out_list: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const search = e_book_cache_search;

    /// Similar to `edatabook.BookCache.search`, but fetches only a list of contact UIDs.
    ///
    /// The returned `out_list` list should be freed with g_slist_free_full(list, g_free)
    /// when no longer needed.
    extern fn e_book_cache_search_uids(p_book_cache: *BookCache, p_sexp: ?[*:0]const u8, p_out_list: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchUids = e_book_cache_search_uids;

    /// Similar to `edatabook.BookCache.search`, but calls the `func` for each found contact.
    extern fn e_book_cache_search_with_callback(p_book_cache: *BookCache, p_sexp: ?[*:0]const u8, p_func: edatabook.BookCacheSearchFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchWithCallback = e_book_cache_search_with_callback;

    /// Sets or replaces the custom flags associated with a contact
    /// identified by the `uid`.
    extern fn e_book_cache_set_contact_custom_flags(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_custom_flags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setContactCustomFlags = e_book_cache_set_contact_custom_flags;

    /// Sets or replaces the extra data associated with `uid`.
    extern fn e_book_cache_set_contact_extra(p_book_cache: *BookCache, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setContactExtra = e_book_cache_set_contact_extra;

    /// Relocalizes any locale specific data in the specified
    /// new `lc_collate` locale.
    ///
    /// The `lc_collate` locale setting is stored and remembered on
    /// subsequent accesses of the cache, changing the locale will
    /// store the new locale and will modify sort keys and any
    /// locale specific data in the cache.
    ///
    /// As a side effect, it's possible that changing the locale
    /// will cause stored vCard-s to change.
    extern fn e_book_cache_set_locale(p_book_cache: *BookCache, p_lc_collate: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setLocale = e_book_cache_set_locale;

    extern fn e_book_cache_get_type() usize;
    pub const getGObjectType = e_book_cache_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below.
pub const BookMetaBackend = extern struct {
    pub const Parent = edatabook.BookBackendSync;
    pub const Implements = [_]type{};
    pub const Class = edatabook.BookMetaBackendClass;
    f_parent: edatabook.BookBackendSync,
    f_priv: ?*edatabook.BookMetaBackendPrivate,

    pub const virtual_methods = struct {
        /// This is called always before any operation which requires a connection
        /// to the remote side. It can fail with an `E_CLIENT_ERROR_REPOSITORY_OFFLINE`
        /// error to indicate that the remote side cannot be currently reached. Other
        /// errors are propagated to the caller/client side. This method is not called
        /// when the backend is offline.
        ///
        /// The descendant should also call `edatabook.BookBackend.setWritable` after successful
        /// connect to the remote side. This value is stored for later use, when being
        /// opened offline.
        ///
        /// The `credentials` parameter consists of the previously used credentials.
        /// It's always `NULL` with the first connection attempt. To get the credentials,
        /// just set the `out_auth_result` to `E_SOURCE_AUTHENTICATION_REQUIRED` for
        /// the first time and the function will be called again once the credentials
        /// are available. See the documentation of `edataserver.SourceAuthenticationResult` for
        /// other available results.
        ///
        /// The out parameters are passed to `ebackend.Backend.scheduleCredentialsRequired`
        /// and are ignored when the descendant returns `TRUE`, aka they are used
        /// only if the connection fails. The `out_certificate_pem` and `out_certificate_errors`
        /// should be used together and they can be left untouched if the failure reason was
        /// not related to certificate. Use `out_auth_result` `E_SOURCE_AUTHENTICATION_UNKNOWN`
        /// to indicate other error than `credentials` error, otherwise the `error` is used
        /// according to `out_auth_result` value.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        pub const connect_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_connect_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_credentials, p_out_auth_result, p_out_certificate_pem, p_out_certificate_errors, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_connect_sync = @ptrCast(p_implementation);
            }
        };

        /// This is called when the backend goes into offline mode or
        /// when the disconnect is required. The implementation should
        /// not report any error when it is called and the `meta_backend`
        /// is not connected.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        pub const disconnect_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_disconnect_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_disconnect_sync = @ptrCast(p_implementation);
            }
        };

        /// Gathers the changes since the last check which had been done
        /// on the remote side.
        ///
        /// The `last_sync_tag` can be used as a tag of the last check. This can be `NULL`,
        /// when there was no previous call or when the descendant doesn't store any
        /// such tags. The `out_new_sync_tag` can be populated with a value to be stored
        /// and used the next time.
        ///
        /// The `out_repeat` can be set to `TRUE` when the descendant didn't finish
        /// read of all the changes. In that case the `meta_backend` calls this
        /// function again with the `out_new_sync_tag` as the `last_sync_tag`, but also
        /// notifies about the found changes immediately. The `is_repeat` is set
        /// to `TRUE` as well in this case, otherwise it's `FALSE`.
        ///
        /// The descendant can populate also EBookMetaBackendInfo::object of
        /// the `out_created_objects` and `out_modified_objects`, if known, in which
        /// case this will be used instead of loading it with `edatabook.BookMetaBackend.loadContactSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation calls `edatabook.BookMetaBackend.listExistingSync`
        /// and then compares the list with the current content of the local cache
        /// and populates the respective lists appropriately.
        ///
        /// Each output `glib.SList` should be freed with
        /// g_slist_free_full (objects, e_book_meta_backend_info_free);
        /// when no longer needed.
        pub const get_changes_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_get_changes_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_last_sync_tag, p_is_repeat, p_out_new_sync_tag, p_out_repeat, p_out_created_objects, p_out_modified_objects, p_out_removed_objects, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_get_changes_sync = @ptrCast(p_implementation);
            }
        };

        /// It is optional to implement this virtual method by the descendants.
        /// It is used to receive SSL error details when any online operation
        /// returns E_CLIENT_ERROR, E_CLIENT_ERROR_TLS_NOT_AVAILABLE error.
        pub const get_ssl_error_details = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_get_ssl_error_details.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_out_certificate_pem, p_out_certificate_errors);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_get_ssl_error_details = @ptrCast(p_implementation);
            }
        };

        /// Used to get list of all existing objects on the remote side. The descendant
        /// can optionally provide `out_new_sync_tag`, which will be stored on success, if
        /// not `NULL`. The descendant can populate also EBookMetaBackendInfo::object of
        /// the `out_existing_objects`, if known, in which case this will be used instead
        /// of loading it with `edatabook.BookMetaBackend.loadContactSync`.
        ///
        /// It is mandatory to implement this virtual method by the descendant, unless
        /// it implements its own `edatabook.BookMetaBackendClass.virtual_methods.get_changes_sync`.
        ///
        /// The `out_existing_objects` `glib.SList` should be freed with
        /// g_slist_free_full (objects, e_book_meta_backend_info_free);
        /// when no longer needed.
        pub const list_existing_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_list_existing_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_out_new_sync_tag, p_out_existing_objects, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_list_existing_sync = @ptrCast(p_implementation);
            }
        };

        /// Loads a contact from the remote side.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        ///
        /// The returned `out_contact` should be freed with `gobject.Object.unref`,
        /// when no longer needed.
        ///
        /// The returned `out_extra` should be freed with `glib.free`, when no longer
        /// needed.
        pub const load_contact_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_contact: **ebookcontacts.Contact, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_load_contact_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_uid, p_extra, p_out_contact, p_out_extra, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_contact: **ebookcontacts.Contact, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_load_contact_sync = @ptrCast(p_implementation);
            }
        };

        /// Removes a contact from the remote side. The `object` is not `NULL` when
        /// it's removing locally deleted object in offline mode. Being it `NULL`,
        /// the descendant can obtain the object from the `edatabook.BookCache`.
        ///
        /// It is mandatory to implement this virtual method by the writable descendant.
        pub const remove_contact_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_remove_contact_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_conflict_resolution, p_uid, p_extra, p_object, p_opflags, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_remove_contact_sync = @ptrCast(p_implementation);
            }
        };

        /// Determines, whether current source content requires reconnect of the backend.
        ///
        /// It is optional to implement this virtual method by the descendant. The default
        /// implementation compares `E_SOURCE_EXTENSION_AUTHENTICATION` and
        /// `E_SOURCE_EXTENSION_WEBDAV_BACKEND`, if existing in the source,
        /// with the values after the last successful connect and returns
        /// `TRUE` when they changed. It always return `TRUE` when there was
        /// no successful connect done yet.
        pub const requires_reconnect = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_requires_reconnect.?(gobject.ext.as(BookMetaBackend, p_meta_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_requires_reconnect = @ptrCast(p_implementation);
            }
        };

        /// Saves one contact into the remote side.  When the `overwrite_existing` is `TRUE`, then
        /// the descendant can overwrite an object with the same UID on the remote side
        /// (usually used for modify). The `conflict_resolution` defines what to do when
        /// the remote side had made any changes to the object since the last update.
        ///
        /// The `contact` has already converted locally stored photos and logos
        /// into inline variants, thus it's not needed to call
        /// `edatabook.BookMetaBackend.inlineLocalPhotosSync` by the descendant.
        ///
        /// The `out_new_uid` can be populated with a UID of the saved contact as the server
        /// assigned it to it. This UID, if set, is loaded from the remote side afterwards,
        /// also to see whether any changes had been made to the contact by the remote side.
        ///
        /// The `out_new_extra` can be populated with a new extra data to save with the contact.
        /// Left it `NULL`, to keep the same value as the `extra`.
        ///
        /// The descendant can use an `E_CLIENT_ERROR_OUT_OF_SYNC` error to indicate that
        /// the save failed due to made changes on the remote side, and let the `meta_backend`
        /// resolve this conflict based on the `conflict_resolution` on its own.
        /// The `E_CLIENT_ERROR_OUT_OF_SYNC` error should not be used when the descendant
        /// is able to resolve the conflicts itself.
        ///
        /// It is mandatory to implement this virtual method by the writable descendant.
        pub const save_contact_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_contact: *ebookcontacts.Contact, p_extra: ?[*:0]const u8, p_opflags: u32, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_save_contact_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_overwrite_existing, p_conflict_resolution, p_contact, p_extra, p_opflags, p_out_new_uid, p_out_new_extra, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_contact: *ebookcontacts.Contact, p_extra: ?[*:0]const u8, p_opflags: u32, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_save_contact_sync = @ptrCast(p_implementation);
            }
        };

        /// Searches `meta_backend` with given expression `expr` and returns
        /// found contacts as a `glib.SList` of `ebookcontacts.Contact` `out_contacts`.
        /// Free the returned `out_contacts` with g_slist_free_full (contacts, g_object_unref);
        /// when no longer needed.
        /// When the `expr` is `NULL`, all objects are returned. To get
        /// UID-s instead, call `edatabook.BookMetaBackend.searchUidsSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation searches `meta_backend`'s cache. It's also
        /// not required to be online for searching, thus `meta_backend` doesn't
        /// ensure it.
        pub const search_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_meta_contact: c_int, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_search_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_expr, p_meta_contact, p_out_contacts, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_meta_contact: c_int, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_search_sync = @ptrCast(p_implementation);
            }
        };

        /// Searches `meta_backend` with given expression `expr` and returns
        /// found contact UID-s as a `glib.SList` `out_contacts`.
        /// Free the returned `out_uids` with g_slist_free_full (uids, g_free);
        /// when no longer needed.
        /// When the `expr` is `NULL`, all UID-s are returned. To get `ebookcontacts.Contact`(s)
        /// instead, call `edatabook.BookMetaBackend.searchSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation searches `meta_backend`'s cache. It's also
        /// not required to be online for searching, thus `meta_backend` doesn't
        /// ensure it.
        pub const search_uids_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_search_uids_sync.?(gobject.ext.as(BookMetaBackend, p_meta_backend), p_expr, p_out_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_search_uids_sync = @ptrCast(p_implementation);
            }
        };

        pub const source_changed = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(BookMetaBackend.Class, p_class).f_source_changed.?(gobject.ext.as(BookMetaBackend, p_meta_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(BookMetaBackend.Class, p_class).f_source_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The `edatabook.BookCache` being used for this meta backend.
        pub const cache = struct {
            pub const name = "cache";

            pub const Type = ?*edatabook.BookCache;
        };
    };

    pub const signals = struct {
        pub const refresh_completed = struct {
            pub const name = "refresh-completed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookMetaBackend, p_instance))),
                    gobject.signalLookup("refresh-completed", BookMetaBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted whenever the underlying backend `edataserver.Source`
        /// changes. Unlike the `edataserver.Source`'s 'changed' signal this one is
        /// tight to the `edatabook.BookMetaBackend` itself and is emitted from
        /// a dedicated thread, thus it doesn't block the main thread.
        pub const source_changed = struct {
            pub const name = "source-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookMetaBackend, p_instance))),
                    gobject.signalLookup("source-changed", BookMetaBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This is called always before any operation which requires a connection
    /// to the remote side. It can fail with an `E_CLIENT_ERROR_REPOSITORY_OFFLINE`
    /// error to indicate that the remote side cannot be currently reached. Other
    /// errors are propagated to the caller/client side. This method is not called
    /// when the backend is offline.
    ///
    /// The descendant should also call `edatabook.BookBackend.setWritable` after successful
    /// connect to the remote side. This value is stored for later use, when being
    /// opened offline.
    ///
    /// The `credentials` parameter consists of the previously used credentials.
    /// It's always `NULL` with the first connection attempt. To get the credentials,
    /// just set the `out_auth_result` to `E_SOURCE_AUTHENTICATION_REQUIRED` for
    /// the first time and the function will be called again once the credentials
    /// are available. See the documentation of `edataserver.SourceAuthenticationResult` for
    /// other available results.
    ///
    /// The out parameters are passed to `ebackend.Backend.scheduleCredentialsRequired`
    /// and are ignored when the descendant returns `TRUE`, aka they are used
    /// only if the connection fails. The `out_certificate_pem` and `out_certificate_errors`
    /// should be used together and they can be left untouched if the failure reason was
    /// not related to certificate. Use `out_auth_result` `E_SOURCE_AUTHENTICATION_UNKNOWN`
    /// to indicate other error than `credentials` error, otherwise the `error` is used
    /// according to `out_auth_result` value.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    extern fn e_book_meta_backend_connect_sync(p_meta_backend: *BookMetaBackend, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const connectSync = e_book_meta_backend_connect_sync;

    /// This is called when the backend goes into offline mode or
    /// when the disconnect is required. The implementation should
    /// not report any error when it is called and the `meta_backend`
    /// is not connected.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    extern fn e_book_meta_backend_disconnect_sync(p_meta_backend: *BookMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const disconnectSync = e_book_meta_backend_disconnect_sync;

    /// Returns the last known synchronization tag, the same as used to
    /// call `edatabook.BookMetaBackend.getChangesSync`.
    ///
    /// Free the returned string with `glib.free`, when no longer needed.
    extern fn e_book_meta_backend_dup_sync_tag(p_meta_backend: *BookMetaBackend) ?[*:0]u8;
    pub const dupSyncTag = e_book_meta_backend_dup_sync_tag;

    /// Empties the local cache by removing all known contacts from it
    /// and notifies about such removal any opened views.
    extern fn e_book_meta_backend_empty_cache_sync(p_meta_backend: *BookMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const emptyCacheSync = e_book_meta_backend_empty_cache_sync;

    /// Ensures that the `meta_backend` is connected to its destination.
    extern fn e_book_meta_backend_ensure_connected_sync(p_meta_backend: *BookMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const ensureConnectedSync = e_book_meta_backend_ensure_connected_sync;

    extern fn e_book_meta_backend_get_capabilities(p_meta_backend: *BookMetaBackend) [*:0]const u8;
    pub const getCapabilities = e_book_meta_backend_get_capabilities;

    /// Gathers the changes since the last check which had been done
    /// on the remote side.
    ///
    /// The `last_sync_tag` can be used as a tag of the last check. This can be `NULL`,
    /// when there was no previous call or when the descendant doesn't store any
    /// such tags. The `out_new_sync_tag` can be populated with a value to be stored
    /// and used the next time.
    ///
    /// The `out_repeat` can be set to `TRUE` when the descendant didn't finish
    /// read of all the changes. In that case the `meta_backend` calls this
    /// function again with the `out_new_sync_tag` as the `last_sync_tag`, but also
    /// notifies about the found changes immediately. The `is_repeat` is set
    /// to `TRUE` as well in this case, otherwise it's `FALSE`.
    ///
    /// The descendant can populate also EBookMetaBackendInfo::object of
    /// the `out_created_objects` and `out_modified_objects`, if known, in which
    /// case this will be used instead of loading it with `edatabook.BookMetaBackend.loadContactSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation calls `edatabook.BookMetaBackend.listExistingSync`
    /// and then compares the list with the current content of the local cache
    /// and populates the respective lists appropriately.
    ///
    /// Each output `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_book_meta_backend_info_free);
    /// when no longer needed.
    extern fn e_book_meta_backend_get_changes_sync(p_meta_backend: *BookMetaBackend, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getChangesSync = e_book_meta_backend_get_changes_sync;

    /// This value has meaning only if `edatabook.BookMetaBackend.getEverConnected`
    /// is `TRUE`.
    extern fn e_book_meta_backend_get_connected_writable(p_meta_backend: *BookMetaBackend) c_int;
    pub const getConnectedWritable = e_book_meta_backend_get_connected_writable;

    extern fn e_book_meta_backend_get_ever_connected(p_meta_backend: *BookMetaBackend) c_int;
    pub const getEverConnected = e_book_meta_backend_get_ever_connected;

    /// It is optional to implement this virtual method by the descendants.
    /// It is used to receive SSL error details when any online operation
    /// returns E_CLIENT_ERROR, E_CLIENT_ERROR_TLS_NOT_AVAILABLE error.
    extern fn e_book_meta_backend_get_ssl_error_details(p_meta_backend: *BookMetaBackend, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) c_int;
    pub const getSslErrorDetails = e_book_meta_backend_get_ssl_error_details;

    /// Changes all URL photos and logos which point to a local file in `contact`
    /// to inline type, aka adds the file content into the `contact`.
    /// This is called automatically before `edatabook.BookMetaBackend.saveContactSync`.
    ///
    /// The reverse operation is `edatabook.BookMetaBackend.storeInlinePhotosSync`.
    extern fn e_book_meta_backend_inline_local_photos_sync(p_meta_backend: *BookMetaBackend, p_contact: *ebookcontacts.Contact, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const inlineLocalPhotosSync = e_book_meta_backend_inline_local_photos_sync;

    /// Used to get list of all existing objects on the remote side. The descendant
    /// can optionally provide `out_new_sync_tag`, which will be stored on success, if
    /// not `NULL`. The descendant can populate also EBookMetaBackendInfo::object of
    /// the `out_existing_objects`, if known, in which case this will be used instead
    /// of loading it with `edatabook.BookMetaBackend.loadContactSync`.
    ///
    /// It is mandatory to implement this virtual method by the descendant, unless
    /// it implements its own `edatabook.BookMetaBackendClass.virtual_methods.get_changes_sync`.
    ///
    /// The `out_existing_objects` `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_book_meta_backend_info_free);
    /// when no longer needed.
    extern fn e_book_meta_backend_list_existing_sync(p_meta_backend: *BookMetaBackend, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const listExistingSync = e_book_meta_backend_list_existing_sync;

    /// Loads a contact from the remote side.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    ///
    /// The returned `out_contact` should be freed with `gobject.Object.unref`,
    /// when no longer needed.
    ///
    /// The returned `out_extra` should be freed with `glib.free`, when no longer
    /// needed.
    extern fn e_book_meta_backend_load_contact_sync(p_meta_backend: *BookMetaBackend, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_contact: **ebookcontacts.Contact, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const loadContactSync = e_book_meta_backend_load_contact_sync;

    /// Processes given changes by updating local cache content accordingly.
    /// The `meta_backend` processes the changes like being online and particularly
    /// requires to be online to load created and modified objects when needed.
    extern fn e_book_meta_backend_process_changes_sync(p_meta_backend: *BookMetaBackend, p_created_objects: ?*const glib.SList, p_modified_objects: ?*const glib.SList, p_removed_objects: ?*const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const processChangesSync = e_book_meta_backend_process_changes_sync;

    extern fn e_book_meta_backend_ref_cache(p_meta_backend: *BookMetaBackend) *edatabook.BookCache;
    pub const refCache = e_book_meta_backend_ref_cache;

    /// Refreshes the `meta_backend` immediately. To just schedule refresh
    /// operation call `edatabook.BookMetaBackend.scheduleRefresh`.
    extern fn e_book_meta_backend_refresh_sync(p_meta_backend: *BookMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshSync = e_book_meta_backend_refresh_sync;

    /// Removes a contact from the remote side. The `object` is not `NULL` when
    /// it's removing locally deleted object in offline mode. Being it `NULL`,
    /// the descendant can obtain the object from the `edatabook.BookCache`.
    ///
    /// It is mandatory to implement this virtual method by the writable descendant.
    extern fn e_book_meta_backend_remove_contact_sync(p_meta_backend: *BookMetaBackend, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContactSync = e_book_meta_backend_remove_contact_sync;

    /// Determines, whether current source content requires reconnect of the backend.
    ///
    /// It is optional to implement this virtual method by the descendant. The default
    /// implementation compares `E_SOURCE_EXTENSION_AUTHENTICATION` and
    /// `E_SOURCE_EXTENSION_WEBDAV_BACKEND`, if existing in the source,
    /// with the values after the last successful connect and returns
    /// `TRUE` when they changed. It always return `TRUE` when there was
    /// no successful connect done yet.
    extern fn e_book_meta_backend_requires_reconnect(p_meta_backend: *BookMetaBackend) c_int;
    pub const requiresReconnect = e_book_meta_backend_requires_reconnect;

    /// Saves one contact into the remote side.  When the `overwrite_existing` is `TRUE`, then
    /// the descendant can overwrite an object with the same UID on the remote side
    /// (usually used for modify). The `conflict_resolution` defines what to do when
    /// the remote side had made any changes to the object since the last update.
    ///
    /// The `contact` has already converted locally stored photos and logos
    /// into inline variants, thus it's not needed to call
    /// `edatabook.BookMetaBackend.inlineLocalPhotosSync` by the descendant.
    ///
    /// The `out_new_uid` can be populated with a UID of the saved contact as the server
    /// assigned it to it. This UID, if set, is loaded from the remote side afterwards,
    /// also to see whether any changes had been made to the contact by the remote side.
    ///
    /// The `out_new_extra` can be populated with a new extra data to save with the contact.
    /// Left it `NULL`, to keep the same value as the `extra`.
    ///
    /// The descendant can use an `E_CLIENT_ERROR_OUT_OF_SYNC` error to indicate that
    /// the save failed due to made changes on the remote side, and let the `meta_backend`
    /// resolve this conflict based on the `conflict_resolution` on its own.
    /// The `E_CLIENT_ERROR_OUT_OF_SYNC` error should not be used when the descendant
    /// is able to resolve the conflicts itself.
    ///
    /// It is mandatory to implement this virtual method by the writable descendant.
    extern fn e_book_meta_backend_save_contact_sync(p_meta_backend: *BookMetaBackend, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_contact: *ebookcontacts.Contact, p_extra: ?[*:0]const u8, p_opflags: u32, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const saveContactSync = e_book_meta_backend_save_contact_sync;

    /// Schedules refresh of the content of the `meta_backend`. If there's any
    /// already scheduled, then the function does nothing.
    ///
    /// Use `edatabook.BookMetaBackend.refreshSync` to refresh the `meta_backend`
    /// immediately.
    extern fn e_book_meta_backend_schedule_refresh(p_meta_backend: *BookMetaBackend) void;
    pub const scheduleRefresh = e_book_meta_backend_schedule_refresh;

    /// Searches `meta_backend` with given expression `expr` and returns
    /// found contacts as a `glib.SList` of `ebookcontacts.Contact` `out_contacts`.
    /// Free the returned `out_contacts` with g_slist_free_full (contacts, g_object_unref);
    /// when no longer needed.
    /// When the `expr` is `NULL`, all objects are returned. To get
    /// UID-s instead, call `edatabook.BookMetaBackend.searchUidsSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation searches `meta_backend`'s cache. It's also
    /// not required to be online for searching, thus `meta_backend` doesn't
    /// ensure it.
    extern fn e_book_meta_backend_search_sync(p_meta_backend: *BookMetaBackend, p_expr: ?[*:0]const u8, p_meta_contact: c_int, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchSync = e_book_meta_backend_search_sync;

    /// Searches `meta_backend` with given expression `expr` and returns
    /// found contact UID-s as a `glib.SList` `out_contacts`.
    /// Free the returned `out_uids` with g_slist_free_full (uids, g_free);
    /// when no longer needed.
    /// When the `expr` is `NULL`, all UID-s are returned. To get `ebookcontacts.Contact`(s)
    /// instead, call `edatabook.BookMetaBackend.searchSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation searches `meta_backend`'s cache. It's also
    /// not required to be online for searching, thus `meta_backend` doesn't
    /// ensure it.
    extern fn e_book_meta_backend_search_uids_sync(p_meta_backend: *BookMetaBackend, p_expr: ?[*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchUidsSync = e_book_meta_backend_search_uids_sync;

    /// Sets the `cache` as the cache to be used by the `meta_backend`.
    /// By default, a cache.db in EBookBackend::cache-dir is created
    /// in the constructed method. This function can be used to override
    /// the default.
    ///
    /// Note the `meta_backend` adds its own reference to the `cache`.
    extern fn e_book_meta_backend_set_cache(p_meta_backend: *BookMetaBackend, p_cache: *edatabook.BookCache) void;
    pub const setCache = e_book_meta_backend_set_cache;

    /// Sets whether the `meta_backend` connected to a writable destination.
    /// This value has meaning only if `edatabook.BookMetaBackend.getEverConnected`
    /// is `TRUE`.
    ///
    /// This is used by the `meta_backend` itself, during the opening phase,
    /// to set the backend writable or not also in the offline mode.
    extern fn e_book_meta_backend_set_connected_writable(p_meta_backend: *BookMetaBackend, p_value: c_int) void;
    pub const setConnectedWritable = e_book_meta_backend_set_connected_writable;

    /// Sets whether the `meta_backend` ever made a successful connection
    /// to its destination.
    ///
    /// This is used by the `meta_backend` itself, during the opening phase,
    /// when it had not been connected yet, then it does so immediately, to
    /// eventually report settings error easily.
    extern fn e_book_meta_backend_set_ever_connected(p_meta_backend: *BookMetaBackend, p_value: c_int) void;
    pub const setEverConnected = e_book_meta_backend_set_ever_connected;

    /// Sets the `sync_tag` for the `meta_backend`.
    extern fn e_book_meta_backend_set_sync_tag(p_meta_backend: *BookMetaBackend, p_sync_tag: ?[*:0]const u8) void;
    pub const setSyncTag = e_book_meta_backend_set_sync_tag;

    /// Splits `objects` into created/modified/removed lists according to current local
    /// cache content. Only the `out_removed_objects` can be `NULL`, others cannot.
    /// The function modifies `objects` by moving its 'data' to corresponding out
    /// lists and sets the `objects` 'data' to `NULL`.
    ///
    /// Each output `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_book_meta_backend_info_free);
    /// when no longer needed.
    ///
    /// The caller is still responsible to free `objects` as well.
    extern fn e_book_meta_backend_split_changes_sync(p_meta_backend: *BookMetaBackend, p_objects: *glib.SList, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const splitChangesSync = e_book_meta_backend_split_changes_sync;

    /// Changes all inline photos and logos to URL type in `contact`, which
    /// will point to a local file instead, beside the cache file.
    /// This is called automatically after `edatabook.BookMetaBackend.loadContactSync`.
    ///
    /// The reverse operation is `edatabook.BookMetaBackend.inlineLocalPhotosSync`.
    extern fn e_book_meta_backend_store_inline_photos_sync(p_meta_backend: *BookMetaBackend, p_contact: *ebookcontacts.Contact, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const storeInlinePhotosSync = e_book_meta_backend_store_inline_photos_sync;

    extern fn e_book_meta_backend_get_type() usize;
    pub const getGObjectType = e_book_meta_backend_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookMetaBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookMetaBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookMetaBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BookSqlite = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = edatabook.BookSqliteClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.BookSqlitePrivate,

    pub const virtual_methods = struct {
        pub const before_insert_contact = struct {
            pub fn call(p_class: anytype, p_ebsql: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_db: ?*anyopaque, p_contact: *ebookcontacts.Contact, p_extra: [*:0]const u8, p_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookSqlite.Class, p_class).f_before_insert_contact.?(gobject.ext.as(BookSqlite, p_ebsql), p_db, p_contact, p_extra, p_replace, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_ebsql: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_db: ?*anyopaque, p_contact: *ebookcontacts.Contact, p_extra: [*:0]const u8, p_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookSqlite.Class, p_class).f_before_insert_contact = @ptrCast(p_implementation);
            }
        };

        pub const before_remove_contact = struct {
            pub fn call(p_class: anytype, p_ebsql: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_db: ?*anyopaque, p_contact_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(BookSqlite.Class, p_class).f_before_remove_contact.?(gobject.ext.as(BookSqlite, p_ebsql), p_db, p_contact_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_ebsql: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_db: ?*anyopaque, p_contact_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(BookSqlite.Class, p_class).f_before_remove_contact = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const before_insert_contact = struct {
            pub const name = "before-insert-contact";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: ?*anyopaque, p_p0: *ebookcontacts.Contact, p_p1: [*:0]u8, p_p2: c_int, p_p3: *gobject.Object, p_p4: ?*anyopaque, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookSqlite, p_instance))),
                    gobject.signalLookup("before-insert-contact", BookSqlite.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const before_remove_contact = struct {
            pub const name = "before-remove-contact";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: ?*anyopaque, p_p0: [*:0]u8, p_p1: ?*gio.Cancellable, p_p2: ?*anyopaque, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookSqlite, p_instance))),
                    gobject.signalLookup("before-remove-contact", BookSqlite.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn e_book_sqlite_error_quark() glib.Quark;
    pub const errorQuark = e_book_sqlite_error_quark;

    /// Frees an `edatabook.bSqlSearchData`
    extern fn e_book_sqlite_search_data_free(p_data: *edatabook.bSqlSearchData) void;
    pub const searchDataFree = e_book_sqlite_search_data_free;

    /// Creates a new `edatabook.BookSqlite` with the default summary configuration.
    ///
    /// Aside from the manditory fields `E_CONTACT_UID`, `E_CONTACT_REV`,
    /// the default configuration stores the following fields for quick
    /// performance of searches: `E_CONTACT_FILE_AS`, `E_CONTACT_NICKNAME`,
    /// `E_CONTACT_FULL_NAME`, `E_CONTACT_GIVEN_NAME`, `E_CONTACT_FAMILY_NAME`,
    /// `E_CONTACT_EMAIL`, `E_CONTACT_TEL`, `E_CONTACT_IS_LIST`, `E_CONTACT_LIST_SHOW_ADDRESSES`,
    /// and `E_CONTACT_WANTS_HTML`.
    ///
    /// The fields `E_CONTACT_FULL_NAME` and `E_CONTACT_EMAIL` are configured
    /// to respond extra quickly with the `E_BOOK_INDEX_PREFIX` index flag.
    ///
    /// The fields `E_CONTACT_FILE_AS`, `E_CONTACT_FAMILY_NAME` and
    /// `E_CONTACT_GIVEN_NAME` are configured to perform well with
    /// the `edatabook.bSqlCursor` interface, using the `E_BOOK_INDEX_SORT_KEY`
    /// index flag.
    extern fn e_book_sqlite_new(p_path: [*:0]const u8, p_source: ?*edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.BookSqlite;
    pub const new = e_book_sqlite_new;

    /// Opens or creates a new addressbook at `path`.
    ///
    /// Like `edatabook.BookSqlite.new`, but allows configuration of which contact fields
    /// will be stored for quick reference in the summary. The configuration indicated by
    /// `setup` will only be taken into account when initially creating the underlying table,
    /// further configurations will be ignored.
    ///
    /// The fields `E_CONTACT_UID` and `E_CONTACT_REV` are not optional,
    /// they will be stored in the summary regardless of this function's parameters.
    /// Only `EContactFields` with the type `G_TYPE_STRING`, `G_TYPE_BOOLEAN` or
    /// `E_TYPE_CONTACT_ATTR_LIST` are currently supported.
    ///
    /// If `vcard_callback` is specified, then vcards will not be stored by functions
    /// such as `e_book_sqlitedb_add_contact`. Instead `vcard_callback` will be invoked
    /// at any time the created `edatabook.BookSqlite` requires a vcard, either as a fallback
    /// for querying search expressions which cannot be satisfied with the summary
    /// fields, or when reporting results from searches.
    ///
    /// If any error occurs and `NULL` is returned, then the passed `user_data` will
    /// be automatically freed using the `user_data_destroy` function, if specified.
    ///
    /// It is recommended to store all contact vcards in the `edatabook.BookSqlite` addressbook
    /// if at all possible, however in some cases the vcards must be stored in some
    /// other storage.
    extern fn e_book_sqlite_new_full(p_path: [*:0]const u8, p_source: ?*edataserver.Source, p_setup: ?*ebookcontacts.SourceBackendSummarySetup, p_vcard_callback: ?edatabook.bSqlVCardCallback, p_change_callback: ?edatabook.bSqlChangeCallback, p_user_data: ?*anyopaque, p_user_data_destroy: ?glib.DestroyNotify, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.BookSqlite;
    pub const newFull = e_book_sqlite_new_full;

    extern fn e_book_sqlite_add_contact(p_ebsql: *BookSqlite, p_contact: *ebookcontacts.Contact, p_extra: [*:0]const u8, p_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addContact = e_book_sqlite_add_contact;

    /// Adds or replaces contacts in `ebsql`. If `replace_existing` is specified then existing
    /// contacts with the same UID will be replaced, otherwise adding an existing contact
    /// will return an error.
    ///
    /// If `extra` is specified, it must have an equal length as the `contacts` list. Each element
    /// from the `extra` list will be stored in association with it's corresponding contact
    /// in the `contacts` list.
    extern fn e_book_sqlite_add_contacts(p_ebsql: *BookSqlite, p_contacts: *glib.SList, p_extra: ?*glib.SList, p_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addContacts = e_book_sqlite_add_contacts;

    /// Counts how many contacts satisfy the `sexp`.
    extern fn e_book_sqlite_count_query(p_ebsql: *BookSqlite, p_sexp: ?[*:0]const u8, p_out_n_total: *c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const countQuery = e_book_sqlite_count_query;

    /// Calculates the `total` amount of results for the `cursor`'s query expression,
    /// as well as the current `position` of `cursor` in the results. `position` is
    /// represented as the amount of results which lead up to the current value
    /// of `cursor`, if `cursor` currently points to an exact contact, the position
    /// also includes the cursor contact.
    extern fn e_book_sqlite_cursor_calculate(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor, p_total: ?*c_int, p_position: ?*c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const cursorCalculate = e_book_sqlite_cursor_calculate;

    /// Compares `contact` with `cursor` and returns whether `contact` is less than, equal to, or greater
    /// than `cursor`.
    extern fn e_book_sqlite_cursor_compare_contact(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor, p_contact: *ebookcontacts.Contact, p_matches_sexp: ?*c_int) c_int;
    pub const cursorCompareContact = e_book_sqlite_cursor_compare_contact;

    /// Frees `cursor`.
    extern fn e_book_sqlite_cursor_free(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor) void;
    pub const cursorFree = e_book_sqlite_cursor_free;

    /// Creates a new `edatabook.bSqlCursor`.
    ///
    /// The cursor should be freed with `edatabook.BookSqlite.cursorFree`.
    extern fn e_book_sqlite_cursor_new(p_ebsql: *BookSqlite, p_sexp: ?[*:0]const u8, p_sort_fields: [*]const ebookcontacts.ContactField, p_sort_types: [*]const ebookcontacts.BookCursorSortType, p_n_sort_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.bSqlCursor;
    pub const cursorNew = e_book_sqlite_cursor_new;

    /// Modifies the current query expression for `cursor`. This will not
    /// modify `cursor`'s state, but will change the outcome of any further
    /// calls to `edatabook.BookSqlite.cursorCalculate` or
    /// `edatabook.BookSqlite.cursorStep`.
    extern fn e_book_sqlite_cursor_set_sexp(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor, p_sexp: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const cursorSetSexp = e_book_sqlite_cursor_set_sexp;

    /// Sets the `cursor` position to an
    /// <link linkend="cursor-alphabet">Alphabetic Index</link>
    /// into the alphabet active in `ebsql`'s locale.
    ///
    /// After setting the target to an alphabetic index, for example the
    /// index for letter 'E', then further calls to `edatabook.BookSqlite.cursorStep`
    /// will return results starting with the letter 'E' (or results starting
    /// with the last result in 'D', if moving in a negative direction).
    ///
    /// The passed index must be a valid index in the active locale, knowledge
    /// on the currently active alphabet index must be obtained using `edataserver.Collator`
    /// APIs.
    ///
    /// Use `edatabook.BookSqlite.refCollator` to obtain the active collator for `ebsql`.
    extern fn e_book_sqlite_cursor_set_target_alphabetic_index(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor, p_idx: c_int) void;
    pub const cursorSetTargetAlphabeticIndex = e_book_sqlite_cursor_set_target_alphabetic_index;

    /// Steps `cursor` through its sorted query by a maximum of `count` contacts
    /// starting from `origin`.
    ///
    /// If `count` is negative, then the cursor will move through the list in reverse.
    ///
    /// If `cursor` reaches the beginning or end of the query results, then the
    /// returned list might not contain the amount of desired contacts, or might
    /// return no results if the cursor currently points to the last contact.
    /// Reaching the end of the list is not considered an error condition. Attempts
    /// to step beyond the end of the list after having reached the end of the list
    /// will however trigger an `E_BOOK_SQLITE_ERROR_END_OF_LIST` error.
    ///
    /// If `EBSQL_CURSOR_STEP_FETCH` is specified in `flags`, a pointer to
    /// a `NULL` `glib.SList` pointer should be provided for the `results` parameter.
    ///
    /// The result list will be stored to `results` and should be freed with `glib.SList.free`
    /// and all elements freed with `edatabook.BookSqlite.searchDataFree`.
    extern fn e_book_sqlite_cursor_step(p_ebsql: *BookSqlite, p_cursor: *edatabook.bSqlCursor, p_flags: edatabook.bSqlCursorStepFlags, p_origin: edatabook.bSqlCursorOrigin, p_count: c_int, p_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const cursorStep = e_book_sqlite_cursor_step;

    /// Queries the `ebsql` for the contacts in the given range and order.
    /// The `sort_field` should be in the summary, otherwise an error
    /// is returned.
    ///
    /// Free the `out_contacts` with `g_ptr_aray_unref`, when no longer needed.
    extern fn e_book_sqlite_dup_query_contacts(p_ebsql: *BookSqlite, p_sexp: ?[*:0]const u8, p_sort_field: ebookcontacts.ContactField, p_sort_type: ebookcontacts.BookCursorSortType, p_n_offset: c_uint, p_n_limit: c_uint, p_out_contacts: **glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupQueryContacts = e_book_sqlite_dup_query_contacts;

    /// Queries the `ebsql` for a `summary_field` value for contacts in the given range and order.
    /// To get complete contacts use `edatabook.BookSqlite.dupQueryContacts`. Note the field value may
    /// not correspond precisely to the value stored in the vCard (it can be in lower case).
    ///
    /// Both `summary_field` and `sort_field` should be in the summary, otherwise an error
    /// is returned.
    ///
    /// The `out_uids` and `out_values` will have the same number of elements,
    /// the indexes corresponding to each other. Free the arrays with
    /// `g_ptr_aray_unref`, when no longer needed.
    extern fn e_book_sqlite_dup_query_field(p_ebsql: *BookSqlite, p_summary_field: ebookcontacts.ContactField, p_sexp: ?[*:0]const u8, p_sort_field: ebookcontacts.ContactField, p_sort_type: ebookcontacts.BookCursorSortType, p_n_offset: c_uint, p_n_limit: c_uint, p_out_uids: **glib.PtrArray, p_out_values: **glib.PtrArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupQueryField = e_book_sqlite_dup_query_field;

    /// Queries the `ebsql` for a `summary_field` value for contact with UID `uid`.
    /// Note the field value may not correspond precisely to the value stored
    /// in the vCard (it can be in lower case).
    ///
    /// Free the `out_value` with `glib.free`, when no longer needed.
    extern fn e_book_sqlite_dup_summary_field(p_ebsql: *BookSqlite, p_summary_field: ebookcontacts.ContactField, p_uid: [*:0]const u8, p_out_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupSummaryField = e_book_sqlite_dup_summary_field;

    /// Executes an SQLite statement. Use `edatabook.BookSqlite.select` for
    /// SELECT statements.
    extern fn e_book_sqlite_exec(p_ebsql: *BookSqlite, p_sql_stmt: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const exec = e_book_sqlite_exec;

    /// Fetch the `ebookcontacts.Contact` specified by `uid` in `ebsql`.
    ///
    /// If `meta_contact` is specified, then a shallow `ebookcontacts.Contact` will be created
    /// holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_sqlite_get_contact(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_meta_contact: c_int, p_ret_contact: **ebookcontacts.Contact, p_error: ?*?*glib.Error) c_int;
    pub const getContact = e_book_sqlite_get_contact;

    /// Fetches the extra data previously set for `uid`, either with
    /// `edatabook.BookSqlite.setContactExtra` or when adding contacts.
    extern fn e_book_sqlite_get_contact_extra(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_ret_extra: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const getContactExtra = e_book_sqlite_get_contact_extra;

    /// Fetches the value for `key` and stores it in `value`
    extern fn e_book_sqlite_get_key_value(p_ebsql: *BookSqlite, p_key: [*:0]const u8, p_value: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const getKeyValue = e_book_sqlite_get_key_value;

    /// A convenience function to fetch the value of `key` as an integer.
    extern fn e_book_sqlite_get_key_value_int(p_ebsql: *BookSqlite, p_key: [*:0]const u8, p_value: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const getKeyValueInt = e_book_sqlite_get_key_value_int;

    /// Fetches the current locale setting for the address-book.
    ///
    /// Upon success, `lc_collate_out` will hold the returned locale setting,
    /// otherwise `FALSE` will be returned and `error` will be updated accordingly.
    extern fn e_book_sqlite_get_locale(p_ebsql: *BookSqlite, p_locale_out: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const getLocale = e_book_sqlite_get_locale;

    /// Fetch a vcard string for `uid` in `ebsql`.
    ///
    /// If `meta_contact` is specified, then a shallow vcard representation will be
    /// created holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_sqlite_get_vcard(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_meta_contact: c_int, p_ret_vcard: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const getVcard = e_book_sqlite_get_vcard;

    /// Checks if a contact bearing the UID indicated by `uid` is stored in `ebsql`.
    extern fn e_book_sqlite_has_contact(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_exists: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const hasContact = e_book_sqlite_has_contact;

    /// Obtains an exclusive lock on `ebsql` and starts a transaction.
    ///
    /// This should be called if you need to access `ebsql` multiple times while
    /// ensuring an atomic transaction. End this transaction with `edatabook.BookSqlite.unlock`.
    ///
    /// If `cancellable` is specified, then `ebsql` will retain a reference to it until
    /// `edatabook.BookSqlite.unlock` is called. Any accesses to `ebsql` with the lock held
    /// are expected to have the same `cancellable` specified, or `NULL`.
    ///
    /// <note><para>Aside from ensuring atomicity of transactions, this function will hold a mutex
    /// which will cause further calls to `edatabook.BookSqlite.lock` to block. If you are accessing
    /// `ebsql` from multiple threads, then any interactions with `ebsql` should be nested in calls
    /// to `edatabook.BookSqlite.lock` and `edatabook.BookSqlite.unlock`.</para></note>
    extern fn e_book_sqlite_lock(p_ebsql: *BookSqlite, p_lock_type: edatabook.bSqlLockType, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const lock = e_book_sqlite_lock;

    /// References the currently active `edataserver.Collator` for `ebsql`,
    /// use `edataserver.Collator.unref` when finished using the returned collator.
    ///
    /// Note that the active collator will change with the active locale setting.
    extern fn e_book_sqlite_ref_collator(p_ebsql: *BookSqlite) *edataserver.Collator;
    pub const refCollator = e_book_sqlite_ref_collator;

    /// References the `edataserver.Source` to which `ebsql` is paired,
    /// use `gobject.Object.unref` when finished using the source.
    /// It can be `NULL` in some cases, like when running tests.
    extern fn e_book_sqlite_ref_source(p_ebsql: *BookSqlite) ?*edataserver.Source;
    pub const refSource = e_book_sqlite_ref_source;

    /// Removes the contact indicated by `uid` from `ebsql`.
    extern fn e_book_sqlite_remove_contact(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContact = e_book_sqlite_remove_contact;

    /// Removes the contacts indicated by `uids` from `ebsql`.
    extern fn e_book_sqlite_remove_contacts(p_ebsql: *BookSqlite, p_uids: *glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContacts = e_book_sqlite_remove_contacts;

    /// Searches `ebsql` for contacts matching the search expression indicated by `sexp`.
    ///
    /// When `sexp` refers only to `EContactFields` configured in the summary of `ebsql`,
    /// the search should always be quick, when searching for other `EContactFields`
    /// a fallback will be used, possibly invoking any `edatabook.bSqlVCardCallback` which
    /// may have been passed to `edatabook.BookSqlite.newFull`.
    ///
    /// The returned `ret_list` list should be freed with `glib.SList.free`
    /// and all elements freed with `edatabook.BookSqlite.searchDataFree`.
    ///
    /// If `meta_contact` is specified, then shallow vcard representations will be
    /// created holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
    extern fn e_book_sqlite_search(p_ebsql: *BookSqlite, p_sexp: ?[*:0]const u8, p_meta_contacts: c_int, p_ret_list: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const search = e_book_sqlite_search;

    /// Similar to `e_book_sqlitedb_search`, but fetches only a list of contact UIDs.
    ///
    /// The returned `ret_list` list should be freed with `glib.SList.free` and all
    /// elements freed with `glib.free`.
    extern fn e_book_sqlite_search_uids(p_ebsql: *BookSqlite, p_sexp: ?[*:0]const u8, p_ret_list: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchUids = e_book_sqlite_search_uids;

    /// Executes a SELECT statement `sql_stmt` and calls `func` for each row of the result.
    /// Use `edatabook.BookSqlite.exec` for statements which do not return row sets.
    extern fn e_book_sqlite_select(p_ebsql: *BookSqlite, p_sql_stmt: [*:0]const u8, p_func: edatabook.BookSqliteSelectFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const select = e_book_sqlite_select;

    /// Sets or replaces the extra data associated with `uid`.
    extern fn e_book_sqlite_set_contact_extra(p_ebsql: *BookSqlite, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const setContactExtra = e_book_sqlite_set_contact_extra;

    /// Sets the value for `key` to be `value`
    extern fn e_book_sqlite_set_key_value(p_ebsql: *BookSqlite, p_key: [*:0]const u8, p_value: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const setKeyValue = e_book_sqlite_set_key_value;

    /// A convenience function to set the value of `key` as an integer.
    extern fn e_book_sqlite_set_key_value_int(p_ebsql: *BookSqlite, p_key: [*:0]const u8, p_value: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setKeyValueInt = e_book_sqlite_set_key_value_int;

    /// Relocalizes any locale specific data in the specified
    /// new `lc_collate` locale.
    ///
    /// The `lc_collate` locale setting is stored and remembered on
    /// subsequent accesses of the addressbook, changing the locale
    /// will store the new locale and will modify sort keys and any
    /// locale specific data in the addressbook.
    ///
    /// As a side effect, it's possible that changing the locale
    /// will cause stored vcards to change. Notifications for
    /// these changes can be caught with the `edatabook.bSqlVCardCallback`
    /// provided to `edatabook.BookSqlite.newFull`.
    extern fn e_book_sqlite_set_locale(p_ebsql: *BookSqlite, p_lc_collate: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setLocale = e_book_sqlite_set_locale;

    /// Releases an exclusive on `ebsql` and finishes a transaction previously
    /// started with `e_book_sqlite_lock_updates`.
    ///
    /// <note><para>If this fails, the lock on `ebsql` is still released and `error` will
    /// be set to indicate why the transaction or rollback failed.</para></note>
    extern fn e_book_sqlite_unlock(p_ebsql: *BookSqlite, p_action: edatabook.bSqlUnlockAction, p_error: ?*?*glib.Error) c_int;
    pub const unlock = e_book_sqlite_unlock;

    extern fn e_book_sqlite_get_type() usize;
    pub const getGObjectType = e_book_sqlite_get_type;

    extern fn g_object_ref(p_self: *edatabook.BookSqlite) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.BookSqlite) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookSqlite, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBook = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatabook.DataBookClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.DataBookPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*edatabook.BookBackend;
        };

        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Takes a list of strings and converts it to a comma-separated string of
    /// values; free returned pointer with `glib.free`
    extern fn e_data_book_string_slist_to_comma_string(p_strings: *const glib.SList) [*:0]u8;
    pub const stringSlistToCommaString = e_data_book_string_slist_to_comma_string;

    /// Creates a new `edatabook.DataBook` and exports the AddressBook D-Bus interface
    /// on `connection` at `object_path`.  The `edatabook.DataBook` handles incoming remote
    /// method invocations and forwards them to the `backend`.  If the AddressBook
    /// interface fails to export, the function sets `error` and returns `NULL`.
    extern fn e_data_book_new(p_backend: *edatabook.BookBackend, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*edatabook.DataBook;
    pub const new = e_data_book_new;

    /// Returns the `gio.DBusConnection` on which the AddressBook D-Bus interface
    /// is exported.
    extern fn e_data_book_get_connection(p_book: *DataBook) *gio.DBusConnection;
    pub const getConnection = e_data_book_get_connection;

    /// Returns the object path at which the AddressBook D-Bus interface is
    /// exported.
    extern fn e_data_book_get_object_path(p_book: *DataBook) [*:0]const u8;
    pub const getObjectPath = e_data_book_get_object_path;

    /// Returns the `edatabook.BookBackend` to which incoming remote method invocations
    /// are being forwarded.
    ///
    /// The returned `edatabook.BookBackend` is referenced for thread-safety and should
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_data_book_ref_backend(p_book: *DataBook) *edatabook.BookBackend;
    pub const refBackend = e_data_book_ref_backend;

    /// Notifies the clients about a property change.
    extern fn e_data_book_report_backend_property_changed(p_book: *DataBook, p_prop_name: [*:0]const u8, p_prop_value: ?[*:0]const u8) void;
    pub const reportBackendPropertyChanged = e_data_book_report_backend_property_changed;

    /// Notifies the clients about an error, which happened out of any client-initiate operation.
    extern fn e_data_book_report_error(p_book: *DataBook, p_message: [*:0]const u8) void;
    pub const reportError = e_data_book_report_error;

    /// Finishes a call to check whether contains an email address.
    extern fn e_data_book_respond_contains_email(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_found: c_int) void;
    pub const respondContainsEmail = e_data_book_respond_contains_email;

    /// Finishes a call to create a list contacts.
    extern fn e_data_book_respond_create_contacts(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_contacts: *const glib.SList) void;
    pub const respondCreateContacts = e_data_book_respond_create_contacts;

    /// Notifies listeners of the completion of the get_contact method call.
    /// Only one of `error` and `contact` can be set.
    extern fn e_data_book_respond_get_contact(p_book: *DataBook, p_opid: u32, p_error: ?*glib.Error, p_contact: ?*const ebookcontacts.Contact) void;
    pub const respondGetContact = e_data_book_respond_get_contact;

    /// Finishes a call to get list of `ebookcontacts.Contact`, which satisfy certain criteria.
    extern fn e_data_book_respond_get_contact_list(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_contacts: *const glib.SList) void;
    pub const respondGetContactList = e_data_book_respond_get_contact_list;

    /// Finishes a call to get list of UIDs which satisfy certain criteria.
    extern fn e_data_book_respond_get_contact_list_uids(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_uids: *const glib.SList) void;
    pub const respondGetContactListUids = e_data_book_respond_get_contact_list_uids;

    /// Finishes a call to modify a list of contacts.
    extern fn e_data_book_respond_modify_contacts(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_contacts: *const glib.SList) void;
    pub const respondModifyContacts = e_data_book_respond_modify_contacts;

    /// Notifies listeners of the completion of the open method call.
    extern fn e_data_book_respond_open(p_book: *DataBook, p_opid: u32, p_error: *glib.Error) void;
    pub const respondOpen = e_data_book_respond_open;

    /// Notifies listeners of the completion of the refresh method call.
    extern fn e_data_book_respond_refresh(p_book: *DataBook, p_opid: u32, p_error: *glib.Error) void;
    pub const respondRefresh = e_data_book_respond_refresh;

    /// Finishes a call to remove a list of contacts.
    extern fn e_data_book_respond_remove_contacts(p_book: *DataBook, p_opid: u32, p_error: *glib.Error, p_ids: *const glib.SList) void;
    pub const respondRemoveContacts = e_data_book_respond_remove_contacts;

    /// Set's the locale for this addressbook, this can result in renormalization of
    /// locale sensitive data.
    extern fn e_data_book_set_locale(p_book: *DataBook, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setLocale = e_data_book_set_locale;

    extern fn e_data_book_get_type() usize;
    pub const getGObjectType = e_data_book_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBook) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBook) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBook, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque handle for an addressbook cursor
pub const DataBookCursor = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookCursorClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.DataBookCursorPrivate,

    pub const virtual_methods = struct {
        /// The `edatabook.DataBookCursorCompareContactFunc` delegate to compare an `ebookcontacts.Contact` with the cursor position
        pub const compare_contact = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact, p_matches_sexp: ?*c_int) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_compare_contact.?(gobject.ext.as(DataBookCursor, p_cursor), p_contact, p_matches_sexp);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_contact: *ebookcontacts.Contact, p_matches_sexp: ?*c_int) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_compare_contact = @ptrCast(p_implementation);
            }
        };

        /// The `edatabook.DataBookCursorGetPositionFunc` delegate to calculate the current total and position values
        pub const get_position = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_total: *c_int, p_position: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_get_position.?(gobject.ext.as(DataBookCursor, p_cursor), p_total, p_position, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_total: *c_int, p_position: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_get_position = @ptrCast(p_implementation);
            }
        };

        /// The `edatabook.DataBookCursorLoadLocaleFunc` delegate used to reload the locale setting
        pub const load_locale = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_locale: *[*:0]u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_load_locale.?(gobject.ext.as(DataBookCursor, p_cursor), p_locale, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_locale: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_load_locale = @ptrCast(p_implementation);
            }
        };

        /// The `edatabook.DataBookCursorSetAlphabetIndexFunc` delegate to set the alphabetic position
        pub const set_alphabetic_index = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_int, p_locale: [*:0]const u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_set_alphabetic_index.?(gobject.ext.as(DataBookCursor, p_cursor), p_index, p_locale, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index: c_int, p_locale: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_set_alphabetic_index = @ptrCast(p_implementation);
            }
        };

        /// The `edatabook.DataBookCursorSetSexpFunc` delegate to set the search expression
        pub const set_sexp = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sexp: ?[*:0]const u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_set_sexp.?(gobject.ext.as(DataBookCursor, p_cursor), p_sexp, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sexp: ?[*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_set_sexp = @ptrCast(p_implementation);
            }
        };

        /// Steps `cursor` through its sorted query by a maximum of `count` contacts
        /// starting from `origin`.
        ///
        /// If `count` is negative, then the cursor will move through the list in reverse.
        ///
        /// If `cursor` reaches the beginning or end of the query results, then the
        /// returned list might not contain the amount of desired contacts, or might
        /// return no results if the cursor currently points to the last contact.
        /// Reaching the end of the list is not considered an error condition. Attempts
        /// to step beyond the end of the list after having reached the end of the list
        /// will however trigger an `E_CLIENT_ERROR_QUERY_REFUSED` error.
        ///
        /// If `E_BOOK_CURSOR_STEP_FETCH` is specified in `flags`, a pointer to
        /// a `NULL` `glib.SList` pointer should be provided for the `results` parameter.
        ///
        /// The result list will be stored to `results` and should be freed with `glib.SList.free`
        /// and all elements freed with `glib.free`.
        ///
        /// If a `revision_guard` is specified, the cursor implementation will issue an
        /// `E_CLIENT_ERROR_OUT_OF_SYNC` error if the `revision_guard` does not match
        /// the current addressbook revision.
        ///
        /// An explanation of how stepping is expected to behave can be found
        /// in the <link linkend="cursor-iteration">user facing reference documentation</link>.
        pub const step = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_revision_guard: ?[*:0]const u8, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(DataBookCursor.Class, p_class).f_step.?(gobject.ext.as(DataBookCursor, p_cursor), p_revision_guard, p_flags, p_origin, p_count, p_results, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_revision_guard: ?[*:0]const u8, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(DataBookCursor.Class, p_class).f_step = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*edatabook.BookBackend;
        };

        pub const position = struct {
            pub const name = "position";

            pub const Type = c_int;
        };

        pub const total = struct {
            pub const name = "total";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Should be called by addressbook backends whenever a contact
    /// is added.
    extern fn e_data_book_cursor_contact_added(p_cursor: *DataBookCursor, p_contact: *ebookcontacts.Contact) void;
    pub const contactAdded = e_data_book_cursor_contact_added;

    /// Should be called by addressbook backends whenever a contact
    /// is removed.
    extern fn e_data_book_cursor_contact_removed(p_cursor: *DataBookCursor, p_contact: *ebookcontacts.Contact) void;
    pub const contactRemoved = e_data_book_cursor_contact_removed;

    /// Gets the backend which created and owns `cursor`.
    extern fn e_data_book_cursor_get_backend(p_cursor: *DataBookCursor) *edatabook.BookBackend;
    pub const getBackend = e_data_book_cursor_get_backend;

    /// Fetch the current position of `cursor` in its result list.
    extern fn e_data_book_cursor_get_position(p_cursor: *DataBookCursor) c_int;
    pub const getPosition = e_data_book_cursor_get_position;

    /// Fetch the total number of contacts which match `cursor`'s query expression.
    extern fn e_data_book_cursor_get_total(p_cursor: *DataBookCursor) c_int;
    pub const getTotal = e_data_book_cursor_get_total;

    /// Load the current locale setting from the cursor's underlying database.
    ///
    /// Addressbook backends implementing cursors should call this function on all active
    /// cursor when the locale setting changes.
    ///
    /// This will implicitly reset `cursor`'s state and position.
    extern fn e_data_book_cursor_load_locale(p_cursor: *DataBookCursor, p_locale: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const loadLocale = e_data_book_cursor_load_locale;

    /// Recalculates the cursor's total and position, this is meant
    /// for cursor created in Direct Read Access mode to synchronously
    /// recalculate the position and total values when the addressbook
    /// revision has changed.
    extern fn e_data_book_cursor_recalculate(p_cursor: *DataBookCursor, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const recalculate = e_data_book_cursor_recalculate;

    /// Places `cursor` on the `connection` at `object_path`
    extern fn e_data_book_cursor_register_gdbus_object(p_cursor: *DataBookCursor, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const registerGdbusObject = e_data_book_cursor_register_gdbus_object;

    /// Sets the `cursor` position to an
    /// <link linkend="cursor-alphabet">Alphabetic Index</link>
    /// into the alphabet active in the `locale` of the addressbook.
    ///
    /// After setting the target to an alphabetic index, for example the
    /// index for letter 'E', then further calls to `edatabook.DataBookCursor.step`
    /// will return results starting with the letter 'E' (or results starting
    /// with the last result in 'D', if moving in a negative direction).
    ///
    /// The passed index must be a valid index in `locale`, if by some chance
    /// the addressbook backend has changed into a new locale after this
    /// call has been issued, an `E_CLIENT_ERROR_OUT_OF_SYNC` error will be
    /// issued indicating that there was a locale mismatch.
    extern fn e_data_book_cursor_set_alphabetic_index(p_cursor: *DataBookCursor, p_index: c_int, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setAlphabeticIndex = e_data_book_cursor_set_alphabetic_index;

    /// Sets the search expression for the cursor
    extern fn e_data_book_cursor_set_sexp(p_cursor: *DataBookCursor, p_sexp: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setSexp = e_data_book_cursor_set_sexp;

    /// Steps `cursor` through its sorted query by a maximum of `count` contacts
    /// starting from `origin`.
    ///
    /// If `count` is negative, then the cursor will move through the list in reverse.
    ///
    /// If `cursor` reaches the beginning or end of the query results, then the
    /// returned list might not contain the amount of desired contacts, or might
    /// return no results if the cursor currently points to the last contact.
    /// Reaching the end of the list is not considered an error condition. Attempts
    /// to step beyond the end of the list after having reached the end of the list
    /// will however trigger an `E_CLIENT_ERROR_QUERY_REFUSED` error.
    ///
    /// If `E_BOOK_CURSOR_STEP_FETCH` is specified in `flags`, a pointer to
    /// a `NULL` `glib.SList` pointer should be provided for the `results` parameter.
    ///
    /// The result list will be stored to `results` and should be freed with `glib.SList.free`
    /// and all elements freed with `glib.free`.
    ///
    /// If a `revision_guard` is specified, the cursor implementation will issue an
    /// `E_CLIENT_ERROR_OUT_OF_SYNC` error if the `revision_guard` does not match
    /// the current addressbook revision.
    ///
    /// An explanation of how stepping is expected to behave can be found
    /// in the <link linkend="cursor-iteration">user facing reference documentation</link>.
    extern fn e_data_book_cursor_step(p_cursor: *DataBookCursor, p_revision_guard: ?[*:0]const u8, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const step = e_data_book_cursor_step;

    extern fn e_data_book_cursor_get_type() usize;
    pub const getGObjectType = e_data_book_cursor_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookCursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookCursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookCursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque handle for the `edatabook.BookCache` cursor instance.
pub const DataBookCursorCache = extern struct {
    pub const Parent = edatabook.DataBookCursor;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookCursorCacheClass;
    f_parent: edatabook.DataBookCursor,
    f_priv: ?*edatabook.DataBookCursorCachePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const book_cache = struct {
            pub const name = "book-cache";

            pub const Type = ?*edatabook.BookCache;
        };

        pub const cursor = struct {
            pub const name = "cursor";

            pub const Type = ?*anyopaque;
        };
    };

    pub const signals = struct {};

    /// Creates an `edatabook.DataBookCursor` and implements all of the cursor methods
    /// using the delegate `book_cache` object.
    ///
    /// This is suitable cursor type for any backend which stores its contacts
    /// using the `edatabook.BookCache` object. The `edatabook.BookMetaBackend` does that transparently.
    extern fn e_data_book_cursor_cache_new(p_book_backend: *edatabook.BookBackend, p_book_cache: *edatabook.BookCache, p_sort_fields: [*]const ebookcontacts.ContactField, p_sort_types: [*]const ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.DataBookCursorCache;
    pub const new = e_data_book_cursor_cache_new;

    extern fn e_data_book_cursor_cache_get_type() usize;
    pub const getGObjectType = e_data_book_cursor_cache_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookCursorCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookCursorCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookCursorCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque handle for the SQLite cursor instance.
pub const DataBookCursorSqlite = extern struct {
    pub const Parent = edatabook.DataBookCursor;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookCursorSqliteClass;
    f_parent: edatabook.DataBookCursor,
    f_priv: ?*edatabook.DataBookCursorSqlitePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const cursor = struct {
            pub const name = "cursor";

            pub const Type = ?*anyopaque;
        };

        pub const ebsql = struct {
            pub const name = "ebsql";

            pub const Type = ?*edatabook.BookSqlite;
        };

        pub const revision_key = struct {
            pub const name = "revision-key";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates an `edatabook.DataBookCursor` and implements all of the cursor methods
    /// using the delegate `ebsql` object.
    ///
    /// This is a suitable cursor type for any backend which stores its contacts
    /// using the `edatabook.BookSqlite` object.
    extern fn e_data_book_cursor_sqlite_new(p_backend: *edatabook.BookBackend, p_ebsql: *edatabook.BookSqlite, p_revision_key: [*:0]const u8, p_sort_fields: [*]const ebookcontacts.ContactField, p_sort_types: [*]const ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.DataBookCursorSqlite;
    pub const new = e_data_book_cursor_sqlite_new;

    extern fn e_data_book_cursor_sqlite_get_type() usize;
    pub const getGObjectType = e_data_book_cursor_sqlite_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookCursorSqlite) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookCursorSqlite) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookCursorSqlite, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookDirect = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookDirectClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.DataBookDirectPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates an `edatabook.DataBookDirect` to report configuration data needed for direct
    /// read access.
    ///
    /// This is returned by `edatabook.BookBackend.getDirectBook` for backends
    /// which support direct read access mode.
    extern fn e_data_book_direct_new(p_backend_path: [*:0]const u8, p_backend_factory_name: [*:0]const u8, p_config: [*:0]const u8) *edatabook.DataBookDirect;
    pub const new = e_data_book_direct_new;

    /// Places `direct` on the `connection` at `object_path`
    extern fn e_data_book_direct_register_gdbus_object(p_direct: *DataBookDirect, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const registerGdbusObject = e_data_book_direct_register_gdbus_object;

    extern fn e_data_book_direct_get_type() usize;
    pub const getGObjectType = e_data_book_direct_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookDirect) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookDirect) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookDirect, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookFactory = extern struct {
    pub const Parent = ebackend.DataFactory;
    pub const Implements = [_]type{ edataserver.Extensible, gio.Initable };
    pub const Class = edatabook.DataBookFactoryClass;
    f_parent: ebackend.DataFactory,
    f_priv: ?*edatabook.DataBookFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_data_book_factory_new(p_backend_per_process: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.DataBookFactory;
    pub const new = e_data_book_factory_new;

    extern fn e_data_book_factory_get_type() usize;
    pub const getGObjectType = e_data_book_factory_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookView = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatabook.DataBookViewClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.DataBookViewPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*edatabook.BookBackend;
        };

        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        pub const indices = struct {
            pub const name = "indices";

            pub const Type = ?*anyopaque;
        };

        pub const n_total = struct {
            pub const name = "n-total";

            pub const Type = c_uint;
        };

        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };

        pub const sexp = struct {
            pub const name = "sexp";

            pub const Type = ?*edatabook.BookBackendSExp;
        };
    };

    pub const signals = struct {
        /// Emitted when new objects are added into the `view`.
        ///
        /// Note: This signal is used only when the view has
        ///    set `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` flag.
        pub const objects_added = struct {
            pub const name = "objects-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_vcards: [*][*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DataBookView, p_instance))),
                    gobject.signalLookup("objects-added", DataBookView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the objects in the `view` are modified.
        ///
        /// Note: This signal is used only when the view has
        ///    set `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` flag.
        pub const objects_modified = struct {
            pub const name = "objects-modified";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_vcards: [*][*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DataBookView, p_instance))),
                    gobject.signalLookup("objects-modified", DataBookView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the objects are removed from the `view`.
        ///
        /// Note: This signal is used only when the view has
        ///    set `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY` flag.
        pub const objects_removed = struct {
            pub const name = "objects-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_uids: [*][*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DataBookView, p_instance))),
                    gobject.signalLookup("objects-removed", DataBookView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `edatabook.DataBookView` and exports its D-Bus interface on
    /// `connection` at `object_path`.  If an error occurs while exporting,
    /// the function sets `error` and returns `NULL`.
    extern fn e_data_book_view_new(p_backend: *edatabook.BookBackend, p_sexp: *edatabook.BookBackendSExp, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*edatabook.DataBookView;
    pub const new = e_data_book_view_new;

    /// Tells the `self`, that it contains a contact with UID `uid`. This is useful
    /// for "manual query" view, which do not do initial notifications. It helps
    /// to not send "objects-added" signal for contacts, which are already part
    /// of the `self`, because for them the "objects-modified" should be emitted
    /// instead.
    extern fn e_data_book_view_claim_contact_uid(p_self: *DataBookView, p_uid: [*:0]const u8) void;
    pub const claimContactUid = e_data_book_view_claim_contact_uid;

    /// Reads `range_length` contacts from index `range_start`.
    /// When there are asked more than `edatabook.DataBookView.getNTotal`
    /// contacts only those up to the total number of contacts are read.
    ///
    /// Free the returned `glib.PtrArray` with `glib.PtrArray.unref`,
    /// when no longer needed.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_dup_contacts(p_self: *DataBookView, p_range_start: c_uint, p_range_length: c_uint) ?*glib.PtrArray;
    pub const dupContacts = e_data_book_view_dup_contacts;

    /// Returns a list of `ebookcontacts.BookIndices` holding indices of the contacts
    /// in the view. These are received from the first sort field set by
    /// `edatabook.DataBookView.setSortFields`. The last item of the returned
    /// array is the one with chr member being `NULL`.
    ///
    /// Free the returned array with `ebookcontacts.BookIndices.free`, when no longer needed.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_dup_indices(p_self: *DataBookView) ?*ebookcontacts.BookIndices;
    pub const dupIndices = e_data_book_view_dup_indices;

    /// Returns the `gio.DBusConnection` on which the AddressBookView D-Bus
    /// interface is exported.
    extern fn e_data_book_view_get_connection(p_view: *DataBookView) *gio.DBusConnection;
    pub const getConnection = e_data_book_view_get_connection;

    extern fn e_data_book_view_get_fields_of_interest(p_view: *DataBookView) ?*glib.HashTable;
    pub const getFieldsOfInterest = e_data_book_view_get_fields_of_interest;

    /// Gets the `ebookcontacts.BookClientViewFlags` that control the behaviour of `view`.
    extern fn e_data_book_view_get_flags(p_view: *DataBookView) ebookcontacts.BookClientViewFlags;
    pub const getFlags = e_data_book_view_get_flags;

    /// Returns whether the `view` should do initial notifications
    /// even when the flags do not contain `E_BOOK_CLIENT_VIEW_FLAGS_NOTIFY_INITIAL`.
    /// The default is `FALSE`.
    extern fn e_data_book_view_get_force_initial_notifications(p_view: *DataBookView) c_int;
    pub const getForceInitialNotifications = e_data_book_view_get_force_initial_notifications;

    /// Returns an identifier of the `self`. It does not change
    /// for the whole life time of the `self`.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_get_id(p_self: *DataBookView) usize;
    pub const getId = e_data_book_view_get_id;

    /// Returns how many contacts are available in the view.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_get_n_total(p_self: *DataBookView) c_uint;
    pub const getNTotal = e_data_book_view_get_n_total;

    /// Returns the object path at which the AddressBookView D-Bus interface
    /// is exported.
    extern fn e_data_book_view_get_object_path(p_view: *DataBookView) [*:0]const u8;
    pub const getObjectPath = e_data_book_view_get_object_path;

    /// Gets the s-expression used for matching contacts to `view`.
    extern fn e_data_book_view_get_sexp(p_view: *DataBookView) *edatabook.BookBackendSExp;
    pub const getSexp = e_data_book_view_get_sexp;

    extern fn e_data_book_view_is_completed(p_view: *DataBookView) c_int;
    pub const isCompleted = e_data_book_view_is_completed;

    /// Notifies listeners that all pending updates on `view`
    /// have been sent. The listener's information should now be
    /// in sync with the backend's.
    extern fn e_data_book_view_notify_complete(p_view: *DataBookView, p_error: *const glib.Error) void;
    pub const notifyComplete = e_data_book_view_notify_complete;

    /// Notifies the client side that the content of the `self` changed,
    /// which it should use to refresh the view data.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_notify_content_changed(p_self: *DataBookView) void;
    pub const notifyContentChanged = e_data_book_view_notify_content_changed;

    /// Provides listeners with a human-readable text describing the
    /// current backend operation. This can be used for progress
    /// reporting.
    extern fn e_data_book_view_notify_progress(p_view: *DataBookView, p_percent: c_uint, p_message: [*:0]const u8) void;
    pub const notifyProgress = e_data_book_view_notify_progress;

    /// Notify listeners that a contact specified by `id`
    /// was removed from `view`.
    extern fn e_data_book_view_notify_remove(p_view: *DataBookView, p_id: [*:0]const u8) void;
    pub const notifyRemove = e_data_book_view_notify_remove;

    /// Notify listeners that `contact` has changed. This can
    /// trigger an add, change or removal event depending on
    /// whether the change causes the contact to start matching,
    /// no longer match, or stay matching the query specified
    /// by `view`.
    extern fn e_data_book_view_notify_update(p_view: *DataBookView, p_contact: *const ebookcontacts.Contact) void;
    pub const notifyUpdate = e_data_book_view_notify_update;

    /// Notify listeners that `vcard` has changed. This can
    /// trigger an add, change or removal event depending on
    /// whether the change causes the contact to start matching,
    /// no longer match, or stay matching the query specified
    /// by `view`.  This method should be preferred over
    /// `edatabook.DataBookView.notifyUpdate` when the native
    /// representation of a contact is a vCard.
    ///
    /// The important difference between this method and
    /// `edatabook.DataBookView.notifyUpdate` and
    /// `edatabook.DataBookView.notifyUpdateVcard` is
    /// that it doesn't match the contact against the book view query to see if it
    /// should be included, it assumes that this has been done and the contact is
    /// known to exist in the view.
    extern fn e_data_book_view_notify_update_prefiltered_vcard(p_view: *DataBookView, p_id: [*:0]const u8, p_vcard: [*:0]const u8) void;
    pub const notifyUpdatePrefilteredVcard = e_data_book_view_notify_update_prefiltered_vcard;

    /// Notify listeners that `vcard` has changed. This can
    /// trigger an add, change or removal event depending on
    /// whether the change causes the contact to start matching,
    /// no longer match, or stay matching the query specified
    /// by `view`.  This method should be preferred over
    /// `edatabook.DataBookView.notifyUpdate` when the native
    /// representation of a contact is a vCard.
    extern fn e_data_book_view_notify_update_vcard(p_view: *DataBookView, p_id: [*:0]const u8, p_vcard: [*:0]const u8) void;
    pub const notifyUpdateVcard = e_data_book_view_notify_update_vcard;

    /// Refs the backend that `view` is querying. Unref the returned backend,
    /// if not `NULL`, with `gobject.Object.unref`, when no longer needed.
    extern fn e_data_book_view_ref_backend(p_view: *DataBookView) ?*edatabook.BookBackend;
    pub const refBackend = e_data_book_view_ref_backend;

    /// Sets whether the `view` should do initial notifications
    /// even when the flags do not contain `E_BOOK_CLIENT_VIEW_FLAGS_NOTIFY_INITIAL`.
    extern fn e_data_book_view_set_force_initial_notifications(p_view: *DataBookView, p_value: c_int) void;
    pub const setForceInitialNotifications = e_data_book_view_set_force_initial_notifications;

    /// Sets indices used by the `self`. The array is terminated by an item
    /// with chr member being `NULL`.
    /// See `edatabook.DataBookView.dupIndices` for more information.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_set_indices(p_self: *DataBookView, p_indices: *const ebookcontacts.BookIndices) void;
    pub const setIndices = e_data_book_view_set_indices;

    /// Sets how many contacts are available in the view.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_set_n_total(p_self: *DataBookView, p_n_total: c_uint) void;
    pub const setNTotal = e_data_book_view_set_n_total;

    /// Sets `fields` to sort the view by. The default is to sort by the file-as
    /// field. The contacts are always sorted in ascending order. Not every field
    /// can be used for sorting, the default available fields are `E_CONTACT_FILE_AS`,
    /// `E_CONTACT_GIVEN_NAME` and `E_CONTACT_FAMILY_NAME`.
    ///
    /// The first sort field is used to populate indices, as returned
    /// by `edatabook.DataBookView.dupIndices`.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_data_book_view_set_sort_fields(p_self: *DataBookView, p_fields: *const ebookcontacts.BookClientViewSortFields) void;
    pub const setSortFields = e_data_book_view_set_sort_fields;

    extern fn e_data_book_view_get_type() usize;
    pub const getGObjectType = e_data_book_view_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure used to handle "manual query" views for `edatabook.BookBackend`
/// descendants which use `edatabook.BookCache` to store the contacts.
pub const DataBookViewWatcherCache = extern struct {
    pub const Parent = ebookcontacts.BookIndicesUpdater;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookViewWatcherCacheClass;
    f_parent: ebookcontacts.BookIndicesUpdater,
    f_priv: ?*edatabook.DataBookViewWatcherCachePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edatabook.DataBookViewWatcherCache`, which will watch the `view`
    /// and will provide the information about indices and total contacts
    /// to the `backend`, taking the data from the `cache`.
    extern fn e_data_book_view_watcher_cache_new(p_backend: *edatabook.BookBackend, p_cache: *edatabook.BookCache, p_view: *edatabook.DataBookView) *edatabook.DataBookViewWatcherCache;
    pub const new = e_data_book_view_watcher_cache_new;

    /// Retrieves contacts in the given range. Returns `NULL` when the `range_start`
    /// is out of bounds. The function can return less than `range_length` contacts.
    ///
    /// The returned array should be freed with `glib.PtrArray.unref`,
    /// when no longer needed.
    extern fn e_data_book_view_watcher_cache_dup_contacts(p_self: *DataBookViewWatcherCache, p_range_start: c_uint, p_range_length: c_uint) ?*glib.PtrArray;
    pub const dupContacts = e_data_book_view_watcher_cache_dup_contacts;

    /// Sets `sort_fields` as fields to sort the contacts by. If `NULL`,
    /// sorts by file-as field. The function assumes ownership of the `sort_fields`.
    extern fn e_data_book_view_watcher_cache_take_sort_fields(p_self: *DataBookViewWatcherCache, p_sort_fields: ?*ebookcontacts.BookClientViewSortFields) void;
    pub const takeSortFields = e_data_book_view_watcher_cache_take_sort_fields;

    extern fn e_data_book_view_watcher_cache_get_type() usize;
    pub const getGObjectType = e_data_book_view_watcher_cache_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookViewWatcherCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookViewWatcherCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookViewWatcherCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure used as a default implementation to
/// handle "manual query" views by the `edatabook.BookBackend`.
pub const DataBookViewWatcherMemory = extern struct {
    pub const Parent = ebookcontacts.BookIndicesUpdater;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookViewWatcherMemoryClass;
    f_parent: ebookcontacts.BookIndicesUpdater,
    f_priv: ?*edatabook.DataBookViewWatcherMemoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edatabook.DataBookViewWatcherMemory`, which will watch the `view`
    /// and will provide the information about indices and total contacts
    /// to the `backend`. The locale is taken from the `backend` during
    /// the creation process too.
    extern fn e_data_book_view_watcher_memory_new(p_backend: *edatabook.BookBackend, p_view: *edatabook.DataBookView) *edatabook.DataBookViewWatcherMemory;
    pub const new = e_data_book_view_watcher_memory_new;

    /// Retrieves contacts in the given range. Returns `NULL` when the `range_start`
    /// is out of bounds. The function can return less than `range_length` contacts.
    ///
    /// The returned array should be freed with `glib.PtrArray.unref`,
    /// when no longer needed.
    extern fn e_data_book_view_watcher_memory_dup_contacts(p_self: *DataBookViewWatcherMemory, p_range_start: c_uint, p_range_length: c_uint) ?*glib.PtrArray;
    pub const dupContacts = e_data_book_view_watcher_memory_dup_contacts;

    /// Sets a locale to use for sorting. When `NULL`, or when cannot
    /// use the provided locale, tries to use the system locale.
    extern fn e_data_book_view_watcher_memory_set_locale(p_self: *DataBookViewWatcherMemory, p_locale: ?[*:0]const u8) void;
    pub const setLocale = e_data_book_view_watcher_memory_set_locale;

    /// Sets `sort_fields` as fields to sort the contacts by. If `NULL`,
    /// sorts by file-as field. The function assumes ownership of the `sort_fields`.
    extern fn e_data_book_view_watcher_memory_take_sort_fields(p_self: *DataBookViewWatcherMemory, p_sort_fields: ?*ebookcontacts.BookClientViewSortFields) void;
    pub const takeSortFields = e_data_book_view_watcher_memory_take_sort_fields;

    extern fn e_data_book_view_watcher_memory_get_type() usize;
    pub const getGObjectType = e_data_book_view_watcher_memory_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookViewWatcherMemory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookViewWatcherMemory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookViewWatcherMemory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure used to handle "manual query" views for `edatabook.BookBackend`
/// descendants which use `edatabook.BookSqlite` to store the contacts.
pub const DataBookViewWatcherSqlite = extern struct {
    pub const Parent = ebookcontacts.BookIndicesUpdater;
    pub const Implements = [_]type{};
    pub const Class = edatabook.DataBookViewWatcherSqliteClass;
    f_parent: ebookcontacts.BookIndicesUpdater,
    f_priv: ?*edatabook.DataBookViewWatcherSqlitePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edatabook.DataBookViewWatcherSqlite`, which will watch the `view`
    /// and will provide the information about indices and total contacts
    /// to the `backend`, taking the data from the `ebsql`.
    extern fn e_data_book_view_watcher_sqlite_new(p_backend: *edatabook.BookBackend, p_ebsql: *edatabook.BookSqlite, p_view: *edatabook.DataBookView) *edatabook.DataBookViewWatcherSqlite;
    pub const new = e_data_book_view_watcher_sqlite_new;

    /// Retrieves contacts in the given range. Returns `NULL` when the `range_start`
    /// is out of bounds. The function can return less than `range_length` contacts.
    ///
    /// The returned array should be freed with `glib.PtrArray.unref`,
    /// when no longer needed.
    extern fn e_data_book_view_watcher_sqlite_dup_contacts(p_self: *DataBookViewWatcherSqlite, p_range_start: c_uint, p_range_length: c_uint) ?*glib.PtrArray;
    pub const dupContacts = e_data_book_view_watcher_sqlite_dup_contacts;

    /// Sets `sort_fields` as fields to sort the contacts by. If `NULL`,
    /// sorts by file-as field. The function assumes ownership of the `sort_fields`.
    extern fn e_data_book_view_watcher_sqlite_take_sort_fields(p_self: *DataBookViewWatcherSqlite, p_sort_fields: ?*ebookcontacts.BookClientViewSortFields) void;
    pub const takeSortFields = e_data_book_view_watcher_sqlite_take_sort_fields;

    extern fn e_data_book_view_watcher_sqlite_get_type() usize;
    pub const getGObjectType = e_data_book_view_watcher_sqlite_get_type;

    extern fn g_object_ref(p_self: *edatabook.DataBookViewWatcherSqlite) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.DataBookViewWatcherSqlite) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataBookViewWatcherSqlite, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessBookFactory = extern struct {
    pub const Parent = ebackend.SubprocessFactory;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatabook.SubprocessBookFactoryClass;
    f_parent: ebackend.SubprocessFactory,
    f_priv: ?*edatabook.SubprocessBookFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_subprocess_book_factory_new(p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatabook.SubprocessBookFactory;
    pub const new = e_subprocess_book_factory_new;

    extern fn e_subprocess_book_factory_get_type() usize;
    pub const getGObjectType = e_subprocess_book_factory_get_type;

    extern fn g_object_ref(p_self: *edatabook.SubprocessBookFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.SubprocessBookFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SubprocessBookFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SystemLocaleWatcher = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatabook.SystemLocaleWatcherClass;
    f_parent: gobject.Object,
    f_priv: ?*edatabook.SystemLocaleWatcherPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Current locale, as detected. It can be `NULL`, when the locale
        /// was not detected yet.
        pub const locale = struct {
            pub const name = "locale";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `edatabook.SystemLocaleWatcher` instance, which listens for D-Bus
    /// notification on locale changes. It uses system bus, unless an environment
    /// variable "EDS_TESTING" is defined, in which case it uses the session bus
    /// instead.
    extern fn e_system_locale_watcher_new() *edatabook.SystemLocaleWatcher;
    pub const new = e_system_locale_watcher_new;

    /// Returns the current locale, as detected by the `watcher`. The string
    /// is duplicated for thread safety. It can be `NULL`, when the locale
    /// was not detected yet.
    ///
    /// Free it with `glib.free`, when no longer needed.
    extern fn e_system_locale_watcher_dup_locale(p_watcher: *SystemLocaleWatcher) ?[*:0]u8;
    pub const dupLocale = e_system_locale_watcher_dup_locale;

    extern fn e_system_locale_watcher_get_type() usize;
    pub const getGObjectType = e_system_locale_watcher_get_type;

    extern fn g_object_ref(p_self: *edatabook.SystemLocaleWatcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatabook.SystemLocaleWatcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SystemLocaleWatcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookBackend` class.
///
/// These virtual methods must be implemented when writing
/// an addressbook backend.
pub const BookBackendClass = extern struct {
    pub const Instance = edatabook.BookBackend;

    f_parent_class: ebackend.BackendClass,
    /// Whether a serial dispatch queue should
    ///                             be used for this backend or not. The default is `TRUE`.
    f_use_serial_dispatch_queue: c_int,
    /// Fetch a property value by name from the backend
    f_impl_get_backend_property: ?*const fn (p_backend: *edatabook.BookBackend, p_prop_name: [*:0]const u8) callconv(.c) [*:0]u8,
    /// Open the backend
    f_impl_open: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    /// Refresh the backend
    f_impl_refresh: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    /// Add and store the passed vcards
    f_impl_create_contacts: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) callconv(.c) void,
    /// Modify the existing contacts using the passed vcards
    f_impl_modify_contacts: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_vcards: *const [*:0]const u8, p_opflags: u32) callconv(.c) void,
    /// Remove the contacts specified by the passed UIDs
    f_impl_remove_contacts: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uids: *const [*:0]const u8, p_opflags: u32) callconv(.c) void,
    /// Fetch a contact by UID
    f_impl_get_contact: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_id: [*:0]const u8) callconv(.c) void,
    /// Fetch a list of contacts based on a search expression
    f_impl_get_contact_list: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) callconv(.c) void,
    /// Fetch a list of contact UIDs based on a search expression
    f_impl_get_contact_list_uids: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_query: [*:0]const u8) callconv(.c) void,
    /// Start up the specified view
    f_impl_start_view: ?*const fn (p_backend: *edatabook.BookBackend, p_view: *edatabook.DataBookView) callconv(.c) void,
    /// Stop the specified view
    f_impl_stop_view: ?*const fn (p_backend: *edatabook.BookBackend, p_view: *edatabook.DataBookView) callconv(.c) void,
    /// Notify changes which might have occured for a given contact
    f_impl_notify_update: ?*const fn (p_backend: *edatabook.BookBackend, p_contact: *const ebookcontacts.Contact) callconv(.c) void,
    /// For addressbook backends which support Direct Read Access,
    ///                   report some information on how to access the addressbook persistance directly
    f_impl_get_direct_book: ?*const fn (p_backend: *edatabook.BookBackend) callconv(.c) *edatabook.DataBookDirect,
    /// For addressbook backends which support Direct Read Access, configure a
    ///                    backend instantiated on the client side for Direct Read Access, using data
    ///                    reported from the server via the `get_direct_book` method.
    f_impl_configure_direct: ?*const fn (p_backend: *edatabook.BookBackend, p_config: [*:0]const u8) callconv(.c) void,
    /// Store & remember the passed locale setting
    f_impl_set_locale: ?*const fn (p_backend: *edatabook.BookBackend, p_locale: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Return the currently set locale setting (must be a string duplicate, for thread safety).
    f_impl_dup_locale: ?*const fn (p_backend: *edatabook.BookBackend) callconv(.c) [*:0]u8,
    /// Create an `edatabook.DataBookCursor`
    f_impl_create_cursor: ?*const fn (p_backend: *edatabook.BookBackend, p_sort_fields: *ebookcontacts.ContactField, p_sort_types: *ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_error: ?*?*glib.Error) callconv(.c) ?*edatabook.DataBookCursor,
    /// Delete an `edatabook.DataBookCursor` previously created by this backend
    f_impl_delete_cursor: ?*const fn (p_backend: *edatabook.BookBackend, p_cursor: *edatabook.DataBookCursor, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// A signal notifying that the backend was closed
    f_closed: ?*const fn (p_backend: *edatabook.BookBackend, p_sender: [*:0]const u8) callconv(.c) void,
    /// A signal notifying that the backend is being shut down
    f_shutdown: ?*const fn (p_backend: *edatabook.BookBackend) callconv(.c) void,
    /// Checkes whether the backend contains an email address
    f_impl_contains_email: ?*const fn (p_backend: *edatabook.BookBackend, p_book: *edatabook.DataBook, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_email_address: [*:0]const u8) callconv(.c) void,
    /// sets sort fields for "manual query" views; default implementation saves
    ///    the values into internal structures, which can be read back with `edatabook.BookBackend.dupViewSortFields`. Since 3.50
    f_impl_set_view_sort_fields: ?*const fn (p_backend: *edatabook.BookBackend, p_view_id: usize, p_fields: *const ebookcontacts.BookClientViewSortFields) callconv(.c) void,
    /// retrieve how many contacts a "manual query" view has; default implementation
    ///    returns value set by `edatabook.BookBackend.setViewNTotal`. Since: 3.50
    f_impl_get_view_n_total: ?*const fn (p_backend: *edatabook.BookBackend, p_view_id: usize) callconv(.c) c_uint,
    /// retrieve indexes into an alphabet for contacts in the "manual query" view; default
    ///    implementation returns value set by `edatabook.BookBackend.setViewIndices`. Since: 3.50
    f_impl_dup_view_indices: ?*const fn (p_backend: *edatabook.BookBackend, p_view_id: usize) callconv(.c) *ebookcontacts.BookIndices,
    /// returns contacts in the given range of the sorted "manual query" view; default
    ///    implementation tracks view's connect and returns the contacts accordingly. Since: 3.50
    f_impl_dup_view_contacts: ?*const fn (p_backend: *edatabook.BookBackend, p_view_id: usize, p_range_start: c_uint, p_range_length: c_uint) callconv(.c) *glib.PtrArray,
    f_reserved_padding: [15]*anyopaque,

    pub fn as(p_instance: *BookBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookBackendFactory` class.
///
/// Subclasses need to set the factory name and backend type
/// at initialization, the base class will take care of creating
/// backends of the specified type on demand.
pub const BookBackendFactoryClass = extern struct {
    pub const Instance = edatabook.BookBackendFactory;

    f_parent_class: ebackend.BackendFactoryClass,
    /// The string identifier for this book backend type
    f_factory_name: ?[*:0]const u8,
    /// The `gobject.Type` to use to build `EBookBackends` for this factory
    f_backend_type: usize,

    pub fn as(p_instance: *BookBackendFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendSExpClass = extern struct {
    pub const Instance = edatabook.BookBackendSExp;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *BookBackendSExpClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendSExpPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookBackendSync` class.
///
/// These virtual methods must be implemented when writing
/// an addressbook backend.
pub const BookBackendSyncClass = extern struct {
    pub const Instance = edatabook.BookBackendSync;

    f_parent_class: edatabook.BookBackendClass,
    /// Open the backend
    f_open_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Refresh the backend
    f_refresh_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Add and store the passed vcards
    f_create_contacts_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Modify the existing contacts using the passed vcards
    f_modify_contacts_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_vcards: *const [*:0]const u8, p_opflags: u32, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Remove the contacts specified by the passed UIDs
    f_remove_contacts_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_uids: *const [*:0]const u8, p_opflags: u32, p_out_removed_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Fetch a contact by UID
    f_get_contact_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*ebookcontacts.Contact,
    /// Fetch a list of contacts based on a search expression
    f_get_contact_list_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_query: [*:0]const u8, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// Fetch a list of contact UIDs based on a search expression (optional)
    f_get_contact_list_uids_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_query: [*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_contains_email_sync: ?*const fn (p_backend: *edatabook.BookBackendSync, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved_padding: [19]*anyopaque,

    pub fn as(p_instance: *BookBackendSyncClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookBackendSyncPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookCache` class.
pub const BookCacheClass = extern struct {
    pub const Instance = edatabook.BookCache;

    f_parent_class: ebackend.CacheClass,
    f_e164_changed: ?*const fn (p_book_cache: *edatabook.BookCache, p_contact: *ebookcontacts.Contact, p_is_replace: c_int) callconv(.c) void,
    f_dup_contact_revision: ?*const fn (p_book_cache: *edatabook.BookCache, p_contact: *ebookcontacts.Contact) callconv(.c) [*:0]u8,
    f_categories_changed: ?*const fn (p_book_cache: *edatabook.BookCache, p_categories: [*:0]const u8) callconv(.c) void,
    f_reserved: [9]*anyopaque,

    pub fn as(p_instance: *BookCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque cursor pointer
pub const BookCacheCursor = opaque {
    /// Creates a new `edatabook.BookCacheCursor`.
    ///
    /// The cursor should be freed with `edatabook.BookCache.cursorFree` when
    /// no longer needed.
    extern fn e_book_cache_cursor_new(p_book_cache: *edatabook.BookCache, p_sexp: ?[*:0]const u8, p_sort_fields: [*]const ebookcontacts.ContactField, p_sort_types: [*]const ebookcontacts.BookCursorSortType, p_n_sort_fields: c_uint, p_error: ?*?*glib.Error) ?*edatabook.BookCacheCursor;
    pub const new = e_book_cache_cursor_new;

    extern fn e_book_cache_cursor_get_type() usize;
    pub const getGObjectType = e_book_cache_cursor_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure is used to represent contacts returned
/// by the `edatabook.BookCache` from various functions
/// such as `edatabook.BookCache.search`.
///
/// The `extra` parameter will contain any data which was
/// previously passed for this contact in `edatabook.BookCache.putContact`
/// or set with `edatabook.BookCache.setContactExtra`.
///
/// These should be freed with `edatabook.bookCacheSearchDataFree`.
pub const BookCacheSearchData = extern struct {
    /// The `E_CONTACT_UID` field of this contact
    f_uid: ?[*:0]u8,
    /// The vcard string
    f_vcard: ?[*:0]u8,
    /// Any extra data associated with the vcard
    f_extra: ?[*:0]u8,

    /// Frees the `data` structure, previously allocated with `edatabook.BookCacheSearchData.new`
    /// or `edatabook.BookCacheSearchData.copy`.
    extern fn e_book_cache_search_data_free(p_data: ?*anyopaque) void;
    pub const free = e_book_cache_search_data_free;

    /// Creates a new EBookCacheSearchData prefilled with the given values.
    extern fn e_book_cache_search_data_new(p_uid: [*:0]const u8, p_vcard: [*:0]const u8, p_extra: ?[*:0]const u8) *edatabook.BookCacheSearchData;
    pub const new = e_book_cache_search_data_new;

    extern fn e_book_cache_search_data_copy(p_data: ?*const BookCacheSearchData) ?*edatabook.BookCacheSearchData;
    pub const copy = e_book_cache_search_data_copy;

    extern fn e_book_cache_search_data_get_type() usize;
    pub const getGObjectType = e_book_cache_search_data_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookMetaBackend` class.
pub const BookMetaBackendClass = extern struct {
    pub const Instance = edatabook.BookMetaBackend;

    f_parent_class: edatabook.BookBackendSyncClass,
    f_backend_module_filename: ?[*:0]const u8,
    f_backend_factory_type_name: ?[*:0]const u8,
    f_connect_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_disconnect_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_changes_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_list_existing_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_load_contact_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_contact: **ebookcontacts.Contact, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_save_contact_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_contact: *ebookcontacts.Contact, p_extra: ?[*:0]const u8, p_opflags: u32, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove_contact_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_search_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_expr: ?[*:0]const u8, p_meta_contact: c_int, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_search_uids_sync: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_expr: ?[*:0]const u8, p_out_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_requires_reconnect: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend) callconv(.c) c_int,
    f_source_changed: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend) callconv(.c) void,
    f_get_ssl_error_details: ?*const fn (p_meta_backend: *edatabook.BookMetaBackend, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) callconv(.c) c_int,
    f_backend_module_directory: ?[*:0]const u8,
    f_reserved: [8]*anyopaque,

    pub fn as(p_instance: *BookMetaBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookMetaBackendInfo = extern struct {
    f_uid: ?[*:0]u8,
    f_revision: ?[*:0]u8,
    f_object: ?[*:0]u8,
    f_extra: ?[*:0]u8,

    /// Frees the `ptr` structure, previously allocated with `edatabook.BookMetaBackendInfo.new`
    /// or `edatabook.BookMetaBackendInfo.copy`.
    extern fn e_book_meta_backend_info_free(p_ptr: ?*anyopaque) void;
    pub const free = e_book_meta_backend_info_free;

    /// Creates a new `edatabook.BookMetaBackendInfo` prefilled with the given values.
    extern fn e_book_meta_backend_info_new(p_uid: [*:0]const u8, p_revision: ?[*:0]const u8, p_object: ?[*:0]const u8, p_extra: ?[*:0]const u8) *edatabook.BookMetaBackendInfo;
    pub const new = e_book_meta_backend_info_new;

    extern fn e_book_meta_backend_info_copy(p_src: ?*const BookMetaBackendInfo) ?*edatabook.BookMetaBackendInfo;
    pub const copy = e_book_meta_backend_info_copy;

    extern fn e_book_meta_backend_info_get_type() usize;
    pub const getGObjectType = e_book_meta_backend_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookMetaBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatabook.BookSqlite` class.
pub const BookSqliteClass = extern struct {
    pub const Instance = edatabook.BookSqlite;

    f_parent_class: gobject.ObjectClass,
    f_before_insert_contact: ?*const fn (p_ebsql: *edatabook.BookSqlite, p_db: ?*anyopaque, p_contact: *ebookcontacts.Contact, p_extra: [*:0]const u8, p_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_before_remove_contact: ?*const fn (p_ebsql: *edatabook.BookSqlite, p_db: ?*anyopaque, p_contact_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,

    pub fn as(p_instance: *BookSqliteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookSqlitePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookClass = extern struct {
    pub const Instance = edatabook.DataBook;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DataBookClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `edatabook.BookCache` cursor class structure.
pub const DataBookCursorCacheClass = extern struct {
    pub const Instance = edatabook.DataBookCursorCache;

    f_parent: edatabook.DataBookCursorClass,

    pub fn as(p_instance: *DataBookCursorCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookCursorCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Methods to implement on an `edatabook.DataBookCursor` concrete class.
pub const DataBookCursorClass = extern struct {
    pub const Instance = edatabook.DataBookCursor;

    f_parent: gobject.ObjectClass,
    /// The `edatabook.DataBookCursorSetSexpFunc` delegate to set the search expression
    f_set_sexp: ?edatabook.DataBookCursorSetSexpFunc,
    /// The `edatabook.DataBookCursorStepFunc` delegate to navigate the cursor
    f_step: ?edatabook.DataBookCursorStepFunc,
    /// The `edatabook.DataBookCursorSetAlphabetIndexFunc` delegate to set the alphabetic position
    f_set_alphabetic_index: ?edatabook.DataBookCursorSetAlphabetIndexFunc,
    /// The `edatabook.DataBookCursorGetPositionFunc` delegate to calculate the current total and position values
    f_get_position: ?edatabook.DataBookCursorGetPositionFunc,
    /// The `edatabook.DataBookCursorCompareContactFunc` delegate to compare an `ebookcontacts.Contact` with the cursor position
    f_compare_contact: ?edatabook.DataBookCursorCompareContactFunc,
    /// The `edatabook.DataBookCursorLoadLocaleFunc` delegate used to reload the locale setting
    f_load_locale: ?edatabook.DataBookCursorLoadLocaleFunc,

    pub fn as(p_instance: *DataBookCursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookCursorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The SQLite cursor class structure.
pub const DataBookCursorSqliteClass = extern struct {
    pub const Instance = edatabook.DataBookCursorSqlite;

    f_parent: edatabook.DataBookCursorClass,

    pub fn as(p_instance: *DataBookCursorSqliteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookCursorSqlitePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookDirectClass = extern struct {
    pub const Instance = edatabook.DataBookDirect;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *DataBookDirectClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookDirectPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookFactoryClass = extern struct {
    pub const Instance = edatabook.DataBookFactory;

    f_parent_class: ebackend.DataFactoryClass,

    pub fn as(p_instance: *DataBookFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewClass = extern struct {
    pub const Instance = edatabook.DataBookView;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *DataBookViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherCacheClass = extern struct {
    pub const Instance = edatabook.DataBookViewWatcherCache;

    f_parent_class: ebookcontacts.BookIndicesUpdaterClass,

    pub fn as(p_instance: *DataBookViewWatcherCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherMemoryClass = extern struct {
    pub const Instance = edatabook.DataBookViewWatcherMemory;

    f_parent_class: ebookcontacts.BookIndicesUpdaterClass,

    pub fn as(p_instance: *DataBookViewWatcherMemoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherMemoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherSqliteClass = extern struct {
    pub const Instance = edatabook.DataBookViewWatcherSqlite;

    f_parent_class: ebookcontacts.BookIndicesUpdaterClass,

    pub fn as(p_instance: *DataBookViewWatcherSqliteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataBookViewWatcherSqlitePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessBookFactoryClass = extern struct {
    pub const Instance = edatabook.SubprocessBookFactory;

    f_parent_class: ebackend.SubprocessFactoryClass,

    pub fn as(p_instance: *SubprocessBookFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessBookFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SystemLocaleWatcherClass = extern struct {
    pub const Instance = edatabook.SystemLocaleWatcher;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SystemLocaleWatcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SystemLocaleWatcherPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque cursor pointer
pub const bSqlCursor = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure is used to represent contacts returned
/// by the `edatabook.BookSqlite` from various functions
/// such as `e_book_sqlitedb_search`.
///
/// The `extra` parameter will contain any data which was
/// previously passed for this contact in `edatabook.BookSqlite.addContact`.
///
/// These should be freed with `edatabook.BookSqlite.searchDataFree`.
pub const bSqlSearchData = extern struct {
    /// The `E_CONTACT_UID` field of this contact
    f_uid: ?[*:0]u8,
    /// The the vcard string
    f_vcard: ?[*:0]u8,
    /// Any extra data associated to the vcard
    f_extra: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// What compare function should be used when comparing two values.
pub const BookBackendSexpCompareKind = enum(c_int) {
    unknown = 0,
    begins_with = 1,
    ends_with = 2,
    contains = 3,
    is = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the start position to in the list of traversed contacts
/// in calls to `edatabook.BookCache.cursorStep`.
///
/// When an `edatabook.BookCacheCursor` is created, the current position implied by `E_BOOK_CACHE_CURSOR_ORIGIN_CURRENT`
/// is the same as `E_BOOK_CACHE_CURSOR_ORIGIN_BEGIN`.
pub const BookCacheCursorOrigin = enum(c_int) {
    current = 0,
    begin = 1,
    end = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the types of possible errors reported by the `edatabook.BookSqlite`
pub const BookSqliteError = enum(c_int) {
    engine = 0,
    constraint = 1,
    contact_not_found = 2,
    invalid_query = 3,
    unsupported_query = 4,
    unsupported_field = 5,
    end_of_list = 6,
    load = 7,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the type of change which occurred in an `edatabook.bSqlChangeCallback`
pub const bSqlChangeType = enum(c_int) {
    contact_added = 0,
    locale_changed = 1,
    last = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the start position to in the list of traversed contacts
/// in calls to `edatabook.BookSqlite.cursorStep`.
///
/// When an `edatabook.bSqlCursor` is created, the current position implied by `EBSQL_CURSOR_ORIGIN_CURRENT`
/// is the same as `EBSQL_CURSOR_ORIGIN_BEGIN`.
pub const bSqlCursorOrigin = enum(c_int) {
    current = 0,
    begin = 1,
    end = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the type of lock requested in `edatabook.BookSqlite.lock`
pub const bSqlLockType = enum(c_int) {
    read = 0,
    write = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates what type of action to take while unlocking the sqlite with `edatabook.BookSqlite.unlock`
///
/// In the case that some addressbook modification failed while holding an `EBSQL_LOCK_WRITE` lock,
/// then the `edatabook.BookSqlite` must be unlocked with `EBSQL_UNLOCK_ROLLBACK`.
pub const bSqlUnlockAction = enum(c_int) {
    none = 0,
    commit = 1,
    rollback = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the behaviour of `edatabook.BookCache.cursorStep`.
pub const BookCacheCursorStepFlags = packed struct(c_uint) {
    move: bool = false,
    fetch: bool = false,
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

    pub const flags_move: BookCacheCursorStepFlags = @bitCast(@as(c_uint, 1));
    pub const flags_fetch: BookCacheCursorStepFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the behaviour of `edatabook.BookSqlite.cursorStep`.
pub const bSqlCursorStepFlags = packed struct(c_uint) {
    move: bool = false,
    fetch: bool = false,
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

    pub const flags_move: bSqlCursorStepFlags = @bitCast(@as(c_uint, 1));
    pub const flags_fetch: bSqlCursorStepFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Fetches the extra data previously set for `uid`, either with
/// `edatabook.BookSqlite.setContactExtra` or when adding contacts,
/// without locking internal mutex.
extern fn ebsql_get_contact_extra_unlocked(p_ebsql: *edatabook.BookSqlite, p_uid: [*:0]const u8, p_ret_extra: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
pub const ebsqlGetContactExtraUnlocked = ebsql_get_contact_extra_unlocked;

/// Fetch the `ebookcontacts.Contact` specified by `uid` in `ebsql` without locking internal mutex.
///
/// If `meta_contact` is specified, then a shallow `ebookcontacts.Contact` will be created
/// holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
extern fn ebsql_get_contact_unlocked(p_ebsql: *edatabook.BookSqlite, p_uid: [*:0]const u8, p_meta_contact: c_int, p_contact: **ebookcontacts.Contact, p_error: ?*?*glib.Error) c_int;
pub const ebsqlGetContactUnlocked = ebsql_get_contact_unlocked;

/// Fetch a vcard string for `uid` in `ebsql` without locking internal mutex.
///
/// If `meta_contact` is specified, then a shallow vcard representation will be
/// created holding only the `E_CONTACT_UID` and `E_CONTACT_REV` fields.
extern fn ebsql_get_vcard_unlocked(p_ebsql: *edatabook.BookSqlite, p_uid: [*:0]const u8, p_meta_contact: c_int, p_ret_vcard: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
pub const ebsqlGetVcardUnlocked = ebsql_get_vcard_unlocked;

/// A callback prototype being called in a dedicated thread, scheduled
/// by `edatabook.BookBackend.scheduleCustomOperation`.
pub const BookBackendCustomOpFunc = *const fn (p_book_backend: *edatabook.BookBackend, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void;

/// Callback function used by `edatabook.BookBackend.foreachView`.
pub const BookBackendForeachViewFunc = *const fn (p_backend: *edatabook.BookBackend, p_view: *edatabook.DataBookView, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each object row when using
/// `edatabook.BookCache.searchWithCallback` function.
pub const BookCacheSearchFunc = *const fn (p_book_cache: *edatabook.BookCache, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_extra: [*:0]const u8, p_custom_flags: u32, p_offline_state: ebackend.OfflineState, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each row of a SELECT statement executed
/// with `edatabook.BookSqlite.select` function.
pub const BookSqliteSelectFunc = *const fn (p_ebsql: *edatabook.BookSqlite, p_ncols: c_int, p_column_names: [*][*:0]const u8, p_column_values: [*][*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.compare_contact`
///
/// Cursor implementations must implement this in order to compare a
/// contact with the current cursor state.
///
/// This is called when the addressbook backends notify active cursors
/// that the addressbook has been modified with `edatabook.DataBookCursor.contactAdded` and
/// `edatabook.DataBookCursor.contactRemoved`.
pub const DataBookCursorCompareContactFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_contact: *ebookcontacts.Contact, p_matches_sexp: ?*c_int) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.get_position`
///
/// Cursor implementations must implement this to count the total results
/// matching `cursor`'s query expression and to calculate the amount of contacts
/// leading up to the current cursor state (cursor inclusive).
///
/// A cursor position is defined as an integer which is inclusive of the
/// current contact to which it points (if the cursor points to an exact
/// contact). A position of 0 indicates that the cursor is situated in
/// a position that is before and after the entire result set. The cursor
/// position should be 0 at creation time, and should start again from
/// the symbolic 0 position whenever `E_BOOK_CURSOR_ORIGIN_BEGIN` is
/// specified in the `edatabook.DataBookCursorClass.virtual_methods.step` method (or whenever
/// moving the cursor beyond the end of the result set).
///
/// If the cursor is positioned beyond the end of the list, then
/// the position should be the total amount of contacts available
/// in the list (as returned through the `total` argument) plus one.
///
/// This method is called by `edatabook.DataBookCursor.recalculate` and in some
/// other cases where `cursor`'s current position and total must be
/// recalculated from scratch.
pub const DataBookCursorGetPositionFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_total: *c_int, p_position: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.load_locale`
///
/// Fetches the locale setting from `cursor`'s addressbook
///
/// If the locale setting has changed, the cursor must reload any
/// internal locale specific data and ensure that comparisons of
/// sort keys will function properly in the new locale.
///
/// Upon locale changes, the implementation need not worry about
/// updating it's current cursor state, the cursor state will be
/// reset automatically for you.
pub const DataBookCursorLoadLocaleFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_locale: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.set_alphabetic_index`
///
/// Sets the cursor state to point to an
/// <link linkend="cursor-alphabet">index into the active alphabet</link>.
///
/// The implementing class must check that `locale` matches the current
/// locale setting of the underlying database and report an `E_CLIENT_ERROR_OUT_OF_SYNC`
/// error in the case that the locales do not match.
pub const DataBookCursorSetAlphabetIndexFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_index: c_int, p_locale: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.set_sexp`
///
/// A cursor implementation must implement this in order to modify the search
/// expression for `cursor`. After this is called, the position and total will
/// be recalculated.
///
/// If the cursor implementation is unable to deal with the `EContactFields`
/// referred to in `sexp`, then an `E_CLIENT_ERROR_INVALID_QUERY` error should
/// be set to indicate this.
pub const DataBookCursorSetSexpFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_sexp: ?[*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Method type for `edatabook.DataBookCursorClass.virtual_methods.step`
///
/// As all cursor methods may be called either by the addressbook service or
/// directly by a client in Direct Read Access mode, it is important that the
/// operation be an atomic transaction with the underlying database.
///
/// The `revision_guard`, if specified, will be set to the `CLIENT_BACKEND_PROPERTY_REVISION`
/// value at the time which the given client issued the call to move the cursor.
/// If the `revision_guard` provided by the client does not match the stored addressbook
/// revision, then an `E_CLIENT_ERROR_OUT_OF_SYNC` error should be set to indicate
/// that the revision was out of sync while attempting to move the cursor.
///
/// <note><para>If the addressbook backend supports direct read access, then the
/// revision comparison and reading of the data store must be coupled into a
/// single atomic operation (the data read back from the store must be the correct
/// data for the given addressbook revision).</para></note>
///
/// See `edatabook.DataBookCursor.step` for more details on the expected behaviour of this method.
pub const DataBookCursorStepFunc = *const fn (p_cursor: *edatabook.DataBookCursor, p_revision_guard: ?[*:0]const u8, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_results: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// A function which may be called in response to a change
/// in contact data.
///
/// <note><para>This user callback is called inside a lock,
/// you must not call the `edatabook.BookSqlite` API from
/// this callback.</para></note>
pub const bSqlChangeCallback = *const fn (p_change_type: edatabook.bSqlChangeType, p_uid: [*:0]const u8, p_extra: [*:0]const u8, p_vcard: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

/// If this callback is passed to `edatabook.BookSqlite.new`, then
/// vcards are not stored in the SQLite and instead this callback
/// is invoked to fetch the vcard.
///
/// This callback will be called to fetch results for fully indexed
/// and optimized queries, and it will also be called while performing
/// fallback queries against `EContactFields` which are not configured
/// in the `ebookcontacts.SourceBackendSummarySetup` or default summary fields.
///
/// <note><para>This user callback is called inside a lock,
/// you must not call the `edatabook.BookSqlite` API from
/// this callback.</para></note>
pub const bSqlVCardCallback = *const fn (p_uid: [*:0]const u8, p_extra: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) [*:0]u8;

/// This key can be used with `edatabook.BookSqlite.getKeyValue`.
///
/// In the case of a migration from an older SQLite, any value which
/// was previously stored with `e_book_backend_sqlitedb_set_is_populated`
/// can be retrieved with this key.
pub const BOOK_SQL_IS_POPULATED_KEY = "eds-reserved-namespace-is-populated";
/// This key can be used with `edatabook.BookSqlite.getKeyValue`.
///
/// In the case of a migration from an older SQLite, any value which
/// was previously stored with `e_book_backend_sqlitedb_set_sync_data`
/// can be retrieved with this key.
pub const BOOK_SQL_SYNC_DATA_KEY = "eds-reserved-namespace-sync-data";
/// This environment variable configures where the address book
/// factory loads its backend modules from.
pub const EDS_ADDRESS_BOOK_MODULES = "EDS_ADDRESS_BOOK_MODULES";
/// This environment variable configures where the address book
/// factory subprocess is located in.
pub const EDS_SUBPROCESS_BOOK_PATH = "EDS_SUBPROCESS_BOOK_PATH";
pub const XIMIAN_VCARD = "BEGIN:VCARD\nX-EVOLUTION-FILE-AS:Novell Ximian Group\nADR;TYPE=WORK:;Suite 500;8 Cambridge Center;Cambridge;MA;02142;USA\nLABEL;TYPE=WORK:8 Cambridge Center, Suite 500\\nCambridge\\, MA\\n02142\\nUSA\nTEL;WORK;VOICE:(617) 613-2000\nTEL;WORK;FAX:(617) 613-2001\nEMAIL;INTERNET:hello@ximian.com\nURL:http://www.ximian.com/\nORG:Novell;Ximian Group\nPHOTO;ENCODING=b;TYPE=JPEG:/9j/4AAQSkZJRgABAQEARwBHAAD//gAXQ3JlYXRlZCB3aXRo\n IFRoZSBHSU1Q/9sAQwAIBgYHBgUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCM\n cHCg3KSwwMTQ0NB8nOT04MjwuMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMj\n IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy/8AAEQgAbgBkAwEiAAIRAQMRAf/EA\n BwAAAIDAQEBAQAAAAAAAAAAAAAHBQYIBAMBAv/EAEYQAAEDAwEFBgMEBgQPAAAAAAECAwQABREG\n BxIhMWETIkFRcYEUkaEIMkLBFSNSsbLRFmJydRgkMzY3Q0RGgpKTosLh8P/EABsBAQACAwEBAAA\n AAAAAAAAAAAAEBQIDBgEH/8QALREAAQMCAwYGAgMAAAAAAAAAAQACAwQREiFRBRMiMUFhMnGBkb\n HRBsEUofD/2gAMAwEAAhEDEQA/AH/RRRREVwXe9W2wwFzbpNZixkc1uqwPQeZ6CoHXevLfom1ds\n 9h6a6D8PGCsFZHMk+CR4n86yzdbrqfaZqYBSnp0hRPZMoG62ynoOSR1Pua8Lg0XPJegX5Jv6k+0\n bBjrWxp22LlkcBIlHs0HqEjiR64peT9umupqyWrhHhpP4WI6eHureNW7Tmw+DGaTI1FJVJdxksM\n qKG09CrmfbFMCHpCw2xATDs8JrH4gykq+Z4mqifbMUZsxpd/QUllK53M2SCb2xa+bXvf0gcV0Uw\n 0R/DVktH2hdUwlpFxjQrg1490tLPuOH0pvv2qE4jdchx1p8lNAj91Va87OtM3RCt+2Nx3Dyci/q\n yPYcD7g1EZ+RR4rSMI9b/S2mhdbhKsmkdtWmNTuNxnXVW2cvgGZRASo+SV8j74PSmOlQUMpORWP\n NU7MrjY0rlQFmdDTxOE4cQOo8R1Hyqe2Z7ZJ2m32bXfHnJVpJCUuqO8uP7+Kenh4eVXkFRFUMxx\n G4UOSN0Zs4LU1FeEOWxOityYzqHWXEhSFoOQoHkQa963rBFFFFERUdfr1E09Y5d1mr3Y8ZsrV5n\n yA6k4A6mpGkL9ojUym0W/TrLmAsGU+AeYBwgfPJ/4RREqrrcb1tJ1oUpBXLmObqUZ7rSByT0SkZ\n J8zk1pHQmiLXo+zpbabC3SAp55Q7zyvM9PIUudiGmURbS7fpCMvzFFton8LSTxx6qH0FM7VV9VY\n 9MzZ7aQt5tASw3+26ohKB/zEVSVFVvZzGMw02tqe/kpbI8LMR6/C/Xxq9QagfbbP+IW1QQ4Rycf\n xncHRAIJ/rEfsmu2a9Fgsl2XIZjtj8bqwgfM1+9L2VFksESAV9o6hG886ebjqjvLWepUSarutdn\n MXV+obRcZks/CwCQ5DKMpeBOTxzwzgA9KwfTtfxPOSB5GQUXc9pOjoC+zXe2HV5xiOC6PmkEfWp\n xe6tAWghSVDIIOQRXxekNOx4b0WPZYLLTram19mwlJKSMHjjNUzQd2dZM7SNxczcLOsttqVzdYz\n 3FewI9iKpK2mjMZdFe7ed9NfT9qZDI4OAd1Vkko50ndoui22kuXq2NBOO9JZSOH9sD9/z86c8gc\n DUJNQlaFJUkKSoYII4EVGoKp9PIHt9e6lyRNlZhcqlsJ2guQpydL3F4mO7kw1KP3Fcyj0PEjrnz\n rSAIIyOVYfvsJ3TGqlCKpTfYuJfjLHMDOR8jw9q2Foy+o1FpWBckY/XMpUoeRxxHsciu/jeJGB7\n eRXPvaWuLT0U/RRRWaxQeVY82x3BVw2oXbJyhgoZR0AQM/UmthK+6fSsWbRQW9pV73x/tZPtwNE\n Wj9Nw0WuwwIKQAGI6G/cAZ+tRW0lx5nTEW4Ntqdat9xjy5CEjJLSFZP5H2qaYdCkpUk5BGQa7Ap\n DrSm3EpWhYKVJUMgg8wRXz+kqyyTG7VXUsV22Clrfc48+CzMiPIejvIC23EHIUDXNe79b7HbXbh\n c5SI8ZvmtZ5nyA5k9BS7d0nfdMPuSdD3JtEZaitdom5Uznx3DzT6cPWkvq/V1611fGW5nZtBCgy\n zFbXhtCycE5JxknxPhXR07RUeB3D11H+9lAfwcxmrrqLbxcHpikWGAw1FScByUkqWvrgEBPpxqi\n ztdXWdqmNqIIjx7gykJUphJCXAM/eBJ5g4PQCmBZNiDKWEu364uF0jJYh4AT6qUDn2FVu6bPIkT\n aTB08xKeMOU2H99eCtKRvZGQMZ7hwceNZxVGzsbmMzIBv5dfNeOjnsCdUwbTtKsV8nJgIccZkqw\n lJcThDqvJJz8s4zUtLVzpc2vZZKt+qBIkyUKt0V0ONKSe+7g5SCPDr9Kv0tznXP1cNMyQfxnXBC\n tqUyuB3gslftPjJLkGWB3u82o/Ij86bf2e7iqRoxyIpWfhpC0JHQ4V/5GlVtJcBt0RPiXif+00w\n Ps5BQtNxP4TJP8Ka6rZZJpW37/Kq68ATlPeiiirBQ0HlWR9t9qVbtpEp/dwiY0h5J8Mgbp/h+ta\n 4pM7fdKLumn2rxGbKn4BKl4HEtn73ywD7GiL7o28JuulLbKCsqLKUL/tJ7p+oqyIe4c6RGyzU4g\n THLNJc3WpCt9gk8A54j3GPcdaZuoosy82V23QpaYpkEIdeIJKUeIAHieXPkTXA11DuassJsCefY\n /SvYZN5FiGZU9edRwLDAXJny2mRukoStQBWQOQHjSjg7PYE7ZmzcZb7cG6KK5CZD6txOCcJQvPg\n QAQfAn2q6RNOWi1D9J3R5dwlR2xmZPVv9mlI8ByTj59ar09Lm0jUIQl5Y0zAUMrQSPiXfHHpyz4\n D1qTRvMQIieQAQXOtllfIDre/X2WqVmI8Qz6D9q0bP9SO37SrSpW8ZUVXw7q+YcKeSgeRyMZ65q\n qammvWTalEv1yjOJtaWfh25CBvBOUkHPlxUeHlyq/MiPCitxorSGWG07qG0DASK45xZlx3GJDaH\n WljCkLGQR6VGinY2ofIG8Lri2gOi37hxYG3zC+uT2HY6ZDbyFMrAUlwK7pB5HNRcp7nxqpzdN3G\n CFQ7NObTa3nApcaSN/suOe4SDw6VK3O4swojsp9WGmxk9fIDrW4UzWkbt2K/v691vjec8YtZUTa\n BL+IuMaIjiWWytXQn/wBD608tgtrVC0W2+tOFSFqd9icD6AVnmFFl6n1AhoAmRPdwcfgR4n2H7q\n 2Ppi1N2exRojaQlKEBIHkAK7Gmi3MTWaLn6iTeSF+qmaKKK3rSiuedEanQ3I7qQpC0kEEZzXRRR\n FjnaRoSVoq/KcYQv9HOr3mHB/qzz3SenhVi0ftAbnNNwLo6G5iQEodUcJd9fJX760ZqLTkHUdsd\n hTWEOtuJwQoVl/XGyS7aakOPwGnJcDORujK0DqPH2qJV0cdUzC/0Oi3QTuhddqY84IuFukwnFFK\n JDSmlEcwFDGR86ISI1tgtQ4jYaYaTuoSP/udJS1azvFoAZLnbsp4dm/klPQHmKs0faVEWkfEw32\n 1f1CFj8q56XZNSwYG5t7fSt46yB5ucimM5L4c643pXWqU5tCteMpRKUfIIH86ipmvnnAUwoQSf2\n 3lZ+g/nWEey5yfCtrquBo8Su0+4sQ46pEp1LTSeZUfoPOlnfr67fZKQlK0QkK/VtficV5nrXOkX\n XUk9KQHp0gnghI7qPyAp1bOdkCmH2rneQHHxxQjHdb9OvWr2j2c2Didm74VZVVplGFuQXRsc2fO\n Qgb1cmsSXQN1JH+TT4D+dPEAAADkK848duMylppISkDGBXrVkoCKKKKIiiqrrbX9m0JARIua1re\n dJDMdoArcI58+AA8zVLsO26RqiS9Gsukpct5lHaKbTLaSrd8wFEZ9s0RN6vGRGZktlDqAoHzFKq\n JtomzrPOuzGjZvwEBRTJfckttpbUOae9jJ5cBk8R514Wrbo7e489+3aTlvtQGTIkqElsdm2Mkq4\n 4zyPKiKf1Hsj09flKdXEQh4/jR3VfMUvJ/2et1ZMOe8keSgFfyqz2LbfJ1M9IZs2kJsx2O0XnEN\n yEAhA4ZwcZ58hxr7ZdtkvUS5SbTo2fJMRsuPkPoSG0jzKsDPPhz4HyoipDewC47+FXFWOjYH51Y\n bTsAgtrSqc88/jwWrA+QxUlYtujupZ6oNo0nLlSUtqdKEyW04SMZOVYHiKjP8ACUt5/wB3pX/XT\n /KiJnWLQ1nsTSURorad39lIFWZKUoThIAHSlNqDbLP0siKu96MnQ0ygSyVyGzvYxnlnB4jga87F\n ttlamXJbs2j50xcZvtXUtyEZCfPB5+gyaIm9RSetm3J68RbhJgaSmPM25vtZaviW09knjxIOM8j\n y8q7LHtzstwv/AOhrlBftkkudkFOLS43v5xgqSeHHx5daImrRX5QtK0hSTkGiiLMP2ho8wa1iSn\n QoxVRQ20fAKClFQ9eIqq7LLJe7vreG7ZZCoZhqD8iZjustjnnwORkY8c+Wa1ZqbStt1PBMa4MId\n Rz7wzg+dL8bEbA1vpa7RtK+CkpdWAfXjRFB7UpCNe6Kdm6NnJft1qluKuUJlvdKznPbYH3hzPXJ\n PMGqZsk/zc2gf3G5/Cumc3sRsTO92Rcb3uB3XVjP1r4jYfYGwoN76QsYUEurGR5HjREudhUt2BP\n 1TMYID0eyuuoJGRvJII+oq96I2iwtVz7rb7ZZWbalyzyJ9wKUjLsrKEkjH4cE8+Jz049bew+wNb\n 3Z76N4YO66sZHlzob2H2Bkktb6CRglLqxkeXOiJZbAv9IMj+7X/wB6ag9lGnEaj17CRJA+BhZmy\n lK+6EI44PQq3R6E06W9h9gZVvNb6FYxlLqwcfOhvYhYWt7s99G8MK3XVjI68aIo7UxgbR9IajhQ\n 7/Du9yiSF3S3tMNrStlkAAt94DPDI4eJFUvYfNetqNYz4xAfjWZx5skZAUnJHD1FMVrYhYWVbzW\n +2ojGUOrBx86EbD7A0FBvfRvDCt11YyPI8aIo23zdP6i2e621TaUJiXCfa1IucFPJt5KVnfHRWS\n euPPNZ2YadfkNsspUp1aglCU8yTyrTSNh9gbCgjfSFjCgl1YyPI8al9PbItP2WamUywkuJ5KOVE\n emeVEVw02ZH9H4YkEqdDYCifE4oqXbaS02lCRhIGBRRF//Z\nEND:VCARD";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
