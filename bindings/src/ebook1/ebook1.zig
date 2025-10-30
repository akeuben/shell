pub const ext = @import("ext.zig");
const ebook = @This();

const std = @import("std");
const compat = @import("compat");
const libxml2 = @import("libxml22");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const edataserver = @import("edataserver1");
const soup = @import("soup3");
const json = @import("json1");
const camel = @import("camel1");
const ebookcontacts = @import("ebookcontacts1");
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BookClient = extern struct {
    pub const Parent = edataserver.Client;
    pub const Implements = [_]type{ gio.AsyncInitable, gio.Initable };
    pub const Class = ebook.BookClientClass;
    f_parent: edataserver.Client,
    f_priv: ?*ebook.BookClientPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently active locale for this addressbook.
        pub const locale = struct {
            pub const name = "locale";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Asynchronously creates a new `ebook.BookClient` for `source`.
    ///
    /// The `wait_for_connected_seconds` argument had been added since 3.16,
    /// to let the caller decide how long to wait for the backend to fully
    /// connect to its (possibly remote) data store. This is required due
    /// to a change in the authentication process, which is fully asynchronous
    /// and done on the client side, while not every client is supposed to
    /// response to authentication requests. In case the backend will not connect
    /// within the set interval, then it is opened in an offline mode. A special
    /// value -1 can be used to not wait for the connected state at all.
    ///
    /// Unlike with `ebook.BookClient.new`, there is no need to call `edataserver.Client.open`
    /// after obtaining the `ebook.BookClient`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebook.BookClient.connectFinish` to get the result of the operation.
    extern fn e_book_client_connect(p_source: *edataserver.Source, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const connect = e_book_client_connect;

    /// Like `ebook.BookClient.connect`, except creates the book client for
    /// direct read access to the underlying addressbook.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebook.BookClient.connectDirectFinish` to get the result of the operation.
    extern fn e_book_client_connect_direct(p_source: *edataserver.Source, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const connectDirect = e_book_client_connect_direct;

    /// Finishes the operation started with `ebook.BookClient.connectDirect`.
    /// If an error occurs in connecting to the D-Bus service, the function sets
    /// `error` and returns `NULL`.
    ///
    /// For error handling convenience, any error message returned by this
    /// function will have a descriptive prefix that includes the display
    /// name of the `edataserver.Source` passed to `ebook.BookClient.connectDirect`.
    extern fn e_book_client_connect_direct_finish(p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*ebook.BookClient;
    pub const connectDirectFinish = e_book_client_connect_direct_finish;

    /// Like `ebook.BookClient.connectSync`, except creates the book client for
    /// direct read access to the underlying addressbook.
    extern fn e_book_client_connect_direct_sync(p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebook.BookClient;
    pub const connectDirectSync = e_book_client_connect_direct_sync;

    /// Finishes the operation started with `ebook.BookClient.connect`.  If an
    /// error occurs in connecting to the D-Bus service, the function sets
    /// `error` and returns `NULL`.
    ///
    /// For error handling convenience, any error message returned by this
    /// function will have a descriptive prefix that includes the display
    /// name of the `edataserver.Source` passed to `ebook.BookClient.connect`.
    extern fn e_book_client_connect_finish(p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*ebook.BookClient;
    pub const connectFinish = e_book_client_connect_finish;

    /// Creates a new `ebook.BookClient` for `source`.  If an error occurs, the function
    /// will set `error` and return `FALSE`.
    ///
    /// Unlike with `ebook.BookClient.new`, there is no need to call
    /// `edataserver.Client.openSync` after obtaining the `ebook.BookClient`.
    ///
    /// The `wait_for_connected_seconds` argument had been added since 3.16,
    /// to let the caller decide how long to wait for the backend to fully
    /// connect to its (possibly remote) data store. This is required due
    /// to a change in the authentication process, which is fully asynchronous
    /// and done on the client side, while not every client is supposed to
    /// response to authentication requests. In case the backend will not connect
    /// within the set interval, then it is opened in an offline mode. A special
    /// value -1 can be used to not wait for the connected state at all.
    ///
    /// For error handling convenience, any error message returned by this
    /// function will have a descriptive prefix that includes the display
    /// name of `source`.
    extern fn e_book_client_connect_sync(p_source: *edataserver.Source, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebook.BookClient;
    pub const connectSync = e_book_client_connect_sync;

    /// Get the `ebookcontacts.Contact` referring to the user of the address book
    /// and set it in `out_contact` and `out_client`.
    extern fn e_book_client_get_self(p_registry: *edataserver.SourceRegistry, p_out_contact: **ebookcontacts.Contact, p_out_client: **ebook.BookClient, p_error: ?*?*glib.Error) c_int;
    pub const getSelf = e_book_client_get_self;

    /// Check if `contact` is the user of the address book.
    extern fn e_book_client_is_self(p_contact: *ebookcontacts.Contact) c_int;
    pub const isSelf = e_book_client_is_self;

    /// Creates a new `ebook.BookClient` corresponding to the given source.  There are
    /// only two operations that are valid on this book at this point:
    /// `edataserver.Client.open`, and `edataserver.Client.remove`.
    extern fn e_book_client_new(p_source: *edataserver.Source, p_error: ?*?*glib.Error) ?*ebook.BookClient;
    pub const new = e_book_client_new;

    /// Adds `contact` to `client`.
    /// The call is finished by `ebook.BookClient.addContactFinish`
    /// from the `callback`.
    extern fn e_book_client_add_contact(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const addContact = e_book_client_add_contact;

    /// Finishes previous call of `ebook.BookClient.addContact` and
    /// sets `out_added_uid` to a UID of a newly added contact.
    /// This string should be freed with `glib.free`.
    ///
    /// Note: This is not modifying original `ebookcontacts.Contact`.
    extern fn e_book_client_add_contact_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_added_uid: ?*[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const addContactFinish = e_book_client_add_contact_finish;

    /// Adds `contact` to `client` and
    /// sets `out_added_uid` to a UID of a newly added contact.
    /// This string should be freed with `glib.free`.
    ///
    /// Note: This is not modifying original `contact`, thus if it's needed,
    /// then use e_contact_set (contact, E_CONTACT_UID, new_uid).
    extern fn e_book_client_add_contact_sync(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_out_added_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addContactSync = e_book_client_add_contact_sync;

    /// Adds `contacts` to `client`.
    /// The call is finished by `ebook.BookClient.addContactsFinish`
    /// from the `callback`.
    extern fn e_book_client_add_contacts(p_client: *BookClient, p_contacts: *glib.SList, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const addContacts = e_book_client_add_contacts;

    /// Finishes previous call of `ebook.BookClient.addContacts` and
    /// sets `out_added_uids` to the UIDs of newly added contacts if successful.
    /// This `glib.SList` should be freed with `edataserver.Client.utilFreeStringSlist`.
    ///
    /// If any of the contacts cannot be inserted, all of the insertions will be
    /// reverted and this method will return `FALSE`.
    ///
    /// Note: This is not modifying original `ebookcontacts.Contact` objects.
    extern fn e_book_client_add_contacts_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_added_uids: ?**glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const addContactsFinish = e_book_client_add_contacts_finish;

    /// Adds `contacts` to `client` and
    /// sets `out_added_uids` to the UIDs of newly added contacts if successful.
    /// This `glib.SList` should be freed with `edataserver.Client.utilFreeStringSlist`.
    ///
    /// If any of the contacts cannot be inserted, all of the insertions will be
    /// reverted and this method will return `FALSE`.
    ///
    /// Note: This is not modifying original `contacts`, thus if it's needed,
    /// then use e_contact_set (contact, E_CONTACT_UID, new_uid).
    extern fn e_book_client_add_contacts_sync(p_client: *BookClient, p_contacts: *glib.SList, p_opflags: u32, p_out_added_uids: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addContactsSync = e_book_client_add_contacts_sync;

    /// Asynchronously checks whether contains an `email_address`. When the `email_address`
    /// contains multiple addresses, then returns `TRUE` when at least one
    /// address exists in the address book.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebook.BookClient.containsEmailFinish` to get the result of the
    /// operation.
    extern fn e_book_client_contains_email(p_client: *BookClient, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const containsEmail = e_book_client_contains_email;

    /// Finishes previous call of `ebook.BookClient.containsEmail`.
    extern fn e_book_client_contains_email_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const containsEmailFinish = e_book_client_contains_email_finish;

    extern fn e_book_client_contains_email_sync(p_client: *BookClient, p_email_address: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const containsEmailSync = e_book_client_contains_email_sync;

    /// Receive `ebookcontacts.Contact` from the `client` for the given `uid`.
    /// The call is finished by `ebook.BookClient.getContactFinish`
    /// from the `callback`.
    extern fn e_book_client_get_contact(p_client: *BookClient, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContact = e_book_client_get_contact;

    /// Finishes previous call of `ebook.BookClient.getContact`.
    /// If successful, then the `out_contact` is set to newly allocated
    /// `ebookcontacts.Contact`, which should be freed with `gobject.Object.unref`.
    extern fn e_book_client_get_contact_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_contact: ?**ebookcontacts.Contact, p_error: ?*?*glib.Error) c_int;
    pub const getContactFinish = e_book_client_get_contact_finish;

    /// Receive `ebookcontacts.Contact` from the `client` for the gived `uid`.
    /// If successful, then the `out_contact` is set to newly allocated
    /// `ebookcontacts.Contact`, which should be freed with `gobject.Object.unref`.
    extern fn e_book_client_get_contact_sync(p_client: *BookClient, p_uid: [*:0]const u8, p_out_contact: **ebookcontacts.Contact, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactSync = e_book_client_get_contact_sync;

    /// Query `client` with `sexp`, receiving a list of contacts which
    /// matched. The call is finished by `ebook.BookClient.getContactsFinish`
    /// from the `callback`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_contacts(p_client: *BookClient, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContacts = e_book_client_get_contacts;

    /// Finishes previous call of `ebook.BookClient.getContacts`.
    /// If successful, then the `out_contacts` is set to newly allocated list of
    /// `ebookcontacts.Contact`(s), which should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_book_client_get_contacts_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_contacts: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getContactsFinish = e_book_client_get_contacts_finish;

    /// Query `client` with `sexp`, receiving a list of contacts which matched.
    /// If successful, then the `out_contacts` is set to newly allocated `glib.SList` of
    /// `ebookcontacts.Contact`(s), which should be freed with `edataserver.Client.utilFreeObjectSlist`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_contacts_sync(p_client: *BookClient, p_sexp: [*:0]const u8, p_out_contacts: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactsSync = e_book_client_get_contacts_sync;

    /// Query `client` with `sexp`, receiving a list of contacts UIDs which
    /// matched. The call is finished by `ebook.BookClient.getContactsUidsFinish`
    /// from the `callback`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_contacts_uids(p_client: *BookClient, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getContactsUids = e_book_client_get_contacts_uids;

    /// Finishes previous call of `ebook.BookClient.getContactsUids`.
    /// If successful, then the `out_contact_uids` is set to newly allocated list
    /// of UID strings, which should be freed with `edataserver.Client.utilFreeStringSlist`.
    extern fn e_book_client_get_contacts_uids_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_contact_uids: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getContactsUidsFinish = e_book_client_get_contacts_uids_finish;

    /// Query `client` with `sexp`, receiving a list of contacts UIDs which matched.
    /// If successful, then the `out_contact_uids` is set to newly allocated list
    /// of UID strings, which should be freed with `edataserver.Client.utilFreeStringSlist`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_contacts_uids_sync(p_client: *BookClient, p_sexp: [*:0]const u8, p_out_contact_uids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getContactsUidsSync = e_book_client_get_contacts_uids_sync;

    /// Create an `ebook.BookClientCursor`.
    /// The call is finished by `ebook.BookClient.getCursorFinish`
    /// from the `callback`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_cursor(p_client: *BookClient, p_sexp: [*:0]const u8, p_sort_fields: *const ebookcontacts.ContactField, p_sort_types: *const ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getCursor = e_book_client_get_cursor;

    /// Finishes previous call of `ebook.BookClient.getCursor`.
    /// If successful, then the `out_cursor` is set to newly create
    /// `ebook.BookClientCursor`, the cursor should be freed with `gobject.Object.unref`
    /// when no longer needed.
    extern fn e_book_client_get_cursor_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_cursor: **ebook.BookClientCursor, p_error: ?*?*glib.Error) c_int;
    pub const getCursorFinish = e_book_client_get_cursor_finish;

    /// Create an `ebook.BookClientCursor`. If successful, then the `out_cursor` is set
    /// to newly allocated `ebook.BookClientCursor`, the cursor should be freed with `gobject.Object.unref`
    /// when no longer needed.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_cursor_sync(p_client: *BookClient, p_sexp: [*:0]const u8, p_sort_fields: *const ebookcontacts.ContactField, p_sort_types: *const ebookcontacts.BookCursorSortType, p_n_fields: c_uint, p_out_cursor: **ebook.BookClientCursor, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getCursorSync = e_book_client_get_cursor_sync;

    /// Reports the locale in use for `client`. The addressbook might sort contacts
    /// in different orders, or store and compare phone numbers in different ways
    /// depending on the currently set locale.
    ///
    /// Locales can change dynamically if systemd decides to change the locale, so
    /// it's important to listen for notifications on the `ebook.BookClient.properties.locale` property
    /// if you depend on sorted result lists. Ordered results should be reloaded
    /// after a locale change is detected.
    extern fn e_book_client_get_locale(p_client: *BookClient) [*:0]const u8;
    pub const getLocale = e_book_client_get_locale;

    /// Query `client` with `sexp`, creating an `ebook.BookClientView`.
    /// The call is finished by `ebook.BookClient.getViewFinish`
    /// from the `callback`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_view(p_client: *BookClient, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getView = e_book_client_get_view;

    /// Finishes previous call of `ebook.BookClient.getView`.
    /// If successful, then the `out_view` is set to newly allocated
    /// `ebook.BookClientView`, which should be freed with `gobject.Object.unref`.
    extern fn e_book_client_get_view_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_out_view: **ebook.BookClientView, p_error: ?*?*glib.Error) c_int;
    pub const getViewFinish = e_book_client_get_view_finish;

    /// Query `client` with `sexp`, creating an `ebook.BookClientView`.
    /// If successful, then the `out_view` is set to newly allocated
    /// `ebook.BookClientView`, which should be freed with `gobject.Object.unref`.
    ///
    /// Note: `sexp` can be obtained through `ebookcontacts.BookQuery`, by converting it
    /// to a string with `ebookcontacts.BookQuery.toString`.
    extern fn e_book_client_get_view_sync(p_client: *BookClient, p_sexp: [*:0]const u8, p_out_view: **ebook.BookClientView, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getViewSync = e_book_client_get_view_sync;

    /// Applies the changes made to `contact` to the stored version in `client`.
    /// The call is finished by `ebook.BookClient.modifyContactFinish`
    /// from the `callback`.
    extern fn e_book_client_modify_contact(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyContact = e_book_client_modify_contact;

    /// Finishes previous call of `ebook.BookClient.modifyContact`.
    extern fn e_book_client_modify_contact_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactFinish = e_book_client_modify_contact_finish;

    /// Applies the changes made to `contact` to the stored version in `client`.
    extern fn e_book_client_modify_contact_sync(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactSync = e_book_client_modify_contact_sync;

    /// Applies the changes made to `contacts` to the stored versions in `client`.
    /// The call is finished by `ebook.BookClient.modifyContactsFinish`
    /// from the `callback`.
    extern fn e_book_client_modify_contacts(p_client: *BookClient, p_contacts: *glib.SList, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyContacts = e_book_client_modify_contacts;

    /// Finishes previous call of `ebook.BookClient.modifyContacts`.
    extern fn e_book_client_modify_contacts_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactsFinish = e_book_client_modify_contacts_finish;

    /// Applies the changes made to `contacts` to the stored versions in `client`.
    extern fn e_book_client_modify_contacts_sync(p_client: *BookClient, p_contacts: *glib.SList, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyContactsSync = e_book_client_modify_contacts_sync;

    /// Removes `contact` from the `client`.
    /// The call is finished by `ebook.BookClient.removeContactFinish`
    /// from the `callback`.
    extern fn e_book_client_remove_contact(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeContact = e_book_client_remove_contact;

    /// Removes contact with `uid` from the `client`.
    /// The call is finished by `ebook.BookClient.removeContactByUidFinish`
    /// from the `callback`.
    extern fn e_book_client_remove_contact_by_uid(p_client: *BookClient, p_uid: [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeContactByUid = e_book_client_remove_contact_by_uid;

    /// Finishes previous call of `ebook.BookClient.removeContactByUid`.
    extern fn e_book_client_remove_contact_by_uid_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeContactByUidFinish = e_book_client_remove_contact_by_uid_finish;

    /// Removes contact with `uid` from the `client`.
    extern fn e_book_client_remove_contact_by_uid_sync(p_client: *BookClient, p_uid: [*:0]const u8, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContactByUidSync = e_book_client_remove_contact_by_uid_sync;

    /// Finishes previous call of `ebook.BookClient.removeContact`.
    extern fn e_book_client_remove_contact_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeContactFinish = e_book_client_remove_contact_finish;

    /// Removes `contact` from the `client`.
    extern fn e_book_client_remove_contact_sync(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContactSync = e_book_client_remove_contact_sync;

    /// Removes the contacts with uids from the list `uids` from `client`.  This is
    /// always more efficient than calling `ebook.BookClient.removeContact` if you
    /// have more than one uid to remove, as some backends can implement it
    /// as a batch request.
    /// The call is finished by `ebook.BookClient.removeContactsFinish`
    /// from the `callback`.
    extern fn e_book_client_remove_contacts(p_client: *BookClient, p_uids: *const glib.SList, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeContacts = e_book_client_remove_contacts;

    /// Finishes previous call of `ebook.BookClient.removeContacts`.
    extern fn e_book_client_remove_contacts_finish(p_client: *BookClient, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeContactsFinish = e_book_client_remove_contacts_finish;

    /// Removes the contacts with uids from the list `uids` from `client`.  This is
    /// always more efficient than calling `ebook.BookClient.removeContact` if you
    /// have more than one uid to remove, as some backends can implement it
    /// as a batch request.
    extern fn e_book_client_remove_contacts_sync(p_client: *BookClient, p_uids: *const glib.SList, p_opflags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeContactsSync = e_book_client_remove_contacts_sync;

    /// Specify that `contact` residing in `client` is the `ebookcontacts.Contact` that
    /// refers to the user of the address book.
    extern fn e_book_client_set_self(p_client: *BookClient, p_contact: *ebookcontacts.Contact, p_error: ?*?*glib.Error) c_int;
    pub const setSelf = e_book_client_set_self;

    extern fn e_book_client_get_type() usize;
    pub const getGObjectType = e_book_client_get_type;

    extern fn g_object_ref(p_self: *ebook.BookClient) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebook.BookClient) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookClient, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data.
pub const BookClientCursor = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = ebook.BookClientCursorClass;
    f_parent: gobject.Object,
    f_priv: ?*ebook.BookClientCursorPrivate,

    pub const virtual_methods = struct {
        /// The class handler for the `ebook.BookClientCursor.signals.refresh` signal
        pub const refresh = struct {
            pub fn call(p_class: anytype, p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(BookClientCursor.Class, p_class).f_refresh.?(gobject.ext.as(BookClientCursor, p_cursor));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cursor: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(BookClientCursor.Class, p_class).f_refresh = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The currently <link linkend="cursor-alphabet">active alphabet</link>.
        ///
        /// The value is a `NULL` terminated array of strings,
        /// each string is suitable to display a specific letter
        /// in the active alphabet.
        ///
        /// Indexes from this array can later be used with
        /// `ebook.BookClientCursor.setAlphabeticIndex`.
        ///
        /// This property will automatically change if the
        /// active locale of the addressbook server changes.
        ///
        /// Property change notifications are guaranteed to be
        /// delivered in the `glib.MainContext` which was the thread
        /// default context at cursor creation time.
        pub const alphabet = struct {
            pub const name = "alphabet";

            pub const Type = ?[*][*:0]u8;
        };

        /// The `ebook.BookClient` which this cursor was created for
        pub const client = struct {
            pub const name = "client";

            pub const Type = ?*ebook.BookClient;
        };

        /// The `gio.DBusConnection` to the addressbook server.
        ///
        /// <note><para>This is an internal parameter for constructing the
        /// cursor, to construct the cursor use `ebook.BookClient.getCursor`.
        /// </para></note>
        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        /// The `glib.MainContext` in which the `ebook.BookClient` created this cursor.
        ///
        /// <note><para>This is an internal parameter for constructing the
        /// cursor, to construct the cursor use `ebook.BookClient.getCursor`.
        /// </para></note>
        pub const context = struct {
            pub const name = "context";

            pub const Type = ?*glib.MainContext;
        };

        /// The direct handle to the `EDataBookCursor` for direct read access mode.
        ///
        /// <note><para>This is an internal parameter for constructing the
        /// cursor, to construct the cursor use `ebook.BookClient.getCursor`.
        /// </para></note>
        pub const direct_cursor = struct {
            pub const name = "direct-cursor";

            pub const Type = @compileError("no type information available");
        };

        /// The D-Bus object path to find the server side cursor object.
        ///
        /// <note><para>This is an internal parameter for constructing the
        /// cursor, to construct the cursor use `ebook.BookClient.getCursor`.
        /// </para></note>
        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };

        /// The current cursor position in the cursor's result list.
        ///
        /// More specifically, the cursor position is defined as
        /// the number of contacts leading up to the current
        /// cursor position, inclusive of the current cursor
        /// position.
        ///
        /// If the position value is 0, then the cursor is positioned
        /// before the contact list in the symbolic `E_BOOK_CURSOR_ORIGIN_BEGIN`
        /// position. If the position value is greater than
        /// `ebook.BookClientCursor.properties.total`, this indicates that the cursor is
        /// positioned after the contact list in the symbolic
        /// `E_BOOK_CURSOR_ORIGIN_END` position.
        ///
        /// Property change notifications are guaranteed to be
        /// delivered in the `glib.MainContext` which was the thread
        /// default context at cursor creation time.
        pub const position = struct {
            pub const name = "position";

            pub const Type = c_int;
        };

        /// The `ebookcontacts.ContactField` names to sort this cursor with
        ///
        /// <note><para>This is an internal parameter for constructing the
        /// cursor, to construct the cursor use `ebook.BookClient.getCursor`.
        /// </para></note>
        pub const sort_fields = struct {
            pub const name = "sort-fields";

            pub const Type = ?[*][*:0]u8;
        };

        /// The total number of contacts which satisfy the cursor's query.
        ///
        /// Property change notifications are guaranteed to be
        /// delivered in the `glib.MainContext` which was the thread
        /// default context at cursor creation time.
        pub const total = struct {
            pub const name = "total";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Indicates that the addressbook has been modified and
        /// that any content currently being displayed from the current
        /// cursor position should be reloaded.
        ///
        /// This signal is guaranteed to be delivered in the `glib.MainContext`
        /// which was the thread default context at cursor creation time.
        pub const refresh = struct {
            pub const name = "refresh";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientCursor, p_instance))),
                    gobject.signalLookup("refresh", BookClientCursor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Fetches the array of displayable labels for the <link linkend="cursor-alphabet">active alphabet</link>.
    ///
    /// The active alphabet is based on the current locale configuration of the
    /// addressbook, and can be a different alphabet for locales requiring non-Latin
    /// language scripts. These UTF-8 labels are appropriate to display in a user
    /// interface to represent the alphabetic position of the cursor in the user's
    /// native alphabet.
    ///
    /// The `underflow`, `inflow` and `overflow` parameters allow one to observe which
    /// indexes Evolution Data Server is using to store words which sort outside
    /// of the alphabet, for instance words from foreign language scripts and
    /// words which start with numeric characters, or other types of character.
    ///
    /// While the `underflow` and `overflow` are for words which sort below or
    /// above the active alphabets, the `inflow` index is for words which sort
    /// in between multiple concurrently active alphabets. The active alphabet
    /// array might contain more than one alphabet for locales where it is
    /// very common or expected to have names in Latin script as well as names
    /// in another script.
    extern fn e_book_client_cursor_get_alphabet(p_cursor: *BookClientCursor, p_n_labels: ?*c_int, p_underflow: ?*c_int, p_inflow: ?*c_int, p_overflow: ?*c_int) [*]const [*:0]const u8;
    pub const getAlphabet = e_book_client_cursor_get_alphabet;

    /// Checks which alphabetic index `contact` would be sorted
    /// into according to `cursor`.
    ///
    /// So long as the active `ebook.BookClientCursor.properties.alphabet` does
    /// not change, the returned index will be a valid position
    /// in the array of labels returned by `ebook.BookClientCursor.getAlphabet`.
    ///
    /// If the index returned by this function is needed for
    /// any extended period of time, it should be recalculated
    /// whenever the `ebook.BookClientCursor.properties.alphabet` changes.
    extern fn e_book_client_cursor_get_contact_alphabetic_index(p_cursor: *BookClientCursor, p_contact: *ebookcontacts.Contact) c_int;
    pub const getContactAlphabeticIndex = e_book_client_cursor_get_contact_alphabetic_index;

    /// Fetches the number of contacts leading up to the current
    /// cursor position, inclusive of the current cursor position.
    ///
    /// The position value can be anywhere from 0 to the total
    /// number of contacts plus one. A value of 0 indicates
    /// that the cursor is positioned before the contact list in
    /// the symbolic `E_BOOK_CURSOR_ORIGIN_BEGIN` state. If
    /// the position is greater than the total, as returned by
    /// `ebook.BookClientCursor.getTotal`, then the cursor is positioned
    /// after the last contact in the symbolic `E_BOOK_CURSOR_ORIGIN_END` position.
    extern fn e_book_client_cursor_get_position(p_cursor: *BookClientCursor) c_int;
    pub const getPosition = e_book_client_cursor_get_position;

    /// Fetches the total number of contacts in the addressbook
    /// which match `cursor`'s query
    extern fn e_book_client_cursor_get_total(p_cursor: *BookClientCursor) c_int;
    pub const getTotal = e_book_client_cursor_get_total;

    /// Returns the `ebook.BookClientCursor.properties.client` associated with `cursor`.
    ///
    /// The returned `ebook.BookClient` is referenced because the cursor
    /// does not keep a strong reference to the client.
    ///
    /// Unreference the `ebook.BookClient` with `gobject.Object.unref` when finished with it.
    extern fn e_book_client_cursor_ref_client(p_cursor: *BookClientCursor) *ebook.BookClient;
    pub const refClient = e_book_client_cursor_ref_client;

    /// Sets the current cursor position to point to an <link linkend="cursor-alphabet">Alphabetic Index</link>.
    ///
    /// See: `ebook.BookClientCursor.setAlphabeticIndexSync`.
    ///
    /// This asynchronous call is completed with a call to
    /// `ebook.BookClientCursor.setAlphabeticIndexFinish` from the specified `callback`.
    extern fn e_book_client_cursor_set_alphabetic_index(p_cursor: *BookClientCursor, p_index: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const setAlphabeticIndex = e_book_client_cursor_set_alphabetic_index;

    /// Completes an asynchronous call initiated by `ebook.BookClientCursor.setAlphabeticIndex`.
    extern fn e_book_client_cursor_set_alphabetic_index_finish(p_cursor: *BookClientCursor, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setAlphabeticIndexFinish = e_book_client_cursor_set_alphabetic_index_finish;

    /// Sets the cursor to point to an <link linkend="cursor-alphabet">Alphabetic Index</link>.
    ///
    /// After setting the alphabetic index, for example the
    /// index for letter 'E', then further calls to `ebook.BookClientCursor.step`
    /// will return results starting with the letter 'E' (or results starting
    /// with the last result in 'D' when navigating through cursor results
    /// in reverse).
    ///
    /// The passed index must be a valid index into the alphabet parameters
    /// returned by `ebook.BookClientCursor.getAlphabet`.
    ///
    /// If this method is called from the same thread context in which
    /// the cursor was created, then the updates to the `ebook.BookClientCursor.properties.position`
    /// property are guaranteed to be delivered synchronously upon successful completion
    /// of moving the cursor. Otherwise, notifications will be delivered asynchronously
    /// in the cursor's original thread context.
    ///
    /// If this method completes with an `E_CLIENT_ERROR_OUT_OF_SYNC` error, it is an
    /// indication that the addressbook has been set into a new locale and it would be
    /// unsafe to set the alphabetic index at this time. If you receive an out of sync
    /// error from this method, then you should wait until an `ebook.BookClientCursor.properties.alphabet`
    /// property change notification is delivered and then proceed to load the new
    /// alphabet before trying to set any alphabetic index.
    extern fn e_book_client_cursor_set_alphabetic_index_sync(p_cursor: *BookClientCursor, p_index: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setAlphabeticIndexSync = e_book_client_cursor_set_alphabetic_index_sync;

    /// Sets the <link linkend="cursor-search">Search Expression</link> for the cursor.
    ///
    /// See: `ebook.BookClientCursor.setSexpSync`.
    ///
    /// This asynchronous call is completed with a call to
    /// `ebook.BookClientCursor.setSexpFinish` from the specified `callback`.
    extern fn e_book_client_cursor_set_sexp(p_cursor: *BookClientCursor, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const setSexp = e_book_client_cursor_set_sexp;

    /// Completes an asynchronous call initiated by `ebook.BookClientCursor.setSexp`, reporting
    /// whether the new search expression was accepted.
    extern fn e_book_client_cursor_set_sexp_finish(p_cursor: *BookClientCursor, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setSexpFinish = e_book_client_cursor_set_sexp_finish;

    /// Sets the <link linkend="cursor-search">Search Expression</link> for the cursor.
    ///
    /// A side effect of setting the search expression is that the
    /// <link linkend="cursor-pos-total">position and total</link>
    /// properties will be updated.
    ///
    /// If this method is called from the same thread context in which
    /// the cursor was created, then the updates to the `ebook.BookClientCursor.properties.position`
    /// and `ebook.BookClientCursor.properties.total` properties are guaranteed to be delivered
    /// synchronously upon successful completion of setting the search expression.
    /// Otherwise, notifications will be delivered asynchronously in the cursor's
    /// original thread context.
    ///
    /// If the backend does not support the given search expression,
    /// an `E_CLIENT_ERROR_INVALID_QUERY` error will be set.
    extern fn e_book_client_cursor_set_sexp_sync(p_cursor: *BookClientCursor, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setSexpSync = e_book_client_cursor_set_sexp_sync;

    /// <link linkend="cursor-iteration">Steps the cursor through the results</link> by
    /// a maximum of `count` and fetch the results traversed.
    ///
    /// See: `ebook.BookClientCursor.stepSync`.
    ///
    /// This asynchronous call is completed with a call to
    /// `ebook.BookClientCursor.stepFinish` from the specified `callback`.
    extern fn e_book_client_cursor_step(p_cursor: *BookClientCursor, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const step = e_book_client_cursor_step;

    /// Completes an asynchronous call initiated by `ebook.BookClientCursor.step`, fetching
    /// any contacts which might have been returned by the call.
    extern fn e_book_client_cursor_step_finish(p_cursor: *BookClientCursor, p_result: *gio.AsyncResult, p_out_contacts: ?**glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const stepFinish = e_book_client_cursor_step_finish;

    /// <link linkend="cursor-iteration">Steps the cursor through the results</link> by
    /// a maximum of `count` and fetch the results traversed.
    ///
    /// If `count` is negative, then the cursor will move backwards.
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
    /// If `E_BOOK_CURSOR_STEP_MOVE` is specified in `flags`, then the cursor's
    /// state will be modified and the <link linkend="cursor-pos-total">position</link>
    /// property will be updated as a result.
    ///
    /// If this method is called from the same thread context in which
    /// the cursor was created, then the updates to the `ebook.BookClientCursor.properties.position`
    /// property are guaranteed to be delivered synchronously upon successful completion
    /// of moving the cursor. Otherwise, notifications will be delivered asynchronously
    /// in the cursor's original thread context.
    ///
    /// If this method completes with an `E_CLIENT_ERROR_OUT_OF_SYNC` error, it is an
    /// indication that the addressbook has been modified and it would be unsafe to
    /// move the cursor at this time. Any `E_CLIENT_ERROR_OUT_OF_SYNC` error is guaranteed
    /// to be followed by an `ebook.BookClientCursor.signals.refresh` signal at which point any content
    /// should be reloaded.
    extern fn e_book_client_cursor_step_sync(p_cursor: *BookClientCursor, p_flags: ebookcontacts.BookCursorStepFlags, p_origin: ebookcontacts.BookCursorOrigin, p_count: c_int, p_out_contacts: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const stepSync = e_book_client_cursor_step_sync;

    extern fn e_book_client_cursor_get_type() usize;
    pub const getGObjectType = e_book_client_cursor_get_type;

    extern fn g_object_ref(p_self: *ebook.BookClientCursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebook.BookClientCursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookClientCursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data the should be read and manipulated using the
/// functions below.
pub const BookClientView = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = ebook.BookClientViewClass;
    f_parent: gobject.Object,
    f_priv: ?*ebook.BookClientViewPrivate,

    pub const virtual_methods = struct {
        /// Notification that loading a view has completed, after calling `ebook.BookClientView.start`
        pub const complete = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) void {
                return gobject.ext.as(BookClientView.Class, p_class).f_complete.?(gobject.ext.as(BookClientView, p_client_view), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(BookClientView.Class, p_class).f_complete = @ptrCast(p_implementation);
            }
        };

        /// Signal emitted when contacts are added in the view
        pub const objects_added = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) void {
                return gobject.ext.as(BookClientView.Class, p_class).f_objects_added.?(gobject.ext.as(BookClientView, p_client_view), p_objects);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(BookClientView.Class, p_class).f_objects_added = @ptrCast(p_implementation);
            }
        };

        /// Signal emitted when contacts in the view are modified
        pub const objects_modified = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) void {
                return gobject.ext.as(BookClientView.Class, p_class).f_objects_modified.?(gobject.ext.as(BookClientView, p_client_view), p_objects);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(BookClientView.Class, p_class).f_objects_modified = @ptrCast(p_implementation);
            }
        };

        /// Signal emitted when contacts are removed from the view
        pub const objects_removed = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList) void {
                return gobject.ext.as(BookClientView.Class, p_class).f_objects_removed.?(gobject.ext.as(BookClientView, p_client_view), p_uids);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(BookClientView.Class, p_class).f_objects_removed = @ptrCast(p_implementation);
            }
        };

        /// Signal emitted intermittently while loading a view after calling `ebook.BookClientView.start`
        pub const progress = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_percent: c_uint, p_message: [*:0]const u8) void {
                return gobject.ext.as(BookClientView.Class, p_class).f_progress.?(gobject.ext.as(BookClientView, p_client_view), p_percent, p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_percent: c_uint, p_message: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(BookClientView.Class, p_class).f_progress = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const client = struct {
            pub const name = "client";

            pub const Type = ?*ebook.BookClient;
        };

        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        pub const direct_backend = struct {
            pub const name = "direct-backend";

            pub const Type = @compileError("no type information available");
        };

        /// A list of `ebookcontacts.BookIndices` holding indices of the contacts in the view.
        /// These are received from the first sort field set by
        /// `ebook.BookClientView.setSortFieldsSync`. The last item of the returned
        /// array is the one with chr member being `NULL`.
        ///
        /// Note: This property can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
        pub const indices = struct {
            pub const name = "indices";

            pub const Type = ?*ebookcontacts.BookIndices;
        };

        /// How many contacts are available in the view.
        ///
        /// Note: This property can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
        pub const n_total = struct {
            pub const name = "n-total";

            pub const Type = c_uint;
        };

        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const complete = struct {
            pub const name = "complete";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("complete", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal is emitted whenever content of any contact in the `client_view` changes,
        /// or a contact is added or removed. It may or may not change `EBookClientView`:n-total
        /// property too.
        ///
        /// Note: This signal can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
        pub const content_changed = struct {
            pub const name = "content-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("content-changed", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_added = struct {
            pub const name = "objects-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_objects: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("objects-added", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_modified = struct {
            pub const name = "objects-modified";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_objects: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("objects-modified", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_removed = struct {
            pub const name = "objects-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_uids: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("objects-removed", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const progress = struct {
            pub const name = "progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: c_uint, p_p0: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BookClientView, p_instance))),
                    gobject.signalLookup("progress", BookClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Asynchronously reads `range_length` contacts from index `range_start`.
    /// When there are asked more than `ebook.BookClientView.getNTotal`
    /// contacts only those up to the total number of contacts are read.
    /// Asking for out of range contacts results in an error.
    ///
    /// Finish the call by `ebook.BookClientView.dupContactsFinish` from the `cb`.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_dup_contacts(p_self: *BookClientView, p_range_start: c_uint, p_range_length: c_uint, p_cancellable: ?*gio.Cancellable, p_cb: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const dupContacts = e_book_client_view_dup_contacts;

    /// Finishes previous call of `ebook.BookClientView.dupContacts`;
    /// see it for further information.
    ///
    /// Free the returned `glib.PtrArray` with `glib.PtrArray.unref`, when
    /// no longer needed.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_dup_contacts_finish(p_self: *BookClientView, p_result: *gio.AsyncResult, p_out_range_start: ?*c_uint, p_out_contacts: **glib.PtrArray, p_error: ?*?*glib.Error) c_int;
    pub const dupContactsFinish = e_book_client_view_dup_contacts_finish;

    /// Returns a list of `ebookcontacts.BookIndices` holding indices of the contacts
    /// in the view. These are received from the first sort field set by
    /// `ebook.BookClientView.setSortFieldsSync`. The last item of the returned
    /// array is the one with chr member being `NULL`.
    ///
    /// Free the returned array with `ebookcontacts.BookIndices.free`, when no longer needed.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_dup_indices(p_self: *BookClientView) *ebookcontacts.BookIndices;
    pub const dupIndices = e_book_client_view_dup_indices;

    /// Returns the `ebook.BookClientView.properties.client` associated with `client_view`.
    extern fn e_book_client_view_get_client(p_client_view: *BookClientView) *ebook.BookClient;
    pub const getClient = e_book_client_view_get_client;

    /// Returns the `gio.DBusConnection` used to create the D-Bus proxy.
    extern fn e_book_client_view_get_connection(p_client_view: *BookClientView) *gio.DBusConnection;
    pub const getConnection = e_book_client_view_get_connection;

    /// Returns an identifier of the `self`. It does not change
    /// for the whole life time of the `self`.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_get_id(p_self: *BookClientView) usize;
    pub const getId = e_book_client_view_get_id;

    /// Returns how many contacts are available in the view.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_get_n_total(p_self: *BookClientView) c_uint;
    pub const getNTotal = e_book_client_view_get_n_total;

    /// Returns the object path used to create the D-Bus proxy.
    extern fn e_book_client_view_get_object_path(p_client_view: *BookClientView) [*:0]const u8;
    pub const getObjectPath = e_book_client_view_get_object_path;

    extern fn e_book_client_view_is_running(p_client_view: *BookClientView) c_int;
    pub const isRunning = e_book_client_view_is_running;

    /// Returns the `ebook.BookClientView.properties.client` associated with `client_view`.
    ///
    /// The returned `ebook.BookClient` is referenced for thread-safety.  Unreference
    /// the `ebook.BookClient` with `gobject.Object.unref` when finished with it.
    extern fn e_book_client_view_ref_client(p_client_view: *BookClientView) *ebook.BookClient;
    pub const refClient = e_book_client_view_ref_client;

    /// Client can instruct server to which fields it is interested in only, thus
    /// the server can return less data over the wire. The server can still return
    /// complete objects, this is just a hint to it that the listed fields will
    /// be used only. The UID field is returned always. Initial views has no fields
    /// of interest and using `NULL` for `fields_of_interest` will unset any previous
    /// changes.
    ///
    /// Some backends can use summary information of its cache to create artifical
    /// objects, which will omit stored object parsing. If this cannot be done then
    /// it will simply return object as is stored in the cache.
    extern fn e_book_client_view_set_fields_of_interest(p_client_view: *BookClientView, p_fields_of_interest: *const glib.SList, p_error: ?*?*glib.Error) void;
    pub const setFieldsOfInterest = e_book_client_view_set_fields_of_interest;

    /// Sets the `flags` which control the behaviour of `client_view`.
    extern fn e_book_client_view_set_flags(p_client_view: *BookClientView, p_flags: ebookcontacts.BookClientViewFlags, p_error: ?*?*glib.Error) void;
    pub const setFlags = e_book_client_view_set_flags;

    /// Sets `fields` to sort the view by. The default is to sort by the file-as
    /// field in ascending order. Not every field can be used for sorting,
    /// usually available fields are `E_CONTACT_FILE_AS`,
    /// `E_CONTACT_GIVEN_NAME` and `E_CONTACT_FAMILY_NAME`.
    ///
    /// The array is terminated by an item with an `E_CONTACT_FIELD_LAST` field.
    ///
    /// The first sort field is used to populate indices, as returned
    /// by `ebook.BookClientView.dupIndices`.
    ///
    /// Note: This function can be used only with `E_BOOK_CLIENT_VIEW_FLAGS_MANUAL_QUERY`.
    extern fn e_book_client_view_set_sort_fields_sync(p_self: *BookClientView, p_fields: *const ebookcontacts.BookClientViewSortFields, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setSortFieldsSync = e_book_client_view_set_sort_fields_sync;

    /// Tells `client_view` to start processing events.
    extern fn e_book_client_view_start(p_client_view: *BookClientView, p_error: ?*?*glib.Error) void;
    pub const start = e_book_client_view_start;

    /// Tells `client_view` to stop processing events.
    extern fn e_book_client_view_stop(p_client_view: *BookClientView, p_error: ?*?*glib.Error) void;
    pub const stop = e_book_client_view_stop;

    extern fn e_book_client_view_get_type() usize;
    pub const getGObjectType = e_book_client_view_get_type;

    extern fn g_object_ref(p_self: *ebook.BookClientView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebook.BookClientView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookClientView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Destination = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebook.DestinationClass;
    f_object: gobject.Object,
    f_priv: ?*ebook.DestinationPrivate,

    pub const virtual_methods = struct {
        pub const changed = struct {
            pub fn call(p_class: anytype, p_destination: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Destination.Class, p_class).f_changed.?(gobject.ext.as(Destination, p_destination));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_destination: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Destination.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Destination, p_instance))),
                    gobject.signalLookup("changed", Destination.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Exports multiple `ebook.Destination` elements to a single XML document.
    extern fn e_destination_exportv(p_destv: [*]*ebook.Destination) [*:0]u8;
    pub const exportv = e_destination_exportv;

    /// Unrefs the elements of `destv` and frees `destv` itself.
    extern fn e_destination_freev(p_destv: [*]*ebook.Destination) void;
    pub const freev = e_destination_freev;

    /// Generates a joint text representation of all the `ebook.Destination`
    /// elements in `destv`.
    extern fn e_destination_get_textrepv(p_destv: [*]*ebook.Destination) [*:0]u8;
    pub const getTextrepv = e_destination_get_textrepv;

    /// Creates an `ebook.Destination` from an XML document.
    extern fn e_destination_import(p_str: [*:0]const u8) ?*ebook.Destination;
    pub const import = e_destination_import;

    /// Creates an array of pointers to `ebook.Destination` elements
    /// from an XML document.
    extern fn e_destination_importv(p_str: [*:0]const u8) [*]*ebook.Destination;
    pub const importv = e_destination_importv;

    /// Creates a new `ebook.Destination` with blank values.
    extern fn e_destination_new() *ebook.Destination;
    pub const new = e_destination_new;

    /// Creates a new `ebook.Destination` identical to `dest`.
    extern fn e_destination_copy(p_dest: *const Destination) *ebook.Destination;
    pub const copy = e_destination_copy;

    /// Checks if `dest` is blank.
    extern fn e_destination_empty(p_dest: *const Destination) c_int;
    pub const empty = e_destination_empty;

    /// Checks if `a` and `b` are equal.
    extern fn e_destination_equal(p_a: *const Destination, p_b: *const ebook.Destination) c_int;
    pub const equal = e_destination_equal;

    /// Exports a destination to an XML document.
    extern fn e_destination_export(p_dest: *const Destination) [*:0]u8;
    pub const @"export" = e_destination_export;

    /// Exports the contact information from `dest` to parameters
    /// and values in `attr`, suitable for an address book.
    extern fn e_destination_export_to_vcard_attribute(p_dest: *Destination, p_attr: *ebookcontacts.VCardAttribute) void;
    pub const exportToVcardAttribute = e_destination_export_to_vcard_attribute;

    /// Gets the encoded name and email address, or in the case of lists, the
    /// encoded list of email addresses, from `dest`.  The returned string is
    /// suitable for use in an email header, but not for displaying to users.
    extern fn e_destination_get_address(p_dest: *const Destination) ?[*:0]const u8;
    pub const getAddress = e_destination_get_address;

    /// Gets the contact `dest` is pointing to, if any.
    extern fn e_destination_get_contact(p_dest: *const Destination) ?*ebookcontacts.Contact;
    pub const getContact = e_destination_get_contact;

    /// Gets the unique contact ID `dest` is pointing to, if any.
    extern fn e_destination_get_contact_uid(p_dest: *const Destination) ?[*:0]const u8;
    pub const getContactUid = e_destination_get_contact_uid;

    /// Gets the e-mail address of `dest`'s addressee.
    extern fn e_destination_get_email(p_dest: *const Destination) [*:0]const u8;
    pub const getEmail = e_destination_get_email;

    /// Gets the index of the e-mail address of the contact that
    /// `dest` is pointing to, if any.
    extern fn e_destination_get_email_num(p_dest: *const Destination) c_int;
    pub const getEmailNum = e_destination_get_email_num;

    /// Check if `dest` wants to get mail formatted as HTML.
    extern fn e_destination_get_html_mail_pref(p_dest: *const Destination) c_int;
    pub const getHtmlMailPref = e_destination_get_html_mail_pref;

    /// Gets the full name of `dest`'s addressee, or if the addressee is
    /// a contact list, the name the list was filed under. The name can
    /// be encoded in quoted printable.
    extern fn e_destination_get_name(p_dest: *const Destination) ?[*:0]const u8;
    pub const getName = e_destination_get_name;

    /// Gets the unique source ID `dest` is pointing to, if any. The source
    /// ID specifies which address book `dest`'s contact came from.
    extern fn e_destination_get_source_uid(p_dest: *const Destination) ?[*:0]const u8;
    pub const getSourceUid = e_destination_get_source_uid;

    /// Generates a textual representation of `dest`, suitable for referring
    /// to the destination during user interaction. The name can be encoded
    /// in quoted printable.
    extern fn e_destination_get_textrep(p_dest: *const Destination, p_include_email: c_int) [*:0]const u8;
    pub const getTextrep = e_destination_get_textrep;

    /// Checks if `dest` is flagged as an automatic recipient, meaning
    /// it was not explicitly specified by the user. This can be used
    /// to hide it from some UI elements.
    extern fn e_destination_is_auto_recipient(p_dest: *const Destination) c_int;
    pub const isAutoRecipient = e_destination_is_auto_recipient;

    /// Checks if `dest` is a list of addresses.
    extern fn e_destination_is_evolution_list(p_dest: *const Destination) c_int;
    pub const isEvolutionList = e_destination_is_evolution_list;

    /// Check if `dest` is to be ignored.
    extern fn e_destination_is_ignored(p_dest: *const Destination) c_int;
    pub const isIgnored = e_destination_is_ignored;

    /// If `dest` is a list, gets recursively list of all destinations.
    /// Everything returned from this function belongs to `dest` and
    /// thus should not be freed.
    extern fn e_destination_list_get_dests(p_dest: *const Destination) ?*const glib.List;
    pub const listGetDests = e_destination_list_get_dests;

    /// If `dest` is a list, gets the list of EDestinations assigned directly
    /// to `dest`.
    /// The list and its elements belong to `dest`, and should not be freed.
    extern fn e_destination_list_get_root_dests(p_dest: *const Destination) ?*const glib.List;
    pub const listGetRootDests = e_destination_list_get_root_dests;

    /// If `dest` is a list, checks if the addresses in the list
    /// should be presented to the user during interaction.
    extern fn e_destination_list_show_addresses(p_dest: *const Destination) c_int;
    pub const listShowAddresses = e_destination_list_show_addresses;

    /// Sets the flag indicating if `dest` is an automatic recipient, meaning
    /// it was not explicitly specified by the user. This can be used
    /// to hide it from some UI elements.
    extern fn e_destination_set_auto_recipient(p_dest: *Destination, p_value: c_int) void;
    pub const setAutoRecipient = e_destination_set_auto_recipient;

    /// Specify the source `dest`'s contact comes from. This is useful
    /// if you need to update the contact later.
    extern fn e_destination_set_client(p_dest: *Destination, p_client: *ebook.BookClient) void;
    pub const setClient = e_destination_set_client;

    /// Sets `dest` to point to one of `contact`'s e-mail addresses
    /// indicated by `email_num`.
    extern fn e_destination_set_contact(p_dest: *Destination, p_contact: *ebookcontacts.Contact, p_email_num: c_int) void;
    pub const setContact = e_destination_set_contact;

    /// Sets `dest` to point to one of the contact specified by `uid`'s e-mail
    /// addresses indicated by `email_num`.
    extern fn e_destination_set_contact_uid(p_dest: *Destination, p_uid: [*:0]const u8, p_email_num: c_int) void;
    pub const setContactUid = e_destination_set_contact_uid;

    /// Sets the e-mail address of `dest`'s addressee.
    extern fn e_destination_set_email(p_dest: *Destination, p_email: [*:0]const u8) void;
    pub const setEmail = e_destination_set_email;

    /// Specifies whether `dest` wants to get mail formatted as HTML.
    extern fn e_destination_set_html_mail_pref(p_dest: *Destination, p_flag: c_int) void;
    pub const setHtmlMailPref = e_destination_set_html_mail_pref;

    /// Set the ignore flag on an `ebook.Destination`.
    extern fn e_destination_set_ignored(p_dest: *Destination, p_ignored: c_int) void;
    pub const setIgnored = e_destination_set_ignored;

    /// Sets the full name of `dest`'s addressee.
    extern fn e_destination_set_name(p_dest: *Destination, p_name: [*:0]const u8) void;
    pub const setName = e_destination_set_name;

    /// Sets `dest` to point to the name and e-mail address resulting from
    /// parsing the supplied string. Useful for user input.
    extern fn e_destination_set_raw(p_dest: *Destination, p_raw: [*:0]const u8) void;
    pub const setRaw = e_destination_set_raw;

    extern fn e_destination_get_type() usize;
    pub const getGObjectType = e_destination_get_type;

    extern fn g_object_ref(p_self: *ebook.Destination) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebook.Destination) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Destination, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `ebook.BookClient` class.
pub const BookClientClass = extern struct {
    pub const Instance = ebook.BookClient;

    f_parent_class: edataserver.ClientClass,

    pub fn as(p_instance: *BookClientClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The cursor class structure.
pub const BookClientCursorClass = extern struct {
    pub const Instance = ebook.BookClientCursor;

    f_parent_class: gobject.ObjectClass,
    /// The class handler for the `ebook.BookClientCursor.signals.refresh` signal
    f_refresh: ?*const fn (p_cursor: *ebook.BookClientCursor) callconv(.c) void,

    pub fn as(p_instance: *BookClientCursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookClientCursorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookClientPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `ebook.BookClient` class.
pub const BookClientViewClass = extern struct {
    pub const Instance = ebook.BookClientView;

    f_parent_class: gobject.ObjectClass,
    /// Signal emitted when contacts are added in the view
    f_objects_added: ?*const fn (p_client_view: *ebook.BookClientView, p_objects: *const glib.SList) callconv(.c) void,
    /// Signal emitted when contacts in the view are modified
    f_objects_modified: ?*const fn (p_client_view: *ebook.BookClientView, p_objects: *const glib.SList) callconv(.c) void,
    /// Signal emitted when contacts are removed from the view
    f_objects_removed: ?*const fn (p_client_view: *ebook.BookClientView, p_uids: *const glib.SList) callconv(.c) void,
    /// Signal emitted intermittently while loading a view after calling `ebook.BookClientView.start`
    f_progress: ?*const fn (p_client_view: *ebook.BookClientView, p_percent: c_uint, p_message: [*:0]const u8) callconv(.c) void,
    /// Notification that loading a view has completed, after calling `ebook.BookClientView.start`
    f_complete: ?*const fn (p_client_view: *ebook.BookClientView, p_error: *const glib.Error) callconv(.c) void,

    pub fn as(p_instance: *BookClientViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookClientViewPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DestinationClass = extern struct {
    pub const Instance = ebook.Destination;

    f_parent_class: gobject.ObjectClass,
    f_changed: ?*const fn (p_destination: *ebook.Destination) callconv(.c) void,
    f__ebook_reserved1: ?*const fn () callconv(.c) void,
    f__ebook_reserved2: ?*const fn () callconv(.c) void,
    f__ebook_reserved3: ?*const fn () callconv(.c) void,
    f__ebook_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *DestinationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DestinationPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for the `E_BOOK_ERROR` error
pub const BookStatus = enum(c_int) {
    ok = 0,
    invalid_arg = 1,
    busy = 2,
    repository_offline = 3,
    no_such_book = 4,
    no_self_contact = 5,
    source_not_loaded = 6,
    source_already_loaded = 7,
    permission_denied = 8,
    contact_not_found = 9,
    contact_id_already_exists = 10,
    protocol_not_supported = 11,
    cancelled = 12,
    could_not_cancel = 13,
    authentication_failed = 14,
    authentication_required = 15,
    tls_not_available = 16,
    dbus_exception = 17,
    no_such_source = 18,
    offline_unavailable = 19,
    other_error = 20,
    invalid_server_version = 21,
    unsupported_authentication_method = 22,
    no_space = 23,
    not_supported = 24,
    _,

    extern fn e_book_status_get_type() usize;
    pub const getGObjectType = e_book_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn e_book_error_quark() glib.Quark;
pub const bookErrorQuark = e_book_error_quark;

/// Synchronously searches for `recipients` S/MIME or PGP certificates either
/// in provided `only_clients` `ebook.BookClient`, or, when `NULL`, in each found
/// address book configured for auto-completion.
///
/// This function can be used within `camel.Session.getRecipientCertificatesSync`
/// implementation.
extern fn e_book_utils_get_recipient_certificates_sync(p_registry: *edataserver.SourceRegistry, p_only_clients: ?*const glib.SList, p_flags: u32, p_recipients: *const glib.PtrArray, p_out_certificates: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const bookUtilsGetRecipientCertificatesSync = e_book_utils_get_recipient_certificates_sync;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
