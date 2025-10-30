pub const ext = @import("ext.zig");
const pangoot = @This();

const std = @import("std");
const compat = @import("compat");
const freetype2 = @import("freetype22");
const pangofc = @import("pangofc1");
const fontconfig = @import("fontconfig2");
const pango = @import("pango1");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const harfbuzz = @import("harfbuzz0");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
/// The `PangoOTTag` typedef is used to represent TrueType and OpenType
/// four letter tags inside Pango. Use `PANGO_OT_TAG_MAKE`
/// or `PANGO_OT_TAG_MAKE_FROM_STRING` macros to create PangoOTTags manually.
pub const Tag = u32;

pub const Info = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Info;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the `PangoOTInfo` structure for the given FreeType font face.
    extern fn pango_ot_info_get(p_face: freetype2.Face) *pangoot.Info;
    pub const get = pango_ot_info_get;

    /// Finds the index of a feature.
    ///
    /// If the feature is not found, sets `feature_index` to PANGO_OT_NO_FEATURE,
    /// which is safe to pass to `pangoot.Ruleset.addFeature` and similar
    /// functions.
    ///
    /// In the future, this may set `feature_index` to an special value that if
    /// used in `pangoot.Ruleset.addFeature` will ask Pango to synthesize
    /// the requested feature based on Unicode properties and data. However, this
    /// function will still return `FALSE` in those cases. So, users may want to
    /// ignore the return value of this function in certain cases.
    extern fn pango_ot_info_find_feature(p_info: *Info, p_table_type: pangoot.TableType, p_feature_tag: pangoot.Tag, p_script_index: c_uint, p_language_index: c_uint, p_feature_index: ?*c_uint) c_int;
    pub const findFeature = pango_ot_info_find_feature;

    /// Finds the index of a language and its required feature index.
    ///
    /// If the language is not found, sets `language_index` to `PANGO_OT_DEFAULT_LANGUAGE`
    /// and the required feature of the default language system is returned in
    /// required_feature_index. For best compatibility with some fonts, also
    /// searches the language system tag 'dflt' before falling back to the default
    /// language system, but that is transparent to the user. The user can simply
    /// ignore the return value of this function to automatically fall back to the
    /// default language system.
    extern fn pango_ot_info_find_language(p_info: *Info, p_table_type: pangoot.TableType, p_script_index: c_uint, p_language_tag: pangoot.Tag, p_language_index: ?*c_uint, p_required_feature_index: ?*c_uint) c_int;
    pub const findLanguage = pango_ot_info_find_language;

    /// Finds the index of a script.
    ///
    /// If not found, tries to find the 'DFLT' and then 'dflt' scripts and
    /// return the index of that in `script_index`. If none of those is found
    /// either, `PANGO_OT_NO_SCRIPT` is placed in `script_index`.
    ///
    /// All other functions taking an input script_index parameter know
    /// how to handle `PANGO_OT_NO_SCRIPT`, so one can ignore the return
    /// value of this function completely and proceed, to enjoy the automatic
    /// fallback to the 'DFLT'/'dflt' script.
    extern fn pango_ot_info_find_script(p_info: *Info, p_table_type: pangoot.TableType, p_script_tag: pangoot.Tag, p_script_index: ?*c_uint) c_int;
    pub const findScript = pango_ot_info_find_script;

    /// Obtains the list of features for the given language of the given script.
    extern fn pango_ot_info_list_features(p_info: *Info, p_table_type: pangoot.TableType, p_tag: pangoot.Tag, p_script_index: c_uint, p_language_index: c_uint) *pangoot.Tag;
    pub const listFeatures = pango_ot_info_list_features;

    /// Obtains the list of available languages for a given script.
    extern fn pango_ot_info_list_languages(p_info: *Info, p_table_type: pangoot.TableType, p_script_index: c_uint, p_language_tag: pangoot.Tag) *pangoot.Tag;
    pub const listLanguages = pango_ot_info_list_languages;

    /// Obtains the list of available scripts.
    extern fn pango_ot_info_list_scripts(p_info: *Info, p_table_type: pangoot.TableType) *pangoot.Tag;
    pub const listScripts = pango_ot_info_list_scripts;

    extern fn pango_ot_info_get_type() usize;
    pub const getGObjectType = pango_ot_info_get_type;

    extern fn g_object_ref(p_self: *pangoot.Info) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoot.Info) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Info, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoOTRuleset` structure holds a set of features selected
/// from the tables in an OpenType font.
///
/// A feature is an operation such as adjusting glyph positioning
/// that should be applied to a text feature such as a certain
/// type of accent.
///
/// A `PangoOTRuleset` is created with `pangoot.Ruleset.new`,
/// features are added to it with `pangoot.Ruleset.addFeature`,
/// then it is applied to a `PangoGlyphString` with
/// `pangoot.Ruleset.position`.
pub const Ruleset = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Ruleset;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a ruleset for the given OpenType info and ruleset
    /// description.
    ///
    /// Rulesets are created on demand using
    /// `pangoot.Ruleset.newFromDescription`.
    /// The returned ruleset should not be modified or destroyed.
    ///
    /// The static feature map members of `desc` should be alive as
    /// long as `info` is.
    extern fn pango_ot_ruleset_get_for_description(p_info: *pangoot.Info, p_desc: *const pangoot.RulesetDescription) *const pangoot.Ruleset;
    pub const getForDescription = pango_ot_ruleset_get_for_description;

    /// Creates a new `PangoOTRuleset` for the given OpenType info.
    extern fn pango_ot_ruleset_new(p_info: *pangoot.Info) *pangoot.Ruleset;
    pub const new = pango_ot_ruleset_new;

    /// Creates a new `PangoOTRuleset` for the given OpenType info, script, and
    /// language.
    ///
    /// This function is part of a convenience scheme that highly simplifies
    /// using a `PangoOTRuleset` to represent features for a specific pair of script
    /// and language.  So one can use this function passing in the script and
    /// language of interest, and later try to add features to the ruleset by just
    /// specifying the feature name or tag, without having to deal with finding
    /// script, language, or feature indices manually.
    ///
    /// In addition to what `pangoot.Ruleset.new` does, this function will:
    ///
    /// * Find the `PangoOTTag` script and language tags associated with
    ///   `script` and `language` using `pangoot.tagFromScript` and
    ///   `pangoot.tagFromLanguage`,
    ///
    /// * For each of table types `PANGO_OT_TABLE_GSUB` and `PANGO_OT_TABLE_GPOS`,
    ///   find the script index of the script tag found and the language
    ///   system index of the language tag found in that script system, using
    ///   `pangoot.Info.findScript` and `pangoot.Info.findLanguage`,
    ///
    /// * For found language-systems, if they have required feature index,
    ///   add that feature to the ruleset using `pangoot.Ruleset.addFeature`,
    ///
    /// * Remember found script and language indices for both table types,
    ///   and use them in future `pangoot.Ruleset.maybeAddFeature` and
    ///   `pangoot.Ruleset.maybeAddFeatures`.
    ///
    /// Because of the way return values of `pangoot.Info.findScript` and
    /// `pangoot.Info.findLanguage` are ignored, this function automatically
    /// finds and uses the 'DFLT' script and the default language-system.
    extern fn pango_ot_ruleset_new_for(p_info: *pangoot.Info, p_script: pango.Script, p_language: *pango.Language) *pangoot.Ruleset;
    pub const newFor = pango_ot_ruleset_new_for;

    /// Creates a new `PangoOTRuleset` for the given OpenType info and
    /// matching the given ruleset description.
    ///
    /// This is a convenience function that calls `pangoot.Ruleset.newFor`
    /// and adds the static GSUB/GPOS features to the resulting ruleset,
    /// followed by adding other features to both GSUB and GPOS.
    ///
    /// The static feature map members of `desc` should be alive as
    /// long as `info` is.
    extern fn pango_ot_ruleset_new_from_description(p_info: *pangoot.Info, p_desc: *const pangoot.RulesetDescription) *pangoot.Ruleset;
    pub const newFromDescription = pango_ot_ruleset_new_from_description;

    /// Adds a feature to the ruleset.
    extern fn pango_ot_ruleset_add_feature(p_ruleset: *Ruleset, p_table_type: pangoot.TableType, p_feature_index: c_uint, p_property_bit: c_ulong) void;
    pub const addFeature = pango_ot_ruleset_add_feature;

    /// Gets the number of GSUB and GPOS features in the ruleset.
    extern fn pango_ot_ruleset_get_feature_count(p_ruleset: *const Ruleset, p_n_gsub_features: ?*c_uint, p_n_gpos_features: ?*c_uint) c_uint;
    pub const getFeatureCount = pango_ot_ruleset_get_feature_count;

    /// This is a convenience function that first tries to find the feature
    /// using `pangoot.Info.findFeature` and the ruleset script and
    /// language passed to `pangoot.Ruleset.newFor` and if the feature
    /// is found, adds it to the ruleset.
    ///
    /// If `ruleset` was not created using `pangoot.Ruleset.newFor`,
    /// this function does nothing.
    extern fn pango_ot_ruleset_maybe_add_feature(p_ruleset: *Ruleset, p_table_type: pangoot.TableType, p_feature_tag: pangoot.Tag, p_property_bit: c_ulong) c_int;
    pub const maybeAddFeature = pango_ot_ruleset_maybe_add_feature;

    /// This is a convenience function that for each feature in the feature map
    /// array `features` converts the feature name to a `PangoOTTag` feature tag
    /// using `PANGO_OT_TAG_MAKE` and calls `pangoot.Ruleset.maybeAddFeature`
    /// on it.
    extern fn pango_ot_ruleset_maybe_add_features(p_ruleset: *Ruleset, p_table_type: pangoot.TableType, p_features: *const pangoot.FeatureMap, p_n_features: c_uint) c_uint;
    pub const maybeAddFeatures = pango_ot_ruleset_maybe_add_features;

    /// Performs the OpenType GPOS positioning on `buffer` using
    /// the features in `ruleset`.
    extern fn pango_ot_ruleset_position(p_ruleset: *const Ruleset, p_buffer: *pangoot.Buffer) void;
    pub const position = pango_ot_ruleset_position;

    /// Performs the OpenType GSUB substitution on `buffer` using
    /// the features in `ruleset`.
    extern fn pango_ot_ruleset_substitute(p_ruleset: *const Ruleset, p_buffer: *pangoot.Buffer) void;
    pub const substitute = pango_ot_ruleset_substitute;

    extern fn pango_ot_ruleset_get_type() usize;
    pub const getGObjectType = pango_ot_ruleset_get_type;

    extern fn g_object_ref(p_self: *pangoot.Ruleset) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoot.Ruleset) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Ruleset, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Buffer = opaque {
    /// Creates a new `PangoOTBuffer` for the given OpenType font.
    extern fn pango_ot_buffer_new(p_font: *pangofc.Font) *pangoot.Buffer;
    pub const new = pango_ot_buffer_new;

    /// Appends a glyph to a `PangoOTBuffer`, with `properties` identifying which
    /// features should be applied on this glyph.
    ///
    /// See `pangoot.Ruleset.addFeature`.
    extern fn pango_ot_buffer_add_glyph(p_buffer: *Buffer, p_glyph: c_uint, p_properties: c_uint, p_cluster: c_uint) void;
    pub const addGlyph = pango_ot_buffer_add_glyph;

    /// Empties a `PangoOTBuffer`, make it ready to add glyphs to.
    extern fn pango_ot_buffer_clear(p_buffer: *Buffer) void;
    pub const clear = pango_ot_buffer_clear;

    /// Destroys a `PangoOTBuffer` and free all associated memory.
    extern fn pango_ot_buffer_destroy(p_buffer: *Buffer) void;
    pub const destroy = pango_ot_buffer_destroy;

    /// Gets the glyph array contained in a `PangoOTBuffer`.
    ///
    /// The glyphs are owned by the buffer and should not be freed,
    /// and are only valid as long as buffer is not modified.
    extern fn pango_ot_buffer_get_glyphs(p_buffer: *const Buffer, p_glyphs: ?*[*]pangoot.Glyph, p_n_glyphs: ?*c_int) void;
    pub const getGlyphs = pango_ot_buffer_get_glyphs;

    /// Exports the glyphs in a `PangoOTBuffer` into a `PangoGlyphString`.
    ///
    /// This is typically used after the OpenType layout processing
    /// is over, to convert the resulting glyphs into a generic Pango
    /// glyph string.
    extern fn pango_ot_buffer_output(p_buffer: *const Buffer, p_glyphs: *pango.GlyphString) void;
    pub const output = pango_ot_buffer_output;

    /// Sets whether glyphs will be rendered right-to-left.
    ///
    /// This setting is needed for proper horizontal positioning
    /// of right-to-left scripts.
    extern fn pango_ot_buffer_set_rtl(p_buffer: *Buffer, p_rtl: c_int) void;
    pub const setRtl = pango_ot_buffer_set_rtl;

    /// Sets whether characters with a mark class should be forced to zero width.
    ///
    /// This setting is needed for proper positioning of Arabic accents,
    /// but will produce incorrect results with standard OpenType Indic
    /// fonts.
    extern fn pango_ot_buffer_set_zero_width_marks(p_buffer: *Buffer, p_zero_width_marks: c_int) void;
    pub const setZeroWidthMarks = pango_ot_buffer_set_zero_width_marks;

    extern fn pango_ot_buffer_get_type() usize;
    pub const getGObjectType = pango_ot_buffer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoOTFeatureMap` typedef is used to represent an OpenType
/// feature with the property bit associated with it.  The feature tag is
/// represented as a char array instead of a `PangoOTTag` for convenience.
pub const FeatureMap = extern struct {
    /// feature tag in represented as four-letter ASCII string.
    f_feature_name: [5]u8,
    /// the property bit to use for this feature.  See
    /// `pangoot.Ruleset.addFeature` for details.
    f_property_bit: c_ulong,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoOTGlyph` structure represents a single glyph together with
/// information used for OpenType layout processing of the glyph.
/// It contains the following fields.
pub const Glyph = extern struct {
    /// the glyph itself.
    f_glyph: u32,
    /// the properties value, identifying which features should be
    /// applied on this glyph.  See `pangoot.Ruleset.addFeature`.
    f_properties: c_uint,
    /// the cluster that this glyph belongs to.
    f_cluster: c_uint,
    /// a component value, set by the OpenType layout engine.
    f_component: c_ushort,
    /// a ligature index value, set by the OpenType layout engine.
    f_ligID: c_ushort,
    /// for Pango internal use
    f_internal: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoOTRuleset` structure holds all the information needed
/// to build a complete `PangoOTRuleset` from an OpenType font.
/// The main use of this struct is to act as the key for a per-font
/// hash of rulesets.  The user populates a ruleset description and
/// gets the ruleset using `pangoot.Ruleset.getForDescription`
/// or create a new one using `pangoot.Ruleset.newFromDescription`.
pub const RulesetDescription = extern struct {
    /// a `PangoScript`
    f_script: pango.Script,
    /// a `PangoLanguage`
    f_language: ?*pango.Language,
    /// static map of GSUB features
    f_static_gsub_features: ?*const pangoot.FeatureMap,
    /// length of `static_gsub_features`, or 0.
    f_n_static_gsub_features: c_uint,
    /// static map of GPOS features
    f_static_gpos_features: ?*const pangoot.FeatureMap,
    /// length of `static_gpos_features`, or 0.
    f_n_static_gpos_features: c_uint,
    /// map of extra features to add to both
    ///   GSUB and GPOS. Unlike the static maps, this pointer need not
    ///   live beyond the life of function calls taking this struct.
    f_other_features: ?*const pangoot.FeatureMap,
    /// length of `other_features`, or 0.
    f_n_other_features: c_uint,

    /// Creates a copy of `desc`, which should be freed with
    /// `pangoot.RulesetDescription.free`.
    ///
    /// Primarily used internally by `pangoot.Ruleset.getForDescription`
    /// to cache rulesets for ruleset descriptions.
    extern fn pango_ot_ruleset_description_copy(p_desc: *const RulesetDescription) *pangoot.RulesetDescription;
    pub const copy = pango_ot_ruleset_description_copy;

    /// Compares two ruleset descriptions for equality.
    ///
    /// Two ruleset descriptions are considered equal if the rulesets
    /// they describe are provably identical. This means that their
    /// script, language, and all feature sets should be equal.
    ///
    /// For static feature sets, the array addresses are compared directly,
    /// while for other features, the list of features is compared one by
    /// one.(Two ruleset descriptions may result in identical rulesets
    /// being created, but still compare `FALSE`.)
    extern fn pango_ot_ruleset_description_equal(p_desc1: *const RulesetDescription, p_desc2: *const pangoot.RulesetDescription) c_int;
    pub const equal = pango_ot_ruleset_description_equal;

    /// Frees a ruleset description allocated by
    /// `pangoot.RulesetDescription.copy`.
    extern fn pango_ot_ruleset_description_free(p_desc: *RulesetDescription) void;
    pub const free = pango_ot_ruleset_description_free;

    /// Computes a hash of a `PangoOTRulesetDescription` structure suitable
    /// to be used, for example, as an argument to `glib.HashTable.new`.
    extern fn pango_ot_ruleset_description_hash(p_desc: *const RulesetDescription) c_uint;
    pub const hash = pango_ot_ruleset_description_hash;

    extern fn pango_ot_ruleset_description_get_type() usize;
    pub const getGObjectType = pango_ot_ruleset_description_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The PangoOTTableType enumeration values are used to
/// identify the various OpenType tables in the
/// pango_ot_info_… functions.
pub const TableType = enum(c_int) {
    gsub = 0,
    gpos = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Finds the OpenType language-system tag best describing `language`.
extern fn pango_ot_tag_from_language(p_language: ?*pango.Language) pangoot.Tag;
pub const tagFromLanguage = pango_ot_tag_from_language;

/// Finds the OpenType script tag corresponding to `script`.
///
/// The `PANGO_SCRIPT_COMMON`, `PANGO_SCRIPT_INHERITED`, and
/// `PANGO_SCRIPT_UNKNOWN` scripts are mapped to the OpenType
/// 'DFLT' script tag that is also defined as
/// `PANGO_OT_TAG_DEFAULT_SCRIPT`.
///
/// Note that multiple `PangoScript` values may map to the same
/// OpenType script tag.  In particular, `PANGO_SCRIPT_HIRAGANA`
/// and `PANGO_SCRIPT_KATAKANA` both map to the OT tag 'kana'.
extern fn pango_ot_tag_from_script(p_script: pango.Script) pangoot.Tag;
pub const tagFromScript = pango_ot_tag_from_script;

/// Finds a `PangoLanguage` corresponding to `language_tag`.
extern fn pango_ot_tag_to_language(p_language_tag: pangoot.Tag) *pango.Language;
pub const tagToLanguage = pango_ot_tag_to_language;

/// Finds the `PangoScript` corresponding to `script_tag`.
///
/// The 'DFLT' script tag is mapped to `PANGO_SCRIPT_COMMON`.
///
/// Note that an OpenType script tag may correspond to multiple
/// `PangoScript` values.  In such cases, the `PangoScript` value
/// with the smallest value is returned.
/// In particular, `PANGO_SCRIPT_HIRAGANA`
/// and `PANGO_SCRIPT_KATAKANA` both map to the OT tag 'kana'.
/// This function will return `PANGO_SCRIPT_HIRAGANA` for
/// 'kana'.
extern fn pango_ot_tag_to_script(p_script_tag: pangoot.Tag) pango.Script;
pub const tagToScript = pango_ot_tag_to_script;

/// This is used as the property bit in `pangoot.Ruleset.addFeature` when a
/// feature should be applied to all glyphs.
pub const ALL_GLYPHS = 65535;
/// This is used as the language index in `pangoot.Info.findFeature` when
/// the default language system of the script is desired.
///
/// It is also returned by `pangoot.Info.findLanguage` if the requested language
/// is not found, or the requested language tag was PANGO_OT_TAG_DEFAULT_LANGUAGE.
/// The end result is that one can always call `pangoot.tagFromLanguage`
/// followed by `pangoot.Info.findLanguage` and pass the result to
/// `pangoot.Info.findFeature` without having to worry about falling back to
/// default language system explicitly.
pub const DEFAULT_LANGUAGE = 65535;
/// This is used as a feature index that represent no feature, that is, should be
/// skipped.  It may be returned as feature index by `pangoot.Info.findFeature`
/// if the feature is not found, and `pangoot.Ruleset.addFeature` function
/// automatically skips this value, so no special handling is required by the user.
pub const NO_FEATURE = 65535;
/// This is used as a script index that represent no script, that is, when the
/// requested script was not found, and a default ('DFLT') script was not found
/// either.  It may be returned as script index by `pangoot.Info.findScript`
/// if the script or a default script are not found, all other functions
/// taking a script index essentially return if the input script index is
/// this value, so no special handling is required by the user.
pub const NO_SCRIPT = 65535;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
