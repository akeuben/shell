pub const ext = @import("ext.zig");
const adw = @This();

const std = @import("std");
const compat = @import("compat");
const gtk = @import("gtk4");
const gsk = @import("gsk4");
const graphene = @import("graphene1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
/// A dialog showing information about the application.
///
/// <picture>
///   <source srcset="about-dialog-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="about-dialog.png" alt="about-dialog">
/// </picture>
///
/// an about dialog is typically opened when the user activates the `About …`
/// item in the application's primary menu. All parts of the dialog are optional.
///
/// ## Main page
///
/// `AdwAboutDialog` prominently displays the application's icon, name, developer
/// name and version. They can be set with the `AboutDialog.properties.application_icon`,
/// `AboutDialog.properties.application_name`,
/// `AboutDialog.properties.developer_name` and `AboutDialog.properties.version`
/// respectively.
///
/// ## What's New
///
/// `AdwAboutDialog` provides a way for applications to display their release
/// notes, set with the `AboutDialog.properties.release_notes` property.
///
/// Release notes are formatted the same way as
/// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
///
/// The supported formatting options are:
///
/// * Paragraph (`<p>`)
/// * Ordered list (`<ol>`), with list items (`<li>`)
/// * Unordered list (`<ul>`), with list items (`<li>`)
///
/// Within paragraphs and list items, emphasis (`<em>`) and inline code
/// (`<code>`) text styles are supported. The emphasis is rendered in italic,
/// while inline code is shown in a monospaced font.
///
/// Any text outside paragraphs or list items is ignored.
///
/// Nested lists are not supported.
///
/// Only one version can be shown at a time. By default, the displayed version
/// number matches `AboutDialog.properties.version`. Use
/// `AboutDialog.properties.release_notes_version` to override it.
///
/// ## Details
///
/// The Details page displays the application comments and links.
///
/// The comments can be set with the `AboutDialog.properties.comments` property.
/// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
/// detailed. It can also contain links and Pango markup.
///
/// To set the application website, use `AboutDialog.properties.website`.
/// To add extra links below the website, use `AboutDialog.addLink`.
///
/// If the Details page doesn't have any other content besides website, the
/// website will be displayed on the main page instead.
///
/// ## Troubleshooting
///
/// `AdwAboutDialog` displays the following two links on the main page:
///
/// * Support Questions, set with the `AboutDialog.properties.support_url` property,
/// * Report an Issue, set with the `AboutDialog.properties.issue_url` property.
///
/// Additionally, applications can provide debugging information. It will be
/// shown separately on the Troubleshooting page. Use the
/// `AboutDialog.properties.debug_info` property to specify it.
///
/// It's intended to be attached to issue reports when reporting issues against
/// the application. As such, it cannot contain markup or links.
///
/// `AdwAboutDialog` provides a quick way to save debug information to a file.
/// When saving, `AboutDialog.properties.debug_info_filename` would be used as
/// the suggested filename.
///
/// ## Credits and Acknowledgements
///
/// The Credits page has the following default sections:
///
/// * Developers, set with the `AboutDialog.properties.developers` property,
/// * Designers, set with the `AboutDialog.properties.designers` property,
/// * Artists, set with the `AboutDialog.properties.artists` property,
/// * Documenters, set with the `AboutDialog.properties.documenters` property,
/// * Translators, set with the `AboutDialog.properties.translator_credits` property.
///
/// When setting translator credits, use the strings `"translator-credits"` or
/// `"translator_credits"` and mark them as translatable.
///
/// The default sections that don't contain any names won't be displayed.
///
/// The Credits page can also contain an arbitrary number of extra sections below
/// the default ones. Use `AboutDialog.addCreditSection` to add them.
///
/// The Acknowledgements page can be used to acknowledge additional people and
/// organizations for their non-development contributions. Use
/// `AboutDialog.addAcknowledgementSection` to add sections to it. For
/// example, it can be used to list backers in a crowdfunded project or to give
/// special thanks.
///
/// Each of the people or organizations can have an email address or a website
/// specified. To add a email address, use a string like
/// `Edgar Allan Poe <edgar`poe`.com>`. To specify a website with a title, use a
/// string like `The GNOME Project https://www.gnome.org`:
///
/// <picture>
///   <source srcset="about-dialog-credits-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="about-dialog-credits.png" alt="about-dialog-credits">
/// </picture>
///
/// ## Legal
///
/// The Legal page displays the copyright and licensing information for the
/// application and other modules.
///
/// The copyright string is set with the `AboutDialog.properties.copyright`
/// property and should be a short string of one or two lines, for example:
/// `© 2022 Example`.
///
/// Licensing information can be quickly set from a list of known licenses with
/// the `AboutDialog.properties.license_type` property. If the application's
/// license is not in the list, `AboutDialog.properties.license` can be used
/// instead.
///
/// To add information about other modules, such as application dependencies or
/// data, use `AboutDialog.addLegalSection`.
///
/// ## Other applications
///
/// `AdwAboutDialog` can show links to your other apps at the end of the main
/// page. To add them, use `AboutDialog.addOtherApp`.
///
/// ## Constructing
///
/// To make constructing an `AdwAboutDialog` as convenient as possible, you can
/// use the function `showAboutDialog` which constructs and shows a
/// dialog.
///
/// ```c
/// static void
/// show_about (GtkApplication *app)
/// {
///   const char *developers[] = {
///     "Angela Avery",
///     NULL
///   };
///
///   const char *designers[] = {
///     "GNOME Design Team",
///     NULL
///   };
///
///   adw_show_about_dialog (GTK_WIDGET (gtk_application_get_active_window (app)),
///                          "application-name", _("Example"),
///                          "application-icon", "org.example.App",
///                          "version", "1.2.3",
///                          "copyright", "© 2022 Angela Avery",
///                          "issue-url", "https://gitlab.gnome.org/example/example/-/issues/",
///                          "license-type", GTK_LICENSE_GPL_3_0,
///                          "developers", developers,
///                          "designers", designers,
///                          "translator-credits", _("translator-credits"),
///                          NULL);
/// }
/// ```
///
/// ## CSS nodes
///
/// `AdwAboutDialog` has a main CSS node with the name `dialog` and the
/// style class `.about`.
pub const AboutDialog = opaque {
    pub const Parent = adw.Dialog;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.ShortcutManager };
    pub const Class = adw.AboutDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The name of the application icon.
        ///
        /// The icon is displayed at the top of the main page.
        pub const application_icon = struct {
            pub const name = "application-icon";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the application.
        ///
        /// The name is displayed at the top of the main page.
        pub const application_name = struct {
            pub const name = "application-name";

            pub const Type = ?[*:0]u8;
        };

        /// The list of artists of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutDialog.properties.developers`
        /// * `AboutDialog.properties.designers`
        /// * `AboutDialog.properties.documenters`
        /// * `AboutDialog.properties.translator_credits`
        /// * `AboutDialog.addCreditSection`
        /// * `AboutDialog.addAcknowledgementSection`
        pub const artists = struct {
            pub const name = "artists";

            pub const Type = ?[*][*:0]u8;
        };

        /// The comments about the application.
        ///
        /// Comments will be shown on the Details page, above links.
        ///
        /// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
        /// detailed. It can also contain links and Pango markup.
        pub const comments = struct {
            pub const name = "comments";

            pub const Type = ?[*:0]u8;
        };

        /// The copyright information.
        ///
        /// This should be a short string of one or two lines, for example:
        /// `© 2022 Example`.
        ///
        /// The copyright information will be displayed on the Legal page, above the
        /// application license.
        ///
        /// `AboutDialog.addLegalSection` can be used to add copyright
        /// information for the application dependencies or other components.
        pub const copyright = struct {
            pub const name = "copyright";

            pub const Type = ?[*:0]u8;
        };

        /// The debug information.
        ///
        /// Debug information will be shown on the Troubleshooting page. It's intended
        /// to be attached to issue reports when reporting issues against the
        /// application.
        ///
        /// `AdwAboutDialog` provides a quick way to save debug information to a file.
        /// When saving, `AboutDialog.properties.debug_info_filename` would be used as
        /// the suggested filename.
        ///
        /// Debug information cannot contain markup or links.
        pub const debug_info = struct {
            pub const name = "debug-info";

            pub const Type = ?[*:0]u8;
        };

        /// The debug information filename.
        ///
        /// It will be used as the suggested filename when saving debug information to
        /// a file.
        ///
        /// See `AboutDialog.properties.debug_info`.
        pub const debug_info_filename = struct {
            pub const name = "debug-info-filename";

            pub const Type = ?[*:0]u8;
        };

        /// The list of designers of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutDialog.properties.developers`
        /// * `AboutDialog.properties.artists`
        /// * `AboutDialog.properties.documenters`
        /// * `AboutDialog.properties.translator_credits`
        /// * `AboutDialog.addCreditSection`
        /// * `AboutDialog.addAcknowledgementSection`
        pub const designers = struct {
            pub const name = "designers";

            pub const Type = ?[*][*:0]u8;
        };

        /// The developer name.
        ///
        /// The developer name is displayed on the main page, under the application
        /// name.
        ///
        /// If the application is developed by multiple people, the developer name can
        /// be set to values like "AppName team", "AppName developers" or
        /// "The AppName project", and the individual contributors can be listed on the
        /// Credits page, with `AboutDialog.properties.developers` and related
        /// properties.
        pub const developer_name = struct {
            pub const name = "developer-name";

            pub const Type = ?[*:0]u8;
        };

        /// The list of developers of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutDialog.properties.designers`
        /// * `AboutDialog.properties.artists`
        /// * `AboutDialog.properties.documenters`
        /// * `AboutDialog.properties.translator_credits`
        /// * `AboutDialog.addCreditSection`
        /// * `AboutDialog.addAcknowledgementSection`
        pub const developers = struct {
            pub const name = "developers";

            pub const Type = ?[*][*:0]u8;
        };

        /// The list of documenters of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutDialog.properties.developers`
        /// * `AboutDialog.properties.designers`
        /// * `AboutDialog.properties.artists`
        /// * `AboutDialog.properties.translator_credits`
        /// * `AboutDialog.addCreditSection`
        /// * `AboutDialog.addAcknowledgementSection`
        pub const documenters = struct {
            pub const name = "documenters";

            pub const Type = ?[*][*:0]u8;
        };

        /// The URL for the application's issue tracker.
        ///
        /// The issue tracker link is displayed on the main page.
        pub const issue_url = struct {
            pub const name = "issue-url";

            pub const Type = ?[*:0]u8;
        };

        /// The license text.
        ///
        /// This can be used to set a custom text for the license if it can't be set
        /// via `AboutDialog.properties.license_type`.
        ///
        /// When set, `AboutDialog.properties.license_type` will be set to
        /// `GTK_LICENSE_CUSTOM`.
        ///
        /// The license text will be displayed on the Legal page, below the copyright
        /// information.
        ///
        /// License text can contain Pango markup and links.
        ///
        /// `AboutDialog.addLegalSection` can be used to add license
        /// information for the application dependencies or other components.
        pub const license = struct {
            pub const name = "license";

            pub const Type = ?[*:0]u8;
        };

        /// The license type.
        ///
        /// Allows to set the application's license froma list of known licenses.
        ///
        /// If the application's license is not in the list,
        /// `AboutDialog.properties.license` can be used instead. The license type will
        /// be automatically set to `GTK_LICENSE_CUSTOM` in that case.
        ///
        /// If set to `GTK_LICENSE_UNKNOWN`, no information will be displayed.
        ///
        /// If the license type is different from `GTK_LICENSE_CUSTOM`.
        /// `AboutDialog.properties.license` will be cleared out.
        ///
        /// The license description will be displayed on the Legal page, below the
        /// copyright information.
        ///
        /// `AboutDialog.addLegalSection` can be used to add license
        /// information for the application dependencies or other components.
        pub const license_type = struct {
            pub const name = "license-type";

            pub const Type = gtk.License;
        };

        /// The release notes of the application.
        ///
        /// Release notes are displayed on the the What's New page.
        ///
        /// Release notes are formatted the same way as
        /// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
        ///
        /// The supported formatting options are:
        ///
        /// * Paragraph (`<p>`)
        /// * Ordered list (`<ol>`), with list items (`<li>`)
        /// * Unordered list (`<ul>`), with list items (`<li>`)
        ///
        /// Within paragraphs and list items, emphasis (`<em>`) and inline code
        /// (`<code>`) text styles are supported. The emphasis is rendered in italic,
        /// while inline code is shown in a monospaced font.
        ///
        /// Any text outside paragraphs or list items is ignored.
        ///
        /// Nested lists are not supported.
        ///
        /// `AdwAboutDialog` displays the version above the release notes. If set, the
        /// `AboutDialog.properties.release_notes_version` of the property will be used
        /// as the version; otherwise, `AboutDialog.properties.version` is used.
        pub const release_notes = struct {
            pub const name = "release-notes";

            pub const Type = ?[*:0]u8;
        };

        /// The version described by the application's release notes.
        ///
        /// The release notes version is displayed on the What's New page, above the
        /// release notes.
        ///
        /// If not set, `AboutDialog.properties.version` will be used instead.
        ///
        /// For example, an application with the current version 2.0.2 might want to
        /// keep the release notes from 2.0.0, and set the release notes version
        /// accordingly.
        ///
        /// See `AboutDialog.properties.release_notes`.
        pub const release_notes_version = struct {
            pub const name = "release-notes-version";

            pub const Type = ?[*:0]u8;
        };

        /// The URL of the application's support page.
        ///
        /// The support page link is displayed on the main page.
        pub const support_url = struct {
            pub const name = "support-url";

            pub const Type = ?[*:0]u8;
        };

        /// The translator credits string.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// This string should be `"translator-credits"` or `"translator_credits"` and
        /// should be marked as translatable.
        ///
        /// The string may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutDialog.properties.developers`
        /// * `AboutDialog.properties.designers`
        /// * `AboutDialog.properties.artists`
        /// * `AboutDialog.properties.documenters`
        /// * `AboutDialog.addCreditSection`
        /// * `AboutDialog.addAcknowledgementSection`
        pub const translator_credits = struct {
            pub const name = "translator-credits";

            pub const Type = ?[*:0]u8;
        };

        /// The version of the application.
        ///
        /// The version is displayed on the main page.
        ///
        /// If `AboutDialog.properties.release_notes_version` is not set, the version
        /// will also be displayed above the release notes on the What's New page.
        pub const version = struct {
            pub const name = "version";

            pub const Type = ?[*:0]u8;
        };

        /// The URL of the application's website.
        ///
        /// Website is displayed on the Details page, below comments, or on the main
        /// page if the Details page doesn't have any other content.
        ///
        /// Applications can add other links below, see `AboutDialog.addLink`.
        pub const website = struct {
            pub const name = "website";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a URL is activated.
        ///
        /// Applications may connect to it to override the default behavior, which is
        /// to call `gtk.showUri`.
        pub const activate_link = struct {
            pub const name = "activate-link";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_uri: [*:0]u8, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(AboutDialog, p_instance))),
                    gobject.signalLookup("activate-link", AboutDialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwAboutDialog`.
    extern fn adw_about_dialog_new() *adw.AboutDialog;
    pub const new = adw_about_dialog_new;

    /// Creates a new `AdwAboutDialog` using AppStream metadata.
    ///
    /// This automatically sets the following properties with the following AppStream
    /// values:
    ///
    /// * `AboutDialog.properties.application_icon` is set from the `<id>`
    /// * `AboutDialog.properties.application_name` is set from the `<name>`
    /// * `AboutDialog.properties.developer_name` is set from the `<name>` within
    ///      `<developer>`
    /// * `AboutDialog.properties.version` is set from the version of the latest release
    /// * `AboutDialog.properties.website` is set from the `<url type="homepage">`
    /// * `AboutDialog.properties.support_url` is set from the `<url type="help">`
    /// * `AboutDialog.properties.issue_url` is set from the `<url type="bugtracker">`
    /// * `AboutDialog.properties.license_type` is set from the `<project_license>`.
    ///     If the license type retrieved from AppStream is not listed in
    ///     `gtk.License`, it will be set to `GTK_LICENCE_CUSTOM`.
    ///
    /// If `release_notes_version` is not `NULL`,
    /// `AboutDialog.properties.release_notes_version` is set to match it, while
    /// `AboutDialog.properties.release_notes` is set from the AppStream release
    /// description for that version.
    extern fn adw_about_dialog_new_from_appdata(p_resource_path: [*:0]const u8, p_release_notes_version: ?[*:0]const u8) *adw.AboutDialog;
    pub const newFromAppdata = adw_about_dialog_new_from_appdata;

    /// Adds a section to the Acknowledgements page.
    ///
    /// This can be used to acknowledge additional people and organizations for their
    /// non-development contributions - for example, backers in a crowdfunded
    /// project.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addCreditSection`
    extern fn adw_about_dialog_add_acknowledgement_section(p_self: *AboutDialog, p_name: ?[*:0]const u8, p_people: [*][*:0]const u8) void;
    pub const addAcknowledgementSection = adw_about_dialog_add_acknowledgement_section;

    /// Adds an extra section to the Credits page.
    ///
    /// Extra sections are displayed below the standard categories.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_add_credit_section(p_self: *AboutDialog, p_name: ?[*:0]const u8, p_people: [*][*:0]const u8) void;
    pub const addCreditSection = adw_about_dialog_add_credit_section;

    /// Adds an extra section to the Legal page.
    ///
    /// Extra sections will be displayed below the application's own information.
    ///
    /// The parameters `copyright`, `license_type` and `license` will be used to present
    /// the it the same way as `AboutDialog.properties.copyright`,
    /// `AboutDialog.properties.license_type` and `AboutDialog.properties.license` are
    /// for the application's own information.
    ///
    /// See those properties for more details.
    ///
    /// This can be useful to attribute the application dependencies or data.
    ///
    /// Examples:
    ///
    /// ```c
    /// adw_about_dialog_add_legal_section (ADW_ABOUT_DIALOG (about),
    ///                                     _("Copyright and a known license"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_LGPL_2_1,
    ///                                     NULL);
    ///
    /// adw_about_dialog_add_legal_section (ADW_ABOUT_DIALOG (about),
    ///                                     _("Copyright and custom license"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_CUSTOM,
    ///                                     "Custom license text");
    ///
    /// adw_about_dialog_add_legal_section (ADW_ABOUT_DIALOG (about),
    ///                                     _("Copyright only"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_UNKNOWN,
    ///                                     NULL);
    ///
    /// adw_about_dialog_add_legal_section (ADW_ABOUT_DIALOG (about),
    ///                                     _("Custom license only"),
    ///                                     NULL,
    ///                                     GTK_LICENSE_CUSTOM,
    ///                                     "Something completely custom here.");
    /// ```
    extern fn adw_about_dialog_add_legal_section(p_self: *AboutDialog, p_title: [*:0]const u8, p_copyright: ?[*:0]const u8, p_license_type: gtk.License, p_license: ?[*:0]const u8) void;
    pub const addLegalSection = adw_about_dialog_add_legal_section;

    /// Adds an extra link to the Details page.
    ///
    /// Extra links are displayed under the comment and website.
    ///
    /// Underlines in `title` will be interpreted as indicating a mnemonic.
    ///
    /// See `AboutDialog.properties.website`.
    extern fn adw_about_dialog_add_link(p_self: *AboutDialog, p_title: [*:0]const u8, p_url: [*:0]const u8) void;
    pub const addLink = adw_about_dialog_add_link;

    /// Adds another application to `self`.
    ///
    /// The application will be displayed at the bottom of the main page, in a
    /// separate section. Each added application will be presented as a row with
    /// `title` and `summary`, as well as an icon with the name `appid`. Clicking the
    /// row will show `appid` in the software center app.
    ///
    /// This can be used to link to your other applications if you have multiple.
    ///
    /// Example:
    ///
    /// ```c
    /// adw_about_dialog_add_other_app (ADW_ABOUT_DIALOG (about),
    ///                                 "org.gnome.Boxes",
    ///                                 _("Boxes"),
    ///                                 _("Virtualization made simple"));
    /// ```
    extern fn adw_about_dialog_add_other_app(p_self: *AboutDialog, p_appid: [*:0]const u8, p_name: [*:0]const u8, p_summary: [*:0]const u8) void;
    pub const addOtherApp = adw_about_dialog_add_other_app;

    /// Gets the name of the application icon for `self`.
    extern fn adw_about_dialog_get_application_icon(p_self: *AboutDialog) [*:0]const u8;
    pub const getApplicationIcon = adw_about_dialog_get_application_icon;

    /// Gets the application name for `self`.
    extern fn adw_about_dialog_get_application_name(p_self: *AboutDialog) [*:0]const u8;
    pub const getApplicationName = adw_about_dialog_get_application_name;

    /// Gets the list of artists of the application.
    extern fn adw_about_dialog_get_artists(p_self: *AboutDialog) ?[*]const [*:0]const u8;
    pub const getArtists = adw_about_dialog_get_artists;

    /// Gets the comments about the application.
    extern fn adw_about_dialog_get_comments(p_self: *AboutDialog) [*:0]const u8;
    pub const getComments = adw_about_dialog_get_comments;

    /// Gets the copyright information for `self`.
    extern fn adw_about_dialog_get_copyright(p_self: *AboutDialog) [*:0]const u8;
    pub const getCopyright = adw_about_dialog_get_copyright;

    /// Gets the debug information for `self`.
    extern fn adw_about_dialog_get_debug_info(p_self: *AboutDialog) [*:0]const u8;
    pub const getDebugInfo = adw_about_dialog_get_debug_info;

    /// Gets the debug information filename for `self`.
    extern fn adw_about_dialog_get_debug_info_filename(p_self: *AboutDialog) [*:0]const u8;
    pub const getDebugInfoFilename = adw_about_dialog_get_debug_info_filename;

    /// Gets the list of designers of the application.
    extern fn adw_about_dialog_get_designers(p_self: *AboutDialog) ?[*]const [*:0]const u8;
    pub const getDesigners = adw_about_dialog_get_designers;

    /// Gets the developer name for `self`.
    extern fn adw_about_dialog_get_developer_name(p_self: *AboutDialog) [*:0]const u8;
    pub const getDeveloperName = adw_about_dialog_get_developer_name;

    /// Gets the list of developers of the application.
    extern fn adw_about_dialog_get_developers(p_self: *AboutDialog) ?[*]const [*:0]const u8;
    pub const getDevelopers = adw_about_dialog_get_developers;

    /// Gets the list of documenters of the application.
    extern fn adw_about_dialog_get_documenters(p_self: *AboutDialog) ?[*]const [*:0]const u8;
    pub const getDocumenters = adw_about_dialog_get_documenters;

    /// Gets the issue tracker URL for `self`.
    extern fn adw_about_dialog_get_issue_url(p_self: *AboutDialog) [*:0]const u8;
    pub const getIssueUrl = adw_about_dialog_get_issue_url;

    /// Gets the license for `self`.
    extern fn adw_about_dialog_get_license(p_self: *AboutDialog) [*:0]const u8;
    pub const getLicense = adw_about_dialog_get_license;

    /// Gets the license type for `self`.
    extern fn adw_about_dialog_get_license_type(p_self: *AboutDialog) gtk.License;
    pub const getLicenseType = adw_about_dialog_get_license_type;

    /// Gets the release notes for `self`.
    extern fn adw_about_dialog_get_release_notes(p_self: *AboutDialog) [*:0]const u8;
    pub const getReleaseNotes = adw_about_dialog_get_release_notes;

    /// Gets the version described by the application's release notes.
    extern fn adw_about_dialog_get_release_notes_version(p_self: *AboutDialog) [*:0]const u8;
    pub const getReleaseNotesVersion = adw_about_dialog_get_release_notes_version;

    /// Gets the URL of the support page for `self`.
    extern fn adw_about_dialog_get_support_url(p_self: *AboutDialog) [*:0]const u8;
    pub const getSupportUrl = adw_about_dialog_get_support_url;

    /// Gets the translator credits string.
    extern fn adw_about_dialog_get_translator_credits(p_self: *AboutDialog) [*:0]const u8;
    pub const getTranslatorCredits = adw_about_dialog_get_translator_credits;

    /// Gets the version for `self`.
    extern fn adw_about_dialog_get_version(p_self: *AboutDialog) [*:0]const u8;
    pub const getVersion = adw_about_dialog_get_version;

    /// Gets the application website URL for `self`.
    extern fn adw_about_dialog_get_website(p_self: *AboutDialog) [*:0]const u8;
    pub const getWebsite = adw_about_dialog_get_website;

    /// Sets the name of the application icon for `self`.
    ///
    /// The icon is displayed at the top of the main page.
    extern fn adw_about_dialog_set_application_icon(p_self: *AboutDialog, p_application_icon: [*:0]const u8) void;
    pub const setApplicationIcon = adw_about_dialog_set_application_icon;

    /// Sets the application name for `self`.
    ///
    /// The name is displayed at the top of the main page.
    extern fn adw_about_dialog_set_application_name(p_self: *AboutDialog, p_application_name: [*:0]const u8) void;
    pub const setApplicationName = adw_about_dialog_set_application_name;

    /// Sets the list of artists of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addCreditSection`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_set_artists(p_self: *AboutDialog, p_artists: ?[*][*:0]const u8) void;
    pub const setArtists = adw_about_dialog_set_artists;

    /// Sets the comments about the application.
    ///
    /// Comments will be shown on the Details page, above links.
    ///
    /// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
    /// detailed. It can also contain links and Pango markup.
    extern fn adw_about_dialog_set_comments(p_self: *AboutDialog, p_comments: [*:0]const u8) void;
    pub const setComments = adw_about_dialog_set_comments;

    /// Sets the copyright information for `self`.
    ///
    /// This should be a short string of one or two lines, for example:
    /// `© 2022 Example`.
    ///
    /// The copyright information will be displayed on the Legal page, before the
    /// application license.
    ///
    /// `AboutDialog.addLegalSection` can be used to add copyright
    /// information for the application dependencies or other components.
    extern fn adw_about_dialog_set_copyright(p_self: *AboutDialog, p_copyright: [*:0]const u8) void;
    pub const setCopyright = adw_about_dialog_set_copyright;

    /// Sets the debug information for `self`.
    ///
    /// Debug information will be shown on the Troubleshooting page. It's intended
    /// to be attached to issue reports when reporting issues against the
    /// application.
    ///
    /// `AdwAboutDialog` provides a quick way to save debug information to a file.
    /// When saving, `AboutDialog.properties.debug_info_filename` would be used as
    /// the suggested filename.
    ///
    /// Debug information cannot contain markup or links.
    extern fn adw_about_dialog_set_debug_info(p_self: *AboutDialog, p_debug_info: [*:0]const u8) void;
    pub const setDebugInfo = adw_about_dialog_set_debug_info;

    /// Sets the debug information filename for `self`.
    ///
    /// It will be used as the suggested filename when saving debug information to a
    /// file.
    ///
    /// See `AboutDialog.properties.debug_info`.
    extern fn adw_about_dialog_set_debug_info_filename(p_self: *AboutDialog, p_filename: [*:0]const u8) void;
    pub const setDebugInfoFilename = adw_about_dialog_set_debug_info_filename;

    /// Sets the list of designers of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addCreditSection`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_set_designers(p_self: *AboutDialog, p_designers: ?[*][*:0]const u8) void;
    pub const setDesigners = adw_about_dialog_set_designers;

    /// Sets the developer name for `self`.
    ///
    /// The developer name is displayed on the main page, under the application name.
    ///
    /// If the application is developed by multiple people, the developer name can be
    /// set to values like "AppName team", "AppName developers" or
    /// "The AppName project", and the individual contributors can be listed on the
    /// Credits page, with `AboutDialog.properties.developers` and related properties.
    extern fn adw_about_dialog_set_developer_name(p_self: *AboutDialog, p_developer_name: [*:0]const u8) void;
    pub const setDeveloperName = adw_about_dialog_set_developer_name;

    /// Sets the list of developers of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addCreditSection`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_set_developers(p_self: *AboutDialog, p_developers: ?[*][*:0]const u8) void;
    pub const setDevelopers = adw_about_dialog_set_developers;

    /// Sets the list of documenters of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.translator_credits`
    /// * `AboutDialog.addCreditSection`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_set_documenters(p_self: *AboutDialog, p_documenters: ?[*][*:0]const u8) void;
    pub const setDocumenters = adw_about_dialog_set_documenters;

    /// Sets the issue tracker URL for `self`.
    ///
    /// The issue tracker link is displayed on the main page.
    extern fn adw_about_dialog_set_issue_url(p_self: *AboutDialog, p_issue_url: [*:0]const u8) void;
    pub const setIssueUrl = adw_about_dialog_set_issue_url;

    /// Sets the license for `self`.
    ///
    /// This can be used to set a custom text for the license if it can't be set via
    /// `AboutDialog.properties.license_type`.
    ///
    /// When set, `AboutDialog.properties.license_type` will be set to
    /// `GTK_LICENSE_CUSTOM`.
    ///
    /// The license text will be displayed on the Legal page, below the copyright
    /// information.
    ///
    /// License text can contain Pango markup and links.
    ///
    /// `AboutDialog.addLegalSection` can be used to add license information
    /// for the application dependencies or other components.
    extern fn adw_about_dialog_set_license(p_self: *AboutDialog, p_license: [*:0]const u8) void;
    pub const setLicense = adw_about_dialog_set_license;

    /// Sets the license for `self` from a list of known licenses.
    ///
    /// If the application's license is not in the list,
    /// `AboutDialog.properties.license` can be used instead. The license type will be
    /// automatically set to `GTK_LICENSE_CUSTOM` in that case.
    ///
    /// If `license_type` is `GTK_LICENSE_UNKNOWN`, no information will be displayed.
    ///
    /// If `license_type` is different from `GTK_LICENSE_CUSTOM`.
    /// `AboutDialog.properties.license` will be cleared out.
    ///
    /// The license description will be displayed on the Legal page, below the
    /// copyright information.
    ///
    /// `AboutDialog.addLegalSection` can be used to add license information
    /// for the application dependencies or other components.
    extern fn adw_about_dialog_set_license_type(p_self: *AboutDialog, p_license_type: gtk.License) void;
    pub const setLicenseType = adw_about_dialog_set_license_type;

    /// Sets the release notes for `self`.
    ///
    /// Release notes are displayed on the the What's New page.
    ///
    /// Release notes are formatted the same way as
    /// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
    ///
    /// The supported formatting options are:
    ///
    /// * Paragraph (`<p>`)
    /// * Ordered list (`<ol>`), with list items (`<li>`)
    /// * Unordered list (`<ul>`), with list items (`<li>`)
    ///
    /// Within paragraphs and list items, emphasis (`<em>`) and inline code
    /// (`<code>`) text styles are supported. The emphasis is rendered in italic,
    /// while inline code is shown in a monospaced font.
    ///
    /// Any text outside paragraphs or list items is ignored.
    ///
    /// Nested lists are not supported.
    ///
    /// `AdwAboutDialog` displays the version above the release notes. If set, the
    /// `AboutDialog.properties.release_notes_version` of the property will be used
    /// as the version; otherwise, `AboutDialog.properties.version` is used.
    extern fn adw_about_dialog_set_release_notes(p_self: *AboutDialog, p_release_notes: [*:0]const u8) void;
    pub const setReleaseNotes = adw_about_dialog_set_release_notes;

    /// Sets the version described by the application's release notes.
    ///
    /// The release notes version is displayed on the What's New page, above the
    /// release notes.
    ///
    /// If not set, `AboutDialog.properties.version` will be used instead.
    ///
    /// For example, an application with the current version 2.0.2 might want to
    /// keep the release notes from 2.0.0, and set the release notes version
    /// accordingly.
    ///
    /// See `AboutDialog.properties.release_notes`.
    extern fn adw_about_dialog_set_release_notes_version(p_self: *AboutDialog, p_version: [*:0]const u8) void;
    pub const setReleaseNotesVersion = adw_about_dialog_set_release_notes_version;

    /// Sets the URL of the support page for `self`.
    ///
    /// The support page link is displayed on the main page.
    extern fn adw_about_dialog_set_support_url(p_self: *AboutDialog, p_support_url: [*:0]const u8) void;
    pub const setSupportUrl = adw_about_dialog_set_support_url;

    /// Sets the translator credits string.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// This string should be `"translator-credits"` or `"translator_credits"` and
    /// should be marked as translatable.
    ///
    /// The string may contain email addresses and URLs, see the introduction for
    /// more details. When there is more than one translator, they must be
    /// separated by a newline in the same string.
    ///
    /// See also:
    ///
    /// * `AboutDialog.properties.developers`
    /// * `AboutDialog.properties.designers`
    /// * `AboutDialog.properties.artists`
    /// * `AboutDialog.properties.documenters`
    /// * `AboutDialog.addCreditSection`
    /// * `AboutDialog.addAcknowledgementSection`
    extern fn adw_about_dialog_set_translator_credits(p_self: *AboutDialog, p_translator_credits: [*:0]const u8) void;
    pub const setTranslatorCredits = adw_about_dialog_set_translator_credits;

    /// Sets the version for `self`.
    ///
    /// The version is displayed on the main page.
    ///
    /// If `AboutDialog.properties.release_notes_version` is not set, the version will
    /// also be displayed above the release notes on the What's New page.
    extern fn adw_about_dialog_set_version(p_self: *AboutDialog, p_version: [*:0]const u8) void;
    pub const setVersion = adw_about_dialog_set_version;

    /// Sets the application website URL for `self`.
    ///
    /// Website is displayed on the Details page, below comments, or on the main page
    /// if the Details page doesn't have any other content.
    ///
    /// Applications can add other links below, see `AboutDialog.addLink`.
    extern fn adw_about_dialog_set_website(p_self: *AboutDialog, p_website: [*:0]const u8) void;
    pub const setWebsite = adw_about_dialog_set_website;

    extern fn adw_about_dialog_get_type() usize;
    pub const getGObjectType = adw_about_dialog_get_type;

    extern fn g_object_ref(p_self: *adw.AboutDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.AboutDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AboutDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A window showing information about the application.
///
/// <picture>
///   <source srcset="about-window-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="about-window.png" alt="about-window">
/// </picture>
///
/// An about window is typically opened when the user activates the `About …`
/// item in the application's primary menu. All parts of the window are optional.
///
/// ## Main page
///
/// `AdwAboutWindow` prominently displays the application's icon, name, developer
/// name and version. They can be set with the `AboutWindow.properties.application_icon`,
/// `AboutWindow.properties.application_name`,
/// `AboutWindow.properties.developer_name` and `AboutWindow.properties.version`
/// respectively.
///
/// ## What's New
///
/// `AdwAboutWindow` provides a way for applications to display their release
/// notes, set with the `AboutWindow.properties.release_notes` property.
///
/// Release notes are formatted the same way as
/// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
///
/// The supported formatting options are:
///
/// * Paragraph (`<p>`)
/// * Ordered list (`<ol>`), with list items (`<li>`)
/// * Unordered list (`<ul>`), with list items (`<li>`)
///
/// Within paragraphs and list items, emphasis (`<em>`) and inline code
/// (`<code>`) text styles are supported. The emphasis is rendered in italic,
/// while inline code is shown in a monospaced font.
///
/// Any text outside paragraphs or list items is ignored.
///
/// Nested lists are not supported.
///
/// Only one version can be shown at a time. By default, the displayed version
/// number matches `AboutWindow.properties.version`. Use
/// `AboutWindow.properties.release_notes_version` to override it.
///
/// ## Details
///
/// The Details page displays the application comments and links.
///
/// The comments can be set with the `AboutWindow.properties.comments` property.
/// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
/// detailed. It can also contain links and Pango markup.
///
/// To set the application website, use `AboutWindow.properties.website`.
/// To add extra links below the website, use `AboutWindow.addLink`.
///
/// If the Details page doesn't have any other content besides website, the
/// website will be displayed on the main page instead.
///
/// ## Troubleshooting
///
/// `AdwAboutWindow` displays the following two links on the main page:
///
/// * Support Questions, set with the `AboutWindow.properties.support_url` property,
/// * Report an Issue, set with the `AboutWindow.properties.issue_url` property.
///
/// Additionally, applications can provide debugging information. It will be
/// shown separately on the Troubleshooting page. Use the
/// `AboutWindow.properties.debug_info` property to specify it.
///
/// It's intended to be attached to issue reports when reporting issues against
/// the application. As such, it cannot contain markup or links.
///
/// `AdwAboutWindow` provides a quick way to save debug information to a file.
/// When saving, `AboutWindow.properties.debug_info_filename` would be used as
/// the suggested filename.
///
/// ## Credits and Acknowledgements
///
/// The Credits page has the following default sections:
///
/// * Developers, set with the `AboutWindow.properties.developers` property,
/// * Designers, set with the `AboutWindow.properties.designers` property,
/// * Artists, set with the `AboutWindow.properties.artists` property,
/// * Documenters, set with the `AboutWindow.properties.documenters` property,
/// * Translators, set with the `AboutWindow.properties.translator_credits` property.
///
/// When setting translator credits, use the strings `"translator-credits"` or
/// `"translator_credits"` and mark them as translatable.
///
/// The default sections that don't contain any names won't be displayed.
///
/// The Credits page can also contain an arbitrary number of extra sections below
/// the default ones. Use `AboutWindow.addCreditSection` to add them.
///
/// The Acknowledgements page can be used to acknowledge additional people and
/// organizations for their non-development contributions. Use
/// `AboutWindow.addAcknowledgementSection` to add sections to it. For
/// example, it can be used to list backers in a crowdfunded project or to give
/// special thanks.
///
/// Each of the people or organizations can have an email address or a website
/// specified. To add a email address, use a string like
/// `Edgar Allan Poe <edgar`poe`.com>`. To specify a website with a title, use a
/// string like `The GNOME Project https://www.gnome.org`:
///
/// <picture>
///   <source srcset="about-window-credits-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="about-window-credits.png" alt="about-window-credits">
/// </picture>
///
/// ## Legal
///
/// The Legal page displays the copyright and licensing information for the
/// application and other modules.
///
/// The copyright string is set with the `AboutWindow.properties.copyright`
/// property and should be a short string of one or two lines, for example:
/// `© 2022 Example`.
///
/// Licensing information can be quickly set from a list of known licenses with
/// the `AboutWindow.properties.license_type` property. If the application's
/// license is not in the list, `AboutWindow.properties.license` can be used
/// instead.
///
/// To add information about other modules, such as application dependencies or
/// data, use `AboutWindow.addLegalSection`.
///
/// ## Constructing
///
/// To make constructing an `AdwAboutWindow` as convenient as possible, you can
/// use the function `showAboutWindow` which constructs and shows a
/// window.
///
/// ```c
/// static void
/// show_about (GtkApplication *app)
/// {
///   const char *developers[] = {
///     "Angela Avery",
///     NULL
///   };
///
///   const char *designers[] = {
///     "GNOME Design Team",
///     NULL
///   };
///
///   adw_show_about_window (gtk_application_get_active_window (app),
///                          "application-name", _("Example"),
///                          "application-icon", "org.example.App",
///                          "version", "1.2.3",
///                          "copyright", "© 2022 Angela Avery",
///                          "issue-url", "https://gitlab.gnome.org/example/example/-/issues/",
///                          "license-type", GTK_LICENSE_GPL_3_0,
///                          "developers", developers,
///                          "designers", designers,
///                          "translator-credits", _("translator-credits"),
///                          NULL);
/// }
/// ```
///
/// ## CSS nodes
///
/// `AdwAboutWindow` has a main CSS node with the name `window` and the
/// style class `.about`.
pub const AboutWindow = opaque {
    pub const Parent = adw.Window;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = adw.AboutWindowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The name of the application icon.
        ///
        /// The icon is displayed at the top of the main page.
        pub const application_icon = struct {
            pub const name = "application-icon";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the application.
        ///
        /// The name is displayed at the top of the main page.
        pub const application_name = struct {
            pub const name = "application-name";

            pub const Type = ?[*:0]u8;
        };

        /// The list of artists of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutWindow.properties.developers`
        /// * `AboutWindow.properties.designers`
        /// * `AboutWindow.properties.documenters`
        /// * `AboutWindow.properties.translator_credits`
        /// * `AboutWindow.addCreditSection`
        /// * `AboutWindow.addAcknowledgementSection`
        pub const artists = struct {
            pub const name = "artists";

            pub const Type = ?[*][*:0]u8;
        };

        /// The comments about the application.
        ///
        /// Comments will be shown on the Details page, above links.
        ///
        /// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
        /// detailed. It can also contain links and Pango markup.
        pub const comments = struct {
            pub const name = "comments";

            pub const Type = ?[*:0]u8;
        };

        /// The copyright information.
        ///
        /// This should be a short string of one or two lines, for example:
        /// `© 2022 Example`.
        ///
        /// The copyright information will be displayed on the Legal page, above the
        /// application license.
        ///
        /// `AboutWindow.addLegalSection` can be used to add copyright
        /// information for the application dependencies or other components.
        pub const copyright = struct {
            pub const name = "copyright";

            pub const Type = ?[*:0]u8;
        };

        /// The debug information.
        ///
        /// Debug information will be shown on the Troubleshooting page. It's intended
        /// to be attached to issue reports when reporting issues against the
        /// application.
        ///
        /// `AdwAboutWindow` provides a quick way to save debug information to a file.
        /// When saving, `AboutWindow.properties.debug_info_filename` would be used as
        /// the suggested filename.
        ///
        /// Debug information cannot contain markup or links.
        pub const debug_info = struct {
            pub const name = "debug-info";

            pub const Type = ?[*:0]u8;
        };

        /// The debug information filename.
        ///
        /// It will be used as the suggested filename when saving debug information to
        /// a file.
        ///
        /// See `AboutWindow.properties.debug_info`.
        pub const debug_info_filename = struct {
            pub const name = "debug-info-filename";

            pub const Type = ?[*:0]u8;
        };

        /// The list of designers of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutWindow.properties.developers`
        /// * `AboutWindow.properties.artists`
        /// * `AboutWindow.properties.documenters`
        /// * `AboutWindow.properties.translator_credits`
        /// * `AboutWindow.addCreditSection`
        /// * `AboutWindow.addAcknowledgementSection`
        pub const designers = struct {
            pub const name = "designers";

            pub const Type = ?[*][*:0]u8;
        };

        /// The developer name.
        ///
        /// The developer name is displayed on the main page, under the application
        /// name.
        ///
        /// If the application is developed by multiple people, the developer name can
        /// be set to values like "AppName team", "AppName developers" or
        /// "The AppName project", and the individual contributors can be listed on the
        /// Credits page, with `AboutWindow.properties.developers` and related
        /// properties.
        pub const developer_name = struct {
            pub const name = "developer-name";

            pub const Type = ?[*:0]u8;
        };

        /// The list of developers of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutWindow.properties.designers`
        /// * `AboutWindow.properties.artists`
        /// * `AboutWindow.properties.documenters`
        /// * `AboutWindow.properties.translator_credits`
        /// * `AboutWindow.addCreditSection`
        /// * `AboutWindow.addAcknowledgementSection`
        pub const developers = struct {
            pub const name = "developers";

            pub const Type = ?[*][*:0]u8;
        };

        /// The list of documenters of the application.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// Each name may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutWindow.properties.developers`
        /// * `AboutWindow.properties.designers`
        /// * `AboutWindow.properties.artists`
        /// * `AboutWindow.properties.translator_credits`
        /// * `AboutWindow.addCreditSection`
        /// * `AboutWindow.addAcknowledgementSection`
        pub const documenters = struct {
            pub const name = "documenters";

            pub const Type = ?[*][*:0]u8;
        };

        /// The URL for the application's issue tracker.
        ///
        /// The issue tracker link is displayed on the main page.
        pub const issue_url = struct {
            pub const name = "issue-url";

            pub const Type = ?[*:0]u8;
        };

        /// The license text.
        ///
        /// This can be used to set a custom text for the license if it can't be set
        /// via `AboutWindow.properties.license_type`.
        ///
        /// When set, `AboutWindow.properties.license_type` will be set to
        /// `GTK_LICENSE_CUSTOM`.
        ///
        /// The license text will be displayed on the Legal page, below the copyright
        /// information.
        ///
        /// License text can contain Pango markup and links.
        ///
        /// `AboutWindow.addLegalSection` can be used to add license
        /// information for the application dependencies or other components.
        pub const license = struct {
            pub const name = "license";

            pub const Type = ?[*:0]u8;
        };

        /// The license type.
        ///
        /// Allows to set the application's license froma list of known licenses.
        ///
        /// If the application's license is not in the list,
        /// `AboutWindow.properties.license` can be used instead. The license type will
        /// be automatically set to `GTK_LICENSE_CUSTOM` in that case.
        ///
        /// If set to `GTK_LICENSE_UNKNOWN`, no information will be displayed.
        ///
        /// If the license type is different from `GTK_LICENSE_CUSTOM`.
        /// `AboutWindow.properties.license` will be cleared out.
        ///
        /// The license description will be displayed on the Legal page, below the
        /// copyright information.
        ///
        /// `AboutWindow.addLegalSection` can be used to add license
        /// information for the application dependencies or other components.
        pub const license_type = struct {
            pub const name = "license-type";

            pub const Type = gtk.License;
        };

        /// The release notes of the application.
        ///
        /// Release notes are displayed on the the What's New page.
        ///
        /// Release notes are formatted the same way as
        /// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
        ///
        /// The supported formatting options are:
        ///
        /// * Paragraph (`<p>`)
        /// * Ordered list (`<ol>`), with list items (`<li>`)
        /// * Unordered list (`<ul>`), with list items (`<li>`)
        ///
        /// Within paragraphs and list items, emphasis (`<em>`) and inline code
        /// (`<code>`) text styles are supported. The emphasis is rendered in italic,
        /// while inline code is shown in a monospaced font.
        ///
        /// Any text outside paragraphs or list items is ignored.
        ///
        /// Nested lists are not supported.
        ///
        /// `AdwAboutWindow` displays the version above the release notes. If set, the
        /// `AboutWindow.properties.release_notes_version` of the property will be used
        /// as the version; otherwise, `AboutWindow.properties.version` is used.
        pub const release_notes = struct {
            pub const name = "release-notes";

            pub const Type = ?[*:0]u8;
        };

        /// The version described by the application's release notes.
        ///
        /// The release notes version is displayed on the What's New page, above the
        /// release notes.
        ///
        /// If not set, `AboutWindow.properties.version` will be used instead.
        ///
        /// For example, an application with the current version 2.0.2 might want to
        /// keep the release notes from 2.0.0, and set the release notes version
        /// accordingly.
        ///
        /// See `AboutWindow.properties.release_notes`.
        pub const release_notes_version = struct {
            pub const name = "release-notes-version";

            pub const Type = ?[*:0]u8;
        };

        /// The URL of the application's support page.
        ///
        /// The support page link is displayed on the main page.
        pub const support_url = struct {
            pub const name = "support-url";

            pub const Type = ?[*:0]u8;
        };

        /// The translator credits string.
        ///
        /// It will be displayed on the Credits page.
        ///
        /// This string should be `"translator-credits"` or `"translator_credits"` and
        /// should be marked as translatable.
        ///
        /// The string may contain email addresses and URLs, see the introduction for
        /// more details.
        ///
        /// See also:
        ///
        /// * `AboutWindow.properties.developers`
        /// * `AboutWindow.properties.designers`
        /// * `AboutWindow.properties.artists`
        /// * `AboutWindow.properties.documenters`
        /// * `AboutWindow.addCreditSection`
        /// * `AboutWindow.addAcknowledgementSection`
        pub const translator_credits = struct {
            pub const name = "translator-credits";

            pub const Type = ?[*:0]u8;
        };

        /// The version of the application.
        ///
        /// The version is displayed on the main page.
        ///
        /// If `AboutWindow.properties.release_notes_version` is not set, the version
        /// will also be displayed above the release notes on the What's New page.
        pub const version = struct {
            pub const name = "version";

            pub const Type = ?[*:0]u8;
        };

        /// The URL of the application's website.
        ///
        /// Website is displayed on the Details page, below comments, or on the main
        /// page if the Details page doesn't have any other content.
        ///
        /// Applications can add other links below, see `AboutWindow.addLink`.
        pub const website = struct {
            pub const name = "website";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a URL is activated.
        ///
        /// Applications may connect to it to override the default behavior, which is
        /// to call `gtk.showUri`.
        pub const activate_link = struct {
            pub const name = "activate-link";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_uri: [*:0]u8, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(AboutWindow, p_instance))),
                    gobject.signalLookup("activate-link", AboutWindow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwAboutWindow`.
    extern fn adw_about_window_new() *adw.AboutWindow;
    pub const new = adw_about_window_new;

    /// Creates a new `AdwAboutWindow` using AppStream metadata.
    ///
    /// This automatically sets the following properties with the following AppStream
    /// values:
    ///
    /// * `AboutWindow.properties.application_icon` is set from the `<id>`
    /// * `AboutWindow.properties.application_name` is set from the `<name>`
    /// * `AboutWindow.properties.developer_name` is set from the `<name>` within
    ///      `<developer>`
    /// * `AboutWindow.properties.version` is set from the version of the latest release
    /// * `AboutWindow.properties.website` is set from the `<url type="homepage">`
    /// * `AboutWindow.properties.support_url` is set from the `<url type="help">`
    /// * `AboutWindow.properties.issue_url` is set from the `<url type="bugtracker">`
    /// * `AboutWindow.properties.license_type` is set from the `<project_license>`.
    ///     If the license type retrieved from AppStream is not listed in
    ///     `gtk.License`, it will be set to `GTK_LICENCE_CUSTOM`.
    ///
    /// If `release_notes_version` is not `NULL`,
    /// `AboutWindow.properties.release_notes_version` is set to match it, while
    /// `AboutWindow.properties.release_notes` is set from the AppStream release
    /// description for that version.
    extern fn adw_about_window_new_from_appdata(p_resource_path: [*:0]const u8, p_release_notes_version: ?[*:0]const u8) *adw.AboutWindow;
    pub const newFromAppdata = adw_about_window_new_from_appdata;

    /// Adds a section to the Acknowledgements page.
    ///
    /// This can be used to acknowledge additional people and organizations for their
    /// non-development contributions - for example, backers in a crowdfunded
    /// project.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addCreditSection`
    extern fn adw_about_window_add_acknowledgement_section(p_self: *AboutWindow, p_name: ?[*:0]const u8, p_people: [*][*:0]const u8) void;
    pub const addAcknowledgementSection = adw_about_window_add_acknowledgement_section;

    /// Adds an extra section to the Credits page.
    ///
    /// Extra sections are displayed below the standard categories.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_add_credit_section(p_self: *AboutWindow, p_name: ?[*:0]const u8, p_people: [*][*:0]const u8) void;
    pub const addCreditSection = adw_about_window_add_credit_section;

    /// Adds an extra section to the Legal page.
    ///
    /// Extra sections will be displayed below the application's own information.
    ///
    /// The parameters `copyright`, `license_type` and `license` will be used to present
    /// the it the same way as `AboutWindow.properties.copyright`,
    /// `AboutWindow.properties.license_type` and `AboutWindow.properties.license` are
    /// for the application's own information.
    ///
    /// See those properties for more details.
    ///
    /// This can be useful to attribute the application dependencies or data.
    ///
    /// Examples:
    ///
    /// ```c
    /// adw_about_window_add_legal_section (ADW_ABOUT_WINDOW (about),
    ///                                     _("Copyright and a known license"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_LGPL_2_1,
    ///                                     NULL);
    ///
    /// adw_about_window_add_legal_section (ADW_ABOUT_WINDOW (about),
    ///                                     _("Copyright and custom license"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_CUSTOM,
    ///                                     "Custom license text");
    ///
    /// adw_about_window_add_legal_section (ADW_ABOUT_WINDOW (about),
    ///                                     _("Copyright only"),
    ///                                     "© 2022 Example",
    ///                                     GTK_LICENSE_UNKNOWN,
    ///                                     NULL);
    ///
    /// adw_about_window_add_legal_section (ADW_ABOUT_WINDOW (about),
    ///                                     _("Custom license only"),
    ///                                     NULL,
    ///                                     GTK_LICENSE_CUSTOM,
    ///                                     "Something completely custom here.");
    /// ```
    extern fn adw_about_window_add_legal_section(p_self: *AboutWindow, p_title: [*:0]const u8, p_copyright: ?[*:0]const u8, p_license_type: gtk.License, p_license: ?[*:0]const u8) void;
    pub const addLegalSection = adw_about_window_add_legal_section;

    /// Adds an extra link to the Details page.
    ///
    /// Extra links are displayed under the comment and website.
    ///
    /// Underlines in `title` will be interpreted as indicating a mnemonic.
    ///
    /// See `AboutWindow.properties.website`.
    extern fn adw_about_window_add_link(p_self: *AboutWindow, p_title: [*:0]const u8, p_url: [*:0]const u8) void;
    pub const addLink = adw_about_window_add_link;

    /// Gets the name of the application icon for `self`.
    extern fn adw_about_window_get_application_icon(p_self: *AboutWindow) [*:0]const u8;
    pub const getApplicationIcon = adw_about_window_get_application_icon;

    /// Gets the application name for `self`.
    extern fn adw_about_window_get_application_name(p_self: *AboutWindow) [*:0]const u8;
    pub const getApplicationName = adw_about_window_get_application_name;

    /// Gets the list of artists of the application.
    extern fn adw_about_window_get_artists(p_self: *AboutWindow) ?[*]const [*:0]const u8;
    pub const getArtists = adw_about_window_get_artists;

    /// Gets the comments about the application.
    extern fn adw_about_window_get_comments(p_self: *AboutWindow) [*:0]const u8;
    pub const getComments = adw_about_window_get_comments;

    /// Gets the copyright information for `self`.
    extern fn adw_about_window_get_copyright(p_self: *AboutWindow) [*:0]const u8;
    pub const getCopyright = adw_about_window_get_copyright;

    /// Gets the debug information for `self`.
    extern fn adw_about_window_get_debug_info(p_self: *AboutWindow) [*:0]const u8;
    pub const getDebugInfo = adw_about_window_get_debug_info;

    /// Gets the debug information filename for `self`.
    extern fn adw_about_window_get_debug_info_filename(p_self: *AboutWindow) [*:0]const u8;
    pub const getDebugInfoFilename = adw_about_window_get_debug_info_filename;

    /// Gets the list of designers of the application.
    extern fn adw_about_window_get_designers(p_self: *AboutWindow) ?[*]const [*:0]const u8;
    pub const getDesigners = adw_about_window_get_designers;

    /// Gets the developer name for `self`.
    extern fn adw_about_window_get_developer_name(p_self: *AboutWindow) [*:0]const u8;
    pub const getDeveloperName = adw_about_window_get_developer_name;

    /// Gets the list of developers of the application.
    extern fn adw_about_window_get_developers(p_self: *AboutWindow) ?[*]const [*:0]const u8;
    pub const getDevelopers = adw_about_window_get_developers;

    /// Gets the list of documenters of the application.
    extern fn adw_about_window_get_documenters(p_self: *AboutWindow) ?[*]const [*:0]const u8;
    pub const getDocumenters = adw_about_window_get_documenters;

    /// Gets the issue tracker URL for `self`.
    extern fn adw_about_window_get_issue_url(p_self: *AboutWindow) [*:0]const u8;
    pub const getIssueUrl = adw_about_window_get_issue_url;

    /// Gets the license for `self`.
    extern fn adw_about_window_get_license(p_self: *AboutWindow) [*:0]const u8;
    pub const getLicense = adw_about_window_get_license;

    /// Gets the license type for `self`.
    extern fn adw_about_window_get_license_type(p_self: *AboutWindow) gtk.License;
    pub const getLicenseType = adw_about_window_get_license_type;

    /// Gets the release notes for `self`.
    extern fn adw_about_window_get_release_notes(p_self: *AboutWindow) [*:0]const u8;
    pub const getReleaseNotes = adw_about_window_get_release_notes;

    /// Gets the version described by the application's release notes.
    extern fn adw_about_window_get_release_notes_version(p_self: *AboutWindow) [*:0]const u8;
    pub const getReleaseNotesVersion = adw_about_window_get_release_notes_version;

    /// Gets the URL of the support page for `self`.
    extern fn adw_about_window_get_support_url(p_self: *AboutWindow) [*:0]const u8;
    pub const getSupportUrl = adw_about_window_get_support_url;

    /// Gets the translator credits string.
    extern fn adw_about_window_get_translator_credits(p_self: *AboutWindow) [*:0]const u8;
    pub const getTranslatorCredits = adw_about_window_get_translator_credits;

    /// Gets the version for `self`.
    extern fn adw_about_window_get_version(p_self: *AboutWindow) [*:0]const u8;
    pub const getVersion = adw_about_window_get_version;

    /// Gets the application website URL for `self`.
    extern fn adw_about_window_get_website(p_self: *AboutWindow) [*:0]const u8;
    pub const getWebsite = adw_about_window_get_website;

    /// Sets the name of the application icon for `self`.
    ///
    /// The icon is displayed at the top of the main page.
    extern fn adw_about_window_set_application_icon(p_self: *AboutWindow, p_application_icon: [*:0]const u8) void;
    pub const setApplicationIcon = adw_about_window_set_application_icon;

    /// Sets the application name for `self`.
    ///
    /// The name is displayed at the top of the main page.
    extern fn adw_about_window_set_application_name(p_self: *AboutWindow, p_application_name: [*:0]const u8) void;
    pub const setApplicationName = adw_about_window_set_application_name;

    /// Sets the list of artists of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addCreditSection`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_set_artists(p_self: *AboutWindow, p_artists: ?[*][*:0]const u8) void;
    pub const setArtists = adw_about_window_set_artists;

    /// Sets the comments about the application.
    ///
    /// Comments will be shown on the Details page, above links.
    ///
    /// Unlike `gtk.AboutDialog.properties.comments`, this string can be long and
    /// detailed. It can also contain links and Pango markup.
    extern fn adw_about_window_set_comments(p_self: *AboutWindow, p_comments: [*:0]const u8) void;
    pub const setComments = adw_about_window_set_comments;

    /// Sets the copyright information for `self`.
    ///
    /// This should be a short string of one or two lines, for example:
    /// `© 2022 Example`.
    ///
    /// The copyright information will be displayed on the Legal page, before the
    /// application license.
    ///
    /// `AboutWindow.addLegalSection` can be used to add copyright
    /// information for the application dependencies or other components.
    extern fn adw_about_window_set_copyright(p_self: *AboutWindow, p_copyright: [*:0]const u8) void;
    pub const setCopyright = adw_about_window_set_copyright;

    /// Sets the debug information for `self`.
    ///
    /// Debug information will be shown on the Troubleshooting page. It's intended
    /// to be attached to issue reports when reporting issues against the
    /// application.
    ///
    /// `AdwAboutWindow` provides a quick way to save debug information to a file.
    /// When saving, `AboutWindow.properties.debug_info_filename` would be used as
    /// the suggested filename.
    ///
    /// Debug information cannot contain markup or links.
    extern fn adw_about_window_set_debug_info(p_self: *AboutWindow, p_debug_info: [*:0]const u8) void;
    pub const setDebugInfo = adw_about_window_set_debug_info;

    /// Sets the debug information filename for `self`.
    ///
    /// It will be used as the suggested filename when saving debug information to a
    /// file.
    ///
    /// See `AboutWindow.properties.debug_info`.
    extern fn adw_about_window_set_debug_info_filename(p_self: *AboutWindow, p_filename: [*:0]const u8) void;
    pub const setDebugInfoFilename = adw_about_window_set_debug_info_filename;

    /// Sets the list of designers of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addCreditSection`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_set_designers(p_self: *AboutWindow, p_designers: ?[*][*:0]const u8) void;
    pub const setDesigners = adw_about_window_set_designers;

    /// Sets the developer name for `self`.
    ///
    /// The developer name is displayed on the main page, under the application name.
    ///
    /// If the application is developed by multiple people, the developer name can be
    /// set to values like "AppName team", "AppName developers" or
    /// "The AppName project", and the individual contributors can be listed on the
    /// Credits page, with `AboutWindow.properties.developers` and related properties.
    extern fn adw_about_window_set_developer_name(p_self: *AboutWindow, p_developer_name: [*:0]const u8) void;
    pub const setDeveloperName = adw_about_window_set_developer_name;

    /// Sets the list of developers of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addCreditSection`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_set_developers(p_self: *AboutWindow, p_developers: ?[*][*:0]const u8) void;
    pub const setDevelopers = adw_about_window_set_developers;

    /// Sets the list of documenters of the application.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// Each name may contain email addresses and URLs, see the introduction for more
    /// details.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.translator_credits`
    /// * `AboutWindow.addCreditSection`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_set_documenters(p_self: *AboutWindow, p_documenters: ?[*][*:0]const u8) void;
    pub const setDocumenters = adw_about_window_set_documenters;

    /// Sets the issue tracker URL for `self`.
    ///
    /// The issue tracker link is displayed on the main page.
    extern fn adw_about_window_set_issue_url(p_self: *AboutWindow, p_issue_url: [*:0]const u8) void;
    pub const setIssueUrl = adw_about_window_set_issue_url;

    /// Sets the license for `self`.
    ///
    /// This can be used to set a custom text for the license if it can't be set via
    /// `AboutWindow.properties.license_type`.
    ///
    /// When set, `AboutWindow.properties.license_type` will be set to
    /// `GTK_LICENSE_CUSTOM`.
    ///
    /// The license text will be displayed on the Legal page, below the copyright
    /// information.
    ///
    /// License text can contain Pango markup and links.
    ///
    /// `AboutWindow.addLegalSection` can be used to add license information
    /// for the application dependencies or other components.
    extern fn adw_about_window_set_license(p_self: *AboutWindow, p_license: [*:0]const u8) void;
    pub const setLicense = adw_about_window_set_license;

    /// Sets the license for `self` from a list of known licenses.
    ///
    /// If the application's license is not in the list,
    /// `AboutWindow.properties.license` can be used instead. The license type will be
    /// automatically set to `GTK_LICENSE_CUSTOM` in that case.
    ///
    /// If `license_type` is `GTK_LICENSE_UNKNOWN`, no information will be displayed.
    ///
    /// If `license_type` is different from `GTK_LICENSE_CUSTOM`.
    /// `AboutWindow.properties.license` will be cleared out.
    ///
    /// The license description will be displayed on the Legal page, below the
    /// copyright information.
    ///
    /// `AboutWindow.addLegalSection` can be used to add license information
    /// for the application dependencies or other components.
    extern fn adw_about_window_set_license_type(p_self: *AboutWindow, p_license_type: gtk.License) void;
    pub const setLicenseType = adw_about_window_set_license_type;

    /// Sets the release notes for `self`.
    ///
    /// Release notes are displayed on the the What's New page.
    ///
    /// Release notes are formatted the same way as
    /// [AppStream descriptions](https://freedesktop.org/software/appstream/docs/chap-Metadata.html`tag`-description).
    ///
    /// The supported formatting options are:
    ///
    /// * Paragraph (`<p>`)
    /// * Ordered list (`<ol>`), with list items (`<li>`)
    /// * Unordered list (`<ul>`), with list items (`<li>`)
    ///
    /// Within paragraphs and list items, emphasis (`<em>`) and inline code
    /// (`<code>`) text styles are supported. The emphasis is rendered in italic,
    /// while inline code is shown in a monospaced font.
    ///
    /// Any text outside paragraphs or list items is ignored.
    ///
    /// Nested lists are not supported.
    ///
    /// `AdwAboutWindow` displays the version above the release notes. If set, the
    /// `AboutWindow.properties.release_notes_version` of the property will be used
    /// as the version; otherwise, `AboutWindow.properties.version` is used.
    extern fn adw_about_window_set_release_notes(p_self: *AboutWindow, p_release_notes: [*:0]const u8) void;
    pub const setReleaseNotes = adw_about_window_set_release_notes;

    /// Sets the version described by the application's release notes.
    ///
    /// The release notes version is displayed on the What's New page, above the
    /// release notes.
    ///
    /// If not set, `AboutWindow.properties.version` will be used instead.
    ///
    /// For example, an application with the current version 2.0.2 might want to
    /// keep the release notes from 2.0.0, and set the release notes version
    /// accordingly.
    ///
    /// See `AboutWindow.properties.release_notes`.
    extern fn adw_about_window_set_release_notes_version(p_self: *AboutWindow, p_version: [*:0]const u8) void;
    pub const setReleaseNotesVersion = adw_about_window_set_release_notes_version;

    /// Sets the URL of the support page for `self`.
    ///
    /// The support page link is displayed on the main page.
    extern fn adw_about_window_set_support_url(p_self: *AboutWindow, p_support_url: [*:0]const u8) void;
    pub const setSupportUrl = adw_about_window_set_support_url;

    /// Sets the translator credits string.
    ///
    /// It will be displayed on the Credits page.
    ///
    /// This string should be `"translator-credits"` or `"translator_credits"` and
    /// should be marked as translatable.
    ///
    /// The string may contain email addresses and URLs, see the introduction for
    /// more details. When there is more than one translator, they must be
    /// separated by a newline in the same string.
    ///
    /// See also:
    ///
    /// * `AboutWindow.properties.developers`
    /// * `AboutWindow.properties.designers`
    /// * `AboutWindow.properties.artists`
    /// * `AboutWindow.properties.documenters`
    /// * `AboutWindow.addCreditSection`
    /// * `AboutWindow.addAcknowledgementSection`
    extern fn adw_about_window_set_translator_credits(p_self: *AboutWindow, p_translator_credits: [*:0]const u8) void;
    pub const setTranslatorCredits = adw_about_window_set_translator_credits;

    /// Sets the version for `self`.
    ///
    /// The version is displayed on the main page.
    ///
    /// If `AboutWindow.properties.release_notes_version` is not set, the version will
    /// also be displayed above the release notes on the What's New page.
    extern fn adw_about_window_set_version(p_self: *AboutWindow, p_version: [*:0]const u8) void;
    pub const setVersion = adw_about_window_set_version;

    /// Sets the application website URL for `self`.
    ///
    /// Website is displayed on the Details page, below comments, or on the main page
    /// if the Details page doesn't have any other content.
    ///
    /// Applications can add other links below, see `AboutWindow.addLink`.
    extern fn adw_about_window_set_website(p_self: *AboutWindow, p_website: [*:0]const u8) void;
    pub const setWebsite = adw_about_window_set_website;

    extern fn adw_about_window_get_type() usize;
    pub const getGObjectType = adw_about_window_get_type;

    extern fn g_object_ref(p_self: *adw.AboutWindow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.AboutWindow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AboutWindow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` used to present actions.
///
/// <picture>
///   <source srcset="action-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="action-row.png" alt="action-row">
/// </picture>
///
/// The `AdwActionRow` widget can have a title, a subtitle and an icon. The row
/// can receive additional widgets at its end, or prefix widgets at its start.
///
/// It is convenient to present a preference and its related actions.
///
/// `AdwActionRow` is unactivatable by default, giving it an activatable widget
/// will automatically make it activatable, but unsetting it won't change the
/// row's activatability.
///
/// ## AdwActionRow as GtkBuildable
///
/// The `AdwActionRow` implementation of the `gtk.Buildable` interface
/// supports adding a child at its end by specifying “suffix” or omitting the
/// “type” attribute of a <child> element.
///
/// It also supports adding a child as a prefix widget by specifying “prefix” as
/// the “type” attribute of a <child> element.
///
/// ## CSS nodes
///
/// `AdwActionRow` has a main CSS node with name `row`.
///
/// It contains the subnode `box.header` for its main horizontal box, and
/// `box.title` for the vertical box containing the title and subtitle labels.
///
/// It contains subnodes `label.title` and `label.subtitle` representing
/// respectively the title label and subtitle label.
///
/// ## Style classes
///
/// `AdwActionRow` can use the [`.property`](style-classes.html`property`-rows)
/// style class to emphasize the row subtitle instead of the row title, which is
/// useful for displaying read-only properties.
///
/// <picture>
///   <source srcset="property-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="property-row.png" alt="property-row">
/// </picture>
///
/// When used together with the `.monospace` style class, only the subtitle
/// becomes monospace, not the title or any extra widgets.
pub const ActionRow = extern struct {
    pub const Parent = adw.PreferencesRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ActionRowClass;
    f_parent_instance: adw.PreferencesRow,

    pub const virtual_methods = struct {
        /// Activates `self`.
        pub const activate = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ActionRow.Class, p_class).f_activate.?(gobject.ext.as(ActionRow, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ActionRow.Class, p_class).f_activate = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The widget to activate when the row is activated.
        ///
        /// The row can be activated either by clicking on it, calling
        /// `ActionRow.activate`, or via mnemonics in the title.
        /// See the `PreferencesRow.properties.use_underline` property to enable
        /// mnemonics.
        ///
        /// The target widget will be activated by emitting the
        /// `gtk.Widget.signals.mnemonic_activate` signal on it.
        pub const activatable_widget = struct {
            pub const name = "activatable-widget";

            pub const Type = ?*gtk.Widget;
        };

        /// The icon name for this row.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The subtitle for this row.
        ///
        /// The subtitle is interpreted as Pango markup unless
        /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
        pub const subtitle = struct {
            pub const name = "subtitle";

            pub const Type = ?[*:0]u8;
        };

        /// The number of lines at the end of which the subtitle label will be
        /// ellipsized.
        ///
        /// If the value is 0, the number of lines won't be limited.
        pub const subtitle_lines = struct {
            pub const name = "subtitle-lines";

            pub const Type = c_int;
        };

        /// Whether the user can copy the subtitle from the label.
        ///
        /// See also `gtk.Label.properties.selectable`.
        pub const subtitle_selectable = struct {
            pub const name = "subtitle-selectable";

            pub const Type = c_int;
        };

        /// The number of lines at the end of which the title label will be ellipsized.
        ///
        /// If the value is 0, the number of lines won't be limited.
        pub const title_lines = struct {
            pub const name = "title-lines";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// This signal is emitted after the row has been activated.
        pub const activated = struct {
            pub const name = "activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ActionRow, p_instance))),
                    gobject.signalLookup("activated", ActionRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwActionRow`.
    extern fn adw_action_row_new() *adw.ActionRow;
    pub const new = adw_action_row_new;

    /// Activates `self`.
    extern fn adw_action_row_activate(p_self: *ActionRow) void;
    pub const activate = adw_action_row_activate;

    /// Adds a prefix widget to `self`.
    extern fn adw_action_row_add_prefix(p_self: *ActionRow, p_widget: *gtk.Widget) void;
    pub const addPrefix = adw_action_row_add_prefix;

    /// Adds a suffix widget to `self`.
    extern fn adw_action_row_add_suffix(p_self: *ActionRow, p_widget: *gtk.Widget) void;
    pub const addSuffix = adw_action_row_add_suffix;

    /// Gets the widget activated when `self` is activated.
    extern fn adw_action_row_get_activatable_widget(p_self: *ActionRow) ?*gtk.Widget;
    pub const getActivatableWidget = adw_action_row_get_activatable_widget;

    /// Gets the icon name for `self`.
    extern fn adw_action_row_get_icon_name(p_self: *ActionRow) ?[*:0]const u8;
    pub const getIconName = adw_action_row_get_icon_name;

    /// Gets the subtitle for `self`.
    extern fn adw_action_row_get_subtitle(p_self: *ActionRow) ?[*:0]const u8;
    pub const getSubtitle = adw_action_row_get_subtitle;

    /// Gets the number of lines at the end of which the subtitle label will be
    /// ellipsized.
    extern fn adw_action_row_get_subtitle_lines(p_self: *ActionRow) c_int;
    pub const getSubtitleLines = adw_action_row_get_subtitle_lines;

    /// Gets whether the user can copy the subtitle from the label
    extern fn adw_action_row_get_subtitle_selectable(p_self: *ActionRow) c_int;
    pub const getSubtitleSelectable = adw_action_row_get_subtitle_selectable;

    /// Gets the number of lines at the end of which the title label will be
    /// ellipsized.
    extern fn adw_action_row_get_title_lines(p_self: *ActionRow) c_int;
    pub const getTitleLines = adw_action_row_get_title_lines;

    /// Removes a child from `self`.
    extern fn adw_action_row_remove(p_self: *ActionRow, p_widget: *gtk.Widget) void;
    pub const remove = adw_action_row_remove;

    /// Sets the widget to activate when `self` is activated.
    ///
    /// The row can be activated either by clicking on it, calling
    /// `ActionRow.activate`, or via mnemonics in the title.
    /// See the `PreferencesRow.properties.use_underline` property to enable mnemonics.
    ///
    /// The target widget will be activated by emitting the
    /// `gtk.Widget.signals.mnemonic_activate` signal on it.
    extern fn adw_action_row_set_activatable_widget(p_self: *ActionRow, p_widget: ?*gtk.Widget) void;
    pub const setActivatableWidget = adw_action_row_set_activatable_widget;

    /// Sets the icon name for `self`.
    extern fn adw_action_row_set_icon_name(p_self: *ActionRow, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_action_row_set_icon_name;

    /// Sets the subtitle for `self`.
    ///
    /// The subtitle is interpreted as Pango markup unless
    /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
    extern fn adw_action_row_set_subtitle(p_self: *ActionRow, p_subtitle: [*:0]const u8) void;
    pub const setSubtitle = adw_action_row_set_subtitle;

    /// Sets the number of lines at the end of which the subtitle label will be
    /// ellipsized.
    ///
    /// If the value is 0, the number of lines won't be limited.
    extern fn adw_action_row_set_subtitle_lines(p_self: *ActionRow, p_subtitle_lines: c_int) void;
    pub const setSubtitleLines = adw_action_row_set_subtitle_lines;

    /// Sets whether the user can copy the subtitle from the label
    ///
    /// See also `gtk.Label.properties.selectable`.
    extern fn adw_action_row_set_subtitle_selectable(p_self: *ActionRow, p_subtitle_selectable: c_int) void;
    pub const setSubtitleSelectable = adw_action_row_set_subtitle_selectable;

    /// Sets the number of lines at the end of which the title label will be
    /// ellipsized.
    ///
    /// If the value is 0, the number of lines won't be limited.
    extern fn adw_action_row_set_title_lines(p_self: *ActionRow, p_title_lines: c_int) void;
    pub const setTitleLines = adw_action_row_set_title_lines;

    extern fn adw_action_row_get_type() usize;
    pub const getGObjectType = adw_action_row_get_type;

    extern fn g_object_ref(p_self: *adw.ActionRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ActionRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ActionRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A dialog presenting a message or a question.
///
/// <picture>
///   <source srcset="alert-dialog-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="alert-dialog.png" alt="alert-dialog">
/// </picture>
///
/// Alert dialogs have a heading, a body, an optional child widget, and one or
/// multiple responses, each presented as a button.
///
/// Each response has a unique string ID, and a button label. Additionally, each
/// response can be enabled or disabled, and can have a suggested or destructive
/// appearance.
///
/// When one of the responses is activated, or the dialog is closed, the
/// `AlertDialog.signals.response` signal will be emitted. This signal is
/// detailed, and the detail, as well as the `response` parameter will be set to
/// the ID of the activated response, or to the value of the
/// `AlertDialog.properties.close_response` property if the dialog had been closed
/// without activating any of the responses.
///
/// Response buttons can be presented horizontally or vertically depending on
/// available space.
///
/// When a response is activated, `AdwAlertDialog` is closed automatically.
///
/// An example of using an alert dialog:
///
/// ```c
/// AdwDialog *dialog;
///
/// dialog = adw_alert_dialog_new (_("Replace File?"), NULL);
///
/// adw_alert_dialog_format_body (ADW_ALERT_DIALOG (dialog),
///                               _("A file named “`s`” already exists. Do you want to replace it?"),
///                               filename);
///
/// adw_alert_dialog_add_responses (ADW_ALERT_DIALOG (dialog),
///                                 "cancel",  _("_Cancel"),
///                                 "replace", _("_Replace"),
///                                 NULL);
///
/// adw_alert_dialog_set_response_appearance (ADW_ALERT_DIALOG (dialog),
///                                           "replace",
///                                           ADW_RESPONSE_DESTRUCTIVE);
///
/// adw_alert_dialog_set_default_response (ADW_ALERT_DIALOG (dialog), "cancel");
/// adw_alert_dialog_set_close_response (ADW_ALERT_DIALOG (dialog), "cancel");
///
/// g_signal_connect (dialog, "response", G_CALLBACK (response_cb), self);
///
/// adw_dialog_present (dialog, parent);
/// ```
///
/// ## Async API
///
/// `AdwAlertDialog` can also be used via the `AlertDialog.choose` method.
/// This API follows the GIO async pattern, for example:
///
/// ```c
/// static void
/// dialog_cb (AdwAlertDialog *dialog,
///            GAsyncResult   *result,
///            MyWindow       *self)
/// {
///   const char *response = adw_alert_dialog_choose_finish (dialog, result);
///
///   // ...
/// }
///
/// static void
/// show_dialog (MyWindow *self)
/// {
///   AdwDialog *dialog;
///
///   dialog = adw_alert_dialog_new (_("Replace File?"), NULL);
///
///   adw_alert_dialog_format_body (ADW_ALERT_DIALOG (dialog),
///                                 _("A file named “`s`” already exists. Do you want to replace it?"),
///                                 filename);
///
///   adw_alert_dialog_add_responses (ADW_ALERT_DIALOG (dialog),
///                                   "cancel",  _("_Cancel"),
///                                   "replace", _("_Replace"),
///                                   NULL);
///
///   adw_alert_dialog_set_response_appearance (ADW_ALERT_DIALOG (dialog),
///                                             "replace",
///                                             ADW_RESPONSE_DESTRUCTIVE);
///
///   adw_alert_dialog_set_default_response (ADW_ALERT_DIALOG (dialog), "cancel");
///   adw_alert_dialog_set_close_response (ADW_ALERT_DIALOG (dialog), "cancel");
///
///   adw_alert_dialog_choose (ADW_ALERT_DIALOG (dialog), GTK_WIDGET (self),
///                            NULL, (GAsyncReadyCallback) dialog_cb, self);
/// }
/// ```
///
/// ## AdwAlertDialog as GtkBuildable
///
/// `AdwAlertDialog` supports adding responses in UI definitions by via the
/// `<responses>` element that may contain multiple `<response>` elements, each
/// representing a response.
///
/// Each of the `<response>` elements must have the `id` attribute specifying the
/// response ID. The contents of the element are used as the response label.
///
/// Response labels can be translated with the usual `translatable`, `context`
/// and `comments` attributes.
///
/// The `<response>` elements can also have `enabled` and/or `appearance`
/// attributes. See `AlertDialog.setResponseEnabled` and
/// `AlertDialog.setResponseAppearance` for details.
///
/// Example of an `AdwAlertDialog` UI definition:
///
/// ```xml
/// <object class="AdwAlertDialog" id="dialog">
///   <property name="heading" translatable="yes">Save Changes?</property>
///   <property name="body" translatable="yes">Open documents contain unsaved changes. Changes which are not saved will be permanently lost.</property>
///   <property name="default-response">save</property>
///   <property name="close-response">cancel</property>
///   <signal name="response" handler="response_cb"/>
///   <responses>
///     <response id="cancel" translatable="yes">_Cancel</response>
///     <response id="discard" translatable="yes" appearance="destructive">_Discard</response>
///     <response id="save" translatable="yes" appearance="suggested" enabled="false">_Save</response>
///   </responses>
/// </object>
/// ```
pub const AlertDialog = extern struct {
    pub const Parent = adw.Dialog;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.ShortcutManager };
    pub const Class = adw.AlertDialogClass;
    f_parent_instance: adw.Dialog,

    pub const virtual_methods = struct {
        pub const response = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_response: [*:0]const u8) void {
                return gobject.ext.as(AlertDialog.Class, p_class).f_response.?(gobject.ext.as(AlertDialog, p_self), p_response);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_response: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(AlertDialog.Class, p_class).f_response = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The body text of the dialog.
        pub const body = struct {
            pub const name = "body";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the body text includes Pango markup.
        ///
        /// See `pango.parseMarkup`.
        pub const body_use_markup = struct {
            pub const name = "body-use-markup";

            pub const Type = c_int;
        };

        /// The ID of the close response.
        ///
        /// It will be passed to `AlertDialog.signals.response` if the dialog is
        /// closed by pressing <kbd>Escape</kbd> or with a system action.
        ///
        /// It doesn't have to correspond to any of the responses in the dialog.
        ///
        /// The default close response is `close`.
        pub const close_response = struct {
            pub const name = "close-response";

            pub const Type = ?[*:0]u8;
        };

        /// The response ID of the default response.
        ///
        /// If set, pressing <kbd>Enter</kbd> will activate the corresponding button.
        ///
        /// If set to `NULL` or a non-existent response ID, pressing <kbd>Enter</kbd>
        /// will do nothing.
        pub const default_response = struct {
            pub const name = "default-response";

            pub const Type = ?[*:0]u8;
        };

        /// The child widget.
        ///
        /// Displayed below the heading and body.
        pub const extra_child = struct {
            pub const name = "extra-child";

            pub const Type = ?*gtk.Widget;
        };

        /// The heading of the dialog.
        pub const heading = struct {
            pub const name = "heading";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the heading includes Pango markup.
        ///
        /// See `pango.parseMarkup`.
        pub const heading_use_markup = struct {
            pub const name = "heading-use-markup";

            pub const Type = c_int;
        };

        /// Whether to prefer wide layout.
        ///
        /// Prefer horizontal button layout when possible, and wider dialog width
        /// otherwise.
        pub const prefer_wide_layout = struct {
            pub const name = "prefer-wide-layout";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when the dialog is closed.
        ///
        /// `response` will be set to the response ID of the button that had been
        /// activated.
        ///
        /// if the dialog was closed by pressing <kbd>Escape</kbd> or with a system
        /// action, `response` will be set to the value of
        /// `AlertDialog.properties.close_response`.
        pub const response = struct {
            pub const name = "response";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_response: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(AlertDialog, p_instance))),
                    gobject.signalLookup("response", AlertDialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwAlertDialog`.
    ///
    /// `heading` and `body` can be set to `NULL`. This can be useful if they need to
    /// be formatted or use markup. In that case, set them to `NULL` and call
    /// `AlertDialog.formatBody` or similar methods afterwards:
    ///
    /// ```c
    /// AdwDialog *dialog;
    ///
    /// dialog = adw_alert_dialog_new (_("Replace File?"), NULL);
    /// adw_alert_dialog_format_body (ADW_ALERT_DIALOG (dialog),
    ///                               _("A file named “`s`” already exists.  Do you want to replace it?"),
    ///                               filename);
    /// ```
    extern fn adw_alert_dialog_new(p_heading: ?[*:0]const u8, p_body: ?[*:0]const u8) *adw.AlertDialog;
    pub const new = adw_alert_dialog_new;

    /// Adds a response with `id` and `label` to `self`.
    ///
    /// Responses are represented as buttons in the dialog.
    ///
    /// Response ID must be unique. It will be used in `AlertDialog.signals.response`
    /// to tell which response had been activated, as well as to inspect and modify
    /// the response later.
    ///
    /// An embedded underline in `label` indicates a mnemonic.
    ///
    /// `AlertDialog.setResponseLabel` can be used to change the response
    /// label after it had been added.
    ///
    /// `AlertDialog.setResponseEnabled` and
    /// `AlertDialog.setResponseAppearance` can be used to customize the
    /// responses further.
    extern fn adw_alert_dialog_add_response(p_self: *AlertDialog, p_id: [*:0]const u8, p_label: [*:0]const u8) void;
    pub const addResponse = adw_alert_dialog_add_response;

    /// Adds multiple responses to `self`.
    ///
    /// This is the same as calling `AlertDialog.addResponse` repeatedly. The
    /// variable argument list should be `NULL`-terminated list of response IDs and
    /// labels.
    ///
    /// Example:
    ///
    /// ```c
    /// adw_alert_dialog_add_responses (dialog,
    ///                                 "cancel",  _("_Cancel"),
    ///                                 "discard", _("_Discard"),
    ///                                 "save",    _("_Save"),
    ///                                 NULL);
    /// ```
    extern fn adw_alert_dialog_add_responses(p_self: *AlertDialog, p_first_id: [*:0]const u8, ...) void;
    pub const addResponses = adw_alert_dialog_add_responses;

    /// This function shows `self` to the user.
    ///
    /// If the window is an `Window` or `ApplicationWindow`, the dialog
    /// will be shown within it. Otherwise, it will be a separate window.
    extern fn adw_alert_dialog_choose(p_self: *AlertDialog, p_parent: ?*gtk.Widget, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const choose = adw_alert_dialog_choose;

    /// Finishes the `AlertDialog.choose` call and returns the response ID.
    extern fn adw_alert_dialog_choose_finish(p_self: *AlertDialog, p_result: *gio.AsyncResult) [*:0]const u8;
    pub const chooseFinish = adw_alert_dialog_choose_finish;

    /// Sets the formatted body text of `self`.
    ///
    /// See `AlertDialog.properties.body`.
    extern fn adw_alert_dialog_format_body(p_self: *AlertDialog, p_format: [*:0]const u8, ...) void;
    pub const formatBody = adw_alert_dialog_format_body;

    /// Sets the formatted body text of `self` with Pango markup.
    ///
    /// The `format` is assumed to contain Pango markup.
    ///
    /// Special XML characters in the ``printf`` arguments passed to this function
    /// will automatically be escaped as necessary, see
    /// `glib.markupPrintfEscaped`.
    ///
    /// See `AlertDialog.properties.body`.
    extern fn adw_alert_dialog_format_body_markup(p_self: *AlertDialog, p_format: [*:0]const u8, ...) void;
    pub const formatBodyMarkup = adw_alert_dialog_format_body_markup;

    /// Sets the formatted heading of `self`.
    ///
    /// See `AlertDialog.properties.heading`.
    extern fn adw_alert_dialog_format_heading(p_self: *AlertDialog, p_format: [*:0]const u8, ...) void;
    pub const formatHeading = adw_alert_dialog_format_heading;

    /// Sets the formatted heading of `self` with Pango markup.
    ///
    /// The `format` is assumed to contain Pango markup.
    ///
    /// Special XML characters in the ``printf`` arguments passed to this function
    /// will automatically be escaped as necessary, see
    /// `glib.markupPrintfEscaped`.
    ///
    /// See `AlertDialog.properties.heading`.
    extern fn adw_alert_dialog_format_heading_markup(p_self: *AlertDialog, p_format: [*:0]const u8, ...) void;
    pub const formatHeadingMarkup = adw_alert_dialog_format_heading_markup;

    /// Gets the body text of `self`.
    extern fn adw_alert_dialog_get_body(p_self: *AlertDialog) [*:0]const u8;
    pub const getBody = adw_alert_dialog_get_body;

    /// Gets whether the body text of `self` includes Pango markup.
    extern fn adw_alert_dialog_get_body_use_markup(p_self: *AlertDialog) c_int;
    pub const getBodyUseMarkup = adw_alert_dialog_get_body_use_markup;

    /// Gets the ID of the close response of `self`.
    extern fn adw_alert_dialog_get_close_response(p_self: *AlertDialog) [*:0]const u8;
    pub const getCloseResponse = adw_alert_dialog_get_close_response;

    /// Gets the ID of the default response of `self`.
    extern fn adw_alert_dialog_get_default_response(p_self: *AlertDialog) ?[*:0]const u8;
    pub const getDefaultResponse = adw_alert_dialog_get_default_response;

    /// Gets the child widget of `self`.
    extern fn adw_alert_dialog_get_extra_child(p_self: *AlertDialog) ?*gtk.Widget;
    pub const getExtraChild = adw_alert_dialog_get_extra_child;

    /// Gets the heading of `self`.
    extern fn adw_alert_dialog_get_heading(p_self: *AlertDialog) ?[*:0]const u8;
    pub const getHeading = adw_alert_dialog_get_heading;

    /// Gets whether the heading of `self` includes Pango markup.
    extern fn adw_alert_dialog_get_heading_use_markup(p_self: *AlertDialog) c_int;
    pub const getHeadingUseMarkup = adw_alert_dialog_get_heading_use_markup;

    /// Gets whether `self` prefers wide layout.
    extern fn adw_alert_dialog_get_prefer_wide_layout(p_self: *AlertDialog) c_int;
    pub const getPreferWideLayout = adw_alert_dialog_get_prefer_wide_layout;

    /// Gets the appearance of `response`.
    ///
    /// See `AlertDialog.setResponseAppearance`.
    extern fn adw_alert_dialog_get_response_appearance(p_self: *AlertDialog, p_response: [*:0]const u8) adw.ResponseAppearance;
    pub const getResponseAppearance = adw_alert_dialog_get_response_appearance;

    /// Gets whether `response` is enabled.
    ///
    /// See `AlertDialog.setResponseEnabled`.
    extern fn adw_alert_dialog_get_response_enabled(p_self: *AlertDialog, p_response: [*:0]const u8) c_int;
    pub const getResponseEnabled = adw_alert_dialog_get_response_enabled;

    /// Gets the label of `response`.
    ///
    /// See `AlertDialog.setResponseLabel`.
    extern fn adw_alert_dialog_get_response_label(p_self: *AlertDialog, p_response: [*:0]const u8) [*:0]const u8;
    pub const getResponseLabel = adw_alert_dialog_get_response_label;

    /// Gets whether `self` has a response with the ID `response`.
    extern fn adw_alert_dialog_has_response(p_self: *AlertDialog, p_response: [*:0]const u8) c_int;
    pub const hasResponse = adw_alert_dialog_has_response;

    /// Removes a response from `self`.
    extern fn adw_alert_dialog_remove_response(p_self: *AlertDialog, p_id: [*:0]const u8) void;
    pub const removeResponse = adw_alert_dialog_remove_response;

    /// Sets the body text of `self`.
    extern fn adw_alert_dialog_set_body(p_self: *AlertDialog, p_body: [*:0]const u8) void;
    pub const setBody = adw_alert_dialog_set_body;

    /// Sets whether the body text of `self` includes Pango markup.
    ///
    /// See `pango.parseMarkup`.
    extern fn adw_alert_dialog_set_body_use_markup(p_self: *AlertDialog, p_use_markup: c_int) void;
    pub const setBodyUseMarkup = adw_alert_dialog_set_body_use_markup;

    /// Sets the ID of the close response of `self`.
    ///
    /// It will be passed to `AlertDialog.signals.response` if the dialog is closed
    /// by pressing <kbd>Escape</kbd> or with a system action.
    ///
    /// It doesn't have to correspond to any of the responses in the dialog.
    ///
    /// The default close response is `close`.
    extern fn adw_alert_dialog_set_close_response(p_self: *AlertDialog, p_response: [*:0]const u8) void;
    pub const setCloseResponse = adw_alert_dialog_set_close_response;

    /// Sets the ID of the default response of `self`.
    ///
    /// If set, pressing <kbd>Enter</kbd> will activate the corresponding button.
    ///
    /// If set to `NULL` or to a non-existent response ID, pressing <kbd>Enter</kbd>
    /// will do nothing.
    extern fn adw_alert_dialog_set_default_response(p_self: *AlertDialog, p_response: ?[*:0]const u8) void;
    pub const setDefaultResponse = adw_alert_dialog_set_default_response;

    /// Sets the child widget of `self`.
    ///
    /// The child widget is displayed below the heading and body.
    extern fn adw_alert_dialog_set_extra_child(p_self: *AlertDialog, p_child: ?*gtk.Widget) void;
    pub const setExtraChild = adw_alert_dialog_set_extra_child;

    /// Sets the heading of `self`.
    extern fn adw_alert_dialog_set_heading(p_self: *AlertDialog, p_heading: ?[*:0]const u8) void;
    pub const setHeading = adw_alert_dialog_set_heading;

    /// Sets whether the heading of `self` includes Pango markup.
    ///
    /// See `pango.parseMarkup`.
    extern fn adw_alert_dialog_set_heading_use_markup(p_self: *AlertDialog, p_use_markup: c_int) void;
    pub const setHeadingUseMarkup = adw_alert_dialog_set_heading_use_markup;

    /// Sets whether `self` prefers wide layout.
    ///
    /// Prefer horizontal button layout when possible, and wider dialog width
    /// otherwise.
    extern fn adw_alert_dialog_set_prefer_wide_layout(p_self: *AlertDialog, p_prefer_wide_layout: c_int) void;
    pub const setPreferWideLayout = adw_alert_dialog_set_prefer_wide_layout;

    /// Sets the appearance for `response`.
    ///
    /// <picture>
    ///   <source srcset="alert-dialog-appearance-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img src="alert-dialog-appearance.png" alt="alert-dialog-appearance">
    /// </picture>
    ///
    /// Use `ADW_RESPONSE_SUGGESTED` to mark important responses such as the
    /// affirmative action, like the Save button in the example.
    ///
    /// Use `ADW_RESPONSE_DESTRUCTIVE` to draw attention to the potentially damaging
    /// consequences of using `response`. This appearance acts as a warning to the
    /// user. The Discard button in the example is using this appearance.
    ///
    /// The default appearance is `ADW_RESPONSE_DEFAULT`.
    ///
    /// Negative responses like Cancel or Close should use the default appearance.
    extern fn adw_alert_dialog_set_response_appearance(p_self: *AlertDialog, p_response: [*:0]const u8, p_appearance: adw.ResponseAppearance) void;
    pub const setResponseAppearance = adw_alert_dialog_set_response_appearance;

    /// Sets whether `response` is enabled.
    ///
    /// If `response` is not enabled, the corresponding button will have
    /// `gtk.Widget.properties.sensitive` set to `FALSE` and it can't be activated as
    /// a default response.
    ///
    /// `response` can still be used as `AlertDialog.properties.close_response` while
    /// it's not enabled.
    ///
    /// Responses are enabled by default.
    extern fn adw_alert_dialog_set_response_enabled(p_self: *AlertDialog, p_response: [*:0]const u8, p_enabled: c_int) void;
    pub const setResponseEnabled = adw_alert_dialog_set_response_enabled;

    /// Sets the label of `response` to `label`.
    ///
    /// Labels are displayed on the dialog buttons. An embedded underline in `label`
    /// indicates a mnemonic.
    extern fn adw_alert_dialog_set_response_label(p_self: *AlertDialog, p_response: [*:0]const u8, p_label: [*:0]const u8) void;
    pub const setResponseLabel = adw_alert_dialog_set_response_label;

    extern fn adw_alert_dialog_get_type() usize;
    pub const getGObjectType = adw_alert_dialog_get_type;

    extern fn g_object_ref(p_self: *adw.AlertDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.AlertDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AlertDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A base class for animations.
///
/// `AdwAnimation` represents an animation on a widget. It has a target that
/// provides a value to animate, and a state indicating whether the
/// animation hasn't been started yet, is playing, paused or finished.
///
/// Currently there are two concrete animation types:
/// `TimedAnimation` and `SpringAnimation`.
///
/// `AdwAnimation` will automatically skip the animation if
/// `Animation.properties.widget` is unmapped, or if
/// `gtk.Settings.properties.gtk_enable_animations` is `FALSE`.
///
/// The `Animation.signals.done` signal can be used to perform an action after
/// the animation ends, for example hiding a widget after animating its
/// `gtk.Widget.properties.opacity` to 0.
///
/// `AdwAnimation` will be kept alive while the animation is playing. As such,
/// it's safe to create an animation, start it and immediately unref it:
/// A fire-and-forget animation:
///
/// ```c
/// static void
/// animation_cb (double    value,
///               MyObject *self)
/// {
///   // Do something with `value`
/// }
///
/// static void
/// my_object_animate (MyObject *self)
/// {
///   AdwAnimationTarget *target =
///     adw_callback_animation_target_new ((AdwAnimationTargetFunc) animation_cb,
///                                        self, NULL);
///   g_autoptr (AdwAnimation) animation =
///     adw_timed_animation_new (widget, 0, 1, 250, target);
///
///   adw_animation_play (animation);
/// }
/// ```
///
/// If there's a chance the previous animation for the same target hasn't yet
/// finished, the previous animation should be stopped first, or the existing
/// `AdwAnimation` object can be reused.
pub const Animation = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.AnimationClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to skip the animation when animations are globally disabled.
        ///
        /// The default behavior is to skip the animation. Set to `FALSE` to disable
        /// this behavior.
        ///
        /// This can be useful for cases where animation is essential, like spinners,
        /// or in demo applications. Most other animations should keep it enabled.
        ///
        /// See `gtk.Settings.properties.gtk_enable_animations`.
        pub const follow_enable_animations_setting = struct {
            pub const name = "follow-enable-animations-setting";

            pub const Type = c_int;
        };

        /// The animation state.
        ///
        /// The state indicates whether the animation is currently playing, paused,
        /// finished or hasn't been started yet.
        pub const state = struct {
            pub const name = "state";

            pub const Type = adw.AnimationState;
        };

        /// The target to animate.
        pub const target = struct {
            pub const name = "target";

            pub const Type = ?*adw.AnimationTarget;
        };

        /// The current value of the animation.
        pub const value = struct {
            pub const name = "value";

            pub const Type = f64;
        };

        /// The animation widget.
        ///
        /// It provides the frame clock for the animation. It's not strictly necessary
        /// for this widget to be same as the one being animated.
        ///
        /// The widget must be mapped in order for the animation to work. If it's not
        /// mapped, or if it gets unmapped during an ongoing animation, the animation
        /// will be automatically skipped.
        pub const widget = struct {
            pub const name = "widget";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when the animation has been completed, either on its
        /// own or via calling `Animation.skip`.
        pub const done = struct {
            pub const name = "done";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Animation, p_instance))),
                    gobject.signalLookup("done", Animation.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets whether `self` should be skipped when animations are globally disabled.
    extern fn adw_animation_get_follow_enable_animations_setting(p_self: *Animation) c_int;
    pub const getFollowEnableAnimationsSetting = adw_animation_get_follow_enable_animations_setting;

    /// Gets the current value of `self`.
    ///
    /// The state indicates whether `self` is currently playing, paused, finished or
    /// hasn't been started yet.
    extern fn adw_animation_get_state(p_self: *Animation) adw.AnimationState;
    pub const getState = adw_animation_get_state;

    /// Gets the target `self` animates.
    extern fn adw_animation_get_target(p_self: *Animation) *adw.AnimationTarget;
    pub const getTarget = adw_animation_get_target;

    /// Gets the current value of `self`.
    extern fn adw_animation_get_value(p_self: *Animation) f64;
    pub const getValue = adw_animation_get_value;

    /// Gets the widget `self` was created for.
    ///
    /// It provides the frame clock for the animation. It's not strictly necessary
    /// for this widget to be same as the one being animated.
    ///
    /// The widget must be mapped in order for the animation to work. If it's not
    /// mapped, or if it gets unmapped during an ongoing animation, the animation
    /// will be automatically skipped.
    extern fn adw_animation_get_widget(p_self: *Animation) *gtk.Widget;
    pub const getWidget = adw_animation_get_widget;

    /// Pauses a playing animation for `self`.
    ///
    /// Does nothing if the current state of `self` isn't `ADW_ANIMATION_PLAYING`.
    ///
    /// Sets `Animation.properties.state` to `ADW_ANIMATION_PAUSED`.
    extern fn adw_animation_pause(p_self: *Animation) void;
    pub const pause = adw_animation_pause;

    /// Starts the animation for `self`.
    ///
    /// If the animation is playing, paused or has been completed, restarts it from
    /// the beginning. This allows to easily play an animation regardless of whether
    /// it's already playing or not.
    ///
    /// Sets `Animation.properties.state` to `ADW_ANIMATION_PLAYING`.
    ///
    /// The animation will be automatically skipped if `Animation.properties.widget` is
    /// unmapped, or if `gtk.Settings.properties.gtk_enable_animations` is `FALSE`.
    ///
    /// As such, it's not guaranteed that the animation will actually run. For
    /// example, when using `glib.idleAdd` and starting an animation
    /// immediately afterwards, it's entirely possible that the idle callback will
    /// run after the animation has already finished, and not while it's playing.
    extern fn adw_animation_play(p_self: *Animation) void;
    pub const play = adw_animation_play;

    /// Resets the animation for `self`.
    ///
    /// Sets `Animation.properties.state` to `ADW_ANIMATION_IDLE`.
    extern fn adw_animation_reset(p_self: *Animation) void;
    pub const reset = adw_animation_reset;

    /// Resumes a paused animation for `self`.
    ///
    /// This function must only be used if the animation has been paused with
    /// `Animation.pause`.
    ///
    /// Sets `Animation.properties.state` to `ADW_ANIMATION_PLAYING`.
    extern fn adw_animation_resume(p_self: *Animation) void;
    pub const @"resume" = adw_animation_resume;

    /// Sets whether to skip `self` when animations are globally disabled.
    ///
    /// The default behavior is to skip the animation. Set to `FALSE` to disable this
    /// behavior.
    ///
    /// This can be useful for cases where animation is essential, like spinners, or
    /// in demo applications. Most other animations should keep it enabled.
    ///
    /// See `gtk.Settings.properties.gtk_enable_animations`.
    extern fn adw_animation_set_follow_enable_animations_setting(p_self: *Animation, p_setting: c_int) void;
    pub const setFollowEnableAnimationsSetting = adw_animation_set_follow_enable_animations_setting;

    /// Sets the target `self` animates to `target`.
    extern fn adw_animation_set_target(p_self: *Animation, p_target: *adw.AnimationTarget) void;
    pub const setTarget = adw_animation_set_target;

    /// Skips the animation for `self`.
    ///
    /// If the animation hasn't been started yet, is playing, or is paused, instantly
    /// skips the animation to the end and causes `Animation.signals.done` to be
    /// emitted.
    ///
    /// Sets `Animation.properties.state` to `ADW_ANIMATION_FINISHED`.
    extern fn adw_animation_skip(p_self: *Animation) void;
    pub const skip = adw_animation_skip;

    extern fn adw_animation_get_type() usize;
    pub const getGObjectType = adw_animation_get_type;

    extern fn g_object_ref(p_self: *adw.Animation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Animation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Animation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a value `Animation` can animate.
pub const AnimationTarget = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.AnimationTargetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn adw_animation_target_get_type() usize;
    pub const getGObjectType = adw_animation_target_get_type;

    extern fn g_object_ref(p_self: *adw.AnimationTarget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.AnimationTarget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AnimationTarget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A base class for Adwaita applications.
///
/// `AdwApplication` handles library initialization by calling `init` in the
/// default `gio.Application.signals.startup` signal handler, in turn chaining up
/// as required by `gtk.Application`. Therefore, any subclass of
/// `AdwApplication` should always chain up its `startup` handler before using
/// any Adwaita or GTK API.
///
/// ## Automatic Resources
///
/// `AdwApplication` will automatically load stylesheets located in the
/// application's resource base path (see
/// `gio.Application.setResourceBasePath`, if they're present.
///
/// They can be used to add custom styles to the application, as follows:
///
/// - `style.css` contains styles that are always present.
///
/// - `style-dark.css` contains styles only used when
/// `StyleManager.properties.dark` is `TRUE`.
///
/// - `style-hc.css` contains styles used when the system high contrast
///   preference is enabled.
///
/// - `style-hc-dark.css` contains styles used when the system high contrast
///   preference is enabled and `StyleManager.properties.dark` is `TRUE`.
pub const Application = extern struct {
    pub const Parent = gtk.Application;
    pub const Implements = [_]type{ gio.ActionGroup, gio.ActionMap };
    pub const Class = adw.ApplicationClass;
    f_parent_instance: gtk.Application,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The style manager for this application.
        ///
        /// This is a convenience property allowing to access `AdwStyleManager` through
        /// property bindings or expressions.
        pub const style_manager = struct {
            pub const name = "style-manager";

            pub const Type = ?*adw.StyleManager;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwApplication`.
    ///
    /// If `application_id` is not `NULL`, then it must be valid. See
    /// `gio.Application.idIsValid`.
    ///
    /// If no application ID is given then some features (most notably application
    /// uniqueness) will be disabled.
    extern fn adw_application_new(p_application_id: ?[*:0]const u8, p_flags: gio.ApplicationFlags) *adw.Application;
    pub const new = adw_application_new;

    /// Gets the style manager for `self`.
    ///
    /// This is a convenience property allowing to access `AdwStyleManager` through
    /// property bindings or expressions.
    extern fn adw_application_get_style_manager(p_self: *Application) *adw.StyleManager;
    pub const getStyleManager = adw_application_get_style_manager;

    extern fn adw_application_get_type() usize;
    pub const getGObjectType = adw_application_get_type;

    extern fn g_object_ref(p_self: *adw.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A freeform application window.
///
/// <picture>
///   <source srcset="application-window-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="application-window.png" alt="application-window">
/// </picture>
///
/// `AdwApplicationWindow` is a `gtk.ApplicationWindow` subclass providing
/// the same features as `Window`.
///
/// See `Window` for details.
///
/// Example of an `AdwApplicationWindow` UI definition:
///
/// ```xml
/// <object class="AdwApplicationWindow">
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar"/>
///       </child>
///       <property name="content">
///         <!-- ... -->
///       </property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// Using `gtk.Application.properties.menubar` is not supported and may result in
/// visual glitches.
pub const ApplicationWindow = extern struct {
    pub const Parent = gtk.ApplicationWindow;
    pub const Implements = [_]type{ gio.ActionGroup, gio.ActionMap, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = adw.ApplicationWindowClass;
    f_parent_instance: gtk.ApplicationWindow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether adaptive preview is currently open.
        ///
        /// Adaptive preview is a debugging tool used for testing the window
        /// contents at specific screen sizes, simulating mobile environment.
        ///
        /// Adaptive preview can always be accessed from inspector. This function
        /// allows applications to open it manually.
        ///
        /// Most applications should not use this property.
        pub const adaptive_preview = struct {
            pub const name = "adaptive-preview";

            pub const Type = c_int;
        };

        /// The content widget.
        ///
        /// This property should always be used instead of `gtk.Window.properties.child`.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// The current breakpoint.
        pub const current_breakpoint = struct {
            pub const name = "current-breakpoint";

            pub const Type = ?*adw.Breakpoint;
        };

        /// The open dialogs.
        pub const dialogs = struct {
            pub const name = "dialogs";

            pub const Type = ?*gio.ListModel;
        };

        /// The currently visible dialog
        pub const visible_dialog = struct {
            pub const name = "visible-dialog";

            pub const Type = ?*adw.Dialog;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwApplicationWindow` for `app`.
    extern fn adw_application_window_new(p_app: *gtk.Application) *adw.ApplicationWindow;
    pub const new = adw_application_window_new;

    /// Adds `breakpoint` to `self`.
    extern fn adw_application_window_add_breakpoint(p_self: *ApplicationWindow, p_breakpoint: *adw.Breakpoint) void;
    pub const addBreakpoint = adw_application_window_add_breakpoint;

    /// Gets whether adaptive preview for `self` is currently open.
    extern fn adw_application_window_get_adaptive_preview(p_self: *ApplicationWindow) c_int;
    pub const getAdaptivePreview = adw_application_window_get_adaptive_preview;

    /// Gets the content widget of `self`.
    ///
    /// This method should always be used instead of `gtk.Window.getChild`.
    extern fn adw_application_window_get_content(p_self: *ApplicationWindow) ?*gtk.Widget;
    pub const getContent = adw_application_window_get_content;

    /// Gets the current breakpoint.
    extern fn adw_application_window_get_current_breakpoint(p_self: *ApplicationWindow) ?*adw.Breakpoint;
    pub const getCurrentBreakpoint = adw_application_window_get_current_breakpoint;

    /// Returns a `gio.ListModel` that contains the open dialogs of `self`.
    ///
    /// This can be used to keep an up-to-date view.
    extern fn adw_application_window_get_dialogs(p_self: *ApplicationWindow) *gio.ListModel;
    pub const getDialogs = adw_application_window_get_dialogs;

    /// Returns the currently visible dialog in `self`, if there's one.
    extern fn adw_application_window_get_visible_dialog(p_self: *ApplicationWindow) ?*adw.Dialog;
    pub const getVisibleDialog = adw_application_window_get_visible_dialog;

    /// Sets whether adaptive preview for `self` is currently open.
    ///
    /// Adaptive preview is a debugging tool used for testing the window
    /// contents at specific screen sizes, simulating mobile environment.
    ///
    /// Adaptive preview can always be accessed from inspector. This function
    /// allows applications to open it manually.
    ///
    /// Most applications should not use this function.
    extern fn adw_application_window_set_adaptive_preview(p_self: *ApplicationWindow, p_adaptive_preview: c_int) void;
    pub const setAdaptivePreview = adw_application_window_set_adaptive_preview;

    /// Sets the content widget of `self`.
    ///
    /// This method should always be used instead of `gtk.Window.setChild`.
    extern fn adw_application_window_set_content(p_self: *ApplicationWindow, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_application_window_set_content;

    extern fn adw_application_window_get_type() usize;
    pub const getGObjectType = adw_application_window_get_type;

    extern fn g_object_ref(p_self: *adw.ApplicationWindow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ApplicationWindow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ApplicationWindow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget displaying an image, with a generated fallback.
///
/// <picture>
///   <source srcset="avatar-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="avatar.png" alt="avatar">
/// </picture>
///
/// `AdwAvatar` is a widget that shows a round avatar.
///
/// `AdwAvatar` generates an avatar with the initials of  the
/// `Avatar.properties.text` on top of a colored background.
///
/// The color is picked based on the hash of the `Avatar.properties.text`.
///
/// If `Avatar.properties.show_initials` is set to `FALSE`,
/// `Avatar.properties.icon_name` or `avatar-default-symbolic` is shown instead of
/// the initials.
///
/// Use `Avatar.properties.custom_image` to set a custom image.
///
/// ## CSS nodes
///
/// `AdwAvatar` has a single CSS node with name `avatar`.
///
/// ## Accessibility
///
/// `AdwAvatar` uses the `GTK_ACCESSIBLE_ROLE_IMG` role.
pub const Avatar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.AvatarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// A custom image paintable.
        ///
        /// Custom image is displayed instead of initials or icon.
        pub const custom_image = struct {
            pub const name = "custom-image";

            pub const Type = ?*gdk.Paintable;
        };

        /// The name of an icon to use as a fallback.
        ///
        /// If no name is set, `avatar-default-symbolic` will be used.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether initials are used instead of an icon on the fallback avatar.
        ///
        /// See `Avatar.properties.icon_name` for how to change the fallback icon.
        pub const show_initials = struct {
            pub const name = "show-initials";

            pub const Type = c_int;
        };

        /// The size of the avatar.
        pub const size = struct {
            pub const name = "size";

            pub const Type = c_int;
        };

        /// Sets the text used to generate the fallback initials and color.
        ///
        /// It's only used to generate the color if `Avatar.properties.show_initials` is
        /// `FALSE`.
        pub const text = struct {
            pub const name = "text";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwAvatar`.
    extern fn adw_avatar_new(p_size: c_int, p_text: ?[*:0]const u8, p_show_initials: c_int) *adw.Avatar;
    pub const new = adw_avatar_new;

    /// Renders `self` into a `gdk.Texture` at `scale_factor`.
    ///
    /// This can be used to export the fallback avatar.
    extern fn adw_avatar_draw_to_texture(p_self: *Avatar, p_scale_factor: c_int) *gdk.Texture;
    pub const drawToTexture = adw_avatar_draw_to_texture;

    /// Gets the custom image paintable.
    extern fn adw_avatar_get_custom_image(p_self: *Avatar) ?*gdk.Paintable;
    pub const getCustomImage = adw_avatar_get_custom_image;

    /// Gets the name of an icon to use as a fallback.
    extern fn adw_avatar_get_icon_name(p_self: *Avatar) ?[*:0]const u8;
    pub const getIconName = adw_avatar_get_icon_name;

    /// Gets whether initials are used instead of an icon on the fallback avatar.
    extern fn adw_avatar_get_show_initials(p_self: *Avatar) c_int;
    pub const getShowInitials = adw_avatar_get_show_initials;

    /// Gets the size of the avatar.
    extern fn adw_avatar_get_size(p_self: *Avatar) c_int;
    pub const getSize = adw_avatar_get_size;

    /// Gets the text used to generate the fallback initials and color.
    extern fn adw_avatar_get_text(p_self: *Avatar) ?[*:0]const u8;
    pub const getText = adw_avatar_get_text;

    /// Sets the custom image paintable.
    ///
    /// Custom image is displayed instead of initials or icon.
    extern fn adw_avatar_set_custom_image(p_self: *Avatar, p_custom_image: ?*gdk.Paintable) void;
    pub const setCustomImage = adw_avatar_set_custom_image;

    /// Sets the name of an icon to use as a fallback.
    ///
    /// If no name is set, `avatar-default-symbolic` will be used.
    extern fn adw_avatar_set_icon_name(p_self: *Avatar, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_avatar_set_icon_name;

    /// Sets whether to use initials instead of an icon on the fallback avatar.
    ///
    /// See `Avatar.properties.icon_name` for how to change the fallback icon.
    extern fn adw_avatar_set_show_initials(p_self: *Avatar, p_show_initials: c_int) void;
    pub const setShowInitials = adw_avatar_set_show_initials;

    /// Sets the size of the avatar.
    extern fn adw_avatar_set_size(p_self: *Avatar, p_size: c_int) void;
    pub const setSize = adw_avatar_set_size;

    /// Sets the text used to generate the fallback initials and color.
    ///
    /// It's only used to generate the color if `Avatar.properties.show_initials` is
    /// `FALSE`.
    extern fn adw_avatar_set_text(p_self: *Avatar, p_text: ?[*:0]const u8) void;
    pub const setText = adw_avatar_set_text;

    extern fn adw_avatar_get_type() usize;
    pub const getGObjectType = adw_avatar_get_type;

    extern fn g_object_ref(p_self: *adw.Avatar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Avatar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Avatar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A bar with contextual information.
///
/// <picture>
///   <source srcset="banner-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="banner.png" alt="banner">
/// </picture>
///
/// Banners are hidden by default, use `Banner.properties.revealed` to show them.
///
/// Banners have a title, set with `Banner.properties.title`. Titles can be marked
/// up with Pango markup, use `Banner.properties.use_markup` to enable it.
///
/// The title will be shown centered or left-aligned depending on available
/// space.
///
/// Banners can optionally have a button with text on it, set through
/// `Banner.properties.button_label`. The button can be used with a `GAction`,
/// or with the `Banner.signals.button_clicked` signal. The button can have
/// different styles, a gray style and a suggested style.
///
/// <picture>
///   <source srcset="banner-suggested-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="banner-suggested.png" alt="banner with suggested button style">
/// </picture>
///
/// ## CSS nodes
///
/// `AdwBanner` has a main CSS node with the name `banner`.
pub const Banner = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.BannerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The label to show on the button.
        ///
        /// If set to `""` or `NULL`, the button won't be shown.
        ///
        /// The button can be used with a `GAction`, or with the
        /// `Banner.signals.button_clicked` signal.
        pub const button_label = struct {
            pub const name = "button-label";

            pub const Type = ?[*:0]u8;
        };

        /// The style class to use for the banner button.
        ///
        /// When set to `ADW_BANNER_BUTTON_DEFAULT`, the button stays grey.
        /// When set to `ADW_BANNER_BUTTON_SUGGESTED`, the button follows the [`.suggested-action`](style-classes.html`suggested`-action) style
        ///
        /// <picture>
        ///   <source srcset="banner-suggested-dark.png" media="(prefers-color-scheme: dark)">
        ///   <img src="banner-suggested.png" alt="banner with suggested button style">
        /// </picture>
        pub const button_style = struct {
            pub const name = "button-style";

            pub const Type = adw.BannerButtonStyle;
        };

        /// Whether the banner is currently revealed.
        pub const revealed = struct {
            pub const name = "revealed";

            pub const Type = c_int;
        };

        /// The title for this banner.
        ///
        /// See also: `Banner.properties.use_markup`.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether to use Pango markup for the banner title.
        ///
        /// See also `pango.parseMarkup`.
        pub const use_markup = struct {
            pub const name = "use-markup";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// This signal is emitted after the action button has been clicked.
        ///
        /// It can be used as an alternative to setting an action.
        pub const button_clicked = struct {
            pub const name = "button-clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Banner, p_instance))),
                    gobject.signalLookup("button-clicked", Banner.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwBanner`.
    extern fn adw_banner_new(p_title: [*:0]const u8) *adw.Banner;
    pub const new = adw_banner_new;

    /// Gets the button label for `self`.
    extern fn adw_banner_get_button_label(p_self: *Banner) ?[*:0]const u8;
    pub const getButtonLabel = adw_banner_get_button_label;

    /// Gets the style class in use for the banner button.
    extern fn adw_banner_get_button_style(p_self: *Banner) adw.BannerButtonStyle;
    pub const getButtonStyle = adw_banner_get_button_style;

    /// Gets if a banner is revealed
    extern fn adw_banner_get_revealed(p_self: *Banner) c_int;
    pub const getRevealed = adw_banner_get_revealed;

    /// Gets the title for `self`.
    extern fn adw_banner_get_title(p_self: *Banner) [*:0]const u8;
    pub const getTitle = adw_banner_get_title;

    /// Gets whether to use Pango markup for the banner title.
    extern fn adw_banner_get_use_markup(p_self: *Banner) c_int;
    pub const getUseMarkup = adw_banner_get_use_markup;

    /// Sets the button label for `self`.
    ///
    /// If set to `""` or `NULL`, the button won't be shown.
    ///
    /// The button can be used with a `GAction`, or with the
    /// `Banner.signals.button_clicked` signal.
    extern fn adw_banner_set_button_label(p_self: *Banner, p_label: ?[*:0]const u8) void;
    pub const setButtonLabel = adw_banner_set_button_label;

    /// Sets the style class to use for the banner button.
    ///
    /// When set to `ADW_BANNER_BUTTON_DEFAULT`, the button stays grey.
    /// When set to `ADW_BANNER_BUTTON_SUGGESTED`, the button follows the [`.suggested-action`](style-classes.html`suggested`-action) style
    ///
    /// <picture>
    ///   <source srcset="banner-suggested-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img src="banner-suggested.png" alt="banner with suggested button style">
    /// </picture>
    extern fn adw_banner_set_button_style(p_self: *Banner, p_style: adw.BannerButtonStyle) void;
    pub const setButtonStyle = adw_banner_set_button_style;

    /// Sets whether a banner should be revealed
    extern fn adw_banner_set_revealed(p_self: *Banner, p_revealed: c_int) void;
    pub const setRevealed = adw_banner_set_revealed;

    /// Sets the title for this banner.
    ///
    /// See also: `Banner.properties.use_markup`.
    extern fn adw_banner_set_title(p_self: *Banner, p_title: [*:0]const u8) void;
    pub const setTitle = adw_banner_set_title;

    /// Sets whether to use Pango markup for the banner title.
    ///
    /// See also `pango.parseMarkup`.
    extern fn adw_banner_set_use_markup(p_self: *Banner, p_use_markup: c_int) void;
    pub const setUseMarkup = adw_banner_set_use_markup;

    extern fn adw_banner_get_type() usize;
    pub const getGObjectType = adw_banner_get_type;

    extern fn g_object_ref(p_self: *adw.Banner) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Banner) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Banner, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget with one child.
///
/// <picture>
///   <source srcset="bin-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="bin.png" alt="bin">
/// </picture>
///
/// The `AdwBin` widget has only one child, set with the `Bin.properties.child`
/// property.
///
/// It is useful for deriving subclasses, since it provides common code needed
/// for handling a single child widget.
pub const Bin = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.BinClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget of the `AdwBin`.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwBin`.
    extern fn adw_bin_new() *adw.Bin;
    pub const new = adw_bin_new;

    /// Gets the child widget of `self`.
    extern fn adw_bin_get_child(p_self: *Bin) ?*gtk.Widget;
    pub const getChild = adw_bin_get_child;

    /// Sets the child widget of `self`.
    extern fn adw_bin_set_child(p_self: *Bin, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_bin_set_child;

    extern fn adw_bin_get_type() usize;
    pub const getGObjectType = adw_bin_get_type;

    extern fn g_object_ref(p_self: *adw.Bin) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Bin) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Bin, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A bottom sheet with an optional bottom bar.
///
/// <picture>
///   <source srcset="bottom-sheet-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="bottom-sheet.png" alt="bottom-sheet">
/// </picture>
///
/// `AdwBottomSheet` has three child widgets. `BottomSheet.properties.content` is
/// shown persistently. `BottomSheet.properties.sheet` is displayed above it when
/// it's open, and `BottomSheet.properties.bottom_bar` is displayed when it's not.
///
/// Bottom sheet and bottom bar are attached to the bottom edge of the widget.
/// They take the full width by default, but can only take a portion of it if
/// `BottomSheet.properties.full_width` is set to `FALSE`. In this case,
/// `BottomSheet.properties.@"align"` determines where along the bottom edge they are
/// placed.
///
/// Bottom bar can be hidden using the `BottomSheet.properties.reveal_bottom_bar`
/// property.
///
/// `AdwBottomSheet` can be useful for applications such as music players, that
/// want to have a persistent bottom bar that expands into a bottom sheet when
/// clicked. It's meant for cases where a bottom sheet is tightly integrated into
/// the UI. For more transient bottom sheets, see `Dialog`.
///
/// To open or close the bottom sheet, use the `BottomSheet.properties.open`
/// property.
///
/// By default, the bottom sheet has an overlaid drag handle. It can be disabled
/// by setting `BottomSheet.properties.show_drag_handle` to `FALSE`. Note that the
/// handle also controls whether the sheet can be dragged using a pointer.
///
/// Bottom sheets are modal by default, meaning that the content is dimmed and
/// cannot be accessed while the sheet is open. Set `BottomSheet.properties.modal`
/// to `FALSE` if this behavior is unwanted.
///
/// To disable user interactions for opening or closing the bottom sheet (such as
/// swipes or clicking the bottom bar or close button), set
/// `BottomSheet.properties.can_open` or `BottomSheet.properties.can_close` to
/// `FALSE`.
///
/// In some cases, particularly when using a full-width bottom bar, it may be
/// necessary to shift `BottomSheet.properties.content` upwards. Use the
/// `BottomSheet.properties.bottom_bar_height` and
/// `BottomSheet.properties.sheet_height` for that.
///
/// `AdwBottomSheet` is not adaptive, and for larger window sizes applications
/// may want to replace it with another UI, such as a sidebar. This can be done
/// using `MultiLayoutView`.
///
/// ## Sizing
///
/// Unlike `Dialog` presented as a bottom sheet, `AdwBottomSheet` just
/// follows the content's natural size, and it's up to the applications to make
/// sure their content provides one. For example, when using
/// `gtk.ScrolledWindow`, make sure to set
/// `gtk.ScrolledWindow.properties.propagate_natural_height` to `TRUE`.
///
/// ## Header Bar Integration
///
/// When placed inside an `AdwBottomSheet`, `HeaderBar` will not show the
/// title when `BottomSheet.properties.show_drag_handle` is `TRUE`, regardless of
/// `HeaderBar.properties.show_title`. This only applies to the default title,
/// titles set with `HeaderBar.properties.title_widget` will still be shown.
///
/// ## `AdwBottomSheet` as `GtkBuildable`:
///
/// The `AdwBottomSheet` implementation of the `gtk.Buildable` interface
/// supports setting the sheet widget by specifying “sheet” as the “type”
/// attribute of a `<child>` element, and the bottom bar by specifying
/// “bottom-bar”. Specifying “content” or omitting the child type results in
/// setting the content child.
pub const BottomSheet = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.BottomSheetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Horizontal alignment of the bottom sheet.
        ///
        /// 0 means the bottom sheet is flush with the start edge, 1 means it's flush
        /// with the end edge. 0.5 means it's centered.
        ///
        /// Only used when `BottomSheet.properties.full_width` is set to `FALSE`.
        pub const @"align" = struct {
            pub const name = "align";

            pub const Type = f32;
        };

        /// The bottom bar widget.
        ///
        /// Shown when `BottomSheet.properties.open` is `FALSE`. When open, morphs into
        /// the `BottomSheet.properties.sheet`.
        ///
        /// Bottom bar can be temporarily hidden using the
        /// `BottomSheet.properties.reveal_bottom_bar` property.
        pub const bottom_bar = struct {
            pub const name = "bottom-bar";

            pub const Type = ?*gtk.Widget;
        };

        /// The current bottom bar height.
        ///
        /// It can be used to shift the content upwards permanently to accommodate for
        /// the bottom bar.
        pub const bottom_bar_height = struct {
            pub const name = "bottom-bar-height";

            pub const Type = c_int;
        };

        /// Whether the bottom sheet can be closed by user.
        ///
        /// It can be closed via the close button, swiping down, pressing
        /// <kbd>Escape</kbd> or clicking the content dimming (when modal).
        ///
        /// Bottom sheet can still be closed using `BottomSheet.properties.open`.
        pub const can_close = struct {
            pub const name = "can-close";

            pub const Type = c_int;
        };

        /// Whether the bottom sheet can be opened by user.
        ///
        /// It can be opened via clicking or swiping up from the bottom bar.
        ///
        /// Does nothing if `BottomSheet.properties.bottom_bar` is not set.
        ///
        /// Bottom sheet can still be opened using `BottomSheet.properties.open`.
        pub const can_open = struct {
            pub const name = "can-open";

            pub const Type = c_int;
        };

        /// The content widget.
        ///
        /// It's always shown, and the bottom sheet is overlaid over it.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the bottom sheet takes the full width.
        ///
        /// When full width, `BottomSheet.properties.@"align"` is ignored.
        pub const full_width = struct {
            pub const name = "full-width";

            pub const Type = c_int;
        };

        /// Whether the bottom sheet is modal.
        ///
        /// When modal, `BottomSheet.properties.content` will be dimmed when the bottom
        /// sheet is open, and clicking it will close the bottom sheet. It also cannot
        /// be focused with keyboard.
        ///
        /// Otherwise, the content is accessible even when the bottom sheet is open.
        pub const modal = struct {
            pub const name = "modal";

            pub const Type = c_int;
        };

        /// Whether the bottom sheet is open.
        pub const open = struct {
            pub const name = "open";

            pub const Type = c_int;
        };

        /// Whether to reveal the bottom bar.
        ///
        /// The transition will be animated.
        ///
        /// See `BottomSheet.properties.bottom_bar` and
        /// `BottomSheet.properties.bottom_bar_height`.
        pub const reveal_bottom_bar = struct {
            pub const name = "reveal-bottom-bar";

            pub const Type = c_int;
        };

        /// The bottom sheet widget.
        ///
        /// Only shown when `BottomSheet.properties.open` is `TRUE`.
        pub const sheet = struct {
            pub const name = "sheet";

            pub const Type = ?*gtk.Widget;
        };

        /// The current bottom sheet height.
        ///
        /// It can be used to shift the content upwards when the bottom sheet is open.
        pub const sheet_height = struct {
            pub const name = "sheet-height";

            pub const Type = c_int;
        };

        /// Whether to overlay a drag handle in the bottom sheet.
        ///
        /// The handle will be overlaid over `BottomSheet.properties.sheet`.
        ///
        /// When the handle is shown, `HeaderBar` will hide its default title,
        /// and `ToolbarView` will reserve space if there are no top bars.
        ///
        /// Showing drag handle also allows to swipe the bottom sheet down (and to
        /// swipe the bottom bar up) with a pointer, instead of just touchscreen.
        pub const show_drag_handle = struct {
            pub const name = "show-drag-handle";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when the close button or shortcut is used while
        /// `Dialog.properties.can_close` is set to `FALSE`.
        pub const close_attempt = struct {
            pub const name = "close-attempt";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(BottomSheet, p_instance))),
                    gobject.signalLookup("close-attempt", BottomSheet.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwBottomSheet`.
    extern fn adw_bottom_sheet_new() *adw.BottomSheet;
    pub const new = adw_bottom_sheet_new;

    /// Gets horizontal alignment of the bottom sheet.
    extern fn adw_bottom_sheet_get_align(p_self: *BottomSheet) f32;
    pub const getAlign = adw_bottom_sheet_get_align;

    /// Gets the bottom bar widget for `self`.
    extern fn adw_bottom_sheet_get_bottom_bar(p_self: *BottomSheet) ?*gtk.Widget;
    pub const getBottomBar = adw_bottom_sheet_get_bottom_bar;

    /// Gets the current bottom bar height.
    ///
    /// It can be used to shift the content upwards permanently to accommodate for
    /// the bottom bar.
    extern fn adw_bottom_sheet_get_bottom_bar_height(p_self: *BottomSheet) c_int;
    pub const getBottomBarHeight = adw_bottom_sheet_get_bottom_bar_height;

    /// Gets whether the bottom sheet can be closed by user.
    extern fn adw_bottom_sheet_get_can_close(p_self: *BottomSheet) c_int;
    pub const getCanClose = adw_bottom_sheet_get_can_close;

    /// Gets whether the bottom sheet can be opened by user.
    extern fn adw_bottom_sheet_get_can_open(p_self: *BottomSheet) c_int;
    pub const getCanOpen = adw_bottom_sheet_get_can_open;

    /// Gets the content widget for `self`.
    extern fn adw_bottom_sheet_get_content(p_self: *BottomSheet) ?*gtk.Widget;
    pub const getContent = adw_bottom_sheet_get_content;

    /// Gets whether the bottom sheet takes the full width.
    extern fn adw_bottom_sheet_get_full_width(p_self: *BottomSheet) c_int;
    pub const getFullWidth = adw_bottom_sheet_get_full_width;

    /// Gets whether the bottom sheet is modal.
    extern fn adw_bottom_sheet_get_modal(p_self: *BottomSheet) c_int;
    pub const getModal = adw_bottom_sheet_get_modal;

    /// Gets whether the bottom sheet is open.
    extern fn adw_bottom_sheet_get_open(p_self: *BottomSheet) c_int;
    pub const getOpen = adw_bottom_sheet_get_open;

    /// Gets whether the bottom bar is revealed.
    extern fn adw_bottom_sheet_get_reveal_bottom_bar(p_self: *BottomSheet) c_int;
    pub const getRevealBottomBar = adw_bottom_sheet_get_reveal_bottom_bar;

    /// Gets the bottom sheet widget for `self`.
    extern fn adw_bottom_sheet_get_sheet(p_self: *BottomSheet) ?*gtk.Widget;
    pub const getSheet = adw_bottom_sheet_get_sheet;

    /// Gets the current bottom sheet height.
    ///
    /// It can be used to shift the content upwards when the bottom sheet is open.
    extern fn adw_bottom_sheet_get_sheet_height(p_self: *BottomSheet) c_int;
    pub const getSheetHeight = adw_bottom_sheet_get_sheet_height;

    /// Gets whether to show a drag handle in the bottom sheet.
    extern fn adw_bottom_sheet_get_show_drag_handle(p_self: *BottomSheet) c_int;
    pub const getShowDragHandle = adw_bottom_sheet_get_show_drag_handle;

    /// Sets horizontal alignment of the bottom sheet.
    ///
    /// 0 means the bottom sheet is flush with the start edge, 1 means it's flush
    /// with the end edge. 0.5 means it's centered.
    ///
    /// Only used when `BottomSheet.properties.full_width` is set to `FALSE`.
    extern fn adw_bottom_sheet_set_align(p_self: *BottomSheet, p_align: f32) void;
    pub const setAlign = adw_bottom_sheet_set_align;

    /// Sets the bottom bar widget for `self`.
    ///
    /// Shown when `BottomSheet.properties.open` is `FALSE`. When open, morphs into
    /// the `BottomSheet.properties.sheet`.
    ///
    /// Bottom bar can be temporarily hidden using the
    /// `BottomSheet.properties.reveal_bottom_bar` property.
    extern fn adw_bottom_sheet_set_bottom_bar(p_self: *BottomSheet, p_bottom_bar: ?*gtk.Widget) void;
    pub const setBottomBar = adw_bottom_sheet_set_bottom_bar;

    /// Sets whether the bottom sheet can be closed by user.
    ///
    /// It can be closed via the close button, swiping down, pressing
    /// <kbd>Escape</kbd> or clicking the content dimming (when modal).
    ///
    /// Bottom sheet can still be closed using `BottomSheet.properties.open`.
    extern fn adw_bottom_sheet_set_can_close(p_self: *BottomSheet, p_can_close: c_int) void;
    pub const setCanClose = adw_bottom_sheet_set_can_close;

    /// Sets whether the bottom sheet can be opened by user.
    ///
    /// It can be opened via clicking or swiping up from the bottom bar.
    ///
    /// Does nothing if `BottomSheet.properties.bottom_bar` is not set.
    ///
    /// Bottom sheet can still be opened using `BottomSheet.properties.open`.
    extern fn adw_bottom_sheet_set_can_open(p_self: *BottomSheet, p_can_open: c_int) void;
    pub const setCanOpen = adw_bottom_sheet_set_can_open;

    /// Sets the content widget for `self`.
    ///
    /// It's always shown, and the bottom sheet is overlaid over it.
    extern fn adw_bottom_sheet_set_content(p_self: *BottomSheet, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_bottom_sheet_set_content;

    /// Sets whether the bottom sheet takes the full width.
    ///
    /// When full width, `BottomSheet.properties.@"align"` is ignored.
    extern fn adw_bottom_sheet_set_full_width(p_self: *BottomSheet, p_full_width: c_int) void;
    pub const setFullWidth = adw_bottom_sheet_set_full_width;

    /// Sets whether the bottom sheet is modal.
    ///
    /// When modal, `BottomSheet.properties.content` will be dimmed when the bottom
    /// sheet is open, and clicking it will close the bottom sheet. It also cannot be
    /// focused with keyboard.
    ///
    /// Otherwise, the content is accessible even when the bottom sheet is open.
    extern fn adw_bottom_sheet_set_modal(p_self: *BottomSheet, p_modal: c_int) void;
    pub const setModal = adw_bottom_sheet_set_modal;

    /// Sets whether the bottom sheet is open.
    extern fn adw_bottom_sheet_set_open(p_self: *BottomSheet, p_open: c_int) void;
    pub const setOpen = adw_bottom_sheet_set_open;

    /// Sets whether to reveal the bottom bar.
    ///
    /// The transition will be animated.
    ///
    /// See `BottomSheet.properties.bottom_bar` and
    /// `BottomSheet.properties.bottom_bar_height`.
    extern fn adw_bottom_sheet_set_reveal_bottom_bar(p_self: *BottomSheet, p_reveal: c_int) void;
    pub const setRevealBottomBar = adw_bottom_sheet_set_reveal_bottom_bar;

    /// Sets the bottom sheet widget for `self`.
    ///
    /// Only shown when `BottomSheet.properties.open` is `TRUE`.
    extern fn adw_bottom_sheet_set_sheet(p_self: *BottomSheet, p_sheet: ?*gtk.Widget) void;
    pub const setSheet = adw_bottom_sheet_set_sheet;

    /// Sets whether to show a drag handle in the bottom sheet.
    ///
    /// The handle will be overlaid over `BottomSheet.properties.sheet`.
    ///
    /// When the handle is shown, `HeaderBar` will hide its default title, and
    /// `ToolbarView` will reserve space if there are no top bars.
    ///
    /// Showing drag handle also allows to swipe the bottom sheet down (and to swipe
    /// the bottom bar up) with a pointer, instead of just touchscreen.
    extern fn adw_bottom_sheet_set_show_drag_handle(p_self: *BottomSheet, p_show_drag_handle: c_int) void;
    pub const setShowDragHandle = adw_bottom_sheet_set_show_drag_handle;

    extern fn adw_bottom_sheet_get_type() usize;
    pub const getGObjectType = adw_bottom_sheet_get_type;

    extern fn g_object_ref(p_self: *adw.BottomSheet) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.BottomSheet) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BottomSheet, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a breakpoint for `Window` or `Dialog`.
///
/// Breakpoints are used to create adaptive UI, allowing to change the layout
/// depending on available size.
///
/// Breakpoint is a size threshold, specified by its condition, as well as one or
/// more setters.
///
/// Each setter has a target object, a property and a value. When a breakpoint
/// is applied, each setter sets the target property on their target object to
/// the specified value, and reset it back to the original value when it's
/// unapplied.
///
/// For more complicated scenarios, `Breakpoint.signals.apply` and
/// `Breakpoint.signals.unapply` can be used instead.
///
/// Breakpoints can be used within `Window`, `ApplicationWindow`,
/// `Dialog` or `BreakpointBin`.
///
/// ## `AdwBreakpoint` as `GtkBuildable`:
///
/// `AdwBreakpoint` supports specifying its condition via the `<condition>`
/// element. The contents of the element must be a string in a format accepted by
/// `BreakpointCondition.parse`.
///
/// It also supports adding setters via the `<setter>` element. Each `<setter>`
/// element must have the `object` attribute specifying the target object, and
/// the `property` attribute specifying the property name. The contents of the
/// element are used as the setter value.
///
/// For `G_TYPE_OBJECT` and `G_TYPE_BOXED` derived properties, empty contents are
/// treated as `NULL`.
///
/// Setter values can be translated with the usual `translatable`, `context` and
/// `comments` attributes.
///
/// Example of an `AdwBreakpoint` UI definition:
///
/// ```xml
/// <object class="AdwBreakpoint">
///   <condition>max-width: 400px</condition>
///   <setter object="button" property="visible">True</setter>
///   <setter object="box" property="orientation">vertical</setter>
///   <setter object="page" property="title" translatable="yes">Example</setter>
/// </object>
/// ```
pub const Breakpoint = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.Buildable};
    pub const Class = adw.BreakpointClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The breakpoint's condition.
        pub const condition = struct {
            pub const name = "condition";

            pub const Type = ?*adw.BreakpointCondition;
        };
    };

    pub const signals = struct {
        /// Emitted when the breakpoint is applied.
        ///
        /// This signal is emitted after the setters have been applied.
        pub const apply = struct {
            pub const name = "apply";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Breakpoint, p_instance))),
                    gobject.signalLookup("apply", Breakpoint.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the breakpoint is unapplied.
        ///
        /// This signal is emitted before resetting the setter values.
        pub const unapply = struct {
            pub const name = "unapply";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Breakpoint, p_instance))),
                    gobject.signalLookup("unapply", Breakpoint.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwBreakpoint` with `condition`.
    extern fn adw_breakpoint_new(p_condition: *adw.BreakpointCondition) *adw.Breakpoint;
    pub const new = adw_breakpoint_new;

    /// Adds a setter to `self`.
    ///
    /// The setter will automatically set `property` on `object` to `value` when
    /// applying the breakpoint, and set it back to its original value upon
    /// unapplying it.
    ///
    /// ::: note
    ///     Setting properties to their original values does not work for properties
    ///     that have irreversible side effects. For example, changing
    ///     `gtk.Button.properties.label` while `gtk.Button.properties.icon_name` is set
    ///     will reset the icon. However, resetting the label will not set
    ///     `icon-name` to its original value.
    ///
    /// Use the `Breakpoint.signals.apply` and `Breakpoint.signals.unapply` signals
    /// for those properties instead, as follows:
    ///
    /// ```c
    /// static void
    /// breakpoint_apply_cb (MyWidget *self)
    /// {
    ///   gtk_button_set_icon_name (self->button, "go-previous-symbolic");
    /// }
    ///
    /// static void
    /// breakpoint_apply_cb (MyWidget *self)
    /// {
    ///   gtk_button_set_label (self->button, _("_Back"));
    /// }
    ///
    /// // ...
    ///
    /// g_signal_connect_swapped (breakpoint, "apply",
    ///                           G_CALLBACK (breakpoint_apply_cb), self);
    /// g_signal_connect_swapped (breakpoint, "unapply",
    ///                           G_CALLBACK (breakpoint_unapply_cb), self);
    /// ```
    extern fn adw_breakpoint_add_setter(p_self: *Breakpoint, p_object: *gobject.Object, p_property: [*:0]const u8, p_value: ?*const gobject.Value) void;
    pub const addSetter = adw_breakpoint_add_setter;

    /// Adds multiple setters to `self`.
    ///
    /// See `Breakpoint.addSetter`.
    ///
    /// Example:
    ///
    /// ```c
    /// adw_breakpoint_add_setters (breakpoint,
    ///                             G_OBJECT (box), "orientation", GTK_ORIENTATION_VERTICAL,
    ///                             G_OBJECT (button), "halign", GTK_ALIGN_FILL,
    ///                             G_OBJECT (button), "valign", GTK_ALIGN_END,
    ///                             NULL);
    /// ```
    extern fn adw_breakpoint_add_setters(p_self: *Breakpoint, p_first_object: *gobject.Object, p_first_property: [*:0]const u8, ...) void;
    pub const addSetters = adw_breakpoint_add_setters;

    /// Adds multiple setters to `self`.
    ///
    /// See `Breakpoint.addSetters`.
    extern fn adw_breakpoint_add_setters_valist(p_self: *Breakpoint, p_first_object: *gobject.Object, p_first_property: [*:0]const u8, p_args: std.builtin.VaList) void;
    pub const addSettersValist = adw_breakpoint_add_setters_valist;

    /// Adds `n_setters` setters to `self`.
    ///
    /// This is a convenience function for adding multiple setters at once.
    ///
    /// See `Breakpoint.addSetter`.
    ///
    /// This function is meant to be used by language bindings.
    extern fn adw_breakpoint_add_settersv(p_self: *Breakpoint, p_n_setters: c_int, p_objects: [*]*gobject.Object, p_names: [*][*:0]const u8, p_values: [*]*const gobject.Value) void;
    pub const addSettersv = adw_breakpoint_add_settersv;

    /// Gets the condition for `self`.
    extern fn adw_breakpoint_get_condition(p_self: *Breakpoint) ?*adw.BreakpointCondition;
    pub const getCondition = adw_breakpoint_get_condition;

    /// Sets the condition for `self`.
    extern fn adw_breakpoint_set_condition(p_self: *Breakpoint, p_condition: ?*adw.BreakpointCondition) void;
    pub const setCondition = adw_breakpoint_set_condition;

    extern fn adw_breakpoint_get_type() usize;
    pub const getGObjectType = adw_breakpoint_get_type;

    extern fn g_object_ref(p_self: *adw.Breakpoint) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Breakpoint) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Breakpoint, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget that changes layout based on available size.
///
/// <picture>
///   <source srcset="breakpoint-bin-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="breakpoint-bin.png" alt="breakpoint-bin">
/// </picture>
///
/// `AdwBreakpointBin` provides a way to use breakpoints without `Window`,
/// `ApplicationWindow` or `Dialog`. It can be useful for limiting
/// breakpoints to a single page and similar purposes. Most applications
/// shouldn't need it.
///
/// `AdwBreakpointBin` is similar to `Bin`. It has one child, set via the
/// `BreakpointBin.properties.child` property.
///
/// When `AdwBreakpointBin` is resized, its child widget can rearrange its layout
/// at specific thresholds.
///
/// The thresholds and layout changes are defined via `Breakpoint` objects.
/// They can be added using `BreakpointBin.addBreakpoint`.
///
/// Each breakpoint has a condition, specifying the bin's size and/or aspect
/// ratio, and setters that automatically set object properties when that
/// happens. The `Breakpoint.signals.apply` and `Breakpoint.signals.unapply` can
/// be used instead for more complex scenarios.
///
/// Breakpoints are only allowed to modify widgets inside the `AdwBreakpointBin`,
/// but not on the `AdwBreakpointBin` itself or any other widgets.
///
/// If multiple breakpoints can be used for the current size, the last one is
/// always picked. The current breakpoint can be tracked using the
/// `BreakpointBin.properties.current_breakpoint` property.
///
/// If none of the breakpoints can be used, that property will be set to `NULL`,
/// and the original property values will be used instead.
///
/// ## Minimum Size
///
/// Adding a breakpoint to `AdwBreakpointBin` will result in it having no minimum
/// size. The `gtk.Widget.properties.width_request` and
/// `gtk.Widget.properties.height_request` properties must always be set when using
/// breakpoints, indicating the smallest size you want to support.
///
/// The minimum size and breakpoint conditions must be carefully selected so that
/// the child widget completely fits. If it doesn't, it will overflow and a
/// warning message will be printed.
///
/// When choosing minimum size, consider translations and text scale factor
/// changes. Make sure to leave enough space for text labels, and enable
/// ellipsizing or wrapping if they might not fit.
///
/// For `gtk.Label` this can be done via `gtk.Label.properties.ellipsize`, or
/// via `gtk.Label.properties.wrap` together with `gtk.Label.properties.wrap_mode`.
///
/// For buttons, use `gtk.Button.properties.can_shrink`,
/// `gtk.MenuButton.properties.can_shrink`, `adw.SplitButton.properties.can_shrink`,
/// or `adw.ButtonContent.properties.can_shrink`.
///
/// ## Example
///
/// ```c
/// GtkWidget *bin, *child;
/// AdwBreakpoint *breakpoint;
///
/// bin = adw_breakpoint_bin_new ();
/// gtk_widget_set_size_request (bin, 150, 150);
///
/// child = gtk_label_new ("Wide");
/// gtk_label_set_ellipsize (GTK_LABEL (label), PANGO_ELLIPSIZE_END);
/// gtk_widget_add_css_class (child, "title-1");
/// adw_breakpoint_bin_set_child (ADW_BREAKPOINT_BIN (bin), child);
///
/// breakpoint = adw_breakpoint_new (adw_breakpoint_condition_parse ("max-width: 200px"));
/// adw_breakpoint_add_setters (breakpoint,
///                             G_OBJECT (child), "label", "Narrow",
///                             NULL);
/// adw_breakpoint_bin_add_breakpoint (ADW_BREAKPOINT_BIN (bin), breakpoint);
/// ```
///
/// The bin has a single label inside it, displaying "Wide". When the bin's width
/// is smaller than or equal to 200px, it changes to "Narrow".
///
/// ## `AdwBreakpointBin` as `GtkBuildable`
///
/// `AdwBreakpointBin` allows adding `AdwBreakpoint` objects as children.
///
/// Example of an `AdwBreakpointBin` UI definition:
///
/// ```xml
/// <object class="AdwBreakpointBin">
///   <property name="width-request">150</property>
///   <property name="height-request">150</property>
///   <property name="child">
///     <object class="GtkLabel" id="child">
///       <property name="label">Wide</property>
///       <property name="ellipsize">end</property>
///       <style>
///         <class name="title-1"/>
///       </style>
///     </object>
///   </property>
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 200px</condition>
///       <setter object="child" property="label">Narrow</setter>
///     </object>
///   </child>
/// </object>
/// ```
///
/// See `Breakpoint` documentation for details.
pub const BreakpointBin = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.BreakpointBinClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The current breakpoint.
        pub const current_breakpoint = struct {
            pub const name = "current-breakpoint";

            pub const Type = ?*adw.Breakpoint;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwBreakpointBin`.
    extern fn adw_breakpoint_bin_new() *adw.BreakpointBin;
    pub const new = adw_breakpoint_bin_new;

    /// Adds `breakpoint` to `self`.
    extern fn adw_breakpoint_bin_add_breakpoint(p_self: *BreakpointBin, p_breakpoint: *adw.Breakpoint) void;
    pub const addBreakpoint = adw_breakpoint_bin_add_breakpoint;

    /// Gets the child widget of `self`.
    extern fn adw_breakpoint_bin_get_child(p_self: *BreakpointBin) ?*gtk.Widget;
    pub const getChild = adw_breakpoint_bin_get_child;

    /// Gets the current breakpoint.
    extern fn adw_breakpoint_bin_get_current_breakpoint(p_self: *BreakpointBin) ?*adw.Breakpoint;
    pub const getCurrentBreakpoint = adw_breakpoint_bin_get_current_breakpoint;

    /// Removes `breakpoint` from `self`.
    extern fn adw_breakpoint_bin_remove_breakpoint(p_self: *BreakpointBin, p_breakpoint: *adw.Breakpoint) void;
    pub const removeBreakpoint = adw_breakpoint_bin_remove_breakpoint;

    /// Sets the child widget of `self`.
    extern fn adw_breakpoint_bin_set_child(p_self: *BreakpointBin, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_breakpoint_bin_set_child;

    extern fn adw_breakpoint_bin_get_type() usize;
    pub const getGObjectType = adw_breakpoint_bin_get_type;

    extern fn g_object_ref(p_self: *adw.BreakpointBin) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.BreakpointBin) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BreakpointBin, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A helper widget for creating buttons.
///
/// <picture>
///   <source srcset="button-content-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="button-content.png" alt="button-content">
/// </picture>
///
/// `AdwButtonContent` is a box-like widget with an icon and a label.
///
/// It's intended to be used as a direct child of `gtk.Button`,
/// `gtk.MenuButton` or `SplitButton`, when they need to have both an
/// icon and a label, as follows:
///
/// ```xml
/// <object class="GtkButton">
///   <property name="child">
///     <object class="AdwButtonContent">
///       <property name="icon-name">document-open-symbolic</property>
///       <property name="label" translatable="yes">_Open</property>
///       <property name="use-underline">True</property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// `AdwButtonContent` handles style classes and connecting the mnemonic to the
/// button automatically.
///
/// ## CSS nodes
///
/// ```
/// buttoncontent
/// ╰── box
///     ├── image
///     ╰── label
/// ```
///
/// `AdwButtonContent`'s CSS node is called `buttoncontent`. It contains a `box`
/// subnode that serves as a container for the  `image` and `label` nodes.
///
/// When inside a `GtkButton` or `AdwSplitButton`, the button will receive the
/// `.image-text-button` style class. When inside a `GtkMenuButton`, the
/// internal `GtkButton` will receive it instead.
///
/// ## Accessibility
///
/// `AdwButtonContent` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const ButtonContent = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ButtonContentClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the button can be smaller than the natural size of its contents.
        ///
        /// If set to `TRUE`, the label will ellipsize.
        ///
        /// See `gtk.Button.properties.can_shrink`.
        pub const can_shrink = struct {
            pub const name = "can-shrink";

            pub const Type = c_int;
        };

        /// The name of the displayed icon.
        ///
        /// If empty, the icon is not shown.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The displayed label.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// Whether an underline in the text indicates a mnemonic.
        ///
        /// The mnemonic can be used to activate the parent button.
        ///
        /// See `ButtonContent.properties.label`.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwButtonContent`.
    extern fn adw_button_content_new() *adw.ButtonContent;
    pub const new = adw_button_content_new;

    /// gets whether the button can be smaller than the natural size of its contents.
    extern fn adw_button_content_get_can_shrink(p_self: *ButtonContent) c_int;
    pub const getCanShrink = adw_button_content_get_can_shrink;

    /// Gets the name of the displayed icon.
    extern fn adw_button_content_get_icon_name(p_self: *ButtonContent) [*:0]const u8;
    pub const getIconName = adw_button_content_get_icon_name;

    /// Gets the displayed label.
    extern fn adw_button_content_get_label(p_self: *ButtonContent) [*:0]const u8;
    pub const getLabel = adw_button_content_get_label;

    /// Gets whether an underline in the text indicates a mnemonic.
    extern fn adw_button_content_get_use_underline(p_self: *ButtonContent) c_int;
    pub const getUseUnderline = adw_button_content_get_use_underline;

    /// Sets whether the button can be smaller than the natural size of its contents.
    ///
    /// If set to `TRUE`, the label will ellipsize.
    ///
    /// See `gtk.Button.setCanShrink`.
    extern fn adw_button_content_set_can_shrink(p_self: *ButtonContent, p_can_shrink: c_int) void;
    pub const setCanShrink = adw_button_content_set_can_shrink;

    /// Sets the name of the displayed icon.
    ///
    /// If empty, the icon is not shown.
    extern fn adw_button_content_set_icon_name(p_self: *ButtonContent, p_icon_name: [*:0]const u8) void;
    pub const setIconName = adw_button_content_set_icon_name;

    /// Sets the displayed label.
    extern fn adw_button_content_set_label(p_self: *ButtonContent, p_label: [*:0]const u8) void;
    pub const setLabel = adw_button_content_set_label;

    /// Sets whether an underline in the text indicates a mnemonic.
    ///
    /// The mnemonic can be used to activate the parent button.
    ///
    /// See `ButtonContent.properties.label`.
    extern fn adw_button_content_set_use_underline(p_self: *ButtonContent, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_button_content_set_use_underline;

    extern fn adw_button_content_get_type() usize;
    pub const getGObjectType = adw_button_content_get_type;

    extern fn g_object_ref(p_self: *adw.ButtonContent) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ButtonContent) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ButtonContent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` that looks like a button.
///
/// <picture>
///   <source srcset="button-rows-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="button-rows.png" alt="button-rows">
/// </picture>
///
/// The `AdwButtonRow` widget has a title and two icons: before and after the
/// title.
///
/// It is convenient for presenting actions like "Delete" at the end of a boxed
/// list.
///
/// `AdwButtonRow` is always activatable.
///
/// ## CSS nodes
///
/// `AdwButtonRow` has a main CSS node with name `row` and the style class
/// `.button`.
///
/// It contains the subnode `box` for its main horizontal box, which contains the
/// nodes: `image.icon.start` for the start icon, `label.title` for the title,
/// and `image.icon.end` for the end icon.
///
/// ## Style classes
///
/// The [`.suggested-action`](style-classes.html`suggested`-action) style class
/// makes `AdwButtonRow` use accent color for its background. It should be used
/// very sparingly to denote important buttons.
///
/// <picture>
///   <source srcset="button-row-suggested-action-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="button-row-suggested-action.png" alt="button-row-suggested-action">
/// </picture>
///
/// The [`.destructive-action`](style-classes.html`destructive`-action) style
/// makes the row use destructive colors. It can be used to draw attention to the
/// potentially damaging consequences of using it. This style acts as a warning
/// to the user.
///
/// <picture>
///   <source srcset="button-row-destructive-action-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="button-row-destructive-action.png" alt="button-row-destructive-action">
/// </picture>
pub const ButtonRow = opaque {
    pub const Parent = adw.PreferencesRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ButtonRowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The icon name to show after the title.
        pub const end_icon_name = struct {
            pub const name = "end-icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The icon name to show before the title.
        pub const start_icon_name = struct {
            pub const name = "start-icon-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// This signal is emitted after the row has been activated.
        pub const activated = struct {
            pub const name = "activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ButtonRow, p_instance))),
                    gobject.signalLookup("activated", ButtonRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwButtonRow`.
    extern fn adw_button_row_new() *adw.ButtonRow;
    pub const new = adw_button_row_new;

    /// Gets the end icon name for `self`.
    extern fn adw_button_row_get_end_icon_name(p_self: *ButtonRow) ?[*:0]const u8;
    pub const getEndIconName = adw_button_row_get_end_icon_name;

    /// Gets the start icon name for `self`.
    extern fn adw_button_row_get_start_icon_name(p_self: *ButtonRow) ?[*:0]const u8;
    pub const getStartIconName = adw_button_row_get_start_icon_name;

    /// Sets the end icon name for `self`.
    extern fn adw_button_row_set_end_icon_name(p_self: *ButtonRow, p_icon_name: ?[*:0]const u8) void;
    pub const setEndIconName = adw_button_row_set_end_icon_name;

    /// Sets the start icon name for `self`.
    extern fn adw_button_row_set_start_icon_name(p_self: *ButtonRow, p_icon_name: ?[*:0]const u8) void;
    pub const setStartIconName = adw_button_row_set_start_icon_name;

    extern fn adw_button_row_get_type() usize;
    pub const getGObjectType = adw_button_row_get_type;

    extern fn g_object_ref(p_self: *adw.ButtonRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ButtonRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ButtonRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An `AnimationTarget` that calls a given callback during the
/// animation.
pub const CallbackAnimationTarget = opaque {
    pub const Parent = adw.AnimationTarget;
    pub const Implements = [_]type{};
    pub const Class = adw.CallbackAnimationTargetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `AdwAnimationTarget` that calls the given `callback` during
    /// the animation.
    extern fn adw_callback_animation_target_new(p_callback: adw.AnimationTargetFunc, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) *adw.CallbackAnimationTarget;
    pub const new = adw_callback_animation_target_new;

    extern fn adw_callback_animation_target_get_type() usize;
    pub const getGObjectType = adw_callback_animation_target_get_type;

    extern fn g_object_ref(p_self: *adw.CallbackAnimationTarget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.CallbackAnimationTarget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CallbackAnimationTarget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A paginated scrolling widget.
///
/// <picture>
///   <source srcset="carousel-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="carousel.png" alt="carousel">
/// </picture>
///
/// The `AdwCarousel` widget can be used to display a set of pages with
/// swipe-based navigation between them.
///
/// `CarouselIndicatorDots` and `CarouselIndicatorLines` can be used
/// to provide page indicators for `AdwCarousel`.
///
/// ## CSS nodes
///
/// `AdwCarousel` has a single CSS node with name `carousel`.
pub const Carousel = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.CarouselClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to allow swiping for more than one page at a time.
        ///
        /// If the value is `FALSE`, each swipe can only move to the adjacent pages.
        pub const allow_long_swipes = struct {
            pub const name = "allow-long-swipes";

            pub const Type = c_int;
        };

        /// Sets whether the `AdwCarousel` can be dragged with mouse pointer.
        ///
        /// If the value is `FALSE`, dragging is only available on touch.
        pub const allow_mouse_drag = struct {
            pub const name = "allow-mouse-drag";

            pub const Type = c_int;
        };

        /// Whether the widget will respond to scroll wheel events.
        ///
        /// If the value is `FALSE`, wheel events will be ignored.
        pub const allow_scroll_wheel = struct {
            pub const name = "allow-scroll-wheel";

            pub const Type = c_int;
        };

        /// Whether the carousel can be navigated.
        ///
        /// This can be used to temporarily disable the carousel to only allow
        /// navigating it in a certain state.
        pub const interactive = struct {
            pub const name = "interactive";

            pub const Type = c_int;
        };

        /// The number of pages in a `AdwCarousel`.
        pub const n_pages = struct {
            pub const name = "n-pages";

            pub const Type = c_uint;
        };

        /// Current scrolling position, unitless.
        ///
        /// 1 matches 1 page. Use `Carousel.scrollTo` for changing it.
        pub const position = struct {
            pub const name = "position";

            pub const Type = f64;
        };

        /// Page reveal duration, in milliseconds.
        ///
        /// Reveal duration is used when animating adding or removing pages.
        pub const reveal_duration = struct {
            pub const name = "reveal-duration";

            pub const Type = c_uint;
        };

        /// Scroll animation spring parameters.
        ///
        /// The default value is equivalent to:
        ///
        /// ```c
        /// adw_spring_params_new (1, 0.5, 500)
        /// ```
        pub const scroll_params = struct {
            pub const name = "scroll-params";

            pub const Type = ?*adw.SpringParams;
        };

        /// Spacing between pages in pixels.
        pub const spacing = struct {
            pub const name = "spacing";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {
        /// This signal is emitted after a page has been changed.
        ///
        /// It can be used to implement "infinite scrolling" by amending the pages
        /// after every scroll.
        ///
        /// ::: note
        ///     An empty carousel is indicated by `(int)index == -1`.
        pub const page_changed = struct {
            pub const name = "page-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_index: c_uint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Carousel, p_instance))),
                    gobject.signalLookup("page-changed", Carousel.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwCarousel`.
    extern fn adw_carousel_new() *adw.Carousel;
    pub const new = adw_carousel_new;

    /// Appends `child` to `self`.
    extern fn adw_carousel_append(p_self: *Carousel, p_child: *gtk.Widget) void;
    pub const append = adw_carousel_append;

    /// Gets whether to allow swiping for more than one page at a time.
    extern fn adw_carousel_get_allow_long_swipes(p_self: *Carousel) c_int;
    pub const getAllowLongSwipes = adw_carousel_get_allow_long_swipes;

    /// Sets whether `self` can be dragged with mouse pointer.
    extern fn adw_carousel_get_allow_mouse_drag(p_self: *Carousel) c_int;
    pub const getAllowMouseDrag = adw_carousel_get_allow_mouse_drag;

    /// Gets whether `self` will respond to scroll wheel events.
    extern fn adw_carousel_get_allow_scroll_wheel(p_self: *Carousel) c_int;
    pub const getAllowScrollWheel = adw_carousel_get_allow_scroll_wheel;

    /// Gets whether `self` can be navigated.
    extern fn adw_carousel_get_interactive(p_self: *Carousel) c_int;
    pub const getInteractive = adw_carousel_get_interactive;

    /// Gets the number of pages in `self`.
    extern fn adw_carousel_get_n_pages(p_self: *Carousel) c_uint;
    pub const getNPages = adw_carousel_get_n_pages;

    /// Gets the page at position `n`.
    extern fn adw_carousel_get_nth_page(p_self: *Carousel, p_n: c_uint) *gtk.Widget;
    pub const getNthPage = adw_carousel_get_nth_page;

    /// Gets current scroll position in `self`, unitless.
    ///
    /// 1 matches 1 page. Use `Carousel.scrollTo` for changing it.
    extern fn adw_carousel_get_position(p_self: *Carousel) f64;
    pub const getPosition = adw_carousel_get_position;

    /// Gets the page reveal duration, in milliseconds.
    extern fn adw_carousel_get_reveal_duration(p_self: *Carousel) c_uint;
    pub const getRevealDuration = adw_carousel_get_reveal_duration;

    /// Gets the scroll animation spring parameters for `self`.
    extern fn adw_carousel_get_scroll_params(p_self: *Carousel) *adw.SpringParams;
    pub const getScrollParams = adw_carousel_get_scroll_params;

    /// Gets spacing between pages in pixels.
    extern fn adw_carousel_get_spacing(p_self: *Carousel) c_uint;
    pub const getSpacing = adw_carousel_get_spacing;

    /// Inserts `child` into `self` at position `position`.
    ///
    /// If position is -1, or larger than the number of pages,
    /// `child` will be appended to the end.
    extern fn adw_carousel_insert(p_self: *Carousel, p_child: *gtk.Widget, p_position: c_int) void;
    pub const insert = adw_carousel_insert;

    /// Prepends `child` to `self`.
    extern fn adw_carousel_prepend(p_self: *Carousel, p_child: *gtk.Widget) void;
    pub const prepend = adw_carousel_prepend;

    /// Removes `child` from `self`.
    extern fn adw_carousel_remove(p_self: *Carousel, p_child: *gtk.Widget) void;
    pub const remove = adw_carousel_remove;

    /// Moves `child` into position `position`.
    ///
    /// If position is -1, or larger than the number of pages, `child` will be moved
    /// at the end.
    extern fn adw_carousel_reorder(p_self: *Carousel, p_child: *gtk.Widget, p_position: c_int) void;
    pub const reorder = adw_carousel_reorder;

    /// Scrolls to `widget`.
    ///
    /// If `animate` is `TRUE`, the transition will be animated.
    extern fn adw_carousel_scroll_to(p_self: *Carousel, p_widget: *gtk.Widget, p_animate: c_int) void;
    pub const scrollTo = adw_carousel_scroll_to;

    /// Sets whether to allow swiping for more than one page at a time.
    ///
    /// If `allow_long_swipes` is `FALSE`, each swipe can only move to the adjacent
    /// pages.
    extern fn adw_carousel_set_allow_long_swipes(p_self: *Carousel, p_allow_long_swipes: c_int) void;
    pub const setAllowLongSwipes = adw_carousel_set_allow_long_swipes;

    /// Sets whether `self` can be dragged with mouse pointer.
    ///
    /// If `allow_mouse_drag` is `FALSE`, dragging is only available on touch.
    extern fn adw_carousel_set_allow_mouse_drag(p_self: *Carousel, p_allow_mouse_drag: c_int) void;
    pub const setAllowMouseDrag = adw_carousel_set_allow_mouse_drag;

    /// Sets whether `self` will respond to scroll wheel events.
    ///
    /// If `allow_scroll_wheel` is `FALSE`, wheel events will be ignored.
    extern fn adw_carousel_set_allow_scroll_wheel(p_self: *Carousel, p_allow_scroll_wheel: c_int) void;
    pub const setAllowScrollWheel = adw_carousel_set_allow_scroll_wheel;

    /// Sets whether `self` can be navigated.
    ///
    /// This can be used to temporarily disable the carousel to only allow navigating
    /// it in a certain state.
    extern fn adw_carousel_set_interactive(p_self: *Carousel, p_interactive: c_int) void;
    pub const setInteractive = adw_carousel_set_interactive;

    /// Sets the page reveal duration, in milliseconds.
    ///
    /// Reveal duration is used when animating adding or removing pages.
    extern fn adw_carousel_set_reveal_duration(p_self: *Carousel, p_reveal_duration: c_uint) void;
    pub const setRevealDuration = adw_carousel_set_reveal_duration;

    /// Sets the scroll animation spring parameters for `self`.
    ///
    /// The default value is equivalent to:
    ///
    /// ```c
    /// adw_spring_params_new (1, 0.5, 500)
    /// ```
    extern fn adw_carousel_set_scroll_params(p_self: *Carousel, p_params: *adw.SpringParams) void;
    pub const setScrollParams = adw_carousel_set_scroll_params;

    /// Sets spacing between pages in pixels.
    extern fn adw_carousel_set_spacing(p_self: *Carousel, p_spacing: c_uint) void;
    pub const setSpacing = adw_carousel_set_spacing;

    extern fn adw_carousel_get_type() usize;
    pub const getGObjectType = adw_carousel_get_type;

    extern fn g_object_ref(p_self: *adw.Carousel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Carousel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Carousel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A dots indicator for `Carousel`.
///
/// <picture>
///   <source srcset="carousel-indicator-dots-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="carousel-indicator-dots.png" alt="carousel-indicator-dots">
/// </picture>
///
/// The `AdwCarouselIndicatorDots` widget shows a set of dots for each page of a
/// given `Carousel`. The dot representing the carousel's active page is
/// larger and more opaque than the others, the transition to the active and
/// inactive state is gradual to match the carousel's position.
///
/// See also `CarouselIndicatorLines`.
///
/// ## CSS nodes
///
/// `AdwCarouselIndicatorDots` has a single CSS node with name
/// `carouselindicatordots`.
pub const CarouselIndicatorDots = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.CarouselIndicatorDotsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The displayed carousel.
        pub const carousel = struct {
            pub const name = "carousel";

            pub const Type = ?*adw.Carousel;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwCarouselIndicatorDots`.
    extern fn adw_carousel_indicator_dots_new() *adw.CarouselIndicatorDots;
    pub const new = adw_carousel_indicator_dots_new;

    /// Gets the displayed carousel.
    extern fn adw_carousel_indicator_dots_get_carousel(p_self: *CarouselIndicatorDots) ?*adw.Carousel;
    pub const getCarousel = adw_carousel_indicator_dots_get_carousel;

    /// Sets the displayed carousel.
    extern fn adw_carousel_indicator_dots_set_carousel(p_self: *CarouselIndicatorDots, p_carousel: ?*adw.Carousel) void;
    pub const setCarousel = adw_carousel_indicator_dots_set_carousel;

    extern fn adw_carousel_indicator_dots_get_type() usize;
    pub const getGObjectType = adw_carousel_indicator_dots_get_type;

    extern fn g_object_ref(p_self: *adw.CarouselIndicatorDots) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.CarouselIndicatorDots) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CarouselIndicatorDots, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A lines indicator for `Carousel`.
///
/// <picture>
///   <source srcset="carousel-indicator-lines-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="carousel-indicator-lines.png" alt="carousel-indicator-lines">
/// </picture>
///
/// The `AdwCarouselIndicatorLines` widget shows a set of lines for each page of
/// a given `Carousel`. The carousel's active page is shown as another line
/// that moves between them to match the carousel's position.
///
/// See also `CarouselIndicatorDots`.
///
/// ## CSS nodes
///
/// `AdwCarouselIndicatorLines` has a single CSS node with name
/// `carouselindicatorlines`.
pub const CarouselIndicatorLines = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.CarouselIndicatorLinesClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The displayed carousel.
        pub const carousel = struct {
            pub const name = "carousel";

            pub const Type = ?*adw.Carousel;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwCarouselIndicatorLines`.
    extern fn adw_carousel_indicator_lines_new() *adw.CarouselIndicatorLines;
    pub const new = adw_carousel_indicator_lines_new;

    /// Gets the displayed carousel.
    extern fn adw_carousel_indicator_lines_get_carousel(p_self: *CarouselIndicatorLines) ?*adw.Carousel;
    pub const getCarousel = adw_carousel_indicator_lines_get_carousel;

    /// Sets the displayed carousel.
    extern fn adw_carousel_indicator_lines_set_carousel(p_self: *CarouselIndicatorLines, p_carousel: ?*adw.Carousel) void;
    pub const setCarousel = adw_carousel_indicator_lines_set_carousel;

    extern fn adw_carousel_indicator_lines_get_type() usize;
    pub const getGObjectType = adw_carousel_indicator_lines_get_type;

    extern fn g_object_ref(p_self: *adw.CarouselIndicatorLines) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.CarouselIndicatorLines) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CarouselIndicatorLines, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget constraining its child to a given size.
///
/// <picture>
///   <source srcset="clamp-wide-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="clamp-wide.png" alt="clamp-wide">
/// </picture>
/// <picture>
///   <source srcset="clamp-narrow-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="clamp-narrow.png" alt="clamp-narrow">
/// </picture>
///
/// The `AdwClamp` widget constrains the size of the widget it contains to a
/// given maximum size. It will constrain the width if it is horizontal, or the
/// height if it is vertical. The expansion of the child from its minimum to its
/// maximum size is eased out for a smooth transition.
///
/// If the child requires more than the requested maximum size, it will be
/// allocated the minimum size it can fit in instead.
///
/// `AdwClamp` can scale with the text scale factor, use the
/// `Clamp.properties.unit` property to enable that behavior.
///
/// See also: `ClampLayout`, `ClampScrollable`.
///
/// ## CSS nodes
///
/// `AdwClamp` has a single CSS node with name `clamp`.
pub const Clamp = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.ClampClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget of the `AdwClamp`.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The maximum size allocated to the child.
        ///
        /// It is the width if the clamp is horizontal, or the height if it is vertical.
        pub const maximum_size = struct {
            pub const name = "maximum-size";

            pub const Type = c_int;
        };

        /// The size above which the child is clamped.
        ///
        /// Starting from this size, the clamp will tighten its grip on the child,
        /// slowly allocating less and less of the available size up to the maximum
        /// allocated size. Below that threshold and below the maximum size, the child
        /// will be allocated all the available size.
        ///
        /// If the threshold is greater than the maximum size to allocate to the child,
        /// the child will be allocated all the size up to the maximum.
        /// If the threshold is lower than the minimum size to allocate to the child,
        /// that size will be used as the tightening threshold.
        ///
        /// Effectively, tightening the grip on the child before it reaches its maximum
        /// size makes transitions to and from the maximum size smoother when resizing.
        pub const tightening_threshold = struct {
            pub const name = "tightening-threshold";

            pub const Type = c_int;
        };

        /// The length unit for maximum size and tightening threshold.
        ///
        /// Allows the sizes to vary depending on the text scale factor.
        pub const unit = struct {
            pub const name = "unit";

            pub const Type = adw.LengthUnit;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwClamp`.
    extern fn adw_clamp_new() *adw.Clamp;
    pub const new = adw_clamp_new;

    /// Gets the child widget of `self`.
    extern fn adw_clamp_get_child(p_self: *Clamp) ?*gtk.Widget;
    pub const getChild = adw_clamp_get_child;

    /// Gets the maximum size allocated to the child.
    extern fn adw_clamp_get_maximum_size(p_self: *Clamp) c_int;
    pub const getMaximumSize = adw_clamp_get_maximum_size;

    /// Gets the size above which the child is clamped.
    extern fn adw_clamp_get_tightening_threshold(p_self: *Clamp) c_int;
    pub const getTighteningThreshold = adw_clamp_get_tightening_threshold;

    /// Gets the length unit for maximum size and tightening threshold.
    extern fn adw_clamp_get_unit(p_self: *Clamp) adw.LengthUnit;
    pub const getUnit = adw_clamp_get_unit;

    /// Sets the child widget of `self`.
    extern fn adw_clamp_set_child(p_self: *Clamp, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_clamp_set_child;

    /// Sets the maximum size allocated to the child.
    ///
    /// It is the width if the clamp is horizontal, or the height if it is vertical.
    extern fn adw_clamp_set_maximum_size(p_self: *Clamp, p_maximum_size: c_int) void;
    pub const setMaximumSize = adw_clamp_set_maximum_size;

    /// Sets the size above which the child is clamped.
    ///
    /// Starting from this size, the clamp will tighten its grip on the child, slowly
    /// allocating less and less of the available size up to the maximum allocated
    /// size. Below that threshold and below the maximum size, the child will be
    /// allocated all the available size.
    ///
    /// If the threshold is greater than the maximum size to allocate to the child,
    /// the child will be allocated all the size up to the maximum. If the threshold
    /// is lower than the minimum size to allocate to the child, that size will be
    /// used as the tightening threshold.
    ///
    /// Effectively, tightening the grip on the child before it reaches its maximum
    /// size makes transitions to and from the maximum size smoother when resizing.
    extern fn adw_clamp_set_tightening_threshold(p_self: *Clamp, p_tightening_threshold: c_int) void;
    pub const setTighteningThreshold = adw_clamp_set_tightening_threshold;

    /// Sets the length unit for maximum size and tightening threshold.
    ///
    /// Allows the sizes to vary depending on the text scale factor.
    extern fn adw_clamp_set_unit(p_self: *Clamp, p_unit: adw.LengthUnit) void;
    pub const setUnit = adw_clamp_set_unit;

    extern fn adw_clamp_get_type() usize;
    pub const getGObjectType = adw_clamp_get_type;

    extern fn g_object_ref(p_self: *adw.Clamp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Clamp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Clamp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A layout manager constraining its children to a given size.
///
/// <picture>
///   <source srcset="clamp-wide-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="clamp-wide.png" alt="clamp-wide">
/// </picture>
/// <picture>
///   <source srcset="clamp-narrow-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="clamp-narrow.png" alt="clamp-narrow">
/// </picture>
///
/// `AdwClampLayout` constraints the size of the widgets it contains to a given
/// maximum size. It will constrain the width if it is horizontal, or the height
/// if it is vertical. The expansion of the children from their minimum to their
/// maximum size is eased out for a smooth transition.
///
/// If a child requires more than the requested maximum size, it will be
/// allocated the minimum size it can fit in instead.
///
/// `AdwClampLayout` can scale with the text scale factor, use the
/// `ClampLayout.properties.unit` property to enable that behavior.
///
/// See also: `Clamp`, `ClampScrollable`.
pub const ClampLayout = opaque {
    pub const Parent = gtk.LayoutManager;
    pub const Implements = [_]type{gtk.Orientable};
    pub const Class = adw.ClampLayoutClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The maximum size to allocate to the children.
        ///
        /// It is the width if the layout is horizontal, or the height if it is
        /// vertical.
        pub const maximum_size = struct {
            pub const name = "maximum-size";

            pub const Type = c_int;
        };

        /// The size above which the children are clamped.
        ///
        /// Starting from this size, the layout will tighten its grip on the children,
        /// slowly allocating less and less of the available size up to the maximum
        /// allocated size. Below that threshold and below the maximum size, the
        /// children will be allocated all the available size.
        ///
        /// If the threshold is greater than the maximum size to allocate to the
        /// children, they will be allocated the whole size up to the maximum. If the
        /// threshold is lower than the minimum size to allocate to the children, that
        /// size will be used as the tightening threshold.
        ///
        /// Effectively, tightening the grip on a child before it reaches its maximum
        /// size makes transitions to and from the maximum size smoother when resizing.
        pub const tightening_threshold = struct {
            pub const name = "tightening-threshold";

            pub const Type = c_int;
        };

        /// The length unit for maximum size and tightening threshold.
        ///
        /// Allows the sizes to vary depending on the text scale factor.
        pub const unit = struct {
            pub const name = "unit";

            pub const Type = adw.LengthUnit;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwClampLayout`.
    extern fn adw_clamp_layout_new() *adw.ClampLayout;
    pub const new = adw_clamp_layout_new;

    /// Gets the maximum size allocated to the children.
    extern fn adw_clamp_layout_get_maximum_size(p_self: *ClampLayout) c_int;
    pub const getMaximumSize = adw_clamp_layout_get_maximum_size;

    /// Gets the size above which the children are clamped.
    extern fn adw_clamp_layout_get_tightening_threshold(p_self: *ClampLayout) c_int;
    pub const getTighteningThreshold = adw_clamp_layout_get_tightening_threshold;

    /// Gets the length unit for maximum size and tightening threshold.
    extern fn adw_clamp_layout_get_unit(p_self: *ClampLayout) adw.LengthUnit;
    pub const getUnit = adw_clamp_layout_get_unit;

    /// Sets the maximum size allocated to the children.
    ///
    /// It is the width if the layout is horizontal, or the height if it is vertical.
    extern fn adw_clamp_layout_set_maximum_size(p_self: *ClampLayout, p_maximum_size: c_int) void;
    pub const setMaximumSize = adw_clamp_layout_set_maximum_size;

    /// Sets the size above which the children are clamped.
    ///
    /// Starting from this size, the layout will tighten its grip on the children,
    /// slowly allocating less and less of the available size up to the maximum
    /// allocated size. Below that threshold and below the maximum size, the children
    /// will be allocated all the available size.
    ///
    /// If the threshold is greater than the maximum size to allocate to the
    /// children, they will be allocated the whole size up to the maximum. If the
    /// threshold is lower than the minimum size to allocate to the children, that
    /// size will be used as the tightening threshold.
    ///
    /// Effectively, tightening the grip on a child before it reaches its maximum
    /// size makes transitions to and from the maximum size smoother when resizing.
    extern fn adw_clamp_layout_set_tightening_threshold(p_self: *ClampLayout, p_tightening_threshold: c_int) void;
    pub const setTighteningThreshold = adw_clamp_layout_set_tightening_threshold;

    /// Sets the length unit for maximum size and tightening threshold.
    ///
    /// Allows the sizes to vary depending on the text scale factor.
    extern fn adw_clamp_layout_set_unit(p_self: *ClampLayout, p_unit: adw.LengthUnit) void;
    pub const setUnit = adw_clamp_layout_set_unit;

    extern fn adw_clamp_layout_get_type() usize;
    pub const getGObjectType = adw_clamp_layout_get_type;

    extern fn g_object_ref(p_self: *adw.ClampLayout) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ClampLayout) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ClampLayout, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A scrollable `Clamp`.
///
/// `AdwClampScrollable` is a variant of `Clamp` that implements the
/// `gtk.Scrollable` interface.
///
/// The primary use case for `AdwClampScrollable` is clamping
/// `gtk.ListView`.
///
/// See also: `ClampLayout`.
pub const ClampScrollable = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable, gtk.Scrollable };
    pub const Class = adw.ClampScrollableClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget of the `AdwClampScrollable`.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The maximum size allocated to the child.
        ///
        /// It is the width if the clamp is horizontal, or the height if it is vertical.
        pub const maximum_size = struct {
            pub const name = "maximum-size";

            pub const Type = c_int;
        };

        /// The size above which the child is clamped.
        ///
        /// Starting from this size, the clamp will tighten its grip on the child,
        /// slowly allocating less and less of the available size up to the maximum
        /// allocated size. Below that threshold and below the maximum width, the child
        /// will be allocated all the available size.
        ///
        /// If the threshold is greater than the maximum size to allocate to the child,
        /// the child will be allocated all the width up to the maximum.
        /// If the threshold is lower than the minimum size to allocate to the child,
        /// that size will be used as the tightening threshold.
        ///
        /// Effectively, tightening the grip on the child before it reaches its maximum
        /// size makes transitions to and from the maximum size smoother when resizing.
        pub const tightening_threshold = struct {
            pub const name = "tightening-threshold";

            pub const Type = c_int;
        };

        /// The length unit for maximum size and tightening threshold.
        ///
        /// Allows the sizes to vary depending on the text scale factor.
        pub const unit = struct {
            pub const name = "unit";

            pub const Type = adw.LengthUnit;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwClampScrollable`.
    extern fn adw_clamp_scrollable_new() *adw.ClampScrollable;
    pub const new = adw_clamp_scrollable_new;

    /// Gets the child widget of `self`.
    extern fn adw_clamp_scrollable_get_child(p_self: *ClampScrollable) ?*gtk.Widget;
    pub const getChild = adw_clamp_scrollable_get_child;

    /// Gets the maximum size allocated to the child.
    extern fn adw_clamp_scrollable_get_maximum_size(p_self: *ClampScrollable) c_int;
    pub const getMaximumSize = adw_clamp_scrollable_get_maximum_size;

    /// Gets the size above which the child is clamped.
    extern fn adw_clamp_scrollable_get_tightening_threshold(p_self: *ClampScrollable) c_int;
    pub const getTighteningThreshold = adw_clamp_scrollable_get_tightening_threshold;

    /// Gets the length unit for maximum size and tightening threshold.
    extern fn adw_clamp_scrollable_get_unit(p_self: *ClampScrollable) adw.LengthUnit;
    pub const getUnit = adw_clamp_scrollable_get_unit;

    /// Sets the child widget of `self`.
    extern fn adw_clamp_scrollable_set_child(p_self: *ClampScrollable, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_clamp_scrollable_set_child;

    /// Sets the maximum size allocated to the child.
    ///
    /// It is the width if the clamp is horizontal, or the height if it is vertical.
    extern fn adw_clamp_scrollable_set_maximum_size(p_self: *ClampScrollable, p_maximum_size: c_int) void;
    pub const setMaximumSize = adw_clamp_scrollable_set_maximum_size;

    /// Sets the size above which the child is clamped.
    ///
    /// Starting from this size, the clamp will tighten its grip on the child, slowly
    /// allocating less and less of the available size up to the maximum allocated
    /// size. Below that threshold and below the maximum width, the child will be
    /// allocated all the available size.
    ///
    /// If the threshold is greater than the maximum size to allocate to the child,
    /// the child will be allocated all the width up to the maximum. If the threshold
    /// is lower than the minimum size to allocate to the child, that size will be
    /// used as the tightening threshold.
    ///
    /// Effectively, tightening the grip on the child before it reaches its maximum
    /// size makes transitions to and from the maximum size smoother when resizing.
    extern fn adw_clamp_scrollable_set_tightening_threshold(p_self: *ClampScrollable, p_tightening_threshold: c_int) void;
    pub const setTighteningThreshold = adw_clamp_scrollable_set_tightening_threshold;

    /// Sets the length unit for maximum size and tightening threshold.
    ///
    /// Allows the sizes to vary depending on the text scale factor.
    extern fn adw_clamp_scrollable_set_unit(p_self: *ClampScrollable, p_unit: adw.LengthUnit) void;
    pub const setUnit = adw_clamp_scrollable_set_unit;

    extern fn adw_clamp_scrollable_get_type() usize;
    pub const getGObjectType = adw_clamp_scrollable_get_type;

    extern fn g_object_ref(p_self: *adw.ClampScrollable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ClampScrollable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ClampScrollable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` used to choose from a list of items.
///
/// <picture>
///   <source srcset="combo-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="combo-row.png" alt="combo-row">
/// </picture>
///
/// The `AdwComboRow` widget allows the user to choose from a list of valid
/// choices. The row displays the selected choice. When activated, the row
/// displays a popover which allows the user to make a new choice.
///
/// Example of an `AdwComboRow` UI definition:
/// ```xml
/// <object class="AdwComboRow">
///   <property name="title" translatable="yes">Combo Row</property>
///   <property name="model">
///     <object class="GtkStringList">
///       <items>
///         <item translatable="yes">Foo</item>
///         <item translatable="yes">Bar</item>
///         <item translatable="yes">Baz</item>
///       </items>
///     </object>
///   </property>
/// </object>
/// ```
///
/// The `ComboRow.properties.selected` and `ComboRow.properties.selected_item`
/// properties can be used to keep track of the selected item and react to their
/// changes.
///
/// `AdwComboRow` mirrors `gtk.DropDown`, see that widget for details.
///
/// `AdwComboRow` is `gtk.ListBoxRow.properties.activatable` if a model is set.
///
/// ## CSS nodes
///
/// `AdwComboRow` has a main CSS node with name `row` and the `.combo` style
/// class.
///
/// Its popover has the node named `popover` with the `.menu` style class, it
/// contains a `gtk.ScrolledWindow`, which in turn contains a
/// `gtk.ListView`, both are accessible via their regular nodes.
///
/// ## Accessibility
///
/// `AdwComboRow` uses the `GTK_ACCESSIBLE_ROLE_COMBO_BOX` role.
pub const ComboRow = extern struct {
    pub const Parent = adw.ActionRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ComboRowClass;
    f_parent_instance: adw.ActionRow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to show a search entry in the popup.
        ///
        /// If set to `TRUE`, a search entry will be shown in the popup that
        /// allows to search for items in the list.
        ///
        /// Search requires `ComboRow.properties.expression` to be set.
        pub const enable_search = struct {
            pub const name = "enable-search";

            pub const Type = c_int;
        };

        /// An expression used to obtain strings from items.
        ///
        /// The expression must have a value type of `G_TYPE_STRING`.
        ///
        /// It's used to bind strings to labels produced by the default factory if
        /// `ComboRow.properties.factory` is not set, or when
        /// `ComboRow.properties.use_subtitle` is set to `TRUE`.
        pub const expression = struct {
            pub const name = "expression";

            pub const Type = ?*gtk.Expression;
        };

        /// Factory for populating list items.
        ///
        /// This factory is always used for the item in the row. It is also used for
        /// items in the popup unless `ComboRow.properties.list_factory` is set.
        pub const factory = struct {
            pub const name = "factory";

            pub const Type = ?*gtk.ListItemFactory;
        };

        /// The factory for creating header widgets for the popup.
        pub const header_factory = struct {
            pub const name = "header-factory";

            pub const Type = ?*gtk.ListItemFactory;
        };

        /// The factory for populating list items in the popup.
        ///
        /// If this is not set, `ComboRow.properties.factory` is used.
        pub const list_factory = struct {
            pub const name = "list-factory";

            pub const Type = ?*gtk.ListItemFactory;
        };

        /// The model that provides the displayed items.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?*gio.ListModel;
        };

        /// The match mode for the search filter.
        pub const search_match_mode = struct {
            pub const name = "search-match-mode";

            pub const Type = gtk.StringFilterMatchMode;
        };

        /// The position of the selected item.
        ///
        /// If no item is selected, the property has the value
        /// `gtk.INVALID_LIST_POSITION`
        pub const selected = struct {
            pub const name = "selected";

            pub const Type = c_uint;
        };

        /// The selected item.
        pub const selected_item = struct {
            pub const name = "selected-item";

            pub const Type = ?*gobject.Object;
        };

        /// Whether to use the current value as the subtitle.
        ///
        /// If you use a custom list item factory, you will need to give the row a
        /// name conversion expression with `ComboRow.properties.expression`.
        ///
        /// If set to `TRUE`, you should not access `ActionRow.properties.subtitle`.
        ///
        /// The subtitle is interpreted as Pango markup if
        /// `PreferencesRow.properties.use_markup` is set to `TRUE`.
        pub const use_subtitle = struct {
            pub const name = "use-subtitle";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwComboRow`.
    extern fn adw_combo_row_new() *adw.ComboRow;
    pub const new = adw_combo_row_new;

    /// Gets whether search is enabled.
    ///
    /// If set to `TRUE`, a search entry will be shown in the popup that
    /// allows to search for items in the list.
    ///
    /// Search requires `ComboRow.properties.expression` to be set.
    extern fn adw_combo_row_get_enable_search(p_self: *ComboRow) c_int;
    pub const getEnableSearch = adw_combo_row_get_enable_search;

    /// Gets the expression used to obtain strings from items.
    extern fn adw_combo_row_get_expression(p_self: *ComboRow) ?*gtk.Expression;
    pub const getExpression = adw_combo_row_get_expression;

    /// Gets the factory for populating list items.
    extern fn adw_combo_row_get_factory(p_self: *ComboRow) ?*gtk.ListItemFactory;
    pub const getFactory = adw_combo_row_get_factory;

    /// Gets the factory that's currently used to create header widgets for the popup.
    extern fn adw_combo_row_get_header_factory(p_self: *ComboRow) ?*gtk.ListItemFactory;
    pub const getHeaderFactory = adw_combo_row_get_header_factory;

    /// Gets the factory for populating list items in the popup.
    extern fn adw_combo_row_get_list_factory(p_self: *ComboRow) ?*gtk.ListItemFactory;
    pub const getListFactory = adw_combo_row_get_list_factory;

    /// Gets the model that provides the displayed items.
    extern fn adw_combo_row_get_model(p_self: *ComboRow) ?*gio.ListModel;
    pub const getModel = adw_combo_row_get_model;

    /// Returns the match mode that the search filter is using.
    extern fn adw_combo_row_get_search_match_mode(p_self: *ComboRow) gtk.StringFilterMatchMode;
    pub const getSearchMatchMode = adw_combo_row_get_search_match_mode;

    /// Gets the position of the selected item.
    extern fn adw_combo_row_get_selected(p_self: *ComboRow) c_uint;
    pub const getSelected = adw_combo_row_get_selected;

    /// Gets the selected item.
    extern fn adw_combo_row_get_selected_item(p_self: *ComboRow) ?*gobject.Object;
    pub const getSelectedItem = adw_combo_row_get_selected_item;

    /// Gets whether to use the current value as the subtitle.
    extern fn adw_combo_row_get_use_subtitle(p_self: *ComboRow) c_int;
    pub const getUseSubtitle = adw_combo_row_get_use_subtitle;

    /// Sets whether to enable search.
    ///
    /// If set to `TRUE`, a search entry will be shown in the popup that
    /// allows to search for items in the list.
    ///
    /// Search requires `ComboRow.properties.expression` to be set.
    extern fn adw_combo_row_set_enable_search(p_self: *ComboRow, p_enable_search: c_int) void;
    pub const setEnableSearch = adw_combo_row_set_enable_search;

    /// Sets the expression used to obtain strings from items.
    ///
    /// The expression must have a value type of `G_TYPE_STRING`.
    ///
    /// It's used to bind strings to labels produced by the default factory if
    /// `ComboRow.properties.factory` is not set, or when
    /// `ComboRow.properties.use_subtitle` is set to `TRUE`.
    extern fn adw_combo_row_set_expression(p_self: *ComboRow, p_expression: ?*gtk.Expression) void;
    pub const setExpression = adw_combo_row_set_expression;

    /// Sets the factory for populating list items.
    ///
    /// This factory is always used for the item in the row. It is also used for
    /// items in the popup unless `ComboRow.properties.list_factory` is set.
    extern fn adw_combo_row_set_factory(p_self: *ComboRow, p_factory: ?*gtk.ListItemFactory) void;
    pub const setFactory = adw_combo_row_set_factory;

    /// Sets the factory to use for creating header widgets for the popup.
    extern fn adw_combo_row_set_header_factory(p_self: *ComboRow, p_factory: ?*gtk.ListItemFactory) void;
    pub const setHeaderFactory = adw_combo_row_set_header_factory;

    /// Sets the factory for populating list items in the popup.
    ///
    /// If this is not set, `ComboRow.properties.factory` is used.
    extern fn adw_combo_row_set_list_factory(p_self: *ComboRow, p_factory: ?*gtk.ListItemFactory) void;
    pub const setListFactory = adw_combo_row_set_list_factory;

    /// Sets the model that provides the displayed items.
    extern fn adw_combo_row_set_model(p_self: *ComboRow, p_model: ?*gio.ListModel) void;
    pub const setModel = adw_combo_row_set_model;

    /// Sets the match mode for the search filter.
    extern fn adw_combo_row_set_search_match_mode(p_self: *ComboRow, p_search_match_mode: gtk.StringFilterMatchMode) void;
    pub const setSearchMatchMode = adw_combo_row_set_search_match_mode;

    /// Selects the item at the given position.
    extern fn adw_combo_row_set_selected(p_self: *ComboRow, p_position: c_uint) void;
    pub const setSelected = adw_combo_row_set_selected;

    /// Sets whether to use the current value as the subtitle.
    ///
    /// If you use a custom list item factory, you will need to give the row a
    /// name conversion expression with `ComboRow.properties.expression`.
    ///
    /// If set to `TRUE`, you should not access `ActionRow.properties.subtitle`.
    ///
    /// The subtitle is interpreted as Pango markup if
    /// `PreferencesRow.properties.use_markup` is set to `TRUE`.
    extern fn adw_combo_row_set_use_subtitle(p_self: *ComboRow, p_use_subtitle: c_int) void;
    pub const setUseSubtitle = adw_combo_row_set_use_subtitle;

    extern fn adw_combo_row_get_type() usize;
    pub const getGObjectType = adw_combo_row_get_type;

    extern fn g_object_ref(p_self: *adw.ComboRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ComboRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ComboRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An adaptive dialog container.
///
/// <picture>
///   <source srcset="dialog-floating-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="dialog-floating.png" alt="dialog-floating">
/// </picture>
/// <picture>
///   <source srcset="dialog-bottom-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="dialog-bottom.png" alt="dialog-bottom">
/// </picture>
///
/// `AdwDialog` is similar to a window, but is shown within another window. It
/// can be used with `Window` and `ApplicationWindow`, use
/// `Dialog.present` to show it.
///
/// `AdwDialog` is not resizable. Use the `Dialog.properties.content_width` and
/// `Dialog.properties.content_height` properties to set its size, or set
/// `Dialog.properties.follows_content_size` to `TRUE` to make the dialog track the
/// content's size as it changes. `AdwDialog` can never be larger than its parent
/// window.
///
/// `AdwDialog` can be presented as a centered floating window or a bottom sheet.
/// By default it's automatic depending on the available size.
/// `Dialog.properties.presentation_mode` can be used to change that.
///
/// `AdwDialog` can be closed via `Dialog.close`.
///
/// When presented as a bottom sheet, `AdwDialog` can also be closed via swiping
/// it down.
///
/// The `Dialog.properties.can_close` can be used to prevent closing. In that case,
/// `Dialog.signals.close_attempt` gets emitted instead.
///
/// Use `Dialog.forceClose` to close the dialog even when `can-close` is set to
/// `FALSE`.
///
/// `AdwDialog` is transient and doesn't integrate with the window below it, for
/// example it's not possible to collapse it into a bottom bar. See
/// `BottomSheet` for persistent and more tightly integrated bottom sheets.
///
/// ## Header Bar Integration
///
/// When placed inside an `AdwDialog`, `HeaderBar` will display the dialog
/// title instead of window title. It will also adjust the decoration layout to
/// ensure it always has a close button and nothing else. Set
/// `HeaderBar.properties.show_start_title_buttons` and
/// `HeaderBar.properties.show_end_title_buttons` to `FALSE` to remove it if it's
/// unwanted.
///
/// ## Breakpoints
///
/// `AdwDialog` can be used with `Breakpoint` the same way as
/// `BreakpointBin`. Refer to that widget's documentation for details.
///
/// Like `AdwBreakpointBin`, if breakpoints are used, `AdwDialog` doesn't have a
/// minimum size, and `gtk.Widget.properties.width_request` and
/// `gtk.Widget.properties.height_request` properties must be set manually.
pub const Dialog = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.ShortcutManager };
    pub const Class = adw.DialogClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        pub const close_attempt = struct {
            pub fn call(p_class: anytype, p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Dialog.Class, p_class).f_close_attempt.?(gobject.ext.as(Dialog, p_dialog));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Dialog.Class, p_class).f_close_attempt = @ptrCast(p_implementation);
            }
        };

        pub const closed = struct {
            pub fn call(p_class: anytype, p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Dialog.Class, p_class).f_closed.?(gobject.ext.as(Dialog, p_dialog));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Dialog.Class, p_class).f_closed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Whether the dialog can be closed.
        ///
        /// If set to `FALSE`, the close button, shortcuts and
        /// `Dialog.close` will result in `Dialog.signals.close_attempt` being
        /// emitted instead, and bottom sheet close swipe will be disabled.
        /// `Dialog.forceClose` still works.
        pub const can_close = struct {
            pub const name = "can-close";

            pub const Type = c_int;
        };

        /// The child widget of the `AdwDialog`.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The height of the dialog's contents.
        ///
        /// Set it to -1 to reset it to the content's natural height.
        ///
        /// See also: `gtk.Window.properties.default_height`
        pub const content_height = struct {
            pub const name = "content-height";

            pub const Type = c_int;
        };

        /// The width of the dialog's contents.
        ///
        /// Set it to -1 to reset it to the content's natural width.
        ///
        /// See also: `gtk.Window.properties.default_width`
        pub const content_width = struct {
            pub const name = "content-width";

            pub const Type = c_int;
        };

        /// The current breakpoint.
        pub const current_breakpoint = struct {
            pub const name = "current-breakpoint";

            pub const Type = ?*adw.Breakpoint;
        };

        /// The default widget.
        ///
        /// It's activated when the user presses Enter.
        pub const default_widget = struct {
            pub const name = "default-widget";

            pub const Type = ?*gtk.Widget;
        };

        /// The focus widget.
        pub const focus_widget = struct {
            pub const name = "focus-widget";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether to size content automatically.
        ///
        /// If set to `TRUE`, always use the content's natural size instead of
        /// `Dialog.properties.content_width` and `Dialog.properties.content_height`. If
        /// the content resizes, the dialog will immediately resize as well.
        ///
        /// See also: `gtk.Window.properties.resizable`
        pub const follows_content_size = struct {
            pub const name = "follows-content-size";

            pub const Type = c_int;
        };

        /// The dialog's presentation mode.
        ///
        /// When set to `ADW_DIALOG_AUTO`, the dialog appears as a bottom sheet when
        /// the following condition is met: `max-width: 450px or max-height: 360px`,
        /// and as a floating window otherwise.
        ///
        /// Set it to `ADW_DIALOG_FLOATING` or `ADW_DIALOG_BOTTOM_SHEET` to always
        /// present it a floating window or a bottom sheet respectively, regardless of
        /// available size.
        ///
        /// Presentation mode does nothing for dialogs presented as a window.
        pub const presentation_mode = struct {
            pub const name = "presentation-mode";

            pub const Type = adw.DialogPresentationMode;
        };

        /// The title of the dialog.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when the close button or shortcut is used, or
        /// `Dialog.close` is called while `Dialog.properties.can_close` is set to
        /// `FALSE`.
        pub const close_attempt = struct {
            pub const name = "close-attempt";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dialog, p_instance))),
                    gobject.signalLookup("close-attempt", Dialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the dialog is successfully closed.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dialog, p_instance))),
                    gobject.signalLookup("closed", Dialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwDialog`.
    extern fn adw_dialog_new() *adw.Dialog;
    pub const new = adw_dialog_new;

    /// Adds `breakpoint` to `self`.
    extern fn adw_dialog_add_breakpoint(p_self: *Dialog, p_breakpoint: *adw.Breakpoint) void;
    pub const addBreakpoint = adw_dialog_add_breakpoint;

    /// Attempts to close `self`.
    ///
    /// If the `Dialog.properties.can_close` property is set to `FALSE`, the
    /// `Dialog.signals.close_attempt` signal is emitted.
    ///
    /// See also: `Dialog.forceClose`.
    extern fn adw_dialog_close(p_self: *Dialog) c_int;
    pub const close = adw_dialog_close;

    /// Closes `self`.
    ///
    /// Unlike `Dialog.close`, it succeeds even if `Dialog.properties.can_close`
    /// is set to `FALSE`.
    extern fn adw_dialog_force_close(p_self: *Dialog) void;
    pub const forceClose = adw_dialog_force_close;

    /// Gets whether `self` can be closed.
    extern fn adw_dialog_get_can_close(p_self: *Dialog) c_int;
    pub const getCanClose = adw_dialog_get_can_close;

    /// Gets the child widget of `self`.
    extern fn adw_dialog_get_child(p_self: *Dialog) ?*gtk.Widget;
    pub const getChild = adw_dialog_get_child;

    /// Gets the height of the dialog's contents.
    extern fn adw_dialog_get_content_height(p_self: *Dialog) c_int;
    pub const getContentHeight = adw_dialog_get_content_height;

    /// Gets the width of the dialog's contents.
    extern fn adw_dialog_get_content_width(p_self: *Dialog) c_int;
    pub const getContentWidth = adw_dialog_get_content_width;

    /// Gets the current breakpoint.
    extern fn adw_dialog_get_current_breakpoint(p_self: *Dialog) ?*adw.Breakpoint;
    pub const getCurrentBreakpoint = adw_dialog_get_current_breakpoint;

    /// Gets the default widget for `self`.
    extern fn adw_dialog_get_default_widget(p_self: *Dialog) ?*gtk.Widget;
    pub const getDefaultWidget = adw_dialog_get_default_widget;

    /// Gets the focus widget for `self`.
    extern fn adw_dialog_get_focus(p_self: *Dialog) ?*gtk.Widget;
    pub const getFocus = adw_dialog_get_focus;

    /// Gets whether to size content of `self` automatically.
    extern fn adw_dialog_get_follows_content_size(p_self: *Dialog) c_int;
    pub const getFollowsContentSize = adw_dialog_get_follows_content_size;

    /// Gets presentation mode for `self`.
    extern fn adw_dialog_get_presentation_mode(p_self: *Dialog) adw.DialogPresentationMode;
    pub const getPresentationMode = adw_dialog_get_presentation_mode;

    /// Gets the title of `self`.
    extern fn adw_dialog_get_title(p_self: *Dialog) [*:0]const u8;
    pub const getTitle = adw_dialog_get_title;

    /// Presents `self` within `parent`'s window.
    ///
    /// If `self` is already shown, raises it to the top instead.
    ///
    /// If the window is an `Window` or `ApplicationWindow`, the dialog
    /// will be shown within it. Otherwise, it will be a separate window.
    extern fn adw_dialog_present(p_self: *Dialog, p_parent: ?*gtk.Widget) void;
    pub const present = adw_dialog_present;

    /// Sets whether `self` can be closed.
    ///
    /// If set to `FALSE`, the close button, shortcuts and
    /// `Dialog.close` will result in `Dialog.signals.close_attempt` being
    /// emitted instead, and bottom sheet close swipe will be disabled.
    /// `Dialog.forceClose` still works.
    extern fn adw_dialog_set_can_close(p_self: *Dialog, p_can_close: c_int) void;
    pub const setCanClose = adw_dialog_set_can_close;

    /// Sets the child widget of `self`.
    extern fn adw_dialog_set_child(p_self: *Dialog, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_dialog_set_child;

    /// Sets the height of the dialog's contents.
    ///
    /// Set it to -1 to reset it to the content's natural height.
    ///
    /// See also: `gtk.Window.properties.default_height`
    extern fn adw_dialog_set_content_height(p_self: *Dialog, p_content_height: c_int) void;
    pub const setContentHeight = adw_dialog_set_content_height;

    /// Sets the width of the dialog's contents.
    ///
    /// Set it to -1 to reset it to the content's natural width.
    ///
    /// See also: `gtk.Window.properties.default_width`
    extern fn adw_dialog_set_content_width(p_self: *Dialog, p_content_width: c_int) void;
    pub const setContentWidth = adw_dialog_set_content_width;

    /// Sets the default widget for `self`.
    ///
    /// It's activated when the user presses Enter.
    extern fn adw_dialog_set_default_widget(p_self: *Dialog, p_default_widget: ?*gtk.Widget) void;
    pub const setDefaultWidget = adw_dialog_set_default_widget;

    /// Sets the focus widget for `self`.
    ///
    /// If `focus` is not the current focus widget, and is focusable, sets it as the
    /// focus widget for the dialog.
    ///
    /// If focus is `NULL`, unsets the focus widget for this dialog. To set the focus
    /// to a particular widget in the dialog, it is usually more convenient to use
    /// `gtk.Widget.grabFocus` instead of this function.
    extern fn adw_dialog_set_focus(p_self: *Dialog, p_focus: ?*gtk.Widget) void;
    pub const setFocus = adw_dialog_set_focus;

    /// Sets whether to size content of `self` automatically.
    ///
    /// If set to `TRUE`, always use the content's natural size instead of
    /// `Dialog.properties.content_width` and `Dialog.properties.content_height`. If
    /// the content resizes, the dialog will immediately resize as well.
    ///
    /// See also: `gtk.Window.properties.resizable`
    extern fn adw_dialog_set_follows_content_size(p_self: *Dialog, p_follows_content_size: c_int) void;
    pub const setFollowsContentSize = adw_dialog_set_follows_content_size;

    /// Sets presentation mode for `self`.
    ///
    /// When set to `ADW_DIALOG_AUTO`, the dialog appears as a bottom sheet when the
    /// following condition is met: `max-width: 450px or max-height: 360px`, and as a
    /// floating window otherwise.
    ///
    /// Set it to `ADW_DIALOG_FLOATING` or `ADW_DIALOG_BOTTOM_SHEET` to always
    /// present it a floating window or a bottom sheet respectively, regardless of
    /// available size.
    ///
    /// Presentation mode does nothing for dialogs presented as a window.
    extern fn adw_dialog_set_presentation_mode(p_self: *Dialog, p_presentation_mode: adw.DialogPresentationMode) void;
    pub const setPresentationMode = adw_dialog_set_presentation_mode;

    /// Sets the title of `self`.
    extern fn adw_dialog_set_title(p_self: *Dialog, p_title: [*:0]const u8) void;
    pub const setTitle = adw_dialog_set_title;

    extern fn adw_dialog_get_type() usize;
    pub const getGObjectType = adw_dialog_get_type;

    extern fn g_object_ref(p_self: *adw.Dialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Dialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Dialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` with an embedded text entry.
///
/// <picture>
///   <source srcset="entry-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="entry-row.png" alt="entry-row">
/// </picture>
///
/// `AdwEntryRow` has a title that doubles as placeholder text. It shows an icon
/// indicating that it's editable and can receive additional widgets before or
/// after the editable part.
///
/// If `EntryRow.properties.show_apply_button` is set to `TRUE`, `AdwEntryRow` can
/// show an apply button when editing its contents. This can be useful if
/// changing its contents can result in an expensive operation, such as network
/// activity.
///
/// `AdwEntryRow` provides only minimal API and should be used with the
/// `gtk.Editable` API.
///
/// See also `PasswordEntryRow`.
///
/// ## AdwEntryRow as GtkBuildable
///
/// The `AdwEntryRow` implementation of the `gtk.Buildable` interface
/// supports adding a child at its end by specifying “suffix” or omitting the
/// “type” attribute of a <child> element.
///
/// It also supports adding a child as a prefix widget by specifying “prefix” as
/// the “type” attribute of a <child> element.
///
/// ## CSS nodes
///
/// `AdwEntryRow` has a single CSS node with name `row` and the `.entry` style
/// class.
pub const EntryRow = extern struct {
    pub const Parent = adw.PreferencesRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget, gtk.Editable };
    pub const Class = adw.EntryRowClass;
    f_parent_instance: adw.PreferencesRow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether activating the embedded entry can activate the default widget.
        pub const activates_default = struct {
            pub const name = "activates-default";

            pub const Type = c_int;
        };

        /// A list of Pango attributes to apply to the text of the embedded entry.
        ///
        /// The `pango.Attribute`'s `start_index` and `end_index` must refer to
        /// the `gtk.EntryBuffer` text, i.e. without the preedit string.
        pub const attributes = struct {
            pub const name = "attributes";

            pub const Type = ?*pango.AttrList;
        };

        /// Whether to suggest emoji replacements on the entry row.
        ///
        /// Emoji replacement is done with :-delimited names, like `:heart:`.
        pub const enable_emoji_completion = struct {
            pub const name = "enable-emoji-completion";

            pub const Type = c_int;
        };

        /// Additional input hints for the entry row.
        ///
        /// Input hints allow input methods to fine-tune their behavior.
        ///
        /// See also: `adw.EntryRow.properties.input_purpose`
        pub const input_hints = struct {
            pub const name = "input-hints";

            pub const Type = gtk.InputHints;
        };

        /// The input purpose of the entry row.
        ///
        /// The input purpose can be used by input methods to adjust their behavior.
        pub const input_purpose = struct {
            pub const name = "input-purpose";

            pub const Type = gtk.InputPurpose;
        };

        /// Maximum number of characters for the entry.
        pub const max_length = struct {
            pub const name = "max-length";

            pub const Type = c_int;
        };

        /// Whether to show the apply button.
        ///
        /// When set to `TRUE`, typing text in the entry will reveal an apply button.
        /// Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
        /// emit the `EntryRow.signals.apply` signal.
        ///
        /// This is useful if changing the entry contents can trigger an expensive
        /// operation, e.g. network activity, to avoid triggering it after typing every
        /// character.
        pub const show_apply_button = struct {
            pub const name = "show-apply-button";

            pub const Type = c_int;
        };

        /// The length of the text in the entry row.
        pub const text_length = struct {
            pub const name = "text-length";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {
        /// Emitted when the apply button is pressed.
        ///
        /// See `EntryRow.properties.show_apply_button`.
        pub const apply = struct {
            pub const name = "apply";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(EntryRow, p_instance))),
                    gobject.signalLookup("apply", EntryRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the embedded entry is activated.
        pub const entry_activated = struct {
            pub const name = "entry-activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(EntryRow, p_instance))),
                    gobject.signalLookup("entry-activated", EntryRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwEntryRow`.
    extern fn adw_entry_row_new() *adw.EntryRow;
    pub const new = adw_entry_row_new;

    /// Adds a prefix widget to `self`.
    extern fn adw_entry_row_add_prefix(p_self: *EntryRow, p_widget: *gtk.Widget) void;
    pub const addPrefix = adw_entry_row_add_prefix;

    /// Adds a suffix widget to `self`.
    extern fn adw_entry_row_add_suffix(p_self: *EntryRow, p_widget: *gtk.Widget) void;
    pub const addSuffix = adw_entry_row_add_suffix;

    /// Gets whether activating the embedded entry can activate the default widget.
    extern fn adw_entry_row_get_activates_default(p_self: *EntryRow) c_int;
    pub const getActivatesDefault = adw_entry_row_get_activates_default;

    /// Gets Pango attributes applied to the text of the embedded entry.
    extern fn adw_entry_row_get_attributes(p_self: *EntryRow) ?*pango.AttrList;
    pub const getAttributes = adw_entry_row_get_attributes;

    /// Gets whether to suggest emoji replacements on `self`.
    extern fn adw_entry_row_get_enable_emoji_completion(p_self: *EntryRow) c_int;
    pub const getEnableEmojiCompletion = adw_entry_row_get_enable_emoji_completion;

    /// Gets the additional input hints of `self`.
    extern fn adw_entry_row_get_input_hints(p_self: *EntryRow) gtk.InputHints;
    pub const getInputHints = adw_entry_row_get_input_hints;

    /// Gets the input purpose of `self`.
    extern fn adw_entry_row_get_input_purpose(p_self: *EntryRow) gtk.InputPurpose;
    pub const getInputPurpose = adw_entry_row_get_input_purpose;

    /// Retrieves the maximum length of the entry.
    extern fn adw_entry_row_get_max_length(p_self: *EntryRow) c_int;
    pub const getMaxLength = adw_entry_row_get_max_length;

    /// Gets whether `self` can show the apply button.
    extern fn adw_entry_row_get_show_apply_button(p_self: *EntryRow) c_int;
    pub const getShowApplyButton = adw_entry_row_get_show_apply_button;

    /// Retrieves the current length of the text in `self`.
    extern fn adw_entry_row_get_text_length(p_self: *EntryRow) c_uint;
    pub const getTextLength = adw_entry_row_get_text_length;

    /// Causes `self` to have keyboard focus without selecting the text.
    ///
    /// See `gtk.Text.grabFocusWithoutSelecting` for more information.
    extern fn adw_entry_row_grab_focus_without_selecting(p_self: *EntryRow) c_int;
    pub const grabFocusWithoutSelecting = adw_entry_row_grab_focus_without_selecting;

    /// Removes a child from `self`.
    extern fn adw_entry_row_remove(p_self: *EntryRow, p_widget: *gtk.Widget) void;
    pub const remove = adw_entry_row_remove;

    /// Sets whether activating the embedded entry can activate the default widget.
    extern fn adw_entry_row_set_activates_default(p_self: *EntryRow, p_activates: c_int) void;
    pub const setActivatesDefault = adw_entry_row_set_activates_default;

    /// Sets Pango attributes to apply to the text of the embedded entry.
    ///
    /// The `pango.Attribute`'s `start_index` and `end_index` must refer to
    /// the `gtk.EntryBuffer` text, i.e. without the preedit string.
    extern fn adw_entry_row_set_attributes(p_self: *EntryRow, p_attributes: ?*pango.AttrList) void;
    pub const setAttributes = adw_entry_row_set_attributes;

    /// Sets whether to suggest emoji replacements on `self`.
    ///
    /// Emoji replacement is done with :-delimited names, like `:heart:`.
    extern fn adw_entry_row_set_enable_emoji_completion(p_self: *EntryRow, p_enable_emoji_completion: c_int) void;
    pub const setEnableEmojiCompletion = adw_entry_row_set_enable_emoji_completion;

    /// Set additional input hints for `self`.
    ///
    /// Input hints allow input methods to fine-tune their behavior.
    ///
    /// See also: `AdwEntryRow.properties.input_purpose`
    extern fn adw_entry_row_set_input_hints(p_self: *EntryRow, p_hints: gtk.InputHints) void;
    pub const setInputHints = adw_entry_row_set_input_hints;

    /// Sets the input purpose of `self`.
    ///
    /// The input purpose can be used by input methods to adjust their behavior.
    extern fn adw_entry_row_set_input_purpose(p_self: *EntryRow, p_purpose: gtk.InputPurpose) void;
    pub const setInputPurpose = adw_entry_row_set_input_purpose;

    /// Sets the maximum length of the entry.
    extern fn adw_entry_row_set_max_length(p_self: *EntryRow, p_max_length: c_int) void;
    pub const setMaxLength = adw_entry_row_set_max_length;

    /// Sets whether `self` can show the apply button.
    ///
    /// When set to `TRUE`, typing text in the entry will reveal an apply button.
    /// Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
    /// emit the `EntryRow.signals.apply` signal.
    ///
    /// This is useful if changing the entry contents can trigger an expensive
    /// operation, e.g. network activity, to avoid triggering it after typing every
    /// character.
    extern fn adw_entry_row_set_show_apply_button(p_self: *EntryRow, p_show_apply_button: c_int) void;
    pub const setShowApplyButton = adw_entry_row_set_show_apply_button;

    extern fn adw_entry_row_get_type() usize;
    pub const getGObjectType = adw_entry_row_get_type;

    extern fn g_object_ref(p_self: *adw.EntryRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.EntryRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EntryRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `AdwEnumListItem` is the type of items in a `EnumListModel`.
pub const EnumListItem = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.EnumListItemClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The enum value name.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The enum value nick.
        pub const nick = struct {
            pub const name = "nick";

            pub const Type = ?[*:0]u8;
        };

        /// The enum value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Gets the enum value name.
    extern fn adw_enum_list_item_get_name(p_self: *EnumListItem) [*:0]const u8;
    pub const getName = adw_enum_list_item_get_name;

    /// Gets the enum value nick.
    extern fn adw_enum_list_item_get_nick(p_self: *EnumListItem) [*:0]const u8;
    pub const getNick = adw_enum_list_item_get_nick;

    /// Gets the enum value.
    extern fn adw_enum_list_item_get_value(p_self: *EnumListItem) c_int;
    pub const getValue = adw_enum_list_item_get_value;

    extern fn adw_enum_list_item_get_type() usize;
    pub const getGObjectType = adw_enum_list_item_get_type;

    extern fn g_object_ref(p_self: *adw.EnumListItem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.EnumListItem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EnumListItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gio.ListModel` representing values of a given enum.
///
/// `AdwEnumListModel` contains objects of type `EnumListItem`.
pub const EnumListModel = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = adw.EnumListModelClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The type of the enum represented by the model.
        pub const enum_type = struct {
            pub const name = "enum-type";

            pub const Type = usize;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwEnumListModel` for `enum_type`.
    extern fn adw_enum_list_model_new(p_enum_type: usize) *adw.EnumListModel;
    pub const new = adw_enum_list_model_new;

    /// Finds the position of a given enum value in `self`.
    ///
    /// If the value is not found, `GTK_INVALID_LIST_POSITION` is returned.
    extern fn adw_enum_list_model_find_position(p_self: *EnumListModel, p_value: c_int) c_uint;
    pub const findPosition = adw_enum_list_model_find_position;

    /// Gets the type of the enum represented by `self`.
    extern fn adw_enum_list_model_get_enum_type(p_self: *EnumListModel) usize;
    pub const getEnumType = adw_enum_list_model_get_enum_type;

    extern fn adw_enum_list_model_get_type() usize;
    pub const getGObjectType = adw_enum_list_model_get_type;

    extern fn g_object_ref(p_self: *adw.EnumListModel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.EnumListModel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EnumListModel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` used to reveal widgets.
///
/// <picture>
///   <source srcset="expander-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="expander-row.png" alt="expander-row">
/// </picture>
///
/// The `AdwExpanderRow` widget allows the user to reveal or hide widgets below
/// it. It also allows the user to enable the expansion of the row, allowing to
/// disable all that the row contains.
///
/// ## AdwExpanderRow as GtkBuildable
///
/// The `AdwExpanderRow` implementation of the `gtk.Buildable` interface
/// supports adding a child as an suffix widget by specifying “suffix” as the
/// “type” attribute of a <child> element.
///
/// It also supports adding it as a prefix widget by specifying “prefix” as the
/// “type” attribute of a <child> element.
///
/// ## CSS nodes
///
/// `AdwExpanderRow` has a main CSS node with name `row` and the `.expander`
/// style class. It has the `.empty` style class when it contains no children.
///
/// It contains the subnodes `row.header` for its main embedded row,
/// `list.nested` for the list it can expand, and `image.expander-row-arrow` for
/// its arrow.
///
/// ## Style classes
///
/// `AdwExpanderRow` can use the [`.`](style-classes.html`property`-rows)
/// style class to emphasize the row subtitle instead of the row title, which is
/// useful for displaying read-only properties.
///
/// When used together with the `.monospace` style class, only the subtitle
/// becomes monospace, not the title or any extra widgets.
pub const ExpanderRow = extern struct {
    pub const Parent = adw.PreferencesRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ExpanderRowClass;
    f_parent_instance: adw.PreferencesRow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether expansion is enabled.
        pub const enable_expansion = struct {
            pub const name = "enable-expansion";

            pub const Type = c_int;
        };

        /// Whether the row is expanded.
        pub const expanded = struct {
            pub const name = "expanded";

            pub const Type = c_int;
        };

        /// The icon name for this row.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the switch enabling the expansion is visible.
        pub const show_enable_switch = struct {
            pub const name = "show-enable-switch";

            pub const Type = c_int;
        };

        /// The subtitle for this row.
        ///
        /// The subtitle is interpreted as Pango markup unless
        /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
        pub const subtitle = struct {
            pub const name = "subtitle";

            pub const Type = ?[*:0]u8;
        };

        /// The number of lines at the end of which the subtitle label will be
        /// ellipsized.
        ///
        /// If the value is 0, the number of lines won't be limited.
        pub const subtitle_lines = struct {
            pub const name = "subtitle-lines";

            pub const Type = c_int;
        };

        /// The number of lines at the end of which the title label will be ellipsized.
        ///
        /// If the value is 0, the number of lines won't be limited.
        pub const title_lines = struct {
            pub const name = "title-lines";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwExpanderRow`.
    extern fn adw_expander_row_new() *adw.ExpanderRow;
    pub const new = adw_expander_row_new;

    /// Adds an action widget to `self`.
    extern fn adw_expander_row_add_action(p_self: *ExpanderRow, p_widget: *gtk.Widget) void;
    pub const addAction = adw_expander_row_add_action;

    /// Adds a prefix widget to `self`.
    extern fn adw_expander_row_add_prefix(p_self: *ExpanderRow, p_widget: *gtk.Widget) void;
    pub const addPrefix = adw_expander_row_add_prefix;

    /// Adds a widget to `self`.
    ///
    /// The widget will appear in the expanding list below `self`.
    extern fn adw_expander_row_add_row(p_self: *ExpanderRow, p_child: *gtk.Widget) void;
    pub const addRow = adw_expander_row_add_row;

    /// Adds an suffix widget to `self`.
    extern fn adw_expander_row_add_suffix(p_self: *ExpanderRow, p_widget: *gtk.Widget) void;
    pub const addSuffix = adw_expander_row_add_suffix;

    /// Gets whether the expansion of `self` is enabled.
    extern fn adw_expander_row_get_enable_expansion(p_self: *ExpanderRow) c_int;
    pub const getEnableExpansion = adw_expander_row_get_enable_expansion;

    /// Gets whether `self` is expanded.
    extern fn adw_expander_row_get_expanded(p_self: *ExpanderRow) c_int;
    pub const getExpanded = adw_expander_row_get_expanded;

    /// Gets the icon name for `self`.
    extern fn adw_expander_row_get_icon_name(p_self: *ExpanderRow) ?[*:0]const u8;
    pub const getIconName = adw_expander_row_get_icon_name;

    /// Gets whether the switch enabling the expansion of `self` is visible.
    extern fn adw_expander_row_get_show_enable_switch(p_self: *ExpanderRow) c_int;
    pub const getShowEnableSwitch = adw_expander_row_get_show_enable_switch;

    /// Gets the subtitle for `self`.
    extern fn adw_expander_row_get_subtitle(p_self: *ExpanderRow) [*:0]const u8;
    pub const getSubtitle = adw_expander_row_get_subtitle;

    /// Gets the number of lines at the end of which the subtitle label will be
    /// ellipsized.
    extern fn adw_expander_row_get_subtitle_lines(p_self: *ExpanderRow) c_int;
    pub const getSubtitleLines = adw_expander_row_get_subtitle_lines;

    /// Gets the number of lines at the end of which the title label will be
    /// ellipsized.
    extern fn adw_expander_row_get_title_lines(p_self: *ExpanderRow) c_int;
    pub const getTitleLines = adw_expander_row_get_title_lines;

    /// Removes a child from `self`.
    extern fn adw_expander_row_remove(p_self: *ExpanderRow, p_child: *gtk.Widget) void;
    pub const remove = adw_expander_row_remove;

    /// Sets whether the expansion of `self` is enabled.
    extern fn adw_expander_row_set_enable_expansion(p_self: *ExpanderRow, p_enable_expansion: c_int) void;
    pub const setEnableExpansion = adw_expander_row_set_enable_expansion;

    /// Sets whether `self` is expanded.
    extern fn adw_expander_row_set_expanded(p_self: *ExpanderRow, p_expanded: c_int) void;
    pub const setExpanded = adw_expander_row_set_expanded;

    /// Sets the icon name for `self`.
    extern fn adw_expander_row_set_icon_name(p_self: *ExpanderRow, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_expander_row_set_icon_name;

    /// Sets whether the switch enabling the expansion of `self` is visible.
    extern fn adw_expander_row_set_show_enable_switch(p_self: *ExpanderRow, p_show_enable_switch: c_int) void;
    pub const setShowEnableSwitch = adw_expander_row_set_show_enable_switch;

    /// Sets the subtitle for `self`.
    ///
    /// The subtitle is interpreted as Pango markup unless
    /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
    extern fn adw_expander_row_set_subtitle(p_self: *ExpanderRow, p_subtitle: [*:0]const u8) void;
    pub const setSubtitle = adw_expander_row_set_subtitle;

    /// Sets the number of lines at the end of which the subtitle label will be
    /// ellipsized.
    ///
    /// If the value is 0, the number of lines won't be limited.
    extern fn adw_expander_row_set_subtitle_lines(p_self: *ExpanderRow, p_subtitle_lines: c_int) void;
    pub const setSubtitleLines = adw_expander_row_set_subtitle_lines;

    /// Sets the number of lines at the end of which the title label will be
    /// ellipsized.
    ///
    /// If the value is 0, the number of lines won't be limited.
    extern fn adw_expander_row_set_title_lines(p_self: *ExpanderRow, p_title_lines: c_int) void;
    pub const setTitleLines = adw_expander_row_set_title_lines;

    extern fn adw_expander_row_get_type() usize;
    pub const getGObjectType = adw_expander_row_get_type;

    extern fn g_object_ref(p_self: *adw.ExpanderRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ExpanderRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ExpanderRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An adaptive container acting like a box or an overlay.
///
/// <picture>
///   <source srcset="flap-wide-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="flap-wide.png" alt="flap-wide">
/// </picture>
/// <picture>
///   <source srcset="flap-narrow-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="flap-narrow.png" alt="flap-narrow">
/// </picture>
///
/// The `AdwFlap` widget can display its children like a `gtk.Box` does or
/// like a `gtk.Overlay` does, according to the
/// `Flap.properties.fold_policy` value.
///
/// `AdwFlap` has at most three children: `Flap.properties.content`,
/// `Flap.properties.flap` and `Flap.properties.separator`. Content is the primary
/// child, flap is displayed next to it when unfolded, or overlays it when
/// folded. Flap can be shown or hidden by changing the
/// `Flap.properties.reveal_flap` value, as well as via swipe gestures if
/// `Flap.properties.swipe_to_open` and/or `Flap.properties.swipe_to_close` are set
/// to `TRUE`.
///
/// Optionally, a separator can be provided, which would be displayed between
/// the content and the flap when there's no shadow to separate them, depending
/// on the transition type.
///
/// `Flap.properties.flap` is transparent by default; add the
/// [`.background`](style-classes.html`background`) style class to it if this is
/// unwanted.
///
/// If `Flap.properties.modal` is set to `TRUE`, content becomes completely
/// inaccessible when the flap is revealed while folded.
///
/// The position of the flap and separator children relative to the content is
/// determined by orientation, as well as the `Flap.properties.flap_position`
/// value.
///
/// Folding the flap will automatically hide the flap widget, and unfolding it
/// will automatically reveal it. If this behavior is not desired, the
/// `Flap.properties.locked` property can be used to override it.
///
/// Common use cases include sidebars, header bars that need to be able to
/// overlap the window content (for example, in fullscreen mode) and bottom
/// sheets.
///
/// ## AdwFlap as GtkBuildable
///
/// The `AdwFlap` implementation of the `gtk.Buildable` interface supports
/// setting the flap child by specifying “flap” as the “type” attribute of a
/// `<child>` element, and separator by specifying “separator”. Specifying
/// “content” child type or omitting it results in setting the content child.
///
/// ## CSS nodes
///
/// `AdwFlap` has a single CSS node with name `flap`. The node will get the style
/// classes `.folded` when it is folded, and `.unfolded` when it's not.
pub const Flap = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.FlapClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The content widget.
        ///
        /// It's always displayed when unfolded, and partially visible when folded.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// The flap widget.
        ///
        /// It's only visible when `Flap.properties.reveal_progress` is greater than 0.
        pub const flap = struct {
            pub const name = "flap";

            pub const Type = ?*gtk.Widget;
        };

        /// The flap position.
        ///
        /// If it's set to `GTK_PACK_START`, the flap is displayed before the content,
        /// if `GTK_PACK_END`, it's displayed after the content.
        pub const flap_position = struct {
            pub const name = "flap-position";

            pub const Type = gtk.PackType;
        };

        /// The fold transition animation duration, in milliseconds.
        pub const fold_duration = struct {
            pub const name = "fold-duration";

            pub const Type = c_uint;
        };

        /// The fold policy for the flap.
        pub const fold_policy = struct {
            pub const name = "fold-policy";

            pub const Type = adw.FlapFoldPolicy;
        };

        /// Determines when the flap will fold.
        ///
        /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, flap will only fold when
        /// the children cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`,
        /// it will fold as soon as children don't get their natural size.
        ///
        /// This can be useful if you have a long ellipsizing label and want to let it
        /// ellipsize instead of immediately folding.
        pub const fold_threshold_policy = struct {
            pub const name = "fold-threshold-policy";

            pub const Type = adw.FoldThresholdPolicy;
        };

        /// Whether the flap is currently folded.
        ///
        /// See `Flap.properties.fold_policy`.
        pub const folded = struct {
            pub const name = "folded";

            pub const Type = c_int;
        };

        /// Whether the flap is locked.
        ///
        /// If `FALSE`, folding when the flap is revealed automatically closes it, and
        /// unfolding it when the flap is not revealed opens it. If `TRUE`,
        /// `Flap.properties.reveal_flap` value never changes on its own.
        pub const locked = struct {
            pub const name = "locked";

            pub const Type = c_int;
        };

        /// Whether the flap is modal.
        ///
        /// If `TRUE`, clicking the content widget while flap is revealed, as well as
        /// pressing the <kbd>Esc</kbd> key, will close the flap. If `FALSE`, clicks
        /// are passed through to the content widget.
        pub const modal = struct {
            pub const name = "modal";

            pub const Type = c_int;
        };

        /// Whether the flap widget is revealed.
        pub const reveal_flap = struct {
            pub const name = "reveal-flap";

            pub const Type = c_int;
        };

        /// The reveal animation spring parameters.
        ///
        /// The default value is equivalent to:
        ///
        /// ```c
        /// adw_spring_params_new (1, 0.5, 500)
        /// ```
        pub const reveal_params = struct {
            pub const name = "reveal-params";

            pub const Type = ?*adw.SpringParams;
        };

        /// The current reveal transition progress.
        ///
        /// 0 means fully hidden, 1 means fully revealed.
        ///
        /// See `Flap.properties.reveal_flap`.
        pub const reveal_progress = struct {
            pub const name = "reveal-progress";

            pub const Type = f64;
        };

        /// The separator widget.
        ///
        /// It's displayed between content and flap when there's no shadow to display.
        /// When exactly it's visible depends on the `Flap.properties.transition_type`
        /// value.
        pub const separator = struct {
            pub const name = "separator";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the flap can be closed with a swipe gesture.
        ///
        /// The area that can be swiped depends on the `Flap.properties.transition_type`
        /// value.
        pub const swipe_to_close = struct {
            pub const name = "swipe-to-close";

            pub const Type = c_int;
        };

        /// Whether the flap can be opened with a swipe gesture.
        ///
        /// The area that can be swiped depends on the `Flap.properties.transition_type`
        /// value.
        pub const swipe_to_open = struct {
            pub const name = "swipe-to-open";

            pub const Type = c_int;
        };

        /// the type of animation used for reveal and fold transitions.
        ///
        /// `Flap.properties.flap` is transparent by default, which means the content
        /// will be seen through it with `ADW_FLAP_TRANSITION_TYPE_OVER` transitions;
        /// add the [`.background`](style-classes.html`background`) style class to it if
        /// this is unwanted.
        pub const transition_type = struct {
            pub const name = "transition-type";

            pub const Type = adw.FlapTransitionType;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwFlap`.
    extern fn adw_flap_new() *adw.Flap;
    pub const new = adw_flap_new;

    /// Gets the content widget for `self`.
    extern fn adw_flap_get_content(p_self: *Flap) ?*gtk.Widget;
    pub const getContent = adw_flap_get_content;

    /// Gets the flap widget for `self`.
    extern fn adw_flap_get_flap(p_self: *Flap) ?*gtk.Widget;
    pub const getFlap = adw_flap_get_flap;

    /// Gets the flap position for `self`.
    extern fn adw_flap_get_flap_position(p_self: *Flap) gtk.PackType;
    pub const getFlapPosition = adw_flap_get_flap_position;

    /// Gets the fold transition animation duration for `self`, in milliseconds.
    extern fn adw_flap_get_fold_duration(p_self: *Flap) c_uint;
    pub const getFoldDuration = adw_flap_get_fold_duration;

    /// Gets the fold policy for `self`.
    extern fn adw_flap_get_fold_policy(p_self: *Flap) adw.FlapFoldPolicy;
    pub const getFoldPolicy = adw_flap_get_fold_policy;

    /// Gets the fold threshold policy for `self`.
    extern fn adw_flap_get_fold_threshold_policy(p_self: *Flap) adw.FoldThresholdPolicy;
    pub const getFoldThresholdPolicy = adw_flap_get_fold_threshold_policy;

    /// Gets whether `self` is currently folded.
    ///
    /// See `Flap.properties.fold_policy`.
    extern fn adw_flap_get_folded(p_self: *Flap) c_int;
    pub const getFolded = adw_flap_get_folded;

    /// Gets whether `self` is locked.
    extern fn adw_flap_get_locked(p_self: *Flap) c_int;
    pub const getLocked = adw_flap_get_locked;

    /// Gets whether `self` is modal.
    extern fn adw_flap_get_modal(p_self: *Flap) c_int;
    pub const getModal = adw_flap_get_modal;

    /// Gets whether the flap widget is revealed for `self`.
    extern fn adw_flap_get_reveal_flap(p_self: *Flap) c_int;
    pub const getRevealFlap = adw_flap_get_reveal_flap;

    /// Gets the reveal animation spring parameters for `self`.
    extern fn adw_flap_get_reveal_params(p_self: *Flap) *adw.SpringParams;
    pub const getRevealParams = adw_flap_get_reveal_params;

    /// Gets the current reveal progress for `self`.
    ///
    /// 0 means fully hidden, 1 means fully revealed.
    ///
    /// See `Flap.properties.reveal_flap`.
    extern fn adw_flap_get_reveal_progress(p_self: *Flap) f64;
    pub const getRevealProgress = adw_flap_get_reveal_progress;

    /// Gets the separator widget for `self`.
    extern fn adw_flap_get_separator(p_self: *Flap) ?*gtk.Widget;
    pub const getSeparator = adw_flap_get_separator;

    /// Gets whether `self` can be closed with a swipe gesture.
    extern fn adw_flap_get_swipe_to_close(p_self: *Flap) c_int;
    pub const getSwipeToClose = adw_flap_get_swipe_to_close;

    /// Gets whether `self` can be opened with a swipe gesture.
    extern fn adw_flap_get_swipe_to_open(p_self: *Flap) c_int;
    pub const getSwipeToOpen = adw_flap_get_swipe_to_open;

    /// Gets the type of animation used for reveal and fold transitions in `self`.
    extern fn adw_flap_get_transition_type(p_self: *Flap) adw.FlapTransitionType;
    pub const getTransitionType = adw_flap_get_transition_type;

    /// Sets the content widget for `self`.
    ///
    /// It's always displayed when unfolded, and partially visible when folded.
    extern fn adw_flap_set_content(p_self: *Flap, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_flap_set_content;

    /// Sets the flap widget for `self`.
    ///
    /// It's only visible when `Flap.properties.reveal_progress` is greater than 0.
    extern fn adw_flap_set_flap(p_self: *Flap, p_flap: ?*gtk.Widget) void;
    pub const setFlap = adw_flap_set_flap;

    /// Sets the flap position for `self`.
    ///
    /// If it's set to `GTK_PACK_START`, the flap is displayed before the content,
    /// if `GTK_PACK_END`, it's displayed after the content.
    extern fn adw_flap_set_flap_position(p_self: *Flap, p_position: gtk.PackType) void;
    pub const setFlapPosition = adw_flap_set_flap_position;

    /// Sets the fold transition animation duration for `self`, in milliseconds.
    extern fn adw_flap_set_fold_duration(p_self: *Flap, p_duration: c_uint) void;
    pub const setFoldDuration = adw_flap_set_fold_duration;

    /// Sets the fold policy for `self`.
    extern fn adw_flap_set_fold_policy(p_self: *Flap, p_policy: adw.FlapFoldPolicy) void;
    pub const setFoldPolicy = adw_flap_set_fold_policy;

    /// Sets the fold threshold policy for `self`.
    ///
    /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, flap will only fold when the
    /// children cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`, it
    /// will fold as soon as children don't get their natural size.
    ///
    /// This can be useful if you have a long ellipsizing label and want to let it
    /// ellipsize instead of immediately folding.
    extern fn adw_flap_set_fold_threshold_policy(p_self: *Flap, p_policy: adw.FoldThresholdPolicy) void;
    pub const setFoldThresholdPolicy = adw_flap_set_fold_threshold_policy;

    /// Sets whether `self` is locked.
    ///
    /// If `FALSE`, folding when the flap is revealed automatically closes it, and
    /// unfolding it when the flap is not revealed opens it. If `TRUE`,
    /// `Flap.properties.reveal_flap` value never changes on its own.
    extern fn adw_flap_set_locked(p_self: *Flap, p_locked: c_int) void;
    pub const setLocked = adw_flap_set_locked;

    /// Sets whether `self` is modal.
    ///
    /// If `TRUE`, clicking the content widget while flap is revealed, as well as
    /// pressing the <kbd>Esc</kbd> key, will close the flap. If `FALSE`, clicks are
    /// passed through to the content widget.
    extern fn adw_flap_set_modal(p_self: *Flap, p_modal: c_int) void;
    pub const setModal = adw_flap_set_modal;

    /// Sets whether the flap widget is revealed for `self`.
    extern fn adw_flap_set_reveal_flap(p_self: *Flap, p_reveal_flap: c_int) void;
    pub const setRevealFlap = adw_flap_set_reveal_flap;

    /// Sets the reveal animation spring parameters for `self`.
    ///
    /// The default value is equivalent to:
    ///
    /// ```c
    /// adw_spring_params_new (1, 0.5, 500)
    /// ```
    extern fn adw_flap_set_reveal_params(p_self: *Flap, p_params: *adw.SpringParams) void;
    pub const setRevealParams = adw_flap_set_reveal_params;

    /// Sets the separator widget for `self`.
    ///
    /// It's displayed between content and flap when there's no shadow to display.
    /// When exactly it's visible depends on the `Flap.properties.transition_type`
    /// value.
    extern fn adw_flap_set_separator(p_self: *Flap, p_separator: ?*gtk.Widget) void;
    pub const setSeparator = adw_flap_set_separator;

    /// Sets whether `self` can be closed with a swipe gesture.
    ///
    /// The area that can be swiped depends on the `Flap.properties.transition_type`
    /// value.
    extern fn adw_flap_set_swipe_to_close(p_self: *Flap, p_swipe_to_close: c_int) void;
    pub const setSwipeToClose = adw_flap_set_swipe_to_close;

    /// Sets whether `self` can be opened with a swipe gesture.
    ///
    /// The area that can be swiped depends on the `Flap.properties.transition_type`
    /// value.
    extern fn adw_flap_set_swipe_to_open(p_self: *Flap, p_swipe_to_open: c_int) void;
    pub const setSwipeToOpen = adw_flap_set_swipe_to_open;

    /// Sets the type of animation used for reveal and fold transitions in `self`.
    ///
    /// `Flap.properties.flap` is transparent by default, which means the content will
    /// be seen through it with `ADW_FLAP_TRANSITION_TYPE_OVER` transitions; add the
    /// [`.background`](style-classes.html`background`) style class to it if this is
    /// unwanted.
    extern fn adw_flap_set_transition_type(p_self: *Flap, p_transition_type: adw.FlapTransitionType) void;
    pub const setTransitionType = adw_flap_set_transition_type;

    extern fn adw_flap_get_type() usize;
    pub const getGObjectType = adw_flap_get_type;

    extern fn g_object_ref(p_self: *adw.Flap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Flap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Flap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A title bar widget.
///
/// <picture>
///   <source srcset="header-bar-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="header-bar.png" alt="header-bar">
/// </picture>
///
/// `AdwHeaderBar` is similar to `gtk.HeaderBar`, but provides additional
/// features compared to it. Refer to `GtkHeaderBar` for details. It is typically
/// used as a top bar within `ToolbarView`.
///
/// ## Dialog Integration
///
/// When placed inside an `Dialog`, `AdwHeaderBar` will display the dialog
/// title instead of window title. It will also adjust the decoration layout to
/// ensure it always has a close button and nothing else. Set
/// `HeaderBar.properties.show_start_title_buttons` and
/// `HeaderBar.properties.show_end_title_buttons` to `FALSE` to remove it if it's
/// unwanted.
///
/// ## Navigation View Integration
///
/// When placed inside an `NavigationPage`, `AdwHeaderBar` will display the
/// page title instead of window title.
///
/// When used together with `NavigationView` or `NavigationSplitView`,
/// it will also display a back button that can be used to go back to the previous
/// page. The button also has a context menu, allowing to pop multiple pages at
/// once, potentially across multiple navigation views.
///
/// Set `HeaderBar.properties.show_back_button` to `FALSE` to disable this behavior
/// in rare scenarios where it's unwanted.
///
/// ## Split View Integration
///
/// When placed inside `NavigationSplitView` or `OverlaySplitView`,
/// `AdwHeaderBar` will automatically hide the title buttons other than at the
/// edges of the window.
///
/// ## Bottom Sheet Integration
///
/// When played inside `BottomSheet`, `AdwHeaderBar` will not show the title
/// unless `BottomSheet.properties.show_drag_handle` is set to `FALSE`, regardless
/// of `HeaderBar.properties.show_title`. This only applies to the default title,
/// titles set with `HeaderBar.properties.title_widget` will still be shown.
///
/// ## Centering Policy
///
/// `HeaderBar.properties.centering_policy` allows to enforce strict centering of
/// the title widget. This can be useful for entries inside `Clamp`.
///
/// ## Title Buttons
///
/// Unlike `GtkHeaderBar`, `AdwHeaderBar` allows to toggle title button
/// visibility for each side individually, using the
/// `HeaderBar.properties.show_start_title_buttons` and
/// `HeaderBar.properties.show_end_title_buttons` properties.
///
/// ## CSS nodes
///
/// ```
/// headerbar
/// ╰── windowhandle
///     ╰── box
///         ├── widget
///         │   ╰── box.start
///         │       ├── windowcontrols.start
///         │       ├── widget
///         │       │   ╰── [button.back]
///         │       ╰── [other children]
///         ├── widget
///         │   ╰── [Title Widget]
///         ╰── widget
///             ╰── box.end
///                 ├── [other children]
///                 ╰── windowcontrols.end
/// ```
///
/// `AdwHeaderBar`'s CSS node is called `headerbar`. It contains a `windowhandle`
/// subnode, which contains a `box` subnode, which contains three `widget`
/// subnodes at the start, center and end of the header bar. The start and end
/// subnodes contain a `box` subnode with the `.start` and `.end` style classes
/// respectively, and the center node contains a node that represents the title.
///
/// Each of the boxes contains a `windowcontrols` subnode, see
/// `gtk.WindowControls` for details, as well as other children.
///
/// When `HeaderBar.properties.show_back_button` is `TRUE`, the start box also
/// contains a node with the name `widget` that contains a node with the name
/// `button` and `.back` style class.
///
/// ## Accessibility
///
/// `AdwHeaderBar` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const HeaderBar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.HeaderBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The policy for aligning the center widget.
        pub const centering_policy = struct {
            pub const name = "centering-policy";

            pub const Type = adw.CenteringPolicy;
        };

        /// The decoration layout for buttons.
        ///
        /// If this property is not set, the
        /// `gtk.Settings.properties.gtk_decoration_layout` setting is used.
        ///
        /// The format of the string is button names, separated by commas. A colon
        /// separates the buttons that should appear at the start from those at the
        /// end. Recognized button names are minimize, maximize, close and icon (the
        /// window icon).
        ///
        /// For example, “icon:minimize,maximize,close” specifies an icon at the start,
        /// and minimize, maximize and close buttons at the end.
        pub const decoration_layout = struct {
            pub const name = "decoration-layout";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the header bar can show the back button.
        ///
        /// The back button will never be shown unless the header bar is placed inside an
        /// `NavigationView`. Usually, there is no reason to set this to `FALSE`.
        pub const show_back_button = struct {
            pub const name = "show-back-button";

            pub const Type = c_int;
        };

        /// Whether to show title buttons at the end of the header bar.
        ///
        /// See `HeaderBar.properties.show_start_title_buttons` for the other side.
        ///
        /// Which buttons are actually shown and where is determined by the
        /// `HeaderBar.properties.decoration_layout` property, and by the state of the
        /// window (e.g. a close button will not be shown if the window can't be
        /// closed).
        pub const show_end_title_buttons = struct {
            pub const name = "show-end-title-buttons";

            pub const Type = c_int;
        };

        /// Whether to show title buttons at the start of the header bar.
        ///
        /// See `HeaderBar.properties.show_end_title_buttons` for the other side.
        ///
        /// Which buttons are actually shown and where is determined by the
        /// `HeaderBar.properties.decoration_layout` property, and by the state of the
        /// window (e.g. a close button will not be shown if the window can't be
        /// closed).
        pub const show_start_title_buttons = struct {
            pub const name = "show-start-title-buttons";

            pub const Type = c_int;
        };

        /// Whether the title widget should be shown.
        pub const show_title = struct {
            pub const name = "show-title";

            pub const Type = c_int;
        };

        /// The title widget to display.
        ///
        /// When set to `NULL`, the header bar will display the title of the window it
        /// is contained in.
        ///
        /// To use a different title, use `WindowTitle`:
        ///
        /// ```xml
        /// <object class="AdwHeaderBar">
        ///   <property name="title-widget">
        ///     <object class="AdwWindowTitle">
        ///       <property name="title" translatable="yes">Title</property>
        ///     </object>
        ///   </property>
        /// </object>
        /// ```
        pub const title_widget = struct {
            pub const name = "title-widget";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwHeaderBar`.
    extern fn adw_header_bar_new() *adw.HeaderBar;
    pub const new = adw_header_bar_new;

    /// Gets the policy for aligning the center widget.
    extern fn adw_header_bar_get_centering_policy(p_self: *HeaderBar) adw.CenteringPolicy;
    pub const getCenteringPolicy = adw_header_bar_get_centering_policy;

    /// Gets the decoration layout for `self`.
    extern fn adw_header_bar_get_decoration_layout(p_self: *HeaderBar) ?[*:0]const u8;
    pub const getDecorationLayout = adw_header_bar_get_decoration_layout;

    /// Gets whether `self` can show the back button.
    extern fn adw_header_bar_get_show_back_button(p_self: *HeaderBar) c_int;
    pub const getShowBackButton = adw_header_bar_get_show_back_button;

    /// Gets whether to show title buttons at the end of `self`.
    extern fn adw_header_bar_get_show_end_title_buttons(p_self: *HeaderBar) c_int;
    pub const getShowEndTitleButtons = adw_header_bar_get_show_end_title_buttons;

    /// Gets whether to show title buttons at the start of `self`.
    extern fn adw_header_bar_get_show_start_title_buttons(p_self: *HeaderBar) c_int;
    pub const getShowStartTitleButtons = adw_header_bar_get_show_start_title_buttons;

    /// Gets whether the title widget should be shown.
    extern fn adw_header_bar_get_show_title(p_self: *HeaderBar) c_int;
    pub const getShowTitle = adw_header_bar_get_show_title;

    /// Gets the title widget widget of `self`.
    extern fn adw_header_bar_get_title_widget(p_self: *HeaderBar) ?*gtk.Widget;
    pub const getTitleWidget = adw_header_bar_get_title_widget;

    /// Adds `child` to `self`, packed with reference to the end of `self`.
    extern fn adw_header_bar_pack_end(p_self: *HeaderBar, p_child: *gtk.Widget) void;
    pub const packEnd = adw_header_bar_pack_end;

    /// Adds `child` to `self`, packed with reference to the start of the `self`.
    extern fn adw_header_bar_pack_start(p_self: *HeaderBar, p_child: *gtk.Widget) void;
    pub const packStart = adw_header_bar_pack_start;

    /// Removes a child from `self`.
    ///
    /// The child must have been added with `HeaderBar.packStart`,
    /// `HeaderBar.packEnd` or `HeaderBar.properties.title_widget`.
    extern fn adw_header_bar_remove(p_self: *HeaderBar, p_child: *gtk.Widget) void;
    pub const remove = adw_header_bar_remove;

    /// Sets the policy for aligning the center widget.
    extern fn adw_header_bar_set_centering_policy(p_self: *HeaderBar, p_centering_policy: adw.CenteringPolicy) void;
    pub const setCenteringPolicy = adw_header_bar_set_centering_policy;

    /// Sets the decoration layout for `self`.
    ///
    /// If this property is not set, the
    /// `gtk.Settings.properties.gtk_decoration_layout` setting is used.
    ///
    /// The format of the string is button names, separated by commas. A colon
    /// separates the buttons that should appear at the start from those at the end.
    /// Recognized button names are minimize, maximize, close and icon (the window
    /// icon).
    ///
    /// For example, “icon:minimize,maximize,close” specifies an icon at the start,
    /// and minimize, maximize and close buttons at the end.
    extern fn adw_header_bar_set_decoration_layout(p_self: *HeaderBar, p_layout: ?[*:0]const u8) void;
    pub const setDecorationLayout = adw_header_bar_set_decoration_layout;

    /// Sets whether `self` can show the back button.
    ///
    /// The back button will never be shown unless the header bar is placed inside an
    /// `NavigationView`. Usually, there is no reason to set it to `FALSE`.
    extern fn adw_header_bar_set_show_back_button(p_self: *HeaderBar, p_show_back_button: c_int) void;
    pub const setShowBackButton = adw_header_bar_set_show_back_button;

    /// Sets whether to show title buttons at the end of `self`.
    ///
    /// See `HeaderBar.properties.show_start_title_buttons` for the other side.
    ///
    /// Which buttons are actually shown and where is determined by the
    /// `HeaderBar.properties.decoration_layout` property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be closed).
    extern fn adw_header_bar_set_show_end_title_buttons(p_self: *HeaderBar, p_setting: c_int) void;
    pub const setShowEndTitleButtons = adw_header_bar_set_show_end_title_buttons;

    /// Sets whether to show title buttons at the start of `self`.
    ///
    /// See `HeaderBar.properties.show_end_title_buttons` for the other side.
    ///
    /// Which buttons are actually shown and where is determined by the
    /// `HeaderBar.properties.decoration_layout` property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be closed).
    extern fn adw_header_bar_set_show_start_title_buttons(p_self: *HeaderBar, p_setting: c_int) void;
    pub const setShowStartTitleButtons = adw_header_bar_set_show_start_title_buttons;

    /// Sets whether the title widget should be shown.
    extern fn adw_header_bar_set_show_title(p_self: *HeaderBar, p_show_title: c_int) void;
    pub const setShowTitle = adw_header_bar_set_show_title;

    /// Sets the title widget for `self`.
    ///
    /// When set to `NULL`, the header bar will display the title of the window it
    /// is contained in.
    ///
    /// To use a different title, use `WindowTitle`:
    ///
    /// ```xml
    /// <object class="AdwHeaderBar">
    ///   <property name="title-widget">
    ///     <object class="AdwWindowTitle">
    ///       <property name="title" translatable="yes">Title</property>
    ///     </object>
    ///   </property>
    /// </object>
    /// ```
    extern fn adw_header_bar_set_title_widget(p_self: *HeaderBar, p_title_widget: ?*gtk.Widget) void;
    pub const setTitleWidget = adw_header_bar_set_title_widget;

    extern fn adw_header_bar_get_type() usize;
    pub const getGObjectType = adw_header_bar_get_type;

    extern fn g_object_ref(p_self: *adw.HeaderBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.HeaderBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HeaderBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A view switcher that uses a toggle group.
///
/// <picture>
///   <source srcset="inline-view-switcher-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="inline-view-switcher.png" alt="inline-view-switcher">
/// </picture>
///
/// A view switcher showing pages of an `ViewStack` within an
/// `ToggleGroup`, similar to `ViewSwitcher`.
///
/// The toggles can display either an icon, a label or both. Use the
/// `InlineViewSwitcher.properties.display_mode` to control this.
///
/// <picture>
///   <source srcset="inline-view-switcher-display-modes-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="inline-view-switcher-display-modes.png" alt="inline-view-switcher-display-modes">
/// </picture>
///
/// ## CSS nodes
///
/// `AdwInlineViewSwitcher` has a single CSS node with the name
/// `inline-view-switcher`.
///
/// ## Style classes
///
/// Like `AdwToggleGroup`, it can accept the [`.flat`](style-classes.html`flat_1`)
/// and [`.round`](style-classes.html`round`) style classes.
///
/// <picture>
///   <source srcset="inline-view-switcher-style-classes-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="inline-view-switcher-style-classes.png" alt="inline-view-switcher-style-classes">
/// </picture>
///
/// ## Accessibility
///
/// The internal toggle group uses the `GTK_ACCESSIBLE_ROLE_TAB_LIST` role. Its
/// toggles use the `GTK_ACCESSIBLE_ROLE_TAB` role.
pub const InlineViewSwitcher = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.InlineViewSwitcherClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the toggles can be smaller than the natural size of their contents.
        ///
        /// If set to `TRUE`, the toggle labels will ellipsize.
        ///
        /// See `ToggleGroup.properties.can_shrink`.
        pub const can_shrink = struct {
            pub const name = "can-shrink";

            pub const Type = c_int;
        };

        /// The display mode.
        ///
        /// Determines what the toggles display: a label, an icon or both.
        ///
        /// <picture>
        ///   <source srcset="inline-view-switcher-display-modes-dark.png" media="(prefers-color-scheme: dark)">
        ///   <img src="inline-view-switcher-display-modes.png" alt="inline-view-switcher-display-modes">
        /// </picture>
        pub const display_mode = struct {
            pub const name = "display-mode";

            pub const Type = adw.InlineViewSwitcherDisplayMode;
        };

        /// Whether all toggles take the same size.
        pub const homogeneous = struct {
            pub const name = "homogeneous";

            pub const Type = c_int;
        };

        /// The stack the view switcher controls.
        pub const stack = struct {
            pub const name = "stack";

            pub const Type = ?*adw.ViewStack;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwInlineViewSwitcher`.
    extern fn adw_inline_view_switcher_new() *adw.InlineViewSwitcher;
    pub const new = adw_inline_view_switcher_new;

    /// Gets whether the toggles can be smaller than the natural size of their
    /// contents.
    extern fn adw_inline_view_switcher_get_can_shrink(p_self: *InlineViewSwitcher) c_int;
    pub const getCanShrink = adw_inline_view_switcher_get_can_shrink;

    /// Gets the display mode of `self`.
    extern fn adw_inline_view_switcher_get_display_mode(p_self: *InlineViewSwitcher) adw.InlineViewSwitcherDisplayMode;
    pub const getDisplayMode = adw_inline_view_switcher_get_display_mode;

    /// Gets whether all toggles within `self` take the same size.
    extern fn adw_inline_view_switcher_get_homogeneous(p_self: *InlineViewSwitcher) c_int;
    pub const getHomogeneous = adw_inline_view_switcher_get_homogeneous;

    /// Gets the stack `self` controls.
    extern fn adw_inline_view_switcher_get_stack(p_self: *InlineViewSwitcher) ?*adw.ViewStack;
    pub const getStack = adw_inline_view_switcher_get_stack;

    /// Sets whether the toggles can be smaller than the natural size of their
    /// contents.
    ///
    /// If `can_shrink` is `TRUE`, the toggle labels will ellipsize.
    ///
    /// See `ToggleGroup.properties.can_shrink`.
    extern fn adw_inline_view_switcher_set_can_shrink(p_self: *InlineViewSwitcher, p_can_shrink: c_int) void;
    pub const setCanShrink = adw_inline_view_switcher_set_can_shrink;

    /// Sets the display mode of `self`.
    ///
    /// Determines what the toggles display: a label, an icon or both.
    ///
    /// <picture>
    ///   <source srcset="inline-view-switcher-display-modes-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img src="inline-view-switcher-display-modes.png" alt="inline-view-switcher-display-modes">
    /// </picture>
    extern fn adw_inline_view_switcher_set_display_mode(p_self: *InlineViewSwitcher, p_mode: adw.InlineViewSwitcherDisplayMode) void;
    pub const setDisplayMode = adw_inline_view_switcher_set_display_mode;

    /// Sets whether all toggles within `self` take the same size.
    extern fn adw_inline_view_switcher_set_homogeneous(p_self: *InlineViewSwitcher, p_homogeneous: c_int) void;
    pub const setHomogeneous = adw_inline_view_switcher_set_homogeneous;

    /// Sets the stack to control.
    extern fn adw_inline_view_switcher_set_stack(p_self: *InlineViewSwitcher, p_stack: ?*adw.ViewStack) void;
    pub const setStack = adw_inline_view_switcher_set_stack;

    extern fn adw_inline_view_switcher_get_type() usize;
    pub const getGObjectType = adw_inline_view_switcher_get_type;

    extern fn g_object_ref(p_self: *adw.InlineViewSwitcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.InlineViewSwitcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InlineViewSwitcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An individual layout in `MultiLayoutView`.
pub const Layout = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.Buildable};
    pub const Class = adw.LayoutClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The content widget.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the layout.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwLayout` that contains `content`.
    extern fn adw_layout_new(p_content: *gtk.Widget) *adw.Layout;
    pub const new = adw_layout_new;

    /// Gets the content widget.
    extern fn adw_layout_get_content(p_self: *Layout) *gtk.Widget;
    pub const getContent = adw_layout_get_content;

    /// Gets the name of the layout.
    extern fn adw_layout_get_name(p_self: *Layout) ?[*:0]const u8;
    pub const getName = adw_layout_get_name;

    /// Sets the name of the layout.
    extern fn adw_layout_set_name(p_self: *Layout, p_name: ?[*:0]const u8) void;
    pub const setName = adw_layout_set_name;

    extern fn adw_layout_get_type() usize;
    pub const getGObjectType = adw_layout_get_type;

    extern fn g_object_ref(p_self: *adw.Layout) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Layout) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Layout, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A child slot within `Layout`.
///
/// While it contains a layout child, the `gtk.Widget.properties.visible` property
/// of the slot is updated to match that of the layout child.
///
/// See `MultiLayoutView`.
pub const LayoutSlot = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.LayoutSlotClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The slot ID.
        ///
        /// See `MultiLayoutView.setChild`.
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwLayoutSlot` with its ID set to `id`.
    extern fn adw_layout_slot_new(p_id: [*:0]const u8) *adw.LayoutSlot;
    pub const new = adw_layout_slot_new;

    /// Gets the slot id of `self`.
    extern fn adw_layout_slot_get_slot_id(p_self: *LayoutSlot) [*:0]const u8;
    pub const getSlotId = adw_layout_slot_get_slot_id;

    extern fn adw_layout_slot_get_type() usize;
    pub const getGObjectType = adw_layout_slot_get_type;

    extern fn g_object_ref(p_self: *adw.LayoutSlot) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.LayoutSlot) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LayoutSlot, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An adaptive container acting like a box or a stack.
///
/// <picture>
///   <source srcset="leaflet-wide-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="leaflet-wide.png" alt="leaflet-wide">
/// </picture>
/// <picture>
///   <source srcset="leaflet-narrow-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="leaflet-narrow.png" alt="leaflet-narrow">
/// </picture>
///
/// The `AdwLeaflet` widget can display its children like a `gtk.Box` does
/// or like a `gtk.Stack` does, adapting to size changes by switching
/// between the two modes.
///
/// When there is enough space the children are displayed side by side, otherwise
/// only one is displayed and the leaflet is said to be “folded”.
/// The threshold is dictated by the preferred minimum sizes of the children.
/// When a leaflet is folded, the children can be navigated using swipe gestures.
///
/// The “over” and “under” transition types stack the children one on top of the
/// other, while the “slide” transition puts the children side by side. While
/// navigating to a child on the side or below can be performed by swiping the
/// current child away, navigating to an upper child requires dragging it from
/// the edge where it resides. This doesn't affect non-dragging swipes.
///
/// ## CSS nodes
///
/// `AdwLeaflet` has a single CSS node with name `leaflet`. The node will get the
/// style classes `.folded` when it is folded, `.unfolded` when it's not, or none
/// if it hasn't computed its fold yet.
pub const Leaflet = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.LeafletClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether gestures and shortcuts for navigating backward are enabled.
        ///
        /// The supported gestures are:
        ///
        /// - One-finger swipe on touchscreens
        /// - Horizontal scrolling on touchpads (usually two-finger swipe)
        /// - Back/forward mouse buttons
        ///
        /// The keyboard back/forward keys are also supported, as well as the
        /// <kbd>Alt</kbd>+<kbd>←</kbd> shortcut for horizontal orientation, or
        /// <kbd>Alt</kbd>+<kbd>↑</kbd> for vertical orientation.
        ///
        /// If the orientation is horizontal, for right-to-left locales, gestures and
        /// shortcuts are reversed.
        ///
        /// Only children that have `LeafletPage.properties.navigatable` set to `TRUE`
        /// can be navigated to.
        pub const can_navigate_back = struct {
            pub const name = "can-navigate-back";

            pub const Type = c_int;
        };

        /// Whether gestures and shortcuts for navigating forward are enabled.
        ///
        /// The supported gestures are:
        ///
        /// - One-finger swipe on touchscreens
        /// - Horizontal scrolling on touchpads (usually two-finger swipe)
        /// - Back/forward mouse buttons
        ///
        /// The keyboard back/forward keys are also supported, as well as the
        /// <kbd>Alt</kbd>+<kbd>→</kbd> shortcut for horizontal orientation, or
        /// <kbd>Alt</kbd>+<kbd>↓</kbd> for vertical orientation.
        ///
        /// If the orientation is horizontal, for right-to-left locales, gestures and
        /// shortcuts are reversed.
        ///
        /// Only children that have `LeafletPage.properties.navigatable` set to `TRUE`
        /// can be navigated to.
        pub const can_navigate_forward = struct {
            pub const name = "can-navigate-forward";

            pub const Type = c_int;
        };

        /// Whether or not the leaflet can unfold.
        pub const can_unfold = struct {
            pub const name = "can-unfold";

            pub const Type = c_int;
        };

        /// The child transition spring parameters.
        ///
        /// The default value is equivalent to:
        ///
        /// ```c
        /// adw_spring_params_new (1, 0.5, 500)
        /// ```
        pub const child_transition_params = struct {
            pub const name = "child-transition-params";

            pub const Type = ?*adw.SpringParams;
        };

        /// Whether a child transition is currently running.
        pub const child_transition_running = struct {
            pub const name = "child-transition-running";

            pub const Type = c_int;
        };

        /// Determines when the leaflet will fold.
        ///
        /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, it will only fold when the
        /// children cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`, it
        /// will fold as soon as children don't get their natural size.
        ///
        /// This can be useful if you have a long ellipsizing label and want to let it
        /// ellipsize instead of immediately folding.
        pub const fold_threshold_policy = struct {
            pub const name = "fold-threshold-policy";

            pub const Type = adw.FoldThresholdPolicy;
        };

        /// Whether the leaflet is folded.
        ///
        /// The leaflet will be folded if the size allocated to it is smaller than the
        /// sum of the minimum or natural sizes of the children (see
        /// `Leaflet.properties.fold_threshold_policy`), it will be unfolded otherwise.
        pub const folded = struct {
            pub const name = "folded";

            pub const Type = c_int;
        };

        /// Whether the leaflet allocates the same size for all children when folded.
        ///
        /// If set to `FALSE`, different children can have different size along the
        /// opposite orientation.
        pub const homogeneous = struct {
            pub const name = "homogeneous";

            pub const Type = c_int;
        };

        /// The mode transition animation duration, in milliseconds.
        pub const mode_transition_duration = struct {
            pub const name = "mode-transition-duration";

            pub const Type = c_uint;
        };

        /// A selection model with the leaflet's pages.
        ///
        /// This can be used to keep an up-to-date view. The model also implements
        /// `gtk.SelectionModel` and can be used to track and change the visible
        /// page.
        pub const pages = struct {
            pub const name = "pages";

            pub const Type = ?*gtk.SelectionModel;
        };

        /// The type of animation used for transitions between modes and children.
        ///
        /// The transition type can be changed without problems at runtime, so it is
        /// possible to change the animation based on the mode or child that is about
        /// to become current.
        pub const transition_type = struct {
            pub const name = "transition-type";

            pub const Type = adw.LeafletTransitionType;
        };

        /// The widget currently visible when the leaflet is folded.
        ///
        /// The transition is determined by `Leaflet.properties.transition_type` and
        /// `Leaflet.properties.child_transition_params`. The transition can be cancelled
        /// by the user, in which case visible child will change back to the previously
        /// visible child.
        pub const visible_child = struct {
            pub const name = "visible-child";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the widget currently visible when the leaflet is folded.
        ///
        /// See `Leaflet.properties.visible_child`.
        pub const visible_child_name = struct {
            pub const name = "visible-child-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwLeaflet`.
    extern fn adw_leaflet_new() *adw.Leaflet;
    pub const new = adw_leaflet_new;

    /// Adds a child to `self`.
    extern fn adw_leaflet_append(p_self: *Leaflet, p_child: *gtk.Widget) *adw.LeafletPage;
    pub const append = adw_leaflet_append;

    /// Finds the previous or next navigatable child.
    ///
    /// This will be the same child `Leaflet.navigate` or swipe gestures will
    /// navigate to.
    ///
    /// If there's no child to navigate to, `NULL` will be returned instead.
    ///
    /// See `LeafletPage.properties.navigatable`.
    extern fn adw_leaflet_get_adjacent_child(p_self: *Leaflet, p_direction: adw.NavigationDirection) ?*gtk.Widget;
    pub const getAdjacentChild = adw_leaflet_get_adjacent_child;

    /// Gets whether gestures and shortcuts for navigating backward are enabled.
    extern fn adw_leaflet_get_can_navigate_back(p_self: *Leaflet) c_int;
    pub const getCanNavigateBack = adw_leaflet_get_can_navigate_back;

    /// Gets whether gestures and shortcuts for navigating forward are enabled.
    extern fn adw_leaflet_get_can_navigate_forward(p_self: *Leaflet) c_int;
    pub const getCanNavigateForward = adw_leaflet_get_can_navigate_forward;

    /// Gets whether `self` can unfold.
    extern fn adw_leaflet_get_can_unfold(p_self: *Leaflet) c_int;
    pub const getCanUnfold = adw_leaflet_get_can_unfold;

    /// Finds the child of `self` with `name`.
    ///
    /// Returns `NULL` if there is no child with this name.
    ///
    /// See `LeafletPage.properties.name`.
    extern fn adw_leaflet_get_child_by_name(p_self: *Leaflet, p_name: [*:0]const u8) ?*gtk.Widget;
    pub const getChildByName = adw_leaflet_get_child_by_name;

    /// Gets the child transition spring parameters for `self`.
    extern fn adw_leaflet_get_child_transition_params(p_self: *Leaflet) *adw.SpringParams;
    pub const getChildTransitionParams = adw_leaflet_get_child_transition_params;

    /// Gets whether a child transition is currently running for `self`.
    extern fn adw_leaflet_get_child_transition_running(p_self: *Leaflet) c_int;
    pub const getChildTransitionRunning = adw_leaflet_get_child_transition_running;

    /// Gets the fold threshold policy for `self`.
    extern fn adw_leaflet_get_fold_threshold_policy(p_self: *Leaflet) adw.FoldThresholdPolicy;
    pub const getFoldThresholdPolicy = adw_leaflet_get_fold_threshold_policy;

    /// Gets whether `self` is folded.
    ///
    /// The leaflet will be folded if the size allocated to it is smaller than the
    /// sum of the minimum or natural sizes of the children (see
    /// `Leaflet.properties.fold_threshold_policy`), it will be unfolded otherwise.
    extern fn adw_leaflet_get_folded(p_self: *Leaflet) c_int;
    pub const getFolded = adw_leaflet_get_folded;

    /// Gets whether `self` is homogeneous.
    extern fn adw_leaflet_get_homogeneous(p_self: *Leaflet) c_int;
    pub const getHomogeneous = adw_leaflet_get_homogeneous;

    /// Gets the mode transition animation duration for `self`.
    extern fn adw_leaflet_get_mode_transition_duration(p_self: *Leaflet) c_uint;
    pub const getModeTransitionDuration = adw_leaflet_get_mode_transition_duration;

    /// Returns the `LeafletPage` object for `child`.
    extern fn adw_leaflet_get_page(p_self: *Leaflet, p_child: *gtk.Widget) *adw.LeafletPage;
    pub const getPage = adw_leaflet_get_page;

    /// Returns a `gio.ListModel` that contains the pages of the leaflet.
    ///
    /// This can be used to keep an up-to-date view. The model also implements
    /// `gtk.SelectionModel` and can be used to track and change the visible
    /// page.
    extern fn adw_leaflet_get_pages(p_self: *Leaflet) *gtk.SelectionModel;
    pub const getPages = adw_leaflet_get_pages;

    /// Gets the type of animation used for transitions between modes and children.
    extern fn adw_leaflet_get_transition_type(p_self: *Leaflet) adw.LeafletTransitionType;
    pub const getTransitionType = adw_leaflet_get_transition_type;

    /// Gets the widget currently visible when the leaflet is folded.
    extern fn adw_leaflet_get_visible_child(p_self: *Leaflet) ?*gtk.Widget;
    pub const getVisibleChild = adw_leaflet_get_visible_child;

    /// Gets the name of the currently visible child widget.
    extern fn adw_leaflet_get_visible_child_name(p_self: *Leaflet) ?[*:0]const u8;
    pub const getVisibleChildName = adw_leaflet_get_visible_child_name;

    /// Inserts `child` in the position after `sibling` in the list of children.
    ///
    /// If `sibling` is `NULL`, inserts `child` at the first position.
    extern fn adw_leaflet_insert_child_after(p_self: *Leaflet, p_child: *gtk.Widget, p_sibling: ?*gtk.Widget) *adw.LeafletPage;
    pub const insertChildAfter = adw_leaflet_insert_child_after;

    /// Navigates to the previous or next child.
    ///
    /// The child must have the `LeafletPage.properties.navigatable` property set to
    /// `TRUE`, otherwise it will be skipped.
    ///
    /// This will be the same child as returned by
    /// `Leaflet.getAdjacentChild` or navigated to via swipe gestures.
    extern fn adw_leaflet_navigate(p_self: *Leaflet, p_direction: adw.NavigationDirection) c_int;
    pub const navigate = adw_leaflet_navigate;

    /// Inserts `child` at the first position in `self`.
    extern fn adw_leaflet_prepend(p_self: *Leaflet, p_child: *gtk.Widget) *adw.LeafletPage;
    pub const prepend = adw_leaflet_prepend;

    /// Removes a child widget from `self`.
    extern fn adw_leaflet_remove(p_self: *Leaflet, p_child: *gtk.Widget) void;
    pub const remove = adw_leaflet_remove;

    /// Moves `child` to the position after `sibling` in the list of children.
    ///
    /// If `sibling` is `NULL`, moves `child` to the first position.
    extern fn adw_leaflet_reorder_child_after(p_self: *Leaflet, p_child: *gtk.Widget, p_sibling: ?*gtk.Widget) void;
    pub const reorderChildAfter = adw_leaflet_reorder_child_after;

    /// Sets whether gestures and shortcuts for navigating backward are enabled.
    ///
    /// The supported gestures are:
    ///
    /// - One-finger swipe on touchscreens
    /// - Horizontal scrolling on touchpads (usually two-finger swipe)
    /// - Back/forward mouse buttons
    ///
    /// The keyboard back/forward keys are also supported, as well as the
    /// <kbd>Alt</kbd>+<kbd>←</kbd> shortcut for horizontal orientation, or
    /// <kbd>Alt</kbd>+<kbd>↑</kbd> for vertical orientation.
    ///
    /// If the orientation is horizontal, for right-to-left locales, gestures and
    /// shortcuts are reversed.
    ///
    /// Only children that have `LeafletPage.properties.navigatable` set to `TRUE` can
    /// be navigated to.
    extern fn adw_leaflet_set_can_navigate_back(p_self: *Leaflet, p_can_navigate_back: c_int) void;
    pub const setCanNavigateBack = adw_leaflet_set_can_navigate_back;

    /// Sets whether gestures and shortcuts for navigating forward are enabled.
    ///
    /// The supported gestures are:
    ///
    /// - One-finger swipe on touchscreens
    /// - Horizontal scrolling on touchpads (usually two-finger swipe)
    /// - Back/forward mouse buttons
    ///
    /// The keyboard back/forward keys are also supported, as well as the
    /// <kbd>Alt</kbd>+<kbd>→</kbd> shortcut for horizontal orientation, or
    /// <kbd>Alt</kbd>+<kbd>↓</kbd> for vertical orientation.
    ///
    /// If the orientation is horizontal, for right-to-left locales, gestures and
    /// shortcuts are reversed.
    ///
    /// Only children that have `LeafletPage.properties.navigatable` set to `TRUE` can
    /// be navigated to.
    extern fn adw_leaflet_set_can_navigate_forward(p_self: *Leaflet, p_can_navigate_forward: c_int) void;
    pub const setCanNavigateForward = adw_leaflet_set_can_navigate_forward;

    /// Sets whether `self` can unfold.
    extern fn adw_leaflet_set_can_unfold(p_self: *Leaflet, p_can_unfold: c_int) void;
    pub const setCanUnfold = adw_leaflet_set_can_unfold;

    /// Sets the child transition spring parameters for `self`.
    ///
    /// The default value is equivalent to:
    ///
    /// ```c
    /// adw_spring_params_new (1, 0.5, 500)
    /// ```
    extern fn adw_leaflet_set_child_transition_params(p_self: *Leaflet, p_params: *adw.SpringParams) void;
    pub const setChildTransitionParams = adw_leaflet_set_child_transition_params;

    /// Sets the fold threshold policy for `self`.
    ///
    /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, it will only fold when the
    /// children cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`, it
    /// will fold as soon as children don't get their natural size.
    ///
    /// This can be useful if you have a long ellipsizing label and want to let it
    /// ellipsize instead of immediately folding.
    extern fn adw_leaflet_set_fold_threshold_policy(p_self: *Leaflet, p_policy: adw.FoldThresholdPolicy) void;
    pub const setFoldThresholdPolicy = adw_leaflet_set_fold_threshold_policy;

    /// Sets `self` to be homogeneous or not.
    ///
    /// If set to `FALSE`, different children can have different size along the
    /// opposite orientation.
    extern fn adw_leaflet_set_homogeneous(p_self: *Leaflet, p_homogeneous: c_int) void;
    pub const setHomogeneous = adw_leaflet_set_homogeneous;

    /// Sets the mode transition animation duration for `self`.
    extern fn adw_leaflet_set_mode_transition_duration(p_self: *Leaflet, p_duration: c_uint) void;
    pub const setModeTransitionDuration = adw_leaflet_set_mode_transition_duration;

    /// Sets the type of animation used for transitions between modes and children.
    ///
    /// The transition type can be changed without problems at runtime, so it is
    /// possible to change the animation based on the mode or child that is about to
    /// become current.
    extern fn adw_leaflet_set_transition_type(p_self: *Leaflet, p_transition: adw.LeafletTransitionType) void;
    pub const setTransitionType = adw_leaflet_set_transition_type;

    /// Sets the widget currently visible when the leaflet is folded.
    ///
    /// The transition is determined by `Leaflet.properties.transition_type` and
    /// `Leaflet.properties.child_transition_params`. The transition can be cancelled
    /// by the user, in which case visible child will change back to the previously
    /// visible child.
    extern fn adw_leaflet_set_visible_child(p_self: *Leaflet, p_visible_child: *gtk.Widget) void;
    pub const setVisibleChild = adw_leaflet_set_visible_child;

    /// Makes the child with the name `name` visible.
    ///
    /// See `Leaflet.properties.visible_child`.
    extern fn adw_leaflet_set_visible_child_name(p_self: *Leaflet, p_name: [*:0]const u8) void;
    pub const setVisibleChildName = adw_leaflet_set_visible_child_name;

    extern fn adw_leaflet_get_type() usize;
    pub const getGObjectType = adw_leaflet_get_type;

    extern fn g_object_ref(p_self: *adw.Leaflet) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Leaflet) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Leaflet, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An auxiliary class used by `Leaflet`.
pub const LeafletPage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.LeafletPageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The leaflet child to which the page belongs.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the child page.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the child can be navigated to when folded.
        ///
        /// If `FALSE`, the child will be ignored by
        /// `Leaflet.getAdjacentChild`, `Leaflet.navigate`, and swipe
        /// gestures.
        ///
        /// This can be used used to prevent switching to widgets like separators.
        pub const navigatable = struct {
            pub const name = "navigatable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Gets the leaflet child to which `self` belongs.
    extern fn adw_leaflet_page_get_child(p_self: *LeafletPage) *gtk.Widget;
    pub const getChild = adw_leaflet_page_get_child;

    /// Gets the name of `self`.
    extern fn adw_leaflet_page_get_name(p_self: *LeafletPage) ?[*:0]const u8;
    pub const getName = adw_leaflet_page_get_name;

    /// Gets whether the child can be navigated to when folded.
    extern fn adw_leaflet_page_get_navigatable(p_self: *LeafletPage) c_int;
    pub const getNavigatable = adw_leaflet_page_get_navigatable;

    /// Sets the name of the `self`.
    extern fn adw_leaflet_page_set_name(p_self: *LeafletPage, p_name: ?[*:0]const u8) void;
    pub const setName = adw_leaflet_page_set_name;

    /// Sets whether `self` can be navigated to when folded.
    ///
    /// If `FALSE`, the child will be ignored by `Leaflet.getAdjacentChild`,
    /// `Leaflet.navigate`, and swipe gestures.
    ///
    /// This can be used used to prevent switching to widgets like separators.
    extern fn adw_leaflet_page_set_navigatable(p_self: *LeafletPage, p_navigatable: c_int) void;
    pub const setNavigatable = adw_leaflet_page_set_navigatable;

    extern fn adw_leaflet_page_get_type() usize;
    pub const getGObjectType = adw_leaflet_page_get_type;

    extern fn g_object_ref(p_self: *adw.LeafletPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.LeafletPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LeafletPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A dialog presenting a message or a question.
///
/// <picture>
///   <source srcset="message-dialog-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="message-dialog.png" alt="message-dialog">
/// </picture>
///
/// Message dialogs have a heading, a body, an optional child widget, and one or
/// multiple responses, each presented as a button.
///
/// Each response has a unique string ID, and a button label. Additionally, each
/// response can be enabled or disabled, and can have a suggested or destructive
/// appearance.
///
/// When one of the responses is activated, or the dialog is closed, the
/// `MessageDialog.signals.response` signal will be emitted. This signal is
/// detailed, and the detail, as well as the `response` parameter will be set to
/// the ID of the activated response, or to the value of the
/// `MessageDialog.properties.close_response` property if the dialog had been
/// closed without activating any of the responses.
///
/// Response buttons can be presented horizontally or vertically depending on
/// available space.
///
/// When a response is activated, `AdwMessageDialog` is closed automatically.
///
/// An example of using a message dialog:
///
/// ```c
/// GtkWidget *dialog;
///
/// dialog = adw_message_dialog_new (parent, _("Replace File?"), NULL);
///
/// adw_message_dialog_format_body (ADW_MESSAGE_DIALOG (dialog),
///                                 _("A file named “`s`” already exists. Do you want to replace it?"),
///                                 filename);
///
/// adw_message_dialog_add_responses (ADW_MESSAGE_DIALOG (dialog),
///                                   "cancel",  _("_Cancel"),
///                                   "replace", _("_Replace"),
///                                   NULL);
///
/// adw_message_dialog_set_response_appearance (ADW_MESSAGE_DIALOG (dialog), "replace", ADW_RESPONSE_DESTRUCTIVE);
///
/// adw_message_dialog_set_default_response (ADW_MESSAGE_DIALOG (dialog), "cancel");
/// adw_message_dialog_set_close_response (ADW_MESSAGE_DIALOG (dialog), "cancel");
///
/// g_signal_connect (dialog, "response", G_CALLBACK (response_cb), self);
///
/// gtk_window_present (GTK_WINDOW (dialog));
/// ```
///
/// ## Async API
///
/// `AdwMessageDialog` can also be used via the `MessageDialog.choose`
/// method. This API follows the GIO async pattern, for example:
///
/// ```c
/// static void
/// dialog_cb (AdwMessageDialog *dialog,
///            GAsyncResult     *result,
///            MyWindow         *self)
/// {
///   const char *response = adw_message_dialog_choose_finish (dialog, result);
///
///   // ...
/// }
///
/// static void
/// show_dialog (MyWindow *self)
/// {
///   GtkWidget *dialog;
///
///   dialog = adw_message_dialog_new (GTK_WINDOW (self), _("Replace File?"), NULL);
///
///   adw_message_dialog_format_body (ADW_MESSAGE_DIALOG (dialog),
///                                   _("A file named “`s`” already exists. Do you want to replace it?"),
///                                   filename);
///
///   adw_message_dialog_add_responses (ADW_MESSAGE_DIALOG (dialog),
///                                     "cancel",  _("_Cancel"),
///                                     "replace", _("_Replace"),
///                                     NULL);
///
///   adw_message_dialog_set_response_appearance (ADW_MESSAGE_DIALOG (dialog), "replace", ADW_RESPONSE_DESTRUCTIVE);
///
///   adw_message_dialog_set_default_response (ADW_MESSAGE_DIALOG (dialog), "cancel");
///   adw_message_dialog_set_close_response (ADW_MESSAGE_DIALOG (dialog), "cancel");
///
///   adw_message_dialog_choose (ADW_MESSAGE_DIALOG (dialog), NULL, (GAsyncReadyCallback) dialog_cb, self);
/// }
/// ```
///
/// ## AdwMessageDialog as GtkBuildable
///
/// `AdwMessageDialog` supports adding responses in UI definitions by via the
/// `<responses>` element that may contain multiple `<response>` elements, each
/// representing a response.
///
/// Each of the `<response>` elements must have the `id` attribute specifying the
/// response ID. The contents of the element are used as the response label.
///
/// Response labels can be translated with the usual `translatable`, `context`
/// and `comments` attributes.
///
/// The `<response>` elements can also have `enabled` and/or `appearance`
/// attributes. See `MessageDialog.setResponseEnabled` and
/// `MessageDialog.setResponseAppearance` for details.
///
/// Example of an `AdwMessageDialog` UI definition:
///
/// ```xml
/// <object class="AdwMessageDialog" id="dialog">
///   <property name="heading" translatable="yes">Save Changes?</property>
///   <property name="body" translatable="yes">Open documents contain unsaved changes. Changes which are not saved will be permanently lost.</property>
///   <property name="default-response">save</property>
///   <property name="close-response">cancel</property>
///   <signal name="response" handler="response_cb"/>
///   <responses>
///     <response id="cancel" translatable="yes">_Cancel</response>
///     <response id="discard" translatable="yes" appearance="destructive">_Discard</response>
///     <response id="save" translatable="yes" appearance="suggested" enabled="false">_Save</response>
///   </responses>
/// </object>
/// ```
///
/// ## Accessibility
///
/// `AdwMessageDialog` uses the `GTK_ACCESSIBLE_ROLE_DIALOG` role.
pub const MessageDialog = extern struct {
    pub const Parent = gtk.Window;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = adw.MessageDialogClass;
    f_parent_instance: gtk.Window,

    pub const virtual_methods = struct {
        /// Emits the `MessageDialog.signals.response` signal with the given response ID.
        ///
        /// Used to indicate that the user has responded to the dialog in some way.
        pub const response = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_response: [*:0]const u8) void {
                return gobject.ext.as(MessageDialog.Class, p_class).f_response.?(gobject.ext.as(MessageDialog, p_self), p_response);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_response: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(MessageDialog.Class, p_class).f_response = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The body text of the dialog.
        pub const body = struct {
            pub const name = "body";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the body text includes Pango markup.
        ///
        /// See `pango.parseMarkup`.
        pub const body_use_markup = struct {
            pub const name = "body-use-markup";

            pub const Type = c_int;
        };

        /// The ID of the close response.
        ///
        /// It will be passed to `MessageDialog.signals.response` if the window is
        /// closed by pressing <kbd>Escape</kbd> or with a system action.
        ///
        /// It doesn't have to correspond to any of the responses in the dialog.
        ///
        /// The default close response is `close`.
        pub const close_response = struct {
            pub const name = "close-response";

            pub const Type = ?[*:0]u8;
        };

        /// The response ID of the default response.
        ///
        /// If set, pressing <kbd>Enter</kbd> will activate the corresponding button.
        ///
        /// If set to `NULL` or a non-existent response ID, pressing <kbd>Enter</kbd>
        /// will do nothing.
        pub const default_response = struct {
            pub const name = "default-response";

            pub const Type = ?[*:0]u8;
        };

        /// The child widget.
        ///
        /// Displayed below the heading and body.
        pub const extra_child = struct {
            pub const name = "extra-child";

            pub const Type = ?*gtk.Widget;
        };

        /// The heading of the dialog.
        pub const heading = struct {
            pub const name = "heading";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the heading includes Pango markup.
        ///
        /// See `pango.parseMarkup`.
        pub const heading_use_markup = struct {
            pub const name = "heading-use-markup";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when the dialog is closed.
        ///
        /// `response` will be set to the response ID of the button that had been
        /// activated.
        ///
        /// if the dialog was closed by pressing <kbd>Escape</kbd> or with a system
        /// action, `response` will be set to the value of
        /// `MessageDialog.properties.close_response`.
        pub const response = struct {
            pub const name = "response";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_response: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MessageDialog, p_instance))),
                    gobject.signalLookup("response", MessageDialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwMessageDialog`.
    ///
    /// `heading` and `body` can be set to `NULL`. This can be useful if they need to
    /// be formatted or use markup. In that case, set them to `NULL` and call
    /// `MessageDialog.formatBody` or similar methods afterwards:
    ///
    /// ```c
    /// GtkWidget *dialog;
    ///
    /// dialog = adw_message_dialog_new (parent, _("Replace File?"), NULL);
    /// adw_message_dialog_format_body (ADW_MESSAGE_DIALOG (dialog),
    ///                                 _("A file named “`s`” already exists.  Do you want to replace it?"),
    ///                                 filename);
    /// ```
    extern fn adw_message_dialog_new(p_parent: ?*gtk.Window, p_heading: ?[*:0]const u8, p_body: ?[*:0]const u8) *adw.MessageDialog;
    pub const new = adw_message_dialog_new;

    /// Adds a response with `id` and `label` to `self`.
    ///
    /// Responses are represented as buttons in the dialog.
    ///
    /// Response ID must be unique. It will be used in
    /// `MessageDialog.signals.response` to tell which response had been activated,
    /// as well as to inspect and modify the response later.
    ///
    /// An embedded underline in `label` indicates a mnemonic.
    ///
    /// `MessageDialog.setResponseLabel` can be used to change the response
    /// label after it had been added.
    ///
    /// `MessageDialog.setResponseEnabled` and
    /// `MessageDialog.setResponseAppearance` can be used to customize the
    /// responses further.
    extern fn adw_message_dialog_add_response(p_self: *MessageDialog, p_id: [*:0]const u8, p_label: [*:0]const u8) void;
    pub const addResponse = adw_message_dialog_add_response;

    /// Adds multiple responses to `self`.
    ///
    /// This is the same as calling `MessageDialog.addResponse` repeatedly.
    /// The variable argument list should be `NULL`-terminated list of response IDs
    /// and labels.
    ///
    /// Example:
    ///
    /// ```c
    /// adw_message_dialog_add_responses (dialog,
    ///                                   "cancel",  _("_Cancel"),
    ///                                   "discard", _("_Discard"),
    ///                                   "save",    _("_Save"),
    ///                                   NULL);
    /// ```
    extern fn adw_message_dialog_add_responses(p_self: *MessageDialog, p_first_id: [*:0]const u8, ...) void;
    pub const addResponses = adw_message_dialog_add_responses;

    /// This function shows `self` to the user.
    extern fn adw_message_dialog_choose(p_self: *MessageDialog, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const choose = adw_message_dialog_choose;

    /// Finishes the `MessageDialog.choose` call and returns the response ID.
    extern fn adw_message_dialog_choose_finish(p_self: *MessageDialog, p_result: *gio.AsyncResult) [*:0]const u8;
    pub const chooseFinish = adw_message_dialog_choose_finish;

    /// Sets the formatted body text of `self`.
    ///
    /// See `MessageDialog.properties.body`.
    extern fn adw_message_dialog_format_body(p_self: *MessageDialog, p_format: [*:0]const u8, ...) void;
    pub const formatBody = adw_message_dialog_format_body;

    /// Sets the formatted body text of `self` with Pango markup.
    ///
    /// The `format` is assumed to contain Pango markup.
    ///
    /// Special XML characters in the ``printf`` arguments passed to this function
    /// will  automatically be escaped as necessary, see
    /// `glib.markupPrintfEscaped`.
    ///
    /// See `MessageDialog.properties.body`.
    extern fn adw_message_dialog_format_body_markup(p_self: *MessageDialog, p_format: [*:0]const u8, ...) void;
    pub const formatBodyMarkup = adw_message_dialog_format_body_markup;

    /// Sets the formatted heading of `self`.
    ///
    /// See `MessageDialog.properties.heading`.
    extern fn adw_message_dialog_format_heading(p_self: *MessageDialog, p_format: [*:0]const u8, ...) void;
    pub const formatHeading = adw_message_dialog_format_heading;

    /// Sets the formatted heading of `self` with Pango markup.
    ///
    /// The `format` is assumed to contain Pango markup.
    ///
    /// Special XML characters in the ``printf`` arguments passed to this function
    /// will automatically be escaped as necessary, see
    /// `glib.markupPrintfEscaped`.
    ///
    /// See `MessageDialog.properties.heading`.
    extern fn adw_message_dialog_format_heading_markup(p_self: *MessageDialog, p_format: [*:0]const u8, ...) void;
    pub const formatHeadingMarkup = adw_message_dialog_format_heading_markup;

    /// Gets the body text of `self`.
    extern fn adw_message_dialog_get_body(p_self: *MessageDialog) [*:0]const u8;
    pub const getBody = adw_message_dialog_get_body;

    /// Gets whether the body text of `self` includes Pango markup.
    extern fn adw_message_dialog_get_body_use_markup(p_self: *MessageDialog) c_int;
    pub const getBodyUseMarkup = adw_message_dialog_get_body_use_markup;

    /// Gets the ID of the close response of `self`.
    extern fn adw_message_dialog_get_close_response(p_self: *MessageDialog) [*:0]const u8;
    pub const getCloseResponse = adw_message_dialog_get_close_response;

    /// Gets the ID of the default response of `self`.
    extern fn adw_message_dialog_get_default_response(p_self: *MessageDialog) ?[*:0]const u8;
    pub const getDefaultResponse = adw_message_dialog_get_default_response;

    /// Gets the child widget of `self`.
    extern fn adw_message_dialog_get_extra_child(p_self: *MessageDialog) ?*gtk.Widget;
    pub const getExtraChild = adw_message_dialog_get_extra_child;

    /// Gets the heading of `self`.
    extern fn adw_message_dialog_get_heading(p_self: *MessageDialog) ?[*:0]const u8;
    pub const getHeading = adw_message_dialog_get_heading;

    /// Gets whether the heading of `self` includes Pango markup.
    extern fn adw_message_dialog_get_heading_use_markup(p_self: *MessageDialog) c_int;
    pub const getHeadingUseMarkup = adw_message_dialog_get_heading_use_markup;

    /// Gets the appearance of `response`.
    ///
    /// See `MessageDialog.setResponseAppearance`.
    extern fn adw_message_dialog_get_response_appearance(p_self: *MessageDialog, p_response: [*:0]const u8) adw.ResponseAppearance;
    pub const getResponseAppearance = adw_message_dialog_get_response_appearance;

    /// Gets whether `response` is enabled.
    ///
    /// See `MessageDialog.setResponseEnabled`.
    extern fn adw_message_dialog_get_response_enabled(p_self: *MessageDialog, p_response: [*:0]const u8) c_int;
    pub const getResponseEnabled = adw_message_dialog_get_response_enabled;

    /// Gets the label of `response`.
    ///
    /// See `MessageDialog.setResponseLabel`.
    extern fn adw_message_dialog_get_response_label(p_self: *MessageDialog, p_response: [*:0]const u8) [*:0]const u8;
    pub const getResponseLabel = adw_message_dialog_get_response_label;

    /// Gets whether `self` has a response with the ID `response`.
    extern fn adw_message_dialog_has_response(p_self: *MessageDialog, p_response: [*:0]const u8) c_int;
    pub const hasResponse = adw_message_dialog_has_response;

    /// Removes a response from `self`.
    extern fn adw_message_dialog_remove_response(p_self: *MessageDialog, p_id: [*:0]const u8) void;
    pub const removeResponse = adw_message_dialog_remove_response;

    /// Emits the `MessageDialog.signals.response` signal with the given response ID.
    ///
    /// Used to indicate that the user has responded to the dialog in some way.
    extern fn adw_message_dialog_response(p_self: *MessageDialog, p_response: [*:0]const u8) void;
    pub const response = adw_message_dialog_response;

    /// Sets the body text of `self`.
    extern fn adw_message_dialog_set_body(p_self: *MessageDialog, p_body: [*:0]const u8) void;
    pub const setBody = adw_message_dialog_set_body;

    /// Sets whether the body text of `self` includes Pango markup.
    ///
    /// See `pango.parseMarkup`.
    extern fn adw_message_dialog_set_body_use_markup(p_self: *MessageDialog, p_use_markup: c_int) void;
    pub const setBodyUseMarkup = adw_message_dialog_set_body_use_markup;

    /// Sets the ID of the close response of `self`.
    ///
    /// It will be passed to `MessageDialog.signals.response` if the window is
    /// closed by pressing <kbd>Escape</kbd> or with a system action.
    ///
    /// It doesn't have to correspond to any of the responses in the dialog.
    ///
    /// The default close response is `close`.
    extern fn adw_message_dialog_set_close_response(p_self: *MessageDialog, p_response: [*:0]const u8) void;
    pub const setCloseResponse = adw_message_dialog_set_close_response;

    /// Sets the ID of the default response of `self`.
    ///
    /// If set, pressing <kbd>Enter</kbd> will activate the corresponding button.
    ///
    /// If set to `NULL` or to a non-existent response ID, pressing <kbd>Enter</kbd>
    /// will do nothing.
    extern fn adw_message_dialog_set_default_response(p_self: *MessageDialog, p_response: ?[*:0]const u8) void;
    pub const setDefaultResponse = adw_message_dialog_set_default_response;

    /// Sets the child widget of `self`.
    ///
    /// The child widget is displayed below the heading and body.
    extern fn adw_message_dialog_set_extra_child(p_self: *MessageDialog, p_child: ?*gtk.Widget) void;
    pub const setExtraChild = adw_message_dialog_set_extra_child;

    /// Sets the heading of `self`.
    extern fn adw_message_dialog_set_heading(p_self: *MessageDialog, p_heading: ?[*:0]const u8) void;
    pub const setHeading = adw_message_dialog_set_heading;

    /// Sets whether the heading of `self` includes Pango markup.
    ///
    /// See `pango.parseMarkup`.
    extern fn adw_message_dialog_set_heading_use_markup(p_self: *MessageDialog, p_use_markup: c_int) void;
    pub const setHeadingUseMarkup = adw_message_dialog_set_heading_use_markup;

    /// Sets the appearance for `response`.
    ///
    /// <picture>
    ///   <source srcset="message-dialog-appearance-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img src="message-dialog-appearance.png" alt="message-dialog-appearance">
    /// </picture>
    ///
    /// Use `ADW_RESPONSE_SUGGESTED` to mark important responses such as the
    /// affirmative action, like the Save button in the example.
    ///
    /// Use `ADW_RESPONSE_DESTRUCTIVE` to draw attention to the potentially damaging
    /// consequences of using `response`. This appearance acts as a warning to the
    /// user. The Discard button in the example is using this appearance.
    ///
    /// The default appearance is `ADW_RESPONSE_DEFAULT`.
    ///
    /// Negative responses like Cancel or Close should use the default appearance.
    extern fn adw_message_dialog_set_response_appearance(p_self: *MessageDialog, p_response: [*:0]const u8, p_appearance: adw.ResponseAppearance) void;
    pub const setResponseAppearance = adw_message_dialog_set_response_appearance;

    /// Sets whether `response` is enabled.
    ///
    /// If `response` is not enabled, the corresponding button will have
    /// `gtk.Widget.properties.sensitive` set to `FALSE` and it can't be activated as
    /// a default response.
    ///
    /// `response` can still be used as `MessageDialog.properties.close_response` while
    /// it's not enabled.
    ///
    /// Responses are enabled by default.
    extern fn adw_message_dialog_set_response_enabled(p_self: *MessageDialog, p_response: [*:0]const u8, p_enabled: c_int) void;
    pub const setResponseEnabled = adw_message_dialog_set_response_enabled;

    /// Sets the label of `response` to `label`.
    ///
    /// Labels are displayed on the dialog buttons. An embedded underline in `label`
    /// indicates a mnemonic.
    extern fn adw_message_dialog_set_response_label(p_self: *MessageDialog, p_response: [*:0]const u8, p_label: [*:0]const u8) void;
    pub const setResponseLabel = adw_message_dialog_set_response_label;

    extern fn adw_message_dialog_get_type() usize;
    pub const getGObjectType = adw_message_dialog_get_type;

    extern fn g_object_ref(p_self: *adw.MessageDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.MessageDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MessageDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget for switching between different layouts.
///
/// `AdwMultiLayoutView` contains layouts and children. Each child has
/// an ID, each layout has slots inside it, each slot also has an ID. When
/// switching layouts, children are inserted into slots with matching IDs. The
/// `gtk.Widget.properties.visible` property of each slot is updated to match
/// that of the inserted child.
///
/// This can be useful for rearranging children when it's difficult to do so
/// otherwise, for example to move a child from a sidebar to a bottom bar.
///
/// The currently used layout can be switched using the
/// `MultiLayoutView.properties.layout` or `MultiLayoutView.properties.layout_name`
/// properties. For example, it can be done via a `adw.Breakpoint` setter
/// to change layouts depending on the window size.
///
/// ## AdwMultiLayoutView as GtkBuildable
///
/// The `AdwMultiLayoutView` implementation of the `gtk.Buildable`
/// interface supports adding layouts via `<child>` element with the `type`
/// attribute omitted.
///
/// It also supports setting children via `<child type="ID">`.
///
/// Example of an `AdwMultiLayoutView` UI definition that can display a secondary
/// child as either a sidebar or a bottom sheet.
///
/// ```xml
/// <object class="AdwMultiLayoutView">
///   <child>
///     <object class="AdwLayout">
///       <property name="name">sidebar</property>
///       <property name="content">
///         <object class="AdwOverlaySplitView">
///           <property name="sidebar">
///             <object class="AdwLayoutSlot">
///               <property name="id">secondary</property>
///             </object>
///           </property>
///           <property name="content">
///             <object class="AdwLayoutSlot">
///               <property name="id">primary</property>
///             </object>
///           </property>
///         </object>
///       </property>
///     </object>
///   </child>
///   <child>
///     <object class="AdwLayout">
///       <property name="name">bottom-sheet</property>
///       <property name="content">
///         <object class="AdwBottomSheet">
///           <property name="open">True</property>
///           <property name="content">
///             <object class="AdwLayoutSlot">
///               <property name="id">primary</property>
///             </object>
///           </property>
///           <property name="sheet">
///             <object class="AdwLayoutSlot">
///               <property name="id">secondary</property>
///             </object>
///           </property>
///         </object>
///       </property>
///     </object>
///   </child>
///   <child type="primary">
///     <!-- ... -->
///   </child>
///   <child type="secondary">
///     <!-- ... -->
///   </child>
/// </object>
/// ```
///
/// ## CSS nodes
///
/// `AdwMultiLayoutView` has a single CSS node with name `multi-layout-view`.
pub const MultiLayoutView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.MultiLayoutViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently used layout.
        pub const layout = struct {
            pub const name = "layout";

            pub const Type = ?*adw.Layout;
        };

        /// The name of the currently used layout.
        ///
        /// See `Layout.properties.name`.
        pub const layout_name = struct {
            pub const name = "layout-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwMultiLayoutView`.
    extern fn adw_multi_layout_view_new() *adw.MultiLayoutView;
    pub const new = adw_multi_layout_view_new;

    /// Adds `layout` to `self`.
    extern fn adw_multi_layout_view_add_layout(p_self: *MultiLayoutView, p_layout: *adw.Layout) void;
    pub const addLayout = adw_multi_layout_view_add_layout;

    /// Gets the child for `id` to `self`.
    extern fn adw_multi_layout_view_get_child(p_self: *MultiLayoutView, p_id: [*:0]const u8) ?*gtk.Widget;
    pub const getChild = adw_multi_layout_view_get_child;

    /// Gets the currently used layout of `self`.
    extern fn adw_multi_layout_view_get_layout(p_self: *MultiLayoutView) ?*adw.Layout;
    pub const getLayout = adw_multi_layout_view_get_layout;

    /// Gets layout with the name `name` from `self`, or `NULL` if it doesn't exist.
    ///
    /// See `Layout.properties.name`.
    extern fn adw_multi_layout_view_get_layout_by_name(p_self: *MultiLayoutView, p_name: [*:0]const u8) ?*adw.Layout;
    pub const getLayoutByName = adw_multi_layout_view_get_layout_by_name;

    /// Returns the name of the currently used layout of `self`.
    extern fn adw_multi_layout_view_get_layout_name(p_self: *MultiLayoutView) ?[*:0]const u8;
    pub const getLayoutName = adw_multi_layout_view_get_layout_name;

    /// Removes `layout` from `self`.
    extern fn adw_multi_layout_view_remove_layout(p_self: *MultiLayoutView, p_layout: *adw.Layout) void;
    pub const removeLayout = adw_multi_layout_view_remove_layout;

    /// Sets `child` as the child for `id` in `self`.
    ///
    /// When changing layouts, it will be inserted into the slot with `id`.
    extern fn adw_multi_layout_view_set_child(p_self: *MultiLayoutView, p_id: [*:0]const u8, p_child: *gtk.Widget) void;
    pub const setChild = adw_multi_layout_view_set_child;

    /// Makes `layout` the current layout of `self`.
    extern fn adw_multi_layout_view_set_layout(p_self: *MultiLayoutView, p_layout: *adw.Layout) void;
    pub const setLayout = adw_multi_layout_view_set_layout;

    /// Makes the layout with `name` the current layout of `self`.
    ///
    /// See `Layout.properties.name`.
    extern fn adw_multi_layout_view_set_layout_name(p_self: *MultiLayoutView, p_name: [*:0]const u8) void;
    pub const setLayoutName = adw_multi_layout_view_set_layout_name;

    extern fn adw_multi_layout_view_get_type() usize;
    pub const getGObjectType = adw_multi_layout_view_get_type;

    extern fn g_object_ref(p_self: *adw.MultiLayoutView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.MultiLayoutView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MultiLayoutView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A page within `NavigationView` or `NavigationSplitView`.
///
/// Each page has a child widget, a title and optionally a tag.
///
/// The `NavigationPage.signals.showing`, `NavigationPage.signals.shown`,
/// `NavigationPage.signals.hiding` and `NavigationPage.signals.hidden` signals
/// can be used to track the page's visibility within its `AdwNavigationView`.
///
/// ## Header Bar Integration
///
/// When placed inside `AdwNavigationPage`, `HeaderBar` will display the
/// page title instead of window title.
///
/// When used together with `NavigationView`, it will also display a back
/// button that can be used to go back to the previous page. Set
/// `HeaderBar.properties.show_back_button` to `FALSE` to disable that behavior if
/// it's unwanted.
///
/// ## CSS Nodes
///
/// `AdwNavigationPage` has a single CSS node with name
/// `navigation-view-page`.
///
/// ## Accessibility
///
/// `AdwNavigationPage` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const NavigationPage = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.NavigationPageClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        /// Called when the navigation view transition has been completed and the page
        /// is fully hidden.
        pub const hidden = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(NavigationPage.Class, p_class).f_hidden.?(gobject.ext.as(NavigationPage, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(NavigationPage.Class, p_class).f_hidden = @ptrCast(p_implementation);
            }
        };

        /// Called when the page starts hiding at the beginning of the navigation view
        /// transition.
        pub const hiding = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(NavigationPage.Class, p_class).f_hiding.?(gobject.ext.as(NavigationPage, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(NavigationPage.Class, p_class).f_hiding = @ptrCast(p_implementation);
            }
        };

        /// Called when the page shows at the beginning of the navigation view
        /// transition.
        pub const showing = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(NavigationPage.Class, p_class).f_showing.?(gobject.ext.as(NavigationPage, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(NavigationPage.Class, p_class).f_showing = @ptrCast(p_implementation);
            }
        };

        /// Called when the navigation view transition has been completed and the page
        /// is fully shown.
        pub const shown = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(NavigationPage.Class, p_class).f_shown.?(gobject.ext.as(NavigationPage, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(NavigationPage.Class, p_class).f_shown = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Whether the page can be popped from navigation stack.
        ///
        /// Set it to `FALSE` to disable shortcuts and gestures, as well as remove the
        /// back button from `HeaderBar`.
        ///
        /// Manually calling `NavigationView.pop` or using the `navigation.pop`
        /// action will still work.
        ///
        /// See `HeaderBar.properties.show_back_button` for removing only the back
        /// button, but not shortcuts.
        pub const can_pop = struct {
            pub const name = "can-pop";

            pub const Type = c_int;
        };

        /// The child widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The page tag.
        ///
        /// The tag can be used to retrieve the page with
        /// `NavigationView.findPage`, as well as with
        /// `NavigationView.pushByTag`, `NavigationView.popToTag` or
        /// `NavigationView.replaceWithTags`.
        ///
        /// Tags must be unique within each `NavigationView`.
        ///
        /// The tag also must be set to use the `navigation.push` action.
        pub const tag = struct {
            pub const name = "tag";

            pub const Type = ?[*:0]u8;
        };

        /// The page title.
        ///
        /// It's displayed in `HeaderBar` instead of the window title, and used
        /// as the tooltip on the next page's back button, as well as by screen reader.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when the navigation view transition has been completed and the page
        /// is fully hidden.
        ///
        /// It will always be preceded by `NavigationPage.signals.hiding` or
        /// `NavigationPage.signals.showing`.
        pub const hidden = struct {
            pub const name = "hidden";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationPage, p_instance))),
                    gobject.signalLookup("hidden", NavigationPage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the page starts hiding at the beginning of the navigation view
        /// transition.
        ///
        /// It will always be followed by `NavigationPage.signals.hidden` or
        /// `NavigationPage.signals.shown`.
        pub const hiding = struct {
            pub const name = "hiding";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationPage, p_instance))),
                    gobject.signalLookup("hiding", NavigationPage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the page shows at the beginning of the navigation view
        /// transition.
        ///
        /// It will always be followed by `NavigationPage.signals.shown` or
        /// `NavigationPage.signals.hidden`.
        pub const showing = struct {
            pub const name = "showing";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationPage, p_instance))),
                    gobject.signalLookup("showing", NavigationPage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the navigation view transition has been completed and the page
        /// is fully shown.
        ///
        /// It will always be preceded by `NavigationPage.signals.showing` or
        /// `NavigationPage.signals.hiding`.
        pub const shown = struct {
            pub const name = "shown";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationPage, p_instance))),
                    gobject.signalLookup("shown", NavigationPage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwNavigationPage`.
    extern fn adw_navigation_page_new(p_child: *gtk.Widget, p_title: [*:0]const u8) *adw.NavigationPage;
    pub const new = adw_navigation_page_new;

    /// Creates a new `AdwNavigationPage` with provided tag.
    extern fn adw_navigation_page_new_with_tag(p_child: *gtk.Widget, p_title: [*:0]const u8, p_tag: [*:0]const u8) *adw.NavigationPage;
    pub const newWithTag = adw_navigation_page_new_with_tag;

    /// Gets whether `self` can be popped from navigation stack.
    extern fn adw_navigation_page_get_can_pop(p_self: *NavigationPage) c_int;
    pub const getCanPop = adw_navigation_page_get_can_pop;

    /// Gets the child widget of `self`.
    extern fn adw_navigation_page_get_child(p_self: *NavigationPage) ?*gtk.Widget;
    pub const getChild = adw_navigation_page_get_child;

    /// Gets the tag of `self`.
    extern fn adw_navigation_page_get_tag(p_self: *NavigationPage) ?[*:0]const u8;
    pub const getTag = adw_navigation_page_get_tag;

    /// Gets the title of `self`.
    extern fn adw_navigation_page_get_title(p_self: *NavigationPage) [*:0]const u8;
    pub const getTitle = adw_navigation_page_get_title;

    /// Sets whether `self` can be popped from navigation stack.
    ///
    /// Set it to `FALSE` to disable shortcuts and gestures, as well as remove the
    /// back button from `HeaderBar`.
    ///
    /// Manually calling `NavigationView.pop` or using the `navigation.pop`
    /// action will still work.
    ///
    /// See `HeaderBar.properties.show_back_button` for removing only the back button,
    /// but not shortcuts.
    extern fn adw_navigation_page_set_can_pop(p_self: *NavigationPage, p_can_pop: c_int) void;
    pub const setCanPop = adw_navigation_page_set_can_pop;

    /// Sets the child widget of `self`.
    extern fn adw_navigation_page_set_child(p_self: *NavigationPage, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_navigation_page_set_child;

    /// Sets the tag for `self`.
    ///
    /// The tag can be used to retrieve the page with
    /// `NavigationView.findPage`, as well as with
    /// `NavigationView.pushByTag`, `NavigationView.popToTag` or
    /// `NavigationView.replaceWithTags`.
    ///
    /// Tags must be unique within each `NavigationView`.
    ///
    /// The tag also must be set to use the `navigation.push` action.
    extern fn adw_navigation_page_set_tag(p_self: *NavigationPage, p_tag: ?[*:0]const u8) void;
    pub const setTag = adw_navigation_page_set_tag;

    /// Sets the title of `self`.
    ///
    /// It's displayed in `HeaderBar` instead of the window title, and used as
    /// the tooltip on the next page's back button, as well as by screen reader.
    extern fn adw_navigation_page_set_title(p_self: *NavigationPage, p_title: [*:0]const u8) void;
    pub const setTitle = adw_navigation_page_set_title;

    extern fn adw_navigation_page_get_type() usize;
    pub const getGObjectType = adw_navigation_page_get_type;

    extern fn g_object_ref(p_self: *adw.NavigationPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.NavigationPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NavigationPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget presenting sidebar and content side by side or as a navigation view.
///
/// <picture>
///   <source srcset="navigation-split-view-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="navigation-split-view.png" alt="navigation-split-view">
/// </picture>
/// <picture>
///   <source srcset="navigation-split-view-collapsed-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="navigation-split-view-collapsed.png" alt="navigation-split-view-collapsed">
/// </picture>
///
/// `AdwNavigationSplitView` has two `NavigationPage` children: sidebar and
/// content, and displays them side by side.
///
/// When `NavigationSplitView.properties.collapsed` is set to `TRUE`, it instead
/// puts both children inside an `NavigationView`. The
/// `NavigationSplitView.properties.show_content` controls which child is visible
/// while collapsed.
///
/// See also `OverlaySplitView`.
///
/// `AdwNavigationSplitView` is typically used together with an `Breakpoint`
/// setting the `collapsed` property to `TRUE` on small widths, as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <property name="width-request">280</property>
///   <property name="height-request">200</property>
///   <property name="default-width">800</property>
///   <property name="default-height">800</property>
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 400sp</condition>
///       <setter object="split_view" property="collapsed">True</setter>
///     </object>
///   </child>
///   <property name="content">
///     <object class="AdwNavigationSplitView" id="split_view">
///       <property name="sidebar">
///         <object class="AdwNavigationPage">
///           <property name="title" translatable="yes">Sidebar</property>
///           <property name="child">
///             <!-- ... -->
///           </property>
///         </object>
///       </property>
///       <property name="content">
///         <object class="AdwNavigationPage">
///           <property name="title" translatable="yes">Content</property>
///           <property name="child">
///             <!-- ... -->
///           </property>
///         </object>
///       </property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// ## Sizing
///
/// When not collapsed, `AdwNavigationSplitView` changes the sidebar width
/// depending on its own width.
///
/// If possible, it tries to allocate a fraction of the total width, controlled
/// with the `NavigationSplitView.properties.sidebar_width_fraction` property.
///
/// The sidebar also has minimum and maximum sizes, controlled with the
/// `NavigationSplitView.properties.min_sidebar_width` and
/// `NavigationSplitView.properties.max_sidebar_width` properties.
///
/// The minimum and maximum sizes are using the length unit specified with the
/// `NavigationSplitView.properties.sidebar_width_unit`.
///
/// By default, sidebar is using 25% of the total width, with 180sp as the
/// minimum size and 280sp as the maximum size.
///
/// ## Header Bar Integration
///
/// When used inside `AdwNavigationSplitView`, `HeaderBar` will
/// automatically hide the window buttons in the middle.
///
/// When collapsed, it also displays a back button for the content widget, as
/// well as the page titles. See `NavigationView` documentation for details.
///
/// ## Actions
///
/// `AdwNavigationSplitView` defines the same actions as `AdwNavigationView`, but
/// they can be used even when the split view is not collapsed:
///
/// - `navigation.push` takes a string parameter specifying the tag of the page
/// to push. If it matches the tag of the content widget, it sets
/// `NavigationSplitView.properties.show_content` to `TRUE`.
///
/// - `navigation.pop` doesn't take any parameters and sets
/// `NavigationSplitView.properties.show_content` to `FALSE`.
///
/// ## `AdwNavigationSplitView` as `GtkBuildable`
///
/// The `AdwNavigationSplitView` implementation of the `gtk.Buildable`
/// interface supports setting the sidebar widget by specifying “sidebar” as the
/// “type” attribute of a `<child>` element, Specifying “content” child type or
/// omitting it results in setting the content widget.
///
/// ## CSS nodes
///
/// `AdwNavigationSplitView` has a single CSS node with the name
/// `navigation-split-view`.
///
/// When collapsed, it contains a child node with the name `navigation-view`
/// containing both children.
///
/// ```
/// navigation-split-view
/// ╰── navigation-view
///     ├── [sidebar child]
///     ╰── [content child]
/// ```
///
/// When not collapsed, it contains two nodes with the name `widget`, one with
/// the `.sidebar-pane` style class, the other one with `.content-view` style
/// class, containing the sidebar and content children respectively.
///
/// ```
/// navigation-split-view
/// ├── widget.sidebar-pane
/// │   ╰── [sidebar child]
/// ╰── widget.content-pane
///     ╰── [content child]
/// ```
///
/// ## Accessibility
///
/// `AdwNavigationSplitView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const NavigationSplitView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.NavigationSplitViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the split view is collapsed.
        ///
        /// When collapsed, the children are put inside an `NavigationView`,
        /// otherwise they are displayed side by side.
        ///
        /// The `NavigationSplitView.properties.show_content` controls which child is
        /// visible while collapsed.
        pub const collapsed = struct {
            pub const name = "collapsed";

            pub const Type = c_int;
        };

        /// The content widget.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*adw.NavigationPage;
        };

        /// The maximum sidebar width.
        ///
        /// Maximum width is affected by
        /// `NavigationSplitView.properties.sidebar_width_unit`.
        ///
        /// The sidebar widget can still be allocated with larger width if its own
        /// minimum width exceeds it.
        pub const max_sidebar_width = struct {
            pub const name = "max-sidebar-width";

            pub const Type = f64;
        };

        /// The minimum sidebar width.
        ///
        /// Minimum width is affected by
        /// `NavigationSplitView.properties.sidebar_width_unit`.
        ///
        /// The sidebar widget can still be allocated with larger width if its own
        /// minimum width exceeds it.
        pub const min_sidebar_width = struct {
            pub const name = "min-sidebar-width";

            pub const Type = f64;
        };

        /// Determines the visible page when collapsed.
        ///
        /// If set to `TRUE`, the content widget will be the visible page when
        /// `NavigationSplitView.properties.collapsed` is `TRUE`; otherwise the sidebar
        /// widget will be visible.
        ///
        /// If the split view is already collapsed, the visible page changes
        /// immediately.
        pub const show_content = struct {
            pub const name = "show-content";

            pub const Type = c_int;
        };

        /// The sidebar widget.
        pub const sidebar = struct {
            pub const name = "sidebar";

            pub const Type = ?*adw.NavigationPage;
        };

        /// The sidebar position.
        ///
        /// If set to `GTK_PACK_START`, the sidebar is displayed before the content,
        /// and the sidebar will be the root page when collapsed.
        ///
        /// If set to `GTK_PACK_END`, the sidebar is displayed after the content,
        /// and the content will be the root page.
        pub const sidebar_position = struct {
            pub const name = "sidebar-position";

            pub const Type = gtk.PackType;
        };

        /// The preferred sidebar width as a fraction of the total width.
        ///
        /// The preferred width is additionally limited by
        /// `NavigationSplitView.properties.min_sidebar_width` and
        /// `NavigationSplitView.properties.max_sidebar_width`.
        ///
        /// The sidebar widget can be allocated with larger width if its own minimum
        /// width exceeds the preferred width.
        pub const sidebar_width_fraction = struct {
            pub const name = "sidebar-width-fraction";

            pub const Type = f64;
        };

        /// The length unit for minimum and maximum sidebar widths.
        ///
        /// See `NavigationSplitView.properties.min_sidebar_width` and
        /// `NavigationSplitView.properties.max_sidebar_width`.
        pub const sidebar_width_unit = struct {
            pub const name = "sidebar-width-unit";

            pub const Type = adw.LengthUnit;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwNavigationSplitView`.
    extern fn adw_navigation_split_view_new() *adw.NavigationSplitView;
    pub const new = adw_navigation_split_view_new;

    /// Gets whether `self` is collapsed.
    extern fn adw_navigation_split_view_get_collapsed(p_self: *NavigationSplitView) c_int;
    pub const getCollapsed = adw_navigation_split_view_get_collapsed;

    /// Sets the content widget for `self`.
    extern fn adw_navigation_split_view_get_content(p_self: *NavigationSplitView) ?*adw.NavigationPage;
    pub const getContent = adw_navigation_split_view_get_content;

    /// Gets the maximum sidebar width for `self`.
    extern fn adw_navigation_split_view_get_max_sidebar_width(p_self: *NavigationSplitView) f64;
    pub const getMaxSidebarWidth = adw_navigation_split_view_get_max_sidebar_width;

    /// Gets the minimum sidebar width for `self`.
    extern fn adw_navigation_split_view_get_min_sidebar_width(p_self: *NavigationSplitView) f64;
    pub const getMinSidebarWidth = adw_navigation_split_view_get_min_sidebar_width;

    /// Gets which page is visible when `self` is collapsed.
    extern fn adw_navigation_split_view_get_show_content(p_self: *NavigationSplitView) c_int;
    pub const getShowContent = adw_navigation_split_view_get_show_content;

    /// Gets the sidebar widget for `self`.
    extern fn adw_navigation_split_view_get_sidebar(p_self: *NavigationSplitView) ?*adw.NavigationPage;
    pub const getSidebar = adw_navigation_split_view_get_sidebar;

    /// Gets the sidebar position for `self`.
    extern fn adw_navigation_split_view_get_sidebar_position(p_self: *NavigationSplitView) gtk.PackType;
    pub const getSidebarPosition = adw_navigation_split_view_get_sidebar_position;

    /// Gets the preferred sidebar width fraction for `self`.
    extern fn adw_navigation_split_view_get_sidebar_width_fraction(p_self: *NavigationSplitView) f64;
    pub const getSidebarWidthFraction = adw_navigation_split_view_get_sidebar_width_fraction;

    /// Gets the length unit for minimum and maximum sidebar widths.
    extern fn adw_navigation_split_view_get_sidebar_width_unit(p_self: *NavigationSplitView) adw.LengthUnit;
    pub const getSidebarWidthUnit = adw_navigation_split_view_get_sidebar_width_unit;

    /// Sets whether `self` is collapsed.
    ///
    /// When collapsed, the children are put inside an `NavigationView`,
    /// otherwise they are displayed side by side.
    ///
    /// The `NavigationSplitView.properties.show_content` controls which child is
    /// visible while collapsed.
    extern fn adw_navigation_split_view_set_collapsed(p_self: *NavigationSplitView, p_collapsed: c_int) void;
    pub const setCollapsed = adw_navigation_split_view_set_collapsed;

    /// Sets the content widget for `self`.
    extern fn adw_navigation_split_view_set_content(p_self: *NavigationSplitView, p_content: ?*adw.NavigationPage) void;
    pub const setContent = adw_navigation_split_view_set_content;

    /// Sets the maximum sidebar width for `self`.
    ///
    /// Maximum width is affected by
    /// `NavigationSplitView.properties.sidebar_width_unit`.
    ///
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    extern fn adw_navigation_split_view_set_max_sidebar_width(p_self: *NavigationSplitView, p_width: f64) void;
    pub const setMaxSidebarWidth = adw_navigation_split_view_set_max_sidebar_width;

    /// Sets the minimum sidebar width for `self`.
    ///
    /// Minimum width is affected by
    /// `NavigationSplitView.properties.sidebar_width_unit`.
    ///
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    extern fn adw_navigation_split_view_set_min_sidebar_width(p_self: *NavigationSplitView, p_width: f64) void;
    pub const setMinSidebarWidth = adw_navigation_split_view_set_min_sidebar_width;

    /// Sets which page is visible when `self` is collapsed.
    ///
    /// If set to `TRUE`, the content widget will be the visible page when
    /// `NavigationSplitView.properties.collapsed` is `TRUE`; otherwise the sidebar
    /// widget will be visible.
    ///
    /// If the split view is already collapsed, the visible page changes immediately.
    extern fn adw_navigation_split_view_set_show_content(p_self: *NavigationSplitView, p_show_content: c_int) void;
    pub const setShowContent = adw_navigation_split_view_set_show_content;

    /// Sets the sidebar widget for `self`.
    extern fn adw_navigation_split_view_set_sidebar(p_self: *NavigationSplitView, p_sidebar: ?*adw.NavigationPage) void;
    pub const setSidebar = adw_navigation_split_view_set_sidebar;

    /// Sets the sidebar position for `self`.
    ///
    /// If set to `GTK_PACK_START`, the sidebar is displayed before the content,
    /// and the sidebar will be the root page when collapsed.
    ///
    /// If set to `GTK_PACK_END`, the sidebar is displayed after the content,
    /// and the content will be the root page.
    extern fn adw_navigation_split_view_set_sidebar_position(p_self: *NavigationSplitView, p_position: gtk.PackType) void;
    pub const setSidebarPosition = adw_navigation_split_view_set_sidebar_position;

    /// Sets the preferred sidebar width as a fraction of the total width of `self`.
    ///
    /// The preferred width is additionally limited by
    /// `NavigationSplitView.properties.min_sidebar_width` and
    /// `NavigationSplitView.properties.max_sidebar_width`.
    ///
    /// The sidebar widget can be allocated with larger width if its own minimum
    /// width exceeds the preferred width.
    extern fn adw_navigation_split_view_set_sidebar_width_fraction(p_self: *NavigationSplitView, p_fraction: f64) void;
    pub const setSidebarWidthFraction = adw_navigation_split_view_set_sidebar_width_fraction;

    /// Sets the length unit for minimum and maximum sidebar widths.
    ///
    /// See `NavigationSplitView.properties.min_sidebar_width` and
    /// `NavigationSplitView.properties.max_sidebar_width`.
    extern fn adw_navigation_split_view_set_sidebar_width_unit(p_self: *NavigationSplitView, p_unit: adw.LengthUnit) void;
    pub const setSidebarWidthUnit = adw_navigation_split_view_set_sidebar_width_unit;

    extern fn adw_navigation_split_view_get_type() usize;
    pub const getGObjectType = adw_navigation_split_view_get_type;

    extern fn g_object_ref(p_self: *adw.NavigationSplitView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.NavigationSplitView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NavigationSplitView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A page-based navigation container.
///
/// <picture>
///   <source srcset="navigation-view-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="navigation-view.png" alt="navigation-view">
/// </picture>
///
/// `AdwNavigationView` presents one child at a time, similar to
/// `gtk.Stack`.
///
/// `AdwNavigationView` can only contain `NavigationPage` children.
///
/// It maintains a navigation stack that can be controlled with
/// `NavigationView.push` and `NavigationView.pop`. The whole
/// navigation stack can also be replaced using `NavigationView.replace`.
///
/// `AdwNavigationView` allows to manage pages statically or dynamically.
///
/// Static pages can be added using the `NavigationView.add` method. The
/// `AdwNavigationView` will keep a reference to these pages, but they aren't
/// accessible to the user until `NavigationView.push` is called (except
/// for the first page, which is pushed automatically). Use the
/// `NavigationView.remove` method to remove them. This is useful for
/// applications that have a small number of unique pages and just need
/// navigation between them.
///
/// Dynamic pages are automatically destroyed once they are popped off the
/// navigation stack. To add a page like this, push it using the
/// `NavigationView.push` method without calling
/// `NavigationView.add` first.
///
/// ## Tags
///
/// Static pages, as well as any pages in the navigation stack, can be accessed
/// by their `NavigationPage.properties.tag`. For example,
/// `NavigationView.pushByTag` can be used to push a static page that's
/// not in the navigation stack without having to keep a reference to it manually.
///
/// ## Header Bar Integration
///
/// When used inside `AdwNavigationView`, `HeaderBar` will automatically
/// display a back button that can be used to go back to the previous page when
/// possible. The button also has a context menu, allowing to pop multiple pages
/// at once, potentially across multiple navigation views.
///
/// Set `HeaderBar.properties.show_back_button` to `FALSE` to disable this behavior
/// in rare scenarios where it's unwanted.
///
/// `AdwHeaderBar` will also display the title of the `AdwNavigationPage` it's
/// placed into, so most applications shouldn't need to customize it at all.
///
/// ## Shortcuts and Gestures
///
/// `AdwNavigationView` supports the following shortcuts for going to the
/// previous page:
///
/// - <kbd>Escape</kbd> (unless `NavigationView.properties.pop_on_escape` is set to
///   `FALSE`)
/// - <kbd>Alt</kbd>+<kbd>←</kbd>
/// - Back mouse button
///
/// Additionally, it supports interactive gestures:
///
/// - One-finger swipe towards the right on touchscreens
/// - Scrolling towards the right on touchpads (usually two-finger swipe)
///
/// These gestures have transitions enabled regardless of the
/// `NavigationView.properties.animate_transitions` value.
///
/// Applications can also enable shortcuts for pushing another page onto the
/// navigation stack via connecting to the `NavigationView.signals.get_next_page`
/// signal, in that case the following shortcuts are supported:
///
/// - <kbd>Alt</kbd>+<kbd>→</kbd>
/// - Forward mouse button
/// - Swipe/scrolling towards the left
///
/// For right-to-left locales, the gestures and shortcuts are reversed.
///
/// `NavigationPage.properties.can_pop` can be used to disable them, along with the
/// header bar back buttons.
///
/// ## Actions
///
/// `AdwNavigationView` defines actions for controlling the navigation stack.
/// actions for controlling the navigation stack:
///
/// - `navigation.push` takes a string parameter specifying the tag of the page to
/// push, and is equivalent to calling `NavigationView.pushByTag`.
///
/// - `navigation.pop` doesn't take any parameters and pops the current page from
/// the navigation stack, equivalent to calling `NavigationView.pop`.
///
/// ## `AdwNavigationView` as `GtkBuildable`
///
/// `AdwNavigationView` allows to add pages as children, equivalent to using the
/// `NavigationView.add` method.
///
/// Example of an `AdwNavigationView` UI definition:
///
/// ```xml
/// <object class="AdwNavigationView">
///   <child>
///     <object class="AdwNavigationPage">
///       <property name="title" translatable="yes">Page 1</property>
///       <property name="child">
///         <object class="AdwToolbarView">
///           <child type="top">
///             <object class="AdwHeaderBar"/>
///           </child>
///           <property name="content">
///             <object class="GtkButton">
///               <property name="label" translatable="yes">Open Page 2</property>
///               <property name="halign">center</property>
///               <property name="valign">center</property>
///               <property name="action-name">navigation.push</property>
///               <property name="action-target">'page-2'</property>
///               <style>
///                 <class name="pill"/>
///                </style>
///             </object>
///           </property>
///         </object>
///       </property>
///     </object>
///   </child>
///   <child>
///     <object class="AdwNavigationPage">
///       <property name="title" translatable="yes">Page 2</property>
///       <property name="tag">page-2</property>
///       <property name="child">
///         <object class="AdwToolbarView">
///           <child type="top">
///             <object class="AdwHeaderBar"/>
///           </child>
///           <property name="content">
///             <!-- ... -->
///           </property>
///         </object>
///       </property>
///     </object>
///   </child>
/// </object>
/// ```
///
/// <picture>
///   <source srcset="navigation-view-example-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="navigation-view-example.png" alt="navigation-view-example">
/// </picture>
///
/// ## CSS nodes
///
/// `AdwNavigationView` has a single CSS node with the name `navigation-view`.
///
/// ## Accessibility
///
/// `AdwNavigationView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const NavigationView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.NavigationViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to animate page transitions.
        ///
        /// Gesture-based transitions are always animated.
        pub const animate_transitions = struct {
            pub const name = "animate-transitions";

            pub const Type = c_int;
        };

        /// Whether the view is horizontally homogeneous.
        ///
        /// If the view is horizontally homogeneous, it allocates the same width for
        /// all pages.
        ///
        /// If it's not, the page may change width when a different page becomes
        /// visible.
        pub const hhomogeneous = struct {
            pub const name = "hhomogeneous";

            pub const Type = c_int;
        };

        /// A list model that contains the pages in navigation stack.
        ///
        /// The pages are sorted from root page to visible page.
        ///
        /// This can be used to keep an up-to-date view.
        pub const navigation_stack = struct {
            pub const name = "navigation-stack";

            pub const Type = ?*gio.ListModel;
        };

        /// Whether pressing Escape pops the current page.
        ///
        /// Applications using `AdwNavigationView` to implement a browser may want to
        /// disable it.
        pub const pop_on_escape = struct {
            pub const name = "pop-on-escape";

            pub const Type = c_int;
        };

        /// Whether the view is vertically homogeneous.
        ///
        /// If the view is vertically homogeneous, it allocates the same height for
        /// all pages.
        ///
        /// If it's not, the view may change height when a different page becomes
        /// visible.
        pub const vhomogeneous = struct {
            pub const name = "vhomogeneous";

            pub const Type = c_int;
        };

        /// The currently visible page.
        pub const visible_page = struct {
            pub const name = "visible-page";

            pub const Type = ?*adw.NavigationPage;
        };

        /// The tag of the currently visible page.
        pub const visible_page_tag = struct {
            pub const name = "visible-page-tag";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a push shortcut or a gesture is triggered.
        ///
        /// To support the push shortcuts and gestures, the application is expected to
        /// return the page to push in the handler.
        ///
        /// This signal can be emitted multiple times for the gestures, for example
        /// when the gesture is cancelled by the user. As such, the application must
        /// not make any irreversible changes in the handler, such as removing the page
        /// from a forward stack.
        ///
        /// Instead, it should be done in the `NavigationView.signals.pushed` handler.
        pub const get_next_page = struct {
            pub const name = "get-next-page";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) ?*adw.NavigationPage, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationView, p_instance))),
                    gobject.signalLookup("get-next-page", NavigationView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after `page` has been popped from the navigation stack.
        ///
        /// See `NavigationView.pop`.
        ///
        /// When using `NavigationView.popToPage` or
        /// `NavigationView.popToTag`, this signal is emitted for each of the
        /// popped pages.
        pub const popped = struct {
            pub const name = "popped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.NavigationPage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationView, p_instance))),
                    gobject.signalLookup("popped", NavigationView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after a page has been pushed to the navigation stack.
        ///
        /// See `NavigationView.push`.
        pub const pushed = struct {
            pub const name = "pushed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationView, p_instance))),
                    gobject.signalLookup("pushed", NavigationView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after the navigation stack has been replaced.
        ///
        /// See `NavigationView.replace`.
        pub const replaced = struct {
            pub const name = "replaced";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NavigationView, p_instance))),
                    gobject.signalLookup("replaced", NavigationView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwNavigationView`.
    extern fn adw_navigation_view_new() *adw.NavigationView;
    pub const new = adw_navigation_view_new;

    /// Permanently adds `page` to `self`.
    ///
    /// Any page that has been added will stay in `self` even after being popped from
    /// the navigation stack.
    ///
    /// Adding a page while no page is visible will automatically push it to the
    /// navigation stack.
    ///
    /// See `NavigationView.remove`.
    extern fn adw_navigation_view_add(p_self: *NavigationView, p_page: *adw.NavigationPage) void;
    pub const add = adw_navigation_view_add;

    /// Finds a page in `self` by its tag.
    ///
    /// See `NavigationPage.properties.tag`.
    extern fn adw_navigation_view_find_page(p_self: *NavigationView, p_tag: [*:0]const u8) ?*adw.NavigationPage;
    pub const findPage = adw_navigation_view_find_page;

    /// Gets whether `self` animates page transitions.
    extern fn adw_navigation_view_get_animate_transitions(p_self: *NavigationView) c_int;
    pub const getAnimateTransitions = adw_navigation_view_get_animate_transitions;

    /// Gets whether `self` is horizontally homogeneous.
    extern fn adw_navigation_view_get_hhomogeneous(p_self: *NavigationView) c_int;
    pub const getHhomogeneous = adw_navigation_view_get_hhomogeneous;

    /// Returns a `gio.ListModel` that contains the pages in navigation stack.
    ///
    /// The pages are sorted from root page to visible page.
    ///
    /// This can be used to keep an up-to-date view.
    extern fn adw_navigation_view_get_navigation_stack(p_self: *NavigationView) *gio.ListModel;
    pub const getNavigationStack = adw_navigation_view_get_navigation_stack;

    /// Gets whether pressing Escape pops the current page on `self`.
    extern fn adw_navigation_view_get_pop_on_escape(p_self: *NavigationView) c_int;
    pub const getPopOnEscape = adw_navigation_view_get_pop_on_escape;

    /// Gets the previous page for `page`.
    ///
    /// If `page` is in the navigation stack, returns the page popping `page` will
    /// reveal.
    ///
    /// If `page` is the root page or is not in the navigation stack, returns `NULL`.
    extern fn adw_navigation_view_get_previous_page(p_self: *NavigationView, p_page: *adw.NavigationPage) ?*adw.NavigationPage;
    pub const getPreviousPage = adw_navigation_view_get_previous_page;

    /// Gets whether `self` is vertically homogeneous.
    extern fn adw_navigation_view_get_vhomogeneous(p_self: *NavigationView) c_int;
    pub const getVhomogeneous = adw_navigation_view_get_vhomogeneous;

    /// Gets the currently visible page in `self`.
    extern fn adw_navigation_view_get_visible_page(p_self: *NavigationView) ?*adw.NavigationPage;
    pub const getVisiblePage = adw_navigation_view_get_visible_page;

    /// Gets the tag of the currently visible page in `self`.
    extern fn adw_navigation_view_get_visible_page_tag(p_self: *NavigationView) ?[*:0]const u8;
    pub const getVisiblePageTag = adw_navigation_view_get_visible_page_tag;

    /// Pops the visible page from the navigation stack.
    ///
    /// Does nothing if the navigation stack contains less than two pages.
    ///
    /// If `NavigationView.add` hasn't been called, the page is automatically
    /// removed.
    ///
    /// `NavigationView.signals.popped` will be emitted for the current visible page.
    ///
    /// See `NavigationView.popToPage` and
    /// `NavigationView.popToTag`.
    extern fn adw_navigation_view_pop(p_self: *NavigationView) c_int;
    pub const pop = adw_navigation_view_pop;

    /// Pops pages from the navigation stack until `page` is visible.
    ///
    /// `page` must be in the navigation stack.
    ///
    /// If `NavigationView.add` hasn't been called for any of the popped pages,
    /// they are automatically removed.
    ///
    /// `NavigationView.signals.popped` will be be emitted for each of the popped
    /// pages.
    ///
    /// See `NavigationView.pop` and `NavigationView.popToTag`.
    extern fn adw_navigation_view_pop_to_page(p_self: *NavigationView, p_page: *adw.NavigationPage) c_int;
    pub const popToPage = adw_navigation_view_pop_to_page;

    /// Pops pages from the navigation stack until page with the tag `tag` is visible.
    ///
    /// The page must be in the navigation stack.
    ///
    /// If `NavigationView.add` hasn't been called for any of the popped pages,
    /// they are automatically removed.
    ///
    /// `NavigationView.signals.popped` will be emitted for each of the popped pages.
    ///
    /// See `NavigationView.popToPage` and `NavigationPage.properties.tag`.
    extern fn adw_navigation_view_pop_to_tag(p_self: *NavigationView, p_tag: [*:0]const u8) c_int;
    pub const popToTag = adw_navigation_view_pop_to_tag;

    /// Pushes `page` onto the navigation stack.
    ///
    /// If `NavigationView.add` hasn't been called, the page is automatically
    /// removed once it's popped.
    ///
    /// `NavigationView.signals.pushed` will be emitted for `page`.
    ///
    /// See `NavigationView.pushByTag`.
    extern fn adw_navigation_view_push(p_self: *NavigationView, p_page: *adw.NavigationPage) void;
    pub const push = adw_navigation_view_push;

    /// Pushes the page with the tag `tag` onto the navigation stack.
    ///
    /// If `NavigationView.add` hasn't been called, the page is automatically
    /// removed once it's popped.
    ///
    /// `NavigationView.signals.pushed` will be emitted for the page.
    ///
    /// See `NavigationView.push` and `NavigationPage.properties.tag`.
    extern fn adw_navigation_view_push_by_tag(p_self: *NavigationView, p_tag: [*:0]const u8) void;
    pub const pushByTag = adw_navigation_view_push_by_tag;

    /// Removes `page` from `self`.
    ///
    /// If `page` is currently in the navigation stack, it will be removed once it's
    /// popped. Otherwise, it's removed immediately.
    ///
    /// See `NavigationView.add`.
    extern fn adw_navigation_view_remove(p_self: *NavigationView, p_page: *adw.NavigationPage) void;
    pub const remove = adw_navigation_view_remove;

    /// Replaces the current navigation stack with `pages`.
    ///
    /// The last page becomes the visible page.
    ///
    /// Replacing the navigation stack has no animation.
    ///
    /// If `NavigationView.add` hasn't been called for any pages that are no
    /// longer in the navigation stack, they are automatically removed.
    ///
    /// `n_pages` can be 0, in that case no page will be visible after calling this
    /// method. This can be useful for removing all pages from `self`.
    ///
    /// The `NavigationView.signals.replaced` signal will be emitted.
    ///
    /// See `NavigationView.replaceWithTags`.
    extern fn adw_navigation_view_replace(p_self: *NavigationView, p_pages: [*]*adw.NavigationPage, p_n_pages: c_int) void;
    pub const replace = adw_navigation_view_replace;

    /// Replaces the current navigation stack with pages with the tags `tags`.
    ///
    /// The last page becomes the visible page.
    ///
    /// Replacing the navigation stack has no animation.
    ///
    /// If `NavigationView.add` hasn't been called for any pages that are no
    /// longer in the navigation stack, they are automatically removed.
    ///
    /// `n_tags` can be 0, in that case no page will be visible after calling this
    /// method. This can be useful for removing all pages from `self`.
    ///
    /// The `NavigationView.signals.replaced` signal will be emitted.
    ///
    /// See `NavigationView.replace` and `NavigationPage.properties.tag`.
    extern fn adw_navigation_view_replace_with_tags(p_self: *NavigationView, p_tags: [*]const [*:0]const u8, p_n_tags: c_int) void;
    pub const replaceWithTags = adw_navigation_view_replace_with_tags;

    /// Sets whether `self` should animate page transitions.
    ///
    /// Gesture-based transitions are always animated.
    extern fn adw_navigation_view_set_animate_transitions(p_self: *NavigationView, p_animate_transitions: c_int) void;
    pub const setAnimateTransitions = adw_navigation_view_set_animate_transitions;

    /// Sets `self` to be horizontally homogeneous or not.
    ///
    /// If the view is horizontally homogeneous, it allocates the same width for
    /// all pages.
    ///
    /// If it's not, the view may change width when a different page becomes visible.
    extern fn adw_navigation_view_set_hhomogeneous(p_self: *NavigationView, p_hhomogeneous: c_int) void;
    pub const setHhomogeneous = adw_navigation_view_set_hhomogeneous;

    /// Sets whether pressing Escape pops the current page on `self`.
    ///
    /// Applications using `AdwNavigationView` to implement a browser may want to
    /// disable it.
    extern fn adw_navigation_view_set_pop_on_escape(p_self: *NavigationView, p_pop_on_escape: c_int) void;
    pub const setPopOnEscape = adw_navigation_view_set_pop_on_escape;

    /// Sets `self` to be vertically homogeneous or not.
    ///
    /// If the view is vertically homogeneous, it allocates the same height for
    /// all pages.
    ///
    /// If it's not, the view may change height when a different page becomes
    /// visible.
    extern fn adw_navigation_view_set_vhomogeneous(p_self: *NavigationView, p_vhomogeneous: c_int) void;
    pub const setVhomogeneous = adw_navigation_view_set_vhomogeneous;

    extern fn adw_navigation_view_get_type() usize;
    pub const getGObjectType = adw_navigation_view_get_type;

    extern fn g_object_ref(p_self: *adw.NavigationView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.NavigationView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NavigationView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget presenting sidebar and content side by side or as an overlay.
///
/// <picture>
///   <source srcset="overlay-split-view-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="overlay-split-view.png" alt="overlay-split-view">
/// </picture>
/// <picture>
///   <source srcset="overlay-split-view-collapsed-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="overlay-split-view-collapsed.png" alt="overlay-split-view-collapsed">
/// </picture>
///
/// `AdwOverlaySplitView` has two children: sidebar and content, and displays
/// them side by side.
///
/// When `OverlaySplitView.properties.collapsed` is set to `TRUE`, the sidebar is
/// instead shown as an overlay above the content widget.
///
/// The sidebar can be hidden or shown using the
/// `OverlaySplitView.properties.show_sidebar` property.
///
/// Sidebar can be displayed before or after the content, this can be controlled
/// with the `OverlaySplitView.properties.sidebar_position` property.
///
/// Collapsing the split view automatically hides the sidebar widget, and
/// uncollapsing it shows the sidebar. If this behavior is not desired, the
/// `OverlaySplitView.properties.pin_sidebar` property can be used to override it.
///
/// `AdwOverlaySplitView` supports an edge swipe gesture for showing the sidebar,
/// and a swipe from the sidebar for hiding it. Gestures are only supported on
/// touchscreen, but not touchpad. Gestures can be controlled with the
/// `OverlaySplitView.properties.enable_show_gesture` and
/// `OverlaySplitView.properties.enable_hide_gesture` properties.
///
/// See also `NavigationSplitView`.
///
/// `AdwOverlaySplitView` is typically used together with an `Breakpoint`
/// setting the `collapsed` property to `TRUE` on small widths, as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <property name="default-width">800</property>
///   <property name="default-height">800</property>
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 400sp</condition>
///       <setter object="split_view" property="collapsed">True</setter>
///     </object>
///   </child>
///   <property name="content">
///     <object class="AdwOverlaySplitView" id="split_view">
///       <property name="sidebar">
///         <!-- ... -->
///       </property>
///       <property name="content">
///         <!-- ... -->
///       </property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// `AdwOverlaySplitView` is often used for implementing the
/// [utility pane](https://developer.gnome.org/hig/patterns/containers/utility-panes.html)
/// pattern.
///
/// ## Sizing
///
/// When not collapsed, `AdwOverlaySplitView` changes the sidebar width
/// depending on its own width.
///
/// If possible, it tries to allocate a fraction of the total width, controlled
/// with the `OverlaySplitView.properties.sidebar_width_fraction` property.
///
/// The sidebar also has minimum and maximum sizes, controlled with the
/// `OverlaySplitView.properties.min_sidebar_width` and
/// `OverlaySplitView.properties.max_sidebar_width` properties.
///
/// The minimum and maximum sizes are using the length unit specified with the
/// `OverlaySplitView.properties.sidebar_width_unit`.
///
/// By default, sidebar is using 25% of the total width, with 180sp as the
/// minimum size and 280sp as the maximum size.
///
/// When collapsed, the preferred width fraction is ignored and the sidebar uses
/// `OverlaySplitView.properties.max_sidebar_width` when possible.
///
/// ## Header Bar Integration
///
/// When used inside `AdwOverlaySplitView`, `HeaderBar` will automatically
/// hide the window buttons in the middle.
///
/// ## `AdwOverlaySplitView` as `GtkBuildable`
///
/// The `AdwOverlaySplitView` implementation of the `gtk.Buildable`
/// interface supports setting the sidebar widget by specifying “sidebar” as the
/// “type” attribute of a `<child>` element, Specifying “content” child type or
/// omitting it results in setting the content widget.
///
/// ## CSS nodes
///
/// `AdwOverlaySplitView` has a single CSS node with the name
/// `overlay-split-view`.
///
/// It contains two nodes with the name `widget`, containing the sidebar and
/// content children.
///
/// When not collapsed, they have the `.sidebar-view` and `.content-view` style
/// classes respectively.
///
/// ```
/// overlay-split-view
/// ├── widget.sidebar-pane
/// │   ╰── [sidebar child]
/// ╰── widget.content-pane
///     ╰── [content child]
/// ```
///
/// When collapsed, the one containing the sidebar child has the `.background`
/// style class and the other one has no style classes.
///
/// ```
/// overlay-split-view
/// ├── widget.background
/// │   ╰── [sidebar child]
/// ╰── widget
///     ╰── [content child]
/// ```
///
/// ## Accessibility
///
/// `AdwOverlaySplitView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const OverlaySplitView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ adw.Swipeable, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.OverlaySplitViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the split view is collapsed.
        ///
        /// When collapsed, the sidebar widget is presented as an overlay above the
        /// content widget, otherwise they are displayed side by side.
        pub const collapsed = struct {
            pub const name = "collapsed";

            pub const Type = c_int;
        };

        /// The content widget.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the sidebar can be closed with a swipe gesture.
        ///
        /// Only touchscreen swipes are supported.
        pub const enable_hide_gesture = struct {
            pub const name = "enable-hide-gesture";

            pub const Type = c_int;
        };

        /// Whether the sidebar can be opened with an edge swipe gesture.
        ///
        /// Only touchscreen swipes are supported.
        pub const enable_show_gesture = struct {
            pub const name = "enable-show-gesture";

            pub const Type = c_int;
        };

        /// The maximum sidebar width.
        ///
        /// Maximum width is affected by
        /// `OverlaySplitView.properties.sidebar_width_unit`.
        ///
        /// The sidebar widget can still be allocated with larger width if its own
        /// minimum width exceeds it.
        pub const max_sidebar_width = struct {
            pub const name = "max-sidebar-width";

            pub const Type = f64;
        };

        /// The minimum sidebar width.
        ///
        /// Minimum width is affected by
        /// `OverlaySplitView.properties.sidebar_width_unit`.
        ///
        /// The sidebar widget can still be allocated with larger width if its own
        /// minimum width exceeds it.
        pub const min_sidebar_width = struct {
            pub const name = "min-sidebar-width";

            pub const Type = f64;
        };

        /// Whether the sidebar widget is pinned.
        ///
        /// By default, collapsing `self` automatically hides the sidebar widget, and
        /// uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility
        /// never changes on its own.
        pub const pin_sidebar = struct {
            pub const name = "pin-sidebar";

            pub const Type = c_int;
        };

        /// Whether the sidebar widget is shown.
        pub const show_sidebar = struct {
            pub const name = "show-sidebar";

            pub const Type = c_int;
        };

        /// The sidebar widget.
        pub const sidebar = struct {
            pub const name = "sidebar";

            pub const Type = ?*gtk.Widget;
        };

        /// The sidebar position.
        ///
        /// If it's set to `GTK_PACK_START`, the sidebar is displayed before the content,
        /// if `GTK_PACK_END`, it's displayed after the content.
        pub const sidebar_position = struct {
            pub const name = "sidebar-position";

            pub const Type = gtk.PackType;
        };

        /// The preferred sidebar width as a fraction of the total width.
        ///
        /// The preferred width is additionally limited by
        /// `OverlaySplitView.properties.min_sidebar_width` and
        /// `OverlaySplitView.properties.max_sidebar_width`.
        ///
        /// The sidebar widget can be allocated with larger width if its own minimum
        /// width exceeds the preferred width.
        pub const sidebar_width_fraction = struct {
            pub const name = "sidebar-width-fraction";

            pub const Type = f64;
        };

        /// The length unit for minimum and maximum sidebar widths.
        ///
        /// See `OverlaySplitView.properties.min_sidebar_width` and
        /// `OverlaySplitView.properties.max_sidebar_width`.
        pub const sidebar_width_unit = struct {
            pub const name = "sidebar-width-unit";

            pub const Type = adw.LengthUnit;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwOverlaySplitView`.
    extern fn adw_overlay_split_view_new() *adw.OverlaySplitView;
    pub const new = adw_overlay_split_view_new;

    /// Gets whether `self` is collapsed.
    extern fn adw_overlay_split_view_get_collapsed(p_self: *OverlaySplitView) c_int;
    pub const getCollapsed = adw_overlay_split_view_get_collapsed;

    /// Gets the content widget for `self`.
    extern fn adw_overlay_split_view_get_content(p_self: *OverlaySplitView) ?*gtk.Widget;
    pub const getContent = adw_overlay_split_view_get_content;

    /// Gets whether `self` can be closed with a swipe gesture.
    extern fn adw_overlay_split_view_get_enable_hide_gesture(p_self: *OverlaySplitView) c_int;
    pub const getEnableHideGesture = adw_overlay_split_view_get_enable_hide_gesture;

    /// Gets whether `self` can be opened with an edge swipe gesture.
    extern fn adw_overlay_split_view_get_enable_show_gesture(p_self: *OverlaySplitView) c_int;
    pub const getEnableShowGesture = adw_overlay_split_view_get_enable_show_gesture;

    /// Gets the maximum sidebar width for `self`.
    extern fn adw_overlay_split_view_get_max_sidebar_width(p_self: *OverlaySplitView) f64;
    pub const getMaxSidebarWidth = adw_overlay_split_view_get_max_sidebar_width;

    /// Gets the minimum sidebar width for `self`.
    extern fn adw_overlay_split_view_get_min_sidebar_width(p_self: *OverlaySplitView) f64;
    pub const getMinSidebarWidth = adw_overlay_split_view_get_min_sidebar_width;

    /// Gets whether the sidebar widget is pinned for `self`.
    extern fn adw_overlay_split_view_get_pin_sidebar(p_self: *OverlaySplitView) c_int;
    pub const getPinSidebar = adw_overlay_split_view_get_pin_sidebar;

    /// Gets whether the sidebar widget is shown for `self`.
    extern fn adw_overlay_split_view_get_show_sidebar(p_self: *OverlaySplitView) c_int;
    pub const getShowSidebar = adw_overlay_split_view_get_show_sidebar;

    /// Gets the sidebar widget for `self`.
    extern fn adw_overlay_split_view_get_sidebar(p_self: *OverlaySplitView) ?*gtk.Widget;
    pub const getSidebar = adw_overlay_split_view_get_sidebar;

    /// Gets the sidebar position for `self`.
    extern fn adw_overlay_split_view_get_sidebar_position(p_self: *OverlaySplitView) gtk.PackType;
    pub const getSidebarPosition = adw_overlay_split_view_get_sidebar_position;

    /// Gets the preferred sidebar width fraction for `self`.
    extern fn adw_overlay_split_view_get_sidebar_width_fraction(p_self: *OverlaySplitView) f64;
    pub const getSidebarWidthFraction = adw_overlay_split_view_get_sidebar_width_fraction;

    /// Gets the length unit for minimum and maximum sidebar widths.
    extern fn adw_overlay_split_view_get_sidebar_width_unit(p_self: *OverlaySplitView) adw.LengthUnit;
    pub const getSidebarWidthUnit = adw_overlay_split_view_get_sidebar_width_unit;

    /// Sets whether `self` view is collapsed.
    ///
    /// When collapsed, the sidebar widget is presented as an overlay above the
    /// content widget, otherwise they are displayed side by side.
    extern fn adw_overlay_split_view_set_collapsed(p_self: *OverlaySplitView, p_collapsed: c_int) void;
    pub const setCollapsed = adw_overlay_split_view_set_collapsed;

    /// Sets the content widget for `self`.
    extern fn adw_overlay_split_view_set_content(p_self: *OverlaySplitView, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_overlay_split_view_set_content;

    /// Sets whether `self` can be closed with a swipe gesture.
    ///
    /// Only touchscreen swipes are supported.
    extern fn adw_overlay_split_view_set_enable_hide_gesture(p_self: *OverlaySplitView, p_enable_hide_gesture: c_int) void;
    pub const setEnableHideGesture = adw_overlay_split_view_set_enable_hide_gesture;

    /// Sets whether `self` can be opened with an edge swipe gesture.
    ///
    /// Only touchscreen swipes are supported.
    extern fn adw_overlay_split_view_set_enable_show_gesture(p_self: *OverlaySplitView, p_enable_show_gesture: c_int) void;
    pub const setEnableShowGesture = adw_overlay_split_view_set_enable_show_gesture;

    /// Sets the maximum sidebar width for `self`.
    ///
    /// Maximum width is affected by `OverlaySplitView.properties.sidebar_width_unit`.
    ///
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    extern fn adw_overlay_split_view_set_max_sidebar_width(p_self: *OverlaySplitView, p_width: f64) void;
    pub const setMaxSidebarWidth = adw_overlay_split_view_set_max_sidebar_width;

    /// Sets the minimum sidebar width for `self`.
    ///
    /// Minimum width is affected by `OverlaySplitView.properties.sidebar_width_unit`.
    ///
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    extern fn adw_overlay_split_view_set_min_sidebar_width(p_self: *OverlaySplitView, p_width: f64) void;
    pub const setMinSidebarWidth = adw_overlay_split_view_set_min_sidebar_width;

    /// Sets whether the sidebar widget is pinned for `self`.
    ///
    /// By default, collapsing `self` automatically hides the sidebar widget, and
    /// uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility never
    /// changes on its own.
    extern fn adw_overlay_split_view_set_pin_sidebar(p_self: *OverlaySplitView, p_pin_sidebar: c_int) void;
    pub const setPinSidebar = adw_overlay_split_view_set_pin_sidebar;

    /// Sets whether the sidebar widget is shown for `self`.
    extern fn adw_overlay_split_view_set_show_sidebar(p_self: *OverlaySplitView, p_show_sidebar: c_int) void;
    pub const setShowSidebar = adw_overlay_split_view_set_show_sidebar;

    /// Sets the sidebar widget for `self`.
    extern fn adw_overlay_split_view_set_sidebar(p_self: *OverlaySplitView, p_sidebar: ?*gtk.Widget) void;
    pub const setSidebar = adw_overlay_split_view_set_sidebar;

    /// Sets the sidebar position for `self`.
    ///
    /// If it's set to `GTK_PACK_START`, the sidebar is displayed before the content,
    /// if `GTK_PACK_END`, it's displayed after the content.
    extern fn adw_overlay_split_view_set_sidebar_position(p_self: *OverlaySplitView, p_position: gtk.PackType) void;
    pub const setSidebarPosition = adw_overlay_split_view_set_sidebar_position;

    /// Sets the preferred sidebar width as a fraction of the total width of `self`.
    ///
    /// The preferred width is additionally limited by
    /// `OverlaySplitView.properties.min_sidebar_width` and
    /// `OverlaySplitView.properties.max_sidebar_width`.
    ///
    /// The sidebar widget can be allocated with larger width if its own minimum
    /// width exceeds the preferred width.
    extern fn adw_overlay_split_view_set_sidebar_width_fraction(p_self: *OverlaySplitView, p_fraction: f64) void;
    pub const setSidebarWidthFraction = adw_overlay_split_view_set_sidebar_width_fraction;

    /// Sets the length unit for minimum and maximum sidebar widths.
    ///
    /// See `OverlaySplitView.properties.min_sidebar_width` and
    /// `OverlaySplitView.properties.max_sidebar_width`.
    extern fn adw_overlay_split_view_set_sidebar_width_unit(p_self: *OverlaySplitView, p_unit: adw.LengthUnit) void;
    pub const setSidebarWidthUnit = adw_overlay_split_view_set_sidebar_width_unit;

    extern fn adw_overlay_split_view_get_type() usize;
    pub const getGObjectType = adw_overlay_split_view_get_type;

    extern fn g_object_ref(p_self: *adw.OverlaySplitView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.OverlaySplitView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OverlaySplitView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `EntryRow` tailored for entering secrets.
///
/// <picture>
///   <source srcset="password-entry-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="password-entry-row.png" alt="password-entry-row">
/// </picture>
///
/// It does not show its contents in clear text, does not allow to copy it to the
/// clipboard, and shows a warning when Caps Lock is engaged. If the underlying
/// platform allows it, `AdwPasswordEntryRow` will also place the text in a
/// non-pageable memory area, to avoid it being written out to disk by the
/// operating system.
///
/// It offer a way to reveal the contents in clear text.
///
/// ## CSS Nodes
///
/// `AdwPasswordEntryRow` has a single CSS node with name `row` that carries
/// `.entry` and `.password` style classes.
pub const PasswordEntryRow = opaque {
    pub const Parent = adw.EntryRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget, gtk.Editable };
    pub const Class = adw.PasswordEntryRowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `AdwPasswordEntryRow`.
    extern fn adw_password_entry_row_new() *adw.PasswordEntryRow;
    pub const new = adw_password_entry_row_new;

    extern fn adw_password_entry_row_get_type() usize;
    pub const getGObjectType = adw_password_entry_row_get_type;

    extern fn g_object_ref(p_self: *adw.PasswordEntryRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PasswordEntryRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PasswordEntryRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A dialog showing application's preferences.
///
/// <picture>
///   <source srcset="preferences-dialog-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="preferences-dialog.png" alt="preferences-dialog">
/// </picture>
///
/// The `AdwPreferencesDialog` widget presents an application's preferences
/// gathered into pages and groups. The preferences are searchable by the user.
///
/// ## Actions
///
/// `AdwPrefencesDialog` defines the `navigation.pop` action, it doesn't take any
/// parameters and pops the current subpage from the navigation stack, equivalent
/// to calling `PreferencesDialog.popSubpage`.
///
/// ## CSS nodes
///
/// `AdwPreferencesDialog` has a main CSS node with the name `dialog` and the
/// style class `.preferences`.
pub const PreferencesDialog = extern struct {
    pub const Parent = adw.Dialog;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.ShortcutManager };
    pub const Class = adw.PreferencesDialogClass;
    f_parent_instance: adw.Dialog,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether search is enabled.
        pub const search_enabled = struct {
            pub const name = "search-enabled";

            pub const Type = c_int;
        };

        /// The currently visible page.
        pub const visible_page = struct {
            pub const name = "visible-page";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the currently visible page.
        ///
        /// See `AdwPreferencesDialog.properties.visible_page`.
        pub const visible_page_name = struct {
            pub const name = "visible-page-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPreferencesDialog`.
    extern fn adw_preferences_dialog_new() *adw.PreferencesDialog;
    pub const new = adw_preferences_dialog_new;

    /// Adds a preferences page to `self`.
    extern fn adw_preferences_dialog_add(p_self: *PreferencesDialog, p_page: *adw.PreferencesPage) void;
    pub const add = adw_preferences_dialog_add;

    /// Displays `toast`.
    ///
    /// See `ToastOverlay.addToast`.
    extern fn adw_preferences_dialog_add_toast(p_self: *PreferencesDialog, p_toast: *adw.Toast) void;
    pub const addToast = adw_preferences_dialog_add_toast;

    /// Gets whether search is enabled for `self`.
    extern fn adw_preferences_dialog_get_search_enabled(p_self: *PreferencesDialog) c_int;
    pub const getSearchEnabled = adw_preferences_dialog_get_search_enabled;

    /// Gets the currently visible page of `self`.
    extern fn adw_preferences_dialog_get_visible_page(p_self: *PreferencesDialog) ?*adw.PreferencesPage;
    pub const getVisiblePage = adw_preferences_dialog_get_visible_page;

    /// Gets the name of currently visible page of `self`.
    extern fn adw_preferences_dialog_get_visible_page_name(p_self: *PreferencesDialog) ?[*:0]const u8;
    pub const getVisiblePageName = adw_preferences_dialog_get_visible_page_name;

    /// Pop the visible page from the subpage stack of `self`.
    extern fn adw_preferences_dialog_pop_subpage(p_self: *PreferencesDialog) c_int;
    pub const popSubpage = adw_preferences_dialog_pop_subpage;

    /// Pushes `page` onto the subpage stack of `self`.
    ///
    /// The page will be automatically removed when popped.
    extern fn adw_preferences_dialog_push_subpage(p_self: *PreferencesDialog, p_page: *adw.NavigationPage) void;
    pub const pushSubpage = adw_preferences_dialog_push_subpage;

    /// Removes a page from `self`.
    extern fn adw_preferences_dialog_remove(p_self: *PreferencesDialog, p_page: *adw.PreferencesPage) void;
    pub const remove = adw_preferences_dialog_remove;

    /// Sets whether search is enabled for `self`.
    extern fn adw_preferences_dialog_set_search_enabled(p_self: *PreferencesDialog, p_search_enabled: c_int) void;
    pub const setSearchEnabled = adw_preferences_dialog_set_search_enabled;

    /// Makes `page` the visible page of `self`.
    extern fn adw_preferences_dialog_set_visible_page(p_self: *PreferencesDialog, p_page: *adw.PreferencesPage) void;
    pub const setVisiblePage = adw_preferences_dialog_set_visible_page;

    /// Makes the page with the given name visible.
    ///
    /// See `PreferencesDialog.properties.visible_page`.
    extern fn adw_preferences_dialog_set_visible_page_name(p_self: *PreferencesDialog, p_name: [*:0]const u8) void;
    pub const setVisiblePageName = adw_preferences_dialog_set_visible_page_name;

    extern fn adw_preferences_dialog_get_type() usize;
    pub const getGObjectType = adw_preferences_dialog_get_type;

    extern fn g_object_ref(p_self: *adw.PreferencesDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PreferencesDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreferencesDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A group of preference rows.
///
/// <picture>
///   <source srcset="preferences-group-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="preferences-group.png" alt="preferences-group">
/// </picture>
///
/// An `AdwPreferencesGroup` represents a group or tightly related preferences,
/// which in turn are represented by `PreferencesRow`.
///
/// To summarize the role of the preferences it gathers, a group can have both a
/// title and a description. The title will be used by `PreferencesDialog`
/// to let the user look for a preference.
///
/// The `PreferencesGroup.properties.separate_rows` property can be used to
/// separate the rows within the group, same as when using the
/// [`.boxed-list-separate`](style-classes.html`boxed`-lists-cards) style class
/// instead of `.boxed-list`.
///
/// ## AdwPreferencesGroup as GtkBuildable
///
/// The `AdwPreferencesGroup` implementation of the `gtk.Buildable` interface
/// supports adding `PreferencesRow`s to the list by omitting "type". If "type"
/// is omitted and the widget isn't a `PreferencesRow` the child is added to
/// a box below the list.
///
/// When the "type" attribute of a child is `header-suffix`, the child
/// is set as the suffix on the end of the title and description.
///
/// ## CSS nodes
///
/// `AdwPreferencesGroup` has a single CSS node with name `preferencesgroup`.
///
/// ## Accessibility
///
/// `AdwPreferencesGroup` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const PreferencesGroup = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.PreferencesGroupClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The description for this group of preferences.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The header suffix widget.
        ///
        /// Displayed above the list, next to the title and description.
        ///
        /// Suffixes are commonly used to show a button or a spinner for the whole
        /// group.
        pub const header_suffix = struct {
            pub const name = "header-suffix";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether to separate rows.
        ///
        /// Equivalent to using the
        /// [`.boxed-list-separate`](style-classes.html`boxed`-lists-cards) style class
        /// on a `gtk.ListBox` instead of `.boxed-list`.
        pub const separate_rows = struct {
            pub const name = "separate-rows";

            pub const Type = c_int;
        };

        /// The title for this group of preferences.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPreferencesGroup`.
    extern fn adw_preferences_group_new() *adw.PreferencesGroup;
    pub const new = adw_preferences_group_new;

    /// Adds a child to `self`.
    extern fn adw_preferences_group_add(p_self: *PreferencesGroup, p_child: *gtk.Widget) void;
    pub const add = adw_preferences_group_add;

    /// Gets the description of `self`.
    extern fn adw_preferences_group_get_description(p_self: *PreferencesGroup) ?[*:0]const u8;
    pub const getDescription = adw_preferences_group_get_description;

    /// Gets the suffix for `self`'s header.
    extern fn adw_preferences_group_get_header_suffix(p_self: *PreferencesGroup) ?*gtk.Widget;
    pub const getHeaderSuffix = adw_preferences_group_get_header_suffix;

    /// Gets whether `self`'s rows are separated.
    extern fn adw_preferences_group_get_separate_rows(p_self: *PreferencesGroup) c_int;
    pub const getSeparateRows = adw_preferences_group_get_separate_rows;

    /// Gets the title of `self`.
    extern fn adw_preferences_group_get_title(p_self: *PreferencesGroup) [*:0]const u8;
    pub const getTitle = adw_preferences_group_get_title;

    /// Removes a child from `self`.
    extern fn adw_preferences_group_remove(p_self: *PreferencesGroup, p_child: *gtk.Widget) void;
    pub const remove = adw_preferences_group_remove;

    /// Sets the description for `self`.
    extern fn adw_preferences_group_set_description(p_self: *PreferencesGroup, p_description: ?[*:0]const u8) void;
    pub const setDescription = adw_preferences_group_set_description;

    /// Sets the suffix for `self`'s header.
    ///
    /// Displayed above the list, next to the title and description.
    ///
    /// Suffixes are commonly used to show a button or a spinner for the whole group.
    extern fn adw_preferences_group_set_header_suffix(p_self: *PreferencesGroup, p_suffix: ?*gtk.Widget) void;
    pub const setHeaderSuffix = adw_preferences_group_set_header_suffix;

    /// Sets whether `self`'s rows are separated.
    ///
    /// Equivalent to using the
    /// [`.boxed-list-separate`](style-classes.html`boxed`-lists-cards) style class
    /// on a `gtk.ListBox` instead of `.boxed-list`.
    extern fn adw_preferences_group_set_separate_rows(p_self: *PreferencesGroup, p_separate_rows: c_int) void;
    pub const setSeparateRows = adw_preferences_group_set_separate_rows;

    /// Sets the title for `self`.
    extern fn adw_preferences_group_set_title(p_self: *PreferencesGroup, p_title: [*:0]const u8) void;
    pub const setTitle = adw_preferences_group_set_title;

    extern fn adw_preferences_group_get_type() usize;
    pub const getGObjectType = adw_preferences_group_get_type;

    extern fn g_object_ref(p_self: *adw.PreferencesGroup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PreferencesGroup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreferencesGroup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A page from `PreferencesDialog`.
///
/// <picture>
///   <source srcset="preferences-page-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="preferences-page.png" alt="preferences-page">
/// </picture>
///
/// The `AdwPreferencesPage` widget gathers preferences groups into a single page
/// of a preferences window.
///
/// ## CSS nodes
///
/// `AdwPreferencesPage` has a single CSS node with name `preferencespage`.
///
/// ## Accessibility
///
/// `AdwPreferencesPage` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const PreferencesPage = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.PreferencesPageClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// A `Banner` displayed at the top of the page.
        pub const banner = struct {
            pub const name = "banner";

            pub const Type = ?*adw.Banner;
        };

        /// The description to be displayed at the top of the page.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the description should be centered.
        pub const description_centered = struct {
            pub const name = "description-centered";

            pub const Type = c_int;
        };

        /// The icon name for this page.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The name of this page.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The title for this page.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether an embedded underline in the title indicates a mnemonic.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPreferencesPage`.
    extern fn adw_preferences_page_new() *adw.PreferencesPage;
    pub const new = adw_preferences_page_new;

    /// Adds a preferences group to `self`.
    extern fn adw_preferences_page_add(p_self: *PreferencesPage, p_group: *adw.PreferencesGroup) void;
    pub const add = adw_preferences_page_add;

    /// Gets the banner displayed at the top of the page.
    extern fn adw_preferences_page_get_banner(p_self: *PreferencesPage) ?*adw.Banner;
    pub const getBanner = adw_preferences_page_get_banner;

    /// Gets the description of `self`.
    extern fn adw_preferences_page_get_description(p_self: *PreferencesPage) [*:0]const u8;
    pub const getDescription = adw_preferences_page_get_description;

    /// Gets whether the description is centered.
    extern fn adw_preferences_page_get_description_centered(p_self: *PreferencesPage) c_int;
    pub const getDescriptionCentered = adw_preferences_page_get_description_centered;

    /// Gets the icon name for `self`.
    extern fn adw_preferences_page_get_icon_name(p_self: *PreferencesPage) ?[*:0]const u8;
    pub const getIconName = adw_preferences_page_get_icon_name;

    /// Gets the name of `self`.
    extern fn adw_preferences_page_get_name(p_self: *PreferencesPage) ?[*:0]const u8;
    pub const getName = adw_preferences_page_get_name;

    /// Gets the title of `self`.
    extern fn adw_preferences_page_get_title(p_self: *PreferencesPage) [*:0]const u8;
    pub const getTitle = adw_preferences_page_get_title;

    /// Gets whether an embedded underline in the title indicates a mnemonic.
    extern fn adw_preferences_page_get_use_underline(p_self: *PreferencesPage) c_int;
    pub const getUseUnderline = adw_preferences_page_get_use_underline;

    /// Removes a group from `self`.
    extern fn adw_preferences_page_remove(p_self: *PreferencesPage, p_group: *adw.PreferencesGroup) void;
    pub const remove = adw_preferences_page_remove;

    /// Scrolls the scrolled window of `self` to the top.
    extern fn adw_preferences_page_scroll_to_top(p_self: *PreferencesPage) void;
    pub const scrollToTop = adw_preferences_page_scroll_to_top;

    /// Sets the banner displayed at the top of the page.
    extern fn adw_preferences_page_set_banner(p_self: *PreferencesPage, p_banner: ?*adw.Banner) void;
    pub const setBanner = adw_preferences_page_set_banner;

    /// Sets the description of `self`.
    ///
    /// The description is displayed at the top of the page.
    extern fn adw_preferences_page_set_description(p_self: *PreferencesPage, p_description: [*:0]const u8) void;
    pub const setDescription = adw_preferences_page_set_description;

    /// Sets whether the description should be centered.
    extern fn adw_preferences_page_set_description_centered(p_self: *PreferencesPage, p_centered: c_int) void;
    pub const setDescriptionCentered = adw_preferences_page_set_description_centered;

    /// Sets the icon name for `self`.
    extern fn adw_preferences_page_set_icon_name(p_self: *PreferencesPage, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_preferences_page_set_icon_name;

    /// Sets the name of `self`.
    extern fn adw_preferences_page_set_name(p_self: *PreferencesPage, p_name: ?[*:0]const u8) void;
    pub const setName = adw_preferences_page_set_name;

    /// Sets the title of `self`.
    extern fn adw_preferences_page_set_title(p_self: *PreferencesPage, p_title: [*:0]const u8) void;
    pub const setTitle = adw_preferences_page_set_title;

    /// Sets whether an embedded underline in the title indicates a mnemonic.
    extern fn adw_preferences_page_set_use_underline(p_self: *PreferencesPage, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_preferences_page_set_use_underline;

    extern fn adw_preferences_page_get_type() usize;
    pub const getGObjectType = adw_preferences_page_get_type;

    extern fn g_object_ref(p_self: *adw.PreferencesPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PreferencesPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreferencesPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` used to present preferences.
///
/// The `AdwPreferencesRow` widget has a title that `PreferencesDialog`
/// will use to let the user look for a preference. It doesn't present the title
/// in any way and lets you present the preference as you please.
///
/// `ActionRow` and its derivatives are convenient to use as preference
/// rows as they take care of presenting the preference's title while letting you
/// compose the inputs of the preference around it.
pub const PreferencesRow = extern struct {
    pub const Parent = gtk.ListBoxRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.PreferencesRowClass;
    f_parent_instance: gtk.ListBoxRow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The title of the preference represented by this row.
        ///
        /// The title is interpreted as Pango markup unless
        /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the user can copy the title from the label.
        ///
        /// See also `gtk.Label.properties.selectable`.
        pub const title_selectable = struct {
            pub const name = "title-selectable";

            pub const Type = c_int;
        };

        /// Whether to use Pango markup for the title label.
        ///
        /// Subclasses may also use it for other labels, such as subtitle.
        ///
        /// See also `pango.parseMarkup`.
        pub const use_markup = struct {
            pub const name = "use-markup";

            pub const Type = c_int;
        };

        /// Whether an embedded underline in the title indicates a mnemonic.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPreferencesRow`.
    extern fn adw_preferences_row_new() *adw.PreferencesRow;
    pub const new = adw_preferences_row_new;

    /// Gets the title of the preference represented by `self`.
    extern fn adw_preferences_row_get_title(p_self: *PreferencesRow) [*:0]const u8;
    pub const getTitle = adw_preferences_row_get_title;

    /// Gets whether the user can copy the title from the label
    extern fn adw_preferences_row_get_title_selectable(p_self: *PreferencesRow) c_int;
    pub const getTitleSelectable = adw_preferences_row_get_title_selectable;

    /// Gets whether to use Pango markup for the title label.
    extern fn adw_preferences_row_get_use_markup(p_self: *PreferencesRow) c_int;
    pub const getUseMarkup = adw_preferences_row_get_use_markup;

    /// Gets whether an embedded underline in the title indicates a mnemonic.
    extern fn adw_preferences_row_get_use_underline(p_self: *PreferencesRow) c_int;
    pub const getUseUnderline = adw_preferences_row_get_use_underline;

    /// Sets the title of the preference represented by `self`.
    ///
    /// The title is interpreted as Pango markup unless
    /// `PreferencesRow.properties.use_markup` is set to `FALSE`.
    extern fn adw_preferences_row_set_title(p_self: *PreferencesRow, p_title: [*:0]const u8) void;
    pub const setTitle = adw_preferences_row_set_title;

    /// Sets whether the user can copy the title from the label
    ///
    /// See also `gtk.Label.properties.selectable`.
    extern fn adw_preferences_row_set_title_selectable(p_self: *PreferencesRow, p_title_selectable: c_int) void;
    pub const setTitleSelectable = adw_preferences_row_set_title_selectable;

    /// Sets whether to use Pango markup for the title label.
    ///
    /// Subclasses may also use it for other labels, such as subtitle.
    ///
    /// See also `pango.parseMarkup`.
    extern fn adw_preferences_row_set_use_markup(p_self: *PreferencesRow, p_use_markup: c_int) void;
    pub const setUseMarkup = adw_preferences_row_set_use_markup;

    /// Sets whether an embedded underline in the title indicates a mnemonic.
    extern fn adw_preferences_row_set_use_underline(p_self: *PreferencesRow, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_preferences_row_set_use_underline;

    extern fn adw_preferences_row_get_type() usize;
    pub const getGObjectType = adw_preferences_row_get_type;

    extern fn g_object_ref(p_self: *adw.PreferencesRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PreferencesRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreferencesRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A window to present an application's preferences.
///
/// <picture>
///   <source srcset="preferences-window-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="preferences-window.png" alt="preferences-window">
/// </picture>
///
/// The `AdwPreferencesWindow` widget presents an application's preferences
/// gathered into pages and groups. The preferences are searchable by the user.
///
/// ## CSS nodes
///
/// `AdwPreferencesWindow` has a main CSS node with the name `window` and the
/// style class `.preferences`.
pub const PreferencesWindow = extern struct {
    pub const Parent = adw.Window;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = adw.PreferencesWindowClass;
    f_parent_instance: adw.Window,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether gestures and shortcuts for closing subpages are enabled.
        ///
        /// The supported gestures are:
        ///
        /// - One-finger swipe on touchscreens
        /// - Horizontal scrolling on touchpads (usually two-finger swipe)
        /// - Back mouse button
        ///
        /// The keyboard back key is also supported, as well as the
        /// <kbd>Alt</kbd>+<kbd>←</kbd> shortcut.
        ///
        /// For right-to-left locales, gestures and shortcuts are reversed.
        ///
        /// Has no effect for subpages added with
        /// `PreferencesWindow.pushSubpage`.
        pub const can_navigate_back = struct {
            pub const name = "can-navigate-back";

            pub const Type = c_int;
        };

        /// Whether search is enabled.
        pub const search_enabled = struct {
            pub const name = "search-enabled";

            pub const Type = c_int;
        };

        /// The currently visible page.
        pub const visible_page = struct {
            pub const name = "visible-page";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the currently visible page.
        ///
        /// See `PreferencesWindow.properties.visible_page`.
        pub const visible_page_name = struct {
            pub const name = "visible-page-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPreferencesWindow`.
    extern fn adw_preferences_window_new() *adw.PreferencesWindow;
    pub const new = adw_preferences_window_new;

    /// Adds a preferences page to `self`.
    extern fn adw_preferences_window_add(p_self: *PreferencesWindow, p_page: *adw.PreferencesPage) void;
    pub const add = adw_preferences_window_add;

    /// Displays `toast`.
    ///
    /// See `ToastOverlay.addToast`.
    extern fn adw_preferences_window_add_toast(p_self: *PreferencesWindow, p_toast: *adw.Toast) void;
    pub const addToast = adw_preferences_window_add_toast;

    /// Closes the current subpage.
    ///
    /// If there is no presented subpage, this does nothing.
    extern fn adw_preferences_window_close_subpage(p_self: *PreferencesWindow) void;
    pub const closeSubpage = adw_preferences_window_close_subpage;

    /// Gets whether gestures and shortcuts for closing subpages are enabled.
    extern fn adw_preferences_window_get_can_navigate_back(p_self: *PreferencesWindow) c_int;
    pub const getCanNavigateBack = adw_preferences_window_get_can_navigate_back;

    /// Gets whether search is enabled for `self`.
    extern fn adw_preferences_window_get_search_enabled(p_self: *PreferencesWindow) c_int;
    pub const getSearchEnabled = adw_preferences_window_get_search_enabled;

    /// Gets the currently visible page of `self`.
    extern fn adw_preferences_window_get_visible_page(p_self: *PreferencesWindow) ?*adw.PreferencesPage;
    pub const getVisiblePage = adw_preferences_window_get_visible_page;

    /// Gets the name of currently visible page of `self`.
    extern fn adw_preferences_window_get_visible_page_name(p_self: *PreferencesWindow) ?[*:0]const u8;
    pub const getVisiblePageName = adw_preferences_window_get_visible_page_name;

    /// Pop the visible page from the subpage stack of `self`.
    extern fn adw_preferences_window_pop_subpage(p_self: *PreferencesWindow) c_int;
    pub const popSubpage = adw_preferences_window_pop_subpage;

    /// Sets `subpage` as the window's subpage and opens it.
    ///
    /// The transition can be cancelled by the user, in which case visible child will
    /// change back to the previously visible child.
    extern fn adw_preferences_window_present_subpage(p_self: *PreferencesWindow, p_subpage: *gtk.Widget) void;
    pub const presentSubpage = adw_preferences_window_present_subpage;

    /// Pushes `page` onto the subpage stack of `self`.
    ///
    /// The page will be automatically removed when popped.
    extern fn adw_preferences_window_push_subpage(p_self: *PreferencesWindow, p_page: *adw.NavigationPage) void;
    pub const pushSubpage = adw_preferences_window_push_subpage;

    /// Removes a page from `self`.
    extern fn adw_preferences_window_remove(p_self: *PreferencesWindow, p_page: *adw.PreferencesPage) void;
    pub const remove = adw_preferences_window_remove;

    /// Sets whether gestures and shortcuts for closing subpages are enabled.
    ///
    /// The supported gestures are:
    ///
    /// - One-finger swipe on touchscreens
    /// - Horizontal scrolling on touchpads (usually two-finger swipe)
    /// - Back mouse button
    ///
    /// The keyboard back key is also supported, as well as the
    /// <kbd>Alt</kbd>+<kbd>←</kbd> shortcut.
    ///
    /// For right-to-left locales, gestures and shortcuts are reversed.
    ///
    /// Has no effect for subpages added with `PreferencesWindow.pushSubpage`.
    extern fn adw_preferences_window_set_can_navigate_back(p_self: *PreferencesWindow, p_can_navigate_back: c_int) void;
    pub const setCanNavigateBack = adw_preferences_window_set_can_navigate_back;

    /// Sets whether search is enabled for `self`.
    extern fn adw_preferences_window_set_search_enabled(p_self: *PreferencesWindow, p_search_enabled: c_int) void;
    pub const setSearchEnabled = adw_preferences_window_set_search_enabled;

    /// Makes `page` the visible page of `self`.
    extern fn adw_preferences_window_set_visible_page(p_self: *PreferencesWindow, p_page: *adw.PreferencesPage) void;
    pub const setVisiblePage = adw_preferences_window_set_visible_page;

    /// Makes the page with the given name visible.
    ///
    /// See `PreferencesWindow.properties.visible_page`.
    extern fn adw_preferences_window_set_visible_page_name(p_self: *PreferencesWindow, p_name: [*:0]const u8) void;
    pub const setVisiblePageName = adw_preferences_window_set_visible_page_name;

    extern fn adw_preferences_window_get_type() usize;
    pub const getGObjectType = adw_preferences_window_get_type;

    extern fn g_object_ref(p_self: *adw.PreferencesWindow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PreferencesWindow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreferencesWindow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An `AnimationTarget` changing the value of a property of a
/// `gobject.Object` instance.
pub const PropertyAnimationTarget = opaque {
    pub const Parent = adw.AnimationTarget;
    pub const Implements = [_]type{};
    pub const Class = adw.PropertyAnimationTargetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The object whose property will be animated.
        ///
        /// The `AdwPropertyAnimationTarget` instance does not hold a strong reference
        /// on the object; make sure the object is kept alive throughout the target's
        /// lifetime.
        pub const object = struct {
            pub const name = "object";

            pub const Type = ?*gobject.Object;
        };

        /// The `GParamSpec` of the property to be animated.
        pub const pspec = struct {
            pub const name = "pspec";

            pub const Type = ?*gobject.ParamSpec;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwPropertyAnimationTarget` for the `property_name` property on
    /// `object`.
    extern fn adw_property_animation_target_new(p_object: *gobject.Object, p_property_name: [*:0]const u8) *adw.PropertyAnimationTarget;
    pub const new = adw_property_animation_target_new;

    /// Creates a new `AdwPropertyAnimationTarget` for the `pspec` property on
    /// `object`.
    extern fn adw_property_animation_target_new_for_pspec(p_object: *gobject.Object, p_pspec: *gobject.ParamSpec) *adw.PropertyAnimationTarget;
    pub const newForPspec = adw_property_animation_target_new_for_pspec;

    /// Gets the object animated by `self`.
    ///
    /// The `AdwPropertyAnimationTarget` instance does not hold a strong reference on
    /// the object; make sure the object is kept alive throughout the target's
    /// lifetime.
    extern fn adw_property_animation_target_get_object(p_self: *PropertyAnimationTarget) *gobject.Object;
    pub const getObject = adw_property_animation_target_get_object;

    /// Gets the `GParamSpec` of the property animated by `self`.
    extern fn adw_property_animation_target_get_pspec(p_self: *PropertyAnimationTarget) *gobject.ParamSpec;
    pub const getPspec = adw_property_animation_target_get_pspec;

    extern fn adw_property_animation_target_get_type() usize;
    pub const getGObjectType = adw_property_animation_target_get_type;

    extern fn g_object_ref(p_self: *adw.PropertyAnimationTarget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.PropertyAnimationTarget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PropertyAnimationTarget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An `ActionRow` with an embedded spin button.
///
/// <picture>
///   <source srcset="spin-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="spin-row.png" alt="spin-row">
/// </picture>
///
/// Example of an `AdwSpinRow` UI definition:
///
/// ```xml
/// <object class="AdwSpinRow">
///   <property name="title" translatable="yes">Spin Row</property>
///   <property name="adjustment">
///     <object class="GtkAdjustment">
///       <property name="lower">0</property>
///       <property name="upper">100</property>
///       <property name="value">50</property>
///       <property name="page-increment">10</property>
///       <property name="step-increment">1</property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// See `gtk.SpinButton` for details.
///
/// ## CSS nodes
///
/// `AdwSpinRow` has the same structure as `ActionRow`, as well as the
/// `.spin` style class on the main node.
///
/// ## Accessibility
///
/// `AdwSpinRow` uses an internal `GtkSpinButton` with the
/// `GTK_ACCESSIBLE_ROLE_SPIN_BUTTON` role.
pub const SpinRow = opaque {
    pub const Parent = adw.ActionRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget, gtk.Editable };
    pub const Class = adw.SpinRowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The adjustment that holds the value of the spin row.
        pub const adjustment = struct {
            pub const name = "adjustment";

            pub const Type = ?*gtk.Adjustment;
        };

        /// The acceleration rate when you hold down a button or key.
        pub const climb_rate = struct {
            pub const name = "climb-rate";

            pub const Type = f64;
        };

        /// The number of decimal places to display.
        pub const digits = struct {
            pub const name = "digits";

            pub const Type = c_uint;
        };

        /// Whether non-numeric characters should be ignored.
        pub const numeric = struct {
            pub const name = "numeric";

            pub const Type = c_int;
        };

        /// Whether invalid values are snapped to the nearest step increment.
        pub const snap_to_ticks = struct {
            pub const name = "snap-to-ticks";

            pub const Type = c_int;
        };

        /// The policy for updating the spin row.
        ///
        /// The options are always, or only when the value is invalid.
        pub const update_policy = struct {
            pub const name = "update-policy";

            pub const Type = gtk.SpinButtonUpdatePolicy;
        };

        /// The current value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = f64;
        };

        /// Whether the spin row should wrap upon reaching its limits.
        pub const wrap = struct {
            pub const name = "wrap";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted to convert the user's input into a double value.
        ///
        /// The signal handler is expected to use `gtk.Editable.getText` to
        /// retrieve the text of the spinbutton and set new_value to the new value.
        ///
        /// The default conversion uses `glib.strtod`.
        ///
        /// See `gtk.SpinButton.signals.input`.
        pub const input = struct {
            pub const name = "input";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_new_value: *f64, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SpinRow, p_instance))),
                    gobject.signalLookup("input", SpinRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted to tweak the formatting of the value for display.
        ///
        /// See `gtk.SpinButton.signals.output`.
        pub const output = struct {
            pub const name = "output";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SpinRow, p_instance))),
                    gobject.signalLookup("output", SpinRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted right after the spinbutton wraps.
        ///
        /// See `gtk.SpinButton.signals.wrapped`.
        pub const wrapped = struct {
            pub const name = "wrapped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SpinRow, p_instance))),
                    gobject.signalLookup("wrapped", SpinRow.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwSpinRow`.
    extern fn adw_spin_row_new(p_adjustment: ?*gtk.Adjustment, p_climb_rate: f64, p_digits: c_uint) *adw.SpinRow;
    pub const new = adw_spin_row_new;

    /// Creates a new `AdwSpinRow` with the given properties.
    ///
    /// This is a convenience constructor that allows creation of a numeric
    /// `AdwSpinRow` without manually creating an adjustment. The value is initially
    /// set to the minimum value and a page increment of 10 * `step` is the default.
    /// The precision of the spin row is equivalent to the precisions of `step`.
    ///
    /// ::: note
    ///     The way in which the precision is derived works best if `step` is a power
    ///     of ten. If the resulting precision is not suitable for your needs, use
    ///     `SpinRow.setDigits` to correct it.
    extern fn adw_spin_row_new_with_range(p_min: f64, p_max: f64, p_step: f64) *adw.SpinRow;
    pub const newWithRange = adw_spin_row_new_with_range;

    /// Changes the properties of an existing spin row.
    ///
    /// The adjustment, climb rate, and number of decimal places are updated
    /// accordingly.
    extern fn adw_spin_row_configure(p_self: *SpinRow, p_adjustment: ?*gtk.Adjustment, p_climb_rate: f64, p_digits: c_uint) void;
    pub const configure = adw_spin_row_configure;

    /// Gets the adjustment that holds the value for the spin row.
    extern fn adw_spin_row_get_adjustment(p_self: *SpinRow) *gtk.Adjustment;
    pub const getAdjustment = adw_spin_row_get_adjustment;

    /// Gets the acceleration rate when you hold down a button or key.
    extern fn adw_spin_row_get_climb_rate(p_self: *SpinRow) f64;
    pub const getClimbRate = adw_spin_row_get_climb_rate;

    /// Gets the number of decimal places to display.
    extern fn adw_spin_row_get_digits(p_self: *SpinRow) c_uint;
    pub const getDigits = adw_spin_row_get_digits;

    /// Gets whether non-numeric characters should be ignored.
    extern fn adw_spin_row_get_numeric(p_self: *SpinRow) c_int;
    pub const getNumeric = adw_spin_row_get_numeric;

    /// Gets whether invalid values are snapped to nearest step increment.
    extern fn adw_spin_row_get_snap_to_ticks(p_self: *SpinRow) c_int;
    pub const getSnapToTicks = adw_spin_row_get_snap_to_ticks;

    /// Gets the policy for updating the spin row.
    extern fn adw_spin_row_get_update_policy(p_self: *SpinRow) gtk.SpinButtonUpdatePolicy;
    pub const getUpdatePolicy = adw_spin_row_get_update_policy;

    /// Gets the current value.
    extern fn adw_spin_row_get_value(p_self: *SpinRow) f64;
    pub const getValue = adw_spin_row_get_value;

    /// Gets whether the spin row should wrap upon reaching its limits.
    extern fn adw_spin_row_get_wrap(p_self: *SpinRow) c_int;
    pub const getWrap = adw_spin_row_get_wrap;

    /// Sets the adjustment that holds the value for the spin row.
    extern fn adw_spin_row_set_adjustment(p_self: *SpinRow, p_adjustment: ?*gtk.Adjustment) void;
    pub const setAdjustment = adw_spin_row_set_adjustment;

    /// Sets the acceleration rate when you hold down a button or key.
    extern fn adw_spin_row_set_climb_rate(p_self: *SpinRow, p_climb_rate: f64) void;
    pub const setClimbRate = adw_spin_row_set_climb_rate;

    /// Sets the number of decimal places to display.
    extern fn adw_spin_row_set_digits(p_self: *SpinRow, p_digits: c_uint) void;
    pub const setDigits = adw_spin_row_set_digits;

    /// Sets whether non-numeric characters should be ignored.
    extern fn adw_spin_row_set_numeric(p_self: *SpinRow, p_numeric: c_int) void;
    pub const setNumeric = adw_spin_row_set_numeric;

    /// Sets the minimum and maximum allowable values for `self`.
    ///
    /// If the current value is outside this range, it will be adjusted
    /// to fit within the range, otherwise it will remain unchanged.
    extern fn adw_spin_row_set_range(p_self: *SpinRow, p_min: f64, p_max: f64) void;
    pub const setRange = adw_spin_row_set_range;

    /// Sets whether invalid values are snapped to the nearest step increment.
    extern fn adw_spin_row_set_snap_to_ticks(p_self: *SpinRow, p_snap_to_ticks: c_int) void;
    pub const setSnapToTicks = adw_spin_row_set_snap_to_ticks;

    /// Sets the policy for updating the spin row.
    ///
    /// The options are always, or only when the value is invalid.
    extern fn adw_spin_row_set_update_policy(p_self: *SpinRow, p_policy: gtk.SpinButtonUpdatePolicy) void;
    pub const setUpdatePolicy = adw_spin_row_set_update_policy;

    /// Sets the current value.
    extern fn adw_spin_row_set_value(p_self: *SpinRow, p_value: f64) void;
    pub const setValue = adw_spin_row_set_value;

    /// Sets whether the spin row should wrap upon reaching its limits.
    extern fn adw_spin_row_set_wrap(p_self: *SpinRow, p_wrap: c_int) void;
    pub const setWrap = adw_spin_row_set_wrap;

    /// Manually force an update of the spin row.
    extern fn adw_spin_row_update(p_self: *SpinRow) void;
    pub const update = adw_spin_row_update;

    extern fn adw_spin_row_get_type() usize;
    pub const getGObjectType = adw_spin_row_get_type;

    extern fn g_object_ref(p_self: *adw.SpinRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SpinRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SpinRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget showing a loading spinner.
///
/// <picture>
///   <source srcset="spinner-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="spinner.png" alt="spinner">
/// </picture>
///
/// The size of the spinner depends on the available size, never smaller than
/// 16×16 pixels and never larger than 64×64 pixels.
///
/// Use the `gtk.Widget.properties.halign` and `gtk.Widget.properties.valign`
/// properties in combination with `gtk.Widget.properties.width_request` and
/// `gtk.Widget.properties.height_request` for fine sizing control.
///
/// For example, the following snippet shows the spinner at 48×48 pixels:
///
/// ```xml
/// <object class="AdwSpinner">
///   <property name="halign">center</property>
///   <property name="valign">center</property>
///   <property name="width-request">48</property>
///   <property name="height-request">48</property>
/// </object>
/// ```
///
/// See `SpinnerPaintable` for cases where using a widget is impractical or
/// impossible, such as `StatusPage.properties.paintable`.
///
/// ## CSS nodes
///
/// `AdwSpinner` has a single node with the name `image` and the style class
/// `.spinner`.
pub const Spinner = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.SpinnerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `AdwSpinner`.
    extern fn adw_spinner_new() *adw.Spinner;
    pub const new = adw_spinner_new;

    extern fn adw_spinner_get_type() usize;
    pub const getGObjectType = adw_spinner_get_type;

    extern fn g_object_ref(p_self: *adw.Spinner) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Spinner) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Spinner, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A paintable showing a loading spinner.
///
/// <picture>
///   <source srcset="spinner-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="spinner.png" alt="spinner">
/// </picture>
///
/// `AdwSpinnerPaintable` size varies depending on the available space, but is
/// capped at 64×64 pixels.
///
/// To be able to animate, `AdwSpinnerPaintable` needs a widget. It will be
/// animated according to that widget's frame clock, and only if that widget is
/// mapped. Ideally it should be the same widget the paintable is displayed in,
/// but that's not a requirement.
///
/// Most applications should be using `Spinner` instead.
/// `AdwSpinnerPaintable` is provided for the cases where using a widget is
/// impractical or impossible, such as `StatusPage.properties.paintable`:
///
/// ```xml
/// <object class="AdwStatusPage" id="status_page">
///   <property name="paintable">
///     <object class="AdwSpinnerPaintable">
///       <property name="widget">status_page</property>
///     </object>
///   </property>
///   <!-- ... -->
/// </object>
/// ```
pub const SpinnerPaintable = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gdk.Paintable, gtk.SymbolicPaintable };
    pub const Class = adw.SpinnerPaintableClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The widget the spinner uses for frame clock.
        pub const widget = struct {
            pub const name = "widget";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwSpinnerPaintable` for `widget`.
    extern fn adw_spinner_paintable_new(p_widget: ?*gtk.Widget) *adw.SpinnerPaintable;
    pub const new = adw_spinner_paintable_new;

    /// Gets the widget used for frame clock.
    extern fn adw_spinner_paintable_get_widget(p_self: *SpinnerPaintable) ?*gtk.Widget;
    pub const getWidget = adw_spinner_paintable_get_widget;

    /// Sets the widget used for frame clock.
    extern fn adw_spinner_paintable_set_widget(p_self: *SpinnerPaintable, p_widget: ?*gtk.Widget) void;
    pub const setWidget = adw_spinner_paintable_set_widget;

    extern fn adw_spinner_paintable_get_type() usize;
    pub const getGObjectType = adw_spinner_paintable_get_type;

    extern fn g_object_ref(p_self: *adw.SpinnerPaintable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SpinnerPaintable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SpinnerPaintable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A combined button and dropdown widget.
///
/// <picture>
///   <source srcset="split-button-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="split-button.png" alt="split-button">
/// </picture>
///
/// `AdwSplitButton` is typically used to present a set of actions in a menu,
/// but allow access to one of them with a single click.
///
/// The API is very similar to `gtk.Button` and `gtk.MenuButton`, see
/// their documentation for details.
///
/// ## CSS nodes
///
/// ```
/// splitbutton[.image-button][.text-button]
/// ├── button
/// │   ╰── <content>
/// ├── separator
/// ╰── menubutton
///     ╰── button.toggle
///         ╰── arrow
/// ```
///
/// `AdwSplitButton`'s CSS node is called `splitbutton`. It contains the css
/// nodes: `button`, `separator`, `menubutton`. See `gtk.MenuButton`
/// documentation for the `menubutton` contents.
///
/// The main CSS node will contain the `.image-button` or `.text-button` style
/// classes matching the button contents. The nested button nodes will never
/// contain them.
///
/// ## Style classes
///
/// `AdwSplitButton` can use some of the same style classes as `gtk.Button`:
///
/// - [`.suggested-action`](style-classes.html`suggested`-action)
/// - [`.destructive-action`](style-classes.html`destructive`-action)
/// - [`.flat`](style-classes.html`flat`)
/// - [`.raised`](style-classes.html`raised`)
///
/// Other style classes, like `.pill`, cannot be used.
///
/// ## Accessibility
///
/// `AdwSplitButton` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const SplitButton = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.SplitButtonClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the button can be smaller than the natural size of its contents.
        ///
        /// If set to `TRUE`, the label will ellipsize.
        ///
        /// See `gtk.Button.properties.can_shrink` and
        /// `gtk.MenuButton.properties.can_shrink`.
        pub const can_shrink = struct {
            pub const name = "can-shrink";

            pub const Type = c_int;
        };

        /// The child widget.
        ///
        /// Setting the child widget will set `SplitButton.properties.label` and
        /// `SplitButton.properties.icon_name` to `NULL`.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The direction in which the popup will be popped up.
        ///
        /// The dropdown arrow icon will point at the same direction.
        ///
        /// If the does not fit in the available space in the given direction, GTK will
        /// try its best to keep it inside the screen and fully visible.
        ///
        /// If you pass `GTK_ARROW_NONE`, it's equivalent to `GTK_ARROW_DOWN`.
        pub const direction = struct {
            pub const name = "direction";

            pub const Type = gtk.ArrowType;
        };

        /// The tooltip of the dropdown button.
        ///
        /// The tooltip can be marked up with the Pango text markup language.
        pub const dropdown_tooltip = struct {
            pub const name = "dropdown-tooltip";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the icon used to automatically populate the button.
        ///
        /// Setting the icon name will set `SplitButton.properties.label` and
        /// `SplitButton.properties.child` to `NULL`.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The label for the button.
        ///
        /// Setting the label will set `SplitButton.properties.icon_name` and
        /// `SplitButton.properties.child` to `NULL`.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The `GMenuModel` from which the popup will be created.
        ///
        /// If the menu model is `NULL`, the dropdown is disabled.
        ///
        /// A `gtk.Popover` will be created from the menu model with
        /// `gtk.PopoverMenu.newFromModel`. Actions will be connected as
        /// documented for this function.
        ///
        /// If `SplitButton.properties.popover` is already set, it will be dissociated
        /// from the button, and the property is set to `NULL`.
        pub const menu_model = struct {
            pub const name = "menu-model";

            pub const Type = ?*gio.MenuModel;
        };

        /// The `GtkPopover` that will be popped up when the dropdown is clicked.
        ///
        /// If the popover is `NULL`, the dropdown is disabled.
        ///
        /// If `SplitButton.properties.menu_model` is set, the menu model is dissociated
        /// from the button, and the property is set to `NULL`.
        pub const popover = struct {
            pub const name = "popover";

            pub const Type = ?*gtk.Popover;
        };

        /// Whether an underline in the text indicates a mnemonic.
        ///
        /// See `SplitButton.properties.label`.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted to animate press then release.
        ///
        /// This is an action signal. Applications should never connect to this signal,
        /// but use the `SplitButton.signals.clicked` signal.
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SplitButton, p_instance))),
                    gobject.signalLookup("activate", SplitButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the button has been activated (pressed and released).
        pub const clicked = struct {
            pub const name = "clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SplitButton, p_instance))),
                    gobject.signalLookup("clicked", SplitButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwSplitButton`.
    extern fn adw_split_button_new() *adw.SplitButton;
    pub const new = adw_split_button_new;

    /// gets whether the button can be smaller than the natural size of its contents.
    extern fn adw_split_button_get_can_shrink(p_self: *SplitButton) c_int;
    pub const getCanShrink = adw_split_button_get_can_shrink;

    /// Gets the child widget.
    extern fn adw_split_button_get_child(p_self: *SplitButton) ?*gtk.Widget;
    pub const getChild = adw_split_button_get_child;

    /// Gets the direction in which the popup will be popped up.
    extern fn adw_split_button_get_direction(p_self: *SplitButton) gtk.ArrowType;
    pub const getDirection = adw_split_button_get_direction;

    /// Gets the tooltip of the dropdown button of `self`.
    extern fn adw_split_button_get_dropdown_tooltip(p_self: *SplitButton) [*:0]const u8;
    pub const getDropdownTooltip = adw_split_button_get_dropdown_tooltip;

    /// Gets the name of the icon used to automatically populate the button.
    extern fn adw_split_button_get_icon_name(p_self: *SplitButton) ?[*:0]const u8;
    pub const getIconName = adw_split_button_get_icon_name;

    /// Gets the label for `self`.
    extern fn adw_split_button_get_label(p_self: *SplitButton) ?[*:0]const u8;
    pub const getLabel = adw_split_button_get_label;

    /// Gets the menu model from which the popup will be created.
    extern fn adw_split_button_get_menu_model(p_self: *SplitButton) ?*gio.MenuModel;
    pub const getMenuModel = adw_split_button_get_menu_model;

    /// Gets the popover that will be popped up when the dropdown is clicked.
    extern fn adw_split_button_get_popover(p_self: *SplitButton) ?*gtk.Popover;
    pub const getPopover = adw_split_button_get_popover;

    /// Gets whether an underline in the text indicates a mnemonic.
    extern fn adw_split_button_get_use_underline(p_self: *SplitButton) c_int;
    pub const getUseUnderline = adw_split_button_get_use_underline;

    /// Dismisses the menu.
    extern fn adw_split_button_popdown(p_self: *SplitButton) void;
    pub const popdown = adw_split_button_popdown;

    /// Pops up the menu.
    extern fn adw_split_button_popup(p_self: *SplitButton) void;
    pub const popup = adw_split_button_popup;

    /// Sets whether the button can be smaller than the natural size of its contents.
    ///
    /// If set to `TRUE`, the label will ellipsize.
    ///
    /// See `gtk.Button.setCanShrink` and
    /// `gtk.MenuButton.setCanShrink`.
    extern fn adw_split_button_set_can_shrink(p_self: *SplitButton, p_can_shrink: c_int) void;
    pub const setCanShrink = adw_split_button_set_can_shrink;

    /// Sets the child widget.
    ///
    /// Setting the child widget will set `SplitButton.properties.label` and
    /// `SplitButton.properties.icon_name` to `NULL`.
    extern fn adw_split_button_set_child(p_self: *SplitButton, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_split_button_set_child;

    /// Sets the direction in which the popup will be popped up.
    ///
    /// The dropdown arrow icon will point at the same direction.
    ///
    /// If the does not fit in the available space in the given direction, GTK will
    /// try its best to keep it inside the screen and fully visible.
    ///
    /// If you pass `GTK_ARROW_NONE`, it's equivalent to `GTK_ARROW_DOWN`.
    extern fn adw_split_button_set_direction(p_self: *SplitButton, p_direction: gtk.ArrowType) void;
    pub const setDirection = adw_split_button_set_direction;

    /// Sets the tooltip of the dropdown button of `self`.
    ///
    /// The tooltip can be marked up with the Pango text markup language.
    extern fn adw_split_button_set_dropdown_tooltip(p_self: *SplitButton, p_tooltip: [*:0]const u8) void;
    pub const setDropdownTooltip = adw_split_button_set_dropdown_tooltip;

    /// Sets the name of the icon used to automatically populate the button.
    ///
    /// Setting the icon name will set `SplitButton.properties.label` and
    /// `SplitButton.properties.child` to `NULL`.
    extern fn adw_split_button_set_icon_name(p_self: *SplitButton, p_icon_name: [*:0]const u8) void;
    pub const setIconName = adw_split_button_set_icon_name;

    /// Sets the label for `self`.
    ///
    /// Setting the label will set `SplitButton.properties.icon_name` and
    /// `SplitButton.properties.child` to `NULL`.
    extern fn adw_split_button_set_label(p_self: *SplitButton, p_label: [*:0]const u8) void;
    pub const setLabel = adw_split_button_set_label;

    /// Sets the menu model from which the popup will be created.
    ///
    /// If the menu model is `NULL`, the dropdown is disabled.
    ///
    /// A `gtk.Popover` will be created from the menu model with
    /// `gtk.PopoverMenu.newFromModel`. Actions will be connected as
    /// documented for this function.
    ///
    /// If `SplitButton.properties.popover` is already set, it will be dissociated from
    /// the button, and the property is set to `NULL`.
    extern fn adw_split_button_set_menu_model(p_self: *SplitButton, p_menu_model: ?*gio.MenuModel) void;
    pub const setMenuModel = adw_split_button_set_menu_model;

    /// Sets the popover that will be popped up when the dropdown is clicked.
    ///
    /// If the popover is `NULL`, the dropdown is disabled.
    ///
    /// If `SplitButton.properties.menu_model` is set, the menu model is dissociated
    /// from the button, and the property is set to `NULL`.
    extern fn adw_split_button_set_popover(p_self: *SplitButton, p_popover: ?*gtk.Popover) void;
    pub const setPopover = adw_split_button_set_popover;

    /// Sets whether an underline in the text indicates a mnemonic.
    ///
    /// See `SplitButton.properties.label`.
    extern fn adw_split_button_set_use_underline(p_self: *SplitButton, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_split_button_set_use_underline;

    extern fn adw_split_button_get_type() usize;
    pub const getGObjectType = adw_split_button_get_type;

    extern fn g_object_ref(p_self: *adw.SplitButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SplitButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SplitButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A spring-based `Animation`.
///
/// `AdwSpringAnimation` implements an animation driven by a physical model of a
/// spring described by `SpringParams`, with a resting position in
/// `SpringAnimation.properties.value_to`, stretched to
/// `SpringAnimation.properties.value_from`.
///
/// Since the animation is physically simulated, spring animations don't have a
/// fixed duration. The animation will stop when the simulated spring comes to a
/// rest - when the amplitude of the oscillations becomes smaller than
/// `SpringAnimation.properties.epsilon`, or immediately when it reaches
/// `SpringAnimation.properties.value_to` if
/// `SpringAnimation.properties.clamp` is set to `TRUE`. The estimated duration can
/// be obtained with `SpringAnimation.properties.estimated_duration`.
///
/// Due to the nature of spring-driven motion the animation can overshoot
/// `SpringAnimation.properties.value_to` before coming to a rest. Whether the
/// animation will overshoot or not depends on the damping ratio of the spring.
/// See `SpringParams` for more information about specific damping ratio
/// values.
///
/// If `SpringAnimation.properties.clamp` is `TRUE`, the animation will abruptly
/// end as soon as it reaches the final value, preventing overshooting.
///
/// Animations can have an initial velocity value, set via
/// `SpringAnimation.properties.initial_velocity`, which adjusts the curve without
/// changing the duration. This makes spring animations useful for deceleration
/// at the end of gestures.
///
/// If the initial and final values are equal, and the initial velocity is not 0,
/// the animation value will bounce and return to its resting position.
pub const SpringAnimation = opaque {
    pub const Parent = adw.Animation;
    pub const Implements = [_]type{};
    pub const Class = adw.SpringAnimationClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the animation should be clamped.
        ///
        /// If set to `TRUE`, the animation will abruptly end as soon as it reaches the
        /// final value, preventing overshooting.
        ///
        /// It won't prevent overshooting `SpringAnimation.properties.value_from` if a
        /// relative negative `SpringAnimation.properties.initial_velocity` is set.
        pub const clamp = struct {
            pub const name = "clamp";

            pub const Type = c_int;
        };

        /// Precision of the spring.
        ///
        /// The level of precision used to determine when the animation has come to a
        /// rest, that is, when the amplitude of the oscillations becomes smaller than
        /// this value.
        ///
        /// If the epsilon value is too small, the animation will take a long time to
        /// stop after the animated value has stopped visibly changing.
        ///
        /// If the epsilon value is too large, the animation will end prematurely.
        ///
        /// The default value is 0.001.
        pub const epsilon = struct {
            pub const name = "epsilon";

            pub const Type = f64;
        };

        /// Estimated duration of the animation, in milliseconds.
        ///
        /// Can be `DURATION_INFINITE` if the spring damping is set to 0.
        pub const estimated_duration = struct {
            pub const name = "estimated-duration";

            pub const Type = c_uint;
        };

        /// The initial velocity to start the animation with.
        ///
        /// Initial velocity affects only the animation curve, but not its duration.
        pub const initial_velocity = struct {
            pub const name = "initial-velocity";

            pub const Type = f64;
        };

        /// Physical parameters describing the spring.
        pub const spring_params = struct {
            pub const name = "spring-params";

            pub const Type = ?*adw.SpringParams;
        };

        /// The value to animate from.
        ///
        /// The animation will start at this value and end at
        /// `SpringAnimation.properties.value_to`.
        pub const value_from = struct {
            pub const name = "value-from";

            pub const Type = f64;
        };

        /// The value to animate to.
        ///
        /// The animation will start at `SpringAnimation.properties.value_from` and end
        /// at this value.
        pub const value_to = struct {
            pub const name = "value-to";

            pub const Type = f64;
        };

        /// Current velocity of the animation.
        pub const velocity = struct {
            pub const name = "velocity";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwSpringAnimation` on `widget`.
    ///
    /// The animation will animate `target` from `from` to `to` with the dynamics of a
    /// spring described by `spring_params`.
    extern fn adw_spring_animation_new(p_widget: *gtk.Widget, p_from: f64, p_to: f64, p_spring_params: *adw.SpringParams, p_target: *adw.AnimationTarget) *adw.SpringAnimation;
    pub const new = adw_spring_animation_new;

    /// Calculates the value `self` will have at `time`.
    ///
    /// The time starts at 0 and ends at
    /// `SpringAnimation.properties.estimated_duration`.
    ///
    /// See also `SpringAnimation.calculateVelocity`.
    extern fn adw_spring_animation_calculate_value(p_self: *SpringAnimation, p_time: c_uint) f64;
    pub const calculateValue = adw_spring_animation_calculate_value;

    /// Calculates the velocity `self` will have at `time`.
    ///
    /// The time starts at 0 and ends at
    /// `SpringAnimation.properties.estimated_duration`.
    ///
    /// See also `SpringAnimation.calculateValue`.
    extern fn adw_spring_animation_calculate_velocity(p_self: *SpringAnimation, p_time: c_uint) f64;
    pub const calculateVelocity = adw_spring_animation_calculate_velocity;

    /// Gets whether `self` should be clamped.
    extern fn adw_spring_animation_get_clamp(p_self: *SpringAnimation) c_int;
    pub const getClamp = adw_spring_animation_get_clamp;

    /// Gets the precision of the spring.
    extern fn adw_spring_animation_get_epsilon(p_self: *SpringAnimation) f64;
    pub const getEpsilon = adw_spring_animation_get_epsilon;

    /// Gets the estimated duration of `self`, in milliseconds.
    ///
    /// Can be `DURATION_INFINITE` if the spring damping is set to 0.
    extern fn adw_spring_animation_get_estimated_duration(p_self: *SpringAnimation) c_uint;
    pub const getEstimatedDuration = adw_spring_animation_get_estimated_duration;

    /// Gets the initial velocity of `self`.
    extern fn adw_spring_animation_get_initial_velocity(p_self: *SpringAnimation) f64;
    pub const getInitialVelocity = adw_spring_animation_get_initial_velocity;

    /// Gets the physical parameters of the spring of `self`.
    extern fn adw_spring_animation_get_spring_params(p_self: *SpringAnimation) *adw.SpringParams;
    pub const getSpringParams = adw_spring_animation_get_spring_params;

    /// Gets the value `self` will animate from.
    extern fn adw_spring_animation_get_value_from(p_self: *SpringAnimation) f64;
    pub const getValueFrom = adw_spring_animation_get_value_from;

    /// Gets the value `self` will animate to.
    extern fn adw_spring_animation_get_value_to(p_self: *SpringAnimation) f64;
    pub const getValueTo = adw_spring_animation_get_value_to;

    /// Gets the current velocity of `self`.
    extern fn adw_spring_animation_get_velocity(p_self: *SpringAnimation) f64;
    pub const getVelocity = adw_spring_animation_get_velocity;

    /// Sets whether `self` should be clamped.
    ///
    /// If set to `TRUE`, the animation will abruptly end as soon as it reaches the
    /// final value, preventing overshooting.
    ///
    /// It won't prevent overshooting `SpringAnimation.properties.value_from` if a
    /// relative negative `SpringAnimation.properties.initial_velocity` is set.
    extern fn adw_spring_animation_set_clamp(p_self: *SpringAnimation, p_clamp: c_int) void;
    pub const setClamp = adw_spring_animation_set_clamp;

    /// Sets the precision of the spring.
    ///
    /// The level of precision used to determine when the animation has come to a
    /// rest, that is, when the amplitude of the oscillations becomes smaller than
    /// this value.
    ///
    /// If the epsilon value is too small, the animation will take a long time to
    /// stop after the animated value has stopped visibly changing.
    ///
    /// If the epsilon value is too large, the animation will end prematurely.
    ///
    /// The default value is 0.001.
    extern fn adw_spring_animation_set_epsilon(p_self: *SpringAnimation, p_epsilon: f64) void;
    pub const setEpsilon = adw_spring_animation_set_epsilon;

    /// Sets the initial velocity of `self`.
    ///
    /// Initial velocity affects only the animation curve, but not its duration.
    extern fn adw_spring_animation_set_initial_velocity(p_self: *SpringAnimation, p_velocity: f64) void;
    pub const setInitialVelocity = adw_spring_animation_set_initial_velocity;

    /// Sets the physical parameters of the spring of `self`.
    extern fn adw_spring_animation_set_spring_params(p_self: *SpringAnimation, p_spring_params: *adw.SpringParams) void;
    pub const setSpringParams = adw_spring_animation_set_spring_params;

    /// Sets the value `self` will animate from.
    ///
    /// The animation will start at this value and end at
    /// `SpringAnimation.properties.value_to`.
    extern fn adw_spring_animation_set_value_from(p_self: *SpringAnimation, p_value: f64) void;
    pub const setValueFrom = adw_spring_animation_set_value_from;

    /// Sets the value `self` will animate to.
    ///
    /// The animation will start at `SpringAnimation.properties.value_from` and end at
    /// this value.
    extern fn adw_spring_animation_set_value_to(p_self: *SpringAnimation, p_value: f64) void;
    pub const setValueTo = adw_spring_animation_set_value_to;

    extern fn adw_spring_animation_get_type() usize;
    pub const getGObjectType = adw_spring_animation_get_type;

    extern fn g_object_ref(p_self: *adw.SpringAnimation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SpringAnimation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SpringAnimation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A best fit container.
///
/// <picture>
///   <source srcset="squeezer-wide-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="squeezer-wide.png" alt="squeezer-wide">
/// </picture>
/// <picture>
///   <source srcset="squeezer-narrow-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="squeezer-narrow.png" alt="squeezer-narrow">
/// </picture>
///
/// The `AdwSqueezer` widget is a container which only shows the first of its
/// children that fits in the available size. It is convenient to offer different
/// widgets to represent the same data with different levels of detail, making
/// the widget seem to squeeze itself to fit in the available space.
///
/// Transitions between children can be animated as fades. This can be controlled
/// with `Squeezer.properties.transition_type`.
///
/// ## CSS nodes
///
/// `AdwSqueezer` has a single CSS node with name `squeezer`.
pub const Squeezer = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.SqueezerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to allow squeezing beyond the last child's minimum size.
        ///
        /// If set to `TRUE`, the squeezer can shrink to the point where no child can
        /// be shown. This is functionally equivalent to appending a widget with 0×0
        /// minimum size.
        pub const allow_none = struct {
            pub const name = "allow-none";

            pub const Type = c_int;
        };

        /// Whether all children have the same size for the opposite orientation.
        ///
        /// For example, if a squeezer is horizontal and is homogeneous, it will
        /// request the same height for all its children. If it isn't, the squeezer may
        /// change size when a different child becomes visible.
        pub const homogeneous = struct {
            pub const name = "homogeneous";

            pub const Type = c_int;
        };

        /// Whether the squeezer interpolates its size when changing the visible child.
        ///
        /// If `TRUE`, the squeezer will interpolate its size between the one of the
        /// previous visible child and the one of the new visible child, according to
        /// the set transition duration and the orientation, e.g. if the squeezer is
        /// horizontal, it will interpolate the its height.
        pub const interpolate_size = struct {
            pub const name = "interpolate-size";

            pub const Type = c_int;
        };

        /// A selection model with the squeezer's pages.
        ///
        /// This can be used to keep an up-to-date view. The model also implements
        /// `gtk.SelectionModel` and can be used to track the visible page.
        pub const pages = struct {
            pub const name = "pages";

            pub const Type = ?*gtk.SelectionModel;
        };

        /// The switch threshold policy.
        ///
        /// Determines when the squeezer will switch children.
        ///
        /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, it will only switch when the
        /// visible child cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`,
        /// it will switch as soon as the visible child doesn't get their natural size.
        ///
        /// This can be useful if you have a long ellipsizing label and want to let it
        /// ellipsize instead of immediately switching.
        pub const switch_threshold_policy = struct {
            pub const name = "switch-threshold-policy";

            pub const Type = adw.FoldThresholdPolicy;
        };

        /// The transition animation duration, in milliseconds.
        pub const transition_duration = struct {
            pub const name = "transition-duration";

            pub const Type = c_uint;
        };

        /// Whether a transition is currently running.
        ///
        /// If a transition is impossible, the property value will be set to `TRUE` and
        /// then immediately to `FALSE`, so it's possible to rely on its notifications
        /// to know that a transition has happened.
        pub const transition_running = struct {
            pub const name = "transition-running";

            pub const Type = c_int;
        };

        /// The type of animation used for transitions between children.
        pub const transition_type = struct {
            pub const name = "transition-type";

            pub const Type = adw.SqueezerTransitionType;
        };

        /// The currently visible child.
        pub const visible_child = struct {
            pub const name = "visible-child";

            pub const Type = ?*gtk.Widget;
        };

        /// The horizontal alignment, from 0 (start) to 1 (end).
        ///
        /// This affects the children allocation during transitions, when they exceed
        /// the size of the squeezer.
        ///
        /// For example, 0.5 means the child will be centered, 0 means it will keep the
        /// start side aligned and overflow the end side, and 1 means the opposite.
        pub const xalign = struct {
            pub const name = "xalign";

            pub const Type = f32;
        };

        /// The vertical alignment, from 0 (top) to 1 (bottom).
        ///
        /// This affects the children allocation during transitions, when they exceed
        /// the size of the squeezer.
        ///
        /// For example, 0.5 means the child will be centered, 0 means it will keep the
        /// top side aligned and overflow the bottom side, and 1 means the opposite.
        pub const yalign = struct {
            pub const name = "yalign";

            pub const Type = f32;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwSqueezer`.
    extern fn adw_squeezer_new() *adw.Squeezer;
    pub const new = adw_squeezer_new;

    /// Adds a child to `self`.
    extern fn adw_squeezer_add(p_self: *Squeezer, p_child: *gtk.Widget) *adw.SqueezerPage;
    pub const add = adw_squeezer_add;

    /// Gets whether to allow squeezing beyond the last child's minimum size.
    extern fn adw_squeezer_get_allow_none(p_self: *Squeezer) c_int;
    pub const getAllowNone = adw_squeezer_get_allow_none;

    /// Gets whether all children have the same size for the opposite orientation.
    extern fn adw_squeezer_get_homogeneous(p_self: *Squeezer) c_int;
    pub const getHomogeneous = adw_squeezer_get_homogeneous;

    /// Gets whether `self` interpolates its size when changing the visible child.
    extern fn adw_squeezer_get_interpolate_size(p_self: *Squeezer) c_int;
    pub const getInterpolateSize = adw_squeezer_get_interpolate_size;

    /// Returns the `SqueezerPage` object for `child`.
    extern fn adw_squeezer_get_page(p_self: *Squeezer, p_child: *gtk.Widget) *adw.SqueezerPage;
    pub const getPage = adw_squeezer_get_page;

    /// Returns a `gio.ListModel` that contains the pages of `self`.
    ///
    /// This can be used to keep an up-to-date view. The model also implements
    /// `gtk.SelectionModel` and can be used to track the visible page.
    extern fn adw_squeezer_get_pages(p_self: *Squeezer) *gtk.SelectionModel;
    pub const getPages = adw_squeezer_get_pages;

    /// Gets the switch threshold policy for `self`.
    extern fn adw_squeezer_get_switch_threshold_policy(p_self: *Squeezer) adw.FoldThresholdPolicy;
    pub const getSwitchThresholdPolicy = adw_squeezer_get_switch_threshold_policy;

    /// Gets the transition animation duration for `self`.
    extern fn adw_squeezer_get_transition_duration(p_self: *Squeezer) c_uint;
    pub const getTransitionDuration = adw_squeezer_get_transition_duration;

    /// Gets whether a transition is currently running for `self`.
    ///
    /// If a transition is impossible, the property value will be set to `TRUE` and
    /// then immediately to `FALSE`, so it's possible to rely on its notifications
    /// to know that a transition has happened.
    extern fn adw_squeezer_get_transition_running(p_self: *Squeezer) c_int;
    pub const getTransitionRunning = adw_squeezer_get_transition_running;

    /// Gets the type of animation used for transitions between children in `self`.
    extern fn adw_squeezer_get_transition_type(p_self: *Squeezer) adw.SqueezerTransitionType;
    pub const getTransitionType = adw_squeezer_get_transition_type;

    /// Gets the currently visible child of `self`.
    extern fn adw_squeezer_get_visible_child(p_self: *Squeezer) ?*gtk.Widget;
    pub const getVisibleChild = adw_squeezer_get_visible_child;

    /// Gets the horizontal alignment, from 0 (start) to 1 (end).
    extern fn adw_squeezer_get_xalign(p_self: *Squeezer) f32;
    pub const getXalign = adw_squeezer_get_xalign;

    /// Gets the vertical alignment, from 0 (top) to 1 (bottom).
    extern fn adw_squeezer_get_yalign(p_self: *Squeezer) f32;
    pub const getYalign = adw_squeezer_get_yalign;

    /// Removes a child widget from `self`.
    extern fn adw_squeezer_remove(p_self: *Squeezer, p_child: *gtk.Widget) void;
    pub const remove = adw_squeezer_remove;

    /// Sets whether to allow squeezing beyond the last child's minimum size.
    ///
    /// If set to `TRUE`, the squeezer can shrink to the point where no child can be
    /// shown. This is functionally equivalent to appending a widget with 0×0 minimum
    /// size.
    extern fn adw_squeezer_set_allow_none(p_self: *Squeezer, p_allow_none: c_int) void;
    pub const setAllowNone = adw_squeezer_set_allow_none;

    /// Sets whether all children have the same size for the opposite orientation.
    ///
    /// For example, if a squeezer is horizontal and is homogeneous, it will request
    /// the same height for all its children. If it isn't, the squeezer may change
    /// size when a different child becomes visible.
    extern fn adw_squeezer_set_homogeneous(p_self: *Squeezer, p_homogeneous: c_int) void;
    pub const setHomogeneous = adw_squeezer_set_homogeneous;

    /// Sets whether `self` interpolates its size when changing the visible child.
    ///
    /// If `TRUE`, the squeezer will interpolate its size between the one of the
    /// previous visible child and the one of the new visible child, according to the
    /// set transition duration and the orientation, e.g. if the squeezer is
    /// horizontal, it will interpolate the its height.
    extern fn adw_squeezer_set_interpolate_size(p_self: *Squeezer, p_interpolate_size: c_int) void;
    pub const setInterpolateSize = adw_squeezer_set_interpolate_size;

    /// Sets the switch threshold policy for `self`.
    ///
    /// Determines when the squeezer will switch children.
    ///
    /// If set to `ADW_FOLD_THRESHOLD_POLICY_MINIMUM`, it will only switch when the
    /// visible child cannot fit anymore. With `ADW_FOLD_THRESHOLD_POLICY_NATURAL`,
    /// it will switch as soon as the visible child doesn't get their natural size.
    ///
    /// This can be useful if you have a long ellipsizing label and want to let it
    /// ellipsize instead of immediately switching.
    extern fn adw_squeezer_set_switch_threshold_policy(p_self: *Squeezer, p_policy: adw.FoldThresholdPolicy) void;
    pub const setSwitchThresholdPolicy = adw_squeezer_set_switch_threshold_policy;

    /// Sets the transition animation duration for `self`.
    extern fn adw_squeezer_set_transition_duration(p_self: *Squeezer, p_duration: c_uint) void;
    pub const setTransitionDuration = adw_squeezer_set_transition_duration;

    /// Sets the type of animation used for transitions between children in `self`.
    extern fn adw_squeezer_set_transition_type(p_self: *Squeezer, p_transition: adw.SqueezerTransitionType) void;
    pub const setTransitionType = adw_squeezer_set_transition_type;

    /// Sets the horizontal alignment, from 0 (start) to 1 (end).
    ///
    /// This affects the children allocation during transitions, when they exceed the
    /// size of the squeezer.
    ///
    /// For example, 0.5 means the child will be centered, 0 means it will keep the
    /// start side aligned and overflow the end side, and 1 means the opposite.
    extern fn adw_squeezer_set_xalign(p_self: *Squeezer, p_xalign: f32) void;
    pub const setXalign = adw_squeezer_set_xalign;

    /// Sets the vertical alignment, from 0 (top) to 1 (bottom).
    ///
    /// This affects the children allocation during transitions, when they exceed the
    /// size of the squeezer.
    ///
    /// For example, 0.5 means the child will be centered, 0 means it will keep the
    /// top side aligned and overflow the bottom side, and 1 means the opposite.
    extern fn adw_squeezer_set_yalign(p_self: *Squeezer, p_yalign: f32) void;
    pub const setYalign = adw_squeezer_set_yalign;

    extern fn adw_squeezer_get_type() usize;
    pub const getGObjectType = adw_squeezer_get_type;

    extern fn g_object_ref(p_self: *adw.Squeezer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Squeezer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Squeezer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An auxiliary class used by `Squeezer`.
pub const SqueezerPage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.SqueezerPageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The the squeezer child to which the page belongs.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the child is enabled.
        ///
        /// If a child is disabled, it will be ignored when looking for the child
        /// fitting the available size best.
        ///
        /// This allows to programmatically and prematurely hide a child even if it
        /// fits in the available space.
        ///
        /// This can be used e.g. to ensure a certain child is hidden below a certain
        /// window width, or any other constraint you find suitable.
        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns the squeezer child to which `self` belongs.
    extern fn adw_squeezer_page_get_child(p_self: *SqueezerPage) *gtk.Widget;
    pub const getChild = adw_squeezer_page_get_child;

    /// Gets whether `self` is enabled.
    extern fn adw_squeezer_page_get_enabled(p_self: *SqueezerPage) c_int;
    pub const getEnabled = adw_squeezer_page_get_enabled;

    /// Sets whether `self` is enabled.
    ///
    /// If a child is disabled, it will be ignored when looking for the child
    /// fitting the available size best.
    ///
    /// This allows to programmatically and prematurely hide a child even if it fits
    /// in the available space.
    ///
    /// This can be used e.g. to ensure a certain child is hidden below a certain
    /// window width, or any other constraint you find suitable.
    extern fn adw_squeezer_page_set_enabled(p_self: *SqueezerPage, p_enabled: c_int) void;
    pub const setEnabled = adw_squeezer_page_set_enabled;

    extern fn adw_squeezer_page_get_type() usize;
    pub const getGObjectType = adw_squeezer_page_get_type;

    extern fn g_object_ref(p_self: *adw.SqueezerPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SqueezerPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SqueezerPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A page used for empty/error states and similar use-cases.
///
/// <picture>
///   <source srcset="status-page-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="status-page.png" alt="status-page">
/// </picture>
///
/// The `AdwStatusPage` widget can have an icon, a title, a description and a
/// custom widget which is displayed below them.
///
/// ## CSS nodes
///
/// `AdwStatusPage` has a main CSS node with name `statuspage`.
///
/// When setting an `SpinnerPaintable` as `StatusPage.properties.paintable`,
/// the main nodes gains the `.spinner` style class for a more compact
/// appearance.
///
/// ## Style classes
///
/// `AdwStatusPage` can use the
/// [`.compact`](style-classes.html`compact`-status-page) style class for when it
/// needs to fit into a small space such a sidebar or a popover, similar to when
/// using a spinner as the paintable.
///
/// <picture>
///   <source srcset="status-page-compact-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="status-page-compact.png" alt="status-page-compact">
/// </picture>
pub const StatusPage = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.StatusPageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The description markup to be displayed below the title.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the icon to be used.
        ///
        /// Changing this will set `StatusPage.properties.paintable` to `NULL`.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The paintable to be used.
        ///
        /// Changing this will set `StatusPage.properties.icon_name` to `NULL`.
        pub const paintable = struct {
            pub const name = "paintable";

            pub const Type = ?*gdk.Paintable;
        };

        /// The title to be displayed below the icon.
        ///
        /// It is not parsed as Pango markup.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwStatusPage`.
    extern fn adw_status_page_new() *adw.StatusPage;
    pub const new = adw_status_page_new;

    /// Gets the child widget of `self`.
    extern fn adw_status_page_get_child(p_self: *StatusPage) ?*gtk.Widget;
    pub const getChild = adw_status_page_get_child;

    /// Gets the description markup for `self`.
    extern fn adw_status_page_get_description(p_self: *StatusPage) ?[*:0]const u8;
    pub const getDescription = adw_status_page_get_description;

    /// Gets the icon name for `self`.
    extern fn adw_status_page_get_icon_name(p_self: *StatusPage) ?[*:0]const u8;
    pub const getIconName = adw_status_page_get_icon_name;

    /// Gets the paintable for `self`.
    extern fn adw_status_page_get_paintable(p_self: *StatusPage) ?*gdk.Paintable;
    pub const getPaintable = adw_status_page_get_paintable;

    /// Gets the title for `self`.
    extern fn adw_status_page_get_title(p_self: *StatusPage) [*:0]const u8;
    pub const getTitle = adw_status_page_get_title;

    /// Sets the child widget of `self`.
    extern fn adw_status_page_set_child(p_self: *StatusPage, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_status_page_set_child;

    /// Sets the description markup for `self`.
    ///
    /// The description is displayed below the title. It is parsed as Pango markup.
    extern fn adw_status_page_set_description(p_self: *StatusPage, p_description: ?[*:0]const u8) void;
    pub const setDescription = adw_status_page_set_description;

    /// Sets the icon name for `self`.
    ///
    /// Changing this will set `StatusPage.properties.paintable` to `NULL`.
    extern fn adw_status_page_set_icon_name(p_self: *StatusPage, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_status_page_set_icon_name;

    /// Sets the paintable for `self`.
    ///
    /// Changing this will set `StatusPage.properties.icon_name` to `NULL`.
    extern fn adw_status_page_set_paintable(p_self: *StatusPage, p_paintable: ?*gdk.Paintable) void;
    pub const setPaintable = adw_status_page_set_paintable;

    /// Sets the title for `self`.
    ///
    /// The title is displayed below the icon. It is not parsed as Pango markup.
    extern fn adw_status_page_set_title(p_self: *StatusPage, p_title: [*:0]const u8) void;
    pub const setTitle = adw_status_page_set_title;

    extern fn adw_status_page_get_type() usize;
    pub const getGObjectType = adw_status_page_get_type;

    extern fn g_object_ref(p_self: *adw.StatusPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.StatusPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StatusPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A class for managing application-wide styling.
///
/// `AdwStyleManager` provides a way to query and influence the application
/// styles, such as whether to use dark style, the system accent color or high
/// contrast appearance.
///
/// It allows to set the color scheme via the
/// `StyleManager.properties.color_scheme` property, and to query the current
/// appearance, as well as whether a system-wide color scheme and accent color
/// preferences exists.
pub const StyleManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.StyleManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The current system accent color.
        ///
        /// See also `StyleManager.properties.accent_color_rgba`.
        pub const accent_color = struct {
            pub const name = "accent-color";

            pub const Type = adw.AccentColor;
        };

        /// The current system accent color as a `GdkRGBA`.
        ///
        /// Equivalent to calling `AccentColor.toRgba` on the value of
        /// `StyleManager.properties.accent_color`.
        ///
        /// This is a background color. The matching foreground color is white.
        pub const accent_color_rgba = struct {
            pub const name = "accent-color-rgba";

            pub const Type = ?*gdk.RGBA;
        };

        /// The requested application color scheme.
        ///
        /// The effective appearance will be decided based on the application color
        /// scheme and the system preferred color scheme. The
        /// `StyleManager.properties.dark` property can be used to query the current
        /// effective appearance.
        ///
        /// The `ADW_COLOR_SCHEME_PREFER_LIGHT` color scheme results in the application
        /// using light appearance unless the system prefers dark colors. This is the
        /// default value.
        ///
        /// The `ADW_COLOR_SCHEME_PREFER_DARK` color scheme results in the application
        /// using dark appearance, but can still switch to the light appearance if the
        /// system can prefers it, for example, when the high contrast preference is
        /// enabled.
        ///
        /// The `ADW_COLOR_SCHEME_FORCE_LIGHT` and `ADW_COLOR_SCHEME_FORCE_DARK` values
        /// ignore the system preference entirely. They are useful if the application
        /// wants to match its UI to its content or to provide a separate color scheme
        /// switcher.
        ///
        /// If a per-`gdk.Display` style manager has its color scheme set to
        /// `ADW_COLOR_SCHEME_DEFAULT`, it will inherit the color scheme from the
        /// default style manager.
        ///
        /// For the default style manager, `ADW_COLOR_SCHEME_DEFAULT` is equivalent to
        /// `ADW_COLOR_SCHEME_PREFER_LIGHT`.
        ///
        /// The `StyleManager.properties.system_supports_color_schemes` property can be
        /// used to check if the current environment provides a color scheme
        /// preference.
        pub const color_scheme = struct {
            pub const name = "color-scheme";

            pub const Type = adw.ColorScheme;
        };

        /// Whether the application is using dark appearance.
        ///
        /// This property can be used to query the current appearance, as requested via
        /// `StyleManager.properties.color_scheme`.
        pub const dark = struct {
            pub const name = "dark";

            pub const Type = c_int;
        };

        /// The display the style manager is associated with.
        ///
        /// The display will be `NULL` for the style manager returned by
        /// `StyleManager.getDefault`.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The system document font.
        ///
        /// The font is in the same format as `gtk.Settings.properties.gtk_font_name`,
        /// e.g. "Adwaita Sans 11".
        ///
        /// Use `pango.FontDescription.fromString` to parse it.
        pub const document_font_name = struct {
            pub const name = "document-font-name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the application is using high contrast appearance.
        ///
        /// This cannot be overridden by applications.
        pub const high_contrast = struct {
            pub const name = "high-contrast";

            pub const Type = c_int;
        };

        /// The system monospace font.
        ///
        /// The font is in the same format as `gtk.Settings.properties.gtk_font_name`,
        /// e.g. "Adwaita Mono 11".
        ///
        /// Use `pango.FontDescription.fromString` to parse it.
        pub const monospace_font_name = struct {
            pub const name = "monospace-font-name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the system supports accent colors.
        ///
        /// This property can be used to check if the current environment provides an
        /// accent color preference. For example, applications might want to show a
        /// preference for choosing accent color if it's set to `FALSE`.
        ///
        /// See `StyleManager.properties.accent_color`.
        pub const system_supports_accent_colors = struct {
            pub const name = "system-supports-accent-colors";

            pub const Type = c_int;
        };

        /// Whether the system supports color schemes.
        ///
        /// This property can be used to check if the current environment provides a
        /// color scheme preference. For example, applications might want to show a
        /// separate appearance switcher if it's set to `FALSE`.
        ///
        /// See `StyleManager.properties.color_scheme`.
        pub const system_supports_color_schemes = struct {
            pub const name = "system-supports-color-schemes";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Gets the default `AdwStyleManager` instance.
    ///
    /// It manages all `gdk.Display` instances unless the style manager for
    /// that display has an override.
    ///
    /// See `StyleManager.getForDisplay`.
    extern fn adw_style_manager_get_default() *adw.StyleManager;
    pub const getDefault = adw_style_manager_get_default;

    /// Gets the `AdwStyleManager` instance managing `display`.
    ///
    /// It can be used to override styles for that specific display instead of the
    /// whole application.
    ///
    /// Most applications should use `StyleManager.getDefault` instead.
    extern fn adw_style_manager_get_for_display(p_display: *gdk.Display) *adw.StyleManager;
    pub const getForDisplay = adw_style_manager_get_for_display;

    /// Gets the current system accent color.
    ///
    /// See also `StyleManager.properties.accent_color_rgba`.
    extern fn adw_style_manager_get_accent_color(p_self: *StyleManager) adw.AccentColor;
    pub const getAccentColor = adw_style_manager_get_accent_color;

    /// Gets the current system accent color as a `GdkRGBA`.
    ///
    /// Equivalent to calling `AccentColor.toRgba` on the value of
    /// `StyleManager.properties.accent_color`.
    ///
    /// This is a background color. The matching foreground color is white.
    extern fn adw_style_manager_get_accent_color_rgba(p_self: *StyleManager) *gdk.RGBA;
    pub const getAccentColorRgba = adw_style_manager_get_accent_color_rgba;

    /// Gets the requested application color scheme.
    extern fn adw_style_manager_get_color_scheme(p_self: *StyleManager) adw.ColorScheme;
    pub const getColorScheme = adw_style_manager_get_color_scheme;

    /// Gets whether the application is using dark appearance.
    ///
    /// This can be used to query the current appearance, as requested via
    /// `StyleManager.properties.color_scheme`.
    extern fn adw_style_manager_get_dark(p_self: *StyleManager) c_int;
    pub const getDark = adw_style_manager_get_dark;

    /// Gets the display the style manager is associated with.
    ///
    /// The display will be `NULL` for the style manager returned by
    /// `StyleManager.getDefault`.
    extern fn adw_style_manager_get_display(p_self: *StyleManager) ?*gdk.Display;
    pub const getDisplay = adw_style_manager_get_display;

    /// Gets the system document font.
    ///
    /// The font is in the same format as `gtk.Settings.properties.gtk_font_name`,
    /// e.g. "Adwaita Sans 11".
    ///
    /// Use `pango.FontDescription.fromString` to parse it.
    extern fn adw_style_manager_get_document_font_name(p_self: *StyleManager) [*:0]const u8;
    pub const getDocumentFontName = adw_style_manager_get_document_font_name;

    /// Gets whether the application is using high contrast appearance.
    ///
    /// This cannot be overridden by applications.
    extern fn adw_style_manager_get_high_contrast(p_self: *StyleManager) c_int;
    pub const getHighContrast = adw_style_manager_get_high_contrast;

    /// Gets the system monospace font.
    ///
    /// The font is in the same format as `gtk.Settings.properties.gtk_font_name`,
    /// e.g. "Adwaita Mono 11".
    ///
    /// Use `pango.FontDescription.fromString` to parse it.
    extern fn adw_style_manager_get_monospace_font_name(p_self: *StyleManager) [*:0]const u8;
    pub const getMonospaceFontName = adw_style_manager_get_monospace_font_name;

    /// Gets whether the system supports accent colors.
    ///
    /// This can be used to check if the current environment provides an accent color
    /// preference. For example, applications might want to show a preference for
    /// choosing accent color if it's set to `FALSE`.
    ///
    /// See `StyleManager.properties.accent_color`.
    extern fn adw_style_manager_get_system_supports_accent_colors(p_self: *StyleManager) c_int;
    pub const getSystemSupportsAccentColors = adw_style_manager_get_system_supports_accent_colors;

    /// Gets whether the system supports color schemes.
    ///
    /// This can be used to check if the current environment provides a color scheme
    /// preference. For example, applications might want to show a separate
    /// appearance switcher if it's set to `FALSE`.
    extern fn adw_style_manager_get_system_supports_color_schemes(p_self: *StyleManager) c_int;
    pub const getSystemSupportsColorSchemes = adw_style_manager_get_system_supports_color_schemes;

    /// Sets the requested application color scheme.
    ///
    /// The effective appearance will be decided based on the application color
    /// scheme and the system preferred color scheme. The
    /// `StyleManager.properties.dark` property can be used to query the current
    /// effective appearance.
    ///
    /// The `ADW_COLOR_SCHEME_PREFER_LIGHT` color scheme results in the application
    /// using light appearance unless the system prefers dark colors. This is the
    /// default value.
    ///
    /// The `ADW_COLOR_SCHEME_PREFER_DARK` color scheme results in the application
    /// using dark appearance, but can still switch to the light appearance if the
    /// system can prefers it, for example, when the high contrast preference is
    /// enabled.
    ///
    /// The `ADW_COLOR_SCHEME_FORCE_LIGHT` and `ADW_COLOR_SCHEME_FORCE_DARK` values
    /// ignore the system preference entirely. They are useful if the application
    /// wants to match its UI to its content or to provide a separate color scheme
    /// switcher.
    ///
    /// If a per-`gdk.Display` style manager has its color scheme set to
    /// `ADW_COLOR_SCHEME_DEFAULT`, it will inherit the color scheme from the
    /// default style manager.
    ///
    /// For the default style manager, `ADW_COLOR_SCHEME_DEFAULT` is equivalent to
    /// `ADW_COLOR_SCHEME_PREFER_LIGHT`.
    ///
    /// The `StyleManager.properties.system_supports_color_schemes` property can be
    /// used to check if the current environment provides a color scheme
    /// preference.
    extern fn adw_style_manager_set_color_scheme(p_self: *StyleManager, p_color_scheme: adw.ColorScheme) void;
    pub const setColorScheme = adw_style_manager_set_color_scheme;

    extern fn adw_style_manager_get_type() usize;
    pub const getGObjectType = adw_style_manager_get_type;

    extern fn g_object_ref(p_self: *adw.StyleManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.StyleManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StyleManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A swipe tracker used in `Carousel`, `NavigationView` and
/// `OverlaySplitView`.
///
/// The `AdwSwipeTracker` object can be used for implementing widgets with swipe
/// gestures. It supports touch-based swipes, pointer dragging, and touchpad
/// scrolling.
///
/// The widgets will probably want to expose the `SwipeTracker.properties.enabled`
/// property. If they expect to use horizontal orientation,
/// `SwipeTracker.properties.reversed` can be used for supporting RTL text
/// direction.
pub const SwipeTracker = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.Orientable};
    pub const Class = adw.SwipeTrackerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to allow swiping for more than one snap point at a time.
        ///
        /// If the value is `FALSE`, each swipe can only move to the adjacent snap
        /// points.
        pub const allow_long_swipes = struct {
            pub const name = "allow-long-swipes";

            pub const Type = c_int;
        };

        /// Whether to allow dragging with mouse pointer.
        pub const allow_mouse_drag = struct {
            pub const name = "allow-mouse-drag";

            pub const Type = c_int;
        };

        /// Whether to allow touchscreen swiping from `GtkWindowHandle`.
        ///
        /// This will make dragging the window impossible.
        pub const allow_window_handle = struct {
            pub const name = "allow-window-handle";

            pub const Type = c_int;
        };

        /// Whether the swipe tracker is enabled.
        ///
        /// When it's not enabled, no events will be processed. Usually widgets will
        /// want to expose this via a property.
        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };

        /// Whether to allow swiping past the first available snap point.
        pub const lower_overshoot = struct {
            pub const name = "lower-overshoot";

            pub const Type = c_int;
        };

        /// Whether to reverse the swipe direction.
        ///
        /// If the swipe tracker is horizontal, it can be used for supporting RTL text
        /// direction.
        pub const reversed = struct {
            pub const name = "reversed";

            pub const Type = c_int;
        };

        /// The widget the swipe tracker is attached to.
        pub const swipeable = struct {
            pub const name = "swipeable";

            pub const Type = ?*adw.Swipeable;
        };

        /// Whether to allow swiping past the last available snap point.
        pub const upper_overshoot = struct {
            pub const name = "upper-overshoot";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// This signal is emitted right before a swipe will be started, after the
        /// drag threshold has been passed.
        pub const begin_swipe = struct {
            pub const name = "begin-swipe";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SwipeTracker, p_instance))),
                    gobject.signalLookup("begin-swipe", SwipeTracker.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted as soon as the gesture has stopped.
        ///
        /// The user is expected to animate the deceleration from the current progress
        /// value to `to` with an animation using `velocity` as the initial velocity,
        /// provided in pixels per second. `SpringAnimation` is usually a good
        /// fit for this.
        pub const end_swipe = struct {
            pub const name = "end-swipe";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_velocity: f64, p_to: f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SwipeTracker, p_instance))),
                    gobject.signalLookup("end-swipe", SwipeTracker.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when a possible swipe is detected.
        ///
        /// The `direction` value can be used to restrict the swipe to a certain
        /// direction.
        pub const prepare = struct {
            pub const name = "prepare";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_direction: adw.NavigationDirection, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SwipeTracker, p_instance))),
                    gobject.signalLookup("prepare", SwipeTracker.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted every time the progress value changes.
        pub const update_swipe = struct {
            pub const name = "update-swipe";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_progress: f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SwipeTracker, p_instance))),
                    gobject.signalLookup("update-swipe", SwipeTracker.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwSwipeTracker` for `widget`.
    extern fn adw_swipe_tracker_new(p_swipeable: *adw.Swipeable) *adw.SwipeTracker;
    pub const new = adw_swipe_tracker_new;

    /// Gets whether to allow swiping for more than one snap point at a time.
    extern fn adw_swipe_tracker_get_allow_long_swipes(p_self: *SwipeTracker) c_int;
    pub const getAllowLongSwipes = adw_swipe_tracker_get_allow_long_swipes;

    /// Gets whether `self` can be dragged with mouse pointer.
    extern fn adw_swipe_tracker_get_allow_mouse_drag(p_self: *SwipeTracker) c_int;
    pub const getAllowMouseDrag = adw_swipe_tracker_get_allow_mouse_drag;

    /// Gets whether to allow touchscreen swiping from `GtkWindowHandle`.
    extern fn adw_swipe_tracker_get_allow_window_handle(p_self: *SwipeTracker) c_int;
    pub const getAllowWindowHandle = adw_swipe_tracker_get_allow_window_handle;

    /// Gets whether `self` is enabled.
    extern fn adw_swipe_tracker_get_enabled(p_self: *SwipeTracker) c_int;
    pub const getEnabled = adw_swipe_tracker_get_enabled;

    /// Gets whether to allow swiping past the first available snap point.
    extern fn adw_swipe_tracker_get_lower_overshoot(p_self: *SwipeTracker) c_int;
    pub const getLowerOvershoot = adw_swipe_tracker_get_lower_overshoot;

    /// Gets whether `self` is reversing the swipe direction.
    extern fn adw_swipe_tracker_get_reversed(p_self: *SwipeTracker) c_int;
    pub const getReversed = adw_swipe_tracker_get_reversed;

    /// Get the widget `self` is attached to.
    extern fn adw_swipe_tracker_get_swipeable(p_self: *SwipeTracker) *adw.Swipeable;
    pub const getSwipeable = adw_swipe_tracker_get_swipeable;

    /// Gets whether to allow swiping past the last available snap point.
    extern fn adw_swipe_tracker_get_upper_overshoot(p_self: *SwipeTracker) c_int;
    pub const getUpperOvershoot = adw_swipe_tracker_get_upper_overshoot;

    /// Sets whether to allow swiping for more than one snap point at a time.
    ///
    /// If the value is `FALSE`, each swipe can only move to the adjacent snap
    /// points.
    extern fn adw_swipe_tracker_set_allow_long_swipes(p_self: *SwipeTracker, p_allow_long_swipes: c_int) void;
    pub const setAllowLongSwipes = adw_swipe_tracker_set_allow_long_swipes;

    /// Sets whether `self` can be dragged with mouse pointer.
    extern fn adw_swipe_tracker_set_allow_mouse_drag(p_self: *SwipeTracker, p_allow_mouse_drag: c_int) void;
    pub const setAllowMouseDrag = adw_swipe_tracker_set_allow_mouse_drag;

    /// Sets whether to allow touchscreen swiping from `GtkWindowHandle`.
    ///
    /// Setting it to `TRUE` will make dragging the window impossible.
    extern fn adw_swipe_tracker_set_allow_window_handle(p_self: *SwipeTracker, p_allow_window_handle: c_int) void;
    pub const setAllowWindowHandle = adw_swipe_tracker_set_allow_window_handle;

    /// Sets whether `self` is enabled.
    ///
    /// When it's not enabled, no events will be processed. Usually widgets will want
    /// to expose this via a property.
    extern fn adw_swipe_tracker_set_enabled(p_self: *SwipeTracker, p_enabled: c_int) void;
    pub const setEnabled = adw_swipe_tracker_set_enabled;

    /// Sets whether to allow swiping past the first available snap point.
    extern fn adw_swipe_tracker_set_lower_overshoot(p_self: *SwipeTracker, p_overshoot: c_int) void;
    pub const setLowerOvershoot = adw_swipe_tracker_set_lower_overshoot;

    /// Sets whether to reverse the swipe direction.
    ///
    /// If the swipe tracker is horizontal, it can be used for supporting RTL text
    /// direction.
    extern fn adw_swipe_tracker_set_reversed(p_self: *SwipeTracker, p_reversed: c_int) void;
    pub const setReversed = adw_swipe_tracker_set_reversed;

    /// Sets whether to allow swiping past the last available snap point.
    extern fn adw_swipe_tracker_set_upper_overshoot(p_self: *SwipeTracker, p_overshoot: c_int) void;
    pub const setUpperOvershoot = adw_swipe_tracker_set_upper_overshoot;

    /// Moves the current progress value by `delta`.
    ///
    /// This can be used to adjust the current position if snap points move during
    /// the gesture.
    extern fn adw_swipe_tracker_shift_position(p_self: *SwipeTracker, p_delta: f64) void;
    pub const shiftPosition = adw_swipe_tracker_shift_position;

    extern fn adw_swipe_tracker_get_type() usize;
    pub const getGObjectType = adw_swipe_tracker_get_type;

    extern fn g_object_ref(p_self: *adw.SwipeTracker) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SwipeTracker) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SwipeTracker, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListBoxRow` used to represent two states.
///
/// <picture>
///   <source srcset="switch-row-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="switch-row.png" alt="switch-row">
/// </picture>
///
/// The `AdwSwitchRow` widget contains a `gtk.Switch` that allows the user
/// to select between two states: "on" or "off". When activated, the row will
/// invert its active state.
///
/// The user can control the switch by activating the row or by dragging on the
/// switch handle.
///
/// See `gtk.Switch` for details.
///
/// Example of an `AdwSwitchRow` UI definition:
/// ```xml
/// <object class="AdwSwitchRow">
///   <property name="title" translatable="yes">Switch Row</property>
///   <signal name="notify::active" handler="switch_row_notify_active_cb"/>
/// </object>
/// ```
///
/// The `SwitchRow.properties.active` property should be connected to in order to
/// monitor changes to the active state.
///
/// ## Accessibility
///
/// `AdwSwitchRow` uses the `GTK_ACCESSIBLE_ROLE_SWITCH` role.
pub const SwitchRow = opaque {
    pub const Parent = adw.ActionRow;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.SwitchRowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the switch row is in the "on" or "off" position.
        pub const active = struct {
            pub const name = "active";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwSwitchRow`.
    extern fn adw_switch_row_new() *adw.SwitchRow;
    pub const new = adw_switch_row_new;

    /// Gets whether `self` is in its "on" or "off" position.
    extern fn adw_switch_row_get_active(p_self: *SwitchRow) c_int;
    pub const getActive = adw_switch_row_get_active;

    /// Sets whether `self` is in its "on" or "off" position
    extern fn adw_switch_row_set_active(p_self: *SwitchRow, p_is_active: c_int) void;
    pub const setActive = adw_switch_row_set_active;

    extern fn adw_switch_row_get_type() usize;
    pub const getGObjectType = adw_switch_row_get_type;

    extern fn g_object_ref(p_self: *adw.SwitchRow) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.SwitchRow) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SwitchRow, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A tab bar for `TabView`.
///
/// <picture>
///   <source srcset="tab-bar-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="tab-bar.png" alt="tab-bar">
/// </picture>
///
/// The `AdwTabBar` widget is a tab bar that can be used with conjunction with
/// `AdwTabView`. It is typically used as a top bar within `ToolbarView`.
///
/// `AdwTabBar` can autohide and can optionally contain action widgets on both
/// sides of the tabs.
///
/// When there's not enough space to show all the tabs, `AdwTabBar` will scroll
/// them. Pinned tabs always stay visible and aren't a part of the scrollable
/// area.
///
/// ## CSS nodes
///
/// `AdwTabBar` has a single CSS node with name `tabbar`.
///
/// ## Style classes
///
/// By default `AdwTabBar` look like a part of an `AdwHeaderBar` and is intended
/// to be used directly attached to one or used as a `ToolbarView` toolbar.
/// The [`.inline`](style-classes.html`@"inline"`) style class removes its background,
/// so that it can be used in different contexts instead.
///
/// <picture>
///   <source srcset="tab-bar-inline-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="tab-bar-inline.png" alt="tab-bar-inline">
/// </picture>
pub const TabBar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.TabBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the tabs automatically hide.
        ///
        /// If set to `TRUE`, the tab bar disappears when `TabBar.properties.view` has 0
        /// or 1 tab, no pinned tabs, and no tab is being transferred.
        ///
        /// See `TabBar.properties.tabs_revealed`.
        pub const autohide = struct {
            pub const name = "autohide";

            pub const Type = c_int;
        };

        /// The widget shown after the tabs.
        pub const end_action_widget = struct {
            pub const name = "end-action-widget";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether tabs expand to full width.
        ///
        /// If set to `TRUE`, the tabs will always vary width filling the whole width
        /// when possible, otherwise tabs will always have the minimum possible size.
        pub const expand_tabs = struct {
            pub const name = "expand-tabs";

            pub const Type = c_int;
        };

        /// The unique action on the `current-drop` of the
        /// `TabBar.signals.extra_drag_drop`.
        ///
        /// This property should only be used during a `TabBar.signals.extra_drag_drop`
        /// and is always a subset of what was originally passed to
        /// `TabBar.setupExtraDropTarget`.
        pub const extra_drag_preferred_action = struct {
            pub const name = "extra-drag-preferred-action";

            pub const Type = gdk.DragAction;
        };

        /// Whether the drop data should be preloaded on hover.
        ///
        /// See `gtk.DropTarget.properties.preload`.
        pub const extra_drag_preload = struct {
            pub const name = "extra-drag-preload";

            pub const Type = c_int;
        };

        /// Whether tabs use inverted layout.
        ///
        /// If set to `TRUE`, non-pinned tabs will have the close button at the
        /// beginning and the indicator at the end rather than the opposite.
        pub const inverted = struct {
            pub const name = "inverted";

            pub const Type = c_int;
        };

        /// Whether the tab bar is overflowing.
        ///
        /// If `TRUE`, all tabs cannot be displayed at once and require scrolling.
        pub const is_overflowing = struct {
            pub const name = "is-overflowing";

            pub const Type = c_int;
        };

        /// The widget shown before the tabs.
        pub const start_action_widget = struct {
            pub const name = "start-action-widget";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the tabs are currently revealed.
        ///
        /// See `TabBar.properties.autohide`.
        pub const tabs_revealed = struct {
            pub const name = "tabs-revealed";

            pub const Type = c_int;
        };

        /// The tab view the tab bar controls.
        pub const view = struct {
            pub const name = "view";

            pub const Type = ?*adw.TabView;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when content is dropped onto a tab.
        ///
        /// The content must be of one of the types set up via
        /// `TabBar.setupExtraDropTarget`.
        ///
        /// See `gtk.DropTarget.signals.drop`.
        pub const extra_drag_drop = struct {
            pub const name = "extra-drag-drop";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_value: *gobject.Value, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabBar, p_instance))),
                    gobject.signalLookup("extra-drag-drop", TabBar.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when the dropped content is preloaded.
        ///
        /// In order for data to be preloaded, `TabBar.properties.extra_drag_preload`
        /// must be set to `TRUE`.
        ///
        /// The content must be of one of the types set up via
        /// `TabBar.setupExtraDropTarget`.
        ///
        /// See `gtk.DropTarget.properties.value`.
        pub const extra_drag_value = struct {
            pub const name = "extra-drag-value";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_value: *gobject.Value, P_Data) callconv(.c) gdk.DragAction, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabBar, p_instance))),
                    gobject.signalLookup("extra-drag-value", TabBar.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwTabBar`.
    extern fn adw_tab_bar_new() *adw.TabBar;
    pub const new = adw_tab_bar_new;

    /// Gets whether the tabs automatically hide.
    extern fn adw_tab_bar_get_autohide(p_self: *TabBar) c_int;
    pub const getAutohide = adw_tab_bar_get_autohide;

    /// Gets the widget shown after the tabs.
    extern fn adw_tab_bar_get_end_action_widget(p_self: *TabBar) ?*gtk.Widget;
    pub const getEndActionWidget = adw_tab_bar_get_end_action_widget;

    /// Gets whether tabs expand to full width.
    extern fn adw_tab_bar_get_expand_tabs(p_self: *TabBar) c_int;
    pub const getExpandTabs = adw_tab_bar_get_expand_tabs;

    /// Gets the current action during a drop on the extra_drop_target.
    extern fn adw_tab_bar_get_extra_drag_preferred_action(p_self: *TabBar) gdk.DragAction;
    pub const getExtraDragPreferredAction = adw_tab_bar_get_extra_drag_preferred_action;

    /// Gets whether drop data should be preloaded on hover.
    extern fn adw_tab_bar_get_extra_drag_preload(p_self: *TabBar) c_int;
    pub const getExtraDragPreload = adw_tab_bar_get_extra_drag_preload;

    /// Gets whether tabs use inverted layout.
    extern fn adw_tab_bar_get_inverted(p_self: *TabBar) c_int;
    pub const getInverted = adw_tab_bar_get_inverted;

    /// Gets whether `self` is overflowing.
    ///
    /// If `TRUE`, all tabs cannot be displayed at once and require scrolling.
    extern fn adw_tab_bar_get_is_overflowing(p_self: *TabBar) c_int;
    pub const getIsOverflowing = adw_tab_bar_get_is_overflowing;

    /// Gets the widget shown before the tabs.
    extern fn adw_tab_bar_get_start_action_widget(p_self: *TabBar) ?*gtk.Widget;
    pub const getStartActionWidget = adw_tab_bar_get_start_action_widget;

    /// Gets whether the tabs are currently revealed.
    ///
    /// See `TabBar.properties.autohide`.
    extern fn adw_tab_bar_get_tabs_revealed(p_self: *TabBar) c_int;
    pub const getTabsRevealed = adw_tab_bar_get_tabs_revealed;

    /// Gets the tab view `self` controls.
    extern fn adw_tab_bar_get_view(p_self: *TabBar) ?*adw.TabView;
    pub const getView = adw_tab_bar_get_view;

    /// Sets whether the tabs automatically hide.
    ///
    /// If set to `TRUE`, the tab bar disappears when `TabBar.properties.view` has 0
    /// or 1 tab, no pinned tabs, and no tab is being transferred.
    ///
    /// See `TabBar.properties.tabs_revealed`.
    extern fn adw_tab_bar_set_autohide(p_self: *TabBar, p_autohide: c_int) void;
    pub const setAutohide = adw_tab_bar_set_autohide;

    /// Sets the widget to show after the tabs.
    extern fn adw_tab_bar_set_end_action_widget(p_self: *TabBar, p_widget: ?*gtk.Widget) void;
    pub const setEndActionWidget = adw_tab_bar_set_end_action_widget;

    /// Sets whether tabs expand to full width.
    ///
    /// If set to `TRUE`, the tabs will always vary width filling the whole width
    /// when possible, otherwise tabs will always have the minimum possible size.
    extern fn adw_tab_bar_set_expand_tabs(p_self: *TabBar, p_expand_tabs: c_int) void;
    pub const setExpandTabs = adw_tab_bar_set_expand_tabs;

    /// Sets whether drop data should be preloaded on hover.
    ///
    /// See `gtk.DropTarget.properties.preload`.
    extern fn adw_tab_bar_set_extra_drag_preload(p_self: *TabBar, p_preload: c_int) void;
    pub const setExtraDragPreload = adw_tab_bar_set_extra_drag_preload;

    /// Sets whether tabs tabs use inverted layout.
    ///
    /// If set to `TRUE`, non-pinned tabs will have the close button at the beginning
    /// and the indicator at the end rather than the opposite.
    extern fn adw_tab_bar_set_inverted(p_self: *TabBar, p_inverted: c_int) void;
    pub const setInverted = adw_tab_bar_set_inverted;

    /// Sets the widget to show before the tabs.
    extern fn adw_tab_bar_set_start_action_widget(p_self: *TabBar, p_widget: ?*gtk.Widget) void;
    pub const setStartActionWidget = adw_tab_bar_set_start_action_widget;

    /// Sets the tab view `self` controls.
    extern fn adw_tab_bar_set_view(p_self: *TabBar, p_view: ?*adw.TabView) void;
    pub const setView = adw_tab_bar_set_view;

    /// Sets the supported types for this drop target.
    ///
    /// Sets up an extra drop target on tabs.
    ///
    /// This allows to drag arbitrary content onto tabs, for example URLs in a web
    /// browser.
    ///
    /// If a tab is hovered for a certain period of time while dragging the content,
    /// it will be automatically selected.
    ///
    /// The `TabBar.signals.extra_drag_drop` signal can be used to handle the drop.
    extern fn adw_tab_bar_setup_extra_drop_target(p_self: *TabBar, p_actions: gdk.DragAction, p_types: ?[*]usize, p_n_types: usize) void;
    pub const setupExtraDropTarget = adw_tab_bar_setup_extra_drop_target;

    extern fn adw_tab_bar_get_type() usize;
    pub const getGObjectType = adw_tab_bar_get_type;

    extern fn g_object_ref(p_self: *adw.TabBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TabBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TabBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button that displays the number of `TabView` pages.
///
/// <picture>
///   <source srcset="tab-button-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="tab-button.png" alt="tab-button">
/// </picture>
///
/// `AdwTabButton` is a button that displays the number of pages in a given
/// `AdwTabView`, as well as whether one of the inactive pages needs attention.
///
/// It's intended to be used as a visible indicator when there's no visible tab
/// bar, typically opening an `TabOverview` on click, e.g. via the
/// `overview.open` action name:
///
/// ```xml
/// <object class="AdwTabButton">
///   <property name="view">view</property>
///   <property name="action-name">overview.open</property>
/// </object>
/// ```
///
/// ## CSS nodes
///
/// `AdwTabButton` has a main CSS node with name `tabbutton`.
///
/// # Accessibility
///
/// `AdwTabButton` uses the `GTK_ACCESSIBLE_ROLE_BUTTON` role.
pub const TabButton = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.TabButtonClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The view the tab button displays.
        pub const view = struct {
            pub const name = "view";

            pub const Type = ?*adw.TabView;
        };
    };

    pub const signals = struct {
        /// Emitted to animate press then release.
        ///
        /// This is an action signal. Applications should never connect to this signal,
        /// but use the `TabButton.signals.clicked` signal.
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabButton, p_instance))),
                    gobject.signalLookup("activate", TabButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the button has been activated (pressed and released).
        pub const clicked = struct {
            pub const name = "clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabButton, p_instance))),
                    gobject.signalLookup("clicked", TabButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwTabButton`.
    extern fn adw_tab_button_new() *adw.TabButton;
    pub const new = adw_tab_button_new;

    /// Gets the tab view `self` displays.
    extern fn adw_tab_button_get_view(p_self: *TabButton) ?*adw.TabView;
    pub const getView = adw_tab_button_get_view;

    /// Sets the tab view to display.
    extern fn adw_tab_button_set_view(p_self: *TabButton, p_view: ?*adw.TabView) void;
    pub const setView = adw_tab_button_set_view;

    extern fn adw_tab_button_get_type() usize;
    pub const getGObjectType = adw_tab_button_get_type;

    extern fn g_object_ref(p_self: *adw.TabButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TabButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TabButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A tab overview for `TabView`.
///
/// <picture>
///   <source srcset="tab-overview-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="tab-overview.png" alt="tab-overview">
/// </picture>
///
/// `AdwTabOverview` is a widget that can display tabs from an `AdwTabView` in a
/// grid.
///
/// `AdwTabOverview` shows a thumbnail for each tab. By default thumbnails are
/// static for all pages except the selected one. They can be made always live
/// by setting `TabPage.properties.live_thumbnail` to `TRUE`, or refreshed with
/// `TabPage.invalidateThumbnail` or
/// `TabView.invalidateThumbnails` otherwise.
///
/// If the pages are too tall or too wide, the thumbnails will be cropped; use
/// `TabPage.properties.thumbnail_xalign` and `TabPage.properties.thumbnail_yalign` to
/// control which part of the page should be visible in this case.
///
/// Pinned tabs are shown as smaller cards without thumbnails above the other
/// tabs. Unlike in `TabBar`, they still have titles, as well as an unpin
/// button.
///
/// `AdwTabOverview` provides search in open tabs. It searches in tab titles and
/// tooltips, as well as `TabPage.properties.keyword`.
///
/// If `TabOverview.properties.enable_new_tab` is set to `TRUE`, a new tab button
/// will be shown. Connect to the `TabOverview.signals.create_tab` signal to use
/// it.
///
/// `TabOverview.properties.secondary_menu` can be used to provide a secondary menu
/// for the overview. Use it to add extra actions, e.g. to open a new window or
/// undo closed tab.
///
/// `AdwTabOverview` is intended to be used as the direct child of the window,
/// with the rest of the window contents set as the `TabOverview.properties.child`.
/// The child is expected to contain an `TabView`.
///
/// `AdwTabOverview` shows window buttons by default. They can be disabled by
/// setting `TabOverview.properties.show_start_title_buttons` and/or
/// `TabOverview.properties.show_start_title_buttons` and/or
/// `TabOverview.properties.show_end_title_buttons` to `FALSE`.
///
/// If search and window buttons are disabled, and secondary menu is not set, the
/// header bar will be hidden.
///
/// ## Actions
///
/// `AdwTabOverview` defines the `overview.open` and `overview.close` actions for
/// opening and closing itself. They can be convenient when used together with
/// `TabButton`.
///
/// ## CSS nodes
///
/// `AdwTabOverview` has a single CSS node with name `taboverview`.
pub const TabOverview = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.TabOverviewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether to enable new tab button.
        ///
        /// Connect to the `TabOverview.signals.create_tab` signal to use it.
        pub const enable_new_tab = struct {
            pub const name = "enable-new-tab";

            pub const Type = c_int;
        };

        /// Whether to enable search in tabs.
        ///
        /// Search matches tab titles and tooltips, as well as keywords, set via
        /// `TabPage.properties.keyword`. Use keywords to search in e.g. page URLs in a
        /// web browser.
        ///
        /// During search, tab reordering and drag-n-drop are disabled.
        ///
        /// Use `TabOverview.properties.search_active` to check out if search is
        /// currently active.
        pub const enable_search = struct {
            pub const name = "enable-search";

            pub const Type = c_int;
        };

        /// The unique action on the `current-drop` of the
        /// `TabOverview.signals.extra_drag_drop`.
        ///
        /// This property should only be used during a
        /// `TabOverview.signals.extra_drag_drop` and is always a subset of what was
        /// originally passed to `TabOverview.setupExtraDropTarget`.
        pub const extra_drag_preferred_action = struct {
            pub const name = "extra-drag-preferred-action";

            pub const Type = gdk.DragAction;
        };

        /// Whether the drop data should be preloaded on hover.
        ///
        /// See `gtk.DropTarget.properties.preload`.
        pub const extra_drag_preload = struct {
            pub const name = "extra-drag-preload";

            pub const Type = c_int;
        };

        /// Whether thumbnails use inverted layout.
        ///
        /// If set to `TRUE`, thumbnails will have the close or unpin buttons at the
        /// beginning and the indicator at the end rather than the other way around.
        pub const inverted = struct {
            pub const name = "inverted";

            pub const Type = c_int;
        };

        /// Whether the overview is open.
        pub const open = struct {
            pub const name = "open";

            pub const Type = c_int;
        };

        /// Whether search is currently active.
        ///
        /// See `TabOverview.properties.enable_search`.
        pub const search_active = struct {
            pub const name = "search-active";

            pub const Type = c_int;
        };

        /// The secondary menu model.
        ///
        /// Use it to add extra actions, e.g. to open a new window or undo closed tab.
        pub const secondary_menu = struct {
            pub const name = "secondary-menu";

            pub const Type = ?*gio.MenuModel;
        };

        /// Whether to show end title buttons in the overview's header bar.
        ///
        /// See `HeaderBar.properties.show_start_title_buttons` for the other side.
        pub const show_end_title_buttons = struct {
            pub const name = "show-end-title-buttons";

            pub const Type = c_int;
        };

        /// Whether to show start title buttons in the overview's header bar.
        ///
        /// See `HeaderBar.properties.show_end_title_buttons` for the other side.
        pub const show_start_title_buttons = struct {
            pub const name = "show-start-title-buttons";

            pub const Type = c_int;
        };

        /// The tab view the overview controls.
        ///
        /// The view must be inside the tab overview, see `TabOverview.properties.child`.
        pub const view = struct {
            pub const name = "view";

            pub const Type = ?*adw.TabView;
        };
    };

    pub const signals = struct {
        /// Emitted when a tab needs to be created.
        ///
        /// This can happen after the new tab button has been pressed, see
        /// `TabOverview.properties.enable_new_tab`.
        ///
        /// The signal handler is expected to create a new page in the corresponding
        /// `TabView` and return it.
        pub const create_tab = struct {
            pub const name = "create-tab";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) *adw.TabPage, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabOverview, p_instance))),
                    gobject.signalLookup("create-tab", TabOverview.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when content is dropped onto a tab.
        ///
        /// The content must be of one of the types set up via
        /// `TabOverview.setupExtraDropTarget`.
        ///
        /// See `gtk.DropTarget.signals.drop`.
        pub const extra_drag_drop = struct {
            pub const name = "extra-drag-drop";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_value: *gobject.Value, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabOverview, p_instance))),
                    gobject.signalLookup("extra-drag-drop", TabOverview.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when the dropped content is preloaded.
        ///
        /// In order for data to be preloaded, `TabOverview.properties.extra_drag_preload`
        /// must be set to `TRUE`.
        ///
        /// The content must be of one of the types set up via
        /// `TabOverview.setupExtraDropTarget`.
        ///
        /// See `gtk.DropTarget.properties.value`.
        pub const extra_drag_value = struct {
            pub const name = "extra-drag-value";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_value: *gobject.Value, P_Data) callconv(.c) gdk.DragAction, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabOverview, p_instance))),
                    gobject.signalLookup("extra-drag-value", TabOverview.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwTabOverview`.
    extern fn adw_tab_overview_new() *adw.TabOverview;
    pub const new = adw_tab_overview_new;

    /// Gets the child widget of `self`.
    extern fn adw_tab_overview_get_child(p_self: *TabOverview) ?*gtk.Widget;
    pub const getChild = adw_tab_overview_get_child;

    /// Gets whether to new tab button is enabled for `self`.
    extern fn adw_tab_overview_get_enable_new_tab(p_self: *TabOverview) c_int;
    pub const getEnableNewTab = adw_tab_overview_get_enable_new_tab;

    /// Gets whether search in tabs is enabled for `self`.
    extern fn adw_tab_overview_get_enable_search(p_self: *TabOverview) c_int;
    pub const getEnableSearch = adw_tab_overview_get_enable_search;

    /// Gets the current action during a drop on the extra_drop_target.
    extern fn adw_tab_overview_get_extra_drag_preferred_action(p_self: *TabOverview) gdk.DragAction;
    pub const getExtraDragPreferredAction = adw_tab_overview_get_extra_drag_preferred_action;

    /// Gets whether drop data should be preloaded on hover.
    extern fn adw_tab_overview_get_extra_drag_preload(p_self: *TabOverview) c_int;
    pub const getExtraDragPreload = adw_tab_overview_get_extra_drag_preload;

    /// Gets whether thumbnails use inverted layout.
    extern fn adw_tab_overview_get_inverted(p_self: *TabOverview) c_int;
    pub const getInverted = adw_tab_overview_get_inverted;

    /// Gets whether `self` is open.
    extern fn adw_tab_overview_get_open(p_self: *TabOverview) c_int;
    pub const getOpen = adw_tab_overview_get_open;

    /// Gets whether search is currently active for `self`.
    ///
    /// See `TabOverview.properties.enable_search`.
    extern fn adw_tab_overview_get_search_active(p_self: *TabOverview) c_int;
    pub const getSearchActive = adw_tab_overview_get_search_active;

    /// Gets the secondary menu model for `self`.
    extern fn adw_tab_overview_get_secondary_menu(p_self: *TabOverview) ?*gio.MenuModel;
    pub const getSecondaryMenu = adw_tab_overview_get_secondary_menu;

    /// Gets whether end title buttons are shown in `self`'s header bar.
    extern fn adw_tab_overview_get_show_end_title_buttons(p_self: *TabOverview) c_int;
    pub const getShowEndTitleButtons = adw_tab_overview_get_show_end_title_buttons;

    /// Gets whether start title buttons are shown in `self`'s header bar.
    extern fn adw_tab_overview_get_show_start_title_buttons(p_self: *TabOverview) c_int;
    pub const getShowStartTitleButtons = adw_tab_overview_get_show_start_title_buttons;

    /// Gets the tab view `self` controls.
    extern fn adw_tab_overview_get_view(p_self: *TabOverview) ?*adw.TabView;
    pub const getView = adw_tab_overview_get_view;

    /// Sets the child widget of `self`.
    extern fn adw_tab_overview_set_child(p_self: *TabOverview, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_tab_overview_set_child;

    /// Sets whether to enable new tab button for `self`.
    ///
    /// Connect to the `TabOverview.signals.create_tab` signal to use it.
    extern fn adw_tab_overview_set_enable_new_tab(p_self: *TabOverview, p_enable_new_tab: c_int) void;
    pub const setEnableNewTab = adw_tab_overview_set_enable_new_tab;

    /// Sets whether to enable search in tabs for `self`.
    ///
    /// Search matches tab titles and tooltips, as well as keywords, set via
    /// `TabPage.properties.keyword`. Use keywords to search in e.g. page URLs in a web
    /// browser.
    ///
    /// During search, tab reordering and drag-n-drop are disabled.
    ///
    /// Use `TabOverview.properties.search_active` to check out if search is currently
    /// active.
    extern fn adw_tab_overview_set_enable_search(p_self: *TabOverview, p_enable_search: c_int) void;
    pub const setEnableSearch = adw_tab_overview_set_enable_search;

    /// Sets whether drop data should be preloaded on hover.
    ///
    /// See `gtk.DropTarget.properties.preload`.
    extern fn adw_tab_overview_set_extra_drag_preload(p_self: *TabOverview, p_preload: c_int) void;
    pub const setExtraDragPreload = adw_tab_overview_set_extra_drag_preload;

    /// Sets whether thumbnails use inverted layout.
    ///
    /// If set to `TRUE`, thumbnails will have the close or unpin button at the
    /// beginning and the indicator at the end rather than the other way around.
    extern fn adw_tab_overview_set_inverted(p_self: *TabOverview, p_inverted: c_int) void;
    pub const setInverted = adw_tab_overview_set_inverted;

    /// Sets whether the to open `self`.
    extern fn adw_tab_overview_set_open(p_self: *TabOverview, p_open: c_int) void;
    pub const setOpen = adw_tab_overview_set_open;

    /// Sets the secondary menu model for `self`.
    ///
    /// Use it to add extra actions, e.g. to open a new window or undo closed tab.
    extern fn adw_tab_overview_set_secondary_menu(p_self: *TabOverview, p_secondary_menu: ?*gio.MenuModel) void;
    pub const setSecondaryMenu = adw_tab_overview_set_secondary_menu;

    /// Sets whether to show end title buttons in `self`'s header bar.
    ///
    /// See `HeaderBar.properties.show_start_title_buttons` for the other side.
    extern fn adw_tab_overview_set_show_end_title_buttons(p_self: *TabOverview, p_show_end_title_buttons: c_int) void;
    pub const setShowEndTitleButtons = adw_tab_overview_set_show_end_title_buttons;

    /// Sets whether to show start title buttons in `self`'s header bar.
    ///
    /// See `HeaderBar.properties.show_end_title_buttons` for the other side.
    extern fn adw_tab_overview_set_show_start_title_buttons(p_self: *TabOverview, p_show_start_title_buttons: c_int) void;
    pub const setShowStartTitleButtons = adw_tab_overview_set_show_start_title_buttons;

    /// Sets the tab view to control.
    ///
    /// The view must be inside `self`, see `TabOverview.properties.child`.
    extern fn adw_tab_overview_set_view(p_self: *TabOverview, p_view: ?*adw.TabView) void;
    pub const setView = adw_tab_overview_set_view;

    /// Sets the supported types for this drop target.
    ///
    /// Sets up an extra drop target on tabs.
    ///
    /// This allows to drag arbitrary content onto tabs, for example URLs in a web
    /// browser.
    ///
    /// If a tab is hovered for a certain period of time while dragging the content,
    /// it will be automatically selected.
    ///
    /// The `TabOverview.signals.extra_drag_drop` signal can be used to handle the
    /// drop.
    extern fn adw_tab_overview_setup_extra_drop_target(p_self: *TabOverview, p_actions: gdk.DragAction, p_types: ?[*]usize, p_n_types: usize) void;
    pub const setupExtraDropTarget = adw_tab_overview_setup_extra_drop_target;

    extern fn adw_tab_overview_get_type() usize;
    pub const getGObjectType = adw_tab_overview_get_type;

    extern fn g_object_ref(p_self: *adw.TabOverview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TabOverview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TabOverview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An auxiliary class used by `TabView`.
pub const TabPage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.Accessible};
    pub const Class = adw.TabPageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child of the page.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The icon of the page.
        ///
        /// `TabBar` and `TabOverview` display the icon next to the title,
        /// unless `TabPage.properties.loading` is set to `TRUE`.
        ///
        /// `AdwTabBar` also won't show the icon if the page is pinned and
        /// [propertyTabPage:indicator-icon] is set.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?*gio.Icon;
        };

        /// Whether the indicator icon is activatable.
        ///
        /// If set to `TRUE`, `TabView.signals.indicator_activated` will be emitted
        /// when the indicator icon is clicked.
        ///
        /// If `TabPage.properties.indicator_icon` is not set, does nothing.
        pub const indicator_activatable = struct {
            pub const name = "indicator-activatable";

            pub const Type = c_int;
        };

        /// An indicator icon for the page.
        ///
        /// A common use case is an audio or camera indicator in a web browser.
        ///
        /// `TabBar` will show it at the beginning of the tab, alongside icon
        /// representing `TabPage.properties.icon` or loading spinner.
        ///
        /// If the page is pinned, the indicator will be shown instead of icon or
        /// spinner.
        ///
        /// `TabOverview` will show it at the at the top part of the thumbnail.
        ///
        /// `TabPage.properties.indicator_tooltip` can be used to set the tooltip on the
        /// indicator icon.
        ///
        /// If `TabPage.properties.indicator_activatable` is set to `TRUE`, the
        /// indicator icon can act as a button.
        pub const indicator_icon = struct {
            pub const name = "indicator-icon";

            pub const Type = ?*gio.Icon;
        };

        /// The tooltip of the indicator icon.
        ///
        /// The tooltip can be marked up with the Pango text markup language.
        ///
        /// See `TabPage.properties.indicator_icon`.
        pub const indicator_tooltip = struct {
            pub const name = "indicator-tooltip";

            pub const Type = ?[*:0]u8;
        };

        /// The search keyboard of the page.
        ///
        /// `TabOverview` can search pages by their keywords in addition to their
        /// titles and tooltips.
        ///
        /// Keywords allow to include e.g. page URLs into tab search in a web browser.
        pub const keyword = struct {
            pub const name = "keyword";

            pub const Type = ?[*:0]u8;
        };

        /// Whether to enable live thumbnail for this page.
        ///
        /// When set to `TRUE`, the page's thumbnail in `TabOverview` will update
        /// immediately when the page is redrawn or resized.
        ///
        /// If it's set to `FALSE`, the thumbnail will only be live when the page is
        /// selected, and otherwise it will be static and will only update when
        /// `TabPage.invalidateThumbnail` or
        /// `TabView.invalidateThumbnails` is called.
        pub const live_thumbnail = struct {
            pub const name = "live-thumbnail";

            pub const Type = c_int;
        };

        /// Whether the page is loading.
        ///
        /// If set to `TRUE`, `TabBar` and `TabOverview` will display a
        /// spinner in place of icon.
        ///
        /// If the page is pinned and `TabPage.properties.indicator_icon` is set,
        /// loading status will not be visible with `AdwTabBar`.
        pub const loading = struct {
            pub const name = "loading";

            pub const Type = c_int;
        };

        /// Whether the page needs attention.
        ///
        /// `TabBar` will display a line under the tab representing the page if
        /// set to `TRUE`. If the tab is not visible, the corresponding edge of the tab
        /// bar will be highlighted.
        ///
        /// `TabOverview` will display a dot in the corner of the thumbnail if set
        /// to `TRUE`.
        ///
        /// `TabButton` will display a dot if any of the pages that aren't
        /// selected have this property set to `TRUE`.
        pub const needs_attention = struct {
            pub const name = "needs-attention";

            pub const Type = c_int;
        };

        /// The parent page of the page.
        ///
        /// See `TabView.addPage` and `TabView.closePage`.
        pub const parent = struct {
            pub const name = "parent";

            pub const Type = ?*adw.TabPage;
        };

        /// Whether the page is pinned.
        ///
        /// See `TabView.setPagePinned`.
        pub const pinned = struct {
            pub const name = "pinned";

            pub const Type = c_int;
        };

        /// Whether the page is selected.
        pub const selected = struct {
            pub const name = "selected";

            pub const Type = c_int;
        };

        /// The horizontal alignment of the page thumbnail.
        ///
        /// If the page is so wide that `TabOverview` can't display it completely
        /// and has to crop it, horizontal alignment will determine which part of the
        /// page will be visible.
        ///
        /// For example, 0.5 means the center of the page will be visible, 0 means the
        /// start edge will be visible and 1 means the end edge will be visible.
        ///
        /// The default horizontal alignment is 0.
        pub const thumbnail_xalign = struct {
            pub const name = "thumbnail-xalign";

            pub const Type = f32;
        };

        /// The vertical alignment of the page thumbnail.
        ///
        /// If the page is so tall that `TabOverview` can't display it completely
        /// and has to crop it, vertical alignment will determine which part of the
        /// page will be visible.
        ///
        /// For example, 0.5 means the center of the page will be visible, 0 means the
        /// top edge will be visible and 1 means the bottom edge will be visible.
        ///
        /// The default vertical alignment is 0.
        pub const thumbnail_yalign = struct {
            pub const name = "thumbnail-yalign";

            pub const Type = f32;
        };

        /// The title of the page.
        ///
        /// `TabBar` will display it in the center of the tab unless it's pinned,
        /// and will use it as a tooltip unless `TabPage.properties.tooltip` is set.
        ///
        /// `TabOverview` will display it below the thumbnail unless it's pinned,
        /// or inside the card otherwise, and will use it as a tooltip unless
        /// `TabPage.properties.tooltip` is set.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// The tooltip of the page.
        ///
        /// The tooltip can be marked up with the Pango text markup language.
        ///
        /// If not set, `TabBar` and `TabOverview` will use
        /// `TabPage.properties.title` as a tooltip instead.
        pub const tooltip = struct {
            pub const name = "tooltip";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Gets the child of `self`.
    extern fn adw_tab_page_get_child(p_self: *TabPage) *gtk.Widget;
    pub const getChild = adw_tab_page_get_child;

    /// Gets the icon of `self`.
    extern fn adw_tab_page_get_icon(p_self: *TabPage) ?*gio.Icon;
    pub const getIcon = adw_tab_page_get_icon;

    /// Gets whether the indicator of `self` is activatable.
    extern fn adw_tab_page_get_indicator_activatable(p_self: *TabPage) c_int;
    pub const getIndicatorActivatable = adw_tab_page_get_indicator_activatable;

    /// Gets the indicator icon of `self`.
    extern fn adw_tab_page_get_indicator_icon(p_self: *TabPage) ?*gio.Icon;
    pub const getIndicatorIcon = adw_tab_page_get_indicator_icon;

    /// Gets the tooltip of the indicator icon of `self`.
    extern fn adw_tab_page_get_indicator_tooltip(p_self: *TabPage) [*:0]const u8;
    pub const getIndicatorTooltip = adw_tab_page_get_indicator_tooltip;

    /// Gets the search keyword of `self`.
    extern fn adw_tab_page_get_keyword(p_self: *TabPage) ?[*:0]const u8;
    pub const getKeyword = adw_tab_page_get_keyword;

    /// Gets whether to live thumbnail is enabled `self`.
    extern fn adw_tab_page_get_live_thumbnail(p_self: *TabPage) c_int;
    pub const getLiveThumbnail = adw_tab_page_get_live_thumbnail;

    /// Gets whether `self` is loading.
    extern fn adw_tab_page_get_loading(p_self: *TabPage) c_int;
    pub const getLoading = adw_tab_page_get_loading;

    /// Gets whether `self` needs attention.
    extern fn adw_tab_page_get_needs_attention(p_self: *TabPage) c_int;
    pub const getNeedsAttention = adw_tab_page_get_needs_attention;

    /// Gets the parent page of `self`.
    ///
    /// See `TabView.addPage` and `TabView.closePage`.
    extern fn adw_tab_page_get_parent(p_self: *TabPage) ?*adw.TabPage;
    pub const getParent = adw_tab_page_get_parent;

    /// Gets whether `self` is pinned.
    ///
    /// See `TabView.setPagePinned`.
    extern fn adw_tab_page_get_pinned(p_self: *TabPage) c_int;
    pub const getPinned = adw_tab_page_get_pinned;

    /// Gets whether `self` is selected.
    extern fn adw_tab_page_get_selected(p_self: *TabPage) c_int;
    pub const getSelected = adw_tab_page_get_selected;

    /// Gets the horizontal alignment of the thumbnail for `self`.
    extern fn adw_tab_page_get_thumbnail_xalign(p_self: *TabPage) f32;
    pub const getThumbnailXalign = adw_tab_page_get_thumbnail_xalign;

    /// Gets the vertical alignment of the thumbnail for `self`.
    extern fn adw_tab_page_get_thumbnail_yalign(p_self: *TabPage) f32;
    pub const getThumbnailYalign = adw_tab_page_get_thumbnail_yalign;

    /// Gets the title of `self`.
    extern fn adw_tab_page_get_title(p_self: *TabPage) [*:0]const u8;
    pub const getTitle = adw_tab_page_get_title;

    /// Gets the tooltip of `self`.
    extern fn adw_tab_page_get_tooltip(p_self: *TabPage) ?[*:0]const u8;
    pub const getTooltip = adw_tab_page_get_tooltip;

    /// Invalidates thumbnail for `self`.
    ///
    /// If an `TabOverview` is open, the thumbnail representing `self` will be
    /// immediately updated. Otherwise it will be update when opening the overview.
    ///
    /// Does nothing if `TabPage.properties.live_thumbnail` is set to `TRUE`.
    ///
    /// See also `TabView.invalidateThumbnails`.
    extern fn adw_tab_page_invalidate_thumbnail(p_self: *TabPage) void;
    pub const invalidateThumbnail = adw_tab_page_invalidate_thumbnail;

    /// Sets the icon of `self`.
    ///
    /// `TabBar` and `TabOverview` display the icon next to the title,
    /// unless `TabPage.properties.loading` is set to `TRUE`.
    ///
    /// `AdwTabBar` also won't show the icon if the page is pinned and
    /// [propertyTabPage:indicator-icon] is set.
    extern fn adw_tab_page_set_icon(p_self: *TabPage, p_icon: ?*gio.Icon) void;
    pub const setIcon = adw_tab_page_set_icon;

    /// Sets whether the indicator of `self` is activatable.
    ///
    /// If set to `TRUE`, `TabView.signals.indicator_activated` will be emitted
    /// when the indicator icon is clicked.
    ///
    /// If `TabPage.properties.indicator_icon` is not set, does nothing.
    extern fn adw_tab_page_set_indicator_activatable(p_self: *TabPage, p_activatable: c_int) void;
    pub const setIndicatorActivatable = adw_tab_page_set_indicator_activatable;

    /// Sets the indicator icon of `self`.
    ///
    /// A common use case is an audio or camera indicator in a web browser.
    ///
    /// `TabBar` will show it at the beginning of the tab, alongside icon
    /// representing `TabPage.properties.icon` or loading spinner.
    ///
    /// If the page is pinned, the indicator will be shown instead of icon or
    /// spinner.
    ///
    /// `TabOverview` will show it at the at the top part of the thumbnail.
    ///
    /// `TabPage.properties.indicator_tooltip` can be used to set the tooltip on the
    /// indicator icon.
    ///
    /// If `TabPage.properties.indicator_activatable` is set to `TRUE`, the
    /// indicator icon can act as a button.
    extern fn adw_tab_page_set_indicator_icon(p_self: *TabPage, p_indicator_icon: ?*gio.Icon) void;
    pub const setIndicatorIcon = adw_tab_page_set_indicator_icon;

    /// Sets the tooltip of the indicator icon of `self`.
    ///
    /// The tooltip can be marked up with the Pango text markup language.
    ///
    /// See `TabPage.properties.indicator_icon`.
    extern fn adw_tab_page_set_indicator_tooltip(p_self: *TabPage, p_tooltip: [*:0]const u8) void;
    pub const setIndicatorTooltip = adw_tab_page_set_indicator_tooltip;

    /// Sets the search keyword for `self`.
    ///
    /// `TabOverview` can search pages by their keywords in addition to their
    /// titles and tooltips.
    ///
    /// Keywords allow to include e.g. page URLs into tab search in a web browser.
    extern fn adw_tab_page_set_keyword(p_self: *TabPage, p_keyword: [*:0]const u8) void;
    pub const setKeyword = adw_tab_page_set_keyword;

    /// Sets whether to enable live thumbnail for `self`.
    ///
    /// When set to `TRUE`, `self`'s thumbnail in `TabOverview` will update
    /// immediately when `self` is redrawn or resized.
    ///
    /// If it's set to `FALSE`, the thumbnail will only be live when the `self` is
    /// selected, and otherwise it will be static and will only update when
    /// `TabPage.invalidateThumbnail` or
    /// `TabView.invalidateThumbnails` is called.
    extern fn adw_tab_page_set_live_thumbnail(p_self: *TabPage, p_live_thumbnail: c_int) void;
    pub const setLiveThumbnail = adw_tab_page_set_live_thumbnail;

    /// Sets whether `self` is loading.
    ///
    /// If set to `TRUE`, `TabBar` and `TabOverview` will display a
    /// spinner in place of icon.
    ///
    /// If the page is pinned and `TabPage.properties.indicator_icon` is set, loading
    /// status will not be visible with `AdwTabBar`.
    extern fn adw_tab_page_set_loading(p_self: *TabPage, p_loading: c_int) void;
    pub const setLoading = adw_tab_page_set_loading;

    /// Sets whether `self` needs attention.
    ///
    /// `TabBar` will display a line under the tab representing the page if
    /// set to `TRUE`. If the tab is not visible, the corresponding edge of the tab
    /// bar will be highlighted.
    ///
    /// `TabOverview` will display a dot in the corner of the thumbnail if set
    /// to `TRUE`.
    ///
    /// `TabButton` will display a dot if any of the pages that aren't
    /// selected have `TabPage.properties.needs_attention` set to `TRUE`.
    extern fn adw_tab_page_set_needs_attention(p_self: *TabPage, p_needs_attention: c_int) void;
    pub const setNeedsAttention = adw_tab_page_set_needs_attention;

    /// Sets the horizontal alignment of the thumbnail for `self`.
    ///
    /// If the page is so wide that `TabOverview` can't display it completely
    /// and has to crop it, horizontal alignment will determine which part of the
    /// page will be visible.
    ///
    /// For example, 0.5 means the center of the page will be visible, 0 means the
    /// start edge will be visible and 1 means the end edge will be visible.
    ///
    /// The default horizontal alignment is 0.
    extern fn adw_tab_page_set_thumbnail_xalign(p_self: *TabPage, p_xalign: f32) void;
    pub const setThumbnailXalign = adw_tab_page_set_thumbnail_xalign;

    /// Sets the vertical alignment of the thumbnail for `self`.
    ///
    /// If the page is so tall that `TabOverview` can't display it completely
    /// and has to crop it, vertical alignment will determine which part of the page
    /// will be visible.
    ///
    /// For example, 0.5 means the center of the page will be visible, 0 means the
    /// top edge will be visible and 1 means the bottom edge will be visible.
    ///
    /// The default vertical alignment is 0.
    extern fn adw_tab_page_set_thumbnail_yalign(p_self: *TabPage, p_yalign: f32) void;
    pub const setThumbnailYalign = adw_tab_page_set_thumbnail_yalign;

    /// `TabBar` will display it in the center of the tab unless it's pinned,
    /// and will use it as a tooltip unless `TabPage.properties.tooltip` is set.
    ///
    /// `TabOverview` will display it below the thumbnail unless it's pinned,
    /// or inside the card otherwise, and will use it as a tooltip unless
    /// `TabPage.properties.tooltip` is set.
    ///
    /// Sets the title of `self`.
    extern fn adw_tab_page_set_title(p_self: *TabPage, p_title: [*:0]const u8) void;
    pub const setTitle = adw_tab_page_set_title;

    /// Sets the tooltip of `self`.
    ///
    /// The tooltip can be marked up with the Pango text markup language.
    ///
    /// If not set, `TabBar` and `TabOverview` will use
    /// `TabPage.properties.title` as a tooltip instead.
    extern fn adw_tab_page_set_tooltip(p_self: *TabPage, p_tooltip: [*:0]const u8) void;
    pub const setTooltip = adw_tab_page_set_tooltip;

    extern fn adw_tab_page_get_type() usize;
    pub const getGObjectType = adw_tab_page_get_type;

    extern fn g_object_ref(p_self: *adw.TabPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TabPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TabPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A dynamic tabbed container.
///
/// `AdwTabView` is a container which shows one child at a time. While it
/// provides keyboard shortcuts for switching between pages, it does not provide
/// a visible tab switcher and relies on external widgets for that, such as
/// `TabBar`, `TabOverview` and `TabButton`.
///
/// `AdwTabView` maintains a `TabPage` object for each page, which holds
/// additional per-page properties. You can obtain the `AdwTabPage` for a page
/// with `TabView.getPage`, and as the return value for
/// `TabView.append` and other functions for adding children.
///
/// `AdwTabView` only aims to be useful for dynamic tabs in multi-window
/// document-based applications, such as web browsers, file managers, text
/// editors or terminals. It does not aim to replace `gtk.Notebook` for use
/// cases such as tabbed dialogs.
///
/// As such, it does not support disabling page reordering or detaching.
///
/// `AdwTabView` adds a number of global page switching and reordering shortcuts.
/// The `TabView.properties.shortcuts` property can be used to manage them.
///
/// See `TabViewShortcuts` for the list of the available shortcuts. All of
/// the shortcuts are enabled by default.
///
/// `TabView.addShortcuts` and `TabView.removeShortcuts` can be
/// used to manage shortcuts in a convenient way, for example:
///
/// ```c
/// adw_tab_view_remove_shortcuts (view, ADW_TAB_VIEW_SHORTCUT_CONTROL_HOME |
///                                      ADW_TAB_VIEW_SHORTCUT_CONTROL_END);
/// ```
///
/// ## CSS nodes
///
/// `AdwTabView` has a main CSS node with the name `tabview`.
///
/// ## Accessibility
///
/// `AdwTabView` uses the `GTK_ACCESSIBLE_ROLE_TAB_PANEL` for the tab pages which
/// are the accessible parent objects of the child widgets.
pub const TabView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.TabViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Default page icon.
        ///
        /// If a page doesn't provide its own icon via `TabPage.properties.icon`, a
        /// default icon may be used instead for contexts where having an icon is
        /// necessary.
        ///
        /// `TabBar` will use default icon for pinned tabs in case the page is
        /// not loading, doesn't have an icon and an indicator. Default icon is never
        /// used for tabs that aren't pinned.
        ///
        /// `TabOverview` will use default icon for pages with missing
        /// thumbnails.
        ///
        /// By default, the `adw-tab-icon-missing-symbolic` icon is used.
        pub const default_icon = struct {
            pub const name = "default-icon";

            pub const Type = ?*gio.Icon;
        };

        /// Whether a page is being transferred.
        ///
        /// This property will be set to `TRUE` when a drag-n-drop tab transfer starts
        /// on any `AdwTabView`, and to `FALSE` after it ends.
        ///
        /// During the transfer, children cannot receive pointer input and a tab can
        /// be safely dropped on the tab view.
        pub const is_transferring_page = struct {
            pub const name = "is-transferring-page";

            pub const Type = c_int;
        };

        /// Tab context menu model.
        ///
        /// When a context menu is shown for a tab, it will be constructed from the
        /// provided menu model. Use the `TabView.signals.setup_menu` signal to set up
        /// the menu actions for the particular tab.
        pub const menu_model = struct {
            pub const name = "menu-model";

            pub const Type = ?*gio.MenuModel;
        };

        /// The number of pages in the tab view.
        pub const n_pages = struct {
            pub const name = "n-pages";

            pub const Type = c_int;
        };

        /// The number of pinned pages in the tab view.
        ///
        /// See `TabView.setPagePinned`.
        pub const n_pinned_pages = struct {
            pub const name = "n-pinned-pages";

            pub const Type = c_int;
        };

        /// A selection model with the tab view's pages.
        ///
        /// This can be used to keep an up-to-date view. The model also implements
        /// `gtk.SelectionModel` and can be used to track and change the selected
        /// page.
        pub const pages = struct {
            pub const name = "pages";

            pub const Type = ?*gtk.SelectionModel;
        };

        /// The currently selected page.
        pub const selected_page = struct {
            pub const name = "selected-page";

            pub const Type = ?*adw.TabPage;
        };

        /// The enabled shortcuts.
        ///
        /// See `TabViewShortcuts` for the list of the available shortcuts. All
        /// of the shortcuts are enabled by default.
        ///
        /// `TabView.addShortcuts` and `TabView.removeShortcuts`
        /// provide a convenient way to manage individual shortcuts.
        pub const shortcuts = struct {
            pub const name = "shortcuts";

            pub const Type = adw.TabViewShortcuts;
        };
    };

    pub const signals = struct {
        /// Emitted after `TabView.closePage` has been called for `page`.
        ///
        /// The handler is expected to call `TabView.closePageFinish` to
        /// confirm or reject the closing.
        ///
        /// The default handler will immediately confirm closing for non-pinned pages,
        /// or reject it for pinned pages, equivalent to the following example:
        ///
        /// ```c
        /// static gboolean
        /// close_page_cb (AdwTabView *view,
        ///                AdwTabPage *page,
        ///                gpointer    user_data)
        /// {
        ///   adw_tab_view_close_page_finish (view, page, !adw_tab_page_get_pinned (page));
        ///
        ///   return GDK_EVENT_STOP;
        /// }
        /// ```
        ///
        /// The `TabView.closePageFinish` call doesn't have to happen inside
        /// the handler, so can be used to do asynchronous checks before confirming the
        /// closing.
        ///
        /// A typical reason to connect to this signal is to show a confirmation dialog
        /// for closing a tab.
        ///
        /// The signal handler should return `GDK_EVENT_STOP` to stop propagation or
        /// `GDK_EVENT_CONTINUE` to invoke the default handler.
        pub const close_page = struct {
            pub const name = "close-page";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("close-page", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a tab should be transferred into a new window.
        ///
        /// This can happen after a tab has been dropped on desktop.
        ///
        /// The signal handler is expected to create a new window, position it as
        /// needed and return its `AdwTabView` that the page will be transferred into.
        pub const create_window = struct {
            pub const name = "create-window";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) ?*adw.TabView, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("create-window", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after the indicator icon on `page` has been activated.
        ///
        /// See `TabPage.properties.indicator_icon` and
        /// `TabPage.properties.indicator_activatable`.
        pub const indicator_activated = struct {
            pub const name = "indicator-activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("indicator-activated", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a page has been created or transferred to `self`.
        ///
        /// A typical reason to connect to this signal would be to connect to page
        /// signals for things such as updating window title.
        pub const page_attached = struct {
            pub const name = "page-attached";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_position: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("page-attached", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a page has been removed or transferred to another view.
        ///
        /// A typical reason to connect to this signal would be to disconnect signal
        /// handlers connected in the `TabView.signals.page_attached` handler.
        ///
        /// It is important not to try and destroy the page child in the handler of
        /// this function as the child might merely be moved to another window; use
        /// child dispose handler for that or do it in sync with your
        /// `TabView.closePageFinish` calls.
        pub const page_detached = struct {
            pub const name = "page-detached";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_position: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("page-detached", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after `page` has been reordered to `position`.
        pub const page_reordered = struct {
            pub const name = "page-reordered";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: *adw.TabPage, p_position: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("page-reordered", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a context menu is opened or closed for `page`.
        ///
        /// If the menu has been closed, `page` will be set to `NULL`.
        ///
        /// It can be used to set up menu actions before showing the menu, for example
        /// disable actions not applicable to `page`.
        pub const setup_menu = struct {
            pub const name = "setup-menu";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page: ?*adw.TabPage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TabView, p_instance))),
                    gobject.signalLookup("setup-menu", TabView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwTabView`.
    extern fn adw_tab_view_new() *adw.TabView;
    pub const new = adw_tab_view_new;

    /// Adds `child` to `self` with `parent` as the parent.
    ///
    /// This function can be used to automatically position new pages, and to select
    /// the correct page when this page is closed while being selected (see
    /// `TabView.closePage`).
    ///
    /// If `parent` is `NULL`, this function is equivalent to `TabView.append`.
    extern fn adw_tab_view_add_page(p_self: *TabView, p_child: *gtk.Widget, p_parent: ?*adw.TabPage) *adw.TabPage;
    pub const addPage = adw_tab_view_add_page;

    /// Adds `shortcuts` for `self`.
    ///
    /// See `TabView.properties.shortcuts` for details.
    extern fn adw_tab_view_add_shortcuts(p_self: *TabView, p_shortcuts: adw.TabViewShortcuts) void;
    pub const addShortcuts = adw_tab_view_add_shortcuts;

    /// Inserts `child` as the last non-pinned page.
    extern fn adw_tab_view_append(p_self: *TabView, p_child: *gtk.Widget) *adw.TabPage;
    pub const append = adw_tab_view_append;

    /// Inserts `child` as the last pinned page.
    extern fn adw_tab_view_append_pinned(p_self: *TabView, p_child: *gtk.Widget) *adw.TabPage;
    pub const appendPinned = adw_tab_view_append_pinned;

    /// Requests to close all pages other than `page`.
    extern fn adw_tab_view_close_other_pages(p_self: *TabView, p_page: *adw.TabPage) void;
    pub const closeOtherPages = adw_tab_view_close_other_pages;

    /// Requests to close `page`.
    ///
    /// Calling this function will result in the `TabView.signals.close_page` signal
    /// being emitted for `page`. Closing the page can then be confirmed or
    /// denied via `TabView.closePageFinish`.
    ///
    /// If the page is waiting for a `TabView.closePageFinish` call, this
    /// function will do nothing.
    ///
    /// The default handler for `TabView.signals.close_page` will immediately confirm
    /// closing the page if it's non-pinned, or reject it if it's pinned. This
    /// behavior can be changed by registering your own handler for that signal.
    ///
    /// If `page` was selected, another page will be selected instead:
    ///
    /// If the `TabPage.properties.parent` value is `NULL`, the next page will be
    /// selected when possible, or if the page was already last, the previous page
    /// will be selected instead.
    ///
    /// If it's not `NULL`, the previous page will be selected if it's a descendant
    /// (possibly indirect) of the parent. If both the previous page and the parent
    /// are pinned, the parent will be selected instead.
    extern fn adw_tab_view_close_page(p_self: *TabView, p_page: *adw.TabPage) void;
    pub const closePage = adw_tab_view_close_page;

    /// Completes a `TabView.closePage` call for `page`.
    ///
    /// If `confirm` is `TRUE`, `page` will be closed. If it's `FALSE`, it will be
    /// reverted to its previous state and `TabView.closePage` can be called
    /// for it again.
    ///
    /// This function should not be called unless a custom handler for
    /// `TabView.signals.close_page` is used.
    extern fn adw_tab_view_close_page_finish(p_self: *TabView, p_page: *adw.TabPage, p_confirm: c_int) void;
    pub const closePageFinish = adw_tab_view_close_page_finish;

    /// Requests to close all pages after `page`.
    extern fn adw_tab_view_close_pages_after(p_self: *TabView, p_page: *adw.TabPage) void;
    pub const closePagesAfter = adw_tab_view_close_pages_after;

    /// Requests to close all pages before `page`.
    extern fn adw_tab_view_close_pages_before(p_self: *TabView, p_page: *adw.TabPage) void;
    pub const closePagesBefore = adw_tab_view_close_pages_before;

    /// Gets the default icon of `self`.
    extern fn adw_tab_view_get_default_icon(p_self: *TabView) *gio.Icon;
    pub const getDefaultIcon = adw_tab_view_get_default_icon;

    /// Whether a page is being transferred.
    ///
    /// The corresponding property will be set to `TRUE` when a drag-n-drop tab
    /// transfer starts on any `AdwTabView`, and to `FALSE` after it ends.
    ///
    /// During the transfer, children cannot receive pointer input and a tab can
    /// be safely dropped on the tab view.
    extern fn adw_tab_view_get_is_transferring_page(p_self: *TabView) c_int;
    pub const getIsTransferringPage = adw_tab_view_get_is_transferring_page;

    /// Gets the tab context menu model for `self`.
    extern fn adw_tab_view_get_menu_model(p_self: *TabView) ?*gio.MenuModel;
    pub const getMenuModel = adw_tab_view_get_menu_model;

    /// Gets the number of pages in `self`.
    extern fn adw_tab_view_get_n_pages(p_self: *TabView) c_int;
    pub const getNPages = adw_tab_view_get_n_pages;

    /// Gets the number of pinned pages in `self`.
    ///
    /// See `TabView.setPagePinned`.
    extern fn adw_tab_view_get_n_pinned_pages(p_self: *TabView) c_int;
    pub const getNPinnedPages = adw_tab_view_get_n_pinned_pages;

    /// Gets the `TabPage` representing the child at `position`.
    extern fn adw_tab_view_get_nth_page(p_self: *TabView, p_position: c_int) *adw.TabPage;
    pub const getNthPage = adw_tab_view_get_nth_page;

    /// Gets the `TabPage` object representing `child`.
    extern fn adw_tab_view_get_page(p_self: *TabView, p_child: *gtk.Widget) *adw.TabPage;
    pub const getPage = adw_tab_view_get_page;

    /// Finds the position of `page` in `self`, starting from 0.
    extern fn adw_tab_view_get_page_position(p_self: *TabView, p_page: *adw.TabPage) c_int;
    pub const getPagePosition = adw_tab_view_get_page_position;

    /// Returns a `gio.ListModel` that contains the pages of `self`.
    ///
    /// This can be used to keep an up-to-date view. The model also implements
    /// `gtk.SelectionModel` and can be used to track and change the selected
    /// page.
    extern fn adw_tab_view_get_pages(p_self: *TabView) *gtk.SelectionModel;
    pub const getPages = adw_tab_view_get_pages;

    /// Gets the currently selected page in `self`.
    extern fn adw_tab_view_get_selected_page(p_self: *TabView) ?*adw.TabPage;
    pub const getSelectedPage = adw_tab_view_get_selected_page;

    /// Gets the enabled shortcuts for `self`.
    extern fn adw_tab_view_get_shortcuts(p_self: *TabView) adw.TabViewShortcuts;
    pub const getShortcuts = adw_tab_view_get_shortcuts;

    /// Inserts a non-pinned page at `position`.
    ///
    /// It's an error to try to insert a page before a pinned page, in that case
    /// `TabView.insertPinned` should be used instead.
    extern fn adw_tab_view_insert(p_self: *TabView, p_child: *gtk.Widget, p_position: c_int) *adw.TabPage;
    pub const insert = adw_tab_view_insert;

    /// Inserts a pinned page at `position`.
    ///
    /// It's an error to try to insert a pinned page after a non-pinned page, in
    /// that case `TabView.insert` should be used instead.
    extern fn adw_tab_view_insert_pinned(p_self: *TabView, p_child: *gtk.Widget, p_position: c_int) *adw.TabPage;
    pub const insertPinned = adw_tab_view_insert_pinned;

    /// Invalidates thumbnails for all pages in `self`.
    ///
    /// This is a convenience method, equivalent to calling
    /// `TabPage.invalidateThumbnail` on each page.
    extern fn adw_tab_view_invalidate_thumbnails(p_self: *TabView) void;
    pub const invalidateThumbnails = adw_tab_view_invalidate_thumbnails;

    /// Inserts `child` as the first non-pinned page.
    extern fn adw_tab_view_prepend(p_self: *TabView, p_child: *gtk.Widget) *adw.TabPage;
    pub const prepend = adw_tab_view_prepend;

    /// Inserts `child` as the first pinned page.
    extern fn adw_tab_view_prepend_pinned(p_self: *TabView, p_child: *gtk.Widget) *adw.TabPage;
    pub const prependPinned = adw_tab_view_prepend_pinned;

    /// Removes `shortcuts` from `self`.
    ///
    /// See `TabView.properties.shortcuts` for details.
    extern fn adw_tab_view_remove_shortcuts(p_self: *TabView, p_shortcuts: adw.TabViewShortcuts) void;
    pub const removeShortcuts = adw_tab_view_remove_shortcuts;

    /// Reorders `page` to before its previous page if possible.
    extern fn adw_tab_view_reorder_backward(p_self: *TabView, p_page: *adw.TabPage) c_int;
    pub const reorderBackward = adw_tab_view_reorder_backward;

    /// Reorders `page` to the first possible position.
    extern fn adw_tab_view_reorder_first(p_self: *TabView, p_page: *adw.TabPage) c_int;
    pub const reorderFirst = adw_tab_view_reorder_first;

    /// Reorders `page` to after its next page if possible.
    extern fn adw_tab_view_reorder_forward(p_self: *TabView, p_page: *adw.TabPage) c_int;
    pub const reorderForward = adw_tab_view_reorder_forward;

    /// Reorders `page` to the last possible position.
    extern fn adw_tab_view_reorder_last(p_self: *TabView, p_page: *adw.TabPage) c_int;
    pub const reorderLast = adw_tab_view_reorder_last;

    /// Reorders `page` to `position`.
    ///
    /// It's a programmer error to try to reorder a pinned page after a non-pinned
    /// one, or a non-pinned page before a pinned one.
    extern fn adw_tab_view_reorder_page(p_self: *TabView, p_page: *adw.TabPage, p_position: c_int) c_int;
    pub const reorderPage = adw_tab_view_reorder_page;

    /// Selects the page after the currently selected page.
    ///
    /// If the last page was already selected, this function does nothing.
    extern fn adw_tab_view_select_next_page(p_self: *TabView) c_int;
    pub const selectNextPage = adw_tab_view_select_next_page;

    /// Selects the page before the currently selected page.
    ///
    /// If the first page was already selected, this function does nothing.
    extern fn adw_tab_view_select_previous_page(p_self: *TabView) c_int;
    pub const selectPreviousPage = adw_tab_view_select_previous_page;

    /// Sets the default page icon for `self`.
    ///
    /// If a page doesn't provide its own icon via `TabPage.properties.icon`, a default
    /// icon may be used instead for contexts where having an icon is necessary.
    ///
    /// `TabBar` will use default icon for pinned tabs in case the page is not
    /// loading, doesn't have an icon and an indicator. Default icon is never used
    /// for tabs that aren't pinned.
    ///
    /// `TabOverview` will use default icon for pages with missing thumbnails.
    ///
    /// By default, the `adw-tab-icon-missing-symbolic` icon is used.
    extern fn adw_tab_view_set_default_icon(p_self: *TabView, p_default_icon: *gio.Icon) void;
    pub const setDefaultIcon = adw_tab_view_set_default_icon;

    /// Sets the tab context menu model for `self`.
    ///
    /// When a context menu is shown for a tab, it will be constructed from the
    /// provided menu model. Use the `TabView.signals.setup_menu` signal to set up
    /// the menu actions for the particular tab.
    extern fn adw_tab_view_set_menu_model(p_self: *TabView, p_menu_model: ?*gio.MenuModel) void;
    pub const setMenuModel = adw_tab_view_set_menu_model;

    /// Pins or unpins `page`.
    ///
    /// Pinned pages are guaranteed to be placed before all non-pinned pages; at any
    /// given moment the first `TabView.properties.n_pinned_pages` pages in `self` are
    /// guaranteed to be pinned.
    ///
    /// When a page is pinned or unpinned, it's automatically reordered: pinning a
    /// page moves it after other pinned pages; unpinning a page moves it before
    /// other non-pinned pages.
    ///
    /// Pinned pages can still be reordered between each other.
    ///
    /// `TabBar` will display pinned pages in a compact form, never showing the
    /// title or close button, and only showing a single icon, selected in the
    /// following order:
    ///
    /// 1. `TabPage.properties.indicator_icon`
    /// 2. A spinner if `TabPage.properties.loading` is `TRUE`
    /// 3. `TabPage.properties.icon`
    /// 4. `TabView.properties.default_icon`
    ///
    /// `TabOverview` will not show a thumbnail for pinned pages, and replace
    /// the close button with an unpin button. Unlike `AdwTabBar`, it will still
    /// display the page's title, icon and indicator separately.
    ///
    /// Pinned pages cannot be closed by default, see `TabView.signals.close_page`
    /// for how to override that behavior.
    ///
    /// Changes the value of the `TabPage.properties.pinned` property.
    extern fn adw_tab_view_set_page_pinned(p_self: *TabView, p_page: *adw.TabPage, p_pinned: c_int) void;
    pub const setPagePinned = adw_tab_view_set_page_pinned;

    /// Sets the currently selected page in `self`.
    extern fn adw_tab_view_set_selected_page(p_self: *TabView, p_selected_page: *adw.TabPage) void;
    pub const setSelectedPage = adw_tab_view_set_selected_page;

    /// Sets the enabled shortcuts for `self`.
    ///
    /// See `TabViewShortcuts` for the list of the available shortcuts. All of
    /// the shortcuts are enabled by default.
    ///
    /// `TabView.addShortcuts` and `TabView.removeShortcuts` provide
    /// a convenient way to manage individual shortcuts.
    extern fn adw_tab_view_set_shortcuts(p_self: *TabView, p_shortcuts: adw.TabViewShortcuts) void;
    pub const setShortcuts = adw_tab_view_set_shortcuts;

    /// Transfers `page` from `self` to `other_view`.
    ///
    /// The `page` object will be reused.
    ///
    /// It's a programmer error to try to insert a pinned page after a non-pinned
    /// one, or a non-pinned page before a pinned one.
    extern fn adw_tab_view_transfer_page(p_self: *TabView, p_page: *adw.TabPage, p_other_view: *adw.TabView, p_position: c_int) void;
    pub const transferPage = adw_tab_view_transfer_page;

    extern fn adw_tab_view_get_type() usize;
    pub const getGObjectType = adw_tab_view_get_type;

    extern fn g_object_ref(p_self: *adw.TabView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TabView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TabView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A time-based `Animation`.
///
/// `AdwTimedAnimation` implements a simple animation interpolating the given
/// value from `TimedAnimation.properties.value_from` to
/// `TimedAnimation.properties.value_to` over
/// `TimedAnimation.properties.duration` milliseconds using the curve described by
/// `TimedAnimation.properties.easing`.
///
/// If `TimedAnimation.properties.reverse` is set to `TRUE`, `AdwTimedAnimation`
/// will instead animate from `TimedAnimation.properties.value_to` to
/// `TimedAnimation.properties.value_from`, and the easing curve will be inverted.
///
/// The animation can repeat a certain amount of times, or endlessly, depending
/// on the `TimedAnimation.properties.repeat_count` value. If
/// `TimedAnimation.properties.alternate` is set to `TRUE`, it will also change the
/// direction every other iteration.
pub const TimedAnimation = opaque {
    pub const Parent = adw.Animation;
    pub const Implements = [_]type{};
    pub const Class = adw.TimedAnimationClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the animation changes direction on every iteration.
        pub const alternate = struct {
            pub const name = "alternate";

            pub const Type = c_int;
        };

        /// Duration of the animation, in milliseconds.
        ///
        /// Describes how much time the animation will take.
        ///
        /// If the animation repeats more than once, describes the duration of one
        /// iteration.
        pub const duration = struct {
            pub const name = "duration";

            pub const Type = c_uint;
        };

        /// Easing function used in the animation.
        ///
        /// Describes the curve the value is interpolated on.
        ///
        /// See `Easing` for the description of specific easing functions.
        pub const easing = struct {
            pub const name = "easing";

            pub const Type = adw.Easing;
        };

        /// Number of times the animation will play.
        ///
        /// If set to 0, the animation will repeat endlessly.
        pub const repeat_count = struct {
            pub const name = "repeat-count";

            pub const Type = c_uint;
        };

        /// Whether the animation plays backwards.
        pub const reverse = struct {
            pub const name = "reverse";

            pub const Type = c_int;
        };

        /// The value to animate from.
        ///
        /// The animation will start at this value and end at
        /// `TimedAnimation.properties.value_to`.
        ///
        /// If `TimedAnimation.properties.reverse` is `TRUE`, the animation will end at
        /// this value instead.
        pub const value_from = struct {
            pub const name = "value-from";

            pub const Type = f64;
        };

        /// The value to animate to.
        ///
        /// The animation will start at `TimedAnimation.properties.value_from` and end at
        /// this value.
        ///
        /// If `TimedAnimation.properties.reverse` is `TRUE`, the animation will start
        /// at this value instead.
        pub const value_to = struct {
            pub const name = "value-to";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwTimedAnimation` on `widget` to animate `target` from `from`
    /// to `to`.
    extern fn adw_timed_animation_new(p_widget: *gtk.Widget, p_from: f64, p_to: f64, p_duration: c_uint, p_target: *adw.AnimationTarget) *adw.TimedAnimation;
    pub const new = adw_timed_animation_new;

    /// Gets whether `self` changes direction on every iteration.
    extern fn adw_timed_animation_get_alternate(p_self: *TimedAnimation) c_int;
    pub const getAlternate = adw_timed_animation_get_alternate;

    /// Gets the duration of `self`.
    extern fn adw_timed_animation_get_duration(p_self: *TimedAnimation) c_uint;
    pub const getDuration = adw_timed_animation_get_duration;

    /// Gets the easing function `self` uses.
    extern fn adw_timed_animation_get_easing(p_self: *TimedAnimation) adw.Easing;
    pub const getEasing = adw_timed_animation_get_easing;

    /// Gets the number of times `self` will play.
    extern fn adw_timed_animation_get_repeat_count(p_self: *TimedAnimation) c_uint;
    pub const getRepeatCount = adw_timed_animation_get_repeat_count;

    /// Gets whether `self` plays backwards.
    extern fn adw_timed_animation_get_reverse(p_self: *TimedAnimation) c_int;
    pub const getReverse = adw_timed_animation_get_reverse;

    /// Gets the value `self` will animate from.
    extern fn adw_timed_animation_get_value_from(p_self: *TimedAnimation) f64;
    pub const getValueFrom = adw_timed_animation_get_value_from;

    /// Gets the value `self` will animate to.
    extern fn adw_timed_animation_get_value_to(p_self: *TimedAnimation) f64;
    pub const getValueTo = adw_timed_animation_get_value_to;

    /// Sets whether `self` changes direction on every iteration.
    extern fn adw_timed_animation_set_alternate(p_self: *TimedAnimation, p_alternate: c_int) void;
    pub const setAlternate = adw_timed_animation_set_alternate;

    /// Sets the duration of `self`.
    ///
    /// If the animation repeats more than once, sets the duration of one iteration.
    extern fn adw_timed_animation_set_duration(p_self: *TimedAnimation, p_duration: c_uint) void;
    pub const setDuration = adw_timed_animation_set_duration;

    /// Sets the easing function `self` will use.
    ///
    /// See `Easing` for the description of specific easing functions.
    extern fn adw_timed_animation_set_easing(p_self: *TimedAnimation, p_easing: adw.Easing) void;
    pub const setEasing = adw_timed_animation_set_easing;

    /// Sets the number of times `self` will play.
    ///
    /// If set to 0, `self` will repeat endlessly.
    extern fn adw_timed_animation_set_repeat_count(p_self: *TimedAnimation, p_repeat_count: c_uint) void;
    pub const setRepeatCount = adw_timed_animation_set_repeat_count;

    /// Sets whether `self` plays backwards.
    extern fn adw_timed_animation_set_reverse(p_self: *TimedAnimation, p_reverse: c_int) void;
    pub const setReverse = adw_timed_animation_set_reverse;

    /// Sets the value `self` will animate from.
    ///
    /// The animation will start at this value and end at
    /// `TimedAnimation.properties.value_to`.
    ///
    /// If `TimedAnimation.properties.reverse` is `TRUE`, the animation will end at
    /// this value instead.
    extern fn adw_timed_animation_set_value_from(p_self: *TimedAnimation, p_value: f64) void;
    pub const setValueFrom = adw_timed_animation_set_value_from;

    /// Sets the value `self` will animate to.
    ///
    /// The animation will start at `TimedAnimation.properties.value_from` and end at
    /// this value.
    ///
    /// If `TimedAnimation.properties.reverse` is `TRUE`, the animation will start
    /// at this value instead.
    extern fn adw_timed_animation_set_value_to(p_self: *TimedAnimation, p_value: f64) void;
    pub const setValueTo = adw_timed_animation_set_value_to;

    extern fn adw_timed_animation_get_type() usize;
    pub const getGObjectType = adw_timed_animation_get_type;

    extern fn g_object_ref(p_self: *adw.TimedAnimation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.TimedAnimation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TimedAnimation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A helper object for `ToastOverlay`.
///
/// Toasts are meant to be passed into `ToastOverlay.addToast` as
/// follows:
///
/// ```c
/// adw_toast_overlay_add_toast (overlay, adw_toast_new (_("Simple Toast")));
/// ```
///
/// <picture>
///   <source srcset="toast-simple-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toast-simple.png" alt="toast-simple">
/// </picture>
///
/// Toasts always have a close button. They emit the `Toast.signals.dismissed`
/// signal when disappearing.
///
/// `Toast.properties.timeout` determines how long the toast stays on screen, while
/// `Toast.properties.priority` determines how it behaves if another toast is
/// already being displayed.
///
/// Toast titles use Pango markup by default, set `Toast.properties.use_markup` to
/// `FALSE` if this is unwanted.
///
/// `Toast.properties.custom_title` can be used to replace the title label with a
/// custom widget.
///
/// ## Actions
///
/// Toasts can have one button on them, with a label and an attached
/// `gio.Action`.
///
/// ```c
/// AdwToast *toast = adw_toast_new (_("Toast with Action"));
///
/// adw_toast_set_button_label (toast, _("_Example"));
/// adw_toast_set_action_name (toast, "win.example");
///
/// adw_toast_overlay_add_toast (overlay, toast);
/// ```
///
/// <picture>
///   <source srcset="toast-action-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toast-action.png" alt="toast-action">
/// </picture>
///
/// ## Modifying toasts
///
/// Toasts can be modified after they have been shown. For this, an `AdwToast`
/// reference must be kept around while the toast is visible.
///
/// A common use case for this is using toasts as undo prompts that stack with
/// each other, allowing to batch undo the last deleted items:
///
/// ```c
///
/// static void
/// toast_undo_cb (GtkWidget  *sender,
///                const char *action,
///                GVariant   *param)
/// {
///   // Undo the deletion
/// }
///
/// static void
/// dismissed_cb (MyWindow *self)
/// {
///   self->undo_toast = NULL;
///
///   // Permanently delete the items
/// }
///
/// static void
/// delete_item (MyWindow *self,
///              MyItem   *item)
/// {
///   g_autofree char *title = NULL;
///   int n_items;
///
///   // Mark the item as waiting for deletion
///   n_items = ... // The number of waiting items
///
///   if (!self->undo_toast) {
///     self->undo_toast = adw_toast_new_format (_("‘`s`’ deleted"), ...);
///
///     adw_toast_set_priority (self->undo_toast, ADW_TOAST_PRIORITY_HIGH);
///     adw_toast_set_button_label (self->undo_toast, _("_Undo"));
///     adw_toast_set_action_name (self->undo_toast, "toast.undo");
///
///     g_signal_connect_swapped (self->undo_toast, "dismissed",
///                               G_CALLBACK (dismissed_cb), self);
///
///     adw_toast_overlay_add_toast (self->toast_overlay, self->undo_toast);
///
///     return;
///   }
///
///   title =
///     g_strdup_printf (ngettext ("<span font_features='tnum=1'>`d`</span> item deleted",
///                                "<span font_features='tnum=1'>`d`</span> items deleted",
///                                n_items), n_items);
///
///   adw_toast_set_title (self->undo_toast, title);
///
///   // Bump the toast timeout
///   adw_toast_overlay_add_toast (self->toast_overlay, g_object_ref (self->undo_toast));
/// }
///
/// static void
/// my_window_class_init (MyWindowClass *klass)
/// {
///   GtkWidgetClass *widget_class = GTK_WIDGET_CLASS (klass);
///
///   gtk_widget_class_install_action (widget_class, "toast.undo", NULL, toast_undo_cb);
/// }
/// ```
///
/// <picture>
///   <source srcset="toast-undo-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toast-undo.png" alt="toast-undo">
/// </picture>
pub const Toast = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.ToastClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The name of the associated action.
        ///
        /// It will be activated when clicking the button.
        ///
        /// See `Toast.properties.action_target`.
        pub const action_name = struct {
            pub const name = "action-name";

            pub const Type = ?[*:0]u8;
        };

        /// The parameter for action invocations.
        pub const action_target = struct {
            pub const name = "action-target";

            pub const Type = ?*glib.Variant;
        };

        /// The label to show on the button.
        ///
        /// Underlines in the button text can be used to indicate a mnemonic.
        ///
        /// If set to `NULL`, the button won't be shown.
        ///
        /// See `Toast.properties.action_name`.
        pub const button_label = struct {
            pub const name = "button-label";

            pub const Type = ?[*:0]u8;
        };

        /// The custom title widget.
        ///
        /// It will be displayed instead of the title if set. In this case,
        /// `Toast.properties.title` is ignored.
        ///
        /// Setting a custom title will unset `Toast.properties.title`.
        pub const custom_title = struct {
            pub const name = "custom-title";

            pub const Type = ?*gtk.Widget;
        };

        /// The priority of the toast.
        ///
        /// Priority controls how the toast behaves when another toast is already
        /// being displayed.
        ///
        /// If the priority is `ADW_TOAST_PRIORITY_NORMAL`, the toast will be queued.
        ///
        /// If the priority is `ADW_TOAST_PRIORITY_HIGH`, the toast will be displayed
        /// immediately, pushing the previous toast into the queue instead.
        pub const priority = struct {
            pub const name = "priority";

            pub const Type = adw.ToastPriority;
        };

        /// The timeout of the toast, in seconds.
        ///
        /// If timeout is 0, the toast is displayed indefinitely until manually
        /// dismissed.
        ///
        /// Toasts cannot disappear while being hovered, pressed (on touchscreen), or
        /// have keyboard focus inside them.
        pub const timeout = struct {
            pub const name = "timeout";

            pub const Type = c_uint;
        };

        /// The title of the toast.
        ///
        /// The title can be marked up with the Pango text markup language.
        ///
        /// Setting a title will unset `Toast.properties.custom_title`.
        ///
        /// If `Toast.properties.custom_title` is set, it will be used instead.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether to use Pango markup for the toast title.
        ///
        /// See also `pango.parseMarkup`.
        pub const use_markup = struct {
            pub const name = "use-markup";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted after the button has been clicked.
        ///
        /// It can be used as an alternative to setting an action.
        pub const button_clicked = struct {
            pub const name = "button-clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Toast, p_instance))),
                    gobject.signalLookup("button-clicked", Toast.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the toast has been dismissed.
        pub const dismissed = struct {
            pub const name = "dismissed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Toast, p_instance))),
                    gobject.signalLookup("dismissed", Toast.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `AdwToast`.
    ///
    /// The toast will use `title` as its title.
    ///
    /// `title` can be marked up with the Pango text markup language.
    extern fn adw_toast_new(p_title: [*:0]const u8) *adw.Toast;
    pub const new = adw_toast_new;

    /// Creates a new `AdwToast`.
    ///
    /// The toast will use the format string as its title.
    ///
    /// See also: `Toast.new`
    extern fn adw_toast_new_format(p_format: [*:0]const u8, ...) *adw.Toast;
    pub const newFormat = adw_toast_new_format;

    /// Dismisses `self`.
    ///
    /// Does nothing if `self` has already been dismissed, or hasn't been added to an
    /// `ToastOverlay`.
    extern fn adw_toast_dismiss(p_self: *Toast) void;
    pub const dismiss = adw_toast_dismiss;

    /// Gets the name of the associated action.
    extern fn adw_toast_get_action_name(p_self: *Toast) ?[*:0]const u8;
    pub const getActionName = adw_toast_get_action_name;

    /// Gets the parameter for action invocations.
    extern fn adw_toast_get_action_target_value(p_self: *Toast) ?*glib.Variant;
    pub const getActionTargetValue = adw_toast_get_action_target_value;

    /// Gets the label to show on the button.
    extern fn adw_toast_get_button_label(p_self: *Toast) ?[*:0]const u8;
    pub const getButtonLabel = adw_toast_get_button_label;

    /// Gets the custom title widget of `self`.
    extern fn adw_toast_get_custom_title(p_self: *Toast) ?*gtk.Widget;
    pub const getCustomTitle = adw_toast_get_custom_title;

    /// Gets priority for `self`.
    extern fn adw_toast_get_priority(p_self: *Toast) adw.ToastPriority;
    pub const getPriority = adw_toast_get_priority;

    /// Gets timeout for `self`.
    extern fn adw_toast_get_timeout(p_self: *Toast) c_uint;
    pub const getTimeout = adw_toast_get_timeout;

    /// Gets the title that will be displayed on the toast.
    ///
    /// If a custom title has been set with `adw.Toast.setCustomTitle`
    /// the return value will be `NULL`.
    extern fn adw_toast_get_title(p_self: *Toast) ?[*:0]const u8;
    pub const getTitle = adw_toast_get_title;

    /// Gets whether to use Pango markup for the toast title.
    extern fn adw_toast_get_use_markup(p_self: *Toast) c_int;
    pub const getUseMarkup = adw_toast_get_use_markup;

    /// Sets the name of the associated action.
    ///
    /// It will be activated when clicking the button.
    ///
    /// See `Toast.properties.action_target`.
    extern fn adw_toast_set_action_name(p_self: *Toast, p_action_name: ?[*:0]const u8) void;
    pub const setActionName = adw_toast_set_action_name;

    /// Sets the parameter for action invocations.
    ///
    /// This is a convenience function that calls `glib.Variant.new` for
    /// `format_string` and uses the result to call
    /// `Toast.setActionTargetValue`.
    ///
    /// If you are setting a string-valued target and want to set
    /// the action name at the same time, you can use
    /// `Toast.setDetailedActionName`.
    extern fn adw_toast_set_action_target(p_self: *Toast, p_format_string: ?[*:0]const u8, ...) void;
    pub const setActionTarget = adw_toast_set_action_target;

    /// Sets the parameter for action invocations.
    ///
    /// If the `action_target` variant has a floating reference this function
    /// will sink it.
    extern fn adw_toast_set_action_target_value(p_self: *Toast, p_action_target: ?*glib.Variant) void;
    pub const setActionTargetValue = adw_toast_set_action_target_value;

    /// Sets the label to show on the button.
    ///
    /// Underlines in the button text can be used to indicate a mnemonic.
    ///
    /// If set to `NULL`, the button won't be shown.
    ///
    /// See `Toast.properties.action_name`.
    extern fn adw_toast_set_button_label(p_self: *Toast, p_button_label: ?[*:0]const u8) void;
    pub const setButtonLabel = adw_toast_set_button_label;

    /// Sets the custom title widget of `self`.
    ///
    /// It will be displayed instead of the title if set. In this case,
    /// `Toast.properties.title` is ignored.
    ///
    /// Setting a custom title will unset `Toast.properties.title`.
    extern fn adw_toast_set_custom_title(p_self: *Toast, p_widget: ?*gtk.Widget) void;
    pub const setCustomTitle = adw_toast_set_custom_title;

    /// Sets the action name and its parameter.
    ///
    /// `detailed_action_name` is a string in the format accepted by
    /// `gio.Action.parseDetailedName`.
    extern fn adw_toast_set_detailed_action_name(p_self: *Toast, p_detailed_action_name: ?[*:0]const u8) void;
    pub const setDetailedActionName = adw_toast_set_detailed_action_name;

    /// Sets priority for `self`.
    ///
    /// Priority controls how the toast behaves when another toast is already
    /// being displayed.
    ///
    /// If `priority` is `ADW_TOAST_PRIORITY_NORMAL`, the toast will be queued.
    ///
    /// If `priority` is `ADW_TOAST_PRIORITY_HIGH`, the toast will be displayed
    /// immediately, pushing the previous toast into the queue instead.
    extern fn adw_toast_set_priority(p_self: *Toast, p_priority: adw.ToastPriority) void;
    pub const setPriority = adw_toast_set_priority;

    /// Sets timeout for `self`.
    ///
    /// If `timeout` is 0, the toast is displayed indefinitely until manually
    /// dismissed.
    ///
    /// Toasts cannot disappear while being hovered, pressed (on touchscreen), or
    /// have keyboard focus inside them.
    extern fn adw_toast_set_timeout(p_self: *Toast, p_timeout: c_uint) void;
    pub const setTimeout = adw_toast_set_timeout;

    /// Sets the title that will be displayed on the toast.
    ///
    /// The title can be marked up with the Pango text markup language.
    ///
    /// Setting a title will unset `Toast.properties.custom_title`.
    ///
    /// If `Toast.properties.custom_title` is set, it will be used instead.
    extern fn adw_toast_set_title(p_self: *Toast, p_title: [*:0]const u8) void;
    pub const setTitle = adw_toast_set_title;

    /// Whether to use Pango markup for the toast title.
    ///
    /// See also `pango.parseMarkup`.
    extern fn adw_toast_set_use_markup(p_self: *Toast, p_use_markup: c_int) void;
    pub const setUseMarkup = adw_toast_set_use_markup;

    extern fn adw_toast_get_type() usize;
    pub const getGObjectType = adw_toast_get_type;

    extern fn g_object_ref(p_self: *adw.Toast) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Toast) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Toast, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget showing toasts above its content.
///
/// <picture>
///   <source srcset="toast-overlay-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toast-overlay.png" alt="toast-overlay">
/// </picture>
///
/// Much like `gtk.Overlay`, `AdwToastOverlay` is a container with a single
/// main child, on top of which it can display a `Toast`, overlaid.
/// Toasts can be shown with `ToastOverlay.addToast`.
///
/// Use `ToastOverlay.dismissAll` to dismiss all toasts at once, or
/// `Toast.dismiss` to dismiss a single toast.
///
/// See `Toast` for details.
///
/// ## CSS nodes
///
/// ```
/// toastoverlay
/// ├── [child]
/// ├── toast
/// ┊   ├── widget
/// ┊   │   ├── [label.heading]
///     │   ╰── [custom title]
///     ├── [button]
///     ╰── button.circular.flat
/// ```
///
/// `AdwToastOverlay`'s CSS node is called `toastoverlay`. It contains the child,
/// as well as zero or more `toast` subnodes.
///
/// Each of the `toast` nodes contains a `widget` subnode, optionally a `button`
/// subnode, and another `button` subnode with `.circular` and `.flat` style
/// classes.
///
/// The `widget` subnode contains a `label` subnode with the `.heading` style
/// class, or a custom widget provided by the application.
///
/// ## Accessibility
///
/// `AdwToastOverlay` uses the `gtk.@"AccessibleRole.GROUP"` role.
pub const ToastOverlay = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ToastOverlayClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The child widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwToastOverlay`.
    extern fn adw_toast_overlay_new() *adw.ToastOverlay;
    pub const new = adw_toast_overlay_new;

    /// Displays `toast`.
    ///
    /// Only one toast can be shown at a time; if a toast is already being displayed,
    /// either `toast` or the original toast will be placed in a queue, depending on
    /// the priority of `toast`. See `Toast.properties.priority`.
    ///
    /// If called on a toast that's already displayed, its timeout will be reset.
    ///
    /// If called on a toast currently in the queue, the toast will be bumped
    /// forward to be shown as soon as possible.
    extern fn adw_toast_overlay_add_toast(p_self: *ToastOverlay, p_toast: *adw.Toast) void;
    pub const addToast = adw_toast_overlay_add_toast;

    /// Dismisses all displayed toasts.
    ///
    /// Use `Toast.dismiss` to dismiss a single toast.
    extern fn adw_toast_overlay_dismiss_all(p_self: *ToastOverlay) void;
    pub const dismissAll = adw_toast_overlay_dismiss_all;

    /// Gets the child widget of `self`.
    extern fn adw_toast_overlay_get_child(p_self: *ToastOverlay) ?*gtk.Widget;
    pub const getChild = adw_toast_overlay_get_child;

    /// Sets the child widget of `self`.
    extern fn adw_toast_overlay_set_child(p_self: *ToastOverlay, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_toast_overlay_set_child;

    extern fn adw_toast_overlay_get_type() usize;
    pub const getGObjectType = adw_toast_overlay_get_type;

    extern fn g_object_ref(p_self: *adw.ToastOverlay) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ToastOverlay) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ToastOverlay, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A toggle within `ToggleGroup`.
///
/// `AdwToggle` can optionally have a name, set with `Toggle.properties.name`.
/// If the name is set, `ToggleGroup.properties.active_name` can be used to access
/// toggles instead of index.
pub const Toggle = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = adw.ToggleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The toggle child.
        ///
        /// When the child is set, icon and label are not displayed.
        ///
        /// It's recommended to still set the label, as it can still be used by the
        /// screen reader.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether this toggle is enabled.
        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };

        /// The toggle icon name.
        ///
        /// The icon will be displayed alone or next to the label, unless
        /// `Toggle.properties.child` is set.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The toggle label.
        ///
        /// The label will be displayed alone or next to the icon, unless
        /// `Toggle.properties.child` is set, but will still be read out by the screen
        /// reader.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The toggle name.
        ///
        /// Allows accessing the toggle by its name instead of index.
        ///
        /// See `ToggleGroup.properties.active_name`.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The tooltip of the toggle.
        ///
        /// The tooltip can be marked up with the Pango text markup language.
        pub const tooltip = struct {
            pub const name = "tooltip";

            pub const Type = ?[*:0]u8;
        };

        /// Whether an embedded underline in the label indicates a mnemonic.
        ///
        /// See `Toggle.properties.label`.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwToggle`.
    extern fn adw_toggle_new() *adw.Toggle;
    pub const new = adw_toggle_new;

    /// Gets the child widget of `self`.
    extern fn adw_toggle_get_child(p_self: *Toggle) ?*gtk.Widget;
    pub const getChild = adw_toggle_get_child;

    /// Gets whether `self` is enabled.
    extern fn adw_toggle_get_enabled(p_self: *Toggle) c_int;
    pub const getEnabled = adw_toggle_get_enabled;

    /// Gets the icon name of `self`.
    extern fn adw_toggle_get_icon_name(p_self: *Toggle) ?[*:0]const u8;
    pub const getIconName = adw_toggle_get_icon_name;

    /// Gets the index of `self` within its toggle group.
    extern fn adw_toggle_get_index(p_self: *Toggle) c_uint;
    pub const getIndex = adw_toggle_get_index;

    /// Gets the label of `self`.
    extern fn adw_toggle_get_label(p_self: *Toggle) ?[*:0]const u8;
    pub const getLabel = adw_toggle_get_label;

    /// Gets the name of `self`.
    extern fn adw_toggle_get_name(p_self: *Toggle) [*:0]const u8;
    pub const getName = adw_toggle_get_name;

    /// Gets the tooltip of `self`.
    extern fn adw_toggle_get_tooltip(p_self: *Toggle) [*:0]const u8;
    pub const getTooltip = adw_toggle_get_tooltip;

    /// Gets whether `self` uses underlines.
    extern fn adw_toggle_get_use_underline(p_self: *Toggle) c_int;
    pub const getUseUnderline = adw_toggle_get_use_underline;

    /// Sets the child of `self` to `child`.
    ///
    /// When the child is set, icon and label are not displayed.
    ///
    /// It's recommended to still set the label, as it can still be used by the
    /// screen reader.
    extern fn adw_toggle_set_child(p_self: *Toggle, p_child: ?*gtk.Widget) void;
    pub const setChild = adw_toggle_set_child;

    /// Sets whether `self` is enabled.
    extern fn adw_toggle_set_enabled(p_self: *Toggle, p_enabled: c_int) void;
    pub const setEnabled = adw_toggle_set_enabled;

    /// Sets the icon name of `self` to `icon_name`.
    ///
    /// The icon will be displayed alone or next to the label, unless
    /// `Toggle.properties.child` is set.
    extern fn adw_toggle_set_icon_name(p_self: *Toggle, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_toggle_set_icon_name;

    /// Sets the label of `self` to `label`.
    ///
    /// The label will be displayed alone or next to the icon, unless
    /// `Toggle.properties.child` is set, but will still be read out by the screen
    /// reader.
    extern fn adw_toggle_set_label(p_self: *Toggle, p_label: ?[*:0]const u8) void;
    pub const setLabel = adw_toggle_set_label;

    /// Sets the name of `self` to `name`.
    ///
    /// Allows accessing `self` by its name instead of index.
    ///
    /// See `ToggleGroup.properties.active_name`.
    extern fn adw_toggle_set_name(p_self: *Toggle, p_name: ?[*:0]const u8) void;
    pub const setName = adw_toggle_set_name;

    /// Sets the tooltip of `self` to `tooltip`.
    ///
    /// `tooltip` can be marked up with the Pango text markup language.
    extern fn adw_toggle_set_tooltip(p_self: *Toggle, p_tooltip: [*:0]const u8) void;
    pub const setTooltip = adw_toggle_set_tooltip;

    /// Sets whether an embedded underline in the label indicates a mnemonic.
    ///
    /// See `Toggle.properties.label`.
    extern fn adw_toggle_set_use_underline(p_self: *Toggle, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_toggle_set_use_underline;

    extern fn adw_toggle_get_type() usize;
    pub const getGObjectType = adw_toggle_get_type;

    extern fn g_object_ref(p_self: *adw.Toggle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Toggle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Toggle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A group of exclusive toggles.
///
/// <picture>
///   <source srcset="toggle-group-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toggle-group.png" alt="toggle-group">
/// </picture>
///
/// `AdwToggleGroup` presents a set of exclusive toggles, represented as
/// `Toggle` objects. Each toggle can display an icon, a label, an icon
/// and a label, or a custom child.
///
/// Toggles are indexed by their position, with the first toggle being equivalent
/// to 0, and so on. Use the `ToggleGroup.properties.active` to get that position.
///
/// Toggles can also have optional names, set via the `Toggle.properties.name`
/// property. The name of the active toggle can be accessed via the
/// `ToggleGroup.properties.active_name` property.
///
/// `AdwToggle` objects can be retrieved via their index or name, using
/// `ToggleGroup.getToggle` or `ToggleGroup.getToggleByName`
/// respectively. `AdwToggleGroup` also provides a `gtk.SelectionModel` of
/// its toggles via the `ToggleGroup.properties.toggles` property.
///
/// `AdwToggleGroup` is orientable, and the toggles can be displayed horizontally
/// or vertically. This is mostly useful for icon-only toggles.
///
/// Use the `ToggleGroup.properties.homogeneous` property to make the toggles take
/// the same size, and the `ToggleGroup.properties.can_shrink` to control whether
/// the toggles can ellipsize.
///
/// Example of an `AdwToggleGroup` UI definition:
///
/// ```xml
///  <object class="AdwToggleGroup">
///    <property name="active-name">picture</property>
///    <child>
///      <object class="AdwToggle">
///        <property name="icon-name">camera-photo-symbolic</property>
///        <property name="tooltip" translatable="yes">Picture Mode</property>
///        <property name="name">picture</property>
///      </object>
///    </child>
///    <child>
///      <object class="AdwToggle">
///        <property name="icon-name">camera-video-symbolic</property>
///        <property name="tooltip" translatable="yes">Recording Mode</property>
///        <property name="name">recording</property>
///      </object>
///    </child>
///  </object>
/// ```
///
/// See also: `InlineViewSwitcher`.
///
/// ## CSS nodes
///
/// `AdwToggleGroup` has a main CSS node with the name `toggle-group`.
///
/// Its toggles have CSS nodes with the name `toggle`, and its separators have nodes
/// with the name `separator`.
///
/// Toggle nodes will have a different style classes depending on their content:
/// `.text-button` for labels, `.image-button` for icons, `.image-text-button`
/// for both or no style class for custom children.
///
/// The hidden separators use the `.hidden` style class.
///
/// ## Style classes
///
/// `AdwToggleGroup` can use the [`.flat`](style-classes.html`flat_1`) style class
/// to remove its background and make it look like a group of buttons.
///
/// <picture>
///   <source srcset="toggle-group-flat-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toggle-group-flat.png" alt="toggle-group-flat">
/// </picture>
///
/// It can also use the [`.round`](style-classes.html`round`) style class to make
/// its toggles and the group itself rounded.
///
/// <picture>
///   <source srcset="toggle-group-round-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toggle-group-round.png" alt="toggle-group-round">
/// </picture>
///
/// They can also be combined with each other.
///
/// <picture>
///   <source srcset="toggle-group-flat-round-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toggle-group-flat-round.png" alt="toggle-group-flat-round">
/// </picture>
///
/// ## Accessibility
///
/// `AdwToggleGroup` uses the `GTK_ACCESSIBLE_ROLE_RADIO_GROUP` role. Its toggles
/// use the `GTK_ACCESSIBLE_ROLE_RADIO` role.
pub const ToggleGroup = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.ToggleGroupClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The index of the active toggle.
        ///
        /// Setting the index to a larger value than the number of toggles in the group
        /// unsets the current active toggle.
        ///
        /// If no toggle is active, the property will be set to
        /// `gtk.INVALID_LIST_POSITION`.
        pub const active = struct {
            pub const name = "active";

            pub const Type = c_uint;
        };

        /// The name of the active toggle.
        ///
        /// The name can be set via `Toggle.properties.name`. If the currently active
        /// toggle doesn't have a name, the property will be set to `NULL`.
        ///
        /// Set it to `NULL` to unset the current active toggle.
        pub const active_name = struct {
            pub const name = "active-name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the toggles can be smaller than the natural size of their contents.
        ///
        /// If set to `TRUE`, the toggle labels will ellipsize.
        ///
        /// See `gtk.Button.properties.can_shrink`.
        pub const can_shrink = struct {
            pub const name = "can-shrink";

            pub const Type = c_int;
        };

        /// Whether all toggles take the same size.
        pub const homogeneous = struct {
            pub const name = "homogeneous";

            pub const Type = c_int;
        };

        /// The number of toggles within the group.
        pub const n_toggles = struct {
            pub const name = "n-toggles";

            pub const Type = c_uint;
        };

        /// A selection model with the groups's toggles.
        ///
        /// This can be used to keep an up-to-date view. The model also implements
        /// `gtk.SelectionModel` and can be used to track and change the active
        /// toggle.
        pub const toggles = struct {
            pub const name = "toggles";

            pub const Type = ?*gtk.SelectionModel;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwToggleGroup`.
    extern fn adw_toggle_group_new() *adw.ToggleGroup;
    pub const new = adw_toggle_group_new;

    /// Adds a toggle to `self`.
    extern fn adw_toggle_group_add(p_self: *ToggleGroup, p_toggle: *adw.Toggle) void;
    pub const add = adw_toggle_group_add;

    /// Gets the index of the active toggle in `self`.
    ///
    /// Returns `GTK_INVALID_LIST_POSITION` if no toggle is active.
    extern fn adw_toggle_group_get_active(p_self: *ToggleGroup) c_uint;
    pub const getActive = adw_toggle_group_get_active;

    /// Gets the name of the active toggle in `self`.
    ///
    /// Can be `NULL` if the currently active toggle doesn't have a name.
    ///
    /// See `Toggle.properties.name`.
    extern fn adw_toggle_group_get_active_name(p_self: *ToggleGroup) ?[*:0]const u8;
    pub const getActiveName = adw_toggle_group_get_active_name;

    /// Gets whether the toggles can be smaller than the natural size of their
    /// contents.
    extern fn adw_toggle_group_get_can_shrink(p_self: *ToggleGroup) c_int;
    pub const getCanShrink = adw_toggle_group_get_can_shrink;

    /// Gets whether all toggles take the same size.
    extern fn adw_toggle_group_get_homogeneous(p_self: *ToggleGroup) c_int;
    pub const getHomogeneous = adw_toggle_group_get_homogeneous;

    /// Gets the number of toggles within `self`.
    extern fn adw_toggle_group_get_n_toggles(p_self: *ToggleGroup) c_uint;
    pub const getNToggles = adw_toggle_group_get_n_toggles;

    /// Gets the toggle with `index` from `self`.
    extern fn adw_toggle_group_get_toggle(p_self: *ToggleGroup, p_index: c_uint) ?*adw.Toggle;
    pub const getToggle = adw_toggle_group_get_toggle;

    /// Gets the toggle with the name `name` from `self`.
    extern fn adw_toggle_group_get_toggle_by_name(p_self: *ToggleGroup, p_name: [*:0]const u8) ?*adw.Toggle;
    pub const getToggleByName = adw_toggle_group_get_toggle_by_name;

    /// Returns a `gio.ListModel` that contains the toggles of the group.
    ///
    /// This can be used to keep an up-to-date view. The model also implements
    /// `gtk.SelectionModel` and can be used to track and change the active
    /// toggle.
    extern fn adw_toggle_group_get_toggles(p_self: *ToggleGroup) *gtk.SelectionModel;
    pub const getToggles = adw_toggle_group_get_toggles;

    /// Removes `toggle` from `self`.
    extern fn adw_toggle_group_remove(p_self: *ToggleGroup, p_toggle: *adw.Toggle) void;
    pub const remove = adw_toggle_group_remove;

    /// Removes all toggles from `self`.
    extern fn adw_toggle_group_remove_all(p_self: *ToggleGroup) void;
    pub const removeAll = adw_toggle_group_remove_all;

    /// Sets the active toggle for `self`.
    ///
    /// If the index is larger than the number of toggles in `self`, unsets the
    /// current active toggle.
    extern fn adw_toggle_group_set_active(p_self: *ToggleGroup, p_active: c_uint) void;
    pub const setActive = adw_toggle_group_set_active;

    /// Sets the active toggle for `self`.
    ///
    /// The name can be set via `Toggle.properties.name`.
    ///
    /// If `name` is `NULL`, unset the current active toggle instead.
    extern fn adw_toggle_group_set_active_name(p_self: *ToggleGroup, p_name: ?[*:0]const u8) void;
    pub const setActiveName = adw_toggle_group_set_active_name;

    /// Sets whether the toggles can be smaller than the natural size of their
    /// contents.
    ///
    /// If `can_shrink` is `TRUE`, the toggle labels will ellipsize.
    ///
    /// See `gtk.Button.properties.can_shrink`.
    extern fn adw_toggle_group_set_can_shrink(p_self: *ToggleGroup, p_can_shrink: c_int) void;
    pub const setCanShrink = adw_toggle_group_set_can_shrink;

    /// Sets whether all toggles take the same size.
    extern fn adw_toggle_group_set_homogeneous(p_self: *ToggleGroup, p_homogeneous: c_int) void;
    pub const setHomogeneous = adw_toggle_group_set_homogeneous;

    extern fn adw_toggle_group_get_type() usize;
    pub const getGObjectType = adw_toggle_group_get_type;

    extern fn g_object_ref(p_self: *adw.ToggleGroup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ToggleGroup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ToggleGroup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget containing a page, as well as top and/or bottom bars.
///
/// <picture>
///   <source srcset="toolbar-view-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view.png" alt="toolbar-view">
/// </picture>
///
/// `AdwToolbarView` has a single content widget and one or multiple top and
/// bottom bars, shown at the top and bottom sides respectively.
///
/// Example of an `AdwToolbarView` UI definition:
/// ```xml
/// <object class="AdwToolbarView">
///   <child type="top">
///     <object class="AdwHeaderBar"/>
///   </child>
///   <property name="content">
///     <object class="AdwPreferencesPage">
///       <!-- ... -->
///     </object>
///   </property>
/// </object>
/// ```
///
/// The following kinds of top and bottom bars are supported:
///
/// - `HeaderBar`
/// - `TabBar`
/// - `ViewSwitcherBar`
/// - `gtk.ActionBar`
/// - `gtk.HeaderBar`
/// - `gtk.PopoverMenuBar`
/// - `gtk.SearchBar`
/// - Any `gtk.Box` or a similar widget with the
///   [`.toolbar`](style-classes.html`toolbars`) style class
///
/// By default, top and bottom bars are flat and scrolling content has a subtle
/// undershoot shadow, same as when using the
/// [`.undershoot-top`](style-classes.html`undershoot`-indicators) and
/// [`.undershoot-bottom`](style-classes.html`undershoot`-indicators) style
/// classes. This works well in most cases, e.g. with `StatusPage` or
/// `PreferencesPage`, where the background at the top and bottom parts of
/// the page is uniform. Additionally, windows with sidebars should always use
/// this style.
///
/// `ToolbarView.properties.top_bar_style` and
/// `ToolbarView.properties.bottom_bar_style` properties can be used add an opaque
/// background and a persistent shadow to top and bottom bars, this can be useful
/// for content such as [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
/// where some elements are adjacent to the top/bottom bars, or `TabView`,
/// where each page can have a different background.
///
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-flat-1-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-flat-1.png" alt="toolbar-view-flat-1">
/// </picture>
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-flat-2-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-flat-2.png" alt="toolbar-view-flat-2">
/// </picture>
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-raised-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-raised.png" alt="toolbar-view-raised">
/// </picture>
///
/// `AdwToolbarView` ensures the top and bottom bars have consistent backdrop
/// styles and vertical spacing. For comparison:
///
/// <picture style="min-width: 40%; display: inline-block;">
///   <source srcset="toolbar-view-spacing-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-spacing.png" alt="toolbar-view-spacing">
/// </picture>
/// <picture style="min-width: 40%; display: inline-block;">
///   <source srcset="toolbar-view-spacing-box-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-spacing-box.png" alt="toolbar-view-spacing-box">
/// </picture>
///
/// Any top and bottom bars can also be dragged to move the window, equivalent
/// to putting them into a `gtk.WindowHandle`.
///
/// Content is typically place between top and bottom bars, but can also extend
/// behind them. This is controlled with the
/// `ToolbarView.properties.extend_content_to_top_edge` and
/// `ToolbarView.properties.extend_content_to_bottom_edge` properties.
///
/// Top and bottom bars can be hidden and revealed with an animation using the
/// `ToolbarView.properties.reveal_top_bars` and
/// `ToolbarView.properties.reveal_bottom_bars` properties.
///
/// ## `AdwToolbarView` as `GtkBuildable`
///
/// The `AdwToolbarView` implementation of the `gtk.Buildable` interface
/// supports adding a top bar by specifying “top” as the “type” attribute of a
/// `<child>` element, or adding a bottom bar by specifying “bottom”.
///
/// ## Accessibility
///
/// `AdwToolbarView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const ToolbarView = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ToolbarViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The current bottom bar height.
        ///
        /// Bottom bar height does change depending on
        /// `ToolbarView.properties.reveal_bottom_bars`, including during the transition.
        ///
        /// See `ToolbarView.properties.top_bar_height`.
        pub const bottom_bar_height = struct {
            pub const name = "bottom-bar-height";

            pub const Type = c_int;
        };

        /// Appearance of the bottom bars.
        ///
        /// If set to `ADW_TOOLBAR_FLAT`, bottom bars are flat and scrolling content
        /// has a subtle undershoot shadow when touching them, same as the
        /// [`.undershoot-bottom`](style-classes.html`undershoot`-indicators)
        /// style class. This works well for simple content, e.g. `StatusPage` or
        /// `PreferencesPage`, where the background at the bottom of the page is
        /// uniform. Additionally, windows with sidebars should always use this style.
        ///
        /// Undershoot shadow is only present if a bottom bar is actually present and
        /// visible. It is also never present if
        /// `ToolbarView.properties.extend_content_to_bottom_edge` is set to `TRUE`.
        ///
        /// If set to `ADW_TOOLBAR_RAISED`, bottom bars have an opaque background and a
        /// persistent shadow, this is suitable for content such as
        /// [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
        /// where some elements are directly adjacent to the bottom bars, or
        /// `TabView`, where each page can have a different background.
        ///
        /// `ADW_TOOLBAR_RAISED_BORDER` is similar to `ADW_TOOLBAR_RAISED`, but the
        /// shadow is replaced with a more subtle border. This can be useful for
        /// applications like image viewers.
        ///
        /// See also `ToolbarView.properties.top_bar_style`.
        pub const bottom_bar_style = struct {
            pub const name = "bottom-bar-style";

            pub const Type = adw.ToolbarStyle;
        };

        /// The content widget.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// Whether the content widget can extend behind bottom bars.
        ///
        /// This can be used in combination with
        /// `ToolbarView.properties.reveal_bottom_bars` to show and hide toolbars in
        /// fullscreen.
        ///
        /// See `ToolbarView.properties.extend_content_to_top_edge`.
        pub const extend_content_to_bottom_edge = struct {
            pub const name = "extend-content-to-bottom-edge";

            pub const Type = c_int;
        };

        /// Whether the content widget can extend behind top bars.
        ///
        /// This can be used in combination with `ToolbarView.properties.reveal_top_bars`
        /// to show and hide toolbars in fullscreen.
        ///
        /// See `ToolbarView.properties.extend_content_to_bottom_edge`.
        pub const extend_content_to_top_edge = struct {
            pub const name = "extend-content-to-top-edge";

            pub const Type = c_int;
        };

        /// Whether bottom bars are visible.
        ///
        /// The transition will be animated.
        ///
        /// This can be used in combination with
        /// `ToolbarView.properties.extend_content_to_bottom_edge` to show and hide
        /// toolbars in fullscreen.
        ///
        /// See `ToolbarView.properties.reveal_top_bars`.
        pub const reveal_bottom_bars = struct {
            pub const name = "reveal-bottom-bars";

            pub const Type = c_int;
        };

        /// Whether top bars are revealed.
        ///
        /// The transition will be animated.
        ///
        /// This can be used in combination with
        /// `ToolbarView.properties.extend_content_to_top_edge` to show and hide toolbars
        /// in fullscreen.
        ///
        /// See `ToolbarView.properties.reveal_bottom_bars`.
        pub const reveal_top_bars = struct {
            pub const name = "reveal-top-bars";

            pub const Type = c_int;
        };

        /// The current top bar height.
        ///
        /// Top bar height does change depending `ToolbarView.properties.reveal_top_bars`,
        /// including during the transition.
        ///
        /// See `ToolbarView.properties.bottom_bar_height`.
        pub const top_bar_height = struct {
            pub const name = "top-bar-height";

            pub const Type = c_int;
        };

        /// Appearance of the top bars.
        ///
        /// If set to `ADW_TOOLBAR_FLAT`, top bars are flat and scrolling content has a
        /// subtle undershoot shadow when touching them, same as the
        /// [`.undershoot-top`](style-classes.html`undershoot`-indicators)
        /// style class. This works well for simple content, e.g. `StatusPage` or
        /// `PreferencesPage`, where the background at the top of the page is
        /// uniform. Additionally, windows with sidebars should always use this style.
        ///
        /// Undershoot shadow is only present if a top bar is actually present and
        /// visible. It is also never present if
        /// `ToolbarView.properties.extend_content_to_top_edge` is set to `TRUE`.
        ///
        /// If set to `ADW_TOOLBAR_RAISED`, top bars have an opaque background and a
        /// persistent shadow, this is suitable for content such as
        /// [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
        /// where some elements are directly adjacent to the top bars, or
        /// `TabView`, where each page can have a different background.
        ///
        /// `ADW_TOOLBAR_RAISED_BORDER` is similar to `ADW_TOOLBAR_RAISED`, but the
        /// shadow is replaced with a more subtle border. This can be useful for
        /// applications like image viewers.
        ///
        /// See also `ToolbarView.properties.bottom_bar_style`.
        pub const top_bar_style = struct {
            pub const name = "top-bar-style";

            pub const Type = adw.ToolbarStyle;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwToolbarView`.
    extern fn adw_toolbar_view_new() *adw.ToolbarView;
    pub const new = adw_toolbar_view_new;

    /// Adds a bottom bar to `self`.
    extern fn adw_toolbar_view_add_bottom_bar(p_self: *ToolbarView, p_widget: *gtk.Widget) void;
    pub const addBottomBar = adw_toolbar_view_add_bottom_bar;

    /// Adds a top bar to `self`.
    extern fn adw_toolbar_view_add_top_bar(p_self: *ToolbarView, p_widget: *gtk.Widget) void;
    pub const addTopBar = adw_toolbar_view_add_top_bar;

    /// Gets the current bottom bar height for `self`.
    ///
    /// Bottom bar height does change depending on
    /// `ToolbarView.properties.reveal_bottom_bars`, including during the transition.
    ///
    /// See `ToolbarView.getTopBarHeight`.
    extern fn adw_toolbar_view_get_bottom_bar_height(p_self: *ToolbarView) c_int;
    pub const getBottomBarHeight = adw_toolbar_view_get_bottom_bar_height;

    /// Gets appearance of the bottom bars for `self`.
    extern fn adw_toolbar_view_get_bottom_bar_style(p_self: *ToolbarView) adw.ToolbarStyle;
    pub const getBottomBarStyle = adw_toolbar_view_get_bottom_bar_style;

    /// Gets the content widget for `self`.
    extern fn adw_toolbar_view_get_content(p_self: *ToolbarView) ?*gtk.Widget;
    pub const getContent = adw_toolbar_view_get_content;

    /// Gets whether the content widget can extend behind bottom bars.
    extern fn adw_toolbar_view_get_extend_content_to_bottom_edge(p_self: *ToolbarView) c_int;
    pub const getExtendContentToBottomEdge = adw_toolbar_view_get_extend_content_to_bottom_edge;

    /// Gets whether the content widget can extend behind top bars.
    extern fn adw_toolbar_view_get_extend_content_to_top_edge(p_self: *ToolbarView) c_int;
    pub const getExtendContentToTopEdge = adw_toolbar_view_get_extend_content_to_top_edge;

    /// Gets whether bottom bars are revealed for `self`.
    extern fn adw_toolbar_view_get_reveal_bottom_bars(p_self: *ToolbarView) c_int;
    pub const getRevealBottomBars = adw_toolbar_view_get_reveal_bottom_bars;

    /// Gets whether top bars are revealed for `self`.
    extern fn adw_toolbar_view_get_reveal_top_bars(p_self: *ToolbarView) c_int;
    pub const getRevealTopBars = adw_toolbar_view_get_reveal_top_bars;

    /// Gets the current top bar height for `self`.
    ///
    /// Top bar height does change depending on
    /// `ToolbarView.properties.reveal_top_bars`, including during the transition.
    ///
    /// See `ToolbarView.getBottomBarHeight`.
    extern fn adw_toolbar_view_get_top_bar_height(p_self: *ToolbarView) c_int;
    pub const getTopBarHeight = adw_toolbar_view_get_top_bar_height;

    /// Gets appearance of the top bars for `self`.
    extern fn adw_toolbar_view_get_top_bar_style(p_self: *ToolbarView) adw.ToolbarStyle;
    pub const getTopBarStyle = adw_toolbar_view_get_top_bar_style;

    /// Removes a child from `self`.
    extern fn adw_toolbar_view_remove(p_self: *ToolbarView, p_widget: *gtk.Widget) void;
    pub const remove = adw_toolbar_view_remove;

    /// Sets appearance of the bottom bars for `self`.
    ///
    /// If set to `ADW_TOOLBAR_FLAT`, bottom bars are flat and scrolling content has
    /// a subtle undershoot shadow when touching them, same as the
    /// [`.undershoot-bottom`](style-classes.html`undershoot`-indicators)
    /// style class. This works well for simple content, e.g. `StatusPage` or
    /// `PreferencesPage`, where the background at the bottom of the page is
    /// uniform. Additionally, windows with sidebars should always use this style.
    ///
    /// Undershoot shadow is only present if a bottom bar is actually present and
    /// visible. It is also never present if
    /// `ToolbarView.properties.extend_content_to_bottom_edge` is set to `TRUE`.
    ///
    /// If set to `ADW_TOOLBAR_RAISED`, bottom bars have an opaque background and a
    /// persistent shadow, this is suitable for content such as
    /// [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
    /// where some elements are directly adjacent to the bottom bars, or
    /// `TabView`, where each page can have a different background.
    ///
    /// `ADW_TOOLBAR_RAISED_BORDER` is similar to `ADW_TOOLBAR_RAISED`, but the
    /// shadow is replaced with a more subtle border. This can be useful for
    /// applications like image viewers.
    ///
    /// See also `ToolbarView.setTopBarStyle`.
    extern fn adw_toolbar_view_set_bottom_bar_style(p_self: *ToolbarView, p_style: adw.ToolbarStyle) void;
    pub const setBottomBarStyle = adw_toolbar_view_set_bottom_bar_style;

    /// Sets the content widget for `self`.
    extern fn adw_toolbar_view_set_content(p_self: *ToolbarView, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_toolbar_view_set_content;

    /// Sets whether the content widget can extend behind bottom bars.
    ///
    /// This can be used in combination with `ToolbarView.properties.reveal_bottom_bars`
    /// to show and hide toolbars in fullscreen.
    ///
    /// See `ToolbarView.setExtendContentToTopEdge`.
    extern fn adw_toolbar_view_set_extend_content_to_bottom_edge(p_self: *ToolbarView, p_extend: c_int) void;
    pub const setExtendContentToBottomEdge = adw_toolbar_view_set_extend_content_to_bottom_edge;

    /// Sets whether the content widget can extend behind top bars.
    ///
    /// This can be used in combination with `ToolbarView.properties.reveal_top_bars`
    /// to show and hide toolbars in fullscreen.
    ///
    /// See `ToolbarView.setExtendContentToBottomEdge`.
    extern fn adw_toolbar_view_set_extend_content_to_top_edge(p_self: *ToolbarView, p_extend: c_int) void;
    pub const setExtendContentToTopEdge = adw_toolbar_view_set_extend_content_to_top_edge;

    /// Sets whether bottom bars are revealed for `self`.
    ///
    /// The transition will be animated.
    ///
    /// This can be used in combination with
    /// `ToolbarView.properties.extend_content_to_bottom_edge` to show and hide
    /// toolbars in fullscreen.
    ///
    /// See `ToolbarView.setRevealTopBars`.
    extern fn adw_toolbar_view_set_reveal_bottom_bars(p_self: *ToolbarView, p_reveal: c_int) void;
    pub const setRevealBottomBars = adw_toolbar_view_set_reveal_bottom_bars;

    /// Sets whether top bars are revealed for `self`.
    ///
    /// The transition will be animated.
    ///
    /// This can be used in combination with
    /// `ToolbarView.properties.extend_content_to_top_edge` to show and hide toolbars
    /// in fullscreen.
    ///
    /// See `ToolbarView.setRevealBottomBars`.
    extern fn adw_toolbar_view_set_reveal_top_bars(p_self: *ToolbarView, p_reveal: c_int) void;
    pub const setRevealTopBars = adw_toolbar_view_set_reveal_top_bars;

    /// Sets appearance of the top bars for `self`.
    ///
    /// If set to `ADW_TOOLBAR_FLAT`, top bars are flat and scrolling content has a
    /// subtle undershoot shadow when touching them, same as the
    /// [`.undershoot-top`](style-classes.html`undershoot`-indicators)
    /// style class. This works well for simple content, e.g. `StatusPage` or
    /// `PreferencesPage`, where the background at the top of the page is
    /// uniform. Additionally, windows with sidebars should always use this style.
    ///
    /// Undershoot shadow is only present if a top bar is actually present and
    /// visible. It is also never present if
    /// `ToolbarView.properties.extend_content_to_top_edge` is set to `TRUE`.
    ///
    /// If set to `ADW_TOOLBAR_RAISED`, top bars have an opaque background and a
    /// persistent shadow, this is suitable for content such as
    /// [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
    /// where some elements are directly adjacent to the top bars, or
    /// `TabView`, where each page can have a different background.
    ///
    /// `ADW_TOOLBAR_RAISED_BORDER` is similar to `ADW_TOOLBAR_RAISED`, but the
    /// shadow is replaced with a more subtle border. This can be useful for
    /// applications like image viewers.
    ///
    /// See also `ToolbarView.setBottomBarStyle`.
    extern fn adw_toolbar_view_set_top_bar_style(p_self: *ToolbarView, p_style: adw.ToolbarStyle) void;
    pub const setTopBarStyle = adw_toolbar_view_set_top_bar_style;

    extern fn adw_toolbar_view_get_type() usize;
    pub const getGObjectType = adw_toolbar_view_get_type;

    extern fn g_object_ref(p_self: *adw.ToolbarView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ToolbarView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ToolbarView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A view container for `ViewSwitcher`.
///
/// `AdwViewStack` is a container which only shows one page at a time.
/// It is typically used to hold an application's main views.
///
/// It doesn't provide a way to transition between pages.
/// Instead, a separate widget such as `ViewSwitcher` can be used with
/// `AdwViewStack` to provide this functionality.
///
/// `AdwViewStack` pages can have a title, an icon, an attention request, and a
/// numbered badge that `ViewSwitcher` will use to let users identify which
/// page is which. Set them using the `ViewStackPage.properties.title`,
/// `ViewStackPage.properties.icon_name`,
/// `ViewStackPage.properties.needs_attention`, and
/// `ViewStackPage.properties.badge_number` properties.
///
/// Unlike `gtk.Stack`, transitions between views can only be animated via
/// a crossfade and size changes are always interpolated. Animations are disabled
/// by default. Use `ViewStack.properties.enable_transitions` to enable them.
///
/// `AdwViewStack` maintains a `ViewStackPage` object for each added child,
/// which holds additional per-child properties. You obtain the
/// `ViewStackPage` for a child with `ViewStack.getPage` and you
/// can obtain a `gtk.SelectionModel` containing all the pages with
/// `ViewStack.getPages`.
///
/// ## AdwViewStack as GtkBuildable
///
/// To set child-specific properties in a .ui file, create
/// `ViewStackPage` objects explicitly, and set the child widget as a
/// property on it:
///
/// ```xml
///   <object class="AdwViewStack" id="stack">
///     <child>
///       <object class="AdwViewStackPage">
///         <property name="name">overview</property>
///         <property name="title">Overview</property>
///         <property name="child">
///           <object class="AdwStatusPage">
///             <property name="title">Welcome!</property>
///           </object>
///         </property>
///       </object>
///     </child>
///   </object>
/// ```
///
/// ## CSS nodes
///
/// `AdwViewStack` has a single CSS node named `stack`.
///
/// ## Accessibility
///
/// `AdwViewStack` uses the `GTK_ACCESSIBLE_ROLE_TAB_PANEL` for the stack pages
/// which are the accessible parent objects of the child widgets.
pub const ViewStack = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ViewStackClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the stack uses a crossfade transition between pages.
        ///
        /// Use `ViewStack.properties.transition_duration` to control the duration, and
        /// `ViewStack.properties.transition_running` to know when the transition is
        /// running.
        pub const enable_transitions = struct {
            pub const name = "enable-transitions";

            pub const Type = c_int;
        };

        /// Whether the stack is horizontally homogeneous.
        ///
        /// If the stack is horizontally homogeneous, it allocates the same width for
        /// all children.
        ///
        /// If it's `FALSE`, the stack may change width when a different child becomes
        /// visible.
        pub const hhomogeneous = struct {
            pub const name = "hhomogeneous";

            pub const Type = c_int;
        };

        /// A selection model with the stack's pages.
        ///
        /// This can be used to keep an up-to-date view. The model also implements
        /// `gtk.SelectionModel` and can be used to track and change the visible
        /// page.
        pub const pages = struct {
            pub const name = "pages";

            pub const Type = ?*gtk.SelectionModel;
        };

        /// The transition animation duration, in milliseconds.
        ///
        /// Only used when `ViewStack.properties.enable_transitions` is set to `TRUE`.
        pub const transition_duration = struct {
            pub const name = "transition-duration";

            pub const Type = c_uint;
        };

        /// Whether a transition is currently running.
        ///
        /// If a transition is impossible, the property value will be set to `TRUE` and
        /// then immediately to `FALSE`, so it's possible to rely on its notifications
        /// to know that a transition has happened.
        pub const transition_running = struct {
            pub const name = "transition-running";

            pub const Type = c_int;
        };

        /// Whether the stack is vertically homogeneous.
        ///
        /// If the stack is vertically homogeneous, it allocates the same height for
        /// all children.
        ///
        /// If it's `FALSE`, the stack may change height when a different child becomes
        /// visible.
        pub const vhomogeneous = struct {
            pub const name = "vhomogeneous";

            pub const Type = c_int;
        };

        /// The widget currently visible in the stack.
        pub const visible_child = struct {
            pub const name = "visible-child";

            pub const Type = ?*gtk.Widget;
        };

        /// The name of the widget currently visible in the stack.
        ///
        /// See `ViewStack.properties.visible_child`.
        pub const visible_child_name = struct {
            pub const name = "visible-child-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwViewStack`.
    extern fn adw_view_stack_new() *adw.ViewStack;
    pub const new = adw_view_stack_new;

    /// Adds a child to `self`.
    extern fn adw_view_stack_add(p_self: *ViewStack, p_child: *gtk.Widget) *adw.ViewStackPage;
    pub const add = adw_view_stack_add;

    /// Adds a child to `self`.
    ///
    /// The child is identified by the `name`.
    extern fn adw_view_stack_add_named(p_self: *ViewStack, p_child: *gtk.Widget, p_name: ?[*:0]const u8) *adw.ViewStackPage;
    pub const addNamed = adw_view_stack_add_named;

    /// Adds a child to `self`.
    ///
    /// The child is identified by the `name`. The `title` will be used by
    /// `ViewSwitcher` to represent `child`, so it should be short.
    extern fn adw_view_stack_add_titled(p_self: *ViewStack, p_child: *gtk.Widget, p_name: ?[*:0]const u8, p_title: [*:0]const u8) *adw.ViewStackPage;
    pub const addTitled = adw_view_stack_add_titled;

    /// Adds a child to `self`.
    ///
    /// The child is identified by the `name`. The `title` and `icon_name` will be used
    /// by `ViewSwitcher` to represent `child`.
    extern fn adw_view_stack_add_titled_with_icon(p_self: *ViewStack, p_child: *gtk.Widget, p_name: ?[*:0]const u8, p_title: [*:0]const u8, p_icon_name: [*:0]const u8) *adw.ViewStackPage;
    pub const addTitledWithIcon = adw_view_stack_add_titled_with_icon;

    /// Finds the child with `name` in `self`.
    extern fn adw_view_stack_get_child_by_name(p_self: *ViewStack, p_name: [*:0]const u8) ?*gtk.Widget;
    pub const getChildByName = adw_view_stack_get_child_by_name;

    /// Gets whether `self` uses a crossfade transition between pages.
    ///
    /// Use `ViewStack.properties.transition_duration` to control the duration, and
    /// `ViewStack.properties.transition_running` to know when the transition is
    /// running.
    extern fn adw_view_stack_get_enable_transitions(p_self: *ViewStack) c_int;
    pub const getEnableTransitions = adw_view_stack_get_enable_transitions;

    /// Gets whether `self` is horizontally homogeneous.
    extern fn adw_view_stack_get_hhomogeneous(p_self: *ViewStack) c_int;
    pub const getHhomogeneous = adw_view_stack_get_hhomogeneous;

    /// Gets the `ViewStackPage` object for `child`.
    extern fn adw_view_stack_get_page(p_self: *ViewStack, p_child: *gtk.Widget) *adw.ViewStackPage;
    pub const getPage = adw_view_stack_get_page;

    /// Returns a `gio.ListModel` that contains the pages of the stack.
    ///
    /// This can be used to keep an up-to-date view. The model also implements
    /// `gtk.SelectionModel` and can be used to track and change the visible
    /// page.
    extern fn adw_view_stack_get_pages(p_self: *ViewStack) *gtk.SelectionModel;
    pub const getPages = adw_view_stack_get_pages;

    /// Gets the transition animation duration for `self`.
    extern fn adw_view_stack_get_transition_duration(p_self: *ViewStack) c_uint;
    pub const getTransitionDuration = adw_view_stack_get_transition_duration;

    /// Gets whether a transition is currently running for `self`.
    ///
    /// If a transition is impossible, the property value will be set to `TRUE` and
    /// then immediately to `FALSE`, so it's possible to rely on its notifications
    /// to know that a transition has happened.
    extern fn adw_view_stack_get_transition_running(p_self: *ViewStack) c_int;
    pub const getTransitionRunning = adw_view_stack_get_transition_running;

    /// Gets whether `self` is vertically homogeneous.
    extern fn adw_view_stack_get_vhomogeneous(p_self: *ViewStack) c_int;
    pub const getVhomogeneous = adw_view_stack_get_vhomogeneous;

    /// Gets the currently visible child of `self`.
    extern fn adw_view_stack_get_visible_child(p_self: *ViewStack) ?*gtk.Widget;
    pub const getVisibleChild = adw_view_stack_get_visible_child;

    /// Returns the name of the currently visible child of `self`.
    extern fn adw_view_stack_get_visible_child_name(p_self: *ViewStack) ?[*:0]const u8;
    pub const getVisibleChildName = adw_view_stack_get_visible_child_name;

    /// Removes a child widget from `self`.
    extern fn adw_view_stack_remove(p_self: *ViewStack, p_child: *gtk.Widget) void;
    pub const remove = adw_view_stack_remove;

    /// Sets whether `self` uses a crossfade transition between pages.
    extern fn adw_view_stack_set_enable_transitions(p_self: *ViewStack, p_enable_transitions: c_int) void;
    pub const setEnableTransitions = adw_view_stack_set_enable_transitions;

    /// Sets `self` to be horizontally homogeneous or not.
    ///
    /// If the stack is horizontally homogeneous, it allocates the same width for
    /// all children.
    ///
    /// If it's `FALSE`, the stack may change width when a different child becomes
    /// visible.
    extern fn adw_view_stack_set_hhomogeneous(p_self: *ViewStack, p_hhomogeneous: c_int) void;
    pub const setHhomogeneous = adw_view_stack_set_hhomogeneous;

    /// Sets the transition animation duration for `self`.
    ///
    /// Only used when `ViewStack.properties.enable_transitions` is set to `TRUE`.
    extern fn adw_view_stack_set_transition_duration(p_self: *ViewStack, p_duration: c_uint) void;
    pub const setTransitionDuration = adw_view_stack_set_transition_duration;

    /// Sets `self` to be vertically homogeneous or not.
    ///
    /// If the stack is vertically homogeneous, it allocates the same height for
    /// all children.
    ///
    /// If it's `FALSE`, the stack may change height when a different child becomes
    /// visible.
    extern fn adw_view_stack_set_vhomogeneous(p_self: *ViewStack, p_vhomogeneous: c_int) void;
    pub const setVhomogeneous = adw_view_stack_set_vhomogeneous;

    /// Makes `child` the visible child of `self`.
    extern fn adw_view_stack_set_visible_child(p_self: *ViewStack, p_child: *gtk.Widget) void;
    pub const setVisibleChild = adw_view_stack_set_visible_child;

    /// Makes the child with `name` visible.
    ///
    /// See `ViewStack.properties.visible_child`.
    extern fn adw_view_stack_set_visible_child_name(p_self: *ViewStack, p_name: [*:0]const u8) void;
    pub const setVisibleChildName = adw_view_stack_set_visible_child_name;

    extern fn adw_view_stack_get_type() usize;
    pub const getGObjectType = adw_view_stack_get_type;

    extern fn g_object_ref(p_self: *adw.ViewStack) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewStack) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewStack, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An auxiliary class used by `ViewStack`.
pub const ViewStackPage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.Accessible};
    pub const Class = adw.ViewStackPageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The badge number for this page.
        ///
        /// `ViewSwitcher` can display it as a badge next to the page icon. It is
        /// commonly used to display a number of unread items within the page.
        ///
        /// It can be used together with `@"ViewStack{age}".properties.needs_attention`.
        pub const badge_number = struct {
            pub const name = "badge-number";

            pub const Type = c_uint;
        };

        /// The stack child to which the page belongs.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The icon name of the child page.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the child page.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the page requires the user attention.
        ///
        /// `ViewSwitcher` will display it as a dot next to the page icon.
        pub const needs_attention = struct {
            pub const name = "needs-attention";

            pub const Type = c_int;
        };

        /// The title of the child page.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether an embedded underline in the title indicates a mnemonic.
        pub const use_underline = struct {
            pub const name = "use-underline";

            pub const Type = c_int;
        };

        /// Whether this page is visible.
        ///
        /// This is independent from the `gtk.Widget.properties.visible` property of
        /// `ViewStackPage.properties.child`.
        pub const visible = struct {
            pub const name = "visible";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Gets the badge number for this page.
    extern fn adw_view_stack_page_get_badge_number(p_self: *ViewStackPage) c_uint;
    pub const getBadgeNumber = adw_view_stack_page_get_badge_number;

    /// Gets the stack child to which `self` belongs.
    extern fn adw_view_stack_page_get_child(p_self: *ViewStackPage) *gtk.Widget;
    pub const getChild = adw_view_stack_page_get_child;

    /// Gets the icon name of the page.
    extern fn adw_view_stack_page_get_icon_name(p_self: *ViewStackPage) ?[*:0]const u8;
    pub const getIconName = adw_view_stack_page_get_icon_name;

    /// Gets the name of the page.
    extern fn adw_view_stack_page_get_name(p_self: *ViewStackPage) ?[*:0]const u8;
    pub const getName = adw_view_stack_page_get_name;

    /// Gets whether the page requires the user attention.
    extern fn adw_view_stack_page_get_needs_attention(p_self: *ViewStackPage) c_int;
    pub const getNeedsAttention = adw_view_stack_page_get_needs_attention;

    /// Gets the page title.
    extern fn adw_view_stack_page_get_title(p_self: *ViewStackPage) ?[*:0]const u8;
    pub const getTitle = adw_view_stack_page_get_title;

    /// Gets whether underlines in the page title indicate mnemonics.
    extern fn adw_view_stack_page_get_use_underline(p_self: *ViewStackPage) c_int;
    pub const getUseUnderline = adw_view_stack_page_get_use_underline;

    /// Gets whether `self` is visible in its `AdwViewStack`.
    ///
    /// This is independent from the `gtk.Widget.properties.visible`
    /// property of its widget.
    extern fn adw_view_stack_page_get_visible(p_self: *ViewStackPage) c_int;
    pub const getVisible = adw_view_stack_page_get_visible;

    /// Sets the badge number for this page.
    ///
    /// `ViewSwitcher` can display it as a badge next to the page icon. It is
    /// commonly used to display a number of unread items within the page.
    ///
    /// It can be used together with `@"ViewStack{age}".properties.needs_attention`.
    extern fn adw_view_stack_page_set_badge_number(p_self: *ViewStackPage, p_badge_number: c_uint) void;
    pub const setBadgeNumber = adw_view_stack_page_set_badge_number;

    /// Sets the icon name of the page.
    extern fn adw_view_stack_page_set_icon_name(p_self: *ViewStackPage, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = adw_view_stack_page_set_icon_name;

    /// Sets the name of the page.
    extern fn adw_view_stack_page_set_name(p_self: *ViewStackPage, p_name: ?[*:0]const u8) void;
    pub const setName = adw_view_stack_page_set_name;

    /// Sets whether the page requires the user attention.
    ///
    /// `ViewSwitcher` will display it as a dot next to the page icon.
    extern fn adw_view_stack_page_set_needs_attention(p_self: *ViewStackPage, p_needs_attention: c_int) void;
    pub const setNeedsAttention = adw_view_stack_page_set_needs_attention;

    /// Sets the page title.
    extern fn adw_view_stack_page_set_title(p_self: *ViewStackPage, p_title: ?[*:0]const u8) void;
    pub const setTitle = adw_view_stack_page_set_title;

    /// Sets whether underlines in the page title indicate mnemonics.
    extern fn adw_view_stack_page_set_use_underline(p_self: *ViewStackPage, p_use_underline: c_int) void;
    pub const setUseUnderline = adw_view_stack_page_set_use_underline;

    /// Sets whether `page` is visible in its `AdwViewStack`.
    ///
    /// This is independent from the `gtk.Widget.properties.visible` property of
    /// `ViewStackPage.properties.child`.
    extern fn adw_view_stack_page_set_visible(p_self: *ViewStackPage, p_visible: c_int) void;
    pub const setVisible = adw_view_stack_page_set_visible;

    extern fn adw_view_stack_page_get_type() usize;
    pub const getGObjectType = adw_view_stack_page_get_type;

    extern fn g_object_ref(p_self: *adw.ViewStackPage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewStackPage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewStackPage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An auxiliary class used by `ViewStack`.
///
/// See `ViewStack.properties.pages`.
pub const ViewStackPages = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gio.ListModel, gtk.SelectionModel };
    pub const Class = adw.ViewStackPagesClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The selected `ViewStackPage` within the `ViewStackPages`.
        ///
        /// This can be used to keep an up-to-date view of the `ViewStackPage` for
        /// The visible `ViewStackPage` within the associated `ViewStackPages`.
        ///
        /// This can be used to keep an up-to-date view of the visible child.
        pub const selected_page = struct {
            pub const name = "selected-page";

            pub const Type = ?*adw.ViewStackPage;
        };
    };

    pub const signals = struct {};

    /// Gets the `ViewStackPage` for the visible child of a view stack
    ///
    /// Gets the `ViewStackPage` for the visible child of the associated stack.
    ///
    /// Returns `NULL` if there's no selected page.
    extern fn adw_view_stack_pages_get_selected_page(p_self: *ViewStackPages) ?*adw.ViewStackPage;
    pub const getSelectedPage = adw_view_stack_pages_get_selected_page;

    /// Sets the visible child in the associated `ViewStack`.
    ///
    /// See `ViewStack.properties.visible_child`.
    extern fn adw_view_stack_pages_set_selected_page(p_self: *ViewStackPages, p_page: *adw.ViewStackPage) void;
    pub const setSelectedPage = adw_view_stack_pages_set_selected_page;

    extern fn adw_view_stack_pages_get_type() usize;
    pub const getGObjectType = adw_view_stack_pages_get_type;

    extern fn g_object_ref(p_self: *adw.ViewStackPages) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewStackPages) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewStackPages, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An adaptive view switcher.
///
/// <picture>
///   <source srcset="view-switcher-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="view-switcher.png" alt="view-switcher">
/// </picture>
///
/// An adaptive view switcher designed to switch between multiple views
/// contained in a `ViewStack` in a similar fashion to
/// `gtk.StackSwitcher`.
///
/// `AdwViewSwitcher` buttons always have an icon and a label. They can be
/// displayed side by side, or icon on top of the label. This can be controlled
/// via the `ViewSwitcher.properties.policy` property.
///
/// `AdwViewSwitcher` is intended to be used in a header bar together with
/// `ViewSwitcherBar` at the bottom of the window, and a `Breakpoint`
/// showing the view switcher bar on narrow sizes, while removing the view
/// switcher from the header bar, as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 550sp</condition>
///       <setter object="switcher_bar" property="reveal">True</setter>
///       <setter object="header_bar" property="title-widget"/>
///     </object>
///   </child>
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar" id="header_bar">
///           <property name="title-widget">
///             <object class="AdwViewSwitcher">
///               <property name="stack">stack</property>
///               <property name="policy">wide</property>
///             </object>
///           </property>
///         </object>
///       </child>
///       <property name="content">
///         <object class="AdwViewStack" id="stack"/>
///       </property>
///       <child type="bottom">
///         <object class="AdwViewSwitcherBar" id="switcher_bar">
///           <property name="stack">stack</property>
///         </object>
///       </child>
///     </object>
///   </property>
/// </object>
/// ```
///
/// It's recommended to set `ViewSwitcher.properties.policy` to
/// `ADW_VIEW_SWITCHER_POLICY_WIDE` in this case.
///
/// You may have to adjust the breakpoint condition for your specific pages.
///
/// ## CSS nodes
///
/// `AdwViewSwitcher` has a single CSS node with name `viewswitcher`. It can have
/// the style classes `.wide` and `.narrow`, matching its policy.
///
/// ## Accessibility
///
/// `AdwViewSwitcher` uses the `GTK_ACCESSIBLE_ROLE_TAB_LIST` role and uses the
/// `GTK_ACCESSIBLE_ROLE_TAB` for its buttons.
pub const ViewSwitcher = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ViewSwitcherClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The policy to determine which mode to use.
        pub const policy = struct {
            pub const name = "policy";

            pub const Type = adw.ViewSwitcherPolicy;
        };

        /// The stack the view switcher controls.
        pub const stack = struct {
            pub const name = "stack";

            pub const Type = ?*adw.ViewStack;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwViewSwitcher`.
    extern fn adw_view_switcher_new() *adw.ViewSwitcher;
    pub const new = adw_view_switcher_new;

    /// Gets the policy of `self`.
    extern fn adw_view_switcher_get_policy(p_self: *ViewSwitcher) adw.ViewSwitcherPolicy;
    pub const getPolicy = adw_view_switcher_get_policy;

    /// Gets the stack controlled by `self`.
    extern fn adw_view_switcher_get_stack(p_self: *ViewSwitcher) ?*adw.ViewStack;
    pub const getStack = adw_view_switcher_get_stack;

    /// Sets the policy of `self`.
    extern fn adw_view_switcher_set_policy(p_self: *ViewSwitcher, p_policy: adw.ViewSwitcherPolicy) void;
    pub const setPolicy = adw_view_switcher_set_policy;

    /// Sets the stack controlled by `self`.
    extern fn adw_view_switcher_set_stack(p_self: *ViewSwitcher, p_stack: ?*adw.ViewStack) void;
    pub const setStack = adw_view_switcher_set_stack;

    extern fn adw_view_switcher_get_type() usize;
    pub const getGObjectType = adw_view_switcher_get_type;

    extern fn g_object_ref(p_self: *adw.ViewSwitcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewSwitcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewSwitcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A view switcher action bar.
///
/// <picture>
///   <source srcset="view-switcher-bar-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="view-switcher-bar.png" alt="view-switcher-bar">
/// </picture>
///
/// An action bar letting you switch between multiple views contained in a
/// `ViewStack`, via an `ViewSwitcher`. It is designed to be put at
/// the bottom of a window and to be revealed only on really narrow windows, e.g.
/// on mobile phones. It can't be revealed if there are less than two pages.
///
/// `AdwViewSwitcherBar` is intended to be used together with
/// `AdwViewSwitcher` in a header bar, and a `Breakpoint` showing the view
/// switcher bar on narrow sizes, while removing the view switcher from the
/// header bar, as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 550sp</condition>
///       <setter object="switcher_bar" property="reveal">True</setter>
///       <setter object="header_bar" property="title-widget"/>
///     </object>
///   </child>
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar" id="header_bar">
///           <property name="title-widget">
///             <object class="AdwViewSwitcher">
///               <property name="stack">stack</property>
///               <property name="policy">wide</property>
///             </object>
///           </property>
///         </object>
///       </child>
///       <property name="content">
///         <object class="AdwViewStack" id="stack"/>
///       </property>
///       <child type="bottom">
///         <object class="AdwViewSwitcherBar" id="switcher_bar">
///           <property name="stack">stack</property>
///         </object>
///       </child>
///     </object>
///   </property>
/// </object>
/// ```
///
/// It's recommended to set `ViewSwitcher.properties.policy` to
/// `ADW_VIEW_SWITCHER_POLICY_WIDE` in this case.
///
/// You may have to adjust the breakpoint condition for your specific pages.
///
/// ## CSS nodes
///
/// `AdwViewSwitcherBar` has a single CSS node with name` viewswitcherbar`.
pub const ViewSwitcherBar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ViewSwitcherBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the bar should be revealed or hidden.
        pub const reveal = struct {
            pub const name = "reveal";

            pub const Type = c_int;
        };

        /// The stack the view switcher controls.
        pub const stack = struct {
            pub const name = "stack";

            pub const Type = ?*adw.ViewStack;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwViewSwitcherBar`.
    extern fn adw_view_switcher_bar_new() *adw.ViewSwitcherBar;
    pub const new = adw_view_switcher_bar_new;

    /// Gets whether `self` should be revealed or hidden.
    extern fn adw_view_switcher_bar_get_reveal(p_self: *ViewSwitcherBar) c_int;
    pub const getReveal = adw_view_switcher_bar_get_reveal;

    /// Gets the stack controlled by `self`.
    extern fn adw_view_switcher_bar_get_stack(p_self: *ViewSwitcherBar) ?*adw.ViewStack;
    pub const getStack = adw_view_switcher_bar_get_stack;

    /// Sets whether `self` should be revealed or hidden.
    extern fn adw_view_switcher_bar_set_reveal(p_self: *ViewSwitcherBar, p_reveal: c_int) void;
    pub const setReveal = adw_view_switcher_bar_set_reveal;

    /// Sets the stack controlled by `self`.
    extern fn adw_view_switcher_bar_set_stack(p_self: *ViewSwitcherBar, p_stack: ?*adw.ViewStack) void;
    pub const setStack = adw_view_switcher_bar_set_stack;

    extern fn adw_view_switcher_bar_get_type() usize;
    pub const getGObjectType = adw_view_switcher_bar_get_type;

    extern fn g_object_ref(p_self: *adw.ViewSwitcherBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewSwitcherBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewSwitcherBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A view switcher title.
///
/// <picture>
///   <source srcset="view-switcher-title-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="view-switcher-title.png" alt="view-switcher-title">
/// </picture>
///
/// A widget letting you switch between multiple views contained by a
/// `ViewStack` via an `ViewSwitcher`.
///
/// It is designed to be used as the title widget of a `HeaderBar`, and
/// will display the window's title when the window is too narrow to fit the view
/// switcher e.g. on mobile phones, or if there are less than two views.
///
/// In order to center the title in narrow windows, the header bar should have
/// `HeaderBar.properties.centering_policy` set to
/// `ADW_CENTERING_POLICY_STRICT`.
///
/// `AdwViewSwitcherTitle` is intended to be used together with
/// `ViewSwitcherBar`.
///
/// A common use case is to bind the `ViewSwitcherBar.properties.reveal` property
/// to `ViewSwitcherTitle.properties.title_visible` to automatically reveal the
/// view switcher bar when the title label is displayed in place of the view
/// switcher, as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar">
///           <property name="centering-policy">strict</property>
///           <property name="title-widget">
///             <object class="AdwViewSwitcherTitle" id="title">
///               <property name="stack">stack</property>
///             </object>
///           </property>
///         </object>
///       </child>
///       <property name="content">
///         <object class="AdwViewStack" id="stack"/>
///       </property>
///       <child type="bottom">
///         <object class="AdwViewSwitcherBar">
///           <property name="stack">stack</property>
///           <binding name="reveal">
///             <lookup name="title-visible">title</lookup>
///           </binding>
///         </object>
///       </child>
///     </object>
///   </property>
/// </object>
/// ```
///
/// ## CSS nodes
///
/// `AdwViewSwitcherTitle` has a single CSS node with name `viewswitchertitle`.
pub const ViewSwitcherTitle = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.ViewSwitcherTitleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The stack the view switcher controls.
        pub const stack = struct {
            pub const name = "stack";

            pub const Type = ?*adw.ViewStack;
        };

        /// The subtitle to display.
        ///
        /// The subtitle should give the user additional details.
        pub const subtitle = struct {
            pub const name = "subtitle";

            pub const Type = ?[*:0]u8;
        };

        /// The title to display.
        ///
        /// The title typically identifies the current view or content item, and
        /// generally does not use the application name.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the title is currently visible.
        ///
        /// If the title is visible, it means the view switcher is hidden an it may be
        /// wanted to show an alternative switcher, e.g. a `ViewSwitcherBar`.
        pub const title_visible = struct {
            pub const name = "title-visible";

            pub const Type = c_int;
        };

        /// Whether the view switcher is enabled.
        ///
        /// If it is disabled, the title will be displayed instead. This allows to
        /// programmatically hide the view switcher even if it fits in the available
        /// space.
        ///
        /// This can be used e.g. to ensure the view switcher is hidden below a certain
        /// window width, or any other constraint you find suitable.
        pub const view_switcher_enabled = struct {
            pub const name = "view-switcher-enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwViewSwitcherTitle`.
    extern fn adw_view_switcher_title_new() *adw.ViewSwitcherTitle;
    pub const new = adw_view_switcher_title_new;

    /// Gets the stack controlled by `self`.
    extern fn adw_view_switcher_title_get_stack(p_self: *ViewSwitcherTitle) ?*adw.ViewStack;
    pub const getStack = adw_view_switcher_title_get_stack;

    /// Gets the subtitle of `self`.
    extern fn adw_view_switcher_title_get_subtitle(p_self: *ViewSwitcherTitle) [*:0]const u8;
    pub const getSubtitle = adw_view_switcher_title_get_subtitle;

    /// Gets the title of `self`.
    extern fn adw_view_switcher_title_get_title(p_self: *ViewSwitcherTitle) [*:0]const u8;
    pub const getTitle = adw_view_switcher_title_get_title;

    /// Gets whether the title of `self` is currently visible.
    ///
    /// If the title is visible, it means the view switcher is hidden an it may be
    /// wanted to show an alternative switcher, e.g. a `ViewSwitcherBar`.
    extern fn adw_view_switcher_title_get_title_visible(p_self: *ViewSwitcherTitle) c_int;
    pub const getTitleVisible = adw_view_switcher_title_get_title_visible;

    /// Gets whether `self`'s view switcher is enabled.
    extern fn adw_view_switcher_title_get_view_switcher_enabled(p_self: *ViewSwitcherTitle) c_int;
    pub const getViewSwitcherEnabled = adw_view_switcher_title_get_view_switcher_enabled;

    /// Sets the stack controlled by `self`.
    extern fn adw_view_switcher_title_set_stack(p_self: *ViewSwitcherTitle, p_stack: ?*adw.ViewStack) void;
    pub const setStack = adw_view_switcher_title_set_stack;

    /// Sets the subtitle of `self`.
    ///
    /// The subtitle should give the user additional details.
    extern fn adw_view_switcher_title_set_subtitle(p_self: *ViewSwitcherTitle, p_subtitle: [*:0]const u8) void;
    pub const setSubtitle = adw_view_switcher_title_set_subtitle;

    /// Sets the title of `self`.
    ///
    /// The title typically identifies the current view or content item, and
    /// generally does not use the application name.
    extern fn adw_view_switcher_title_set_title(p_self: *ViewSwitcherTitle, p_title: [*:0]const u8) void;
    pub const setTitle = adw_view_switcher_title_set_title;

    /// Sets whether `self`'s view switcher is enabled.
    ///
    /// If it is disabled, the title will be displayed instead. This allows to
    /// programmatically hide the view switcher even if it fits in the available
    /// space.
    ///
    /// This can be used e.g. to ensure the view switcher is hidden below a certain
    /// window width, or any other constraint you find suitable.
    extern fn adw_view_switcher_title_set_view_switcher_enabled(p_self: *ViewSwitcherTitle, p_enabled: c_int) void;
    pub const setViewSwitcherEnabled = adw_view_switcher_title_set_view_switcher_enabled;

    extern fn adw_view_switcher_title_get_type() usize;
    pub const getGObjectType = adw_view_switcher_title_get_type;

    extern fn g_object_ref(p_self: *adw.ViewSwitcherTitle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.ViewSwitcherTitle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ViewSwitcherTitle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A freeform window.
///
/// <picture>
///   <source srcset="window-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="window.png" alt="window">
/// </picture>
///
/// The `AdwWindow` widget is a subclass of `gtk.Window` which has no
/// titlebar area. Instead, `ToolbarView` can be used together with
/// `HeaderBar` or `gtk.HeaderBar` as follows:
///
/// ```xml
/// <object class="AdwWindow">
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar"/>
///       </child>
///       <property name="content">
///         <!-- ... -->
///       </property>
///     </object>
///   </property>
/// </object>
/// ```
///
/// Using `gtk.Window.properties.titlebar` or `gtk.Window.properties.child`
/// is not supported and will result in a crash. Use `Window.properties.content`
/// instead.
///
/// ## Dialogs
///
/// `AdwWindow` can contain `Dialog`. Use `Dialog.present` with the
/// window or a widget within a window to show a dialog.
///
/// ## Breakpoints
///
/// `AdwWindow` can be used with `Breakpoint` the same way as
/// `BreakpointBin`. Refer to that widget's documentation for details.
///
/// Example:
///
/// ```xml
/// <object class="AdwWindow">
///   <property name="content">
///     <object class="AdwToolbarView">
///       <child type="top">
///         <object class="AdwHeaderBar"/>
///       </child>
///       <property name="content">
///         <!-- ... -->
///       </property>
///       <child type="bottom">
///         <object class="GtkActionBar" id="bottom_bar">
///           <property name="revealed">True</property>
///           <property name="visible">False</property>
///         </object>
///       </child>
///     </object>
///   </property>
///   <child>
///     <object class="AdwBreakpoint">
///       <condition>max-width: 500px</condition>
///       <setter object="bottom_bar" property="visible">True</setter>
///     </object>
///   </child>
/// </object>
/// ```
///
/// When breakpoints are used, the minimum size must be larger than the smallest
/// UI state. `AdwWindow` defaults to the minimum size of 360×200 px. If that's
/// too small, set the `gtk.Widget.properties.width_request` and
/// `gtk.Widget.properties.height_request` properties manually.
///
/// ## Adaptive Preview
///
/// `AdwWindow` has a debug tool called adaptive preview. It can be opened from
/// GTK Inspector or by pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>M</kbd>,
/// and controlled via the `Window.properties.adaptive_preview` property.
pub const Window = extern struct {
    pub const Parent = gtk.Window;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = adw.WindowClass;
    f_parent_instance: gtk.Window,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether adaptive preview is currently open.
        ///
        /// Adaptive preview is a debugging tool used for testing the window
        /// contents at specific screen sizes, simulating mobile environment.
        ///
        /// Adaptive preview can always be accessed from inspector. This function
        /// allows applications to open it manually.
        ///
        /// Most applications should not use this property.
        pub const adaptive_preview = struct {
            pub const name = "adaptive-preview";

            pub const Type = c_int;
        };

        /// The content widget.
        ///
        /// This property should always be used instead of `gtk.Window.properties.child`.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gtk.Widget;
        };

        /// The current breakpoint.
        pub const current_breakpoint = struct {
            pub const name = "current-breakpoint";

            pub const Type = ?*adw.Breakpoint;
        };

        /// The open dialogs.
        pub const dialogs = struct {
            pub const name = "dialogs";

            pub const Type = ?*gio.ListModel;
        };

        /// The currently visible dialog
        pub const visible_dialog = struct {
            pub const name = "visible-dialog";

            pub const Type = ?*adw.Dialog;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwWindow`.
    extern fn adw_window_new() *adw.Window;
    pub const new = adw_window_new;

    /// Adds `breakpoint` to `self`.
    extern fn adw_window_add_breakpoint(p_self: *Window, p_breakpoint: *adw.Breakpoint) void;
    pub const addBreakpoint = adw_window_add_breakpoint;

    /// Gets whether adaptive preview for `self` is currently open.
    extern fn adw_window_get_adaptive_preview(p_self: *Window) c_int;
    pub const getAdaptivePreview = adw_window_get_adaptive_preview;

    /// Gets the content widget of `self`.
    ///
    /// This method should always be used instead of `gtk.Window.getChild`.
    extern fn adw_window_get_content(p_self: *Window) ?*gtk.Widget;
    pub const getContent = adw_window_get_content;

    /// Gets the current breakpoint.
    extern fn adw_window_get_current_breakpoint(p_self: *Window) ?*adw.Breakpoint;
    pub const getCurrentBreakpoint = adw_window_get_current_breakpoint;

    /// Returns a `gio.ListModel` that contains the open dialogs of `self`.
    ///
    /// This can be used to keep an up-to-date view.
    extern fn adw_window_get_dialogs(p_self: *Window) *gio.ListModel;
    pub const getDialogs = adw_window_get_dialogs;

    /// Returns the currently visible dialog in `self`, if there's one.
    extern fn adw_window_get_visible_dialog(p_self: *Window) ?*adw.Dialog;
    pub const getVisibleDialog = adw_window_get_visible_dialog;

    /// Sets whether adaptive preview for `self` is currently open.
    ///
    /// Adaptive preview is a debugging tool used for testing the window
    /// contents at specific screen sizes, simulating mobile environment.
    ///
    /// Adaptive preview can always be accessed from inspector. This function
    /// allows applications to open it manually.
    ///
    /// Most applications should not use this function.
    extern fn adw_window_set_adaptive_preview(p_self: *Window, p_adaptive_preview: c_int) void;
    pub const setAdaptivePreview = adw_window_set_adaptive_preview;

    /// Sets the content widget of `self`.
    ///
    /// This method should always be used instead of `gtk.Window.setChild`.
    extern fn adw_window_set_content(p_self: *Window, p_content: ?*gtk.Widget) void;
    pub const setContent = adw_window_set_content;

    extern fn adw_window_get_type() usize;
    pub const getGObjectType = adw_window_get_type;

    extern fn g_object_ref(p_self: *adw.Window) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Window) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Window, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A helper widget for setting a window's title and subtitle.
///
/// <picture>
///   <source srcset="window-title-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="window-title.png" alt="window-title">
/// </picture>
///
/// `AdwWindowTitle` shows a title and subtitle. It's intended to be used as the
/// title child of `gtk.HeaderBar` or `HeaderBar`.
///
/// ## CSS nodes
///
/// `AdwWindowTitle` has a single CSS node with name `windowtitle`.
pub const WindowTitle = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = adw.WindowTitleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The subtitle to display.
        ///
        /// The subtitle should give the user additional details.
        pub const subtitle = struct {
            pub const name = "subtitle";

            pub const Type = ?[*:0]u8;
        };

        /// The title to display.
        ///
        /// The title typically identifies the current view or content item, and
        /// generally does not use the application name.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwWindowTitle`.
    extern fn adw_window_title_new(p_title: [*:0]const u8, p_subtitle: [*:0]const u8) *adw.WindowTitle;
    pub const new = adw_window_title_new;

    /// Gets the subtitle of `self`.
    extern fn adw_window_title_get_subtitle(p_self: *WindowTitle) [*:0]const u8;
    pub const getSubtitle = adw_window_title_get_subtitle;

    /// Gets the title of `self`.
    extern fn adw_window_title_get_title(p_self: *WindowTitle) [*:0]const u8;
    pub const getTitle = adw_window_title_get_title;

    /// Sets the subtitle of `self`.
    ///
    /// The subtitle should give the user additional details.
    extern fn adw_window_title_set_subtitle(p_self: *WindowTitle, p_subtitle: [*:0]const u8) void;
    pub const setSubtitle = adw_window_title_set_subtitle;

    /// Sets the title of `self`.
    ///
    /// The title typically identifies the current view or content item, and
    /// generally does not use the application name.
    extern fn adw_window_title_set_title(p_self: *WindowTitle, p_title: [*:0]const u8) void;
    pub const setTitle = adw_window_title_set_title;

    extern fn adw_window_title_get_type() usize;
    pub const getGObjectType = adw_window_title_get_type;

    extern fn g_object_ref(p_self: *adw.WindowTitle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.WindowTitle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WindowTitle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A box-like widget that can wrap into multiple lines.
///
/// <picture>
///   <source srcset="wrap-box-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="wrap-box.png" alt="wrap-box">
/// </picture>
///
/// `AdwWrapBox` is similar to `gtk.Box`, but can wrap lines when the
/// widgets cannot fit otherwise. Unlike `gtk.FlowBox`, the children aren't
/// arranged into a grid and behave more like words in a wrapping label.
///
/// Like `GtkBox`, `AdwWrapBox` is orientable and has spacing:
///
/// - `WrapBox.properties.child_spacing` between children in the same line;
/// - `WrapBox.properties.line_spacing` between lines.
///
/// ::: note
///     Unlike `GtkBox`, `AdwWrapBox` cannot follow the CSS `border-spacing`
///     property.
///
/// Use the `WrapBox.properties.natural_line_length` property to determine the
/// layout's natural size, e.g. when using it in a `gtk.Popover`.
///
/// Normally, a horizontal `AdwWrapBox` wraps left to right and top to bottom
/// for left-to-right languages. Both of these directions can be reversed, using
/// the `WrapBox.properties.pack_direction` and `WrapBox.properties.wrap_reverse`
/// properties. Additionally, the alignment of each line can be controlled with
/// the `WrapBox.properties.@"align"` property.
///
/// Lines can be justified using the `WrapBox.properties.justify` property, filling
/// the entire line by either increasing child size or spacing depending on the
/// value. Set `WrapBox.properties.justify_last_line` to justify the last line as
/// well.
///
/// By default, `AdwWrapBox` wraps as soon as the previous line cannot fit any
/// more children without shrinking them past their natural size. Set
/// `WrapBox.properties.wrap_policy` to `adw.@"WrapPolicy.MINIMUM"` to only wrap
/// once all the children in the previous line have been shrunk to their minimum
/// size.
///
/// To make each line take the same amount of space, set
/// `WrapBox.properties.line_homogeneous` to `TRUE`.
///
/// Spacing and natural line length can scale with the text scale factor, use the
/// `WrapBox.properties.child_spacing_unit`, `WrapBox.properties.line_spacing_unit`
/// and/or `WrapBox.properties.natural_line_length_unit` properties to enable that
/// behavior.
///
/// See `WrapLayout`.
///
/// ## CSS nodes
///
/// `AdwWrapBox` uses a single CSS node with name `wrap-box`.
///
/// ## Accessibility
///
/// `AdwWrapBox` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
pub const WrapBox = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = adw.WrapBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The alignment of the children within each line.
        ///
        /// 0 means the children are placed at the start of the line, 1 means they are
        /// placed at the end of the line. 0.5 means they are placed in the middle of
        /// the line.
        ///
        /// Alignment is only used when `WrapBox.properties.justify` is set to
        /// `ADW_JUSTIFY_NONE`, or on the last line when the
        /// `WrapBox.properties.justify_last_line` is `FALSE`.
        pub const @"align" = struct {
            pub const name = "align";

            pub const Type = f32;
        };

        /// The spacing between widgets on the same line.
        ///
        /// See `WrapBox.properties.child_spacing_unit`.
        pub const child_spacing = struct {
            pub const name = "child-spacing";

            pub const Type = c_int;
        };

        /// The length unit for child spacing.
        ///
        /// Allows the spacing to vary depending on the text scale factor.
        ///
        /// See `WrapBox.properties.child_spacing`.
        pub const child_spacing_unit = struct {
            pub const name = "child-spacing-unit";

            pub const Type = adw.LengthUnit;
        };

        /// Determines whether and how each complete line should be stretched to fill
        /// the entire widget.
        ///
        /// If set to `ADW_JUSTIFY_FILL`, each widget in the line will be stretched,
        /// keeping consistent spacing, so that the line fills the entire widget.
        ///
        /// If set to `ADW_JUSTIFY_SPREAD`, the spacing between widgets will be
        /// increased, keeping widget sizes intact. The first and last widget will be
        /// aligned with the beginning and end of the line. If the line only contains
        /// a single widget, it will be stretched regardless.
        ///
        /// If set to `ADW_JUSTIFY_NONE`, the line will not be stretched and the
        /// children will be placed together within the line, according to
        /// `WrapBox.properties.@"align"`.
        ///
        /// By default this doesn't affect the last line, as it will be incomplete. Use
        /// `WrapBox.properties.justify_last_line` to justify it as well.
        pub const justify = struct {
            pub const name = "justify";

            pub const Type = adw.JustifyMode;
        };

        /// Whether the last line should be stretched to fill the entire widget.
        ///
        /// See `WrapBox.properties.justify`.
        pub const justify_last_line = struct {
            pub const name = "justify-last-line";

            pub const Type = c_int;
        };

        /// Whether all lines should take the same amount of space.
        pub const line_homogeneous = struct {
            pub const name = "line-homogeneous";

            pub const Type = c_int;
        };

        /// The spacing between lines.
        ///
        /// See `WrapBox.properties.line_spacing_unit`.
        pub const line_spacing = struct {
            pub const name = "line-spacing";

            pub const Type = c_int;
        };

        /// The length unit for line spacing.
        ///
        /// Allows the spacing to vary depending on the text scale factor.
        ///
        /// See `WrapBox.properties.line_spacing`.
        pub const line_spacing_unit = struct {
            pub const name = "line-spacing-unit";

            pub const Type = adw.LengthUnit;
        };

        /// Determines the natural size for each line.
        ///
        /// It should be used to limit the line lengths, for example when used in
        /// popovers.
        ///
        /// See `WrapBox.properties.natural_line_length_unit`.
        pub const natural_line_length = struct {
            pub const name = "natural-line-length";

            pub const Type = c_int;
        };

        /// The length unit for natural line length.
        ///
        /// Allows the length to vary depending on the text scale factor.
        ///
        /// See `WrapBox.properties.natural_line_length`.
        pub const natural_line_length_unit = struct {
            pub const name = "natural-line-length-unit";

            pub const Type = adw.LengthUnit;
        };

        /// The direction children are packed in each line.
        pub const pack_direction = struct {
            pub const name = "pack-direction";

            pub const Type = adw.PackDirection;
        };

        /// The policy for line wrapping.
        ///
        ///    + If set to `ADW_WRAP_NATURAL`, the box will wrap to the next line as soon as
        /// the previous line cannot fit any more children without shrinking them past
        /// their natural size.
        ///
        /// If set to `ADW_WRAP_MINIMUM`, the box will try to fit as many children into
        /// each line as possible, shrinking them down to their minimum size before
        /// wrapping to the next line.
        pub const wrap_policy = struct {
            pub const name = "wrap-policy";

            pub const Type = adw.WrapPolicy;
        };

        /// Whether wrap direction should be reversed.
        ///
        /// By default, lines wrap downwards in a horizontal box, and towards the end
        /// in a vertical box. If set to `TRUE`, they wrap upwards or towards the start
        /// respectively.
        pub const wrap_reverse = struct {
            pub const name = "wrap-reverse";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwWrapBox`.
    extern fn adw_wrap_box_new() *adw.WrapBox;
    pub const new = adw_wrap_box_new;

    /// Adds `child` as the last child to `self`.
    extern fn adw_wrap_box_append(p_self: *WrapBox, p_child: *gtk.Widget) void;
    pub const append = adw_wrap_box_append;

    /// Gets the alignment of the children within each line.
    extern fn adw_wrap_box_get_align(p_self: *WrapBox) f32;
    pub const getAlign = adw_wrap_box_get_align;

    /// Gets spacing between widgets on the same line.
    extern fn adw_wrap_box_get_child_spacing(p_self: *WrapBox) c_int;
    pub const getChildSpacing = adw_wrap_box_get_child_spacing;

    /// Gets the length unit for child spacing.
    extern fn adw_wrap_box_get_child_spacing_unit(p_self: *WrapBox) adw.LengthUnit;
    pub const getChildSpacingUnit = adw_wrap_box_get_child_spacing_unit;

    /// Gets whether and how each complete line is stretched to fill the entire widget.
    extern fn adw_wrap_box_get_justify(p_self: *WrapBox) adw.JustifyMode;
    pub const getJustify = adw_wrap_box_get_justify;

    /// Gets whether the last line should be stretched to fill the entire widget.
    extern fn adw_wrap_box_get_justify_last_line(p_self: *WrapBox) c_int;
    pub const getJustifyLastLine = adw_wrap_box_get_justify_last_line;

    /// Gets whether all lines should take the same amount of space.
    extern fn adw_wrap_box_get_line_homogeneous(p_self: *WrapBox) c_int;
    pub const getLineHomogeneous = adw_wrap_box_get_line_homogeneous;

    /// Gets the spacing between lines.
    ///
    /// See `WrapBox.properties.line_spacing_unit`.
    extern fn adw_wrap_box_get_line_spacing(p_self: *WrapBox) c_int;
    pub const getLineSpacing = adw_wrap_box_get_line_spacing;

    /// Gets the length unit for line spacing.
    extern fn adw_wrap_box_get_line_spacing_unit(p_self: *WrapBox) adw.LengthUnit;
    pub const getLineSpacingUnit = adw_wrap_box_get_line_spacing_unit;

    /// Gets the natural size for each line.
    extern fn adw_wrap_box_get_natural_line_length(p_self: *WrapBox) c_int;
    pub const getNaturalLineLength = adw_wrap_box_get_natural_line_length;

    /// Gets the length unit for line spacing.
    extern fn adw_wrap_box_get_natural_line_length_unit(p_self: *WrapBox) adw.LengthUnit;
    pub const getNaturalLineLengthUnit = adw_wrap_box_get_natural_line_length_unit;

    /// Gets the direction children are packed in each line.
    extern fn adw_wrap_box_get_pack_direction(p_self: *WrapBox) adw.PackDirection;
    pub const getPackDirection = adw_wrap_box_get_pack_direction;

    /// Gets the policy for line wrapping.
    extern fn adw_wrap_box_get_wrap_policy(p_self: *WrapBox) adw.WrapPolicy;
    pub const getWrapPolicy = adw_wrap_box_get_wrap_policy;

    /// Gets whether wrap direction is reversed.
    extern fn adw_wrap_box_get_wrap_reverse(p_self: *WrapBox) c_int;
    pub const getWrapReverse = adw_wrap_box_get_wrap_reverse;

    /// Inserts `child` in the position after `sibling` in the list of `self` children.
    ///
    /// If `sibling` is `NULL`, inserts `child` at the first position.
    extern fn adw_wrap_box_insert_child_after(p_self: *WrapBox, p_child: *gtk.Widget, p_sibling: ?*gtk.Widget) void;
    pub const insertChildAfter = adw_wrap_box_insert_child_after;

    /// Adds `child` as the first child to `self`.
    extern fn adw_wrap_box_prepend(p_self: *WrapBox, p_child: *gtk.Widget) void;
    pub const prepend = adw_wrap_box_prepend;

    /// Removes a child widget from `self`.
    ///
    /// The child must have been added before with `adw.WrapBox.append`,
    /// `adw.WrapBox.prepend`, or `adw.WrapBox.insertChildAfter`.
    extern fn adw_wrap_box_remove(p_self: *WrapBox, p_child: *gtk.Widget) void;
    pub const remove = adw_wrap_box_remove;

    /// Moves `child` to the position after `sibling` in the list of `self` children.
    ///
    /// If `sibling` is `NULL`, moves `child` to the first position.
    extern fn adw_wrap_box_reorder_child_after(p_self: *WrapBox, p_child: *gtk.Widget, p_sibling: ?*gtk.Widget) void;
    pub const reorderChildAfter = adw_wrap_box_reorder_child_after;

    /// Sets the alignment of the children within each line.
    ///
    /// 0 means the children are placed at the start of the line, 1 means they are
    /// placed at the end of the line. 0.5 means they are placed in the middle of the
    /// line.
    ///
    /// Alignment is only used when `WrapBox.properties.justify` is set to
    /// `ADW_JUSTIFY_NONE`, or on the last line when the
    /// `WrapBox.properties.justify_last_line` is `FALSE`.
    extern fn adw_wrap_box_set_align(p_self: *WrapBox, p_align: f32) void;
    pub const setAlign = adw_wrap_box_set_align;

    /// Sets the spacing between widgets on the same line.
    ///
    /// See `WrapBox.properties.child_spacing_unit`.
    extern fn adw_wrap_box_set_child_spacing(p_self: *WrapBox, p_child_spacing: c_int) void;
    pub const setChildSpacing = adw_wrap_box_set_child_spacing;

    /// Sets the length unit for child spacing.
    ///
    /// Allows the spacing to vary depending on the text scale factor.
    ///
    /// See `WrapBox.properties.child_spacing`.
    extern fn adw_wrap_box_set_child_spacing_unit(p_self: *WrapBox, p_unit: adw.LengthUnit) void;
    pub const setChildSpacingUnit = adw_wrap_box_set_child_spacing_unit;

    /// Determines whether and how each complete line should be stretched to fill
    /// the entire widget.
    ///
    /// If set to `ADW_JUSTIFY_FILL`, each widget in the line will be stretched,
    /// keeping consistent spacing, so that the line fills the entire widget.
    ///
    /// If set to `ADW_JUSTIFY_SPREAD`, the spacing between widgets will be
    /// increased, keeping widget sizes intact. The first and last widget will be
    /// aligned with the beginning and end of the line. If the line only contains a
    /// single widget, it will be stretched regardless.
    ///
    /// If set to `ADW_JUSTIFY_NONE`, the line will not be stretched and the children
    /// will be placed together within the line, according to
    /// `WrapBox.properties.@"align"`.
    ///
    /// By default this doesn't affect the last line, as it will be incomplete. Use
    /// `WrapBox.properties.justify_last_line` to justify it as well.
    extern fn adw_wrap_box_set_justify(p_self: *WrapBox, p_justify: adw.JustifyMode) void;
    pub const setJustify = adw_wrap_box_set_justify;

    /// Sets whether the last line should be stretched to fill the entire widget.
    ///
    /// See `WrapBox.properties.justify`.
    extern fn adw_wrap_box_set_justify_last_line(p_self: *WrapBox, p_justify_last_line: c_int) void;
    pub const setJustifyLastLine = adw_wrap_box_set_justify_last_line;

    /// Sets whether all lines should take the same amount of space.
    extern fn adw_wrap_box_set_line_homogeneous(p_self: *WrapBox, p_homogeneous: c_int) void;
    pub const setLineHomogeneous = adw_wrap_box_set_line_homogeneous;

    /// Sets the spacing between lines.
    extern fn adw_wrap_box_set_line_spacing(p_self: *WrapBox, p_line_spacing: c_int) void;
    pub const setLineSpacing = adw_wrap_box_set_line_spacing;

    /// Sets the length unit for line spacing.
    ///
    /// Allows the spacing to vary depending on the text scale factor.
    ///
    /// See `WrapBox.properties.line_spacing`.
    extern fn adw_wrap_box_set_line_spacing_unit(p_self: *WrapBox, p_unit: adw.LengthUnit) void;
    pub const setLineSpacingUnit = adw_wrap_box_set_line_spacing_unit;

    /// Sets the natural size for each line.
    ///
    /// It should be used to limit the line lengths, for example when used in
    /// popovers.
    ///
    /// See `WrapBox.properties.natural_line_length_unit`.
    extern fn adw_wrap_box_set_natural_line_length(p_self: *WrapBox, p_natural_line_length: c_int) void;
    pub const setNaturalLineLength = adw_wrap_box_set_natural_line_length;

    /// Sets the length unit for natural line length.
    ///
    /// Allows the length to vary depending on the text scale factor.
    ///
    /// See `WrapBox.properties.natural_line_length`.
    extern fn adw_wrap_box_set_natural_line_length_unit(p_self: *WrapBox, p_unit: adw.LengthUnit) void;
    pub const setNaturalLineLengthUnit = adw_wrap_box_set_natural_line_length_unit;

    /// Sets the direction children are packed in each line.
    extern fn adw_wrap_box_set_pack_direction(p_self: *WrapBox, p_pack_direction: adw.PackDirection) void;
    pub const setPackDirection = adw_wrap_box_set_pack_direction;

    /// Sets the policy for line wrapping.
    ///
    /// If set to `ADW_WRAP_NATURAL`, the box will wrap to the next line as soon as
    /// the previous line cannot fit any more children without shrinking them past
    /// their natural size.
    ///
    /// If set to `ADW_WRAP_MINIMUM`, the box will try to fit as many children into
    /// each line as possible, shrinking them down to their minimum size before
    /// wrapping to the next line.
    extern fn adw_wrap_box_set_wrap_policy(p_self: *WrapBox, p_wrap_policy: adw.WrapPolicy) void;
    pub const setWrapPolicy = adw_wrap_box_set_wrap_policy;

    /// Sets whether wrap direction should be reversed.
    ///
    /// By default, lines wrap downwards in a horizontal box, and towards the end
    /// in a vertical box. If set to `TRUE`, they wrap upwards or towards the start
    /// respectively.
    extern fn adw_wrap_box_set_wrap_reverse(p_self: *WrapBox, p_wrap_reverse: c_int) void;
    pub const setWrapReverse = adw_wrap_box_set_wrap_reverse;

    extern fn adw_wrap_box_get_type() usize;
    pub const getGObjectType = adw_wrap_box_get_type;

    extern fn g_object_ref(p_self: *adw.WrapBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.WrapBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WrapBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A box-like layout that can wrap into multiple lines.
///
/// <picture>
///   <source srcset="wrap-box-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="wrap-box.png" alt="wrap-box">
/// </picture>
///
/// `AdwWrapLayout` is similar to `gtk.BoxLayout`, but can wrap lines when
/// the widgets cannot fit otherwise. Unlike `gtk.FlowBox`, the children
/// aren't arranged into a grid and behave more like words in a wrapping label.
///
/// Like `GtkBoxLayout`, `AdwWrapLayout` is orientable and has spacing:
///
/// - `WrapLayout.properties.child_spacing` between children in the same line;
/// - `WrapLayout.properties.line_spacing` between lines.
///
/// ::: note
///     Unlike `GtkBoxLayout`, `AdwWrapLayout` cannot follow the CSS
///     `border-spacing` property.
///
/// Use the `WrapLayout.properties.natural_line_length` property to determine the
/// layout's natural size, e.g. when using it in a `gtk.Popover`.
///
/// Normally, a horizontal `AdwWrapLayout` wraps left to right and top to bottom
/// for left-to-right languages. Both of these directions can be reversed, using
/// the `WrapLayout.properties.pack_direction` and
/// `WrapLayout.properties.wrap_reverse` properties. Additionally, the alignment
/// of each line can be controlled with the `WrapLayout.properties.@"align"` property.
///
/// Lines can be justified using the `WrapLayout.properties.justify` property,
/// filling the entire line by either increasing child size or spacing depending
/// on the value. Set `WrapLayout.properties.justify_last_line` to justify the last
/// line as well.
///
/// By default, `AdwWrapLayout` wraps as soon as the previous line cannot fit
/// any more children without shrinking them past their natural size. Set
/// `WrapLayout.properties.wrap_policy` to `adw.@"WrapPolicy.MINIMUM"` to only
/// wrap once all the children in the previous line have been shrunk to their
/// minimum size.
///
/// To make each line take the same amount of space, set
/// `WrapLayout.properties.line_homogeneous` to `TRUE`.
///
/// Spacing and natural line length can scale with the text scale factor, use the
/// `WrapLayout.properties.child_spacing_unit`,
/// `WrapLayout.properties.line_spacing_unit` and/or
/// `WrapLayout.properties.natural_line_length_unit` properties to enable that
/// behavior.
///
/// See `WrapBox`.
pub const WrapLayout = opaque {
    pub const Parent = gtk.LayoutManager;
    pub const Implements = [_]type{gtk.Orientable};
    pub const Class = adw.WrapLayoutClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The alignment of the children within each line.
        ///
        /// 0 means the children are placed at the start of the line, 1 means they are
        /// placed at the end of the line. 0.5 means they are placed in the middle of
        /// the line.
        ///
        /// Alignment is only used when `WrapLayout.properties.justify` is set to
        /// `ADW_JUSTIFY_NONE`, or on the last line when the
        /// `WrapLayout.properties.justify_last_line` is `FALSE`.
        pub const @"align" = struct {
            pub const name = "align";

            pub const Type = f32;
        };

        /// The spacing between widgets on the same line.
        ///
        /// See `WrapLayout.properties.child_spacing_unit`.
        pub const child_spacing = struct {
            pub const name = "child-spacing";

            pub const Type = c_int;
        };

        /// The length unit for child spacing.
        ///
        /// Allows the spacing to vary depending on the text scale factor.
        ///
        /// See `WrapLayout.properties.child_spacing`.
        pub const child_spacing_unit = struct {
            pub const name = "child-spacing-unit";

            pub const Type = adw.LengthUnit;
        };

        /// Determines whether and how each complete line should be stretched to fill
        /// the entire widget.
        ///
        /// If set to `ADW_JUSTIFY_FILL`, each widget in the line will be stretched,
        /// keeping consistent spacing, so that the line fills the entire widget.
        ///
        /// If set to `ADW_JUSTIFY_SPREAD`, the spacing between widgets will be
        /// increased, keeping widget sizes intact. The first and last widget will be
        /// aligned with the beginning and end of the line. If the line only contains a
        /// single widget, it will be stretched regardless.
        ///
        /// If set to `ADW_JUSTIFY_NONE`, the line will not be stretched and the
        /// children will be placed together within the line, according to
        /// `WrapLayout.properties.@"align"`.
        ///
        /// By default this doesn't affect the last line, as it will be incomplete. Use
        /// `WrapLayout.properties.justify_last_line` to justify it as well.
        pub const justify = struct {
            pub const name = "justify";

            pub const Type = adw.JustifyMode;
        };

        /// Whether the last line should be stretched to fill the entire widget.
        ///
        /// See `WrapLayout.properties.justify`.
        pub const justify_last_line = struct {
            pub const name = "justify-last-line";

            pub const Type = c_int;
        };

        /// Whether all lines should take the same amount of space.
        pub const line_homogeneous = struct {
            pub const name = "line-homogeneous";

            pub const Type = c_int;
        };

        /// The spacing between lines.
        ///
        /// See `WrapLayout.properties.line_spacing_unit`.
        pub const line_spacing = struct {
            pub const name = "line-spacing";

            pub const Type = c_int;
        };

        /// The length unit for line spacing.
        ///
        /// Allows the spacing to vary depending on the text scale factor.
        ///
        /// See `WrapLayout.properties.line_spacing`.
        pub const line_spacing_unit = struct {
            pub const name = "line-spacing-unit";

            pub const Type = adw.LengthUnit;
        };

        /// Determines the natural size for each line.
        ///
        /// It should be used to limit the line lengths, for example when used in
        /// popovers.
        ///
        /// See `WrapLayout.properties.natural_line_length_unit`.
        pub const natural_line_length = struct {
            pub const name = "natural-line-length";

            pub const Type = c_int;
        };

        /// The length unit for natural line length.
        ///
        /// Allows the length to vary depending on the text scale factor.
        ///
        /// See `WrapLayout.properties.natural_line_length`.
        pub const natural_line_length_unit = struct {
            pub const name = "natural-line-length-unit";

            pub const Type = adw.LengthUnit;
        };

        /// The direction children are packed in each line.
        pub const pack_direction = struct {
            pub const name = "pack-direction";

            pub const Type = adw.PackDirection;
        };

        /// The policy for line wrapping.
        ///
        /// If set to `ADW_WRAP_NATURAL`, the box will wrap to the next line as soon as
        /// the previous line cannot fit any more children without shrinking them past
        /// their natural size.
        ///
        /// If set to `ADW_WRAP_MINIMUM`, the box will try to fit as many children into
        /// each line as possible, shrinking them down to their minimum size before
        /// wrapping to the next line.
        pub const wrap_policy = struct {
            pub const name = "wrap-policy";

            pub const Type = adw.WrapPolicy;
        };

        /// Whether wrap direction should be reversed.
        ///
        /// By default, lines wrap downwards in a horizontal box, and towards the end
        /// in a vertical box. If set to `TRUE`, they wrap upwards or towards the start
        /// respectively.
        pub const wrap_reverse = struct {
            pub const name = "wrap-reverse";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `AdwWrapLayout`.
    extern fn adw_wrap_layout_new() *adw.WrapLayout;
    pub const new = adw_wrap_layout_new;

    /// Gets the alignment of the children within each line.
    extern fn adw_wrap_layout_get_align(p_self: *WrapLayout) f32;
    pub const getAlign = adw_wrap_layout_get_align;

    /// Gets spacing between widgets on the same line.
    extern fn adw_wrap_layout_get_child_spacing(p_self: *WrapLayout) c_int;
    pub const getChildSpacing = adw_wrap_layout_get_child_spacing;

    /// Gets the length unit for child spacing.
    extern fn adw_wrap_layout_get_child_spacing_unit(p_self: *WrapLayout) adw.LengthUnit;
    pub const getChildSpacingUnit = adw_wrap_layout_get_child_spacing_unit;

    /// Gets whether and how each complete line is stretched to fill the entire widget.
    extern fn adw_wrap_layout_get_justify(p_self: *WrapLayout) adw.JustifyMode;
    pub const getJustify = adw_wrap_layout_get_justify;

    /// Gets whether the last line should be stretched to fill the entire widget.
    extern fn adw_wrap_layout_get_justify_last_line(p_self: *WrapLayout) c_int;
    pub const getJustifyLastLine = adw_wrap_layout_get_justify_last_line;

    /// Gets whether all lines should take the same amount of space.
    extern fn adw_wrap_layout_get_line_homogeneous(p_self: *WrapLayout) c_int;
    pub const getLineHomogeneous = adw_wrap_layout_get_line_homogeneous;

    /// Gets the spacing between lines.
    extern fn adw_wrap_layout_get_line_spacing(p_self: *WrapLayout) c_int;
    pub const getLineSpacing = adw_wrap_layout_get_line_spacing;

    /// Gets the length unit for line spacing.
    extern fn adw_wrap_layout_get_line_spacing_unit(p_self: *WrapLayout) adw.LengthUnit;
    pub const getLineSpacingUnit = adw_wrap_layout_get_line_spacing_unit;

    /// Gets the natural size for each line.
    extern fn adw_wrap_layout_get_natural_line_length(p_self: *WrapLayout) c_int;
    pub const getNaturalLineLength = adw_wrap_layout_get_natural_line_length;

    /// Gets the length unit for line spacing.
    extern fn adw_wrap_layout_get_natural_line_length_unit(p_self: *WrapLayout) adw.LengthUnit;
    pub const getNaturalLineLengthUnit = adw_wrap_layout_get_natural_line_length_unit;

    /// Gets the direction children are packed in each line.
    extern fn adw_wrap_layout_get_pack_direction(p_self: *WrapLayout) adw.PackDirection;
    pub const getPackDirection = adw_wrap_layout_get_pack_direction;

    /// Gets the policy for line wrapping.
    extern fn adw_wrap_layout_get_wrap_policy(p_self: *WrapLayout) adw.WrapPolicy;
    pub const getWrapPolicy = adw_wrap_layout_get_wrap_policy;

    /// Gets whether wrap direction is reversed.
    extern fn adw_wrap_layout_get_wrap_reverse(p_self: *WrapLayout) c_int;
    pub const getWrapReverse = adw_wrap_layout_get_wrap_reverse;

    /// Sets the alignment of the children within each line.
    ///
    /// 0 means the children are placed at the start of the line, 1 means they are
    /// placed at the end of the line. 0.5 means they are placed in the middle of the
    /// line.
    ///
    /// Alignment is only used when `WrapLayout.properties.justify` is set to
    /// `ADW_JUSTIFY_NONE`, or on the last line when the
    /// `WrapLayout.properties.justify_last_line` is `FALSE`.
    extern fn adw_wrap_layout_set_align(p_self: *WrapLayout, p_align: f32) void;
    pub const setAlign = adw_wrap_layout_set_align;

    /// Sets the spacing between widgets on the same line.
    ///
    /// See `WrapLayout.properties.child_spacing_unit`.
    extern fn adw_wrap_layout_set_child_spacing(p_self: *WrapLayout, p_child_spacing: c_int) void;
    pub const setChildSpacing = adw_wrap_layout_set_child_spacing;

    /// Sets the length unit for child spacing.
    ///
    /// Allows the spacing to vary depending on the text scale factor.
    ///
    /// See `WrapLayout.properties.child_spacing`.
    extern fn adw_wrap_layout_set_child_spacing_unit(p_self: *WrapLayout, p_unit: adw.LengthUnit) void;
    pub const setChildSpacingUnit = adw_wrap_layout_set_child_spacing_unit;

    /// Sets whether and how each complete line should be stretched to fill the
    /// entire widget.
    ///
    /// If set to `ADW_JUSTIFY_FILL`, each widget in the line will be stretched,
    /// keeping consistent spacing, so that the line fills the entire widget.
    ///
    /// If set to `ADW_JUSTIFY_SPREAD`, the spacing between widgets will be
    /// increased, keeping widget sizes intact. The first and last widget will be
    /// aligned with the beginning and end of the line. If the line only contains a
    /// single widget, it will be stretched regardless.
    ///
    /// If set to `ADW_JUSTIFY_NONE`, the line will not be stretched and the children
    /// will be placed together within the line, according to
    /// `WrapLayout.properties.@"align"`.
    ///
    /// By default this doesn't affect the last line, as it will be incomplete. Use
    /// `WrapLayout.properties.justify_last_line` to justify it as well.
    extern fn adw_wrap_layout_set_justify(p_self: *WrapLayout, p_justify: adw.JustifyMode) void;
    pub const setJustify = adw_wrap_layout_set_justify;

    /// Sets whether the last line should be stretched to fill the entire widget.
    ///
    /// See `WrapLayout.properties.justify`.
    extern fn adw_wrap_layout_set_justify_last_line(p_self: *WrapLayout, p_justify_last_line: c_int) void;
    pub const setJustifyLastLine = adw_wrap_layout_set_justify_last_line;

    /// Sets whether all lines should take the same amount of space.
    extern fn adw_wrap_layout_set_line_homogeneous(p_self: *WrapLayout, p_homogeneous: c_int) void;
    pub const setLineHomogeneous = adw_wrap_layout_set_line_homogeneous;

    /// Sets the spacing between lines.
    ///
    /// See `WrapLayout.properties.line_spacing_unit`.
    extern fn adw_wrap_layout_set_line_spacing(p_self: *WrapLayout, p_line_spacing: c_int) void;
    pub const setLineSpacing = adw_wrap_layout_set_line_spacing;

    /// Sets the length unit for line spacing.
    ///
    /// Allows the spacing to vary depending on the text scale factor.
    ///
    /// See `WrapLayout.properties.line_spacing`.
    extern fn adw_wrap_layout_set_line_spacing_unit(p_self: *WrapLayout, p_unit: adw.LengthUnit) void;
    pub const setLineSpacingUnit = adw_wrap_layout_set_line_spacing_unit;

    /// Sets the natural size for each line.
    ///
    /// It should be used to limit the line lengths, for example when used in
    /// popovers.
    ///
    /// See `WrapLayout.properties.natural_line_length_unit`.
    extern fn adw_wrap_layout_set_natural_line_length(p_self: *WrapLayout, p_natural_line_length: c_int) void;
    pub const setNaturalLineLength = adw_wrap_layout_set_natural_line_length;

    /// Sets the length unit for natural line length.
    ///
    /// Allows the length to vary depending on the text scale factor.
    ///
    /// See `WrapLayout.properties.natural_line_length`.
    extern fn adw_wrap_layout_set_natural_line_length_unit(p_self: *WrapLayout, p_unit: adw.LengthUnit) void;
    pub const setNaturalLineLengthUnit = adw_wrap_layout_set_natural_line_length_unit;

    /// Sets the direction children are packed in each line.
    extern fn adw_wrap_layout_set_pack_direction(p_self: *WrapLayout, p_pack_direction: adw.PackDirection) void;
    pub const setPackDirection = adw_wrap_layout_set_pack_direction;

    /// Sets the policy for line wrapping.
    ///
    /// If set to `ADW_WRAP_NATURAL`, the box will wrap to the next line as soon as
    /// the previous line cannot fit any more children without shrinking them past
    /// their natural size.
    ///
    /// If set to `ADW_WRAP_MINIMUM`, the box will try to fit as many children into
    /// each line as possible, shrinking them down to their minimum size before
    /// wrapping to the next line.
    extern fn adw_wrap_layout_set_wrap_policy(p_self: *WrapLayout, p_wrap_policy: adw.WrapPolicy) void;
    pub const setWrapPolicy = adw_wrap_layout_set_wrap_policy;

    /// Sets whether wrap direction should be reversed.
    ///
    /// By default, lines wrap downwards in a horizontal box, and towards the end
    /// in a vertical box. If set to `TRUE`, they wrap upwards or towards the start
    /// respectively.
    extern fn adw_wrap_layout_set_wrap_reverse(p_self: *WrapLayout, p_wrap_reverse: c_int) void;
    pub const setWrapReverse = adw_wrap_layout_set_wrap_reverse;

    extern fn adw_wrap_layout_get_type() usize;
    pub const getGObjectType = adw_wrap_layout_get_type;

    extern fn g_object_ref(p_self: *adw.WrapLayout) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.WrapLayout) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WrapLayout, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface for swipeable widgets.
///
/// The `AdwSwipeable` interface is implemented by all swipeable widgets.
///
/// See `SwipeTracker` for details about implementing it.
pub const Swipeable = opaque {
    pub const Prerequisites = [_]type{gtk.Widget};
    pub const Iface = adw.SwipeableInterface;
    pub const virtual_methods = struct {
        /// Gets the progress `self` will snap back to after the gesture is canceled.
        pub const get_cancel_progress = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Swipeable.Iface, p_class).f_get_cancel_progress.?(gobject.ext.as(Swipeable, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Swipeable.Iface, p_class).f_get_cancel_progress = @ptrCast(p_implementation);
            }
        };

        /// Gets the swipe distance of `self`.
        ///
        /// This corresponds to how many pixels 1 unit represents.
        pub const get_distance = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Swipeable.Iface, p_class).f_get_distance.?(gobject.ext.as(Swipeable, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Swipeable.Iface, p_class).f_get_distance = @ptrCast(p_implementation);
            }
        };

        /// Gets the current progress of `self`.
        pub const get_progress = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Swipeable.Iface, p_class).f_get_progress.?(gobject.ext.as(Swipeable, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Swipeable.Iface, p_class).f_get_progress = @ptrCast(p_implementation);
            }
        };

        /// Gets the snap points of `self`.
        ///
        /// Each snap point represents a progress value that is considered acceptable to
        /// end the swipe on.
        pub const get_snap_points = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_n_snap_points: *c_int) [*]f64 {
                return gobject.ext.as(Swipeable.Iface, p_class).f_get_snap_points.?(gobject.ext.as(Swipeable, p_self), p_n_snap_points);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_n_snap_points: *c_int) callconv(.c) [*]f64) void {
                gobject.ext.as(Swipeable.Iface, p_class).f_get_snap_points = @ptrCast(p_implementation);
            }
        };

        /// Gets the area `self` can start a swipe from for the given direction and
        /// gesture type.
        ///
        /// This can be used to restrict swipes to only be possible from a certain area,
        /// for example, to only allow edge swipes, or to have a draggable element and
        /// ignore swipes elsewhere.
        ///
        /// If not implemented, the default implementation returns the allocation of
        /// `self`, allowing swipes from anywhere.
        pub const get_swipe_area = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_navigation_direction: adw.NavigationDirection, p_is_drag: c_int, p_rect: *gdk.Rectangle) void {
                return gobject.ext.as(Swipeable.Iface, p_class).f_get_swipe_area.?(gobject.ext.as(Swipeable, p_self), p_navigation_direction, p_is_drag, p_rect);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_navigation_direction: adw.NavigationDirection, p_is_drag: c_int, p_rect: *gdk.Rectangle) callconv(.c) void) void {
                gobject.ext.as(Swipeable.Iface, p_class).f_get_swipe_area = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the progress `self` will snap back to after the gesture is canceled.
    extern fn adw_swipeable_get_cancel_progress(p_self: *Swipeable) f64;
    pub const getCancelProgress = adw_swipeable_get_cancel_progress;

    /// Gets the swipe distance of `self`.
    ///
    /// This corresponds to how many pixels 1 unit represents.
    extern fn adw_swipeable_get_distance(p_self: *Swipeable) f64;
    pub const getDistance = adw_swipeable_get_distance;

    /// Gets the current progress of `self`.
    extern fn adw_swipeable_get_progress(p_self: *Swipeable) f64;
    pub const getProgress = adw_swipeable_get_progress;

    /// Gets the snap points of `self`.
    ///
    /// Each snap point represents a progress value that is considered acceptable to
    /// end the swipe on.
    extern fn adw_swipeable_get_snap_points(p_self: *Swipeable, p_n_snap_points: *c_int) [*]f64;
    pub const getSnapPoints = adw_swipeable_get_snap_points;

    /// Gets the area `self` can start a swipe from for the given direction and
    /// gesture type.
    ///
    /// This can be used to restrict swipes to only be possible from a certain area,
    /// for example, to only allow edge swipes, or to have a draggable element and
    /// ignore swipes elsewhere.
    ///
    /// If not implemented, the default implementation returns the allocation of
    /// `self`, allowing swipes from anywhere.
    extern fn adw_swipeable_get_swipe_area(p_self: *Swipeable, p_navigation_direction: adw.NavigationDirection, p_is_drag: c_int, p_rect: *gdk.Rectangle) void;
    pub const getSwipeArea = adw_swipeable_get_swipe_area;

    extern fn adw_swipeable_get_type() usize;
    pub const getGObjectType = adw_swipeable_get_type;

    extern fn g_object_ref(p_self: *adw.Swipeable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *adw.Swipeable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Swipeable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AboutDialogClass = extern struct {
    pub const Instance = adw.AboutDialog;

    f_parent_class: adw.DialogClass,

    pub fn as(p_instance: *AboutDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AboutWindowClass = extern struct {
    pub const Instance = adw.AboutWindow;

    f_parent_class: adw.WindowClass,

    pub fn as(p_instance: *AboutWindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ActionRowClass = extern struct {
    pub const Instance = adw.ActionRow;

    /// The parent class
    f_parent_class: adw.PreferencesRowClass,
    /// Activates the row to trigger its main action.
    f_activate: ?*const fn (p_self: *adw.ActionRow) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *ActionRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AlertDialogClass = extern struct {
    pub const Instance = adw.AlertDialog;

    f_parent_class: adw.DialogClass,
    f_response: ?*const fn (p_self: *adw.AlertDialog, p_response: [*:0]const u8) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *AlertDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AnimationClass = opaque {
    pub const Instance = adw.Animation;

    pub fn as(p_instance: *AnimationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AnimationTargetClass = opaque {
    pub const Instance = adw.AnimationTarget;

    pub fn as(p_instance: *AnimationTargetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationClass = extern struct {
    pub const Instance = adw.Application;

    /// The parent class
    f_parent_class: gtk.ApplicationClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *ApplicationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationWindowClass = extern struct {
    pub const Instance = adw.ApplicationWindow;

    f_parent_class: gtk.ApplicationWindowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *ApplicationWindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AvatarClass = extern struct {
    pub const Instance = adw.Avatar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *AvatarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BannerClass = extern struct {
    pub const Instance = adw.Banner;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *BannerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BinClass = extern struct {
    pub const Instance = adw.Bin;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *BinClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BottomSheetClass = extern struct {
    pub const Instance = adw.BottomSheet;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *BottomSheetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BreakpointBinClass = extern struct {
    pub const Instance = adw.BreakpointBin;

    f_parent_class: gtk.WidgetClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *BreakpointBinClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BreakpointClass = extern struct {
    pub const Instance = adw.Breakpoint;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *BreakpointClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes condition for an `Breakpoint`.
pub const BreakpointCondition = opaque {
    /// Parses a condition from a string.
    ///
    /// Length conditions are specified as `<type>: <value>[<unit>]`, where:
    ///
    /// - `<type>` can be `min-width`, `max-width`, `min-height` or `max-height`
    /// - `<value>` is a fractional number
    /// - `<unit>` can be `px`, `pt` or `sp`
    ///
    /// If the unit is omitted, `px` is assumed.
    ///
    /// See `BreakpointCondition.newLength`.
    ///
    /// Examples:
    ///
    /// - `min-width: 500px`
    /// - `min-height: 400pt`
    /// - `max-width: 100sp`
    /// - `max-height: 500`
    ///
    /// Ratio conditions are specified as `<type>: <width>[/<height>]`, where:
    ///
    /// - `<type>` can be `min-aspect-ratio` or `max-aspect-ratio`
    /// - `<width>` and `<height>` are integer numbers
    ///
    /// See `BreakpointCondition.newRatio`.
    ///
    /// The ratio is represented as `<width>` divided by `<height>`.
    ///
    /// If `<height>` is omitted, it's assumed to be 1.
    ///
    /// Examples:
    ///
    /// - `min-aspect-ratio: 4/3`
    /// - `max-aspect-ratio: 1`
    ///
    /// The logical operators `and`, `or` can be used to compose a complex condition
    /// as follows:
    ///
    /// - `<condition> and <condition>`: the condition is true when both
    ///   `<condition>`s are true, same as when using
    ///   `BreakpointCondition.newAnd`
    /// - `<condition> or <condition>`: the condition is true when either of the
    ///   `<condition>`s is true, same as when using
    ///   `BreakpointCondition.newOr`
    ///
    /// Examples:
    ///
    /// - `min-width: 400px and max-aspect-ratio: 4/3`
    /// - `max-width: 360sp or max-width: 360px`
    ///
    /// Conditions can be further nested using parentheses, for example:
    ///
    /// - `min-width: 400px and (max-aspect-ratio: 4/3 or max-height: 400px)`
    ///
    /// If parentheses are omitted, the first operator takes priority.
    extern fn adw_breakpoint_condition_parse(p_str: [*:0]const u8) *adw.BreakpointCondition;
    pub const parse = adw_breakpoint_condition_parse;

    /// Creates a condition that triggers when `condition_1` and `condition_2` are both
    /// true.
    extern fn adw_breakpoint_condition_new_and(p_condition_1: *adw.BreakpointCondition, p_condition_2: *adw.BreakpointCondition) *adw.BreakpointCondition;
    pub const newAnd = adw_breakpoint_condition_new_and;

    /// Creates a condition that triggers on length changes.
    extern fn adw_breakpoint_condition_new_length(p_type: adw.BreakpointConditionLengthType, p_value: f64, p_unit: adw.LengthUnit) *adw.BreakpointCondition;
    pub const newLength = adw_breakpoint_condition_new_length;

    /// Creates a condition that triggers when either `condition_1` or `condition_2` is
    /// true.
    extern fn adw_breakpoint_condition_new_or(p_condition_1: *adw.BreakpointCondition, p_condition_2: *adw.BreakpointCondition) *adw.BreakpointCondition;
    pub const newOr = adw_breakpoint_condition_new_or;

    /// Creates a condition that triggers on ratio changes.
    ///
    /// The ratio is represented as `width` divided by `height`.
    extern fn adw_breakpoint_condition_new_ratio(p_type: adw.BreakpointConditionRatioType, p_width: c_int, p_height: c_int) *adw.BreakpointCondition;
    pub const newRatio = adw_breakpoint_condition_new_ratio;

    /// Copies `self`.
    extern fn adw_breakpoint_condition_copy(p_self: *BreakpointCondition) *adw.BreakpointCondition;
    pub const copy = adw_breakpoint_condition_copy;

    /// Frees `self`.
    extern fn adw_breakpoint_condition_free(p_self: *BreakpointCondition) void;
    pub const free = adw_breakpoint_condition_free;

    /// Returns a textual representation of `self`.
    ///
    /// The returned string can be parsed by `BreakpointCondition.parse`.
    extern fn adw_breakpoint_condition_to_string(p_self: *BreakpointCondition) [*:0]u8;
    pub const toString = adw_breakpoint_condition_to_string;

    extern fn adw_breakpoint_condition_get_type() usize;
    pub const getGObjectType = adw_breakpoint_condition_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ButtonContentClass = extern struct {
    pub const Instance = adw.ButtonContent;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ButtonContentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ButtonRowClass = extern struct {
    pub const Instance = adw.ButtonRow;

    f_parent_class: adw.PreferencesRowClass,

    pub fn as(p_instance: *ButtonRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CallbackAnimationTargetClass = opaque {
    pub const Instance = adw.CallbackAnimationTarget;

    pub fn as(p_instance: *CallbackAnimationTargetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CarouselClass = extern struct {
    pub const Instance = adw.Carousel;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *CarouselClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CarouselIndicatorDotsClass = extern struct {
    pub const Instance = adw.CarouselIndicatorDots;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *CarouselIndicatorDotsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CarouselIndicatorLinesClass = extern struct {
    pub const Instance = adw.CarouselIndicatorLines;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *CarouselIndicatorLinesClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClampClass = extern struct {
    pub const Instance = adw.Clamp;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ClampClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClampLayoutClass = extern struct {
    pub const Instance = adw.ClampLayout;

    f_parent_class: gtk.LayoutManagerClass,

    pub fn as(p_instance: *ClampLayoutClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClampScrollableClass = extern struct {
    pub const Instance = adw.ClampScrollable;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ClampScrollableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ComboRowClass = extern struct {
    pub const Instance = adw.ComboRow;

    /// The parent class
    f_parent_class: adw.ActionRowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *ComboRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DialogClass = extern struct {
    pub const Instance = adw.Dialog;

    f_parent_class: gtk.WidgetClass,
    f_close_attempt: ?*const fn (p_dialog: *adw.Dialog) callconv(.c) void,
    f_closed: ?*const fn (p_dialog: *adw.Dialog) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *DialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EntryRowClass = extern struct {
    pub const Instance = adw.EntryRow;

    /// The parent class
    f_parent_class: adw.PreferencesRowClass,

    pub fn as(p_instance: *EntryRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EnumListItemClass = extern struct {
    pub const Instance = adw.EnumListItem;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *EnumListItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EnumListModelClass = extern struct {
    pub const Instance = adw.EnumListModel;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *EnumListModelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExpanderRowClass = extern struct {
    pub const Instance = adw.ExpanderRow;

    /// The parent class
    f_parent_class: adw.PreferencesRowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *ExpanderRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FlapClass = extern struct {
    pub const Instance = adw.Flap;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *FlapClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HeaderBarClass = extern struct {
    pub const Instance = adw.HeaderBar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *HeaderBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InlineViewSwitcherClass = extern struct {
    pub const Instance = adw.InlineViewSwitcher;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *InlineViewSwitcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayoutClass = extern struct {
    pub const Instance = adw.Layout;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *LayoutClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayoutSlotClass = extern struct {
    pub const Instance = adw.LayoutSlot;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *LayoutSlotClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LeafletClass = extern struct {
    pub const Instance = adw.Leaflet;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *LeafletClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LeafletPageClass = extern struct {
    pub const Instance = adw.LeafletPage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *LeafletPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageDialogClass = extern struct {
    pub const Instance = adw.MessageDialog;

    f_parent_class: gtk.WindowClass,
    f_response: ?*const fn (p_self: *adw.MessageDialog, p_response: [*:0]const u8) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *MessageDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultiLayoutViewClass = extern struct {
    pub const Instance = adw.MultiLayoutView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *MultiLayoutViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NavigationPageClass = extern struct {
    pub const Instance = adw.NavigationPage;

    f_parent_class: gtk.WidgetClass,
    f_showing: ?*const fn (p_self: *adw.NavigationPage) callconv(.c) void,
    f_shown: ?*const fn (p_self: *adw.NavigationPage) callconv(.c) void,
    f_hiding: ?*const fn (p_self: *adw.NavigationPage) callconv(.c) void,
    f_hidden: ?*const fn (p_self: *adw.NavigationPage) callconv(.c) void,
    f_padding: [8]*anyopaque,

    pub fn as(p_instance: *NavigationPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NavigationSplitViewClass = extern struct {
    pub const Instance = adw.NavigationSplitView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *NavigationSplitViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NavigationViewClass = extern struct {
    pub const Instance = adw.NavigationView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *NavigationViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OverlaySplitViewClass = extern struct {
    pub const Instance = adw.OverlaySplitView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *OverlaySplitViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PasswordEntryRowClass = extern struct {
    pub const Instance = adw.PasswordEntryRow;

    f_parent_class: adw.EntryRowClass,

    pub fn as(p_instance: *PasswordEntryRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreferencesDialogClass = extern struct {
    pub const Instance = adw.PreferencesDialog;

    /// The parent class
    f_parent_class: adw.DialogClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *PreferencesDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreferencesGroupClass = extern struct {
    pub const Instance = adw.PreferencesGroup;

    /// The parent class
    f_parent_class: gtk.WidgetClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *PreferencesGroupClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreferencesPageClass = extern struct {
    pub const Instance = adw.PreferencesPage;

    /// The parent class
    f_parent_class: gtk.WidgetClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *PreferencesPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreferencesRowClass = extern struct {
    pub const Instance = adw.PreferencesRow;

    /// The parent class
    f_parent_class: gtk.ListBoxRowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *PreferencesRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreferencesWindowClass = extern struct {
    pub const Instance = adw.PreferencesWindow;

    /// The parent class
    f_parent_class: adw.WindowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *PreferencesWindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyAnimationTargetClass = opaque {
    pub const Instance = adw.PropertyAnimationTarget;

    pub fn as(p_instance: *PropertyAnimationTargetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinRowClass = extern struct {
    pub const Instance = adw.SpinRow;

    f_parent_class: adw.ActionRowClass,

    pub fn as(p_instance: *SpinRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinnerClass = extern struct {
    pub const Instance = adw.Spinner;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *SpinnerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinnerPaintableClass = extern struct {
    pub const Instance = adw.SpinnerPaintable;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SpinnerPaintableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SplitButtonClass = extern struct {
    pub const Instance = adw.SplitButton;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *SplitButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpringAnimationClass = opaque {
    pub const Instance = adw.SpringAnimation;

    pub fn as(p_instance: *SpringAnimationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Physical parameters of a spring for `SpringAnimation`.
///
/// Any spring can be described by three parameters: mass, stiffness and damping.
///
/// An undamped spring will produce an oscillatory motion which will go on
/// forever.
///
/// The frequency and amplitude of the oscillations will be determined by the
/// stiffness (how "strong" the spring is) and its mass (how much "inertia" it
/// has).
///
/// If damping is larger than 0, the amplitude of that oscillating motion will
/// exponientally decrease over time. If that damping is strong enough that the
/// spring can't complete a full oscillation, it's called an overdamped spring.
///
/// If we the spring can oscillate, it's called an underdamped spring.
///
/// The value between these two behaviors is called critical damping; a
/// critically damped spring will comes to rest in the minimum possible time
/// without producing oscillations.
///
/// The damping can be replaced by damping ratio, which produces the following
/// springs:
///
/// * 0: an undamped spring.
/// * Between 0 and 1: an underdamped spring.
/// * 1: a critically damped spring.
/// * Larger than 1: an overdamped spring.
///
/// As such
pub const SpringParams = opaque {
    /// Creates a new `AdwSpringParams` from `mass`, `stiffness` and `damping_ratio`.
    ///
    /// The damping value is calculated from `damping_ratio` and the other two
    /// parameters.
    ///
    /// * If `damping_ratio` is 0, the spring will not be damped and will oscillate
    ///   endlessly.
    /// * If `damping_ratio` is between 0 and 1, the spring is underdamped and will
    ///   always overshoot.
    /// * If `damping_ratio` is 1, the spring is critically damped and will reach its
    ///   resting position the quickest way possible.
    /// * If `damping_ratio` is larger than 1, the spring is overdamped and will reach
    ///   its resting position faster than it can complete an oscillation.
    ///
    /// `SpringParams.newFull` allows to pass a raw damping value instead.
    extern fn adw_spring_params_new(p_damping_ratio: f64, p_mass: f64, p_stiffness: f64) *adw.SpringParams;
    pub const new = adw_spring_params_new;

    /// Creates a new `AdwSpringParams` from `mass`, `stiffness` and `damping`.
    ///
    /// See `SpringParams.new` for a simplified constructor using damping ratio
    /// instead of `damping`.
    extern fn adw_spring_params_new_full(p_damping: f64, p_mass: f64, p_stiffness: f64) *adw.SpringParams;
    pub const newFull = adw_spring_params_new_full;

    /// Gets the damping of `self`.
    extern fn adw_spring_params_get_damping(p_self: *SpringParams) f64;
    pub const getDamping = adw_spring_params_get_damping;

    /// Gets the damping ratio of `self`.
    extern fn adw_spring_params_get_damping_ratio(p_self: *SpringParams) f64;
    pub const getDampingRatio = adw_spring_params_get_damping_ratio;

    /// Gets the mass of `self`.
    extern fn adw_spring_params_get_mass(p_self: *SpringParams) f64;
    pub const getMass = adw_spring_params_get_mass;

    /// Gets the stiffness of `self`.
    extern fn adw_spring_params_get_stiffness(p_self: *SpringParams) f64;
    pub const getStiffness = adw_spring_params_get_stiffness;

    /// Increases the reference count of `self`.
    extern fn adw_spring_params_ref(p_self: *SpringParams) *adw.SpringParams;
    pub const ref = adw_spring_params_ref;

    /// Decreases the reference count of `self`.
    ///
    /// If the last reference is dropped, the structure is freed.
    extern fn adw_spring_params_unref(p_self: *SpringParams) void;
    pub const unref = adw_spring_params_unref;

    extern fn adw_spring_params_get_type() usize;
    pub const getGObjectType = adw_spring_params_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SqueezerClass = extern struct {
    pub const Instance = adw.Squeezer;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *SqueezerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SqueezerPageClass = extern struct {
    pub const Instance = adw.SqueezerPage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SqueezerPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StatusPageClass = extern struct {
    pub const Instance = adw.StatusPage;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *StatusPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StyleManagerClass = extern struct {
    pub const Instance = adw.StyleManager;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *StyleManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SwipeTrackerClass = extern struct {
    pub const Instance = adw.SwipeTracker;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SwipeTrackerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface for swipeable widgets.
pub const SwipeableInterface = extern struct {
    pub const Instance = adw.Swipeable;

    /// The parent interface.
    f_parent: gobject.TypeInterface,
    /// Gets the swipe distance.
    f_get_distance: ?*const fn (p_self: *adw.Swipeable) callconv(.c) f64,
    /// Gets the snap points.
    f_get_snap_points: ?*const fn (p_self: *adw.Swipeable, p_n_snap_points: *c_int) callconv(.c) [*]f64,
    /// Gets the current progress.
    f_get_progress: ?*const fn (p_self: *adw.Swipeable) callconv(.c) f64,
    /// Gets the cancel progress.
    f_get_cancel_progress: ?*const fn (p_self: *adw.Swipeable) callconv(.c) f64,
    /// Gets the swipeable rectangle.
    f_get_swipe_area: ?*const fn (p_self: *adw.Swipeable, p_navigation_direction: adw.NavigationDirection, p_is_drag: c_int, p_rect: *gdk.Rectangle) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *SwipeableInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SwitchRowClass = extern struct {
    pub const Instance = adw.SwitchRow;

    f_parent_class: adw.ActionRowClass,

    pub fn as(p_instance: *SwitchRowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TabBarClass = extern struct {
    pub const Instance = adw.TabBar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *TabBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TabButtonClass = extern struct {
    pub const Instance = adw.TabButton;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *TabButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TabOverviewClass = extern struct {
    pub const Instance = adw.TabOverview;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *TabOverviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TabPageClass = extern struct {
    pub const Instance = adw.TabPage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *TabPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TabViewClass = extern struct {
    pub const Instance = adw.TabView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *TabViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimedAnimationClass = opaque {
    pub const Instance = adw.TimedAnimation;

    pub fn as(p_instance: *TimedAnimationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToastClass = extern struct {
    pub const Instance = adw.Toast;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ToastClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToastOverlayClass = extern struct {
    pub const Instance = adw.ToastOverlay;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ToastOverlayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToggleClass = extern struct {
    pub const Instance = adw.Toggle;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ToggleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToggleGroupClass = extern struct {
    pub const Instance = adw.ToggleGroup;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ToggleGroupClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToolbarViewClass = extern struct {
    pub const Instance = adw.ToolbarView;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ToolbarViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewStackClass = extern struct {
    pub const Instance = adw.ViewStack;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ViewStackClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewStackPageClass = extern struct {
    pub const Instance = adw.ViewStackPage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ViewStackPageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewStackPagesClass = extern struct {
    pub const Instance = adw.ViewStackPages;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ViewStackPagesClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewSwitcherBarClass = extern struct {
    pub const Instance = adw.ViewSwitcherBar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ViewSwitcherBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewSwitcherClass = extern struct {
    pub const Instance = adw.ViewSwitcher;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ViewSwitcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ViewSwitcherTitleClass = extern struct {
    pub const Instance = adw.ViewSwitcherTitle;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ViewSwitcherTitleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowClass = extern struct {
    pub const Instance = adw.Window;

    f_parent_class: gtk.WindowClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *WindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowTitleClass = extern struct {
    pub const Instance = adw.WindowTitle;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *WindowTitleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WrapBoxClass = extern struct {
    pub const Instance = adw.WrapBox;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *WrapBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WrapLayoutClass = extern struct {
    pub const Instance = adw.WrapLayout;

    f_parent_class: gtk.LayoutManagerClass,

    pub fn as(p_instance: *WrapLayoutClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the available system accent colors.
pub const AccentColor = enum(c_int) {
    blue = 0,
    teal = 1,
    green = 2,
    yellow = 3,
    orange = 4,
    red = 5,
    pink = 6,
    purple = 7,
    slate = 8,
    _,

    /// Converts `self` to a `GdkRGBA` representing its background color.
    ///
    /// The matching foreground color is white.
    extern fn adw_accent_color_to_rgba(p_self: adw.AccentColor, p_rgba: *gdk.RGBA) void;
    pub const toRgba = adw_accent_color_to_rgba;

    /// Converts `self` to a `GdkRGBA` representing its standalone color.
    ///
    /// It will typically be darker for light background, and lighter for dark
    /// background, ensuring contrast.
    extern fn adw_accent_color_to_standalone_rgba(p_self: adw.AccentColor, p_dark: c_int, p_rgba: *gdk.RGBA) void;
    pub const toStandaloneRgba = adw_accent_color_to_standalone_rgba;

    extern fn adw_accent_color_get_type() usize;
    pub const getGObjectType = adw_accent_color_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible states of an `Animation`.
///
/// The state can be controlled with `Animation.play`,
/// `Animation.pause`, `Animation.@"resume"`,
/// `Animation.reset` and `Animation.skip`.
pub const AnimationState = enum(c_int) {
    idle = 0,
    paused = 1,
    playing = 2,
    finished = 3,
    _,

    extern fn adw_animation_state_get_type() usize;
    pub const getGObjectType = adw_animation_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the available button styles for `Banner`.
///
/// New values may be added to this enumeration over time.
///
/// See `Banner.properties.button_style`.
pub const BannerButtonStyle = enum(c_int) {
    default = 0,
    suggested = 1,
    _,

    extern fn adw_banner_button_style_get_type() usize;
    pub const getGObjectType = adw_banner_button_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes length types for `BreakpointCondition`.
///
/// See `BreakpointCondition.newLength`.
///
/// New values may be added to this enumeration over time.
pub const BreakpointConditionLengthType = enum(c_int) {
    min_width = 0,
    max_width = 1,
    min_height = 2,
    max_height = 3,
    _,

    extern fn adw_breakpoint_condition_length_type_get_type() usize;
    pub const getGObjectType = adw_breakpoint_condition_length_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes ratio types for `BreakpointCondition`.
///
/// See `BreakpointCondition.newRatio`.
///
/// New values may be added to this enumeration over time.
pub const BreakpointConditionRatioType = enum(c_int) {
    min_aspect_ratio = 0,
    max_aspect_ratio = 1,
    _,

    extern fn adw_breakpoint_condition_ratio_type_get_type() usize;
    pub const getGObjectType = adw_breakpoint_condition_ratio_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes title centering behavior of a `HeaderBar` widget.
pub const CenteringPolicy = enum(c_int) {
    loose = 0,
    strict = 1,
    _,

    extern fn adw_centering_policy_get_type() usize;
    pub const getGObjectType = adw_centering_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Application color schemes for `StyleManager.properties.color_scheme`.
pub const ColorScheme = enum(c_int) {
    default = 0,
    force_light = 1,
    prefer_light = 2,
    prefer_dark = 3,
    force_dark = 4,
    _,

    extern fn adw_color_scheme_get_type() usize;
    pub const getGObjectType = adw_color_scheme_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the available presentation modes for `Dialog`.
///
/// New values may be added to this enumeration over time.
///
/// See `Dialog.properties.presentation_mode`.
pub const DialogPresentationMode = enum(c_int) {
    auto = 0,
    floating = 1,
    bottom_sheet = 2,
    _,

    extern fn adw_dialog_presentation_mode_get_type() usize;
    pub const getGObjectType = adw_dialog_presentation_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the available easing functions for use with
/// `TimedAnimation`.
///
/// New values may be added to this enumeration over time.
pub const Easing = enum(c_int) {
    linear = 0,
    ease_in_quad = 1,
    ease_out_quad = 2,
    ease_in_out_quad = 3,
    ease_in_cubic = 4,
    ease_out_cubic = 5,
    ease_in_out_cubic = 6,
    ease_in_quart = 7,
    ease_out_quart = 8,
    ease_in_out_quart = 9,
    ease_in_quint = 10,
    ease_out_quint = 11,
    ease_in_out_quint = 12,
    ease_in_sine = 13,
    ease_out_sine = 14,
    ease_in_out_sine = 15,
    ease_in_expo = 16,
    ease_out_expo = 17,
    ease_in_out_expo = 18,
    ease_in_circ = 19,
    ease_out_circ = 20,
    ease_in_out_circ = 21,
    ease_in_elastic = 22,
    ease_out_elastic = 23,
    ease_in_out_elastic = 24,
    ease_in_back = 25,
    ease_out_back = 26,
    ease_in_out_back = 27,
    ease_in_bounce = 28,
    ease_out_bounce = 29,
    ease_in_out_bounce = 30,
    ease = 31,
    ease_in = 32,
    ease_out = 33,
    ease_in_out = 34,
    _,

    /// Computes easing with `easing` for `value`.
    ///
    /// `value` should generally be in the [0, 1] range.
    extern fn adw_easing_ease(p_self: adw.Easing, p_value: f64) f64;
    pub const compute = adw_easing_ease;

    extern fn adw_easing_get_type() usize;
    pub const getGObjectType = adw_easing_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible folding behavior of a `Flap` widget.
pub const FlapFoldPolicy = enum(c_int) {
    never = 0,
    always = 1,
    auto = 2,
    _,

    extern fn adw_flap_fold_policy_get_type() usize;
    pub const getGObjectType = adw_flap_fold_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes transitions types of a `Flap` widget.
///
/// It determines the type of animation when transitioning between children in a
/// `Flap` widget, as well as which areas can be swiped via
/// `Flap.properties.swipe_to_open` and `Flap.properties.swipe_to_close`.
pub const FlapTransitionType = enum(c_int) {
    over = 0,
    under = 1,
    slide = 2,
    _,

    extern fn adw_flap_transition_type_get_type() usize;
    pub const getGObjectType = adw_flap_transition_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Determines when `Flap` and `Leaflet` will fold.
pub const FoldThresholdPolicy = enum(c_int) {
    minimum = 0,
    natural = 1,
    _,

    extern fn adw_fold_threshold_policy_get_type() usize;
    pub const getGObjectType = adw_fold_threshold_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes what `InlineViewSwitcher` toggles display.
///
/// <picture>
///   <source srcset="inline-view-switcher-display-modes-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="inline-view-switcher-display-modes.png" alt="inline-view-switcher-display-modes">
/// </picture>
pub const InlineViewSwitcherDisplayMode = enum(c_int) {
    labels = 0,
    icons = 1,
    both = 2,
    _,

    extern fn adw_inline_view_switcher_display_mode_get_type() usize;
    pub const getGObjectType = adw_inline_view_switcher_display_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes line justify behaviors in a `WrapLayout` or `WrapBox`.
///
/// See `WrapLayout.properties.justify` and `WrapBox.properties.justify`.
pub const JustifyMode = enum(c_int) {
    none = 0,
    fill = 1,
    spread = 2,
    _,

    extern fn adw_justify_mode_get_type() usize;
    pub const getGObjectType = adw_justify_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible transitions in a `Leaflet` widget.
///
/// New values may be added to this enumeration over time.
pub const LeafletTransitionType = enum(c_int) {
    over = 0,
    under = 1,
    slide = 2,
    _,

    extern fn adw_leaflet_transition_type_get_type() usize;
    pub const getGObjectType = adw_leaflet_transition_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes length units.
///
/// | Unit | Regular Text | Large Text |
/// | ---- | ------------ | ---------- |
/// | 1px  | 1px          | 1px        |
/// | 1pt  | 1.333333px   | 1.666667px |
/// | 1sp  | 1px          | 1.25px     |
///
/// New values may be added to this enumeration over time.
pub const LengthUnit = enum(c_int) {
    px = 0,
    pt = 1,
    sp = 2,
    _,

    /// Converts `value` from pixels to `unit`.
    extern fn adw_length_unit_from_px(p_unit: adw.LengthUnit, p_value: f64, p_settings: ?*gtk.Settings) f64;
    pub const fromPx = adw_length_unit_from_px;

    /// Converts `value` from `unit` to pixels.
    extern fn adw_length_unit_to_px(p_unit: adw.LengthUnit, p_value: f64, p_settings: ?*gtk.Settings) f64;
    pub const toPx = adw_length_unit_to_px;

    extern fn adw_length_unit_get_type() usize;
    pub const getGObjectType = adw_length_unit_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the direction of a swipe navigation gesture.
pub const NavigationDirection = enum(c_int) {
    back = 0,
    forward = 1,
    _,

    extern fn adw_navigation_direction_get_type() usize;
    pub const getGObjectType = adw_navigation_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes child packing behavior in a `WrapLayout` or `WrapBox`.
///
/// See `WrapLayout.properties.pack_direction` and
/// `WrapBox.properties.pack_direction`.
pub const PackDirection = enum(c_int) {
    start_to_end = 0,
    end_to_start = 1,
    _,

    extern fn adw_pack_direction_get_type() usize;
    pub const getGObjectType = adw_pack_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible styles of `AlertDialog` response buttons.
///
/// See `AlertDialog.setResponseAppearance`.
pub const ResponseAppearance = enum(c_int) {
    default = 0,
    suggested = 1,
    destructive = 2,
    _,

    extern fn adw_response_appearance_get_type() usize;
    pub const getGObjectType = adw_response_appearance_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible transitions in a `Squeezer` widget.
pub const SqueezerTransitionType = enum(c_int) {
    none = 0,
    crossfade = 1,
    _,

    extern fn adw_squeezer_transition_type_get_type() usize;
    pub const getGObjectType = adw_squeezer_transition_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `Toast` behavior when another toast is already displayed.
pub const ToastPriority = enum(c_int) {
    normal = 0,
    high = 1,
    _,

    extern fn adw_toast_priority_get_type() usize;
    pub const getGObjectType = adw_toast_priority_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the possible top or bottom bar styles in an `ToolbarView`
/// widget.
///
/// `ADW_TOOLBAR_FLAT` is suitable for simple content, such as
/// `StatusPage` or `PreferencesPage`, where the background at the
/// top and bottom parts of the page is uniform. Additionally, windows with
/// sidebars should always use this style.
///
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-flat-1-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-flat-1.png" alt="toolbar-view-flat-1">
/// </picture>
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-flat-2-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-flat-2.png" alt="toolbar-view-flat-2">
/// </picture>
///
/// `ADW_TOOLBAR_RAISED` style is suitable for content such as
/// [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
/// where some elements are directly adjacent to the top/bottom bars, or
/// `TabView`, where each page can have a different background.
///
/// `ADW_TOOLBAR_RAISED_BORDER` style is similar to `ADW_TOOLBAR_RAISED`, but
/// with the shadow replaced with a more subtle border. It's intended to be used
/// in applications like image viewers, where a shadow over the content might be
/// undesired.
///
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-raised-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-raised.png" alt="toolbar-view-raised">
/// </picture>
/// <picture style="min-width: 33%; display: inline-block;">
///   <source srcset="toolbar-view-raised-border-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toolbar-view-raised-border.png" alt="toolbar-view-raised-border">
/// </picture>
///
/// See `ToolbarView.properties.top_bar_style` and
/// `ToolbarView.properties.bottom_bar_style`.
///
/// New values may be added to this enumeration over time.
pub const ToolbarStyle = enum(c_int) {
    flat = 0,
    raised = 1,
    raised_border = 2,
    _,

    extern fn adw_toolbar_style_get_type() usize;
    pub const getGObjectType = adw_toolbar_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the adaptive modes of `ViewSwitcher`.
pub const ViewSwitcherPolicy = enum(c_int) {
    narrow = 0,
    wide = 1,
    _,

    extern fn adw_view_switcher_policy_get_type() usize;
    pub const getGObjectType = adw_view_switcher_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes line wrapping behavior in a `WrapLayout` or `WrapBox`.
///
/// See `WrapLayout.properties.wrap_policy` and `WrapBox.properties.wrap_policy`.
pub const WrapPolicy = enum(c_int) {
    minimum = 0,
    natural = 1,
    _,

    extern fn adw_wrap_policy_get_type() usize;
    pub const getGObjectType = adw_wrap_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes available shortcuts in an `TabView`.
///
/// Shortcuts can be set with `TabView.properties.shortcuts`, or added/removed
/// individually with `TabView.addShortcuts` and
/// `TabView.removeShortcuts`.
///
/// New values may be added to this enumeration over time.
pub const TabViewShortcuts = packed struct(c_uint) {
    control_tab: bool = false,
    control_shift_tab: bool = false,
    control_page_up: bool = false,
    control_page_down: bool = false,
    control_home: bool = false,
    control_end: bool = false,
    control_shift_page_up: bool = false,
    control_shift_page_down: bool = false,
    control_shift_home: bool = false,
    control_shift_end: bool = false,
    alt_digits: bool = false,
    alt_zero: bool = false,
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

    pub const flags_none: TabViewShortcuts = @bitCast(@as(c_uint, 0));
    pub const flags_control_tab: TabViewShortcuts = @bitCast(@as(c_uint, 1));
    pub const flags_control_shift_tab: TabViewShortcuts = @bitCast(@as(c_uint, 2));
    pub const flags_control_page_up: TabViewShortcuts = @bitCast(@as(c_uint, 4));
    pub const flags_control_page_down: TabViewShortcuts = @bitCast(@as(c_uint, 8));
    pub const flags_control_home: TabViewShortcuts = @bitCast(@as(c_uint, 16));
    pub const flags_control_end: TabViewShortcuts = @bitCast(@as(c_uint, 32));
    pub const flags_control_shift_page_up: TabViewShortcuts = @bitCast(@as(c_uint, 64));
    pub const flags_control_shift_page_down: TabViewShortcuts = @bitCast(@as(c_uint, 128));
    pub const flags_control_shift_home: TabViewShortcuts = @bitCast(@as(c_uint, 256));
    pub const flags_control_shift_end: TabViewShortcuts = @bitCast(@as(c_uint, 512));
    pub const flags_alt_digits: TabViewShortcuts = @bitCast(@as(c_uint, 1024));
    pub const flags_alt_zero: TabViewShortcuts = @bitCast(@as(c_uint, 2048));
    pub const flags_all_shortcuts: TabViewShortcuts = @bitCast(@as(c_uint, 4095));
    extern fn adw_tab_view_shortcuts_get_type() usize;
    pub const getGObjectType = adw_tab_view_shortcuts_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Checks whether animations are enabled for `widget`.
///
/// This should be used when implementing an animated widget to know whether to
/// animate it or not.
extern fn adw_get_enable_animations(p_widget: *gtk.Widget) c_int;
pub const getEnableAnimations = adw_get_enable_animations;

/// Returns the major version number of the Adwaita library.
///
/// For example, in libadwaita version 1.2.3 this is 1.
///
/// This function is in the library, so it represents the libadwaita library your
/// code is running against. Contrast with the `MAJOR_VERSION` constant,
/// which represents the major version of the libadwaita headers you have
/// included when compiling your code.
extern fn adw_get_major_version() c_uint;
pub const getMajorVersion = adw_get_major_version;

/// Returns the micro version number of the Adwaita library.
///
/// For example, in libadwaita version 1.2.3 this is 3.
///
/// This function is in the library, so it represents the libadwaita library your
/// code is running against. Contrast with the `MAJOR_VERSION` constant,
/// which represents the micro version of the libadwaita headers you have
/// included when compiling your code.
extern fn adw_get_micro_version() c_uint;
pub const getMicroVersion = adw_get_micro_version;

/// Returns the minor version number of the Adwaita library.
///
/// For example, in libadwaita version 1.2.3 this is 2.
///
/// This function is in the library, so it represents the libadwaita library your
/// code is running against. Contrast with the `MAJOR_VERSION` constant,
/// which represents the minor version of the libadwaita headers you have
/// included when compiling your code.
extern fn adw_get_minor_version() c_uint;
pub const getMinorVersion = adw_get_minor_version;

/// Initializes Libadwaita.
///
/// This function can be used instead of `gtk.init` as it initializes GTK
/// implicitly.
///
/// There's no need to call this function if you're using `Application`.
///
/// If Libadwaita has already been initialized, the function will simply return.
///
/// This makes sure translations, types, themes, and icons for the Adwaita
/// library are set up properly.
extern fn adw_init() void;
pub const init = adw_init;

/// Use this function to check if libadwaita has been initialized with
/// `init`.
extern fn adw_is_initialized() c_int;
pub const isInitialized = adw_is_initialized;

/// Computes the linear interpolation between `a` and `b` for `t`.
extern fn adw_lerp(p_a: f64, p_b: f64, p_t: f64) f64;
pub const lerp = adw_lerp;

/// Adjusts `rgba` to be suitable as a standalone color.
///
/// It will typically be darker for light background, and lighter for dark
/// background, ensuring contrast.
extern fn adw_rgba_to_standalone(p_rgba: *const gdk.RGBA, p_dark: c_int, p_standalone_rgba: *gdk.RGBA) void;
pub const rgbaToStandalone = adw_rgba_to_standalone;

/// A convenience function for showing an application’s about dialog.
extern fn adw_show_about_dialog(p_parent: *gtk.Widget, p_first_property_name: [*:0]const u8, ...) void;
pub const showAboutDialog = adw_show_about_dialog;

/// A convenience function for showing an application’s about dialog from
/// AppStream metadata.
///
/// See `AboutDialog.newFromAppdata` for details.
extern fn adw_show_about_dialog_from_appdata(p_parent: *gtk.Widget, p_resource_path: [*:0]const u8, p_release_notes_version: ?[*:0]const u8, p_first_property_name: [*:0]const u8, ...) void;
pub const showAboutDialogFromAppdata = adw_show_about_dialog_from_appdata;

/// A convenience function for showing an application’s about window.
extern fn adw_show_about_window(p_parent: ?*gtk.Window, p_first_property_name: [*:0]const u8, ...) void;
pub const showAboutWindow = adw_show_about_window;

/// A convenience function for showing an application’s about window from
/// AppStream metadata.
///
/// See `AboutWindow.newFromAppdata` for details.
extern fn adw_show_about_window_from_appdata(p_parent: ?*gtk.Window, p_resource_path: [*:0]const u8, p_release_notes_version: ?[*:0]const u8, p_first_property_name: [*:0]const u8, ...) void;
pub const showAboutWindowFromAppdata = adw_show_about_window_from_appdata;

/// Prototype for animation targets based on user callbacks.
pub const AnimationTargetFunc = *const fn (p_value: f64, p_user_data: ?*anyopaque) callconv(.c) void;

/// Indicates an `Animation` with an infinite duration.
///
/// This value is mostly used internally.
pub const DURATION_INFINITE = 4294967295;
/// Adwaita major version component (e.g. 1 if the version is 1.2.3).
pub const MAJOR_VERSION = 1;
/// Adwaita micro version component (e.g. 3 if the version is 1.2.3).
pub const MICRO_VERSION = 6;
/// Adwaita minor version component (e.g. 2 if the version is 1.2.3).
pub const MINOR_VERSION = 7;
/// Adwaita version, encoded as a string, useful for printing and
/// concatenation.
pub const VERSION_S = "1.7.6";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
