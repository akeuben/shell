pub const ext = @import("ext.zig");
const ebookcontacts = @This();

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
/// An abstract object to handle EBookIndices changes.
pub const BookIndicesUpdater = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebookcontacts.BookIndicesUpdaterClass;
    f_parent: gobject.Object,
    f_priv: ?*ebookcontacts.BookIndicesUpdaterPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Notifies the `self` that a new contact with UID `uid` had been added
    /// to the set and it occupies the `indices_index` index in the indices.
    /// In case the `uid` had been added previously its index is modified
    /// instead.
    ///
    /// This function can be used only after initial call to `ebookcontacts.BookIndicesUpdater.takeIndices`.
    extern fn e_book_indices_updater_add(p_self: *BookIndicesUpdater, p_uid: [*:0]const u8, p_indices_index: c_uint) c_int;
    pub const add = e_book_indices_updater_add;

    /// Sets the initial indices to be updated by the `self`. If `NULL`,
    /// then unsets them.
    extern fn e_book_indices_updater_get_indices(p_self: *BookIndicesUpdater) ?*const ebookcontacts.BookIndices;
    pub const getIndices = e_book_indices_updater_get_indices;

    /// Notifies the `self` that an existing contact with UID `uid` had been removed
    /// from the set. Calling the function with `uid` unknown to the `self` does nothing
    /// and returns `FALSE`.
    ///
    /// This function can be used only after initial call to `ebookcontacts.BookIndicesUpdater.takeIndices`.
    extern fn e_book_indices_updater_remove(p_self: *BookIndicesUpdater, p_uid: [*:0]const u8) c_int;
    pub const remove = e_book_indices_updater_remove;

    /// Sets the initial indices to be updated by the `self`. If `NULL`,
    /// then unsets them. The function always discards data previously
    /// gathered about the involved contacts, regardless whether
    /// the indices changed or not.
    ///
    /// The function assumes ownership of the `indices`.
    extern fn e_book_indices_updater_take_indices(p_self: *BookIndicesUpdater, p_indices: ?*ebookcontacts.BookIndices) c_int;
    pub const takeIndices = e_book_indices_updater_take_indices;

    extern fn e_book_indices_updater_get_type() usize;
    pub const getGObjectType = e_book_indices_updater_get_type;

    extern fn g_object_ref(p_self: *ebookcontacts.BookIndicesUpdater) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebookcontacts.BookIndicesUpdater) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BookIndicesUpdater, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Contact = extern struct {
    pub const Parent = ebookcontacts.VCard;
    pub const Implements = [_]type{};
    pub const Class = ebookcontacts.ContactClass;
    f_parent: ebookcontacts.VCard,
    f_priv: ?*ebookcontacts.ContactPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const Rev = struct {
            pub const name = "Rev";

            pub const Type = ?[*:0]u8;
        };

        pub const address = struct {
            pub const name = "address";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const address_home = struct {
            pub const name = "address-home";

            pub const Type = ?*ebookcontacts.ContactAddress;
        };

        pub const address_label_home = struct {
            pub const name = "address-label-home";

            pub const Type = ?[*:0]u8;
        };

        pub const address_label_other = struct {
            pub const name = "address-label-other";

            pub const Type = ?[*:0]u8;
        };

        pub const address_label_work = struct {
            pub const name = "address-label-work";

            pub const Type = ?[*:0]u8;
        };

        pub const address_other = struct {
            pub const name = "address-other";

            pub const Type = ?*ebookcontacts.ContactAddress;
        };

        pub const address_work = struct {
            pub const name = "address-work";

            pub const Type = ?*ebookcontacts.ContactAddress;
        };

        pub const anniversary = struct {
            pub const name = "anniversary";

            pub const Type = ?*ebookcontacts.ContactDate;
        };

        pub const assistant = struct {
            pub const name = "assistant";

            pub const Type = ?[*:0]u8;
        };

        pub const assistant_phone = struct {
            pub const name = "assistant-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const birth_date = struct {
            pub const name = "birth-date";

            pub const Type = ?*ebookcontacts.ContactDate;
        };

        pub const blog_url = struct {
            pub const name = "blog-url";

            pub const Type = ?[*:0]u8;
        };

        pub const book_uid = struct {
            pub const name = "book-uid";

            pub const Type = ?[*:0]u8;
        };

        pub const business_fax = struct {
            pub const name = "business-fax";

            pub const Type = ?[*:0]u8;
        };

        pub const business_phone = struct {
            pub const name = "business-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const business_phone_2 = struct {
            pub const name = "business-phone-2";

            pub const Type = ?[*:0]u8;
        };

        pub const callback_phone = struct {
            pub const name = "callback-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const caluri = struct {
            pub const name = "caluri";

            pub const Type = ?[*:0]u8;
        };

        pub const car_phone = struct {
            pub const name = "car-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const categories = struct {
            pub const name = "categories";

            pub const Type = ?[*:0]u8;
        };

        pub const category_list = struct {
            pub const name = "category-list";

            pub const Type = ?*anyopaque;
        };

        pub const company_phone = struct {
            pub const name = "company-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const email = struct {
            pub const name = "email";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const email_1 = struct {
            pub const name = "email-1";

            pub const Type = ?[*:0]u8;
        };

        pub const email_2 = struct {
            pub const name = "email-2";

            pub const Type = ?[*:0]u8;
        };

        pub const email_3 = struct {
            pub const name = "email-3";

            pub const Type = ?[*:0]u8;
        };

        pub const email_4 = struct {
            pub const name = "email-4";

            pub const Type = ?[*:0]u8;
        };

        pub const family_name = struct {
            pub const name = "family-name";

            pub const Type = ?[*:0]u8;
        };

        pub const fburl = struct {
            pub const name = "fburl";

            pub const Type = ?[*:0]u8;
        };

        pub const file_as = struct {
            pub const name = "file-as";

            pub const Type = ?[*:0]u8;
        };

        pub const full_name = struct {
            pub const name = "full-name";

            pub const Type = ?[*:0]u8;
        };

        pub const geo = struct {
            pub const name = "geo";

            pub const Type = ?*ebookcontacts.ContactGeo;
        };

        pub const given_name = struct {
            pub const name = "given-name";

            pub const Type = ?[*:0]u8;
        };

        pub const home_fax = struct {
            pub const name = "home-fax";

            pub const Type = ?[*:0]u8;
        };

        pub const home_phone = struct {
            pub const name = "home-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const home_phone_2 = struct {
            pub const name = "home-phone-2";

            pub const Type = ?[*:0]u8;
        };

        pub const homepage_url = struct {
            pub const name = "homepage-url";

            pub const Type = ?[*:0]u8;
        };

        pub const icscalendar = struct {
            pub const name = "icscalendar";

            pub const Type = ?[*:0]u8;
        };

        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim = struct {
            pub const name = "im-aim";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_aim_home_1 = struct {
            pub const name = "im-aim-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim_home_2 = struct {
            pub const name = "im-aim-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim_home_3 = struct {
            pub const name = "im-aim-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim_work_1 = struct {
            pub const name = "im-aim-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim_work_2 = struct {
            pub const name = "im-aim-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_aim_work_3 = struct {
            pub const name = "im-aim-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu = struct {
            pub const name = "im-gadugadu";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_gadugadu_home_1 = struct {
            pub const name = "im-gadugadu-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu_home_2 = struct {
            pub const name = "im-gadugadu-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu_home_3 = struct {
            pub const name = "im-gadugadu-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu_work_1 = struct {
            pub const name = "im-gadugadu-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu_work_2 = struct {
            pub const name = "im-gadugadu-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_gadugadu_work_3 = struct {
            pub const name = "im-gadugadu-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk = struct {
            pub const name = "im-google-talk";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_google_talk_home_1 = struct {
            pub const name = "im-google-talk-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk_home_2 = struct {
            pub const name = "im-google-talk-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk_home_3 = struct {
            pub const name = "im-google-talk-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk_work_1 = struct {
            pub const name = "im-google-talk-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk_work_2 = struct {
            pub const name = "im-google-talk-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_google_talk_work_3 = struct {
            pub const name = "im-google-talk-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise = struct {
            pub const name = "im-groupwise";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_groupwise_home_1 = struct {
            pub const name = "im-groupwise-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise_home_2 = struct {
            pub const name = "im-groupwise-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise_home_3 = struct {
            pub const name = "im-groupwise-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise_work_1 = struct {
            pub const name = "im-groupwise-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise_work_2 = struct {
            pub const name = "im-groupwise-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_groupwise_work_3 = struct {
            pub const name = "im-groupwise-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq = struct {
            pub const name = "im-icq";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_icq_home_1 = struct {
            pub const name = "im-icq-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq_home_2 = struct {
            pub const name = "im-icq-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq_home_3 = struct {
            pub const name = "im-icq-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq_work_1 = struct {
            pub const name = "im-icq-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq_work_2 = struct {
            pub const name = "im-icq-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_icq_work_3 = struct {
            pub const name = "im-icq-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber = struct {
            pub const name = "im-jabber";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_jabber_home_1 = struct {
            pub const name = "im-jabber-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber_home_2 = struct {
            pub const name = "im-jabber-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber_home_3 = struct {
            pub const name = "im-jabber-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber_work_1 = struct {
            pub const name = "im-jabber-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber_work_2 = struct {
            pub const name = "im-jabber-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_jabber_work_3 = struct {
            pub const name = "im-jabber-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix = struct {
            pub const name = "im-matrix";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_matrix_home_1 = struct {
            pub const name = "im-matrix-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix_home_2 = struct {
            pub const name = "im-matrix-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix_home_3 = struct {
            pub const name = "im-matrix-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix_work_1 = struct {
            pub const name = "im-matrix-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix_work_2 = struct {
            pub const name = "im-matrix-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_matrix_work_3 = struct {
            pub const name = "im-matrix-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn = struct {
            pub const name = "im-msn";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_msn_home_1 = struct {
            pub const name = "im-msn-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn_home_2 = struct {
            pub const name = "im-msn-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn_home_3 = struct {
            pub const name = "im-msn-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn_work_1 = struct {
            pub const name = "im-msn-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn_work_2 = struct {
            pub const name = "im-msn-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_msn_work_3 = struct {
            pub const name = "im-msn-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype = struct {
            pub const name = "im-skype";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_skype_home_1 = struct {
            pub const name = "im-skype-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype_home_2 = struct {
            pub const name = "im-skype-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype_home_3 = struct {
            pub const name = "im-skype-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype_work_1 = struct {
            pub const name = "im-skype-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype_work_2 = struct {
            pub const name = "im-skype-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_skype_work_3 = struct {
            pub const name = "im-skype-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_twitter = struct {
            pub const name = "im-twitter";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_yahoo = struct {
            pub const name = "im-yahoo";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const im_yahoo_home_1 = struct {
            pub const name = "im-yahoo-home-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_yahoo_home_2 = struct {
            pub const name = "im-yahoo-home-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_yahoo_home_3 = struct {
            pub const name = "im-yahoo-home-3";

            pub const Type = ?[*:0]u8;
        };

        pub const im_yahoo_work_1 = struct {
            pub const name = "im-yahoo-work-1";

            pub const Type = ?[*:0]u8;
        };

        pub const im_yahoo_work_2 = struct {
            pub const name = "im-yahoo-work-2";

            pub const Type = ?[*:0]u8;
        };

        pub const im_yahoo_work_3 = struct {
            pub const name = "im-yahoo-work-3";

            pub const Type = ?[*:0]u8;
        };

        pub const isdn_phone = struct {
            pub const name = "isdn-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const list = struct {
            pub const name = "list";

            pub const Type = c_int;
        };

        pub const list_show_addresses = struct {
            pub const name = "list-show-addresses";

            pub const Type = c_int;
        };

        pub const logo = struct {
            pub const name = "logo";

            pub const Type = ?*ebookcontacts.ContactPhoto;
        };

        pub const mailer = struct {
            pub const name = "mailer";

            pub const Type = ?[*:0]u8;
        };

        pub const manager = struct {
            pub const name = "manager";

            pub const Type = ?[*:0]u8;
        };

        pub const mobile_phone = struct {
            pub const name = "mobile-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?*ebookcontacts.ContactName;
        };

        pub const name_or_org = struct {
            pub const name = "name-or-org";

            pub const Type = ?[*:0]u8;
        };

        pub const nickname = struct {
            pub const name = "nickname";

            pub const Type = ?[*:0]u8;
        };

        pub const note = struct {
            pub const name = "note";

            pub const Type = ?[*:0]u8;
        };

        pub const office = struct {
            pub const name = "office";

            pub const Type = ?[*:0]u8;
        };

        pub const org = struct {
            pub const name = "org";

            pub const Type = ?[*:0]u8;
        };

        pub const org_unit = struct {
            pub const name = "org-unit";

            pub const Type = ?[*:0]u8;
        };

        pub const other_fax = struct {
            pub const name = "other-fax";

            pub const Type = ?[*:0]u8;
        };

        pub const other_phone = struct {
            pub const name = "other-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const pager = struct {
            pub const name = "pager";

            pub const Type = ?[*:0]u8;
        };

        pub const pgpCert = struct {
            pub const name = "pgpCert";

            pub const Type = ?*ebookcontacts.ContactCert;
        };

        pub const phone = struct {
            pub const name = "phone";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const photo = struct {
            pub const name = "photo";

            pub const Type = ?*ebookcontacts.ContactPhoto;
        };

        pub const primary_phone = struct {
            pub const name = "primary-phone";

            pub const Type = ?[*:0]u8;
        };

        pub const radio = struct {
            pub const name = "radio";

            pub const Type = ?[*:0]u8;
        };

        pub const role = struct {
            pub const name = "role";

            pub const Type = ?[*:0]u8;
        };

        pub const sip = struct {
            pub const name = "sip";

            pub const Type = ebookcontacts.ContactAttrList;
        };

        pub const spouse = struct {
            pub const name = "spouse";

            pub const Type = ?[*:0]u8;
        };

        pub const telex = struct {
            pub const name = "telex";

            pub const Type = ?[*:0]u8;
        };

        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        pub const tty = struct {
            pub const name = "tty";

            pub const Type = ?[*:0]u8;
        };

        pub const video_url = struct {
            pub const name = "video-url";

            pub const Type = ?[*:0]u8;
        };

        pub const wants_html = struct {
            pub const name = "wants-html";

            pub const Type = c_int;
        };

        pub const x509Cert = struct {
            pub const name = "x509Cert";

            pub const Type = ?*ebookcontacts.ContactCert;
        };
    };

    pub const signals = struct {};

    /// Gets the `ebookcontacts.ContactField` corresponding to the `field_name`.
    extern fn e_contact_field_id(p_field_name: [*:0]const u8) ebookcontacts.ContactField;
    pub const fieldId = e_contact_field_id;

    /// Gets the `ebookcontacts.ContactField` corresponding to the `vcard_field`.
    extern fn e_contact_field_id_from_vcard(p_vcard_field: [*:0]const u8) ebookcontacts.ContactField;
    pub const fieldIdFromVcard = e_contact_field_id_from_vcard;

    /// Returns whether the `field_id` is of a string type,
    /// thus it can be used with `ebookcontacts.Contact.getConst`.
    extern fn e_contact_field_is_string(p_field_id: ebookcontacts.ContactField) c_int;
    pub const fieldIsString = e_contact_field_is_string;

    /// Gets the string representation of `field_id`.
    extern fn e_contact_field_name(p_field_id: ebookcontacts.ContactField) [*:0]const u8;
    pub const fieldName = e_contact_field_name;

    /// Gets the `gobject.Type` used for this contact field, this indicates
    /// what kind of value can be passed to `ebookcontacts.Contact.set`.
    extern fn e_contact_field_type(p_field_id: ebookcontacts.ContactField) usize;
    pub const fieldType = e_contact_field_type;

    /// Gets a human-readable, translated string representation
    /// of `field_id`.
    extern fn e_contact_pretty_name(p_field_id: ebookcontacts.ContactField) [*:0]const u8;
    pub const prettyName = e_contact_pretty_name;

    /// Gets the vcard attribute corresponding to `field_id`, as a string.
    extern fn e_contact_vcard_attribute(p_field_id: ebookcontacts.ContactField) [*:0]const u8;
    pub const vcardAttribute = e_contact_vcard_attribute;

    /// Creates a new, blank `ebookcontacts.Contact`.
    extern fn e_contact_new() *ebookcontacts.Contact;
    pub const new = e_contact_new;

    /// Creates a new `ebookcontacts.Contact` based on a vcard.
    extern fn e_contact_new_from_vcard(p_vcard: [*:0]const u8) *ebookcontacts.Contact;
    pub const newFromVcard = e_contact_new_from_vcard;

    /// Creates a new `ebookcontacts.Contact` based on a vcard and a predefined UID.
    extern fn e_contact_new_from_vcard_with_uid(p_vcard: [*:0]const u8, p_uid: [*:0]const u8) *ebookcontacts.Contact;
    pub const newFromVcardWithUid = e_contact_new_from_vcard_with_uid;

    /// Creates a copy of `contact`.
    extern fn e_contact_duplicate(p_contact: *Contact) *ebookcontacts.Contact;
    pub const duplicate = e_contact_duplicate;

    /// Gets the value of `contact`'s field specified by `field_id`.
    extern fn e_contact_get(p_contact: *Contact, p_field_id: ebookcontacts.ContactField) ?*anyopaque;
    pub const get = e_contact_get;

    /// Gets a list of the vcard attributes for `contact`'s `field_id`.
    extern fn e_contact_get_attributes(p_contact: *Contact, p_field_id: ebookcontacts.ContactField) *glib.List;
    pub const getAttributes = e_contact_get_attributes;

    /// Gets a list of the vcard attributes for `contact`'s `field_ids`.
    extern fn e_contact_get_attributes_set(p_contact: *Contact, p_field_ids: [*]const ebookcontacts.ContactField, p_size: c_int) *glib.List;
    pub const getAttributesSet = e_contact_get_attributes_set;

    /// Gets the value of `contact`'s field specified by `field_id`, caching
    /// the result so it can be freed later. Use `ebookcontacts.Contact.fieldIsString`
    /// to check whether the field can be used here.
    extern fn e_contact_get_const(p_contact: *Contact, p_field_id: ebookcontacts.ContactField) ?*const anyopaque;
    pub const getConst = e_contact_get_const;

    /// Tries to modify any `ebookcontacts.ContactPhoto` fields which are
    /// stored on the local file system as type `E_CONTACT_PHOTO_TYPE_URI`
    /// to be inlined and stored as `E_CONTACT_PHOTO_TYPE_INLINED` instead.
    extern fn e_contact_inline_local_photos(p_contact: *Contact, p_error: ?*?*glib.Error) c_int;
    pub const inlineLocalPhotos = e_contact_inline_local_photos;

    /// Sets the value of `contact`'s field specified by `field_id` to `value`.
    extern fn e_contact_set(p_contact: *Contact, p_field_id: ebookcontacts.ContactField, p_value: ?*const anyopaque) void;
    pub const set = e_contact_set;

    /// Sets the vcard attributes for `contact`'s `field_id`.
    /// Attributes are added to the contact in the same order as they are in `attributes`.
    extern fn e_contact_set_attributes(p_contact: *Contact, p_field_id: ebookcontacts.ContactField, p_attributes: *glib.List) void;
    pub const setAttributes = e_contact_set_attributes;

    extern fn e_contact_get_type() usize;
    pub const getGObjectType = e_contact_get_type;

    extern fn g_object_ref(p_self: *ebookcontacts.Contact) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebookcontacts.Contact) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Contact, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceBackendSummarySetup = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = ebookcontacts.SourceBackendSummarySetupClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*ebookcontacts.SourceBackendSummarySetupPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const indexed_fields = struct {
            pub const name = "indexed-fields";

            pub const Type = ?[*:0]u8;
        };

        pub const summary_fields = struct {
            pub const name = "summary-fields";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Fetches the `EContactFields` configured to be indexed, with thier respective `EBookIndexTypes`.
    extern fn e_source_backend_summary_setup_get_indexed_fields(p_extension: *SourceBackendSummarySetup, p_types: **ebookcontacts.BookIndexType, p_n_fields: *c_int) *ebookcontacts.ContactField;
    pub const getIndexedFields = e_source_backend_summary_setup_get_indexed_fields;

    /// Fetches the `EContactFields` which are configured to be a part of the summary.
    ///
    /// <note><para>If there are no configured summary fields, the default configuration is assumed</para></note>
    extern fn e_source_backend_summary_setup_get_summary_fields(p_extension: *SourceBackendSummarySetup, p_n_fields: *c_int) *ebookcontacts.ContactField;
    pub const getSummaryFields = e_source_backend_summary_setup_get_summary_fields;

    /// Like `ebookcontacts.SourceBackendSummarySetup.setIndexedFieldsv`, but takes a literal list of
    /// of indexes.
    ///
    /// To give the 'fullname' field an index for prefix and suffix searches:
    ///
    /// ```
    ///   `include` <libebook/libebook.h>
    ///
    ///   ESourceBackendSummarySetup *extension;
    ///
    ///   extension = e_source_get_extension (source, E_SOURCE_EXTENSION_BACKEND_SUMMARY_SETUP);
    ///
    ///   e_source_backend_summary_setup_set_indexed_fields (extension,
    ///                                                      E_CONTACT_FULL_NAME, E_BOOK_INDEX_PREFIX,
    ///                                                      E_CONTACT_FULL_NAME, E_BOOK_INDEX_SUFFIX,
    ///                                                      0);
    /// ```
    extern fn e_source_backend_summary_setup_set_indexed_fields(p_extension: *SourceBackendSummarySetup, ...) void;
    pub const setIndexedFields = e_source_backend_summary_setup_set_indexed_fields;

    /// Defines indexes for quick reference for the given given `EContactFields` in the addressbook.
    ///
    /// The same `ebookcontacts.ContactField` may be specified multiple times to create multiple indexes
    /// with different characteristics. If an `E_BOOK_INDEX_PREFIX` index is created it will
    /// be used for `E_BOOK_QUERY_BEGINS_WITH` queries. An `E_BOOK_INDEX_SUFFIX` index
    /// will be constructed efficiently for suffix matching and will be used for
    /// `E_BOOK_QUERY_ENDS_WITH` queries. Similar an `E_BOOK_INDEX_PHONE` index will optimize
    /// `E_BOOK_QUERY_EQUALS_PHONE_NUMBER` searches.
    ///
    /// <note><para>The specified indexed fields must also be a part of the summary, any indexed fields
    /// specified that are not already a part of the summary will be ignored.</para></note>
    extern fn e_source_backend_summary_setup_set_indexed_fieldsv(p_extension: *SourceBackendSummarySetup, p_fields: *ebookcontacts.ContactField, p_types: *ebookcontacts.BookIndexType, p_n_fields: c_int) void;
    pub const setIndexedFieldsv = e_source_backend_summary_setup_set_indexed_fieldsv;

    /// Like `ebookcontacts.SourceBackendSummarySetup.setSummaryFieldsv`, but takes a literal
    /// list of `EContactFields` for convenience.
    ///
    /// To configure the address book summary fields with main phone nubmer fields:
    ///
    /// ```
    ///   `include` <libebook/libebook.h>
    ///
    ///   ESourceBackendSummarySetup *extension;
    ///
    ///   extension = e_source_get_extension (source, E_SOURCE_EXTENSION_BACKEND_SUMMARY_SETUP);
    ///
    ///   e_source_backend_summary_setup_set_summary_fields (extension, E_CONTACT_FULL_NAME, E_CONTACT_EMAIL, 0);
    /// ```
    extern fn e_source_backend_summary_setup_set_summary_fields(p_extension: *SourceBackendSummarySetup, ...) void;
    pub const setSummaryFields = e_source_backend_summary_setup_set_summary_fields;

    /// Sets the summary fields configured for the given addressbook.
    ///
    /// The fields `E_CONTACT_UID` and `E_CONTACT_REV` are not optional,
    /// they will be stored in the summary regardless of the configured summary.
    ///
    /// An empty summary configuration is assumed to be the default summary
    /// configuration.
    ///
    /// <note><para>Only `EContactFields` with the type `G_TYPE_STRING` or `G_TYPE_BOOLEAN`
    /// are currently supported as summary fields.</para></note>
    extern fn e_source_backend_summary_setup_set_summary_fieldsv(p_extension: *SourceBackendSummarySetup, p_fields: *ebookcontacts.ContactField, p_n_fields: c_int) void;
    pub const setSummaryFieldsv = e_source_backend_summary_setup_set_summary_fieldsv;

    extern fn e_source_backend_summary_setup_get_type() usize;
    pub const getGObjectType = e_source_backend_summary_setup_get_type;

    extern fn g_object_ref(p_self: *ebookcontacts.SourceBackendSummarySetup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebookcontacts.SourceBackendSummarySetup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceBackendSummarySetup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCard = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebookcontacts.VCardClass;
    f_parent: gobject.Object,
    f_priv: ?*ebookcontacts.VCardPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Escapes a string according to RFC2426, section 5.
    extern fn e_vcard_escape_string(p_s: [*:0]const u8) [*:0]u8;
    pub const escapeString = e_vcard_escape_string;

    /// Unescapes a string according to RFC2426, section 5.
    extern fn e_vcard_unescape_string(p_s: [*:0]const u8) [*:0]u8;
    pub const unescapeString = e_vcard_unescape_string;

    /// Creates a new, blank `ebookcontacts.VCard`.
    extern fn e_vcard_new() *ebookcontacts.VCard;
    pub const new = e_vcard_new;

    /// Creates a new `ebookcontacts.VCard` from the passed-in string
    /// representation.
    extern fn e_vcard_new_from_string(p_str: [*:0]const u8) *ebookcontacts.VCard;
    pub const newFromString = e_vcard_new_from_string;

    /// Prepends `attr` to `evc`. This takes ownership of `attr`.
    extern fn e_vcard_add_attribute(p_evc: *VCard, p_attr: *ebookcontacts.VCardAttribute) void;
    pub const addAttribute = e_vcard_add_attribute;

    /// Prepends `attr` to `evcard`, setting it to `value`. This takes ownership of
    /// `attr`.
    ///
    /// This is a convenience wrapper around `ebookcontacts.VCardAttribute.addValue` and
    /// `ebookcontacts.VCard.addAttribute`.
    extern fn e_vcard_add_attribute_with_value(p_evcard: *VCard, p_attr: *ebookcontacts.VCardAttribute, p_value: [*:0]const u8) void;
    pub const addAttributeWithValue = e_vcard_add_attribute_with_value;

    /// Prepends `attr` to `evcard`, assigning the list of values to it. This takes
    /// ownership of `attr`.
    ///
    /// This is a convenience wrapper around `ebookcontacts.VCardAttribute.addValue` and
    /// `ebookcontacts.VCard.addAttribute`.
    extern fn e_vcard_add_attribute_with_values(p_evcard: *VCard, p_attr: *ebookcontacts.VCardAttribute, ...) void;
    pub const addAttributeWithValues = e_vcard_add_attribute_with_values;

    /// Appends `attr` to `evc` to the end of a list of attributes. This takes
    /// ownership of `attr`.
    extern fn e_vcard_append_attribute(p_evc: *VCard, p_attr: *ebookcontacts.VCardAttribute) void;
    pub const appendAttribute = e_vcard_append_attribute;

    /// Appends `attr` to `evcard`, setting it to `value`. This takes ownership of
    /// `attr`.
    ///
    /// This is a convenience wrapper around `ebookcontacts.VCardAttribute.addValue` and
    /// `ebookcontacts.VCard.appendAttribute`.
    extern fn e_vcard_append_attribute_with_value(p_evcard: *VCard, p_attr: *ebookcontacts.VCardAttribute, p_value: [*:0]const u8) void;
    pub const appendAttributeWithValue = e_vcard_append_attribute_with_value;

    /// Appends `attr` to `evcard`, assigning the list of values to it. This takes
    /// ownership of `attr`.
    ///
    /// This is a convenience wrapper around `ebookcontacts.VCardAttribute.addValue` and
    /// `ebookcontacts.VCard.appendAttribute`.
    extern fn e_vcard_append_attribute_with_values(p_evcard: *VCard, p_attr: *ebookcontacts.VCardAttribute, ...) void;
    pub const appendAttributeWithValues = e_vcard_append_attribute_with_values;

    /// Constructs the existing `ebookcontacts.VCard`, `evc`, setting its vCard data to `str`.
    ///
    /// This modifies `evc`.
    extern fn e_vcard_construct(p_evc: *VCard, p_str: [*:0]const u8) void;
    pub const construct = e_vcard_construct;

    /// Similar to `ebookcontacts.VCard.constructWithUid`, but can also
    /// be used with an `str` that is not `NULL` terminated.
    extern fn e_vcard_construct_full(p_evc: *VCard, p_str: [*:0]const u8, p_len: isize, p_uid: ?[*:0]const u8) void;
    pub const constructFull = e_vcard_construct_full;

    /// Constructs the existing `ebookcontacts.VCard`, `evc`, setting its vCard data to `str`, and
    /// adding a new UID attribute with the value given in `uid` (if `uid` is
    /// non-`NULL`).
    ///
    /// This modifies `evc`.
    extern fn e_vcard_construct_with_uid(p_evc: *VCard, p_str: [*:0]const u8, p_uid: ?[*:0]const u8) void;
    pub const constructWithUid = e_vcard_construct_with_uid;

    /// Prints a dump of `evc`'s structure to stdout. Used for
    /// debugging.
    extern fn e_vcard_dump_structure(p_evc: *VCard) void;
    pub const dumpStructure = e_vcard_dump_structure;

    /// Get the attribute `name` from `evc`.  The `ebookcontacts.VCardAttribute` is owned by
    /// `evcard` and should not be freed. If the attribute does not exist, `NULL` is
    /// returned.
    ///
    /// <note><para>This will only return the <emphasis>first</emphasis> attribute
    /// with the given `name`. To get other attributes of that name (for example,
    /// other <code>TEL</code> attributes if a contact has multiple telephone
    /// numbers), use `ebookcontacts.VCard.getAttributes` and iterate over the list searching
    /// for matching attributes.</para>
    /// <para>This method iterates over all attributes in the `ebookcontacts.VCard`, so should not
    /// be called often. If extracting a large number of attributes from a vCard, it
    /// is more efficient to iterate once over the list returned by
    /// `ebookcontacts.VCard.getAttributes`.</para></note>
    extern fn e_vcard_get_attribute(p_evc: *VCard, p_name: [*:0]const u8) ?*ebookcontacts.VCardAttribute;
    pub const getAttribute = e_vcard_get_attribute;

    /// Similar to `ebookcontacts.VCard.getAttribute` but this method will not attempt to
    /// parse the vCard if it is not already parsed.
    extern fn e_vcard_get_attribute_if_parsed(p_evc: *VCard, p_name: [*:0]const u8) ?*ebookcontacts.VCardAttribute;
    pub const getAttributeIfParsed = e_vcard_get_attribute_if_parsed;

    /// Gets the list of all attributes from `evcard`. The list and its
    /// contents are owned by `evcard`, and must not be freed.
    extern fn e_vcard_get_attributes(p_evcard: *VCard) *glib.List;
    pub const getAttributes = e_vcard_get_attributes;

    /// Check if the `evc` has been parsed already, as `ebookcontacts.VCard` implements lazy parsing
    /// of its vCard data. Used for debugging.
    extern fn e_vcard_is_parsed(p_evc: *VCard) c_int;
    pub const isParsed = e_vcard_is_parsed;

    /// Removes `attr` from `evc` and frees it. This takes ownership of `attr`.
    extern fn e_vcard_remove_attribute(p_evc: *VCard, p_attr: *ebookcontacts.VCardAttribute) void;
    pub const removeAttribute = e_vcard_remove_attribute;

    /// Removes all the attributes with group name and attribute name equal to the
    /// passed in values. If `attr_group` is `NULL` or an empty string,
    /// it removes all the attributes with passed in name irrespective of
    /// their group names.
    extern fn e_vcard_remove_attributes(p_evc: *VCard, p_attr_group: ?[*:0]const u8, p_attr_name: [*:0]const u8) void;
    pub const removeAttributes = e_vcard_remove_attributes;

    /// Exports `evc` to a string representation, specified
    /// by the `format` argument.
    extern fn e_vcard_to_string(p_evc: *VCard, p_format: ebookcontacts.VCardFormat) [*:0]u8;
    pub const toString = e_vcard_to_string;

    extern fn e_vcard_util_dup_x_attribute(p_vcard: *VCard, p_x_name: [*:0]const u8) ?[*:0]u8;
    pub const utilDupXAttribute = e_vcard_util_dup_x_attribute;

    /// Sets an "X-" attribute `x_name` to value `value` in `vcard`, or
    /// removes it from `vcard`, when `value` is `NULL`.
    extern fn e_vcard_util_set_x_attribute(p_vcard: *VCard, p_x_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const utilSetXAttribute = e_vcard_util_set_x_attribute;

    extern fn e_vcard_get_type() usize;
    pub const getGObjectType = e_vcard_get_type;

    extern fn g_object_ref(p_self: *ebookcontacts.VCard) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebookcontacts.VCard) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VCard, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Western address structure.
pub const AddressWestern = extern struct {
    /// PO Box.
    f_po_box: ?[*:0]u8,
    /// TODO, we're not sure what this is.
    f_extended: ?[*:0]u8,
    /// Street name
    f_street: ?[*:0]u8,
    /// City or town
    f_locality: ?[*:0]u8,
    /// State or province
    f_region: ?[*:0]u8,
    /// Postal Code
    f_postal_code: ?[*:0]u8,
    /// Country
    f_country: ?[*:0]u8,

    /// Parses a string representing a mailing address into a
    /// structure of type `ebookcontacts.AddressWestern`.
    extern fn e_address_western_parse(p_in_address: ?[*:0]const u8) ?*ebookcontacts.AddressWestern;
    pub const parse = e_address_western_parse;

    /// Creates a copy of `eaw`.
    extern fn e_address_western_copy(p_eaw: *AddressWestern) *ebookcontacts.AddressWestern;
    pub const copy = e_address_western_copy;

    /// Frees `eaw` and its contents.
    extern fn e_address_western_free(p_eaw: *AddressWestern) void;
    pub const free = e_address_western_free;

    extern fn e_address_western_get_type() usize;
    pub const getGObjectType = e_address_western_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is a part of the deprecated `EBook` API.
pub const BookChange = extern struct {
    /// The `ebookcontacts.BookChangeType`
    f_change_type: ebookcontacts.BookChangeType,
    /// The `ebookcontacts.Contact` which changed
    f_contact: ?*ebookcontacts.Contact,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is a structure describing sort settings in the view.
/// See `e_book_client_view_set_sort_fields_sync` for more information.
pub const BookClientViewSortFields = extern struct {
    /// an `ebookcontacts.ContactField` to sort by
    f_field: ebookcontacts.ContactField,
    /// an `ebookcontacts.BookCursorSortType`
    f_sort_type: ebookcontacts.BookCursorSortType,

    /// Creates a copy of the `src`. If the `src` is `NULL`, the `NULL` is returned.
    /// Both the `src` and the returned array is terminated by an item, which has
    /// the field member set to `E_CONTACT_FIELD_LAST`.
    ///
    /// Free the returned array with `ebookcontacts.BookClientViewSortFields.free`,
    /// when no longer needed.
    extern fn e_book_client_view_sort_fields_copy(p_src: ?*const BookClientViewSortFields) *ebookcontacts.BookClientViewSortFields;
    pub const copy = e_book_client_view_sort_fields_copy;

    /// Frees the `fields` array with each member. The array should be terminated
    /// by an item with field member set to `E_CONTACT_FIELD_LAST`.
    extern fn e_book_client_view_sort_fields_free(p_fields: ?*BookClientViewSortFields) void;
    pub const free = e_book_client_view_sort_fields_free;

    extern fn e_book_client_view_sort_fields_get_type() usize;
    pub const getGObjectType = e_book_client_view_sort_fields_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is a structure describing indices of the contacts in the view.
/// See `e_book_client_view_dup_indices` for more information.
pub const BookIndices = extern struct {
    /// a character for the index
    f_chr: ?[*:0]u8,
    /// 0-based index of the first contact with this character
    f_index: c_uint,

    /// Returns whether the `self` considers contacts stored in the ascending order.
    extern fn e_book_indices_get_ascending_sort(p_self: *ebookcontacts.BookIndicesUpdater) c_int;
    pub const getAscendingSort = e_book_indices_get_ascending_sort;

    /// Sets whether the contacts are sorted in an ascending order; if not,
    /// then they are sorted in the descending order. That influences what
    /// indexes the indices have set.
    extern fn e_book_indices_set_ascending_sort(p_self: *ebookcontacts.BookIndicesUpdater, p_ascending_sort: c_int) void;
    pub const setAscendingSort = e_book_indices_set_ascending_sort;

    /// Creates a copy of the `src`. If the `src` is `NULL`, the `NULL` is returned.
    /// Both the `src` and the returned array is terminated by an item, which has
    /// the chr member set to `NULL`.
    ///
    /// Free the returned array with `ebookcontacts.BookIndices.free`,
    /// when no longer needed.
    extern fn e_book_indices_copy(p_src: ?*const BookIndices) *ebookcontacts.BookIndices;
    pub const copy = e_book_indices_copy;

    /// Frees the `indices` array with each member. The array should be terminated
    /// by an item with chr member set to `NULL`.
    extern fn e_book_indices_free(p_indices: ?*BookIndices) void;
    pub const free = e_book_indices_free;

    extern fn e_book_indices_get_type() usize;
    pub const getGObjectType = e_book_indices_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookIndicesUpdaterClass = extern struct {
    pub const Instance = ebookcontacts.BookIndicesUpdater;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *BookIndicesUpdaterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookIndicesUpdaterPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BookQuery = opaque {
    /// Create a new `ebookcontacts.BookQuery` which is the logical AND of the queries in `qs`.
    extern fn e_book_query_and(p_nqs: c_int, p_qs: **ebookcontacts.BookQuery, p_unref: c_int) *ebookcontacts.BookQuery;
    pub const @"and" = e_book_query_and;

    /// Creates a new `ebookcontacts.BookQuery` which tests if any field contains `value`.
    extern fn e_book_query_any_field_contains(p_value: [*:0]const u8) *ebookcontacts.BookQuery;
    pub const anyFieldContains = e_book_query_any_field_contains;

    /// Creates a new `ebookcontacts.BookQuery` which tests if the field `field` exists.
    extern fn e_book_query_field_exists(p_field: ebookcontacts.ContactField) *ebookcontacts.BookQuery;
    pub const fieldExists = e_book_query_field_exists;

    /// Creates a new `ebookcontacts.BookQuery` which tests `field` for `value` using the test `test`.
    extern fn e_book_query_field_test(p_field: ebookcontacts.ContactField, p_test: ebookcontacts.BookQueryTest, p_value: [*:0]const u8) *ebookcontacts.BookQuery;
    pub const fieldTest = e_book_query_field_test;

    /// Parse `query_string` and return a new `ebookcontacts.BookQuery` representing it.
    extern fn e_book_query_from_string(p_query_string: [*:0]const u8) *ebookcontacts.BookQuery;
    pub const fromString = e_book_query_from_string;

    /// Creates a new `ebookcontacts.BookQuery` which is the logical OR of the queries in `qs`.
    extern fn e_book_query_or(p_nqs: c_int, p_qs: **ebookcontacts.BookQuery, p_unref: c_int) *ebookcontacts.BookQuery;
    pub const @"or" = e_book_query_or;

    /// Creates a new `ebookcontacts.BookQuery` which tests if the field `field` exists. `field`
    /// should be a vCard field name, such as `EVC_FN` or `EVC_X_MSN`.
    extern fn e_book_query_vcard_field_exists(p_field: [*:0]const u8) *ebookcontacts.BookQuery;
    pub const vcardFieldExists = e_book_query_vcard_field_exists;

    /// Creates a new `ebookcontacts.BookQuery` which tests `field` for `value` using the test `test`.
    extern fn e_book_query_vcard_field_test(p_field: [*:0]const u8, p_test: ebookcontacts.BookQueryTest, p_value: [*:0]const u8) *ebookcontacts.BookQuery;
    pub const vcardFieldTest = e_book_query_vcard_field_test;

    /// Creates a new `ebookcontacts.BookQuery` which is the logical AND of the queries specified.
    /// The new `ebookcontacts.BookQuery` takes ownership of the specified queries.
    extern fn e_book_query_andv(p_q: *BookQuery, ...) *ebookcontacts.BookQuery;
    pub const andv = e_book_query_andv;

    /// Creates a copy of `q`.
    extern fn e_book_query_copy(p_q: *BookQuery) *ebookcontacts.BookQuery;
    pub const copy = e_book_query_copy;

    /// Creates a new `ebookcontacts.BookQuery` which is the opposite of `q`.
    extern fn e_book_query_not(p_q: *BookQuery, p_unref: c_int) *ebookcontacts.BookQuery;
    pub const not = e_book_query_not;

    /// Creates a new `ebookcontacts.BookQuery` which is the logical OR of the queries specified.
    /// The new `ebookcontacts.BookQuery` takes ownership of the specified queries.
    extern fn e_book_query_orv(p_q: *BookQuery, ...) *ebookcontacts.BookQuery;
    pub const orv = e_book_query_orv;

    /// Increment the reference count on `q`.
    extern fn e_book_query_ref(p_q: *BookQuery) *ebookcontacts.BookQuery;
    pub const ref = e_book_query_ref;

    /// Return the string representation of `q`.
    extern fn e_book_query_to_string(p_q: *BookQuery) [*:0]u8;
    pub const toString = e_book_query_to_string;

    /// Decrement the reference count on `q`. When the reference count reaches 0, `q`
    /// will be freed and any child queries will have `ebookcontacts.BookQuery.unref` called.
    extern fn e_book_query_unref(p_q: *BookQuery) void;
    pub const unref = e_book_query_unref;

    extern fn e_book_query_get_type() usize;
    pub const getGObjectType = e_book_query_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactAddress = extern struct {
    f_address_format: ?[*:0]u8,
    f_po: ?[*:0]u8,
    f_ext: ?[*:0]u8,
    f_street: ?[*:0]u8,
    f_locality: ?[*:0]u8,
    f_region: ?[*:0]u8,
    f_code: ?[*:0]u8,
    f_country: ?[*:0]u8,

    /// Creates a new `ebookcontacts.ContactAddress` struct.
    extern fn e_contact_address_new() *ebookcontacts.ContactAddress;
    pub const new = e_contact_address_new;

    /// Frees the `address` struct and its contents.
    extern fn e_contact_address_free(p_address: *ContactAddress) void;
    pub const free = e_contact_address_free;

    extern fn e_contact_address_get_type() usize;
    pub const getGObjectType = e_contact_address_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactCert = extern struct {
    f_length: usize,
    f_data: ?[*:0]u8,

    /// Creates an `ebookcontacts.ContactCert` struct with all values set to 0.
    extern fn e_contact_cert_new() *ebookcontacts.ContactCert;
    pub const new = e_contact_cert_new;

    /// Frees the `cert` struct and its contents.
    extern fn e_contact_cert_free(p_cert: *ContactCert) void;
    pub const free = e_contact_cert_free;

    extern fn e_contact_cert_get_type() usize;
    pub const getGObjectType = e_contact_cert_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactClass = extern struct {
    pub const Instance = ebookcontacts.Contact;

    f_parent_class: ebookcontacts.VCardClass,
    f__ebook_reserved0: ?*const fn () callconv(.c) void,
    f__ebook_reserved1: ?*const fn () callconv(.c) void,
    f__ebook_reserved2: ?*const fn () callconv(.c) void,
    f__ebook_reserved3: ?*const fn () callconv(.c) void,
    f__ebook_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ContactClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactDate = extern struct {
    f_year: c_uint,
    f_month: c_uint,
    f_day: c_uint,

    /// Creates a new `ebookcontacts.ContactDate` based on `str`.
    extern fn e_contact_date_from_string(p_str: [*:0]const u8) *ebookcontacts.ContactDate;
    pub const fromString = e_contact_date_from_string;

    /// Creates a new `ebookcontacts.ContactDate` struct.
    extern fn e_contact_date_new() *ebookcontacts.ContactDate;
    pub const new = e_contact_date_new;

    /// Checks if `dt1` and `dt2` are the same date.
    extern fn e_contact_date_equal(p_dt1: *ContactDate, p_dt2: *ebookcontacts.ContactDate) c_int;
    pub const equal = e_contact_date_equal;

    /// Frees the `date` struct and its contents.
    extern fn e_contact_date_free(p_date: *ContactDate) void;
    pub const free = e_contact_date_free;

    /// Generates a date string in the format YYYY-MM-DD based
    /// on the values of `dt`.
    extern fn e_contact_date_to_string(p_dt: *ContactDate) [*:0]u8;
    pub const toString = e_contact_date_to_string;

    extern fn e_contact_date_get_type() usize;
    pub const getGObjectType = e_contact_date_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactGeo = extern struct {
    /// latitude
    f_latitude: f64,
    /// longitude
    f_longitude: f64,

    /// Creates an `ebookcontacts.ContactGeo` struct with all coordinates set to 0.
    extern fn e_contact_geo_new() *ebookcontacts.ContactGeo;
    pub const new = e_contact_geo_new;

    /// Frees the `geo` struct and its contents.
    extern fn e_contact_geo_free(p_geo: *ContactGeo) void;
    pub const free = e_contact_geo_free;

    extern fn e_contact_geo_get_type() usize;
    pub const getGObjectType = e_contact_geo_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactName = extern struct {
    f_family: ?[*:0]u8,
    f_given: ?[*:0]u8,
    f_additional: ?[*:0]u8,
    f_prefixes: ?[*:0]u8,
    f_suffixes: ?[*:0]u8,

    /// Creates a new `ebookcontacts.ContactName` based on the parsed `name_str`.
    extern fn e_contact_name_from_string(p_name_str: [*:0]const u8) *ebookcontacts.ContactName;
    pub const fromString = e_contact_name_from_string;

    /// Creates a new `ebookcontacts.ContactName` struct.
    extern fn e_contact_name_new() *ebookcontacts.ContactName;
    pub const new = e_contact_name_new;

    /// Creates a copy of `n`.
    extern fn e_contact_name_copy(p_n: *ContactName) *ebookcontacts.ContactName;
    pub const copy = e_contact_name_copy;

    /// Frees `name` and its contents.
    extern fn e_contact_name_free(p_name: *ContactName) void;
    pub const free = e_contact_name_free;

    /// Generates a string representation of `name`.
    extern fn e_contact_name_to_string(p_name: *const ContactName) [*:0]u8;
    pub const toString = e_contact_name_to_string;

    extern fn e_contact_name_get_type() usize;
    pub const getGObjectType = e_contact_name_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactPhoto = extern struct {
    f_type: ebookcontacts.ContactPhotoType,
    anon0: extern union {
        anon0: extern struct {
            f_mime_type: ?[*:0]u8,
            f_length: usize,
            f_data: ?*u8,
        },
        f_uri: ?[*:0]u8,
    },

    /// Creates a new `ebookcontacts.ContactPhoto` struct.
    extern fn e_contact_photo_new() *ebookcontacts.ContactPhoto;
    pub const new = e_contact_photo_new;

    /// Creates a copy of `photo`.
    extern fn e_contact_photo_copy(p_photo: *ContactPhoto) *ebookcontacts.ContactPhoto;
    pub const copy = e_contact_photo_copy;

    /// Frees the `photo` struct and its contents.
    extern fn e_contact_photo_free(p_photo: *ContactPhoto) void;
    pub const free = e_contact_photo_free;

    /// Gets the `photo`'s data.
    extern fn e_contact_photo_get_inlined(p_photo: *ContactPhoto, p_len: *usize) ?[*]const u8;
    pub const getInlined = e_contact_photo_get_inlined;

    /// Gets the `photo`'s mime type.
    extern fn e_contact_photo_get_mime_type(p_photo: *ContactPhoto) ?[*:0]const u8;
    pub const getMimeType = e_contact_photo_get_mime_type;

    /// Gets the `photo`'s URI.
    extern fn e_contact_photo_get_uri(p_photo: *ContactPhoto) ?[*:0]const u8;
    pub const getUri = e_contact_photo_get_uri;

    /// Sets the `photo`'s inlined data.
    extern fn e_contact_photo_set_inlined(p_photo: *ContactPhoto, p_data: [*]const u8, p_len: usize) void;
    pub const setInlined = e_contact_photo_set_inlined;

    /// Sets the `photo`'s mime type.
    extern fn e_contact_photo_set_mime_type(p_photo: *ContactPhoto, p_mime_type: [*:0]const u8) void;
    pub const setMimeType = e_contact_photo_set_mime_type;

    /// Sets the `photo`'s URI.
    extern fn e_contact_photo_set_uri(p_photo: *ContactPhoto, p_uri: [*:0]const u8) void;
    pub const setUri = e_contact_photo_set_uri;

    extern fn e_contact_photo_get_type() usize;
    pub const getGObjectType = e_contact_photo_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NameWestern = extern struct {
    f_prefix: ?[*:0]u8,
    f_first: ?[*:0]u8,
    f_middle: ?[*:0]u8,
    f_nick: ?[*:0]u8,
    f_last: ?[*:0]u8,
    f_suffix: ?[*:0]u8,
    f_full: ?[*:0]u8,

    /// Parses `full_name` and returns an `ebookcontacts.NameWestern` struct filled with
    /// the component parts of the name.
    extern fn e_name_western_parse(p_full_name: [*:0]const u8) *ebookcontacts.NameWestern;
    pub const parse = e_name_western_parse;

    /// Creates a copy of `w`.
    extern fn e_name_western_copy(p_w: *NameWestern) *ebookcontacts.NameWestern;
    pub const copy = e_name_western_copy;

    /// Frees the `w` struct and its contents.
    extern fn e_name_western_free(p_w: *NameWestern) void;
    pub const free = e_name_western_free;

    extern fn e_name_western_get_type() usize;
    pub const getGObjectType = e_name_western_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This opaque type describes a parsed phone number. It can be copied using
/// `ebookcontacts.PhoneNumber.copy`. To release it call `ebookcontacts.PhoneNumber.free`.
pub const PhoneNumber = opaque {
    /// Compares two phone numbers.
    extern fn e_phone_number_compare_strings(p_first_number: [*:0]const u8, p_second_number: [*:0]const u8, p_error: ?*?*glib.Error) ebookcontacts.PhoneNumberMatch;
    pub const compareStrings = e_phone_number_compare_strings;

    /// Compares two phone numbers within the context of `region_code`.
    extern fn e_phone_number_compare_strings_with_region(p_first_number: [*:0]const u8, p_second_number: [*:0]const u8, p_region_code: ?[*:0]const u8, p_error: ?*?*glib.Error) ebookcontacts.PhoneNumberMatch;
    pub const compareStringsWithRegion = e_phone_number_compare_strings_with_region;

    extern fn e_phone_number_error_quark() glib.Quark;
    pub const errorQuark = e_phone_number_error_quark;

    /// Parses the string passed in `phone_number`. Note that no validation is
    /// performed whether the recognized phone number is valid for a particular
    /// region.
    ///
    /// The two-letter country code passed in `region_code` only is used if the
    /// `phone_number` is not written in international format. The application's
    /// default region as returned by `ebookcontacts.phoneNumberGetDefaultRegion` is used
    /// if `region_code` is `NULL`.
    ///
    /// If the number is guaranteed to start with a '+' followed by the country
    /// calling code, then "ZZ" can be passed for `region_code`.
    extern fn e_phone_number_from_string(p_phone_number: [*:0]const u8, p_region_code: ?[*:0]const u8, p_error: ?*?*glib.Error) ?*ebookcontacts.PhoneNumber;
    pub const fromString = e_phone_number_from_string;

    /// Retrieves the preferred country calling code for `region_code`,
    /// e.g. 358 for "fi" or 1 for "en_US`UTF`-8".
    ///
    /// If `NULL` is passed for `region_code` the default region as returned by
    /// `ebookcontacts.phoneNumberGetDefaultRegion` is used.
    extern fn e_phone_number_get_country_code_for_region(p_region_code: ?[*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const getCountryCodeForRegion = e_phone_number_get_country_code_for_region;

    /// Retrieves the current two-letter country code that's used by default for
    /// parsing phone numbers in `ebookcontacts.phoneNumberFromString`. It can be useful
    /// to store this number before parsing a bigger number of phone numbers.
    ///
    /// The result of this functions depends on the current setup of the
    /// `LC_ADDRESS` category: If that category provides a reasonable value
    /// for `_NL_ADDRESS_COUNTRY_AB2` this value is returned. Otherwise the
    /// locale name configured for `LC_ADDRESS` is parsed.
    extern fn e_phone_number_get_default_region(p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getDefaultRegion = e_phone_number_get_default_region;

    /// Checks if phone number support is available. It is recommended to call this
    /// function before using any of the phone-utils functions to ensure that the
    /// required functionality is available, and to pick alternative mechanisms if
    /// needed.
    extern fn e_phone_number_is_supported() c_int;
    pub const isSupported = e_phone_number_is_supported;

    /// Compares two phone numbers.
    extern fn e_phone_number_compare(p_first_number: *const PhoneNumber, p_second_number: *const ebookcontacts.PhoneNumber) ebookcontacts.PhoneNumberMatch;
    pub const compare = e_phone_number_compare;

    /// Makes a copy of `phone_number`.
    extern fn e_phone_number_copy(p_phone_number: *const PhoneNumber) *ebookcontacts.PhoneNumber;
    pub const copy = e_phone_number_copy;

    /// Released the memory occupied by `phone_number`.
    extern fn e_phone_number_free(p_phone_number: *PhoneNumber) void;
    pub const free = e_phone_number_free;

    /// Queries the `phone_number`'s country calling code and optionally stores the country
    /// calling code's origin in `source`. For instance when parsing "+1-617-5423789" this
    /// function would return one and assign E_PHONE_NUMBER_COUNTRY_FROM_FQTN to `source`.
    extern fn e_phone_number_get_country_code(p_phone_number: *const PhoneNumber, p_source: ?*ebookcontacts.PhoneNumberCountrySource) c_int;
    pub const getCountryCode = e_phone_number_get_country_code;

    /// Queries the national portion of `phone_number` without any call-out
    /// prefixes. For instance when parsing "+1-617-5423789" this function would
    /// return the string "6175423789".
    extern fn e_phone_number_get_national_number(p_phone_number: *const PhoneNumber) [*:0]u8;
    pub const getNationalNumber = e_phone_number_get_national_number;

    /// Describes the `phone_number` according to the rules applying to `format`.
    extern fn e_phone_number_to_string(p_phone_number: *const PhoneNumber, p_format: ebookcontacts.PhoneNumberFormat) [*:0]u8;
    pub const toString = e_phone_number_to_string;

    extern fn e_phone_number_get_type() usize;
    pub const getGObjectType = e_phone_number_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceBackendSummarySetupClass = extern struct {
    pub const Instance = ebookcontacts.SourceBackendSummarySetup;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceBackendSummarySetupClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceBackendSummarySetupPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCardAttribute = opaque {
    /// Creates a new `ebookcontacts.VCardAttribute` with the specified group and
    /// attribute names. The `attr_group` may be `NULL` or the empty string if no
    /// group is needed.
    extern fn e_vcard_attribute_new(p_attr_group: ?[*:0]const u8, p_attr_name: [*:0]const u8) *ebookcontacts.VCardAttribute;
    pub const new = e_vcard_attribute_new;

    /// Prepends `param` to `attr`'s list of parameters. This takes ownership of
    /// `param` (and all its values).
    ///
    /// Duplicate parameters have their values merged, so that all parameter names
    /// in `attr` are unique. Values are also merged so that uniqueness is preserved.
    extern fn e_vcard_attribute_add_param(p_attr: *VCardAttribute, p_param: *ebookcontacts.VCardAttributeParam) void;
    pub const addParam = e_vcard_attribute_add_param;

    /// Appends `value` to `param`, then prepends `param` to `attr`. This takes ownership
    /// of `param`, but not of `value`.
    ///
    /// This is a convenience method for `ebookcontacts.VCardAttributeParam.addValue` and
    /// `ebookcontacts.VCardAttribute.addParam`.
    extern fn e_vcard_attribute_add_param_with_value(p_attr: *VCardAttribute, p_param: *ebookcontacts.VCardAttributeParam, p_value: [*:0]const u8) void;
    pub const addParamWithValue = e_vcard_attribute_add_param_with_value;

    /// Appends the list of values to `param`, then prepends `param` to `attr`. This
    /// takes ownership of `param`, but not of the list of values.
    ///
    /// This is a convenience method for `ebookcontacts.VCardAttributeParam.addValue` and
    /// `ebookcontacts.VCardAttribute.addParam`.
    extern fn e_vcard_attribute_add_param_with_values(p_attr: *VCardAttribute, p_param: *ebookcontacts.VCardAttributeParam, ...) void;
    pub const addParamWithValues = e_vcard_attribute_add_param_with_values;

    /// Appends `value` to `attr`'s list of values.
    extern fn e_vcard_attribute_add_value(p_attr: *VCardAttribute, p_value: [*:0]const u8) void;
    pub const addValue = e_vcard_attribute_add_value;

    /// Encodes `value` according to the encoding used for `attr`, and appends it to
    /// `attr`'s list of values.
    ///
    /// This should only be used if the `ebookcontacts.VCardAttribute` has a non-raw encoding (i.e.
    /// if it’s encoded in base-64 or quoted-printable encoding).
    extern fn e_vcard_attribute_add_value_decoded(p_attr: *VCardAttribute, p_value: [*:0]const u8, p_len: c_int) void;
    pub const addValueDecoded = e_vcard_attribute_add_value_decoded;

    /// Appends a list of values to `attr`.
    extern fn e_vcard_attribute_add_values(p_attr: *VCardAttribute, ...) void;
    pub const addValues = e_vcard_attribute_add_values;

    /// Makes a copy of `attr`.
    extern fn e_vcard_attribute_copy(p_attr: *VCardAttribute) *ebookcontacts.VCardAttribute;
    pub const copy = e_vcard_attribute_copy;

    /// Frees an attribute, its values and its parameters.
    extern fn e_vcard_attribute_free(p_attr: *VCardAttribute) void;
    pub const free = e_vcard_attribute_free;

    /// Gets the group name of `attr`.
    extern fn e_vcard_attribute_get_group(p_attr: *VCardAttribute) ?[*:0]const u8;
    pub const getGroup = e_vcard_attribute_get_group;

    /// Gets the name of `attr`.
    extern fn e_vcard_attribute_get_name(p_attr: *VCardAttribute) [*:0]const u8;
    pub const getName = e_vcard_attribute_get_name;

    /// Gets the list of values for the paramater `name` from `attr`. The list and its
    /// contents are owned by `attr`, and must not be freed. If no parameter with the
    /// given `name` exists, `NULL` is returned.
    extern fn e_vcard_attribute_get_param(p_attr: *VCardAttribute, p_name: [*:0]const u8) ?*glib.List;
    pub const getParam = e_vcard_attribute_get_param;

    /// Gets the list of parameters (of type `ebookcontacts.VCardAttributeParam`) from `attr`. The
    /// list and its contents are owned by `attr`, and must not be freed.
    extern fn e_vcard_attribute_get_params(p_attr: *VCardAttribute) *glib.List;
    pub const getParams = e_vcard_attribute_get_params;

    /// Gets the value of a single-valued `ebookcontacts.VCardAttribute`, `attr`.
    ///
    /// For example, for a <code>FN</code> (full name) attribute, this will
    /// return the contact’s full name as a single string.
    ///
    /// This will print a warning if called on an `ebookcontacts.VCardAttribute` which is not
    /// single-valued (i.e. for which `ebookcontacts.VCardAttribute.isSingleValued` returns
    /// `FALSE`). Use `ebookcontacts.VCardAttribute.getValues` in such cases instead.
    extern fn e_vcard_attribute_get_value(p_attr: *VCardAttribute) ?[*:0]u8;
    pub const getValue = e_vcard_attribute_get_value;

    /// Gets the value of a single-valued `ebookcontacts.VCardAttribute`, `attr`, decoding
    /// it if necessary according to the encoding given in the vCard’s
    /// <code>ENCODING</code> attribute.
    ///
    /// This will print a warning if called on an `ebookcontacts.VCardAttribute` which is not
    /// single-valued (i.e. for which `ebookcontacts.VCardAttribute.isSingleValued` returns
    /// `FALSE`). Use `ebookcontacts.VCardAttribute.getValuesDecoded` in such cases instead.
    extern fn e_vcard_attribute_get_value_decoded(p_attr: *VCardAttribute) ?*glib.String;
    pub const getValueDecoded = e_vcard_attribute_get_value_decoded;

    /// Gets the ordered list of values from `attr`. The list and its
    /// contents are owned by `attr`, and must not be freed.
    ///
    /// For example, for an <code>ADR</code> (postal address) attribute, this will
    /// return the components of the postal address.
    ///
    /// This may be called on a single-valued attribute (i.e. one for which
    /// `ebookcontacts.VCardAttribute.isSingleValued` returns `TRUE`) and will return a
    /// one-element list in that case. Alternatively, use
    /// `ebookcontacts.VCardAttribute.getValue` in such cases.
    extern fn e_vcard_attribute_get_values(p_attr: *VCardAttribute) *glib.List;
    pub const getValues = e_vcard_attribute_get_values;

    /// Gets the ordered list of values from `attr`, decoding them if
    /// necessary according to the encoding given in the vCard’s
    /// <code>ENCODING</code> attribute. The list and its contents are owned by
    /// `attr`, and must not be freed.
    ///
    /// This may be called on a single-valued attribute (i.e. one for which
    /// `ebookcontacts.VCardAttribute.isSingleValued` returns `TRUE`) and will return a
    /// one-element list in that case. Alternatively, use
    /// `ebookcontacts.VCardAttribute.getValueDecoded` in such cases.
    extern fn e_vcard_attribute_get_values_decoded(p_attr: *VCardAttribute) *glib.List;
    pub const getValuesDecoded = e_vcard_attribute_get_values_decoded;

    /// Checks if `attr` has an `ebookcontacts.VCardAttributeParam` with name `EVC_TYPE` and `typestr`
    /// as one of its values.
    ///
    /// For example, for the vCard attribute:
    /// ```
    /// TEL;TYPE=WORK,VOICE:(111) 555-1212
    /// ```
    /// the following holds true:
    /// ```
    /// g_assert_true (e_vcard_attribute_has_type (attr, "WORK") == TRUE);
    /// g_assert_true (e_vcard_attribute_has_type (attr, "voice") == TRUE);
    /// g_assert_true (e_vcard_attribute_has_type (attr, "HOME") == FALSE);
    /// ```
    ///
    /// Comparisons against `typestr` are case-insensitive.
    extern fn e_vcard_attribute_has_type(p_attr: *VCardAttribute, p_typestr: [*:0]const u8) c_int;
    pub const hasType = e_vcard_attribute_has_type;

    /// Checks if `attr` has a single value.
    extern fn e_vcard_attribute_is_single_valued(p_attr: *VCardAttribute) c_int;
    pub const isSingleValued = e_vcard_attribute_is_single_valued;

    /// Removes and frees parameter `param_name` from the attribute `attr`. Parameter
    /// names are guaranteed to be unique, so `attr` is guaranteed to have no
    /// parameters named `param_name` after this function returns.
    extern fn e_vcard_attribute_remove_param(p_attr: *VCardAttribute, p_param_name: [*:0]const u8) void;
    pub const removeParam = e_vcard_attribute_remove_param;

    /// Removes the value `s` from the parameter `param_name` on the attribute `attr`.
    /// If `s` was the only value for parameter `param_name`, that parameter is removed
    /// entirely from `attr` and freed.
    extern fn e_vcard_attribute_remove_param_value(p_attr: *VCardAttribute, p_param_name: [*:0]const u8, p_s: [*:0]const u8) void;
    pub const removeParamValue = e_vcard_attribute_remove_param_value;

    /// Removes and frees all parameters from `attr`.
    ///
    /// This also resets the `ebookcontacts.VCardAttribute`'s encoding back to raw.
    extern fn e_vcard_attribute_remove_params(p_attr: *VCardAttribute) void;
    pub const removeParams = e_vcard_attribute_remove_params;

    /// Removes value `s` from the value list in `attr`. The value `s` is not freed.
    extern fn e_vcard_attribute_remove_value(p_attr: *VCardAttribute, p_s: [*:0]const u8) void;
    pub const removeValue = e_vcard_attribute_remove_value;

    /// Removes and frees all values from `attr`.
    extern fn e_vcard_attribute_remove_values(p_attr: *VCardAttribute) void;
    pub const removeValues = e_vcard_attribute_remove_values;

    extern fn e_vcard_attribute_get_type() usize;
    pub const getGObjectType = e_vcard_attribute_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCardAttributeParam = opaque {
    /// Creates a new parameter named `name`.
    extern fn e_vcard_attribute_param_new(p_name: [*:0]const u8) *ebookcontacts.VCardAttributeParam;
    pub const new = e_vcard_attribute_param_new;

    /// Appends `value` to `param`'s list of values.
    extern fn e_vcard_attribute_param_add_value(p_param: *VCardAttributeParam, p_value: [*:0]const u8) void;
    pub const addValue = e_vcard_attribute_param_add_value;

    /// Appends a list of values to `param`.
    extern fn e_vcard_attribute_param_add_values(p_param: *VCardAttributeParam, ...) void;
    pub const addValues = e_vcard_attribute_param_add_values;

    /// Makes a copy of `param` and all its values.
    extern fn e_vcard_attribute_param_copy(p_param: *VCardAttributeParam) *ebookcontacts.VCardAttributeParam;
    pub const copy = e_vcard_attribute_param_copy;

    /// Frees `param` and its values.
    extern fn e_vcard_attribute_param_free(p_param: *VCardAttributeParam) void;
    pub const free = e_vcard_attribute_param_free;

    /// Gets the name of `param`.
    ///
    /// For example, for the only parameter of the vCard attribute:
    /// ```
    /// TEL;TYPE=WORK,VOICE:(111) 555-1212
    /// ```
    /// this would return <code>TYPE</code> (which is string-equivalent to
    /// `EVC_TYPE`).
    extern fn e_vcard_attribute_param_get_name(p_param: *VCardAttributeParam) [*:0]const u8;
    pub const getName = e_vcard_attribute_param_get_name;

    /// Gets the list of values from `param`. The list and its
    /// contents are owned by `param`, and must not be freed.
    ///
    /// For example, for the <code>TYPE</code> parameter of the vCard attribute:
    /// ```
    /// TEL;TYPE=WORK,VOICE:(111) 555-1212
    /// ```
    /// this would return the list <code>WORK</code>, <code>VOICE</code>.
    extern fn e_vcard_attribute_param_get_values(p_param: *VCardAttributeParam) *glib.List;
    pub const getValues = e_vcard_attribute_param_get_values;

    /// Removes and frees all values from `param`.
    extern fn e_vcard_attribute_param_remove_values(p_param: *VCardAttributeParam) void;
    pub const removeValues = e_vcard_attribute_param_remove_values;

    extern fn e_vcard_attribute_param_get_type() usize;
    pub const getGObjectType = e_vcard_attribute_param_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCardClass = extern struct {
    pub const Instance = ebookcontacts.VCard;

    f_parent_class: gobject.ObjectClass,
    f__ebook_reserved0: ?*const fn () callconv(.c) void,
    f__ebook_reserved1: ?*const fn () callconv(.c) void,
    f__ebook_reserved2: ?*const fn () callconv(.c) void,
    f__ebook_reserved3: ?*const fn () callconv(.c) void,
    f__ebook_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *VCardClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCardPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of change in an `ebookcontacts.BookChange`
pub const BookChangeType = enum(c_int) {
    added = 0,
    deleted = 1,
    modified = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes returned by `EBookClient` APIs, if an `edataserver.ClientError` was not available.
pub const BookClientError = enum(c_int) {
    no_such_book = 0,
    contact_not_found = 1,
    contact_id_already_exists = 2,
    no_such_source = 3,
    no_space = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the start position to in the list of traversed contacts
/// in calls to `e_book_client_cursor_step`.
///
/// When an `EBookClientCursor` is created, the current position implied by `E_BOOK_CURSOR_ORIGIN_CURRENT`
/// is the same as `E_BOOK_CURSOR_ORIGIN_BEGIN`.
pub const BookCursorOrigin = enum(c_int) {
    current = 0,
    begin = 1,
    end = 2,
    _,

    extern fn e_book_cursor_origin_get_type() usize;
    pub const getGObjectType = e_book_cursor_origin_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the sort order of an ordered query
pub const BookCursorSortType = enum(c_int) {
    ascending = 0,
    descending = 1,
    _,

    extern fn e_book_cursor_sort_type_get_type() usize;
    pub const getGObjectType = e_book_cursor_sort_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of index defined by `ebookcontacts.SourceBackendSummarySetup.setIndexedFields`
pub const BookIndexType = enum(c_int) {
    prefix = 0,
    suffix = 1,
    phone = 2,
    sort_key = 3,
    _,

    extern fn e_book_index_type_get_type() usize;
    pub const getGObjectType = e_book_index_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The kind of test a query created by `ebookcontacts.bookQueryFieldTest` shall perform.
///
/// See also: `ebookcontacts.phoneNumberCompareStrings`.
pub const BookQueryTest = enum(c_int) {
    is = 0,
    contains = 1,
    begins_with = 2,
    ends_with = 3,
    equals_phone_number = 4,
    equals_national_phone_number = 5,
    equals_short_phone_number = 6,
    regex_normal = 7,
    regex_raw = 8,
    last = 9,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Status messages used in notifications in the deprecated `EBookView` class
pub const BookViewStatus = enum(c_int) {
    status_ok = 0,
    status_time_limit_exceeded = 1,
    status_size_limit_exceeded = 2,
    error_invalid_query = 3,
    error_query_refused = 4,
    error_other_error = 5,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactField = enum(c_int) {
    uid = 1,
    file_as = 2,
    book_uid = 3,
    full_name = 4,
    given_name = 5,
    family_name = 6,
    nickname = 7,
    email_1 = 8,
    email_2 = 9,
    email_3 = 10,
    email_4 = 11,
    mailer = 12,
    address_label_home = 13,
    address_label_work = 14,
    address_label_other = 15,
    phone_assistant = 16,
    phone_business = 17,
    phone_business_2 = 18,
    phone_business_fax = 19,
    phone_callback = 20,
    phone_car = 21,
    phone_company = 22,
    phone_home = 23,
    phone_home_2 = 24,
    phone_home_fax = 25,
    phone_isdn = 26,
    phone_mobile = 27,
    phone_other = 28,
    phone_other_fax = 29,
    phone_pager = 30,
    phone_primary = 31,
    phone_radio = 32,
    phone_telex = 33,
    phone_ttytdd = 34,
    org = 35,
    org_unit = 36,
    office = 37,
    title = 38,
    role = 39,
    manager = 40,
    assistant = 41,
    homepage_url = 42,
    blog_url = 43,
    categories = 44,
    calendar_uri = 45,
    freebusy_url = 46,
    ics_calendar = 47,
    video_url = 48,
    spouse = 49,
    note = 50,
    im_aim_home_1 = 51,
    im_aim_home_2 = 52,
    im_aim_home_3 = 53,
    im_aim_work_1 = 54,
    im_aim_work_2 = 55,
    im_aim_work_3 = 56,
    im_groupwise_home_1 = 57,
    im_groupwise_home_2 = 58,
    im_groupwise_home_3 = 59,
    im_groupwise_work_1 = 60,
    im_groupwise_work_2 = 61,
    im_groupwise_work_3 = 62,
    im_jabber_home_1 = 63,
    im_jabber_home_2 = 64,
    im_jabber_home_3 = 65,
    im_jabber_work_1 = 66,
    im_jabber_work_2 = 67,
    im_jabber_work_3 = 68,
    im_yahoo_home_1 = 69,
    im_yahoo_home_2 = 70,
    im_yahoo_home_3 = 71,
    im_yahoo_work_1 = 72,
    im_yahoo_work_2 = 73,
    im_yahoo_work_3 = 74,
    im_msn_home_1 = 75,
    im_msn_home_2 = 76,
    im_msn_home_3 = 77,
    im_msn_work_1 = 78,
    im_msn_work_2 = 79,
    im_msn_work_3 = 80,
    im_icq_home_1 = 81,
    im_icq_home_2 = 82,
    im_icq_home_3 = 83,
    im_icq_work_1 = 84,
    im_icq_work_2 = 85,
    im_icq_work_3 = 86,
    rev = 87,
    name_or_org = 88,
    address = 89,
    address_home = 90,
    address_work = 91,
    address_other = 92,
    category_list = 93,
    photo = 94,
    logo = 95,
    name = 96,
    email = 97,
    im_aim = 98,
    im_groupwise = 99,
    im_jabber = 100,
    im_yahoo = 101,
    im_msn = 102,
    im_icq = 103,
    wants_html = 104,
    is_list = 105,
    list_show_addresses = 106,
    birth_date = 107,
    anniversary = 108,
    x509_cert = 109,
    pgp_cert = 110,
    im_gadugadu_home_1 = 111,
    im_gadugadu_home_2 = 112,
    im_gadugadu_home_3 = 113,
    im_gadugadu_work_1 = 114,
    im_gadugadu_work_2 = 115,
    im_gadugadu_work_3 = 116,
    im_gadugadu = 117,
    geo = 118,
    tel = 119,
    im_skype_home_1 = 120,
    im_skype_home_2 = 121,
    im_skype_home_3 = 122,
    im_skype_work_1 = 123,
    im_skype_work_2 = 124,
    im_skype_work_3 = 125,
    im_skype = 126,
    sip = 127,
    im_google_talk_home_1 = 128,
    im_google_talk_home_2 = 129,
    im_google_talk_home_3 = 130,
    im_google_talk_work_1 = 131,
    im_google_talk_work_2 = 132,
    im_google_talk_work_3 = 133,
    im_google_talk = 134,
    im_twitter = 135,
    im_matrix_home_1 = 136,
    im_matrix_home_2 = 137,
    im_matrix_home_3 = 138,
    im_matrix_work_1 = 139,
    im_matrix_work_2 = 140,
    im_matrix_work_3 = 141,
    im_matrix = 142,
    field_last = 143,
    _,

    pub const field_first = ContactField.uid;
    pub const last_simple_string = ContactField.name_or_org;
    pub const first_phone_id = ContactField.phone_assistant;
    pub const last_phone_id = ContactField.phone_ttytdd;
    pub const first_email_id = ContactField.email_1;
    pub const last_email_id = ContactField.email_4;
    pub const first_address_id = ContactField.address_home;
    pub const last_address_id = ContactField.address_other;
    pub const first_label_id = ContactField.address_label_home;
    pub const last_label_id = ContactField.address_label_other;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContactPhotoType = enum(c_int) {
    inlined = 0,
    uri = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The origin of a parsed EPhoneNumber's country calling code.
pub const PhoneNumberCountrySource = enum(c_int) {
    fqtn = 1,
    idd = 5,
    default = 20,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Numeric description of a phone number related error.
pub const PhoneNumberError = enum(c_int) {
    not_implemented = 0,
    unknown = 1,
    not_a_number = 2,
    invalid_country_code = 3,
    too_short_after_idd = 4,
    too_short = 5,
    too_long = 6,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The supported formatting rules for phone numbers.
pub const PhoneNumberFormat = enum(c_int) {
    e164 = 0,
    international = 1,
    national = 2,
    rfc3966 = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The strength of a phone number match.
///
/// <example>
/// <title>Some examples of phone number matches</title>
/// <para>
/// Let's consider the phone number "+1-221-5423789", then comparing with
/// "+1.221.542.3789" we have get E_PHONE_NUMBER_MATCH_EXACT because country
/// code, region code and local number are matching. Comparing with "2215423789"
/// will result in E_PHONE_NUMBER_MATCH_NATIONAL because the country calling code
/// is missing, but the national portion is matching. Finally comparing with
/// "5423789" gives E_PHONE_NUMBER_MATCH_SHORT. For more detail have a look at
/// the following table:
///
/// <informaltable border="1" align="center">
///  <colgroup>
///   <col width="20%" />
///   <col width="20%" />
///   <col width="20%" />
///   <col width="20%" />
///   <col width="20%" />
///  </colgroup>
///  <tbody>
///   <tr>
///    <th></th>
///    <th align="center">+1-617-5423789</th>
///    <th align="center">+1-221-5423789</th>
///    <th align="center">221-5423789</th>
///    <th align="center">5423789</th>
///   </tr><tr>
///    <th align="right">+1-617-5423789</th>
///    <td align="center">exact</td>
///    <td align="center">none</td>
///    <td align="center">none</td>
///    <td align="center">short</td>
///   </tr><tr>
///    <th align="right">+1-221-5423789</th>
///    <td align="center">none</td>
///    <td align="center">exact</td>
///    <td align="center">national</td>
///    <td align="center">short</td>
///   </tr><tr>
///    <th align="right">221-5423789</th>
///    <td align="center">none</td>
///    <td align="center">national</td>
///    <td align="center">national</td>
///    <td align="center">short</td>
///   </tr><tr>
///    <th align="right">5423789</th>
///    <td align="center">short</td>
///    <td align="center">short</td>
///    <td align="center">short</td>
///    <td align="center">short</td>
///   </tr>
///  </tbody>
/// </informaltable>
/// </para>
/// </example>
pub const PhoneNumberMatch = enum(c_int) {
    none = 0,
    exact = 1,
    national = 1024,
    short = 2048,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VCardFormat = enum(c_int) {
    @"21" = 0,
    @"30" = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that control the behaviour of an `EBookClientView`.
pub const BookClientViewFlags = packed struct(c_uint) {
    notify_initial: bool = false,
    manual_query: bool = false,
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

    pub const flags_none: BookClientViewFlags = @bitCast(@as(c_uint, 0));
    pub const flags_notify_initial: BookClientViewFlags = @bitCast(@as(c_uint, 1));
    pub const flags_manual_query: BookClientViewFlags = @bitCast(@as(c_uint, 2));
    extern fn e_book_client_view_flags_get_type() usize;
    pub const getGObjectType = e_book_client_view_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the behaviour of `e_book_client_cursor_step`.
pub const BookCursorStepFlags = packed struct(c_uint) {
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

    pub const flags_move: BookCursorStepFlags = @bitCast(@as(c_uint, 1));
    pub const flags_fetch: BookCursorStepFlags = @bitCast(@as(c_uint, 2));
    extern fn e_book_cursor_step_flags_get_type() usize;
    pub const getGObjectType = e_book_cursor_step_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Book operation flags, to specify behavior in certain situations. The conflict
/// resolution mode flags cannot be combined together, where the `E_BOOK_OPERATION_FLAG_CONFLICT_KEEP_LOCAL`
/// is the default behavior (and it is used when no other conflict resolution flag is set).
/// The flags can be ignored when the operation or the backend don't support it.
pub const BookOperationFlags = packed struct(c_uint) {
    conflict_fail: bool = false,
    conflict_use_newer: bool = false,
    conflict_keep_server: bool = false,
    conflict_write_copy: bool = false,
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

    pub const flags_none: BookOperationFlags = @bitCast(@as(c_uint, 0));
    pub const flags_conflict_fail: BookOperationFlags = @bitCast(@as(c_uint, 1));
    pub const flags_conflict_use_newer: BookOperationFlags = @bitCast(@as(c_uint, 2));
    pub const flags_conflict_keep_server: BookOperationFlags = @bitCast(@as(c_uint, 4));
    pub const flags_conflict_keep_local: BookOperationFlags = @bitCast(@as(c_uint, 0));
    pub const flags_conflict_write_copy: BookOperationFlags = @bitCast(@as(c_uint, 8));
    extern fn e_book_operation_flags_get_type() usize;
    pub const getGObjectType = e_book_operation_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn e_book_client_error_create(p_code: ebookcontacts.BookClientError, p_custom_msg: ?[*:0]const u8) *glib.Error;
pub const bookClientErrorCreate = e_book_client_error_create;

/// Similar as `ebookcontacts.bookClientErrorCreate`, only here, instead of custom_msg,
/// is used a `printf` format to create a custom message for the error.
extern fn e_book_client_error_create_fmt(p_code: ebookcontacts.BookClientError, p_format: ?[*:0]const u8, ...) *glib.Error;
pub const bookClientErrorCreateFmt = e_book_client_error_create_fmt;

extern fn e_book_client_error_quark() glib.Quark;
pub const bookClientErrorQuark = e_book_client_error_quark;

/// Get localized human readable description of the given error code.
extern fn e_book_client_error_to_string(p_code: ebookcontacts.BookClientError) [*:0]const u8;
pub const bookClientErrorToString = e_book_client_error_to_string;

/// Encodes the `edataserver.ConflictResolution` into the bit-or of `ebookcontacts.BookOperationFlags`.
/// The returned value can be bit-or-ed with other `ebookcontacts.BookOperationFlags` values.
extern fn e_book_util_conflict_resolution_to_operation_flags(p_conflict_resolution: edataserver.ConflictResolution) u32;
pub const bookUtilConflictResolutionToOperationFlags = e_book_util_conflict_resolution_to_operation_flags;

/// Compares list of categories on the `old_contact` with the list of categories
/// on the `new_contact` and fills `out_added` categories and `out_removed` categories
/// accordingly, as if the `old_contact` is replaced with the `new_contact`. When either
/// of the contacts is `NULL`, it's considered as having no categories set.
/// Rather than returning empty `glib.HashTable`, the return argument is set to `NULL`
/// when there are no added/removed categories.
///
/// The key of the hash table is the category string, the value is an integer (1).
/// There is used the hash table only for speed.
///
/// The returned `glib.HashTable`-s should be freed with `glib.hashTableUnref`,
/// when no longer needed.
extern fn e_book_util_diff_categories(p_old_contact: ?*ebookcontacts.Contact, p_new_contact: ?*ebookcontacts.Contact, p_out_added: **glib.HashTable, p_out_removed: **glib.HashTable) void;
pub const bookUtilDiffCategories = e_book_util_diff_categories;

/// Parses the `email_address` and calls `func` for each found address.
/// The first parameter of the `func` is the name, the second parameter
/// of the `func` is the email, the third parameters of the `func` is
/// the `user_data`. The `func` returns `TRUE`, to continue processing.
extern fn e_book_util_foreach_address(p_email_address: [*:0]const u8, p_func: glib.HRFunc, p_user_data: ?*anyopaque) void;
pub const bookUtilForeachAddress = e_book_util_foreach_address;

/// Decodes the `edataserver.ConflictResolution` from the bit-or of `ebookcontacts.BookOperationFlags`.
extern fn e_book_util_operation_flags_to_conflict_resolution(p_flags: u32) edataserver.ConflictResolution;
pub const bookUtilOperationFlagsToConflictResolution = e_book_util_operation_flags_to_conflict_resolution;

/// Provides comma-separated list of all known categories used by
/// the contacts stored in the book backend.
pub const BOOK_BACKEND_PROPERTY_CATEGORIES = "\"categories\"";
/// Provides comma-separated list of required fields by the book backend.
/// All of these attributes should be set, otherwise the backend will reject
/// saving the contact.
///
/// The `ebookcontacts.Contact.fieldId` can be used to transform the field name
/// into an `ebookcontacts.ContactField`.
pub const BOOK_BACKEND_PROPERTY_REQUIRED_FIELDS = "\"required-fields\"";
/// The current overall revision string, this can be used as
/// a quick check to see if data has changed at all since the
/// last time the addressbook revision was observed.
pub const BOOK_BACKEND_PROPERTY_REVISION = "\"revision\"";
/// Provides comma-separated list of supported fields by the book backend.
/// Attributes other than those listed here can be discarded. This can be
/// used to enable/show only supported elements in GUI.
///
/// The `ebookcontacts.Contact.fieldId` can be used to transform the field name
/// into an `ebookcontacts.ContactField`.
pub const BOOK_BACKEND_PROPERTY_SUPPORTED_FIELDS = "\"supported-fields\"";
pub const EVC_ADR = "ADR";
pub const EVC_BDAY = "BDAY";
pub const EVC_CALURI = "CALURI";
pub const EVC_CATEGORIES = "CATEGORIES";
pub const EVC_CL_UID = "X-EVOLUTION-CONTACT-LIST-UID";
pub const EVC_CONTACT_LIST = "X-EVOLUTION-CONTACT-LIST-INFO";
pub const EVC_EMAIL = "EMAIL";
pub const EVC_ENCODING = "ENCODING";
pub const EVC_FBURL = "FBURL";
pub const EVC_FN = "FN";
pub const EVC_GEO = "GEO";
pub const EVC_ICSCALENDAR = "ICSCALENDAR";
pub const EVC_KEY = "KEY";
pub const EVC_LABEL = "LABEL";
pub const EVC_LOGO = "LOGO";
pub const EVC_MAILER = "MAILER";
pub const EVC_N = "N";
pub const EVC_NICKNAME = "NICKNAME";
pub const EVC_NOTE = "NOTE";
pub const EVC_ORG = "ORG";
pub const EVC_PARENT_CL = "X-EVOLUTION-PARENT-UID";
pub const EVC_PHOTO = "PHOTO";
pub const EVC_PRODID = "PRODID";
pub const EVC_QUOTEDPRINTABLE = "QUOTED-PRINTABLE";
pub const EVC_REV = "REV";
pub const EVC_ROLE = "ROLE";
pub const EVC_TEL = "TEL";
pub const EVC_TITLE = "TITLE";
pub const EVC_TYPE = "TYPE";
pub const EVC_UID = "UID";
pub const EVC_URL = "URL";
pub const EVC_VALUE = "VALUE";
pub const EVC_VERSION = "VERSION";
pub const EVC_X_AIM = "X-AIM";
pub const EVC_X_ANNIVERSARY = "X-EVOLUTION-ANNIVERSARY";
pub const EVC_X_ASSISTANT = "X-EVOLUTION-ASSISTANT";
pub const EVC_X_BIRTHDAY = "X-EVOLUTION-BIRTHDAY";
pub const EVC_X_BLOG_URL = "X-EVOLUTION-BLOG-URL";
pub const EVC_X_BOOK_UID = "X-EVOLUTION-BOOK-UID";
pub const EVC_X_CALLBACK = "X-EVOLUTION-CALLBACK";
pub const EVC_X_COMPANY = "X-EVOLUTION-COMPANY";
pub const EVC_X_DEST_CONTACT_UID = "X-EVOLUTION-DEST-CONTACT-UID";
pub const EVC_X_DEST_EMAIL = "X-EVOLUTION-DEST-EMAIL";
pub const EVC_X_DEST_EMAIL_NUM = "X-EVOLUTION-DEST-EMAIL-NUM";
pub const EVC_X_DEST_HTML_MAIL = "X-EVOLUTION-DEST-HTML-MAIL";
pub const EVC_X_DEST_NAME = "X-EVOLUTION-DEST-NAME";
pub const EVC_X_DEST_SOURCE_UID = "X-EVOLUTION-DEST-SOURCE-UID";
pub const EVC_X_E164 = "X-EVOLUTION-E164";
pub const EVC_X_FILE_AS = "X-EVOLUTION-FILE-AS";
pub const EVC_X_GADUGADU = "X-GADUGADU";
pub const EVC_X_GOOGLE_TALK = "X-GOOGLE-TALK";
pub const EVC_X_GROUPWISE = "X-GROUPWISE";
pub const EVC_X_ICQ = "X-ICQ";
pub const EVC_X_JABBER = "X-JABBER";
pub const EVC_X_LIST = "X-EVOLUTION-LIST";
pub const EVC_X_LIST_NAME = "X-EVOLUTION-LIST-NAME";
pub const EVC_X_LIST_SHOW_ADDRESSES = "X-EVOLUTION-LIST-SHOW-ADDRESSES";
pub const EVC_X_MANAGER = "X-EVOLUTION-MANAGER";
pub const EVC_X_MATRIX = "X-MATRIX";
pub const EVC_X_MSN = "X-MSN";
pub const EVC_X_RADIO = "X-EVOLUTION-RADIO";
pub const EVC_X_SIP = "X-SIP";
pub const EVC_X_SKYPE = "X-SKYPE";
pub const EVC_X_SPOUSE = "X-EVOLUTION-SPOUSE";
pub const EVC_X_TELEX = "X-EVOLUTION-TELEX";
pub const EVC_X_TTYTDD = "X-EVOLUTION-TTYTDD";
/// Twitter name(s).
pub const EVC_X_TWITTER = "X-TWITTER";
pub const EVC_X_VIDEO_URL = "X-EVOLUTION-VIDEO-URL";
pub const EVC_X_WANTS_HTML = "X-MOZILLA-HTML";
pub const EVC_X_YAHOO = "X-YAHOO";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `ebookcontacts.SourceBackendSummarySetup`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_BACKEND_SUMMARY_SETUP = "Backend Summary Setup";
/// FIXME: Document me!
pub const VCARD_21_VALID_PARAMETERS = "TYPE,VALUE,ENCODING,CHARSET,LANGUAGE,DOM,INTL,POSTAL,PARCEL,HOME,WORK,PREF,VOICE,FAX,MSG,CELL,PAGER,BBS,MODEM,CAR,ISDN,VIDEO,AOL,APPLELINK,ATTMAIL,CIS,EWORLD,INTERNET,IBMMAIL,MCIMAIL,POWERSHARE,PRODIGY,TLX,X400,GIF,CGM,WMF,BMP,MET,PMB,DIB,PICT,TIFF,PDF,PS,JPEG,QTIME,MPEG,MPEG2,AVI,WAVE,AIFF,PCM,X509,PGP";
/// FIXME: Document me!
pub const VCARD_21_VALID_PROPERTIES = "ADR,ORG,N,AGENT,LOGO,PHOTO,LABEL,FN,TITLE,SOUND,VERSION,TEL,EMAIL,TZ,GEO,NOTE,URL,BDAY,ROLE,REV,UID,KEY,MAILER";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
