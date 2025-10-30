pub const ext = @import("ext.zig");
const astalapps = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
const gobject = @import("gobject2");
/// Object representing an applications .desktop file.
pub const Application = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalapps.ApplicationClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalapps.ApplicationPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The underlying DesktopAppInfo.
        pub const app = struct {
            pub const name = "app";

            pub const Type = ?*glib.DesktopAppInfo;
        };

        /// The number of times `astalapps.Application.launch` was called on this Application.
        pub const frequency = struct {
            pub const name = "frequency";

            pub const Type = c_int;
        };

        /// The name of this Application.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// Name of the .desktop of this Application.
        pub const entry = struct {
            pub const name = "entry";

            pub const Type = ?[*:0]u8;
        };

        /// Description of this Application.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// `StartupWMClass` field from the desktop file. This represents the `WM_CLASS` property of the main window of the application.
        pub const wm_class = struct {
            pub const name = "wm-class";

            pub const Type = ?[*:0]u8;
        };

        /// `Exec` field from the desktop file. Note that if you want to launch this Application you should use the [method@
        /// AstalApps.Application.launch] method.
        pub const executable = struct {
            pub const name = "executable";

            pub const Type = ?[*:0]u8;
        };

        /// `Icon` field from the desktop file. This is usually a named icon or a path to a file.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// `Keywords` field from the desktop file.
        pub const keywords = struct {
            pub const name = "keywords";

            pub const Type = ?[*][*:0]u8;
        };

        /// `Categories` field from the desktop file.
        pub const categories = struct {
            pub const name = "categories";

            pub const Type = ?[*][*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Get a value from the .desktop file by its key.
    extern fn astal_apps_application_get_key(p_self: *Application, p_key: [*:0]const u8) [*:0]u8;
    pub const getKey = astal_apps_application_get_key;

    /// Launches this application. The launched application inherits the environment of the launching process
    extern fn astal_apps_application_launch(p_self: *Application) c_int;
    pub const launch = astal_apps_application_launch;

    /// Calculate a score for an application using fuzzy matching algorithm.
    extern fn astal_apps_application_fuzzy_match(p_self: *Application, p_term: [*:0]const u8, p_result: *astalapps.Score) void;
    pub const fuzzyMatch = astal_apps_application_fuzzy_match;

    /// Calculate a score using exact string algorithm.
    extern fn astal_apps_application_exact_match(p_self: *Application, p_term: [*:0]const u8, p_result: *astalapps.Score) void;
    pub const exactMatch = astal_apps_application_exact_match;

    extern fn astal_apps_application_get_app(p_self: *Application) *glib.DesktopAppInfo;
    pub const getApp = astal_apps_application_get_app;

    extern fn astal_apps_application_set_app(p_self: *Application, p_value: *glib.DesktopAppInfo) void;
    pub const setApp = astal_apps_application_set_app;

    extern fn astal_apps_application_get_frequency(p_self: *Application) c_int;
    pub const getFrequency = astal_apps_application_get_frequency;

    extern fn astal_apps_application_set_frequency(p_self: *Application, p_value: c_int) void;
    pub const setFrequency = astal_apps_application_set_frequency;

    extern fn astal_apps_application_get_name(p_self: *Application) [*:0]const u8;
    pub const getName = astal_apps_application_get_name;

    extern fn astal_apps_application_get_entry(p_self: *Application) [*:0]const u8;
    pub const getEntry = astal_apps_application_get_entry;

    extern fn astal_apps_application_get_description(p_self: *Application) [*:0]const u8;
    pub const getDescription = astal_apps_application_get_description;

    extern fn astal_apps_application_get_wm_class(p_self: *Application) [*:0]const u8;
    pub const getWmClass = astal_apps_application_get_wm_class;

    extern fn astal_apps_application_get_executable(p_self: *Application) [*:0]u8;
    pub const getExecutable = astal_apps_application_get_executable;

    extern fn astal_apps_application_get_icon_name(p_self: *Application) [*:0]u8;
    pub const getIconName = astal_apps_application_get_icon_name;

    extern fn astal_apps_application_get_keywords(p_self: *Application, p_result_length1: *c_int) [*][*:0]u8;
    pub const getKeywords = astal_apps_application_get_keywords;

    extern fn astal_apps_application_get_categories(p_self: *Application, p_result_length1: *c_int) [*][*:0]u8;
    pub const getCategories = astal_apps_application_get_categories;

    extern fn astal_apps_application_get_type() usize;
    pub const getGObjectType = astal_apps_application_get_type;

    extern fn g_object_ref(p_self: *astalapps.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalapps.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This object can be used to query applications. Multipliers can be set to customize `astalapps.Score` results from queries which
/// then are summed and sorted accordingly.
pub const Apps = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalapps.AppsClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalapps.AppsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Indicates wether hidden applications should included in queries.
        pub const show_hidden = struct {
            pub const name = "show-hidden";

            pub const Type = c_int;
        };

        /// Full list of available applications.
        pub const list = struct {
            pub const name = "list";

            pub const Type = ?**glib.List;
        };

        /// The minimum score the application has to meet in order to be included in queries.
        pub const min_score = struct {
            pub const name = "min-score";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the `name` of an application. Defaults to `2`
        pub const name_multiplier = struct {
            pub const name = "name-multiplier";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the entry of an application. Defaults to `0`
        pub const entry_multiplier = struct {
            pub const name = "entry-multiplier";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the executable of an application. Defaults to `0.5`
        pub const executable_multiplier = struct {
            pub const name = "executable-multiplier";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the description of an application. Defaults to `0`
        pub const description_multiplier = struct {
            pub const name = "description-multiplier";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the keywords of an application. Defaults to `0.5`
        pub const keywords_multiplier = struct {
            pub const name = "keywords-multiplier";

            pub const Type = f64;
        };

        /// Extra multiplier to apply when matching the categories of an application. Defaults to `0`
        pub const categories_multiplier = struct {
            pub const name = "categories-multiplier";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    extern fn astal_apps_apps_new() *astalapps.Apps;
    pub const new = astal_apps_apps_new;

    /// Calculate a score for an application using fuzzy matching algorithm. Taking this Apps' include settings into consideration .
    extern fn astal_apps_apps_fuzzy_score(p_self: *Apps, p_search: [*:0]const u8, p_a: *astalapps.Application) f64;
    pub const fuzzyScore = astal_apps_apps_fuzzy_score;

    /// Calculate a score for an application using exact string algorithm. Taking this Apps' include settings into consideration .
    extern fn astal_apps_apps_exact_score(p_self: *Apps, p_search: [*:0]const u8, p_a: *astalapps.Application) f64;
    pub const exactScore = astal_apps_apps_exact_score;

    /// Query the `list` of applications with a fuzzy matching algorithm.
    extern fn astal_apps_apps_fuzzy_query(p_self: *Apps, p_search: ?[*:0]const u8) *glib.List;
    pub const fuzzyQuery = astal_apps_apps_fuzzy_query;

    /// Query the `list` of applications with a simple string matching algorithm.
    extern fn astal_apps_apps_exact_query(p_self: *Apps, p_search: ?[*:0]const u8) *glib.List;
    pub const exactQuery = astal_apps_apps_exact_query;

    /// Reload the `list` of Applications.
    extern fn astal_apps_apps_reload(p_self: *Apps) void;
    pub const reload = astal_apps_apps_reload;

    extern fn astal_apps_apps_get_show_hidden(p_self: *Apps) c_int;
    pub const getShowHidden = astal_apps_apps_get_show_hidden;

    extern fn astal_apps_apps_set_show_hidden(p_self: *Apps, p_value: c_int) void;
    pub const setShowHidden = astal_apps_apps_set_show_hidden;

    extern fn astal_apps_apps_get_list(p_self: *Apps) *glib.List;
    pub const getList = astal_apps_apps_get_list;

    extern fn astal_apps_apps_get_min_score(p_self: *Apps) f64;
    pub const getMinScore = astal_apps_apps_get_min_score;

    extern fn astal_apps_apps_set_min_score(p_self: *Apps, p_value: f64) void;
    pub const setMinScore = astal_apps_apps_set_min_score;

    extern fn astal_apps_apps_get_name_multiplier(p_self: *Apps) f64;
    pub const getNameMultiplier = astal_apps_apps_get_name_multiplier;

    extern fn astal_apps_apps_set_name_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setNameMultiplier = astal_apps_apps_set_name_multiplier;

    extern fn astal_apps_apps_get_entry_multiplier(p_self: *Apps) f64;
    pub const getEntryMultiplier = astal_apps_apps_get_entry_multiplier;

    extern fn astal_apps_apps_set_entry_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setEntryMultiplier = astal_apps_apps_set_entry_multiplier;

    extern fn astal_apps_apps_get_executable_multiplier(p_self: *Apps) f64;
    pub const getExecutableMultiplier = astal_apps_apps_get_executable_multiplier;

    extern fn astal_apps_apps_set_executable_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setExecutableMultiplier = astal_apps_apps_set_executable_multiplier;

    extern fn astal_apps_apps_get_description_multiplier(p_self: *Apps) f64;
    pub const getDescriptionMultiplier = astal_apps_apps_get_description_multiplier;

    extern fn astal_apps_apps_set_description_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setDescriptionMultiplier = astal_apps_apps_set_description_multiplier;

    extern fn astal_apps_apps_get_keywords_multiplier(p_self: *Apps) f64;
    pub const getKeywordsMultiplier = astal_apps_apps_get_keywords_multiplier;

    extern fn astal_apps_apps_set_keywords_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setKeywordsMultiplier = astal_apps_apps_set_keywords_multiplier;

    extern fn astal_apps_apps_get_categories_multiplier(p_self: *Apps) f64;
    pub const getCategoriesMultiplier = astal_apps_apps_get_categories_multiplier;

    extern fn astal_apps_apps_set_categories_multiplier(p_self: *Apps, p_value: f64) void;
    pub const setCategoriesMultiplier = astal_apps_apps_set_categories_multiplier;

    extern fn astal_apps_apps_get_type() usize;
    pub const getGObjectType = astal_apps_apps_get_type;

    extern fn g_object_ref(p_self: *astalapps.Apps) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalapps.Apps) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Apps, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationClass = extern struct {
    pub const Instance = astalapps.Application;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ApplicationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AppsClass = extern struct {
    pub const Instance = astalapps.Apps;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AppsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AppsPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Score = extern struct {
    f_name: c_int,
    f_entry: c_int,
    f_executable: c_int,
    f_description: c_int,
    f_keywords: c_int,
    f_categories: c_int,

    extern fn astal_apps_score_get_type() usize;
    pub const getGObjectType = astal_apps_score_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
