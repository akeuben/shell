pub const ext = @import("ext.zig");
const icalglib = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
/// This is the ICalArray instance.
pub const Array = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ArrayClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_array_new_full(p_native: *anyopaque, p_owner: *gobject.Object, p_is_global_memory: c_int) *icalglib.Array;
    pub const newFull = i_cal_array_new_full;

    /// Creates a deep copy of `ICalArray` with the same properties as the `array`.
    extern fn i_cal_array_copy(p_array: *Array) *icalglib.Array;
    pub const copy = i_cal_array_copy;

    /// Gets the element located in the `position` in the `array`. NULL if position if out of bound.
    extern fn i_cal_array_element_at(p_array: *Array, p_position: c_int) ?*gobject.Object;
    pub const elementAt = i_cal_array_element_at;

    /// Frees the `ICalArray`.
    extern fn i_cal_array_free(p_array: *Array) void;
    pub const free = i_cal_array_free;

    /// Removes the element at the `position` from the array.
    extern fn i_cal_array_remove_element_at(p_array: *Array, p_position: c_int) void;
    pub const removeElementAt = i_cal_array_remove_element_at;

    /// Gets the size of the array.
    extern fn i_cal_array_size(p_array: *Array) c_int;
    pub const size = i_cal_array_size;

    /// Does not work right now. Sorts the `array` using the sort function `compare`.
    extern fn i_cal_array_sort(p_array: *Array, p_compare: ?*anyopaque) void;
    pub const sort = i_cal_array_sort;

    extern fn i_cal_array_get_type() usize;
    pub const getGObjectType = i_cal_array_get_type;

    extern fn g_object_ref(p_self: *icalglib.Array) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Array) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Array, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalAttach instance.
pub const Attach = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.AttachClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `ICalAttach` from the data in bytes. Takes a reference of `bytes`, increase the reference
    /// before calling this function if you with to use it afterward. The stored bytes should be already encoded
    /// with used encoding (like base64).
    extern fn i_cal_attach_new_from_bytes(p_bytes: *glib.Bytes) *icalglib.Attach;
    pub const newFromBytes = i_cal_attach_new_from_bytes;

    /// Creates a new `ICalAttach` from the data.
    extern fn i_cal_attach_new_from_data(p_data: [*:0]const u8, p_free_fn: ?glib.Func, p_free_fn_data: ?*anyopaque) *icalglib.Attach;
    pub const newFromData = i_cal_attach_new_from_data;

    /// Creates a new `ICalAttach` from the url.
    extern fn i_cal_attach_new_from_url(p_url: [*:0]const u8) *icalglib.Attach;
    pub const newFromUrl = i_cal_attach_new_from_url;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_attach_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Attach;
    pub const newFull = i_cal_attach_new_full;

    /// Gets the data, if the `ICalAttach` is built from the data.
    extern fn i_cal_attach_get_data(p_attach: *Attach) ?[*:0]const u8;
    pub const getData = i_cal_attach_get_data;

    /// Checks whether the `ICalAttach` is built from url.
    extern fn i_cal_attach_get_is_url(p_attach: *Attach) c_int;
    pub const getIsUrl = i_cal_attach_get_is_url;

    /// Gets the url, if the `ICalAttach` is built from the url.
    extern fn i_cal_attach_get_url(p_attach: *Attach) ?[*:0]const u8;
    pub const getUrl = i_cal_attach_get_url;

    /// Increases the reference counter by 1 for the `attach`.
    extern fn i_cal_attach_ref(p_attach: *Attach) void;
    pub const ref = i_cal_attach_ref;

    /// Decreases the reference counter by 1 for the `attach`.
    extern fn i_cal_attach_unref(p_attach: *Attach) void;
    pub const unref = i_cal_attach_unref;

    extern fn i_cal_attach_get_type() usize;
    pub const getGObjectType = i_cal_attach_get_type;

    pub fn as(p_instance: *Attach, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalCompIter instance.
pub const CompIter = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.CompIterClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn i_cal_comp_iter_new_default() ?*anyopaque;
    pub const newDefault = i_cal_comp_iter_new_default;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_comp_iter_new_full(p_native: ?*anyopaque) *icalglib.CompIter;
    pub const newFull = i_cal_comp_iter_new_full;

    /// Gets the current `ICalComponent` pointed by `ICalCompIter`.
    extern fn i_cal_comp_iter_deref(p_i: *CompIter) *icalglib.Component;
    pub const deref = i_cal_comp_iter_deref;

    /// Gets the next `ICalComponent` pointed by `ICalCompIter`.
    extern fn i_cal_comp_iter_next(p_i: *CompIter) *icalglib.Component;
    pub const next = i_cal_comp_iter_next;

    /// Gets the prior `ICalComponent` pointed by `ICalCompIter`.
    extern fn i_cal_comp_iter_prior(p_i: *CompIter) *icalglib.Component;
    pub const prior = i_cal_comp_iter_prior;

    extern fn i_cal_comp_iter_get_type() usize;
    pub const getGObjectType = i_cal_comp_iter_get_type;

    extern fn g_object_ref(p_self: *icalglib.CompIter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.CompIter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CompIter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalComponent instance.
pub const Component = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ComponentClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Converts a string to a `icalglib.ComponentKind`.
    extern fn i_cal_component_kind_from_string(p_string: [*:0]const u8) icalglib.ComponentKind;
    pub const kindFromString = i_cal_component_kind_from_string;

    /// Checks if a `icalglib.ComponentKind` is valid.
    extern fn i_cal_component_kind_is_valid(p_kind: icalglib.ComponentKind) c_int;
    pub const kindIsValid = i_cal_component_kind_is_valid;

    /// Converts a `icalglib.ComponentKind` to a string.
    extern fn i_cal_component_kind_to_string(p_kind: icalglib.ComponentKind) [*:0]const u8;
    pub const kindToString = i_cal_component_kind_to_string;

    /// Creates a new `ICalComponent` with specific type.
    extern fn i_cal_component_new(p_kind: icalglib.ComponentKind) *icalglib.Component;
    pub const new = i_cal_component_new;

    /// Creates a new `ICalComponent` based on a string.
    extern fn i_cal_component_new_from_string(p_str: [*:0]const u8) *icalglib.Component;
    pub const newFromString = i_cal_component_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_component_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Component;
    pub const newFull = i_cal_component_new_full;

    /// Creates a `ICalComponent` with the type to be vagenda.
    extern fn i_cal_component_new_vagenda() *icalglib.Component;
    pub const newVagenda = i_cal_component_new_vagenda;

    /// Creates a `ICalComponent` with the type to be valarm.
    extern fn i_cal_component_new_valarm() *icalglib.Component;
    pub const newValarm = i_cal_component_new_valarm;

    /// Creates a `ICalComponent` with the type to be vavailability.
    extern fn i_cal_component_new_vavailability() *icalglib.Component;
    pub const newVavailability = i_cal_component_new_vavailability;

    /// Creates a `ICalComponent` with the type to be vcalendar.
    extern fn i_cal_component_new_vcalendar() *icalglib.Component;
    pub const newVcalendar = i_cal_component_new_vcalendar;

    /// Creates a `ICalComponent` with the type to be vevent.
    extern fn i_cal_component_new_vevent() *icalglib.Component;
    pub const newVevent = i_cal_component_new_vevent;

    /// Creates a `ICalComponent` with the type to be vfreebusy.
    extern fn i_cal_component_new_vfreebusy() *icalglib.Component;
    pub const newVfreebusy = i_cal_component_new_vfreebusy;

    /// Creates a `ICalComponent` with the type to be vjournal.
    extern fn i_cal_component_new_vjournal() *icalglib.Component;
    pub const newVjournal = i_cal_component_new_vjournal;

    /// Creates a `ICalComponent` with the type to be vpoll.
    extern fn i_cal_component_new_vpoll() *icalglib.Component;
    pub const newVpoll = i_cal_component_new_vpoll;

    /// Creates a `ICalComponent` with the type to be vquery.
    extern fn i_cal_component_new_vquery() *icalglib.Component;
    pub const newVquery = i_cal_component_new_vquery;

    /// Creates a `ICalComponent` with the type to be vtimezone.
    extern fn i_cal_component_new_vtimezone() *icalglib.Component;
    pub const newVtimezone = i_cal_component_new_vtimezone;

    /// Creates a `ICalComponent` with the type to be vtodo.
    extern fn i_cal_component_new_vtodo() *icalglib.Component;
    pub const newVtodo = i_cal_component_new_vtodo;

    /// Creates a `ICalComponent` with the type to be vvoter.
    extern fn i_cal_component_new_vvoter() *icalglib.Component;
    pub const newVvoter = i_cal_component_new_vvoter;

    /// Creates a new `ICalComponent` based on name of x property.
    extern fn i_cal_component_new_x(p_x_name: [*:0]const u8) *icalglib.Component;
    pub const newX = i_cal_component_new_x;

    /// Creates a `ICalComponent` with the type to be xavailable.
    extern fn i_cal_component_new_xavailable() *icalglib.Component;
    pub const newXavailable = i_cal_component_new_xavailable;

    /// Creates a `ICalComponent` with the type to be xdaylight.
    extern fn i_cal_component_new_xdaylight() *icalglib.Component;
    pub const newXdaylight = i_cal_component_new_xdaylight;

    /// Creates a `ICalComponent` with the type to be xstandard.
    extern fn i_cal_component_new_xstandard() *icalglib.Component;
    pub const newXstandard = i_cal_component_new_xstandard;

    /// Creates a `ICalComponent` with the type to be xvote.
    extern fn i_cal_component_new_xvote() *icalglib.Component;
    pub const newXvote = i_cal_component_new_xvote;

    /// Adds a `ICalComponent` into another `ICalComponent` as a child component.
    extern fn i_cal_component_add_component(p_parent: *Component, p_child: *icalglib.Component) void;
    pub const addComponent = i_cal_component_add_component;

    /// Adds an `ICalProperty` into `ICalComponent`.
    extern fn i_cal_component_add_property(p_component: *Component, p_property: *icalglib.Property) void;
    pub const addProperty = i_cal_component_add_property;

    /// Converts a `ICalComponent` to a string.
    extern fn i_cal_component_as_ical_string(p_component: *Component) [*:0]u8;
    pub const asIcalString = i_cal_component_as_ical_string;

    /// Gets the `ICalCompIter` pointing to the first child `ICalComponent`.
    extern fn i_cal_component_begin_component(p_component: *Component, p_kind: icalglib.ComponentKind) *icalglib.CompIter;
    pub const beginComponent = i_cal_component_begin_component;

    /// Checks the number of restrictions in `ICalComponent`.
    extern fn i_cal_component_check_restrictions(p_comp: *Component) c_int;
    pub const checkRestrictions = i_cal_component_check_restrictions;

    /// Deeply clone a `ICalComponent`.
    extern fn i_cal_component_clone(p_component: *Component) *icalglib.Component;
    pub const clone = i_cal_component_clone;

    /// Converts some X-LIC-ERROR properties into RETURN-STATUS properties.
    extern fn i_cal_component_convert_errors(p_comp: *Component) void;
    pub const convertErrors = i_cal_component_convert_errors;

    /// Counts the child `ICalComponent` with the target kind in the parent one.
    extern fn i_cal_component_count_components(p_component: *Component, p_kind: icalglib.ComponentKind) c_int;
    pub const countComponents = i_cal_component_count_components;

    /// Counts the number of errors in `ICalComponent`.
    extern fn i_cal_component_count_errors(p_comp: *Component) c_int;
    pub const countErrors = i_cal_component_count_errors;

    /// Counts the number of `ICalProperty` in `ICalComponent`.
    extern fn i_cal_component_count_properties(p_component: *Component, p_kind: icalglib.PropertyKind) c_int;
    pub const countProperties = i_cal_component_count_properties;

    /// Gets the `ICalCompIter` pointing to the end child `ICalComponent`.
    extern fn i_cal_component_end_component(p_component: *Component, p_kind: icalglib.ComponentKind) *icalglib.CompIter;
    pub const endComponent = i_cal_component_end_component;

    /// Cycles through all recurrences of an event. This function will call the specified callback function for
    /// once for the base value of DTSTART, and foreach recurring date/time value. It will filter out events
    /// that are specified as an EXDATE or an EXRULE.
    extern fn i_cal_component_foreach_recurrence(p_comp: *Component, p_start: *icalglib.Time, p_end: *icalglib.Time, p_callback: icalglib.ComponentForeachRecurrenceFunc, p_user_data: ?*anyopaque) void;
    pub const foreachRecurrence = i_cal_component_foreach_recurrence;

    /// Applies the same manipulation on every tzid in `ICalComponent`.
    extern fn i_cal_component_foreach_tzid(p_comp: *Component, p_callback: icalglib.ComponentForeachTZIDFunc, p_user_data: ?*anyopaque) void;
    pub const foreachTzid = i_cal_component_foreach_tzid;

    /// Frees a `ICalComponent`.
    extern fn i_cal_component_free(p_component: *Component) void;
    pub const free = i_cal_component_free;

    /// Gets the comment of the `ICalComponent`.
    extern fn i_cal_component_get_comment(p_comp: *Component) [*:0]const u8;
    pub const getComment = i_cal_component_get_comment;

    /// Gets the current `ICalComponent` in `ICalComponent`.
    extern fn i_cal_component_get_current_component(p_component: *Component) *icalglib.Component;
    pub const getCurrentComponent = i_cal_component_get_current_component;

    /// Gets the current `ICalProperty` in `ICalComponent`.
    extern fn i_cal_component_get_current_property(p_component: *Component) *icalglib.Property;
    pub const getCurrentProperty = i_cal_component_get_current_property;

    /// Gets the description of the `ICalComponent`.
    extern fn i_cal_component_get_description(p_comp: *Component) [*:0]const u8;
    pub const getDescription = i_cal_component_get_description;

    /// Gets the dtend of the `ICalComponent`.
    extern fn i_cal_component_get_dtend(p_comp: *Component) *icalglib.Time;
    pub const getDtend = i_cal_component_get_dtend;

    /// Gets the dtstamp of the `ICalComponent`.
    extern fn i_cal_component_get_dtstamp(p_comp: *Component) *icalglib.Time;
    pub const getDtstamp = i_cal_component_get_dtstamp;

    /// Gets the dtstart of the `ICalComponent`.
    extern fn i_cal_component_get_dtstart(p_comp: *Component) *icalglib.Time;
    pub const getDtstart = i_cal_component_get_dtstart;

    /// Gets the due of the `ICalComponent`.
    extern fn i_cal_component_get_due(p_comp: *Component) *icalglib.Time;
    pub const getDue = i_cal_component_get_due;

    /// Gets the duration of the `ICalComponent`.
    extern fn i_cal_component_get_duration(p_comp: *Component) *icalglib.Duration;
    pub const getDuration = i_cal_component_get_duration;

    /// Gets the first `ICalComponent` with specific kind in `ICalComponent`.
    extern fn i_cal_component_get_first_component(p_component: *Component, p_kind: icalglib.ComponentKind) ?*icalglib.Component;
    pub const getFirstComponent = i_cal_component_get_first_component;

    /// Gets the first `ICalProperty` with specific kind in `ICalComponent`.
    extern fn i_cal_component_get_first_property(p_component: *Component, p_kind: icalglib.PropertyKind) ?*icalglib.Property;
    pub const getFirstProperty = i_cal_component_get_first_property;

    /// For VCOMPONENT: Returns a reference to the first VEVENT, VTODO or VJOURNAL.
    extern fn i_cal_component_get_first_real_component(p_c: *Component) *icalglib.Component;
    pub const getFirstRealComponent = i_cal_component_get_first_real_component;

    /// Returns the first VEVENT, VTODO or VJOURNAL sub-component of cop, or comp if it is one of those types.
    extern fn i_cal_component_get_inner(p_comp: *Component) ?*icalglib.Component;
    pub const getInner = i_cal_component_get_inner;

    /// Gets the location of the `ICalComponent`.
    extern fn i_cal_component_get_location(p_comp: *Component) [*:0]const u8;
    pub const getLocation = i_cal_component_get_location;

    /// Gets the method of the `ICalComponent`.
    extern fn i_cal_component_get_method(p_comp: *Component) icalglib.PropertyMethod;
    pub const getMethod = i_cal_component_get_method;

    /// Gets the next `ICalComponent` with specific kind in `ICalComponent`.
    extern fn i_cal_component_get_next_component(p_component: *Component, p_kind: icalglib.ComponentKind) ?*icalglib.Component;
    pub const getNextComponent = i_cal_component_get_next_component;

    /// Gets the next `ICalProperty` with specific kind in `ICalComponent`.
    extern fn i_cal_component_get_next_property(p_component: *Component, p_kind: icalglib.PropertyKind) ?*icalglib.Property;
    pub const getNextProperty = i_cal_component_get_next_property;

    /// Gets the parent component of the `component`.
    extern fn i_cal_component_get_parent(p_component: *Component) ?*icalglib.Component;
    pub const getParent = i_cal_component_get_parent;

    /// Gets the recurrenceid of the `ICalComponent`.
    extern fn i_cal_component_get_recurrenceid(p_comp: *Component) *icalglib.Time;
    pub const getRecurrenceid = i_cal_component_get_recurrenceid;

    /// Gets the relcalid of the `ICalComponent`.
    extern fn i_cal_component_get_relcalid(p_comp: *Component) [*:0]const u8;
    pub const getRelcalid = i_cal_component_get_relcalid;

    /// Gets the sequence of the `ICalComponent`.
    extern fn i_cal_component_get_sequence(p_comp: *Component) c_int;
    pub const getSequence = i_cal_component_get_sequence;

    /// For VEVENT, VTODO, VJOURNAL and VTIMEZONE: reports the start and end times of an event in UTC.
    extern fn i_cal_component_get_span(p_comp: *Component) *icalglib.TimeSpan;
    pub const getSpan = i_cal_component_get_span;

    /// Gets the status of the `ICalComponent`.
    extern fn i_cal_component_get_status(p_comp: *Component) icalglib.PropertyStatus;
    pub const getStatus = i_cal_component_get_status;

    /// Gets the summary of the `ICalComponent`.
    extern fn i_cal_component_get_summary(p_comp: *Component) [*:0]const u8;
    pub const getSummary = i_cal_component_get_summary;

    /// Returns the icaltimezone in the component corresponding to the TZID, or NULL if it can't be found.
    extern fn i_cal_component_get_timezone(p_comp: *Component, p_tzid: [*:0]const u8) ?*icalglib.Timezone;
    pub const getTimezone = i_cal_component_get_timezone;

    /// Gets the uid of the `ICalComponent`.
    extern fn i_cal_component_get_uid(p_comp: *Component) [*:0]const u8;
    pub const getUid = i_cal_component_get_uid;

    /// Checks whether `ICalComponent` is valid.
    extern fn i_cal_component_is_valid(p_component: *Component) c_int;
    pub const isValid = i_cal_component_is_valid;

    /// Gets the type of `ICalComponent`.
    extern fn i_cal_component_isa(p_component: *const Component) icalglib.ComponentKind;
    pub const isa = i_cal_component_isa;

    /// Checks whether the native part of `ICalComponent` is icalcomponent.
    extern fn i_cal_component_isa_component(p_component: *Component) c_int;
    pub const isaComponent = i_cal_component_isa_component;

    /// Takes 2 VCALENDAR components and merges the second one into the first, resolving any problems with conflicting
    /// TZIDs. comp_to_merge will no longer exist after calling this function.
    extern fn i_cal_component_merge_component(p_comp: *Component, p_comp_to_merge: *icalglib.Component) void;
    pub const mergeComponent = i_cal_component_merge_component;

    /// Removes a child `ICalComponent` from another `ICalComponent`.
    extern fn i_cal_component_remove_component(p_parent: *Component, p_child: *icalglib.Component) void;
    pub const removeComponent = i_cal_component_remove_component;

    /// Removes `ICalProperty` from `ICalComponent`. Caution: The compare is based on address. So you must use
    /// the original `ICalProperty` as the target.
    extern fn i_cal_component_remove_property(p_component: *Component, p_property: *icalglib.Property) void;
    pub const removeProperty = i_cal_component_remove_property;

    /// Sets the comment of the `ICalComponent`.
    extern fn i_cal_component_set_comment(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setComment = i_cal_component_set_comment;

    /// Sets the description of the `ICalComponent`.
    extern fn i_cal_component_set_description(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setDescription = i_cal_component_set_description;

    /// Sets the dtend of the `ICalComponent`.
    extern fn i_cal_component_set_dtend(p_comp: *Component, p_v: *icalglib.Time) void;
    pub const setDtend = i_cal_component_set_dtend;

    /// Sets the dtstamp of the `ICalComponent`.
    extern fn i_cal_component_set_dtstamp(p_comp: *Component, p_v: *icalglib.Time) void;
    pub const setDtstamp = i_cal_component_set_dtstamp;

    /// Sets the dtstart of the `ICalComponent`.
    extern fn i_cal_component_set_dtstart(p_comp: *Component, p_v: *icalglib.Time) void;
    pub const setDtstart = i_cal_component_set_dtstart;

    /// Sets the due of the `ICalComponent`.
    extern fn i_cal_component_set_due(p_comp: *Component, p_v: *icalglib.Time) void;
    pub const setDue = i_cal_component_set_due;

    /// Sets the duration of the `ICalComponent`.
    extern fn i_cal_component_set_duration(p_comp: *Component, p_v: *icalglib.Duration) void;
    pub const setDuration = i_cal_component_set_duration;

    /// Sets the location of the `ICalComponent`.
    extern fn i_cal_component_set_location(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setLocation = i_cal_component_set_location;

    /// Sets the method of the `ICalComponent`.
    extern fn i_cal_component_set_method(p_comp: *Component, p_method: icalglib.PropertyMethod) void;
    pub const setMethod = i_cal_component_set_method;

    /// Sets the `parent` `ICalComponent` of the specified `component`.
    extern fn i_cal_component_set_parent(p_component: *Component, p_parent: ?*icalglib.Component) void;
    pub const setParent = i_cal_component_set_parent;

    /// Sets the recurrenceid of the `ICalComponent`.
    extern fn i_cal_component_set_recurrenceid(p_comp: *Component, p_v: *icalglib.Time) void;
    pub const setRecurrenceid = i_cal_component_set_recurrenceid;

    /// Sets the relcalid of the `ICalComponent`.
    extern fn i_cal_component_set_relcalid(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setRelcalid = i_cal_component_set_relcalid;

    /// Sets the sequence of the `ICalComponent`.
    extern fn i_cal_component_set_sequence(p_comp: *Component, p_v: c_int) void;
    pub const setSequence = i_cal_component_set_sequence;

    /// Sets the status of the `ICalComponent`.
    extern fn i_cal_component_set_status(p_comp: *Component, p_status: icalglib.PropertyStatus) void;
    pub const setStatus = i_cal_component_set_status;

    /// Sets the summary of the `ICalComponent`.
    extern fn i_cal_component_set_summary(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setSummary = i_cal_component_set_summary;

    /// Sets the uid of the `ICalComponent`.
    extern fn i_cal_component_set_uid(p_comp: *Component, p_v: [*:0]const u8) void;
    pub const setUid = i_cal_component_set_uid;

    /// Removes all X-LIC-ERROR properties.
    extern fn i_cal_component_strip_errors(p_comp: *Component) void;
    pub const stripErrors = i_cal_component_strip_errors;

    /// Adds the `child` into the `parent` as a child component and unrefs the `child`.
    extern fn i_cal_component_take_component(p_parent: *Component, p_child: *icalglib.Component) void;
    pub const takeComponent = i_cal_component_take_component;

    /// Adds the `property` into the `component` and unrefs the `property`.
    extern fn i_cal_component_take_property(p_component: *Component, p_property: *icalglib.Property) void;
    pub const takeProperty = i_cal_component_take_property;

    extern fn i_cal_component_get_type() usize;
    pub const getGObjectType = i_cal_component_get_type;

    extern fn g_object_ref(p_self: *icalglib.Component) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Component) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Component, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalDatetimeperiod instance.
pub const Datetimeperiod = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.DatetimeperiodClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new default `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_new_default() ?*anyopaque;
    pub const newDefault = i_cal_datetimeperiod_new_default;

    /// Creates a new `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_new() *icalglib.Datetimeperiod;
    pub const new = i_cal_datetimeperiod_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_datetimeperiod_new_full(p_native: ?*anyopaque) *icalglib.Datetimeperiod;
    pub const newFull = i_cal_datetimeperiod_new_full;

    /// Gets the period attribute of `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_get_period(p_dtp: *Datetimeperiod) *icalglib.Period;
    pub const getPeriod = i_cal_datetimeperiod_get_period;

    /// Gets the time attribute of `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_get_time(p_dtp: *Datetimeperiod) *icalglib.Time;
    pub const getTime = i_cal_datetimeperiod_get_time;

    /// Sets the period attribute of `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_set_period(p_dtp: *Datetimeperiod, p_period: *icalglib.Period) void;
    pub const setPeriod = i_cal_datetimeperiod_set_period;

    /// Sets the time attribute of `ICalDatetimeperiod`.
    extern fn i_cal_datetimeperiod_set_time(p_dtp: *Datetimeperiod, p_time: *icalglib.Time) void;
    pub const setTime = i_cal_datetimeperiod_set_time;

    extern fn i_cal_datetimeperiod_get_type() usize;
    pub const getGObjectType = i_cal_datetimeperiod_get_type;

    extern fn g_object_ref(p_self: *icalglib.Datetimeperiod) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Datetimeperiod) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Datetimeperiod, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalDuration instance.
pub const Duration = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.DurationClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a bad `ICalDuration`.
    extern fn i_cal_duration_new_bad_duration() *icalglib.Duration;
    pub const newBadDuration = i_cal_duration_new_bad_duration;

    /// Creates a `ICalDuration` from the duration in second.
    extern fn i_cal_duration_new_from_int(p_t: c_int) *icalglib.Duration;
    pub const newFromInt = i_cal_duration_new_from_int;

    /// Creates a `ICalDuration` from the duration in string.
    extern fn i_cal_duration_new_from_string(p_str: [*:0]const u8) *icalglib.Duration;
    pub const newFromString = i_cal_duration_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_duration_new_full(p_native: ?*anyopaque) *icalglib.Duration;
    pub const newFull = i_cal_duration_new_full;

    /// Creates a `ICalDuration` with all the fields to be zero.
    extern fn i_cal_duration_new_null_duration() *icalglib.Duration;
    pub const newNullDuration = i_cal_duration_new_null_duration;

    /// Converts the `ICalDuration` to the representation in string.
    extern fn i_cal_duration_as_ical_string(p_duration: *Duration) [*:0]u8;
    pub const asIcalString = i_cal_duration_as_ical_string;

    /// Converts the `ICalDuration` to the representation in second.
    extern fn i_cal_duration_as_int(p_duration: *Duration) c_int;
    pub const asInt = i_cal_duration_as_int;

    /// Gets the days of `ICalDuration`.
    extern fn i_cal_duration_get_days(p_duration: *Duration) c_uint;
    pub const getDays = i_cal_duration_get_days;

    /// Gets the hours of `ICalDuration`.
    extern fn i_cal_duration_get_hours(p_duration: *Duration) c_uint;
    pub const getHours = i_cal_duration_get_hours;

    /// Gets the minutes of `ICalDuration`.
    extern fn i_cal_duration_get_minutes(p_duration: *Duration) c_uint;
    pub const getMinutes = i_cal_duration_get_minutes;

    /// Gets the seconds of `ICalDuration`.
    extern fn i_cal_duration_get_seconds(p_duration: *Duration) c_uint;
    pub const getSeconds = i_cal_duration_get_seconds;

    /// Gets the weeks of `ICalDuration`.
    extern fn i_cal_duration_get_weeks(p_duration: *Duration) c_uint;
    pub const getWeeks = i_cal_duration_get_weeks;

    /// Checks whether the `ICalDuration` is the bad_duration.
    extern fn i_cal_duration_is_bad_duration(p_duration: *Duration) c_int;
    pub const isBadDuration = i_cal_duration_is_bad_duration;

    /// Gets the is_neg of `ICalDuration`.
    extern fn i_cal_duration_is_neg(p_duration: *Duration) c_int;
    pub const isNeg = i_cal_duration_is_neg;

    /// Checks whether the `ICalDuration` is the null_duration.
    extern fn i_cal_duration_is_null_duration(p_duration: *Duration) c_int;
    pub const isNullDuration = i_cal_duration_is_null_duration;

    /// Sets the days of `ICalDuration`.
    extern fn i_cal_duration_set_days(p_duration: *Duration, p_days: c_uint) void;
    pub const setDays = i_cal_duration_set_days;

    /// Sets the hours of `ICalDuration`.
    extern fn i_cal_duration_set_hours(p_duration: *Duration, p_hours: c_uint) void;
    pub const setHours = i_cal_duration_set_hours;

    /// Sets the is_neg of `ICalDuration`.
    extern fn i_cal_duration_set_is_neg(p_duration: *Duration, p_is_neg: c_int) void;
    pub const setIsNeg = i_cal_duration_set_is_neg;

    /// Sets the minutes of `ICalDuration`.
    extern fn i_cal_duration_set_minutes(p_duration: *Duration, p_minutes: c_uint) void;
    pub const setMinutes = i_cal_duration_set_minutes;

    /// Sets the seconds of `ICalDuration`.
    extern fn i_cal_duration_set_seconds(p_duration: *Duration, p_seconds: c_uint) void;
    pub const setSeconds = i_cal_duration_set_seconds;

    /// Sets the weeks of `ICalDuration`.
    extern fn i_cal_duration_set_weeks(p_duration: *Duration, p_weeks: c_uint) void;
    pub const setWeeks = i_cal_duration_set_weeks;

    extern fn i_cal_duration_get_type() usize;
    pub const getGObjectType = i_cal_duration_get_type;

    extern fn g_object_ref(p_self: *icalglib.Duration) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Duration) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Duration, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalGeo instance.
pub const Geo = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.GeoClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new default `ICalGeo`.
    extern fn i_cal_geo_new_default() ?*anyopaque;
    pub const newDefault = i_cal_geo_new_default;

    /// Creates a new `ICalGeo`.
    extern fn i_cal_geo_new(p_lat: f64, p_lon: f64) *icalglib.Geo;
    pub const new = i_cal_geo_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_geo_new_full(p_native: ?*anyopaque) *icalglib.Geo;
    pub const newFull = i_cal_geo_new_full;

    /// Creates a new `ICalGeo`, copy of `geo`.
    extern fn i_cal_geo_clone(p_geo: *const Geo) *icalglib.Geo;
    pub const clone = i_cal_geo_clone;

    /// Gets the latitude of `ICalGeo`.
    extern fn i_cal_geo_get_lat(p_geo: *Geo) f64;
    pub const getLat = i_cal_geo_get_lat;

    /// Gets the longitude of `ICalGeo`.
    extern fn i_cal_geo_get_lon(p_geo: *Geo) f64;
    pub const getLon = i_cal_geo_get_lon;

    /// Sets the latitude of `ICalGeo`.
    extern fn i_cal_geo_set_lat(p_geo: *Geo, p_lat: f64) void;
    pub const setLat = i_cal_geo_set_lat;

    /// Sets the longitude of `ICalGeo`.
    extern fn i_cal_geo_set_lon(p_geo: *Geo, p_lon: f64) void;
    pub const setLon = i_cal_geo_set_lon;

    extern fn i_cal_geo_get_type() usize;
    pub const getGObjectType = i_cal_geo_get_type;

    extern fn g_object_ref(p_self: *icalglib.Geo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Geo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Geo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is an ICalObject instance struct.
pub const Object = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ObjectClass;
    f_parent: gobject.Object,
    f_priv: ?*icalglib.ObjectPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether free the native libical structure on `icalglib.Object`'s finalize even
        /// if the object has set an owner.
        pub const always_destroy = struct {
            pub const name = "always-destroy";

            pub const Type = c_int;
        };

        /// Whether the native libical structure is from a global shared memory.
        /// If TRUE, then it is not freed on `icalglib.Object`'s finalize.
        pub const is_global_memory = struct {
            pub const name = "is-global-memory";

            pub const Type = c_int;
        };

        /// The native libical structure for this ICalObject.
        pub const native = struct {
            pub const name = "native";

            pub const Type = ?*anyopaque;
        };

        /// GDestroyNotify function to use to destroy the native libical pointer.
        pub const native_destroy_func = struct {
            pub const name = "native-destroy-func";

            pub const Type = ?*anyopaque;
        };

        /// Owner of the native libical structure. If set, then it is
        /// responsible for a free of the native libical structure.
        pub const owner = struct {
            pub const name = "owner";

            pub const Type = ?*gobject.Object;
        };
    };

    pub const signals = struct {};

    /// Creates an `icalglib.Object` descendant of type `type` and initialize private members
    /// of it. The descendants should call this function in their `_new` function, or use
    /// corresponding properties during the construction time. This should not be mixed,
    /// either use properties or this function.
    ///
    /// The `is_global_memory` defines whether the returned object is a singleton,
    /// in which case the object is owned by the libical-glib and should not be freed,
    /// or, when `FALSE`, the returned object is a newly created object and the caller
    /// is responsible to free it with `gobject.Object.unref`.
    extern fn i_cal_object_construct(p_object_type: usize, p_native: ?*anyopaque, p_native_destroy_func: glib.DestroyNotify, p_is_global_memory: c_int, p_owner: ?*gobject.Object) ?*anyopaque;
    pub const construct = i_cal_object_construct;

    /// Frees all global objects. Any references to them are invalidated
    /// by this call, unless they had been `gobject.Object.ref`-ed manually.
    extern fn i_cal_object_free_global_objects() void;
    pub const freeGlobalObjects = i_cal_object_free_global_objects;

    /// Adds a `depender` into the list of objects which should not be destroyed before
    /// this `iobject`. It's usually used for cases where the `iobject` uses native libical
    /// structure from the `depender`. The `depender` is referenced. It's illegal to try
    /// to add one `depender` multiple times.
    extern fn i_cal_object_add_depender(p_iobject: *Object, p_depender: *gobject.Object) void;
    pub const addDepender = i_cal_object_add_depender;

    /// Obtain the `ICalObject`::always-destroy property value.
    extern fn i_cal_object_get_always_destroy(p_iobject: *Object) c_int;
    pub const getAlwaysDestroy = i_cal_object_get_always_destroy;

    /// Obtains whether the native libical structure is a global shared memory,
    /// thus should not be destroyed. This can be set only during construction time.
    extern fn i_cal_object_get_is_global_memory(p_iobject: *Object) c_int;
    pub const getIsGlobalMemory = i_cal_object_get_is_global_memory;

    /// Obtain native libical structure pointer associated with this `iobject`.
    extern fn i_cal_object_get_native(p_iobject: *Object) ?*anyopaque;
    pub const getNative = i_cal_object_get_native;

    /// Obtain a pointer to a function responsible to free the libical native structure.
    extern fn i_cal_object_get_native_destroy_func(p_iobject: *Object) glib.DestroyNotify;
    pub const getNativeDestroyFunc = i_cal_object_get_native_destroy_func;

    /// Obtain current owner of the native libical structure. The returned pointer,
    /// if not NULL, is referenced for thread safety. Unref it with g_object_unref
    /// when done with it.
    extern fn i_cal_object_ref_owner(p_iobject: *Object) ?*gobject.Object;
    pub const refOwner = i_cal_object_ref_owner;

    /// Removes a `depender` from the list of objects which should not be destroyed before
    /// this `iobject`, previously added with `icalglib.Object.addDepender`. It's illegal to try
    /// to remove the `depender` which is not in the internal list.
    extern fn i_cal_object_remove_depender(p_iobject: *Object, p_depender: *gobject.Object) void;
    pub const removeDepender = i_cal_object_remove_depender;

    /// Unref and remove the owner.
    extern fn i_cal_object_remove_owner(p_iobject: *Object) void;
    pub const removeOwner = i_cal_object_remove_owner;

    /// Sets the `ICalObject`::always-destroy property value. When `TRUE`, the native
    /// libical structure is always freed, even when an owner of the `iobject` is set.
    extern fn i_cal_object_set_always_destroy(p_iobject: *Object, p_value: c_int) void;
    pub const setAlwaysDestroy = i_cal_object_set_always_destroy;

    /// Sets a function to be used to destroy the native libical structure.
    extern fn i_cal_object_set_native_destroy_func(p_iobject: *Object, p_native_destroy_func: glib.DestroyNotify) void;
    pub const setNativeDestroyFunc = i_cal_object_set_native_destroy_func;

    /// Sets an owner of the native libical structure, that is an object responsible
    /// for a destroy of the native libical structure.
    extern fn i_cal_object_set_owner(p_iobject: *Object, p_owner: *gobject.Object) void;
    pub const setOwner = i_cal_object_set_owner;

    /// Obtain native libical structure pointer associated with this `iobject` and sets the one
    /// at `iobject` to NULL, thus it's invalid since now on.
    extern fn i_cal_object_steal_native(p_iobject: *Object) ?*anyopaque;
    pub const stealNative = i_cal_object_steal_native;

    extern fn i_cal_object_get_type() usize;
    pub const getGObjectType = i_cal_object_get_type;

    extern fn g_object_ref(p_self: *icalglib.Object) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Object) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Object, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalParameter instance.
pub const Parameter = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ParameterClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Converts a string to the `icalglib.ParameterKind`.
    extern fn i_cal_parameter_kind_from_string(p_string: [*:0]const u8) icalglib.ParameterKind;
    pub const kindFromString = i_cal_parameter_kind_from_string;

    /// Checks whether `icalglib.ParameterKind` is valid.
    extern fn i_cal_parameter_kind_is_valid(p_kind: icalglib.ParameterKind) c_int;
    pub const kindIsValid = i_cal_parameter_kind_is_valid;

    /// Converts the `ICalParameter` to the string representation.
    extern fn i_cal_parameter_kind_to_string(p_kind: icalglib.ParameterKind) [*:0]const u8;
    pub const kindToString = i_cal_parameter_kind_to_string;

    /// Converts the `icalglib.ParameterValue` to `icalglib.ValueKind`.
    extern fn i_cal_parameter_value_to_value_kind(p_value: icalglib.ParameterValue) icalglib.ValueKind;
    pub const valueToValueKind = i_cal_parameter_value_to_value_kind;

    /// Creates a new `ICalParameter` according to the kind type.
    extern fn i_cal_parameter_new(p_v: icalglib.ParameterKind) *icalglib.Parameter;
    pub const new = i_cal_parameter_new;

    /// Creates a new `ICalParameter` according to the action type.
    extern fn i_cal_parameter_new_actionparam(p_v: icalglib.ParameterAction) *icalglib.Parameter;
    pub const newActionparam = i_cal_parameter_new_actionparam;

    extern fn i_cal_parameter_new_altrep(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newAltrep = i_cal_parameter_new_altrep;

    extern fn i_cal_parameter_new_charset(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newCharset = i_cal_parameter_new_charset;

    extern fn i_cal_parameter_new_cn(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newCn = i_cal_parameter_new_cn;

    extern fn i_cal_parameter_new_cutype(p_v: icalglib.ParameterCutype) *icalglib.Parameter;
    pub const newCutype = i_cal_parameter_new_cutype;

    extern fn i_cal_parameter_new_delegatedfrom(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newDelegatedfrom = i_cal_parameter_new_delegatedfrom;

    extern fn i_cal_parameter_new_delegatedto(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newDelegatedto = i_cal_parameter_new_delegatedto;

    extern fn i_cal_parameter_new_dir(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newDir = i_cal_parameter_new_dir;

    extern fn i_cal_parameter_new_display(p_value: icalglib.ParameterDisplay) *icalglib.Parameter;
    pub const newDisplay = i_cal_parameter_new_display;

    extern fn i_cal_parameter_new_email(p_value: [*:0]const u8) *icalglib.Parameter;
    pub const newEmail = i_cal_parameter_new_email;

    /// Creates a new `ICalParameter` according to the enable type.
    extern fn i_cal_parameter_new_enable(p_v: icalglib.ParameterEnable) *icalglib.Parameter;
    pub const newEnable = i_cal_parameter_new_enable;

    /// Creates a new `ICalParameter` according to the encoding type.
    extern fn i_cal_parameter_new_encoding(p_v: icalglib.ParameterEncoding) *icalglib.Parameter;
    pub const newEncoding = i_cal_parameter_new_encoding;

    /// Creates a new `ICalParameter` according to the fbtype type.
    extern fn i_cal_parameter_new_fbtype(p_v: icalglib.ParameterFbtype) *icalglib.Parameter;
    pub const newFbtype = i_cal_parameter_new_fbtype;

    extern fn i_cal_parameter_new_feature(p_value: icalglib.ParameterFeature) *icalglib.Parameter;
    pub const newFeature = i_cal_parameter_new_feature;

    extern fn i_cal_parameter_new_filename(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newFilename = i_cal_parameter_new_filename;

    extern fn i_cal_parameter_new_fmttype(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newFmttype = i_cal_parameter_new_fmttype;

    /// Creates a `ICalParameter` from a string of form "PARAMNAME=VALUE".
    extern fn i_cal_parameter_new_from_string(p_value: [*:0]const u8) *icalglib.Parameter;
    pub const newFromString = i_cal_parameter_new_from_string;

    /// Creates a new `ICalParameter` from just the value, the part after the "="
    extern fn i_cal_parameter_new_from_value_string(p_kind: icalglib.ParameterKind, p_value: [*:0]const u8) *icalglib.Parameter;
    pub const newFromValueString = i_cal_parameter_new_from_value_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_parameter_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Parameter;
    pub const newFull = i_cal_parameter_new_full;

    extern fn i_cal_parameter_new_iana(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newIana = i_cal_parameter_new_iana;

    extern fn i_cal_parameter_new_id(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newId = i_cal_parameter_new_id;

    extern fn i_cal_parameter_new_label(p_value: [*:0]const u8) *icalglib.Parameter;
    pub const newLabel = i_cal_parameter_new_label;

    extern fn i_cal_parameter_new_language(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newLanguage = i_cal_parameter_new_language;

    extern fn i_cal_parameter_new_latency(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newLatency = i_cal_parameter_new_latency;

    /// Creates a new `ICalParameter` according to the local type.
    extern fn i_cal_parameter_new_local(p_v: icalglib.ParameterLocal) *icalglib.Parameter;
    pub const newLocal = i_cal_parameter_new_local;

    extern fn i_cal_parameter_new_localize(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newLocalize = i_cal_parameter_new_localize;

    extern fn i_cal_parameter_new_managedid(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newManagedid = i_cal_parameter_new_managedid;

    extern fn i_cal_parameter_new_member(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newMember = i_cal_parameter_new_member;

    extern fn i_cal_parameter_new_modified(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newModified = i_cal_parameter_new_modified;

    extern fn i_cal_parameter_new_options(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newOptions = i_cal_parameter_new_options;

    /// Creates a new `ICalParameter` according to the partstat type.
    extern fn i_cal_parameter_new_partstat(p_v: icalglib.ParameterPartstat) *icalglib.Parameter;
    pub const newPartstat = i_cal_parameter_new_partstat;

    extern fn i_cal_parameter_new_patchaction(p_value: icalglib.ParameterPatchaction) *icalglib.Parameter;
    pub const newPatchaction = i_cal_parameter_new_patchaction;

    extern fn i_cal_parameter_new_publiccomment(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newPubliccomment = i_cal_parameter_new_publiccomment;

    /// Creates a new `ICalParameter` according to the range type.
    extern fn i_cal_parameter_new_range(p_v: icalglib.ParameterRange) *icalglib.Parameter;
    pub const newRange = i_cal_parameter_new_range;

    extern fn i_cal_parameter_new_reason(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newReason = i_cal_parameter_new_reason;

    /// Creates a new `ICalParameter` according to the related type.
    extern fn i_cal_parameter_new_related(p_v: icalglib.ParameterRelated) *icalglib.Parameter;
    pub const newRelated = i_cal_parameter_new_related;

    /// Creates a new `ICalParameter` according to the reltype type.
    extern fn i_cal_parameter_new_reltype(p_v: icalglib.ParameterReltype) *icalglib.Parameter;
    pub const newReltype = i_cal_parameter_new_reltype;

    /// Creates a new `ICalParameter` according to the required type.
    extern fn i_cal_parameter_new_required(p_v: icalglib.ParameterRequired) *icalglib.Parameter;
    pub const newRequired = i_cal_parameter_new_required;

    /// Creates a new `ICalParameter` according to the response type.
    extern fn i_cal_parameter_new_response(p_v: c_int) *icalglib.Parameter;
    pub const newResponse = i_cal_parameter_new_response;

    /// Creates a new `ICalParameter` according to the role type.
    extern fn i_cal_parameter_new_role(p_v: icalglib.ParameterRole) *icalglib.Parameter;
    pub const newRole = i_cal_parameter_new_role;

    /// Creates a new `ICalParameter` according to the rsvp type.
    extern fn i_cal_parameter_new_rsvp(p_v: icalglib.ParameterRsvp) *icalglib.Parameter;
    pub const newRsvp = i_cal_parameter_new_rsvp;

    /// Creates a new `ICalParameter` according to the scheduleagent type.
    extern fn i_cal_parameter_new_scheduleagent(p_v: icalglib.ParameterScheduleagent) *icalglib.Parameter;
    pub const newScheduleagent = i_cal_parameter_new_scheduleagent;

    /// Creates a new `ICalParameter` according to the scheduleforcesend type.
    extern fn i_cal_parameter_new_scheduleforcesend(p_v: icalglib.ParameterScheduleforcesend) *icalglib.Parameter;
    pub const newScheduleforcesend = i_cal_parameter_new_scheduleforcesend;

    extern fn i_cal_parameter_new_schedulestatus(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newSchedulestatus = i_cal_parameter_new_schedulestatus;

    extern fn i_cal_parameter_new_sentby(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newSentby = i_cal_parameter_new_sentby;

    extern fn i_cal_parameter_new_size(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newSize = i_cal_parameter_new_size;

    /// Creates a new `ICalParameter` according to the stayinformed type.
    extern fn i_cal_parameter_new_stayinformed(p_v: icalglib.ParameterStayinformed) *icalglib.Parameter;
    pub const newStayinformed = i_cal_parameter_new_stayinformed;

    /// Creates a new `ICalParameter` according to the substate type.
    extern fn i_cal_parameter_new_substate(p_v: icalglib.ParameterSubstate) *icalglib.Parameter;
    pub const newSubstate = i_cal_parameter_new_substate;

    extern fn i_cal_parameter_new_tzid(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newTzid = i_cal_parameter_new_tzid;

    /// Creates a new `ICalParameter` according to the value type.
    extern fn i_cal_parameter_new_value(p_v: icalglib.ParameterValue) *icalglib.Parameter;
    pub const newValue = i_cal_parameter_new_value;

    extern fn i_cal_parameter_new_x(p_v: [*:0]const u8) *icalglib.Parameter;
    pub const newX = i_cal_parameter_new_x;

    /// Creates a new `ICalParameter` according to the xliccomparetype type.
    extern fn i_cal_parameter_new_xliccomparetype(p_v: icalglib.ParameterXliccomparetype) *icalglib.Parameter;
    pub const newXliccomparetype = i_cal_parameter_new_xliccomparetype;

    /// Creates a new `ICalParameter` according to the xlicerrortype type.
    extern fn i_cal_parameter_new_xlicerrortype(p_v: icalglib.ParameterXlicerrortype) *icalglib.Parameter;
    pub const newXlicerrortype = i_cal_parameter_new_xlicerrortype;

    /// Converts an `ICalParameter` to the string representation.
    extern fn i_cal_parameter_as_ical_string(p_parameter: *Parameter) [*:0]u8;
    pub const asIcalString = i_cal_parameter_as_ical_string;

    /// Deep clone a `ICalParameter`.
    extern fn i_cal_parameter_clone(p_p: *Parameter) *icalglib.Parameter;
    pub const clone = i_cal_parameter_clone;

    /// Frees the native part of the ICalParameter.
    extern fn i_cal_parameter_free(p_parameter: *Parameter) void;
    pub const free = i_cal_parameter_free;

    extern fn i_cal_parameter_get_actionparam(p_value: *const Parameter) icalglib.ParameterAction;
    pub const getActionparam = i_cal_parameter_get_actionparam;

    extern fn i_cal_parameter_get_altrep(p_value: *const Parameter) ?[*:0]const u8;
    pub const getAltrep = i_cal_parameter_get_altrep;

    extern fn i_cal_parameter_get_charset(p_value: *const Parameter) ?[*:0]const u8;
    pub const getCharset = i_cal_parameter_get_charset;

    extern fn i_cal_parameter_get_cn(p_value: *const Parameter) ?[*:0]const u8;
    pub const getCn = i_cal_parameter_get_cn;

    extern fn i_cal_parameter_get_cutype(p_value: *const Parameter) icalglib.ParameterCutype;
    pub const getCutype = i_cal_parameter_get_cutype;

    extern fn i_cal_parameter_get_delegatedfrom(p_value: *const Parameter) ?[*:0]const u8;
    pub const getDelegatedfrom = i_cal_parameter_get_delegatedfrom;

    extern fn i_cal_parameter_get_delegatedto(p_value: *const Parameter) ?[*:0]const u8;
    pub const getDelegatedto = i_cal_parameter_get_delegatedto;

    extern fn i_cal_parameter_get_dir(p_value: *const Parameter) ?[*:0]const u8;
    pub const getDir = i_cal_parameter_get_dir;

    extern fn i_cal_parameter_get_display(p_param: *const Parameter) icalglib.ParameterDisplay;
    pub const getDisplay = i_cal_parameter_get_display;

    extern fn i_cal_parameter_get_email(p_param: *const Parameter) ?[*:0]const u8;
    pub const getEmail = i_cal_parameter_get_email;

    extern fn i_cal_parameter_get_enable(p_value: *const Parameter) icalglib.ParameterEnable;
    pub const getEnable = i_cal_parameter_get_enable;

    extern fn i_cal_parameter_get_encoding(p_value: *const Parameter) icalglib.ParameterEncoding;
    pub const getEncoding = i_cal_parameter_get_encoding;

    extern fn i_cal_parameter_get_fbtype(p_value: *const Parameter) icalglib.ParameterFbtype;
    pub const getFbtype = i_cal_parameter_get_fbtype;

    extern fn i_cal_parameter_get_feature(p_param: *const Parameter) icalglib.ParameterFeature;
    pub const getFeature = i_cal_parameter_get_feature;

    extern fn i_cal_parameter_get_filename(p_value: *const Parameter) ?[*:0]const u8;
    pub const getFilename = i_cal_parameter_get_filename;

    extern fn i_cal_parameter_get_fmttype(p_value: *const Parameter) ?[*:0]const u8;
    pub const getFmttype = i_cal_parameter_get_fmttype;

    extern fn i_cal_parameter_get_iana(p_value: *const Parameter) ?[*:0]const u8;
    pub const getIana = i_cal_parameter_get_iana;

    /// Gets the iana_name property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_get_iana_name(p_param: *Parameter) ?[*:0]const u8;
    pub const getIanaName = i_cal_parameter_get_iana_name;

    /// Gets the iana_value property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_get_iana_value(p_param: *Parameter) ?[*:0]const u8;
    pub const getIanaValue = i_cal_parameter_get_iana_value;

    extern fn i_cal_parameter_get_id(p_value: *const Parameter) ?[*:0]const u8;
    pub const getId = i_cal_parameter_get_id;

    extern fn i_cal_parameter_get_label(p_param: *const Parameter) ?[*:0]const u8;
    pub const getLabel = i_cal_parameter_get_label;

    extern fn i_cal_parameter_get_language(p_value: *const Parameter) ?[*:0]const u8;
    pub const getLanguage = i_cal_parameter_get_language;

    extern fn i_cal_parameter_get_latency(p_value: *const Parameter) ?[*:0]const u8;
    pub const getLatency = i_cal_parameter_get_latency;

    extern fn i_cal_parameter_get_local(p_value: *const Parameter) icalglib.ParameterLocal;
    pub const getLocal = i_cal_parameter_get_local;

    extern fn i_cal_parameter_get_localize(p_value: *const Parameter) ?[*:0]const u8;
    pub const getLocalize = i_cal_parameter_get_localize;

    extern fn i_cal_parameter_get_managedid(p_value: *const Parameter) ?[*:0]const u8;
    pub const getManagedid = i_cal_parameter_get_managedid;

    extern fn i_cal_parameter_get_member(p_value: *const Parameter) ?[*:0]const u8;
    pub const getMember = i_cal_parameter_get_member;

    extern fn i_cal_parameter_get_modified(p_value: *const Parameter) ?[*:0]const u8;
    pub const getModified = i_cal_parameter_get_modified;

    extern fn i_cal_parameter_get_options(p_value: *const Parameter) ?[*:0]const u8;
    pub const getOptions = i_cal_parameter_get_options;

    /// Gets the parent `ICalProperty` of the specified `ICalParameter`.
    extern fn i_cal_parameter_get_parent(p_param: *Parameter) ?*icalglib.Property;
    pub const getParent = i_cal_parameter_get_parent;

    extern fn i_cal_parameter_get_partstat(p_value: *const Parameter) icalglib.ParameterPartstat;
    pub const getPartstat = i_cal_parameter_get_partstat;

    extern fn i_cal_parameter_get_patchaction(p_param: *const Parameter) icalglib.ParameterPatchaction;
    pub const getPatchaction = i_cal_parameter_get_patchaction;

    extern fn i_cal_parameter_get_publiccomment(p_value: *const Parameter) ?[*:0]const u8;
    pub const getPubliccomment = i_cal_parameter_get_publiccomment;

    extern fn i_cal_parameter_get_range(p_value: *const Parameter) icalglib.ParameterRange;
    pub const getRange = i_cal_parameter_get_range;

    extern fn i_cal_parameter_get_reason(p_value: *const Parameter) ?[*:0]const u8;
    pub const getReason = i_cal_parameter_get_reason;

    extern fn i_cal_parameter_get_related(p_value: *const Parameter) icalglib.ParameterRelated;
    pub const getRelated = i_cal_parameter_get_related;

    extern fn i_cal_parameter_get_reltype(p_value: *const Parameter) icalglib.ParameterReltype;
    pub const getReltype = i_cal_parameter_get_reltype;

    extern fn i_cal_parameter_get_required(p_value: *const Parameter) icalglib.ParameterRequired;
    pub const getRequired = i_cal_parameter_get_required;

    extern fn i_cal_parameter_get_response(p_value: *const Parameter) c_int;
    pub const getResponse = i_cal_parameter_get_response;

    extern fn i_cal_parameter_get_role(p_value: *const Parameter) icalglib.ParameterRole;
    pub const getRole = i_cal_parameter_get_role;

    extern fn i_cal_parameter_get_rsvp(p_value: *const Parameter) icalglib.ParameterRsvp;
    pub const getRsvp = i_cal_parameter_get_rsvp;

    extern fn i_cal_parameter_get_scheduleagent(p_value: *const Parameter) icalglib.ParameterScheduleagent;
    pub const getScheduleagent = i_cal_parameter_get_scheduleagent;

    extern fn i_cal_parameter_get_scheduleforcesend(p_value: *const Parameter) icalglib.ParameterScheduleforcesend;
    pub const getScheduleforcesend = i_cal_parameter_get_scheduleforcesend;

    extern fn i_cal_parameter_get_schedulestatus(p_value: *const Parameter) ?[*:0]const u8;
    pub const getSchedulestatus = i_cal_parameter_get_schedulestatus;

    extern fn i_cal_parameter_get_sentby(p_value: *const Parameter) ?[*:0]const u8;
    pub const getSentby = i_cal_parameter_get_sentby;

    extern fn i_cal_parameter_get_size(p_value: *const Parameter) ?[*:0]const u8;
    pub const getSize = i_cal_parameter_get_size;

    extern fn i_cal_parameter_get_stayinformed(p_value: *const Parameter) icalglib.ParameterStayinformed;
    pub const getStayinformed = i_cal_parameter_get_stayinformed;

    extern fn i_cal_parameter_get_substate(p_value: *const Parameter) icalglib.ParameterSubstate;
    pub const getSubstate = i_cal_parameter_get_substate;

    extern fn i_cal_parameter_get_tzid(p_value: *const Parameter) ?[*:0]const u8;
    pub const getTzid = i_cal_parameter_get_tzid;

    extern fn i_cal_parameter_get_value(p_value: *const Parameter) icalglib.ParameterValue;
    pub const getValue = i_cal_parameter_get_value;

    extern fn i_cal_parameter_get_x(p_value: *const Parameter) ?[*:0]const u8;
    pub const getX = i_cal_parameter_get_x;

    extern fn i_cal_parameter_get_xliccomparetype(p_value: *const Parameter) icalglib.ParameterXliccomparetype;
    pub const getXliccomparetype = i_cal_parameter_get_xliccomparetype;

    extern fn i_cal_parameter_get_xlicerrortype(p_value: *const Parameter) icalglib.ParameterXlicerrortype;
    pub const getXlicerrortype = i_cal_parameter_get_xlicerrortype;

    /// Gets the xname property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_get_xname(p_param: *Parameter) ?[*:0]const u8;
    pub const getXname = i_cal_parameter_get_xname;

    /// Gets the xvalue property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_get_xvalue(p_param: *Parameter) ?[*:0]const u8;
    pub const getXvalue = i_cal_parameter_get_xvalue;

    /// Checks whether native parts of two `ICalParameters` have the same name.
    extern fn i_cal_parameter_has_same_name(p_param1: *Parameter, p_param2: *icalglib.Parameter) c_int;
    pub const hasSameName = i_cal_parameter_has_same_name;

    /// Checks the type of a `ICalParameter`.
    extern fn i_cal_parameter_isa(p_parameter: *Parameter) icalglib.ParameterKind;
    pub const isa = i_cal_parameter_isa;

    /// Checks whether the native part of the `ICalParameter` is of type icalparameter.
    extern fn i_cal_parameter_isa_parameter(p_param: *Parameter) c_int;
    pub const isaParameter = i_cal_parameter_isa_parameter;

    extern fn i_cal_parameter_set_actionparam(p_value: *Parameter, p_v: icalglib.ParameterAction) void;
    pub const setActionparam = i_cal_parameter_set_actionparam;

    extern fn i_cal_parameter_set_altrep(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setAltrep = i_cal_parameter_set_altrep;

    extern fn i_cal_parameter_set_charset(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setCharset = i_cal_parameter_set_charset;

    extern fn i_cal_parameter_set_cn(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setCn = i_cal_parameter_set_cn;

    extern fn i_cal_parameter_set_cutype(p_value: *Parameter, p_v: icalglib.ParameterCutype) void;
    pub const setCutype = i_cal_parameter_set_cutype;

    extern fn i_cal_parameter_set_delegatedfrom(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setDelegatedfrom = i_cal_parameter_set_delegatedfrom;

    extern fn i_cal_parameter_set_delegatedto(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setDelegatedto = i_cal_parameter_set_delegatedto;

    extern fn i_cal_parameter_set_dir(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setDir = i_cal_parameter_set_dir;

    extern fn i_cal_parameter_set_display(p_param: *Parameter, p_value: icalglib.ParameterDisplay) void;
    pub const setDisplay = i_cal_parameter_set_display;

    extern fn i_cal_parameter_set_email(p_param: *Parameter, p_value: [*:0]const u8) void;
    pub const setEmail = i_cal_parameter_set_email;

    extern fn i_cal_parameter_set_enable(p_value: *Parameter, p_v: icalglib.ParameterEnable) void;
    pub const setEnable = i_cal_parameter_set_enable;

    extern fn i_cal_parameter_set_encoding(p_value: *Parameter, p_v: icalglib.ParameterEncoding) void;
    pub const setEncoding = i_cal_parameter_set_encoding;

    extern fn i_cal_parameter_set_fbtype(p_value: *Parameter, p_v: icalglib.ParameterFbtype) void;
    pub const setFbtype = i_cal_parameter_set_fbtype;

    extern fn i_cal_parameter_set_feature(p_param: *Parameter, p_value: icalglib.ParameterFeature) void;
    pub const setFeature = i_cal_parameter_set_feature;

    extern fn i_cal_parameter_set_filename(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setFilename = i_cal_parameter_set_filename;

    extern fn i_cal_parameter_set_fmttype(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setFmttype = i_cal_parameter_set_fmttype;

    extern fn i_cal_parameter_set_iana(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setIana = i_cal_parameter_set_iana;

    /// Sets the iana_name property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_set_iana_name(p_param: *Parameter, p_v: [*:0]const u8) void;
    pub const setIanaName = i_cal_parameter_set_iana_name;

    /// Sets the iana_value property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_set_iana_value(p_param: *Parameter, p_v: [*:0]const u8) void;
    pub const setIanaValue = i_cal_parameter_set_iana_value;

    extern fn i_cal_parameter_set_id(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setId = i_cal_parameter_set_id;

    extern fn i_cal_parameter_set_label(p_param: *Parameter, p_value: [*:0]const u8) void;
    pub const setLabel = i_cal_parameter_set_label;

    extern fn i_cal_parameter_set_language(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setLanguage = i_cal_parameter_set_language;

    extern fn i_cal_parameter_set_latency(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setLatency = i_cal_parameter_set_latency;

    extern fn i_cal_parameter_set_local(p_value: *Parameter, p_v: icalglib.ParameterLocal) void;
    pub const setLocal = i_cal_parameter_set_local;

    extern fn i_cal_parameter_set_localize(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setLocalize = i_cal_parameter_set_localize;

    extern fn i_cal_parameter_set_managedid(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setManagedid = i_cal_parameter_set_managedid;

    extern fn i_cal_parameter_set_member(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setMember = i_cal_parameter_set_member;

    extern fn i_cal_parameter_set_modified(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setModified = i_cal_parameter_set_modified;

    extern fn i_cal_parameter_set_options(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setOptions = i_cal_parameter_set_options;

    /// Sets the parent `ICalProperty` of an `ICalParameter`.
    extern fn i_cal_parameter_set_parent(p_param: *Parameter, p_property: ?*icalglib.Property) void;
    pub const setParent = i_cal_parameter_set_parent;

    extern fn i_cal_parameter_set_partstat(p_value: *Parameter, p_v: icalglib.ParameterPartstat) void;
    pub const setPartstat = i_cal_parameter_set_partstat;

    extern fn i_cal_parameter_set_patchaction(p_param: *Parameter, p_value: icalglib.ParameterPatchaction) void;
    pub const setPatchaction = i_cal_parameter_set_patchaction;

    extern fn i_cal_parameter_set_publiccomment(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setPubliccomment = i_cal_parameter_set_publiccomment;

    extern fn i_cal_parameter_set_range(p_value: *Parameter, p_v: icalglib.ParameterRange) void;
    pub const setRange = i_cal_parameter_set_range;

    extern fn i_cal_parameter_set_reason(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setReason = i_cal_parameter_set_reason;

    extern fn i_cal_parameter_set_related(p_value: *Parameter, p_v: icalglib.ParameterRelated) void;
    pub const setRelated = i_cal_parameter_set_related;

    extern fn i_cal_parameter_set_reltype(p_value: *Parameter, p_v: icalglib.ParameterReltype) void;
    pub const setReltype = i_cal_parameter_set_reltype;

    extern fn i_cal_parameter_set_required(p_value: *Parameter, p_v: icalglib.ParameterRequired) void;
    pub const setRequired = i_cal_parameter_set_required;

    extern fn i_cal_parameter_set_response(p_value: *Parameter, p_v: c_int) void;
    pub const setResponse = i_cal_parameter_set_response;

    extern fn i_cal_parameter_set_role(p_value: *Parameter, p_v: icalglib.ParameterRole) void;
    pub const setRole = i_cal_parameter_set_role;

    extern fn i_cal_parameter_set_rsvp(p_value: *Parameter, p_v: icalglib.ParameterRsvp) void;
    pub const setRsvp = i_cal_parameter_set_rsvp;

    extern fn i_cal_parameter_set_scheduleagent(p_value: *Parameter, p_v: icalglib.ParameterScheduleagent) void;
    pub const setScheduleagent = i_cal_parameter_set_scheduleagent;

    extern fn i_cal_parameter_set_scheduleforcesend(p_value: *Parameter, p_v: icalglib.ParameterScheduleforcesend) void;
    pub const setScheduleforcesend = i_cal_parameter_set_scheduleforcesend;

    extern fn i_cal_parameter_set_schedulestatus(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setSchedulestatus = i_cal_parameter_set_schedulestatus;

    extern fn i_cal_parameter_set_sentby(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setSentby = i_cal_parameter_set_sentby;

    extern fn i_cal_parameter_set_size(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setSize = i_cal_parameter_set_size;

    extern fn i_cal_parameter_set_stayinformed(p_value: *Parameter, p_v: icalglib.ParameterStayinformed) void;
    pub const setStayinformed = i_cal_parameter_set_stayinformed;

    extern fn i_cal_parameter_set_substate(p_value: *Parameter, p_v: icalglib.ParameterSubstate) void;
    pub const setSubstate = i_cal_parameter_set_substate;

    extern fn i_cal_parameter_set_tzid(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setTzid = i_cal_parameter_set_tzid;

    extern fn i_cal_parameter_set_value(p_value: *Parameter, p_v: icalglib.ParameterValue) void;
    pub const setValue = i_cal_parameter_set_value;

    extern fn i_cal_parameter_set_x(p_value: *Parameter, p_v: [*:0]const u8) void;
    pub const setX = i_cal_parameter_set_x;

    extern fn i_cal_parameter_set_xliccomparetype(p_value: *Parameter, p_v: icalglib.ParameterXliccomparetype) void;
    pub const setXliccomparetype = i_cal_parameter_set_xliccomparetype;

    extern fn i_cal_parameter_set_xlicerrortype(p_value: *Parameter, p_v: icalglib.ParameterXlicerrortype) void;
    pub const setXlicerrortype = i_cal_parameter_set_xlicerrortype;

    /// Sets the xname property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_set_xname(p_param: *Parameter, p_v: [*:0]const u8) void;
    pub const setXname = i_cal_parameter_set_xname;

    /// Sets the xvalue property of the native part of the `ICalParameter`.
    extern fn i_cal_parameter_set_xvalue(p_param: *Parameter, p_v: [*:0]const u8) void;
    pub const setXvalue = i_cal_parameter_set_xvalue;

    extern fn i_cal_parameter_get_type() usize;
    pub const getGObjectType = i_cal_parameter_get_type;

    extern fn g_object_ref(p_self: *icalglib.Parameter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Parameter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Parameter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalParser instance.
pub const Parser = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ParserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Parses the string into a `ICalComponent`.
    extern fn i_cal_parser_parse_string(p_str: [*:0]const u8) *icalglib.Component;
    pub const parseString = i_cal_parser_parse_string;

    /// Creates a default `ICalParser`.
    extern fn i_cal_parser_new() *icalglib.Parser;
    pub const new = i_cal_parser_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_parser_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Parser;
    pub const newFull = i_cal_parser_new_full;

    /// Add a line at one time into the `ICalParser` until the parsing is complete and `ICalComponent` will be
    /// returned.
    extern fn i_cal_parser_add_line(p_parser: *Parser, p_str: ?[*:0]u8) ?*icalglib.Component;
    pub const addLine = i_cal_parser_add_line;

    /// We won't get a clean exit if some components did not have an "END" tag. Clear off any component that
    /// may be left in the list.
    extern fn i_cal_parser_clean(p_parser: *Parser) ?*icalglib.Component;
    pub const clean = i_cal_parser_clean;

    /// Frees a `ICalParser`.
    extern fn i_cal_parser_free(p_parser: *Parser) void;
    pub const free = i_cal_parser_free;

    /// Given a line generator function, returns a single iCal content line.
    extern fn i_cal_parser_get_line(p_parser: *Parser, p_func: icalglib.ParserLineGenFunc, p_user_data: ?*anyopaque) [*:0]u8;
    pub const getLine = i_cal_parser_get_line;

    /// Gets the state of the target parser.
    extern fn i_cal_parser_get_state(p_parser: *Parser) icalglib.ParserState;
    pub const getState = i_cal_parser_get_state;

    /// icalparser_parse takes a string that holds the text ( in RFC 2445 format ) and returns a pointer to an
    /// `ICalComponent`. The caller owns the memory. `func` is a pointer to a function that returns one content
    /// line per invocation.
    extern fn i_cal_parser_parse(p_parser: *Parser, p_func: icalglib.ParserLineGenFunc, p_user_data: ?*anyopaque) *icalglib.Component;
    pub const parse = i_cal_parser_parse;

    extern fn i_cal_parser_get_type() usize;
    pub const getGObjectType = i_cal_parser_get_type;

    extern fn g_object_ref(p_self: *icalglib.Parser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Parser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Parser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalPeriod instance.
pub const Period = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.PeriodClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `ICalPeriod` from a string.
    extern fn i_cal_period_new_from_string(p_str: [*:0]const u8) *icalglib.Period;
    pub const newFromString = i_cal_period_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_period_new_full(p_native: ?*anyopaque) *icalglib.Period;
    pub const newFull = i_cal_period_new_full;

    /// Creates a default `ICalPeriod`.
    extern fn i_cal_period_new_null_period() *icalglib.Period;
    pub const newNullPeriod = i_cal_period_new_null_period;

    /// Translates `ICalPeriod` to string.
    extern fn i_cal_period_as_ical_string(p_p: *Period) [*:0]u8;
    pub const asIcalString = i_cal_period_as_ical_string;

    /// Gets the duration from an `ICalPeriod`.
    extern fn i_cal_period_get_duration(p_period: *Period) *icalglib.Duration;
    pub const getDuration = i_cal_period_get_duration;

    /// Gets the end time from an `ICalPeriod`.
    extern fn i_cal_period_get_end(p_period: *Period) *icalglib.Time;
    pub const getEnd = i_cal_period_get_end;

    /// Gets the start time from an `ICalPeriod`.
    extern fn i_cal_period_get_start(p_period: *Period) *icalglib.Time;
    pub const getStart = i_cal_period_get_start;

    /// Checks the `ICalPeriod` is null_period.
    extern fn i_cal_period_is_null_period(p_p: *Period) c_int;
    pub const isNullPeriod = i_cal_period_is_null_period;

    /// Checks the `ICalPeriod` is valid_period.
    extern fn i_cal_period_is_valid_period(p_p: *Period) c_int;
    pub const isValidPeriod = i_cal_period_is_valid_period;

    /// Sets the duration of an `ICalPeriod`.
    extern fn i_cal_period_set_duration(p_period: *Period, p_duration: *icalglib.Duration) void;
    pub const setDuration = i_cal_period_set_duration;

    /// Sets the end time of an `ICalPeriod`.
    extern fn i_cal_period_set_end(p_period: *Period, p_end: *icalglib.Time) void;
    pub const setEnd = i_cal_period_set_end;

    /// Sets the start time of an `ICalPeriod`.
    extern fn i_cal_period_set_start(p_period: *Period, p_start: *icalglib.Time) void;
    pub const setStart = i_cal_period_set_start;

    extern fn i_cal_period_get_type() usize;
    pub const getGObjectType = i_cal_period_get_type;

    extern fn g_object_ref(p_self: *icalglib.Period) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Period) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Period, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalProperty instance.
pub const Property = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.PropertyClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Converts the enum to string.
    extern fn i_cal_property_enum_to_string(p_e: c_int) [*:0]u8;
    pub const enumToString = i_cal_property_enum_to_string;

    /// Converts a integer and string into an enum.
    extern fn i_cal_property_kind_and_string_to_enum(p_kind: c_int, p_str: [*:0]const u8) c_int;
    pub const kindAndStringToEnum = i_cal_property_kind_and_string_to_enum;

    /// Converts the string to `icalglib.PropertyKind`.
    extern fn i_cal_property_kind_from_string(p_string: [*:0]const u8) icalglib.PropertyKind;
    pub const kindFromString = i_cal_property_kind_from_string;

    /// Checks whether the enum belongs to the `icalglib.PropertyKind`.
    extern fn i_cal_property_kind_has_property(p_kind: icalglib.PropertyKind, p_e: c_int) c_int;
    pub const kindHasProperty = i_cal_property_kind_has_property;

    /// Checks whether `icalglib.PropertyKind` is valid.
    extern fn i_cal_property_kind_is_valid(p_kind: icalglib.PropertyKind) c_int;
    pub const kindIsValid = i_cal_property_kind_is_valid;

    /// Converts the `icalglib.PropertyKind` to a string.
    extern fn i_cal_property_kind_to_string(p_kind: icalglib.PropertyKind) [*:0]const u8;
    pub const kindToString = i_cal_property_kind_to_string;

    /// Converts the `icalglib.PropertyKind` to `icalglib.ValueKind`.
    extern fn i_cal_property_kind_to_value_kind(p_kind: icalglib.PropertyKind) icalglib.ValueKind;
    pub const kindToValueKind = i_cal_property_kind_to_value_kind;

    /// Converts the string to `icalglib.PropertyKind`.
    extern fn i_cal_property_method_from_string(p_str: [*:0]const u8) icalglib.PropertyMethod;
    pub const methodFromString = i_cal_property_method_from_string;

    /// Converts the `icalglib.PropertyMethod` to string.
    extern fn i_cal_property_method_to_string(p_method: icalglib.PropertyMethod) [*:0]const u8;
    pub const methodToString = i_cal_property_method_to_string;

    /// Decides if this recurrence is acceptable. This function decides if a specific recurrence value is excluded
    /// by EXRULE or EXDATE properties.
    extern fn i_cal_property_recurrence_is_excluded(p_comp: *icalglib.Component, p_dtstart: *icalglib.Time, p_recurtime: *icalglib.Time) c_int;
    pub const recurrenceIsExcluded = i_cal_property_recurrence_is_excluded;

    /// Converts the string to `icalglib.PropertyKind`.
    extern fn i_cal_property_status_from_string(p_str: [*:0]const u8) icalglib.PropertyStatus;
    pub const statusFromString = i_cal_property_status_from_string;

    /// Converts the `icalglib.PropertyStatus` to string.
    extern fn i_cal_property_status_to_string(p_method: icalglib.PropertyStatus) [*:0]const u8;
    pub const statusToString = i_cal_property_status_to_string;

    /// Creates a `ICalProperty` of the target type.
    extern fn i_cal_property_new(p_kind: icalglib.PropertyKind) *icalglib.Property;
    pub const new = i_cal_property_new;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_acceptresponse(p_v: [*:0]const u8) *icalglib.Property;
    pub const newAcceptresponse = i_cal_property_new_acceptresponse;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_acknowledged(p_v: *icalglib.Time) *icalglib.Property;
    pub const newAcknowledged = i_cal_property_new_acknowledged;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_action(p_v: icalglib.PropertyAction) *icalglib.Property;
    pub const newAction = i_cal_property_new_action;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_allowconflict(p_v: [*:0]const u8) *icalglib.Property;
    pub const newAllowconflict = i_cal_property_new_allowconflict;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_attach(p_v: *icalglib.Attach) *icalglib.Property;
    pub const newAttach = i_cal_property_new_attach;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_attendee(p_v: [*:0]const u8) *icalglib.Property;
    pub const newAttendee = i_cal_property_new_attendee;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_busytype(p_v: icalglib.PropertyBusytype) *icalglib.Property;
    pub const newBusytype = i_cal_property_new_busytype;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_calid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCalid = i_cal_property_new_calid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_calmaster(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCalmaster = i_cal_property_new_calmaster;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_calscale(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCalscale = i_cal_property_new_calscale;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_capversion(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCapversion = i_cal_property_new_capversion;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_carid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCarid = i_cal_property_new_carid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_carlevel(p_v: icalglib.PropertyCarlevel) *icalglib.Property;
    pub const newCarlevel = i_cal_property_new_carlevel;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_categories(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCategories = i_cal_property_new_categories;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_class(p_v: icalglib.Property_Class) *icalglib.Property;
    pub const newClass = i_cal_property_new_class;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_cmd(p_v: icalglib.PropertyCmd) *icalglib.Property;
    pub const newCmd = i_cal_property_new_cmd;

    /// Creates a new color `ICalProperty`.
    extern fn i_cal_property_new_color(p_v: [*:0]const u8) *icalglib.Property;
    pub const newColor = i_cal_property_new_color;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_comment(p_v: [*:0]const u8) *icalglib.Property;
    pub const newComment = i_cal_property_new_comment;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_completed(p_v: *icalglib.Time) *icalglib.Property;
    pub const newCompleted = i_cal_property_new_completed;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_components(p_v: [*:0]const u8) *icalglib.Property;
    pub const newComponents = i_cal_property_new_components;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_contact(p_v: [*:0]const u8) *icalglib.Property;
    pub const newContact = i_cal_property_new_contact;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_created(p_v: *icalglib.Time) *icalglib.Property;
    pub const newCreated = i_cal_property_new_created;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_csid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newCsid = i_cal_property_new_csid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_datemax(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDatemax = i_cal_property_new_datemax;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_datemin(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDatemin = i_cal_property_new_datemin;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_decreed(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDecreed = i_cal_property_new_decreed;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_defaultcharset(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDefaultcharset = i_cal_property_new_defaultcharset;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_defaultlocale(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDefaultlocale = i_cal_property_new_defaultlocale;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_defaulttzid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDefaulttzid = i_cal_property_new_defaulttzid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_defaultvcars(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDefaultvcars = i_cal_property_new_defaultvcars;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_deny(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDeny = i_cal_property_new_deny;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_description(p_v: [*:0]const u8) *icalglib.Property;
    pub const newDescription = i_cal_property_new_description;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_dtend(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDtend = i_cal_property_new_dtend;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_dtstamp(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDtstamp = i_cal_property_new_dtstamp;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_dtstart(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDtstart = i_cal_property_new_dtstart;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_due(p_v: *icalglib.Time) *icalglib.Property;
    pub const newDue = i_cal_property_new_due;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_duration(p_v: *icalglib.Duration) *icalglib.Property;
    pub const newDuration = i_cal_property_new_duration;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_estimatedduration(p_v: *icalglib.Duration) *icalglib.Property;
    pub const newEstimatedduration = i_cal_property_new_estimatedduration;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_exdate(p_v: *icalglib.Time) *icalglib.Property;
    pub const newExdate = i_cal_property_new_exdate;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_expand(p_v: c_int) *icalglib.Property;
    pub const newExpand = i_cal_property_new_expand;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_exrule(p_v: *icalglib.Recurrence) *icalglib.Property;
    pub const newExrule = i_cal_property_new_exrule;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_freebusy(p_v: *icalglib.Period) *icalglib.Property;
    pub const newFreebusy = i_cal_property_new_freebusy;

    /// Creates a `ICalProperty` from a string.
    extern fn i_cal_property_new_from_string(p_str: [*:0]const u8) *icalglib.Property;
    pub const newFromString = i_cal_property_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_property_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Property;
    pub const newFull = i_cal_property_new_full;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_geo(p_v: *icalglib.Geo) *icalglib.Property;
    pub const newGeo = i_cal_property_new_geo;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_grant(p_v: [*:0]const u8) *icalglib.Property;
    pub const newGrant = i_cal_property_new_grant;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_itipversion(p_v: [*:0]const u8) *icalglib.Property;
    pub const newItipversion = i_cal_property_new_itipversion;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_lastmodified(p_v: *icalglib.Time) *icalglib.Property;
    pub const newLastmodified = i_cal_property_new_lastmodified;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_location(p_v: [*:0]const u8) *icalglib.Property;
    pub const newLocation = i_cal_property_new_location;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_maxcomponentsize(p_v: c_int) *icalglib.Property;
    pub const newMaxcomponentsize = i_cal_property_new_maxcomponentsize;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_maxdate(p_v: *icalglib.Time) *icalglib.Property;
    pub const newMaxdate = i_cal_property_new_maxdate;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_maxresults(p_v: c_int) *icalglib.Property;
    pub const newMaxresults = i_cal_property_new_maxresults;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_maxresultssize(p_v: c_int) *icalglib.Property;
    pub const newMaxresultssize = i_cal_property_new_maxresultssize;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_method(p_v: icalglib.PropertyMethod) *icalglib.Property;
    pub const newMethod = i_cal_property_new_method;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_mindate(p_v: *icalglib.Time) *icalglib.Property;
    pub const newMindate = i_cal_property_new_mindate;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_multipart(p_v: [*:0]const u8) *icalglib.Property;
    pub const newMultipart = i_cal_property_new_multipart;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_name(p_v: [*:0]const u8) *icalglib.Property;
    pub const newName = i_cal_property_new_name;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_organizer(p_v: [*:0]const u8) *icalglib.Property;
    pub const newOrganizer = i_cal_property_new_organizer;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_owner(p_v: [*:0]const u8) *icalglib.Property;
    pub const newOwner = i_cal_property_new_owner;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_percentcomplete(p_v: c_int) *icalglib.Property;
    pub const newPercentcomplete = i_cal_property_new_percentcomplete;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_permission(p_v: [*:0]const u8) *icalglib.Property;
    pub const newPermission = i_cal_property_new_permission;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_pollcompletion(p_v: icalglib.PropertyPollcompletion) *icalglib.Property;
    pub const newPollcompletion = i_cal_property_new_pollcompletion;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_pollitemid(p_v: c_int) *icalglib.Property;
    pub const newPollitemid = i_cal_property_new_pollitemid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_pollmode(p_v: icalglib.PropertyPollmode) *icalglib.Property;
    pub const newPollmode = i_cal_property_new_pollmode;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_pollproperties(p_v: [*:0]const u8) *icalglib.Property;
    pub const newPollproperties = i_cal_property_new_pollproperties;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_pollwinner(p_v: c_int) *icalglib.Property;
    pub const newPollwinner = i_cal_property_new_pollwinner;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_priority(p_v: c_int) *icalglib.Property;
    pub const newPriority = i_cal_property_new_priority;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_prodid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newProdid = i_cal_property_new_prodid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_query(p_v: [*:0]const u8) *icalglib.Property;
    pub const newQuery = i_cal_property_new_query;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_queryid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newQueryid = i_cal_property_new_queryid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_querylevel(p_v: icalglib.PropertyQuerylevel) *icalglib.Property;
    pub const newQuerylevel = i_cal_property_new_querylevel;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_queryname(p_v: [*:0]const u8) *icalglib.Property;
    pub const newQueryname = i_cal_property_new_queryname;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_rdate(p_v: *icalglib.Datetimeperiod) *icalglib.Property;
    pub const newRdate = i_cal_property_new_rdate;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_recuraccepted(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRecuraccepted = i_cal_property_new_recuraccepted;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_recurexpand(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRecurexpand = i_cal_property_new_recurexpand;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_recurlimit(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRecurlimit = i_cal_property_new_recurlimit;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_recurrenceid(p_v: *icalglib.Time) *icalglib.Property;
    pub const newRecurrenceid = i_cal_property_new_recurrenceid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_relatedto(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRelatedto = i_cal_property_new_relatedto;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_relcalid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRelcalid = i_cal_property_new_relcalid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_repeat(p_v: c_int) *icalglib.Property;
    pub const newRepeat = i_cal_property_new_repeat;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_replyurl(p_v: [*:0]const u8) *icalglib.Property;
    pub const newReplyurl = i_cal_property_new_replyurl;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_requeststatus(p_v: *icalglib.Reqstat) *icalglib.Property;
    pub const newRequeststatus = i_cal_property_new_requeststatus;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_resources(p_v: [*:0]const u8) *icalglib.Property;
    pub const newResources = i_cal_property_new_resources;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_response(p_v: c_int) *icalglib.Property;
    pub const newResponse = i_cal_property_new_response;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_restriction(p_v: [*:0]const u8) *icalglib.Property;
    pub const newRestriction = i_cal_property_new_restriction;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_rrule(p_v: *icalglib.Recurrence) *icalglib.Property;
    pub const newRrule = i_cal_property_new_rrule;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_scope(p_v: [*:0]const u8) *icalglib.Property;
    pub const newScope = i_cal_property_new_scope;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_sequence(p_v: c_int) *icalglib.Property;
    pub const newSequence = i_cal_property_new_sequence;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_status(p_v: icalglib.PropertyStatus) *icalglib.Property;
    pub const newStatus = i_cal_property_new_status;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_storesexpanded(p_v: [*:0]const u8) *icalglib.Property;
    pub const newStoresexpanded = i_cal_property_new_storesexpanded;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_summary(p_v: [*:0]const u8) *icalglib.Property;
    pub const newSummary = i_cal_property_new_summary;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_target(p_v: [*:0]const u8) *icalglib.Property;
    pub const newTarget = i_cal_property_new_target;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_taskmode(p_v: icalglib.PropertyTaskmode) *icalglib.Property;
    pub const newTaskmode = i_cal_property_new_taskmode;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_transp(p_v: icalglib.PropertyTransp) *icalglib.Property;
    pub const newTransp = i_cal_property_new_transp;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_trigger(p_v: *icalglib.Trigger) *icalglib.Property;
    pub const newTrigger = i_cal_property_new_trigger;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newTzid = i_cal_property_new_tzid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzidaliasof(p_v: [*:0]const u8) *icalglib.Property;
    pub const newTzidaliasof = i_cal_property_new_tzidaliasof;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzname(p_v: [*:0]const u8) *icalglib.Property;
    pub const newTzname = i_cal_property_new_tzname;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzoffsetfrom(p_v: c_int) *icalglib.Property;
    pub const newTzoffsetfrom = i_cal_property_new_tzoffsetfrom;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzoffsetto(p_v: c_int) *icalglib.Property;
    pub const newTzoffsetto = i_cal_property_new_tzoffsetto;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzuntil(p_v: *icalglib.Time) *icalglib.Property;
    pub const newTzuntil = i_cal_property_new_tzuntil;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_tzurl(p_v: [*:0]const u8) *icalglib.Property;
    pub const newTzurl = i_cal_property_new_tzurl;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_uid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newUid = i_cal_property_new_uid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_url(p_v: [*:0]const u8) *icalglib.Property;
    pub const newUrl = i_cal_property_new_url;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_version(p_v: [*:0]const u8) *icalglib.Property;
    pub const newVersion = i_cal_property_new_version;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_voter(p_v: [*:0]const u8) *icalglib.Property;
    pub const newVoter = i_cal_property_new_voter;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_x(p_v: [*:0]const u8) *icalglib.Property;
    pub const newX = i_cal_property_new_x;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicclass(p_v: icalglib.PropertyXlicclass) *icalglib.Property;
    pub const newXlicclass = i_cal_property_new_xlicclass;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicclustercount(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicclustercount = i_cal_property_new_xlicclustercount;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicerror(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicerror = i_cal_property_new_xlicerror;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimecharset(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimecharset = i_cal_property_new_xlicmimecharset;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimecid(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimecid = i_cal_property_new_xlicmimecid;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimecontenttype(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimecontenttype = i_cal_property_new_xlicmimecontenttype;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimeencoding(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimeencoding = i_cal_property_new_xlicmimeencoding;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimefilename(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimefilename = i_cal_property_new_xlicmimefilename;

    /// Creates a new `ICalProperty`.
    extern fn i_cal_property_new_xlicmimeoptinfo(p_v: [*:0]const u8) *icalglib.Property;
    pub const newXlicmimeoptinfo = i_cal_property_new_xlicmimeoptinfo;

    /// Adds a `ICalParameter` into the `ICalProperty`. It behaves like set the copy of the `ICalParameter`. Upon
    /// completion the native part of `ICalParameter` will be set to NULL.
    extern fn i_cal_property_add_parameter(p_prop: *Property, p_parameter: *icalglib.Parameter) void;
    pub const addParameter = i_cal_property_add_parameter;

    /// Converts a `ICalProperty` to a string representation.
    extern fn i_cal_property_as_ical_string(p_prop: *Property) [*:0]u8;
    pub const asIcalString = i_cal_property_as_ical_string;

    /// Deeply clone a `ICalProperty`.
    extern fn i_cal_property_clone(p_prop: *Property) *icalglib.Property;
    pub const clone = i_cal_property_clone;

    /// Counts the parameters in the `ICalProperty`.
    extern fn i_cal_property_count_parameters(p_prop: *const Property) c_int;
    pub const countParameters = i_cal_property_count_parameters;

    /// Frees a `ICalProperty`.
    extern fn i_cal_property_free(p_prop: *Property) void;
    pub const free = i_cal_property_free;

    /// Gets the acceptresponse of `ICalProperty`.
    extern fn i_cal_property_get_acceptresponse(p_prop: *Property) [*:0]const u8;
    pub const getAcceptresponse = i_cal_property_get_acceptresponse;

    /// Gets the acknowledged time of `ICalProperty`.
    extern fn i_cal_property_get_acknowledged(p_prop: *Property) *icalglib.Time;
    pub const getAcknowledged = i_cal_property_get_acknowledged;

    /// Gets the action of `ICalProperty`.
    extern fn i_cal_property_get_action(p_prop: *Property) icalglib.PropertyAction;
    pub const getAction = i_cal_property_get_action;

    /// Gets the allowconflict of `ICalProperty`.
    extern fn i_cal_property_get_allowconflict(p_prop: *Property) [*:0]const u8;
    pub const getAllowconflict = i_cal_property_get_allowconflict;

    /// Gets the attach of `ICalProperty`.
    extern fn i_cal_property_get_attach(p_prop: *Property) *icalglib.Attach;
    pub const getAttach = i_cal_property_get_attach;

    /// Gets the attendee of `ICalProperty`.
    extern fn i_cal_property_get_attendee(p_prop: *Property) [*:0]const u8;
    pub const getAttendee = i_cal_property_get_attendee;

    /// Gets the busytype of `ICalProperty`.
    extern fn i_cal_property_get_busytype(p_prop: *Property) icalglib.PropertyBusytype;
    pub const getBusytype = i_cal_property_get_busytype;

    /// Gets the calid of `ICalProperty`.
    extern fn i_cal_property_get_calid(p_prop: *Property) [*:0]const u8;
    pub const getCalid = i_cal_property_get_calid;

    /// Gets the calmaster of `ICalProperty`.
    extern fn i_cal_property_get_calmaster(p_prop: *Property) [*:0]const u8;
    pub const getCalmaster = i_cal_property_get_calmaster;

    /// Gets the calscale of `ICalProperty`.
    extern fn i_cal_property_get_calscale(p_prop: *Property) [*:0]const u8;
    pub const getCalscale = i_cal_property_get_calscale;

    /// Gets the capversion of `ICalProperty`.
    extern fn i_cal_property_get_capversion(p_prop: *Property) [*:0]const u8;
    pub const getCapversion = i_cal_property_get_capversion;

    /// Gets the carid of `ICalProperty`.
    extern fn i_cal_property_get_carid(p_prop: *Property) [*:0]const u8;
    pub const getCarid = i_cal_property_get_carid;

    /// Gets the carlevel of `ICalProperty`.
    extern fn i_cal_property_get_carlevel(p_prop: *Property) icalglib.PropertyCarlevel;
    pub const getCarlevel = i_cal_property_get_carlevel;

    /// Gets the categories of `ICalProperty`.
    extern fn i_cal_property_get_categories(p_prop: *Property) [*:0]const u8;
    pub const getCategories = i_cal_property_get_categories;

    /// Gets the class of `ICalProperty`.
    extern fn i_cal_property_get_class(p_prop: *Property) icalglib.Property_Class;
    pub const getClass = i_cal_property_get_class;

    /// Gets the cmd of `ICalProperty`.
    extern fn i_cal_property_get_cmd(p_prop: *Property) icalglib.PropertyCmd;
    pub const getCmd = i_cal_property_get_cmd;

    /// Gets the color property of the `prop`.
    extern fn i_cal_property_get_color(p_prop: *Property) [*:0]const u8;
    pub const getColor = i_cal_property_get_color;

    /// Gets the comment of `ICalProperty`.
    extern fn i_cal_property_get_comment(p_prop: *Property) [*:0]const u8;
    pub const getComment = i_cal_property_get_comment;

    /// Gets the completed time of `ICalProperty`.
    extern fn i_cal_property_get_completed(p_prop: *Property) *icalglib.Time;
    pub const getCompleted = i_cal_property_get_completed;

    /// Gets the components of `ICalProperty`.
    extern fn i_cal_property_get_components(p_prop: *Property) [*:0]const u8;
    pub const getComponents = i_cal_property_get_components;

    /// Gets the contact of `ICalProperty`.
    extern fn i_cal_property_get_contact(p_prop: *Property) [*:0]const u8;
    pub const getContact = i_cal_property_get_contact;

    /// Gets the created time of `ICalProperty`.
    extern fn i_cal_property_get_created(p_prop: *Property) *icalglib.Time;
    pub const getCreated = i_cal_property_get_created;

    /// Gets the csid of `ICalProperty`.
    extern fn i_cal_property_get_csid(p_prop: *Property) [*:0]const u8;
    pub const getCsid = i_cal_property_get_csid;

    /// Gets the datemax time of `ICalProperty`.
    extern fn i_cal_property_get_datemax(p_prop: *Property) *icalglib.Time;
    pub const getDatemax = i_cal_property_get_datemax;

    /// Gets the datemin time of `ICalProperty`.
    extern fn i_cal_property_get_datemin(p_prop: *Property) *icalglib.Time;
    pub const getDatemin = i_cal_property_get_datemin;

    /// If the property is a DATE-TIME with a TZID parameter and a corresponding VTIMEZONE is present in the
    /// component, the returned component will already be in the correct timezone; otherwise the caller is responsible
    /// for converting it.
    ///
    /// The `comp` can be NULL, in which case the parent of the `prop` is used to find
    /// the corresponding time zone.
    extern fn i_cal_property_get_datetime_with_component(p_prop: *Property, p_comp: ?*icalglib.Component) *icalglib.Time;
    pub const getDatetimeWithComponent = i_cal_property_get_datetime_with_component;

    /// Gets the decreed of `ICalProperty`.
    extern fn i_cal_property_get_decreed(p_prop: *Property) [*:0]const u8;
    pub const getDecreed = i_cal_property_get_decreed;

    /// Gets the defaultcharset of `ICalProperty`.
    extern fn i_cal_property_get_defaultcharset(p_prop: *Property) [*:0]const u8;
    pub const getDefaultcharset = i_cal_property_get_defaultcharset;

    /// Gets the defaultlocale of `ICalProperty`.
    extern fn i_cal_property_get_defaultlocale(p_prop: *Property) [*:0]const u8;
    pub const getDefaultlocale = i_cal_property_get_defaultlocale;

    /// Gets the defaulttzid of `ICalProperty`.
    extern fn i_cal_property_get_defaulttzid(p_prop: *Property) [*:0]const u8;
    pub const getDefaulttzid = i_cal_property_get_defaulttzid;

    /// Gets the defaultvcars of `ICalProperty`.
    extern fn i_cal_property_get_defaultvcars(p_prop: *Property) [*:0]const u8;
    pub const getDefaultvcars = i_cal_property_get_defaultvcars;

    /// Gets the deny of `ICalProperty`.
    extern fn i_cal_property_get_deny(p_prop: *Property) [*:0]const u8;
    pub const getDeny = i_cal_property_get_deny;

    /// Gets the description of `ICalProperty`.
    extern fn i_cal_property_get_description(p_prop: *Property) [*:0]const u8;
    pub const getDescription = i_cal_property_get_description;

    /// Gets the dtend time of `ICalProperty`.
    extern fn i_cal_property_get_dtend(p_prop: *Property) *icalglib.Time;
    pub const getDtend = i_cal_property_get_dtend;

    /// Gets the dtstamp time of `ICalProperty`.
    extern fn i_cal_property_get_dtstamp(p_prop: *Property) *icalglib.Time;
    pub const getDtstamp = i_cal_property_get_dtstamp;

    /// Gets the dtstart time of `ICalProperty`.
    extern fn i_cal_property_get_dtstart(p_prop: *Property) *icalglib.Time;
    pub const getDtstart = i_cal_property_get_dtstart;

    /// Gets the due time of `ICalProperty`.
    extern fn i_cal_property_get_due(p_prop: *Property) *icalglib.Time;
    pub const getDue = i_cal_property_get_due;

    /// Gets the duration of `ICalProperty`.
    extern fn i_cal_property_get_duration(p_prop: *Property) *icalglib.Duration;
    pub const getDuration = i_cal_property_get_duration;

    /// Gets the estimatedduration of `ICalProperty`.
    extern fn i_cal_property_get_estimatedduration(p_prop: *Property) *icalglib.Duration;
    pub const getEstimatedduration = i_cal_property_get_estimatedduration;

    /// Gets the exdate time of `ICalProperty`.
    extern fn i_cal_property_get_exdate(p_prop: *Property) *icalglib.Time;
    pub const getExdate = i_cal_property_get_exdate;

    /// Gets the expand of `ICalProperty`.
    extern fn i_cal_property_get_expand(p_prop: *Property) c_int;
    pub const getExpand = i_cal_property_get_expand;

    /// Gets the exrule recurrence type of `ICalProperty`.
    extern fn i_cal_property_get_exrule(p_prop: *Property) *icalglib.Recurrence;
    pub const getExrule = i_cal_property_get_exrule;

    /// Gets the first `ICalParameter` from the parent `ICalProperty`.
    extern fn i_cal_property_get_first_parameter(p_prop: *Property, p_kind: icalglib.ParameterKind) *icalglib.Parameter;
    pub const getFirstParameter = i_cal_property_get_first_parameter;

    /// Gets the freebusy period type of `ICalProperty`.
    extern fn i_cal_property_get_freebusy(p_prop: *Property) *icalglib.Period;
    pub const getFreebusy = i_cal_property_get_freebusy;

    /// Gets the geo type of `ICalProperty`.
    extern fn i_cal_property_get_geo(p_prop: *Property) *icalglib.Geo;
    pub const getGeo = i_cal_property_get_geo;

    /// Gets the grant of `ICalProperty`.
    extern fn i_cal_property_get_grant(p_prop: *Property) [*:0]const u8;
    pub const getGrant = i_cal_property_get_grant;

    /// Gets the itipversion of `ICalProperty`.
    extern fn i_cal_property_get_itipversion(p_prop: *Property) [*:0]const u8;
    pub const getItipversion = i_cal_property_get_itipversion;

    /// Gets the lastmodified time of `ICalProperty`.
    extern fn i_cal_property_get_lastmodified(p_prop: *Property) *icalglib.Time;
    pub const getLastmodified = i_cal_property_get_lastmodified;

    /// Gets the location of `ICalProperty`.
    extern fn i_cal_property_get_location(p_prop: *Property) [*:0]const u8;
    pub const getLocation = i_cal_property_get_location;

    /// Gets the maxcomponentsize of `ICalProperty`.
    extern fn i_cal_property_get_maxcomponentsize(p_prop: *Property) c_int;
    pub const getMaxcomponentsize = i_cal_property_get_maxcomponentsize;

    /// Gets the maxdate time of `ICalProperty`.
    extern fn i_cal_property_get_maxdate(p_prop: *Property) *icalglib.Time;
    pub const getMaxdate = i_cal_property_get_maxdate;

    /// Gets the maxresults of `ICalProperty`.
    extern fn i_cal_property_get_maxresults(p_prop: *Property) c_int;
    pub const getMaxresults = i_cal_property_get_maxresults;

    /// Gets the maxresultssize of `ICalProperty`.
    extern fn i_cal_property_get_maxresultssize(p_prop: *Property) c_int;
    pub const getMaxresultssize = i_cal_property_get_maxresultssize;

    /// Gets the method of `ICalProperty`.
    extern fn i_cal_property_get_method(p_prop: *Property) icalglib.PropertyMethod;
    pub const getMethod = i_cal_property_get_method;

    /// Gets the mindate time of `ICalProperty`.
    extern fn i_cal_property_get_mindate(p_prop: *Property) *icalglib.Time;
    pub const getMindate = i_cal_property_get_mindate;

    /// Gets the multipart of `ICalProperty`.
    extern fn i_cal_property_get_multipart(p_prop: *Property) [*:0]const u8;
    pub const getMultipart = i_cal_property_get_multipart;

    /// Gets the name of `ICalProperty`.
    extern fn i_cal_property_get_name(p_prop: *Property) [*:0]const u8;
    pub const getName = i_cal_property_get_name;

    /// Gets the next `ICalParameter` from the parent `ICalProperty`.
    extern fn i_cal_property_get_next_parameter(p_prop: *Property, p_kind: icalglib.ParameterKind) *icalglib.Parameter;
    pub const getNextParameter = i_cal_property_get_next_parameter;

    /// Gets the organizer of `ICalProperty`.
    extern fn i_cal_property_get_organizer(p_prop: *Property) [*:0]const u8;
    pub const getOrganizer = i_cal_property_get_organizer;

    /// Gets the owner of `ICalProperty`.
    extern fn i_cal_property_get_owner(p_prop: *Property) [*:0]const u8;
    pub const getOwner = i_cal_property_get_owner;

    /// Gets the string representation of the target parameter in the `ICalProperty`.
    extern fn i_cal_property_get_parameter_as_string(p_prop: *Property, p_name: [*:0]const u8) [*:0]u8;
    pub const getParameterAsString = i_cal_property_get_parameter_as_string;

    /// Gets the parent component of the property. Use with caution. When icalproperty is deallocated, it won't
    /// deallocate its parent. However the `ICalComponent` object created using this method will be deallocated
    /// (if no reference in other places). So You need to make sure there is another reference except the one
    /// in `ICalProperty`.
    extern fn i_cal_property_get_parent(p_property: *Property) ?*icalglib.Component;
    pub const getParent = i_cal_property_get_parent;

    /// Gets the percentcomplete of `ICalProperty`.
    extern fn i_cal_property_get_percentcomplete(p_prop: *Property) c_int;
    pub const getPercentcomplete = i_cal_property_get_percentcomplete;

    /// Gets the permission of `ICalProperty`.
    extern fn i_cal_property_get_permission(p_prop: *Property) [*:0]const u8;
    pub const getPermission = i_cal_property_get_permission;

    /// Gets the pollcompletion of `ICalProperty`.
    extern fn i_cal_property_get_pollcompletion(p_prop: *Property) icalglib.PropertyPollcompletion;
    pub const getPollcompletion = i_cal_property_get_pollcompletion;

    /// Gets the pollitemid of `ICalProperty`.
    extern fn i_cal_property_get_pollitemid(p_prop: *Property) c_int;
    pub const getPollitemid = i_cal_property_get_pollitemid;

    /// Gets the pollmode of `ICalProperty`.
    extern fn i_cal_property_get_pollmode(p_prop: *Property) icalglib.PropertyPollmode;
    pub const getPollmode = i_cal_property_get_pollmode;

    /// Gets the pollproperties of `ICalProperty`.
    extern fn i_cal_property_get_pollproperties(p_prop: *Property) [*:0]const u8;
    pub const getPollproperties = i_cal_property_get_pollproperties;

    /// Gets the pollwinner of `ICalProperty`.
    extern fn i_cal_property_get_pollwinner(p_prop: *Property) c_int;
    pub const getPollwinner = i_cal_property_get_pollwinner;

    /// Gets the priority of `ICalProperty`.
    extern fn i_cal_property_get_priority(p_prop: *Property) c_int;
    pub const getPriority = i_cal_property_get_priority;

    /// Gets the prodid of `ICalProperty`.
    extern fn i_cal_property_get_prodid(p_prop: *Property) [*:0]const u8;
    pub const getProdid = i_cal_property_get_prodid;

    /// Gets the property name of `ICalProperty`.
    extern fn i_cal_property_get_property_name(p_prop: *const Property) [*:0]u8;
    pub const getPropertyName = i_cal_property_get_property_name;

    /// Gets the query of `ICalProperty`.
    extern fn i_cal_property_get_query(p_prop: *Property) [*:0]const u8;
    pub const getQuery = i_cal_property_get_query;

    /// Gets the queryid of `ICalProperty`.
    extern fn i_cal_property_get_queryid(p_prop: *Property) [*:0]const u8;
    pub const getQueryid = i_cal_property_get_queryid;

    /// Gets the querylevel of `ICalProperty`.
    extern fn i_cal_property_get_querylevel(p_prop: *Property) icalglib.PropertyQuerylevel;
    pub const getQuerylevel = i_cal_property_get_querylevel;

    /// Gets the queryname of `ICalProperty`.
    extern fn i_cal_property_get_queryname(p_prop: *Property) [*:0]const u8;
    pub const getQueryname = i_cal_property_get_queryname;

    /// Gets the rdate  of `ICalProperty`.
    extern fn i_cal_property_get_rdate(p_prop: *Property) *icalglib.Datetimeperiod;
    pub const getRdate = i_cal_property_get_rdate;

    /// Gets the recuraccepted of `ICalProperty`.
    extern fn i_cal_property_get_recuraccepted(p_prop: *Property) [*:0]const u8;
    pub const getRecuraccepted = i_cal_property_get_recuraccepted;

    /// Gets the recurexpand of `ICalProperty`.
    extern fn i_cal_property_get_recurexpand(p_prop: *Property) [*:0]const u8;
    pub const getRecurexpand = i_cal_property_get_recurexpand;

    /// Gets the recurlimit of `ICalProperty`.
    extern fn i_cal_property_get_recurlimit(p_prop: *Property) [*:0]const u8;
    pub const getRecurlimit = i_cal_property_get_recurlimit;

    /// Gets the recurrenceid time of `ICalProperty`.
    extern fn i_cal_property_get_recurrenceid(p_prop: *Property) *icalglib.Time;
    pub const getRecurrenceid = i_cal_property_get_recurrenceid;

    /// Gets the relatedto of `ICalProperty`.
    extern fn i_cal_property_get_relatedto(p_prop: *Property) [*:0]const u8;
    pub const getRelatedto = i_cal_property_get_relatedto;

    /// Gets the relcalid of `ICalProperty`.
    extern fn i_cal_property_get_relcalid(p_prop: *Property) [*:0]const u8;
    pub const getRelcalid = i_cal_property_get_relcalid;

    /// Gets the repeat of `ICalProperty`.
    extern fn i_cal_property_get_repeat(p_prop: *Property) c_int;
    pub const getRepeat = i_cal_property_get_repeat;

    /// Gets the replyurl of `ICalProperty`.
    extern fn i_cal_property_get_replyurl(p_prop: *Property) [*:0]const u8;
    pub const getReplyurl = i_cal_property_get_replyurl;

    /// Gets the requeststatus of `ICalProperty`.
    extern fn i_cal_property_get_requeststatus(p_prop: *Property) *icalglib.Reqstat;
    pub const getRequeststatus = i_cal_property_get_requeststatus;

    /// Gets the resources of `ICalProperty`.
    extern fn i_cal_property_get_resources(p_prop: *Property) [*:0]const u8;
    pub const getResources = i_cal_property_get_resources;

    /// Gets the response of `ICalProperty`.
    extern fn i_cal_property_get_response(p_prop: *Property) c_int;
    pub const getResponse = i_cal_property_get_response;

    /// Gets the restriction of `ICalProperty`.
    extern fn i_cal_property_get_restriction(p_prop: *Property) [*:0]const u8;
    pub const getRestriction = i_cal_property_get_restriction;

    /// Gets the rrule recurrence type of `ICalProperty`.
    extern fn i_cal_property_get_rrule(p_prop: *Property) *icalglib.Recurrence;
    pub const getRrule = i_cal_property_get_rrule;

    /// Gets the scope of `ICalProperty`.
    extern fn i_cal_property_get_scope(p_prop: *Property) [*:0]const u8;
    pub const getScope = i_cal_property_get_scope;

    /// Gets the sequence of `ICalProperty`.
    extern fn i_cal_property_get_sequence(p_prop: *Property) c_int;
    pub const getSequence = i_cal_property_get_sequence;

    /// Gets the status of `ICalProperty`.
    extern fn i_cal_property_get_status(p_prop: *Property) icalglib.PropertyStatus;
    pub const getStatus = i_cal_property_get_status;

    /// Gets the storesexpanded of `ICalProperty`.
    extern fn i_cal_property_get_storesexpanded(p_prop: *Property) [*:0]const u8;
    pub const getStoresexpanded = i_cal_property_get_storesexpanded;

    /// Gets the summary of `ICalProperty`.
    extern fn i_cal_property_get_summary(p_prop: *Property) [*:0]const u8;
    pub const getSummary = i_cal_property_get_summary;

    /// Gets the target of `ICalProperty`.
    extern fn i_cal_property_get_target(p_prop: *Property) [*:0]const u8;
    pub const getTarget = i_cal_property_get_target;

    /// Gets the taskmode of `ICalProperty`.
    extern fn i_cal_property_get_taskmode(p_prop: *Property) icalglib.PropertyTaskmode;
    pub const getTaskmode = i_cal_property_get_taskmode;

    /// Gets the transp of `ICalProperty`.
    extern fn i_cal_property_get_transp(p_prop: *Property) icalglib.PropertyTransp;
    pub const getTransp = i_cal_property_get_transp;

    /// Gets the trigger period type of `ICalProperty`.
    extern fn i_cal_property_get_trigger(p_prop: *Property) *icalglib.Trigger;
    pub const getTrigger = i_cal_property_get_trigger;

    /// Gets the tzid of `ICalProperty`.
    extern fn i_cal_property_get_tzid(p_prop: *Property) [*:0]const u8;
    pub const getTzid = i_cal_property_get_tzid;

    /// Gets the tzidaliasof of `ICalProperty`.
    extern fn i_cal_property_get_tzidaliasof(p_prop: *Property) [*:0]const u8;
    pub const getTzidaliasof = i_cal_property_get_tzidaliasof;

    /// Gets the tzname of `ICalProperty`.
    extern fn i_cal_property_get_tzname(p_prop: *Property) [*:0]const u8;
    pub const getTzname = i_cal_property_get_tzname;

    /// Gets the tzoffsetfrom of `ICalProperty`.
    extern fn i_cal_property_get_tzoffsetfrom(p_prop: *Property) c_int;
    pub const getTzoffsetfrom = i_cal_property_get_tzoffsetfrom;

    /// Gets the tzoffsetto of `ICalProperty`.
    extern fn i_cal_property_get_tzoffsetto(p_prop: *Property) c_int;
    pub const getTzoffsetto = i_cal_property_get_tzoffsetto;

    /// Gets the tzuntil time of `ICalProperty`.
    extern fn i_cal_property_get_tzuntil(p_prop: *Property) *icalglib.Time;
    pub const getTzuntil = i_cal_property_get_tzuntil;

    /// Gets the tzurl of `ICalProperty`.
    extern fn i_cal_property_get_tzurl(p_prop: *Property) [*:0]const u8;
    pub const getTzurl = i_cal_property_get_tzurl;

    /// Gets the uid of `ICalProperty`.
    extern fn i_cal_property_get_uid(p_prop: *Property) [*:0]const u8;
    pub const getUid = i_cal_property_get_uid;

    /// Gets the url of `ICalProperty`.
    extern fn i_cal_property_get_url(p_prop: *Property) [*:0]const u8;
    pub const getUrl = i_cal_property_get_url;

    /// Gets the `ICalValue` of `ICalProperty`.
    extern fn i_cal_property_get_value(p_prop: *const Property) *icalglib.Value;
    pub const getValue = i_cal_property_get_value;

    /// Gets the string representation of the value in `ICalProperty`.
    extern fn i_cal_property_get_value_as_string(p_prop: *const Property) [*:0]u8;
    pub const getValueAsString = i_cal_property_get_value_as_string;

    /// Gets the version of `ICalProperty`.
    extern fn i_cal_property_get_version(p_prop: *Property) [*:0]const u8;
    pub const getVersion = i_cal_property_get_version;

    /// Gets the voter of `ICalProperty`.
    extern fn i_cal_property_get_voter(p_prop: *Property) [*:0]const u8;
    pub const getVoter = i_cal_property_get_voter;

    /// Gets the x of `ICalProperty`.
    extern fn i_cal_property_get_x(p_prop: *Property) [*:0]const u8;
    pub const getX = i_cal_property_get_x;

    /// Gets the name of x property.
    extern fn i_cal_property_get_x_name(p_prop: *Property) ?[*:0]const u8;
    pub const getXName = i_cal_property_get_x_name;

    /// Gets the xlicclass of `ICalProperty`.
    extern fn i_cal_property_get_xlicclass(p_prop: *Property) icalglib.PropertyXlicclass;
    pub const getXlicclass = i_cal_property_get_xlicclass;

    /// Gets the xlicclustercount of `ICalProperty`.
    extern fn i_cal_property_get_xlicclustercount(p_prop: *Property) [*:0]const u8;
    pub const getXlicclustercount = i_cal_property_get_xlicclustercount;

    /// Gets the xlicerror of `ICalProperty`.
    extern fn i_cal_property_get_xlicerror(p_prop: *Property) [*:0]const u8;
    pub const getXlicerror = i_cal_property_get_xlicerror;

    /// Gets the xlicmimecharset of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimecharset(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimecharset = i_cal_property_get_xlicmimecharset;

    /// Gets the xlicmimecid of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimecid(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimecid = i_cal_property_get_xlicmimecid;

    /// Gets the xlicmimecontenttype of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimecontenttype(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimecontenttype = i_cal_property_get_xlicmimecontenttype;

    /// Gets the xlicmimeencoding of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimeencoding(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimeencoding = i_cal_property_get_xlicmimeencoding;

    /// Gets the xlicmimefilename of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimefilename(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimefilename = i_cal_property_get_xlicmimefilename;

    /// Gets the xlicmimeoptinfo of `ICalProperty`.
    extern fn i_cal_property_get_xlicmimeoptinfo(p_prop: *Property) [*:0]const u8;
    pub const getXlicmimeoptinfo = i_cal_property_get_xlicmimeoptinfo;

    /// Gets the kind of `ICalProperty`.
    extern fn i_cal_property_isa(p_property: *Property) icalglib.PropertyKind;
    pub const isa = i_cal_property_isa;

    /// Checks whether the native part of `ICalProperty` is of the type icalproperty.
    extern fn i_cal_property_isa_property(p_property: *Property) c_int;
    pub const isaProperty = i_cal_property_isa_property;

    /// Removes the target kind of the parameters in the `ICalProperty`.
    extern fn i_cal_property_remove_parameter_by_kind(p_prop: *Property, p_kind: icalglib.ParameterKind) void;
    pub const removeParameterByKind = i_cal_property_remove_parameter_by_kind;

    /// Removes parameter in the `ICalProperty` by name.
    extern fn i_cal_property_remove_parameter_by_name(p_prop: *Property, p_name: [*:0]const u8) void;
    pub const removeParameterByName = i_cal_property_remove_parameter_by_name;

    /// Removes the parameter in the `ICalProperty` by ref.
    extern fn i_cal_property_remove_parameter_by_ref(p_prop: *Property, p_param: *icalglib.Parameter) void;
    pub const removeParameterByRef = i_cal_property_remove_parameter_by_ref;

    /// Sets the acceptresponse for the `ICalProperty`.
    extern fn i_cal_property_set_acceptresponse(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setAcceptresponse = i_cal_property_set_acceptresponse;

    /// Sets the acknowledged time for the `ICalProperty`.
    extern fn i_cal_property_set_acknowledged(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setAcknowledged = i_cal_property_set_acknowledged;

    /// Sets the action for the `ICalProperty`.
    extern fn i_cal_property_set_action(p_prop: *Property, p_v: icalglib.PropertyAction) void;
    pub const setAction = i_cal_property_set_action;

    /// Sets the allowconflict for the `ICalProperty`.
    extern fn i_cal_property_set_allowconflict(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setAllowconflict = i_cal_property_set_allowconflict;

    /// Sets the attach for the `ICalProperty`.
    extern fn i_cal_property_set_attach(p_prop: *Property, p_v: *icalglib.Attach) void;
    pub const setAttach = i_cal_property_set_attach;

    /// Sets the attendee for the `ICalProperty`.
    extern fn i_cal_property_set_attendee(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setAttendee = i_cal_property_set_attendee;

    /// Sets the busytype for the `ICalProperty`.
    extern fn i_cal_property_set_busytype(p_prop: *Property, p_v: icalglib.PropertyBusytype) void;
    pub const setBusytype = i_cal_property_set_busytype;

    /// Sets the calid for the `ICalProperty`.
    extern fn i_cal_property_set_calid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCalid = i_cal_property_set_calid;

    /// Sets the calmaster for the `ICalProperty`.
    extern fn i_cal_property_set_calmaster(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCalmaster = i_cal_property_set_calmaster;

    /// Sets the calscale for the `ICalProperty`.
    extern fn i_cal_property_set_calscale(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCalscale = i_cal_property_set_calscale;

    /// Sets the capversion for the `ICalProperty`.
    extern fn i_cal_property_set_capversion(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCapversion = i_cal_property_set_capversion;

    /// Sets the carid for the `ICalProperty`.
    extern fn i_cal_property_set_carid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCarid = i_cal_property_set_carid;

    /// Sets the carlevel for the `ICalProperty`.
    extern fn i_cal_property_set_carlevel(p_prop: *Property, p_v: icalglib.PropertyCarlevel) void;
    pub const setCarlevel = i_cal_property_set_carlevel;

    /// Sets the categories for the `ICalProperty`.
    extern fn i_cal_property_set_categories(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCategories = i_cal_property_set_categories;

    /// Sets the class for the `ICalProperty`.
    extern fn i_cal_property_set_class(p_prop: *Property, p_v: icalglib.Property_Class) void;
    pub const setClass = i_cal_property_set_class;

    /// Sets the cmd for the `ICalProperty`.
    extern fn i_cal_property_set_cmd(p_prop: *Property, p_v: icalglib.PropertyCmd) void;
    pub const setCmd = i_cal_property_set_cmd;

    /// Sets the color for the `prop`.
    extern fn i_cal_property_set_color(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setColor = i_cal_property_set_color;

    /// Sets the comment for the `ICalProperty`.
    extern fn i_cal_property_set_comment(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setComment = i_cal_property_set_comment;

    /// Sets the completed time for the `ICalProperty`.
    extern fn i_cal_property_set_completed(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setCompleted = i_cal_property_set_completed;

    /// Sets the components for the `ICalProperty`.
    extern fn i_cal_property_set_components(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setComponents = i_cal_property_set_components;

    /// Sets the contact for the `ICalProperty`.
    extern fn i_cal_property_set_contact(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setContact = i_cal_property_set_contact;

    /// Sets the created time for the `ICalProperty`.
    extern fn i_cal_property_set_created(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setCreated = i_cal_property_set_created;

    /// Sets the csid for the `ICalProperty`.
    extern fn i_cal_property_set_csid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setCsid = i_cal_property_set_csid;

    /// Sets the datemax time for the `ICalProperty`.
    extern fn i_cal_property_set_datemax(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDatemax = i_cal_property_set_datemax;

    /// Sets the datemin time for the `ICalProperty`.
    extern fn i_cal_property_set_datemin(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDatemin = i_cal_property_set_datemin;

    /// Sets the decreed for the `ICalProperty`.
    extern fn i_cal_property_set_decreed(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDecreed = i_cal_property_set_decreed;

    /// Sets the defaultcharset for the `ICalProperty`.
    extern fn i_cal_property_set_defaultcharset(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDefaultcharset = i_cal_property_set_defaultcharset;

    /// Sets the defaultlocale for the `ICalProperty`.
    extern fn i_cal_property_set_defaultlocale(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDefaultlocale = i_cal_property_set_defaultlocale;

    /// Sets the defaulttzid for the `ICalProperty`.
    extern fn i_cal_property_set_defaulttzid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDefaulttzid = i_cal_property_set_defaulttzid;

    /// Sets the defaultvcars for the `ICalProperty`.
    extern fn i_cal_property_set_defaultvcars(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDefaultvcars = i_cal_property_set_defaultvcars;

    /// Sets the deny for the `ICalProperty`.
    extern fn i_cal_property_set_deny(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDeny = i_cal_property_set_deny;

    /// Sets the description for the `ICalProperty`.
    extern fn i_cal_property_set_description(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setDescription = i_cal_property_set_description;

    /// Sets the dtend time for the `ICalProperty`.
    extern fn i_cal_property_set_dtend(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDtend = i_cal_property_set_dtend;

    /// Sets the dtstamp time for the `ICalProperty`.
    extern fn i_cal_property_set_dtstamp(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDtstamp = i_cal_property_set_dtstamp;

    /// Sets the dtstart time for the `ICalProperty`.
    extern fn i_cal_property_set_dtstart(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDtstart = i_cal_property_set_dtstart;

    /// Sets the due time for the `ICalProperty`.
    extern fn i_cal_property_set_due(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setDue = i_cal_property_set_due;

    /// Sets the duration for the `ICalProperty`.
    extern fn i_cal_property_set_duration(p_prop: *Property, p_v: *icalglib.Duration) void;
    pub const setDuration = i_cal_property_set_duration;

    /// Sets the estimatedduration for the `ICalProperty`.
    extern fn i_cal_property_set_estimatedduration(p_prop: *Property, p_v: *icalglib.Duration) void;
    pub const setEstimatedduration = i_cal_property_set_estimatedduration;

    /// Sets the exdate time for the `ICalProperty`.
    extern fn i_cal_property_set_exdate(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setExdate = i_cal_property_set_exdate;

    /// Sets the expand for the `ICalProperty`.
    extern fn i_cal_property_set_expand(p_prop: *Property, p_v: c_int) void;
    pub const setExpand = i_cal_property_set_expand;

    /// Sets the exrule time for the `ICalProperty`.
    extern fn i_cal_property_set_exrule(p_prop: *Property, p_v: *icalglib.Recurrence) void;
    pub const setExrule = i_cal_property_set_exrule;

    /// Sets the freebusy time for the `ICalProperty`.
    extern fn i_cal_property_set_freebusy(p_prop: *Property, p_v: *icalglib.Period) void;
    pub const setFreebusy = i_cal_property_set_freebusy;

    /// Sets the geo for the `ICalProperty`.
    extern fn i_cal_property_set_geo(p_prop: *Property, p_v: *icalglib.Geo) void;
    pub const setGeo = i_cal_property_set_geo;

    /// Sets the grant for the `ICalProperty`.
    extern fn i_cal_property_set_grant(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setGrant = i_cal_property_set_grant;

    /// Sets the itipversion for the `ICalProperty`.
    extern fn i_cal_property_set_itipversion(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setItipversion = i_cal_property_set_itipversion;

    /// Sets the lastmodified time for the `ICalProperty`.
    extern fn i_cal_property_set_lastmodified(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setLastmodified = i_cal_property_set_lastmodified;

    /// Sets the location for the `ICalProperty`.
    extern fn i_cal_property_set_location(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setLocation = i_cal_property_set_location;

    /// Sets the maxcomponentsize for the `ICalProperty`.
    extern fn i_cal_property_set_maxcomponentsize(p_prop: *Property, p_v: c_int) void;
    pub const setMaxcomponentsize = i_cal_property_set_maxcomponentsize;

    /// Sets the maxdate time for the `ICalProperty`.
    extern fn i_cal_property_set_maxdate(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setMaxdate = i_cal_property_set_maxdate;

    /// Sets the maxresults for the `ICalProperty`.
    extern fn i_cal_property_set_maxresults(p_prop: *Property, p_v: c_int) void;
    pub const setMaxresults = i_cal_property_set_maxresults;

    /// Sets the maxresultssize for the `ICalProperty`.
    extern fn i_cal_property_set_maxresultssize(p_prop: *Property, p_v: c_int) void;
    pub const setMaxresultssize = i_cal_property_set_maxresultssize;

    /// Sets the method for the `ICalProperty`.
    extern fn i_cal_property_set_method(p_prop: *Property, p_v: icalglib.PropertyMethod) void;
    pub const setMethod = i_cal_property_set_method;

    /// Sets the mindate time for the `ICalProperty`.
    extern fn i_cal_property_set_mindate(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setMindate = i_cal_property_set_mindate;

    /// Sets the multipart for the `ICalProperty`.
    extern fn i_cal_property_set_multipart(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setMultipart = i_cal_property_set_multipart;

    /// Sets the name for the `ICalProperty`.
    extern fn i_cal_property_set_name(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setName = i_cal_property_set_name;

    /// Sets the organizer for the `ICalProperty`.
    extern fn i_cal_property_set_organizer(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setOrganizer = i_cal_property_set_organizer;

    /// Sets the owner for the `ICalProperty`.
    extern fn i_cal_property_set_owner(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setOwner = i_cal_property_set_owner;

    /// Sets a `ICalParameter` into the `ICalProperty`. It behaves like set the copy of the `ICalParameter`. Upon
    /// completion the native part of `ICalParameter` will be set to NULL.
    extern fn i_cal_property_set_parameter(p_prop: *Property, p_parameter: *icalglib.Parameter) void;
    pub const setParameter = i_cal_property_set_parameter;

    /// Sets the `ICalProperty` with the parameter defined by the name and value.
    extern fn i_cal_property_set_parameter_from_string(p_prop: *Property, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setParameterFromString = i_cal_property_set_parameter_from_string;

    /// Sets the parent `ICalComponent` of the specified `ICalProperty`.
    extern fn i_cal_property_set_parent(p_property: *Property, p_component: ?*icalglib.Component) void;
    pub const setParent = i_cal_property_set_parent;

    /// Sets the percentcomplete for the `ICalProperty`.
    extern fn i_cal_property_set_percentcomplete(p_prop: *Property, p_v: c_int) void;
    pub const setPercentcomplete = i_cal_property_set_percentcomplete;

    /// Sets the permission for the `ICalProperty`.
    extern fn i_cal_property_set_permission(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setPermission = i_cal_property_set_permission;

    /// Sets the pollcompletion for the `ICalProperty`.
    extern fn i_cal_property_set_pollcompletion(p_prop: *Property, p_v: icalglib.PropertyPollcompletion) void;
    pub const setPollcompletion = i_cal_property_set_pollcompletion;

    /// Sets the pollitemid for the `ICalProperty`.
    extern fn i_cal_property_set_pollitemid(p_prop: *Property, p_v: c_int) void;
    pub const setPollitemid = i_cal_property_set_pollitemid;

    /// Sets the pollmode for the `ICalProperty`.
    extern fn i_cal_property_set_pollmode(p_prop: *Property, p_v: icalglib.PropertyPollmode) void;
    pub const setPollmode = i_cal_property_set_pollmode;

    /// Sets the pollproperties for the `ICalProperty`.
    extern fn i_cal_property_set_pollproperties(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setPollproperties = i_cal_property_set_pollproperties;

    /// Sets the pollwinner for the `ICalProperty`.
    extern fn i_cal_property_set_pollwinner(p_prop: *Property, p_v: c_int) void;
    pub const setPollwinner = i_cal_property_set_pollwinner;

    /// Sets the priority for the `ICalProperty`.
    extern fn i_cal_property_set_priority(p_prop: *Property, p_v: c_int) void;
    pub const setPriority = i_cal_property_set_priority;

    /// Sets the prodid for the `ICalProperty`.
    extern fn i_cal_property_set_prodid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setProdid = i_cal_property_set_prodid;

    /// Sets the query for the `ICalProperty`.
    extern fn i_cal_property_set_query(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setQuery = i_cal_property_set_query;

    /// Sets the queryid for the `ICalProperty`.
    extern fn i_cal_property_set_queryid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setQueryid = i_cal_property_set_queryid;

    /// Sets the querylevel for the `ICalProperty`.
    extern fn i_cal_property_set_querylevel(p_prop: *Property, p_v: icalglib.PropertyQuerylevel) void;
    pub const setQuerylevel = i_cal_property_set_querylevel;

    /// Sets the queryname for the `ICalProperty`.
    extern fn i_cal_property_set_queryname(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setQueryname = i_cal_property_set_queryname;

    /// Sets the rdate for the `ICalProperty`.
    extern fn i_cal_property_set_rdate(p_prop: *Property, p_v: *icalglib.Datetimeperiod) void;
    pub const setRdate = i_cal_property_set_rdate;

    /// Sets the recuraccepted for the `ICalProperty`.
    extern fn i_cal_property_set_recuraccepted(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRecuraccepted = i_cal_property_set_recuraccepted;

    /// Sets the recurexpand for the `ICalProperty`.
    extern fn i_cal_property_set_recurexpand(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRecurexpand = i_cal_property_set_recurexpand;

    /// Sets the recurlimit for the `ICalProperty`.
    extern fn i_cal_property_set_recurlimit(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRecurlimit = i_cal_property_set_recurlimit;

    /// Sets the recurrenceid time for the `ICalProperty`.
    extern fn i_cal_property_set_recurrenceid(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setRecurrenceid = i_cal_property_set_recurrenceid;

    /// Sets the relatedto for the `ICalProperty`.
    extern fn i_cal_property_set_relatedto(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRelatedto = i_cal_property_set_relatedto;

    /// Sets the relcalid for the `ICalProperty`.
    extern fn i_cal_property_set_relcalid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRelcalid = i_cal_property_set_relcalid;

    /// Sets the repeat for the `ICalProperty`.
    extern fn i_cal_property_set_repeat(p_prop: *Property, p_v: c_int) void;
    pub const setRepeat = i_cal_property_set_repeat;

    /// Sets the replyurl for the `ICalProperty`.
    extern fn i_cal_property_set_replyurl(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setReplyurl = i_cal_property_set_replyurl;

    /// Sets the requeststatus for the `ICalProperty`.
    extern fn i_cal_property_set_requeststatus(p_prop: *Property, p_v: *icalglib.Reqstat) void;
    pub const setRequeststatus = i_cal_property_set_requeststatus;

    /// Sets the resources for the `ICalProperty`.
    extern fn i_cal_property_set_resources(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setResources = i_cal_property_set_resources;

    /// Sets the response for the `ICalProperty`.
    extern fn i_cal_property_set_response(p_prop: *Property, p_v: c_int) void;
    pub const setResponse = i_cal_property_set_response;

    /// Sets the restriction for the `ICalProperty`.
    extern fn i_cal_property_set_restriction(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setRestriction = i_cal_property_set_restriction;

    /// Sets the rrule for the `ICalProperty`.
    extern fn i_cal_property_set_rrule(p_prop: *Property, p_v: *icalglib.Recurrence) void;
    pub const setRrule = i_cal_property_set_rrule;

    /// Sets the scope for the `ICalProperty`.
    extern fn i_cal_property_set_scope(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setScope = i_cal_property_set_scope;

    /// Sets the sequence for the `ICalProperty`.
    extern fn i_cal_property_set_sequence(p_prop: *Property, p_v: c_int) void;
    pub const setSequence = i_cal_property_set_sequence;

    /// Sets the status for the `ICalProperty`.
    extern fn i_cal_property_set_status(p_prop: *Property, p_v: icalglib.PropertyStatus) void;
    pub const setStatus = i_cal_property_set_status;

    /// Sets the storesexpanded for the `ICalProperty`.
    extern fn i_cal_property_set_storesexpanded(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setStoresexpanded = i_cal_property_set_storesexpanded;

    /// Sets the summary for the `ICalProperty`.
    extern fn i_cal_property_set_summary(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setSummary = i_cal_property_set_summary;

    /// Sets the target for the `ICalProperty`.
    extern fn i_cal_property_set_target(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setTarget = i_cal_property_set_target;

    /// Sets the taskmode for the `ICalProperty`.
    extern fn i_cal_property_set_taskmode(p_prop: *Property, p_v: icalglib.PropertyTaskmode) void;
    pub const setTaskmode = i_cal_property_set_taskmode;

    /// Sets the transp for the `ICalProperty`.
    extern fn i_cal_property_set_transp(p_prop: *Property, p_v: icalglib.PropertyTransp) void;
    pub const setTransp = i_cal_property_set_transp;

    /// Sets the trigger time for the `ICalProperty`.
    extern fn i_cal_property_set_trigger(p_prop: *Property, p_v: *icalglib.Trigger) void;
    pub const setTrigger = i_cal_property_set_trigger;

    /// Sets the tzid for the `ICalProperty`.
    extern fn i_cal_property_set_tzid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setTzid = i_cal_property_set_tzid;

    /// Sets the tzidaliasof for the `ICalProperty`.
    extern fn i_cal_property_set_tzidaliasof(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setTzidaliasof = i_cal_property_set_tzidaliasof;

    /// Sets the tzname for the `ICalProperty`.
    extern fn i_cal_property_set_tzname(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setTzname = i_cal_property_set_tzname;

    /// Sets the tzoffsetfrom for the `ICalProperty`.
    extern fn i_cal_property_set_tzoffsetfrom(p_prop: *Property, p_v: c_int) void;
    pub const setTzoffsetfrom = i_cal_property_set_tzoffsetfrom;

    /// Sets the tzoffsetto for the `ICalProperty`.
    extern fn i_cal_property_set_tzoffsetto(p_prop: *Property, p_v: c_int) void;
    pub const setTzoffsetto = i_cal_property_set_tzoffsetto;

    /// Sets the tzuntil time for the `ICalProperty`.
    extern fn i_cal_property_set_tzuntil(p_prop: *Property, p_v: *icalglib.Time) void;
    pub const setTzuntil = i_cal_property_set_tzuntil;

    /// Sets the tzurl for the `ICalProperty`.
    extern fn i_cal_property_set_tzurl(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setTzurl = i_cal_property_set_tzurl;

    /// Sets the uid for the `ICalProperty`.
    extern fn i_cal_property_set_uid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setUid = i_cal_property_set_uid;

    /// Sets the url for the `ICalProperty`.
    extern fn i_cal_property_set_url(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setUrl = i_cal_property_set_url;

    /// Sets the `ICalProperty` with the `ICalValue`.
    extern fn i_cal_property_set_value(p_prop: *Property, p_value: *icalglib.Value) void;
    pub const setValue = i_cal_property_set_value;

    /// Sets the `ICalProperty` with the `ICalValue` constructed from string.
    extern fn i_cal_property_set_value_from_string(p_prop: *Property, p_value: [*:0]const u8, p_kind: [*:0]const u8) void;
    pub const setValueFromString = i_cal_property_set_value_from_string;

    /// Sets the version for the `ICalProperty`.
    extern fn i_cal_property_set_version(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setVersion = i_cal_property_set_version;

    /// Sets the voter for the `ICalProperty`.
    extern fn i_cal_property_set_voter(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setVoter = i_cal_property_set_voter;

    /// Sets the x for the `ICalProperty`.
    extern fn i_cal_property_set_x(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setX = i_cal_property_set_x;

    /// Sets the name of x property for the `ICalProperty`.
    extern fn i_cal_property_set_x_name(p_prop: *Property, p_name: [*:0]const u8) void;
    pub const setXName = i_cal_property_set_x_name;

    /// Sets the xlicclass for the `ICalProperty`.
    extern fn i_cal_property_set_xlicclass(p_prop: *Property, p_v: icalglib.PropertyXlicclass) void;
    pub const setXlicclass = i_cal_property_set_xlicclass;

    /// Sets the xlicclustercount for the `ICalProperty`.
    extern fn i_cal_property_set_xlicclustercount(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicclustercount = i_cal_property_set_xlicclustercount;

    /// Sets the xlicerror for the `ICalProperty`.
    extern fn i_cal_property_set_xlicerror(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicerror = i_cal_property_set_xlicerror;

    /// Sets the xlicmimecharset for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimecharset(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimecharset = i_cal_property_set_xlicmimecharset;

    /// Sets the xlicmimecid for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimecid(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimecid = i_cal_property_set_xlicmimecid;

    /// Sets the xlicmimecontenttype for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimecontenttype(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimecontenttype = i_cal_property_set_xlicmimecontenttype;

    /// Sets the xlicmimeencoding for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimeencoding(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimeencoding = i_cal_property_set_xlicmimeencoding;

    /// Sets the xlicmimefilename for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimefilename(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimefilename = i_cal_property_set_xlicmimefilename;

    /// Sets the xlicmimeoptinfo for the `ICalProperty`.
    extern fn i_cal_property_set_xlicmimeoptinfo(p_prop: *Property, p_v: [*:0]const u8) void;
    pub const setXlicmimeoptinfo = i_cal_property_set_xlicmimeoptinfo;

    /// Adds the `parameter` into the `prop` and free the `parameter`.
    extern fn i_cal_property_take_parameter(p_prop: *Property, p_parameter: *icalglib.Parameter) void;
    pub const takeParameter = i_cal_property_take_parameter;

    /// Sets the `prop` with the `value` and unrefs the `value`.
    extern fn i_cal_property_take_value(p_prop: *Property, p_value: *icalglib.Value) void;
    pub const takeValue = i_cal_property_take_value;

    extern fn i_cal_property_get_type() usize;
    pub const getGObjectType = i_cal_property_get_type;

    extern fn g_object_ref(p_self: *icalglib.Property) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Property) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Property, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalRecurIterator instance.
pub const RecurIterator = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.RecurIteratorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates an `ICalRecurIterator`.
    extern fn i_cal_recur_iterator_new(p_rule: *icalglib.Recurrence, p_dtstart: *icalglib.Time) *icalglib.RecurIterator;
    pub const new = i_cal_recur_iterator_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_recur_iterator_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.RecurIterator;
    pub const newFull = i_cal_recur_iterator_new_full;

    /// Frees an iterator.
    extern fn i_cal_recur_iterator_free(p_iterator: *RecurIterator) void;
    pub const free = i_cal_recur_iterator_free;

    /// Gets the next occurrence from an iterator.
    extern fn i_cal_recur_iterator_next(p_iterator: *RecurIterator) *icalglib.Time;
    pub const next = i_cal_recur_iterator_next;

    /// Sets the date-time at which the iterator will start, where 'start' is a value between DTSTART and UNTIL.
    /// Note:
    /// CAN NOT be used with RRULEs that contain COUNT.
    extern fn i_cal_recur_iterator_set_start(p_iterator: *RecurIterator, p_start: *icalglib.Time) c_int;
    pub const setStart = i_cal_recur_iterator_set_start;

    extern fn i_cal_recur_iterator_get_type() usize;
    pub const getGObjectType = i_cal_recur_iterator_get_type;

    extern fn g_object_ref(p_self: *icalglib.RecurIterator) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.RecurIterator) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *RecurIterator, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalRecurrence instance.
pub const Recurrence = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.RecurrenceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Decodes a day to a weekday in a week.
    extern fn i_cal_recurrence_day_day_of_week(p_day: c_short) icalglib.RecurrenceWeekday;
    pub const dayDayOfWeek = i_cal_recurrence_day_day_of_week;

    /// Decodes a day to a position of the weekday.
    extern fn i_cal_recurrence_day_position(p_day: c_short) c_int;
    pub const dayPosition = i_cal_recurrence_day_position;

    /// Converts a string representation to an enum representation for the frequency.
    extern fn i_cal_recurrence_frequency_from_string(p_str: [*:0]const u8) icalglib.RecurrenceFrequency;
    pub const frequencyFromString = i_cal_recurrence_frequency_from_string;

    /// Converts a enum representation to a string representation for the frequency.
    extern fn i_cal_recurrence_frequency_to_string(p_kind: icalglib.RecurrenceFrequency) [*:0]const u8;
    pub const frequencyToString = i_cal_recurrence_frequency_to_string;

    /// Decodes a month and check whether it is a leap month.
    extern fn i_cal_recurrence_month_is_leap(p_month: c_short) c_int;
    pub const monthIsLeap = i_cal_recurrence_month_is_leap;

    extern fn i_cal_recurrence_month_month(p_month: c_short) c_int;
    pub const monthMonth = i_cal_recurrence_month_month;

    extern fn i_cal_recurrence_new_default() ?*anyopaque;
    pub const newDefault = i_cal_recurrence_new_default;

    /// Checks whether rscale is supported.
    extern fn i_cal_recurrence_rscale_is_supported() c_int;
    pub const rscaleIsSupported = i_cal_recurrence_rscale_is_supported;

    /// Gets an array of calendars supporting rscale (currently always return NULL).
    extern fn i_cal_recurrence_rscale_supported_calendars() *icalglib.Array;
    pub const rscaleSupportedCalendars = i_cal_recurrence_rscale_supported_calendars;

    /// Converts a string representation to an enum representation for the skip.
    extern fn i_cal_recurrence_skip_from_string(p_str: [*:0]const u8) icalglib.RecurrenceSkip;
    pub const skipFromString = i_cal_recurrence_skip_from_string;

    /// Converts a enum representation to a string representation for the skip.
    extern fn i_cal_recurrence_skip_to_string(p_kind: icalglib.RecurrenceSkip) [*:0]const u8;
    pub const skipToString = i_cal_recurrence_skip_to_string;

    /// Converts a string representation to an enum representation for the weekday.
    extern fn i_cal_recurrence_weekday_from_string(p_str: [*:0]const u8) icalglib.RecurrenceWeekday;
    pub const weekdayFromString = i_cal_recurrence_weekday_from_string;

    /// Converts a enum representation to a string representation for the weekday.
    extern fn i_cal_recurrence_weekday_to_string(p_kind: icalglib.RecurrenceWeekday) [*:0]const u8;
    pub const weekdayToString = i_cal_recurrence_weekday_to_string;

    /// Creates a new `ICalRecurrence`.
    extern fn i_cal_recurrence_new() *icalglib.Recurrence;
    pub const new = i_cal_recurrence_new;

    /// Converts a string to a `ICalRecurrence`.
    extern fn i_cal_recurrence_new_from_string(p_str: [*:0]const u8) *icalglib.Recurrence;
    pub const newFromString = i_cal_recurrence_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_recurrence_new_full(p_native: ?*anyopaque) *icalglib.Recurrence;
    pub const newFull = i_cal_recurrence_new_full;

    /// Resets an `ICalRecurrence`.
    extern fn i_cal_recurrence_clear(p_r: *Recurrence) void;
    pub const clear = i_cal_recurrence_clear;

    /// Gets the by_day value at index `index`. The index should be less than `I_CAL_BY_DAY_SIZE`.
    extern fn i_cal_recurrence_get_by_day(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByDay = i_cal_recurrence_get_by_day;

    /// Gets the by_day array from `ICalRecurrence`. The array size is I_CAL_BY_DAY_SIZE.
    extern fn i_cal_recurrence_get_by_day_array(p_recur: *Recurrence) *glib.Array;
    pub const getByDayArray = i_cal_recurrence_get_by_day_array;

    /// Gets the by_hour value at index `index`. The index should be less than `I_CAL_BY_HOUR_SIZE`.
    extern fn i_cal_recurrence_get_by_hour(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByHour = i_cal_recurrence_get_by_hour;

    /// Gets the by_hour array from `ICalRecurrence`. The array size is I_CAL_BY_HOUR_SIZE.
    extern fn i_cal_recurrence_get_by_hour_array(p_recur: *Recurrence) *glib.Array;
    pub const getByHourArray = i_cal_recurrence_get_by_hour_array;

    /// Gets the by_minute value at index `index`. The index should be less than `I_CAL_BY_MINUTE_SIZE`.
    extern fn i_cal_recurrence_get_by_minute(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByMinute = i_cal_recurrence_get_by_minute;

    /// Gets the by_minute array from `ICalRecurrence`. The array size is I_CAL_BY_MINUTE_SIZE.
    extern fn i_cal_recurrence_get_by_minute_array(p_recur: *Recurrence) *glib.Array;
    pub const getByMinuteArray = i_cal_recurrence_get_by_minute_array;

    /// Gets the by_month value at index `index`. The index should be less than `I_CAL_BY_MONTH_SIZE`.
    extern fn i_cal_recurrence_get_by_month(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByMonth = i_cal_recurrence_get_by_month;

    /// Gets the by_month array from `ICalRecurrence`. The array size is I_CAL_BY_MONTH_SIZE.
    extern fn i_cal_recurrence_get_by_month_array(p_recur: *Recurrence) *glib.Array;
    pub const getByMonthArray = i_cal_recurrence_get_by_month_array;

    /// Gets the by_month_day value at index `index`. The index should be less than `I_CAL_BY_MONTHDAY_SIZE`.
    extern fn i_cal_recurrence_get_by_month_day(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByMonthDay = i_cal_recurrence_get_by_month_day;

    /// Gets the by_month_day array from `ICalRecurrence`. The array size is I_CAL_BY_MONTHDAY_SIZE.
    extern fn i_cal_recurrence_get_by_month_day_array(p_recur: *Recurrence) *glib.Array;
    pub const getByMonthDayArray = i_cal_recurrence_get_by_month_day_array;

    /// Gets the by_second value at index `index`. The index should be less than `I_CAL_BY_SECOND_SIZE`.
    extern fn i_cal_recurrence_get_by_second(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getBySecond = i_cal_recurrence_get_by_second;

    /// Gets the by_second array from `ICalRecurrence`. The array size if I_CAL_BY_SECOND_SIZE.
    extern fn i_cal_recurrence_get_by_second_array(p_recur: *Recurrence) *glib.Array;
    pub const getBySecondArray = i_cal_recurrence_get_by_second_array;

    /// Gets the by_set_pos value at index `index`. The index should be less than `I_CAL_BY_SETPOS_SIZE`.
    extern fn i_cal_recurrence_get_by_set_pos(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getBySetPos = i_cal_recurrence_get_by_set_pos;

    /// Gets the by_set_pos array from `ICalRecurrence`. The array size is I_CAL_BY_SETPOS_SIZE.
    extern fn i_cal_recurrence_get_by_set_pos_array(p_recur: *Recurrence) *glib.Array;
    pub const getBySetPosArray = i_cal_recurrence_get_by_set_pos_array;

    /// Gets the by_week_no value at index `index`. The index should be less than `I_CAL_BY_WEEKNO_SIZE`.
    extern fn i_cal_recurrence_get_by_week_no(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByWeekNo = i_cal_recurrence_get_by_week_no;

    /// Gets the by_week_no array from `ICalRecurrence`. The array size is I_CAL_BY_WEEKNO_SIZE.
    extern fn i_cal_recurrence_get_by_week_no_array(p_recur: *Recurrence) *glib.Array;
    pub const getByWeekNoArray = i_cal_recurrence_get_by_week_no_array;

    /// Gets the by_year_day value at index `index`. The index should be less than `I_CAL_BY_YEARDAY_SIZE`.
    extern fn i_cal_recurrence_get_by_year_day(p_recur: *Recurrence, p_index: c_uint) c_short;
    pub const getByYearDay = i_cal_recurrence_get_by_year_day;

    /// Gets the by_year_day array from `ICalRecurrence`. The array size is I_CAL_BY_YEARDAY_SIZE.
    extern fn i_cal_recurrence_get_by_year_day_array(p_recur: *Recurrence) *glib.Array;
    pub const getByYearDayArray = i_cal_recurrence_get_by_year_day_array;

    /// Gets the count from `ICalRecurrence`.
    extern fn i_cal_recurrence_get_count(p_recur: *Recurrence) c_int;
    pub const getCount = i_cal_recurrence_get_count;

    /// Gets the freq from `ICalRecurrence`.
    extern fn i_cal_recurrence_get_freq(p_recur: *Recurrence) icalglib.RecurrenceFrequency;
    pub const getFreq = i_cal_recurrence_get_freq;

    /// Gets the interval from `ICalRecurrence`.
    extern fn i_cal_recurrence_get_interval(p_recur: *Recurrence) c_short;
    pub const getInterval = i_cal_recurrence_get_interval;

    /// Gets the until from `ICalRecurrence`.
    extern fn i_cal_recurrence_get_until(p_recur: *Recurrence) *icalglib.Time;
    pub const getUntil = i_cal_recurrence_get_until;

    /// Gets the week_start from `ICalRecurrence`.
    extern fn i_cal_recurrence_get_week_start(p_recur: *Recurrence) icalglib.RecurrenceWeekday;
    pub const getWeekStart = i_cal_recurrence_get_week_start;

    /// Sets the by_day array from `ICalRecurrence` at the given index. The array size if I_CAL_BY_DAY_SIZE.
    extern fn i_cal_recurrence_set_by_day(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByDay = i_cal_recurrence_set_by_day;

    /// Sets the by_day array in `recur` at once. The array size can be less than I_CAL_BY_DAY_SIZE. Shorter arrays
    /// are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_day_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByDayArray = i_cal_recurrence_set_by_day_array;

    /// Sets the by_hour array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_HOUR_SIZE.
    extern fn i_cal_recurrence_set_by_hour(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByHour = i_cal_recurrence_set_by_hour;

    /// Sets the by_hour array in `recur` at once. The array size can be less than I_CAL_BY_HOUR_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_hour_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByHourArray = i_cal_recurrence_set_by_hour_array;

    /// Sets the by_minute array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_MINUTE_SIZE.
    extern fn i_cal_recurrence_set_by_minute(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByMinute = i_cal_recurrence_set_by_minute;

    /// Sets the by_minute array in `recur` at once. The array size can be less than I_CAL_BY_MINUTE_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_minute_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByMinuteArray = i_cal_recurrence_set_by_minute_array;

    /// Sets the by_month array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_MONTH_SIZE.
    extern fn i_cal_recurrence_set_by_month(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByMonth = i_cal_recurrence_set_by_month;

    /// Sets the by_month array in `recur` at once. The array size can be less than I_CAL_BY_MONTH_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_month_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByMonthArray = i_cal_recurrence_set_by_month_array;

    /// Sets the by_month_day array from `ICalRecurrence` at the given index. The array size if I_CAL_BY_MONTHDAY_SIZE.
    extern fn i_cal_recurrence_set_by_month_day(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByMonthDay = i_cal_recurrence_set_by_month_day;

    /// Sets the by_month_day array in `recur` at once. The array size can be less than I_CAL_BY_MONTHDAY_SIZE.
    /// Shorter arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_month_day_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByMonthDayArray = i_cal_recurrence_set_by_month_day_array;

    /// Sets the by_second array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_SECOND_SIZE.
    extern fn i_cal_recurrence_set_by_second(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setBySecond = i_cal_recurrence_set_by_second;

    /// Sets the by_second array in `recur` at once. The array size can be less than I_CAL_BY_SECOND_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_second_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setBySecondArray = i_cal_recurrence_set_by_second_array;

    /// Sets the by_set_pos array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_SETPOS_SIZE.
    extern fn i_cal_recurrence_set_by_set_pos(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setBySetPos = i_cal_recurrence_set_by_set_pos;

    /// Sets the by_set_pos array in `recur` at once. The array size can be less than I_CAL_BY_SETPOS_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_set_pos_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setBySetPosArray = i_cal_recurrence_set_by_set_pos_array;

    /// Sets the by_week_no array from `ICalRecurrence` at the given index. The array size is I_CAL_BY_WEEKNO_SIZE.
    extern fn i_cal_recurrence_set_by_week_no(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByWeekNo = i_cal_recurrence_set_by_week_no;

    /// Sets the by_week_no array in `recur` at once. The array size can be less than I_CAL_BY_WEEKNO_SIZE. Shorter
    /// arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_week_no_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByWeekNoArray = i_cal_recurrence_set_by_week_no_array;

    /// Sets the by_year_day array from `ICalRecurrence` at the given index. The array size if I_CAL_BY_YEARDAY_SIZE.
    extern fn i_cal_recurrence_set_by_year_day(p_recur: *Recurrence, p_index: c_uint, p_value: c_short) void;
    pub const setByYearDay = i_cal_recurrence_set_by_year_day;

    /// Sets the by_year_day array in `recur` at once. The array size can be less than I_CAL_BY_YEARDAY_SIZE.
    /// Shorter arrays are terminated with I_CAL_RECURRENCE_ARRAY_MAX value, longer arrays are truncated.
    extern fn i_cal_recurrence_set_by_year_day_array(p_recur: *Recurrence, p_values: *glib.Array) void;
    pub const setByYearDayArray = i_cal_recurrence_set_by_year_day_array;

    /// Sets the count from `ICalRecurrence`.
    extern fn i_cal_recurrence_set_count(p_recur: *Recurrence, p_count: c_int) void;
    pub const setCount = i_cal_recurrence_set_count;

    /// Sets the freq from `ICalRecurrence`.
    extern fn i_cal_recurrence_set_freq(p_recur: *Recurrence, p_freq: icalglib.RecurrenceFrequency) void;
    pub const setFreq = i_cal_recurrence_set_freq;

    /// Sets the interval from `ICalRecurrence`.
    extern fn i_cal_recurrence_set_interval(p_recur: *Recurrence, p_interval: c_short) void;
    pub const setInterval = i_cal_recurrence_set_interval;

    /// Sets the until from `ICalRecurrence`.
    extern fn i_cal_recurrence_set_until(p_recur: *Recurrence, p_until: *icalglib.Time) void;
    pub const setUntil = i_cal_recurrence_set_until;

    /// Sets the week_start from `ICalRecurrence`.
    extern fn i_cal_recurrence_set_week_start(p_recur: *Recurrence, p_week_start: icalglib.RecurrenceWeekday) void;
    pub const setWeekStart = i_cal_recurrence_set_week_start;

    /// Converts a `ICalRecurrence` to a string.
    extern fn i_cal_recurrence_to_string(p_recur: *Recurrence) [*:0]u8;
    pub const toString = i_cal_recurrence_to_string;

    extern fn i_cal_recurrence_get_type() usize;
    pub const getGObjectType = i_cal_recurrence_get_type;

    extern fn g_object_ref(p_self: *icalglib.Recurrence) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Recurrence) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Recurrence, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalReqstat instance.
pub const Reqstat = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ReqstatClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new default `ICalReqstat`.
    extern fn i_cal_reqstat_new_default() ?*anyopaque;
    pub const newDefault = i_cal_reqstat_new_default;

    /// Creates a `ICalReqstat` from string.
    extern fn i_cal_reqstat_new_from_string(p_str: [*:0]const u8) *icalglib.Reqstat;
    pub const newFromString = i_cal_reqstat_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_reqstat_new_full(p_native: ?*anyopaque) *icalglib.Reqstat;
    pub const newFull = i_cal_reqstat_new_full;

    /// Gets the code of `ICalReqstat`.
    extern fn i_cal_reqstat_get_code(p_reqstat: *Reqstat) icalglib.RequestStatus;
    pub const getCode = i_cal_reqstat_get_code;

    /// Gets the debug of `ICalReqstat`.
    extern fn i_cal_reqstat_get_debug(p_reqstat: *const Reqstat) [*:0]const u8;
    pub const getDebug = i_cal_reqstat_get_debug;

    /// Gets the desc of `ICalReqstat`.
    extern fn i_cal_reqstat_get_desc(p_reqstat: *const Reqstat) [*:0]const u8;
    pub const getDesc = i_cal_reqstat_get_desc;

    /// Sets the code of `ICalReqstat`.
    extern fn i_cal_reqstat_set_code(p_reqstat: *Reqstat, p_code: icalglib.RequestStatus) void;
    pub const setCode = i_cal_reqstat_set_code;

    /// Converts `ICalReqstat` to a string representation.
    extern fn i_cal_reqstat_to_string(p_stat: *Reqstat) [*:0]u8;
    pub const toString = i_cal_reqstat_to_string;

    extern fn i_cal_reqstat_get_type() usize;
    pub const getGObjectType = i_cal_reqstat_get_type;

    extern fn g_object_ref(p_self: *icalglib.Reqstat) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Reqstat) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Reqstat, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTime instance.
pub const Time = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.TimeClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the number of days in the target month in the target year.
    extern fn i_cal_time_days_in_month(p_month: c_int, p_year: c_int) c_int;
    pub const daysInMonth = i_cal_time_days_in_month;

    /// Returns the number of days in this year.
    extern fn i_cal_time_days_in_year(p_year: c_int) c_int;
    pub const daysInYear = i_cal_time_days_in_year;

    /// Checks whether a year is a leap year.
    extern fn i_cal_time_days_is_leap_year(p_year: c_int) c_int;
    pub const daysIsLeapYear = i_cal_time_days_is_leap_year;

    /// Applies a list of timezone changes on the array of components until the end year.
    extern fn i_cal_time_timezone_expand_vtimezone(p_comp: *icalglib.Component, p_end_year: c_int, p_changes: *icalglib.Array) void;
    pub const timezoneExpandVtimezone = i_cal_time_timezone_expand_vtimezone;

    /// Creates a new `ICalTime`.
    extern fn i_cal_time_new() *icalglib.Time;
    pub const new = i_cal_time_new;

    /// Creates a `ICalTime` according to the timezone and current time.
    extern fn i_cal_time_new_current_with_zone(p_zone: ?*icalglib.Timezone) *icalglib.Time;
    pub const newCurrentWithZone = i_cal_time_new_current_with_zone;

    /// Creates a new time, given a day of year and a year.
    extern fn i_cal_time_new_from_day_of_year(p_day: c_int, p_year: c_int) *icalglib.Time;
    pub const newFromDayOfYear = i_cal_time_new_from_day_of_year;

    /// Creates a time from an ISO format string.
    extern fn i_cal_time_new_from_string(p_str: [*:0]const u8) *icalglib.Time;
    pub const newFromString = i_cal_time_new_from_string;

    /// Converts seconds past UNIX epoch to a timetype, using timezones.
    extern fn i_cal_time_new_from_timet_with_zone(p_v: std.posix.time_t, p_is_date: c_int, p_zone: ?*icalglib.Timezone) *icalglib.Time;
    pub const newFromTimetWithZone = i_cal_time_new_from_timet_with_zone;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_time_new_full(p_native: ?*anyopaque) *icalglib.Time;
    pub const newFull = i_cal_time_new_full;

    /// Creates a null date, which indicates no time has been set.
    extern fn i_cal_time_new_null_date() *icalglib.Time;
    pub const newNullDate = i_cal_time_new_null_date;

    /// Creates a default time which is an epoch time.
    extern fn i_cal_time_new_null_time() *icalglib.Time;
    pub const newNullTime = i_cal_time_new_null_time;

    /// Creates a `ICalTime` representing today.
    extern fn i_cal_time_new_today() *icalglib.Time;
    pub const newToday = i_cal_time_new_today;

    /// Adds a time duration on the time.
    extern fn i_cal_time_add(p_t: *Time, p_d: *icalglib.Duration) *icalglib.Time;
    pub const add = i_cal_time_add;

    /// Adds or subtracts a number of days, hours, minutes and seconds from `tt`.
    extern fn i_cal_time_adjust(p_tt: *Time, p_days: c_int, p_hours: c_int, p_minutes: c_int, p_seconds: c_int) void;
    pub const adjust = i_cal_time_adjust;

    /// Returns a string representation of the time, in RFC2445 format.
    extern fn i_cal_time_as_ical_string(p_tt: *const Time) [*:0]u8;
    pub const asIcalString = i_cal_time_as_ical_string;

    /// Returns the time as seconds past the UNIX epoch.
    extern fn i_cal_time_as_timet(p_tt: *const Time) std.posix.time_t;
    pub const asTimet = i_cal_time_as_timet;

    /// Returns the time as seconds past the UNIX epoch, using timezones.
    extern fn i_cal_time_as_timet_with_zone(p_tt: *const Time, p_zone: ?*const icalglib.Timezone) std.posix.time_t;
    pub const asTimetWithZone = i_cal_time_as_timet_with_zone;

    /// Creates a new `ICalTime`, copy of `timetype`.
    extern fn i_cal_time_clone(p_timetype: *const Time) *icalglib.Time;
    pub const clone = i_cal_time_clone;

    /// i_cal_time_compare returns an integer indicating the result of the comparison, as follow:
    extern fn i_cal_time_compare(p_a: *const Time, p_b: *const icalglib.Time) c_int;
    pub const compare = i_cal_time_compare;

    /// Like `icalglib.Time.compare`, but only use the date parts.
    extern fn i_cal_time_compare_date_only(p_a: *const Time, p_b: *const icalglib.Time) c_int;
    pub const compareDateOnly = i_cal_time_compare_date_only;

    /// Like `i_cal_time_compare_tz`, but only use the date parts; accepts timezone.
    extern fn i_cal_time_compare_date_only_tz(p_a: *const Time, p_b: *const icalglib.Time, p_zone: ?*icalglib.Timezone) c_int;
    pub const compareDateOnlyTz = i_cal_time_compare_date_only_tz;

    /// Convert time from one timezone to another.
    extern fn i_cal_time_convert_timezone(p_tt: *Time, p_from_zone: ?*icalglib.Timezone, p_to_zone: ?*icalglib.Timezone) void;
    pub const convertTimezone = i_cal_time_convert_timezone;

    /// Converts `tt` to `zone` and return new `ICalTime` object.
    extern fn i_cal_time_convert_to_zone(p_tt: *const Time, p_zone: ?*icalglib.Timezone) *icalglib.Time;
    pub const convertToZone = i_cal_time_convert_to_zone;

    /// Converts `tt` to `zone` and store the result into `tt`.
    extern fn i_cal_time_convert_to_zone_inplace(p_tt: *Time, p_zone: ?*icalglib.Timezone) void;
    pub const convertToZoneInplace = i_cal_time_convert_to_zone_inplace;

    /// Returns the day of the week of the given time. Sunday is 1.
    extern fn i_cal_time_day_of_week(p_tt: *const Time) c_int;
    pub const dayOfWeek = i_cal_time_day_of_week;

    /// Returns the day of the year of the given time.
    extern fn i_cal_time_day_of_year(p_tt: *const Time) c_int;
    pub const dayOfYear = i_cal_time_day_of_year;

    /// Gets the year/month/date parts of the `timetype` in one call.
    extern fn i_cal_time_get_date(p_timetype: *const Time, p_year: ?*c_int, p_month: ?*c_int, p_day: ?*c_int) void;
    pub const getDate = i_cal_time_get_date;

    /// Gets the day of `ICalTime`.
    extern fn i_cal_time_get_day(p_timetype: *const Time) c_int;
    pub const getDay = i_cal_time_get_day;

    /// Gets the hour of `ICalTime`.
    extern fn i_cal_time_get_hour(p_timetype: *const Time) c_int;
    pub const getHour = i_cal_time_get_hour;

    /// Gets the minute of `ICalTime`.
    extern fn i_cal_time_get_minute(p_timetype: *const Time) c_int;
    pub const getMinute = i_cal_time_get_minute;

    /// Gets the month of `ICalTime`.
    extern fn i_cal_time_get_month(p_timetype: *const Time) c_int;
    pub const getMonth = i_cal_time_get_month;

    /// Gets the second of `ICalTime`.
    extern fn i_cal_time_get_second(p_timetype: *const Time) c_int;
    pub const getSecond = i_cal_time_get_second;

    /// Gets the hour/minute/second parts of the `timetype` in one call.
    extern fn i_cal_time_get_time(p_timetype: *const Time, p_hour: ?*c_int, p_minute: ?*c_int, p_second: ?*c_int) void;
    pub const getTime = i_cal_time_get_time;

    /// Returns the timezone, the `ICalTimezone` object is cached and can be either unreferenced once the last
    /// instance is used or can be kept until `icalglib.Object.freeGlobalObjects` is called (usually at the very
    /// end of the program).
    extern fn i_cal_time_get_timezone(p_tt: *const Time) *icalglib.Timezone;
    pub const getTimezone = i_cal_time_get_timezone;

    /// Returns the tzid, or NULL for a floating time.
    extern fn i_cal_time_get_tzid(p_tt: *const Time) ?[*:0]const u8;
    pub const getTzid = i_cal_time_get_tzid;

    /// Gets the year of `ICalTime`.
    extern fn i_cal_time_get_year(p_timetype: *const Time) c_int;
    pub const getYear = i_cal_time_get_year;

    /// Returns true if time is of DATE type, false if DATE-TIME.
    extern fn i_cal_time_is_date(p_tt: *const Time) c_int;
    pub const isDate = i_cal_time_is_date;

    /// Gets the is_daylight of `ICalTime`.
    extern fn i_cal_time_is_daylight(p_timetype: *const Time) c_int;
    pub const isDaylight = i_cal_time_is_daylight;

    /// Returns true if the time is null.
    extern fn i_cal_time_is_null_time(p_tt: *const Time) c_int;
    pub const isNullTime = i_cal_time_is_null_time;

    /// Returns true if time is relative to UTC zone.
    extern fn i_cal_time_is_utc(p_tt: *const Time) c_int;
    pub const isUtc = i_cal_time_is_utc;

    /// Returns true if the time is null.
    extern fn i_cal_time_is_valid_time(p_tt: *const Time) c_int;
    pub const isValidTime = i_cal_time_is_valid_time;

    /// Normalizes the icaltime, so that all fields are within the normal range.
    extern fn i_cal_time_normalize(p_t: *const Time) *icalglib.Time;
    pub const normalize = i_cal_time_normalize;

    /// Normalizes the `tt`, so that all fields are within the normal range.
    extern fn i_cal_time_normalize_inplace(p_tt: *Time) void;
    pub const normalizeInplace = i_cal_time_normalize_inplace;

    /// Sets the year/month/date parts of the `timetype` in one call. This doesn't verify validity of the given
    /// date.
    extern fn i_cal_time_set_date(p_timetype: *Time, p_year: c_int, p_month: c_int, p_day: c_int) void;
    pub const setDate = i_cal_time_set_date;

    /// Sets the day of `ICalTime`.
    extern fn i_cal_time_set_day(p_timetype: *Time, p_day: c_int) void;
    pub const setDay = i_cal_time_set_day;

    /// Sets the hour of `ICalTime`.
    extern fn i_cal_time_set_hour(p_timetype: *Time, p_hour: c_int) void;
    pub const setHour = i_cal_time_set_hour;

    /// Sets the is_date of `ICalTime`.
    extern fn i_cal_time_set_is_date(p_timetype: *Time, p_is_date: c_int) void;
    pub const setIsDate = i_cal_time_set_is_date;

    /// Sets the is_daylight of `ICalTime`.
    extern fn i_cal_time_set_is_daylight(p_timetype: *Time, p_is_daylight: c_int) void;
    pub const setIsDaylight = i_cal_time_set_is_daylight;

    /// Sets the minute of `ICalTime`.
    extern fn i_cal_time_set_minute(p_timetype: *Time, p_minute: c_int) void;
    pub const setMinute = i_cal_time_set_minute;

    /// Sets the month of `ICalTime`.
    extern fn i_cal_time_set_month(p_timetype: *Time, p_month: c_int) void;
    pub const setMonth = i_cal_time_set_month;

    /// Sets the second of `ICalTime`.
    extern fn i_cal_time_set_second(p_timetype: *Time, p_second: c_int) void;
    pub const setSecond = i_cal_time_set_second;

    /// Sets the hour/minute/second parts of the `timetype` in one call. This doesn't verify validity of the given
    /// time.
    extern fn i_cal_time_set_time(p_timetype: *Time, p_hour: c_int, p_minute: c_int, p_second: c_int) void;
    pub const setTime = i_cal_time_set_time;

    /// Sets the timezone of the `tt`.
    extern fn i_cal_time_set_timezone(p_tt: *Time, p_zone: ?*const icalglib.Timezone) void;
    pub const setTimezone = i_cal_time_set_timezone;

    /// Sets the year of `ICalTime`.
    extern fn i_cal_time_set_year(p_timetype: *Time, p_year: c_int) void;
    pub const setYear = i_cal_time_set_year;

    /// Returns the day of the year for the first day of the week that the given time is within.
    extern fn i_cal_time_start_doy_week(p_tt: *const Time, p_fdow: c_int) c_int;
    pub const startDoyWeek = i_cal_time_start_doy_week;

    /// Gets the duration between two time.
    extern fn i_cal_time_subtract(p_t1: *Time, p_t2: *icalglib.Time) *icalglib.Duration;
    pub const subtract = i_cal_time_subtract;

    /// Returns the week number for the week the given time is within.
    extern fn i_cal_time_week_number(p_tt: *const Time) c_int;
    pub const weekNumber = i_cal_time_week_number;

    extern fn i_cal_time_get_type() usize;
    pub const getGObjectType = i_cal_time_get_type;

    extern fn g_object_ref(p_self: *icalglib.Time) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Time) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Time, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTimeSpan instance.
pub const TimeSpan = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.TimeSpanClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `ICalTimeSpan`.
    extern fn i_cal_time_span_new(p_dtstart: *icalglib.Time, p_dtend: *icalglib.Time, p_is_busy: c_int) *icalglib.TimeSpan;
    pub const new = i_cal_time_span_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_time_span_new_full(p_native: ?*anyopaque) *icalglib.TimeSpan;
    pub const newFull = i_cal_time_span_new_full;

    /// Creates a new `ICalTimeSpan`. Free it with `gobject.Object.unref`, when no longer needed.
    extern fn i_cal_time_span_new_timet(p_start: std.posix.time_t, p_end: std.posix.time_t, p_is_busy: c_int) *icalglib.TimeSpan;
    pub const newTimet = i_cal_time_span_new_timet;

    /// Creates a new `ICalTimeSpan`, clone of `src`. Free it with `gobject.Object.unref`, when no longer needed.
    extern fn i_cal_time_span_clone(p_src: *const TimeSpan) *icalglib.TimeSpan;
    pub const clone = i_cal_time_span_clone;

    /// Checks whether one `ICalTimeSpan` is contained in another `ICalTimeSpan`.
    extern fn i_cal_time_span_contains(p_s: *TimeSpan, p_container: *icalglib.TimeSpan) c_int;
    pub const contains = i_cal_time_span_contains;

    /// Gets the end of `ICalTimeSpan`.
    extern fn i_cal_time_span_get_end(p_timespan: *TimeSpan) std.posix.time_t;
    pub const getEnd = i_cal_time_span_get_end;

    /// Gets the is_busy of `ICalTimeSpan`.
    extern fn i_cal_time_span_get_is_busy(p_timespan: *TimeSpan) c_int;
    pub const getIsBusy = i_cal_time_span_get_is_busy;

    /// Gets the start of `ICalTimeSpan`.
    extern fn i_cal_time_span_get_start(p_timespan: *TimeSpan) std.posix.time_t;
    pub const getStart = i_cal_time_span_get_start;

    /// Checks whether two spans overlap.
    extern fn i_cal_time_span_overlaps(p_s1: *TimeSpan, p_s2: *icalglib.TimeSpan) c_int;
    pub const overlaps = i_cal_time_span_overlaps;

    /// Sets the end of `ICalTimeSpan`.
    extern fn i_cal_time_span_set_end(p_timespan: *TimeSpan, p_end: std.posix.time_t) void;
    pub const setEnd = i_cal_time_span_set_end;

    /// Sets the is_busy of `ICalTimeSpan`.
    extern fn i_cal_time_span_set_is_busy(p_timespan: *TimeSpan, p_is_busy: c_int) void;
    pub const setIsBusy = i_cal_time_span_set_is_busy;

    /// Sets the start of `ICalTimeSpan`.
    extern fn i_cal_time_span_set_start(p_timespan: *TimeSpan, p_start: std.posix.time_t) void;
    pub const setStart = i_cal_time_span_set_start;

    extern fn i_cal_time_span_get_type() usize;
    pub const getGObjectType = i_cal_time_span_get_type;

    extern fn g_object_ref(p_self: *icalglib.TimeSpan) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.TimeSpan) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TimeSpan, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTimezone instance.
pub const Timezone = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.TimezoneClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Populate the array of timezones with a component.
    ///
    /// `note` The `timezones` assumes ownership of the
    /// `child`, thus make sure you pass an unowned `ICalComponent`.
    extern fn i_cal_timezone_array_append_from_vtimezone(p_timezones: *icalglib.Array, p_child: *icalglib.Component) void;
    pub const arrayAppendFromVtimezone = i_cal_timezone_array_append_from_vtimezone;

    /// The destructor of the icalarray of icaltimezone elements to fully destroy the native object.
    extern fn i_cal_timezone_array_destroy(p_zones_array: ?*anyopaque) void;
    pub const arrayDestroy = i_cal_timezone_array_destroy;

    /// Gets the `ICalTimezone` at specified position in array.
    extern fn i_cal_timezone_array_element_at(p_timezones: *icalglib.Array, p_index: c_uint) *icalglib.Timezone;
    pub const arrayElementAt = i_cal_timezone_array_element_at;

    /// Frees an array of timezones.
    extern fn i_cal_timezone_array_free(p_timezones: *icalglib.Array) void;
    pub const arrayFree = i_cal_timezone_array_free;

    /// The destructor of the type `ICalTimezone` to fully destroy the object by providing 1 as the second argument
    /// of i_cal_time_zone_free. The method is used as a default destructor for introspection.
    extern fn i_cal_timezone_destroy(p_zone: *anyopaque) void;
    pub const destroy = i_cal_timezone_destroy;

    /// Frees any builtin timezone information.
    extern fn i_cal_timezone_free_builtin_timezones() void;
    pub const freeBuiltinTimezones = i_cal_timezone_free_builtin_timezones;

    /// Frees memory dedicated to the zonefile directory.
    extern fn i_cal_timezone_free_zone_directory() void;
    pub const freeZoneDirectory = i_cal_timezone_free_zone_directory;

    /// Returns a single builtin timezone, given its Olson city name.
    extern fn i_cal_timezone_get_builtin_timezone(p_location: ?[*:0]const u8) ?*icalglib.Timezone;
    pub const getBuiltinTimezone = i_cal_timezone_get_builtin_timezone;

    /// Returns a single builtin timezone, given its offset.
    extern fn i_cal_timezone_get_builtin_timezone_from_offset(p_offset: c_int, p_tzname: ?[*:0]const u8) *icalglib.Timezone;
    pub const getBuiltinTimezoneFromOffset = i_cal_timezone_get_builtin_timezone_from_offset;

    /// Returns a single builtin timezone, given its TZID.
    extern fn i_cal_timezone_get_builtin_timezone_from_tzid(p_tzid: ?[*:0]const u8) *icalglib.Timezone;
    pub const getBuiltinTimezoneFromTzid = i_cal_timezone_get_builtin_timezone_from_tzid;

    /// Returns a list of builtin timezones.
    extern fn i_cal_timezone_get_builtin_timezones() *icalglib.Array;
    pub const getBuiltinTimezones = i_cal_timezone_get_builtin_timezones;

    /// Gets whether to use builtin timezones files.
    extern fn i_cal_timezone_get_builtin_tzdata() c_int;
    pub const getBuiltinTzdata = i_cal_timezone_get_builtin_tzdata;

    /// Gets the location of the vtimezone in component.
    extern fn i_cal_timezone_get_location_from_vtimezone(p_component: *icalglib.Component) [*:0]u8;
    pub const getLocationFromVtimezone = i_cal_timezone_get_location_from_vtimezone;

    /// Gets the name of the vtimezone in component.
    extern fn i_cal_timezone_get_tznames_from_vtimezone(p_component: *icalglib.Component) [*:0]u8;
    pub const getTznamesFromVtimezone = i_cal_timezone_get_tznames_from_vtimezone;

    /// Returns the UTC timezone.
    extern fn i_cal_timezone_get_utc_timezone() *icalglib.Timezone;
    pub const getUtcTimezone = i_cal_timezone_get_utc_timezone;

    /// Gets the directory to look for the zonefiles.
    extern fn i_cal_timezone_get_zone_directory() [*:0]const u8;
    pub const getZoneDirectory = i_cal_timezone_get_zone_directory;

    /// Frees memory dedicated to the zonefile directory.
    extern fn i_cal_timezone_release_zone_tab() void;
    pub const releaseZoneTab = i_cal_timezone_release_zone_tab;

    /// Sets whether to use builtin timezones files.
    extern fn i_cal_timezone_set_builtin_tzdata(p_set: c_int) void;
    pub const setBuiltinTzdata = i_cal_timezone_set_builtin_tzdata;

    /// Sets the prefix to be used for tzid's generated from system tzdata. Must be globally unique (such as
    /// a domain name owned by the developer of the calling application), and begin and end with forward slashes.
    /// Do not change or de-allocate the string buffer after calling this.
    extern fn i_cal_timezone_set_tzid_prefix(p_new_prefix: [*:0]const u8) void;
    pub const setTzidPrefix = i_cal_timezone_set_tzid_prefix;

    /// Sets the directory to look for the zonefiles.
    extern fn i_cal_timezone_set_zone_directory(p_path: [*:0]const u8) void;
    pub const setZoneDirectory = i_cal_timezone_set_zone_directory;

    /// Creates a new array of timezones.
    extern fn i_cal_timezone_array_new() *icalglib.Timezone;
    pub const arrayNew = i_cal_timezone_array_new;

    /// The constructor of the type `ICalTimezone`.
    extern fn i_cal_timezone_new() ?*icalglib.Timezone;
    pub const new = i_cal_timezone_new;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_timezone_new_full(p_native: *anyopaque, p_owner: *gobject.Object, p_is_global_memory: c_int) *icalglib.Timezone;
    pub const newFull = i_cal_timezone_new_full;

    /// The clone method for `ICalTimezone`.
    extern fn i_cal_timezone_copy(p_zone: *const Timezone) *icalglib.Timezone;
    pub const copy = i_cal_timezone_copy;

    /// Outputs a list of timezone changes for the given timezone to the given file, up to the maximum year given.
    extern fn i_cal_timezone_dump_changes(p_zone: *Timezone, p_max_year: c_int, p_fp: ?*anyopaque) c_int;
    pub const dumpChanges = i_cal_timezone_dump_changes;

    /// The destructor of `ICalTimezone`.
    extern fn i_cal_timezone_free(p_zone: *Timezone, p_free_struct: c_int) void;
    pub const free = i_cal_timezone_free;

    /// Returns the VTIMEZONE component of a timezone.
    extern fn i_cal_timezone_get_component(p_zone: ?*const Timezone) *icalglib.Component;
    pub const getComponent = i_cal_timezone_get_component;

    /// Gets the display name of the `zone`.
    extern fn i_cal_timezone_get_display_name(p_zone: ?*const Timezone) [*:0]const u8;
    pub const getDisplayName = i_cal_timezone_get_display_name;

    /// Returns the latitude of a builtin timezone.
    extern fn i_cal_timezone_get_latitude(p_zone: ?*const Timezone) f64;
    pub const getLatitude = i_cal_timezone_get_latitude;

    /// Returns the city name of a timezone, or `NULL`, when none is set or when `zone` is also `NULL`.
    extern fn i_cal_timezone_get_location(p_zone: ?*const Timezone) ?[*:0]const u8;
    pub const getLocation = i_cal_timezone_get_location;

    /// Returns the longitude of a builtin timezone.
    extern fn i_cal_timezone_get_longitude(p_zone: ?*const Timezone) f64;
    pub const getLongitude = i_cal_timezone_get_longitude;

    /// Returns the TZID of a timezone, or `NULL`, when none is set or when `zone` is also `NULL`.
    extern fn i_cal_timezone_get_tzid(p_zone: ?*const Timezone) ?[*:0]const u8;
    pub const getTzid = i_cal_timezone_get_tzid;

    /// Returns the TZNAME properties used in the latest STANDARD and DAYLIGHT components. If they are the same
    /// it will return just one, e.g. "LMT". If they are different it will format them like "EST/EDT". Note that
    /// this may also return NULL.
    extern fn i_cal_timezone_get_tznames(p_zone: ?*const Timezone) ?[*:0]const u8;
    pub const getTznames = i_cal_timezone_get_tznames;

    /// Calculates the UTC offset of a given local time in the given timezone.  It is the number of seconds to
    /// add to UTC to get local time.  The is_daylight flag is set to 1 if the time is in daylight-savings time.
    extern fn i_cal_timezone_get_utc_offset(p_zone: ?*Timezone, p_tt: ?*icalglib.Time, p_is_daylight: ?*c_int) c_int;
    pub const getUtcOffset = i_cal_timezone_get_utc_offset;

    /// Calculates the UTC offset of a given UTC time in the given timezone.  It is the number of seconds to
    /// add to UTC to get local time.  The is_daylight flag is set to 1 if the time is in daylight-savings time.
    extern fn i_cal_timezone_get_utc_offset_of_utc_time(p_zone: ?*Timezone, p_tt: *icalglib.Time, p_is_daylight: ?*c_int) c_int;
    pub const getUtcOffsetOfUtcTime = i_cal_timezone_get_utc_offset_of_utc_time;

    /// Sets the VTIMEZONE component of `ICalTimezone`, initializing the tzid, location and tzname fields. It
    /// returns 1 on success or 0 on failure, i.e. no TZID was found.
    ///
    /// `note` The `zone` assumes ownership
    /// of the `comp`, thus make sure you pass an unowned `ICalComponent`.
    extern fn i_cal_timezone_set_component(p_zone: *Timezone, p_comp: *icalglib.Component) c_int;
    pub const setComponent = i_cal_timezone_set_component;

    extern fn i_cal_timezone_get_type() usize;
    pub const getGObjectType = i_cal_timezone_get_type;

    extern fn g_object_ref(p_self: *icalglib.Timezone) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Timezone) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Timezone, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTrigger instance.
pub const Trigger = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.TriggerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `ICalTrigger` from integer.
    extern fn i_cal_trigger_new_from_int(p_reltime: c_int) *icalglib.Trigger;
    pub const newFromInt = i_cal_trigger_new_from_int;

    /// Creates a `ICalTrigger` from a string.
    extern fn i_cal_trigger_new_from_string(p_str: [*:0]const u8) *icalglib.Trigger;
    pub const newFromString = i_cal_trigger_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_trigger_new_full(p_native: ?*anyopaque) *icalglib.Trigger;
    pub const newFull = i_cal_trigger_new_full;

    /// Gets the duration from `ICalTrigger`.
    extern fn i_cal_trigger_get_duration(p_trigger: *Trigger) *icalglib.Duration;
    pub const getDuration = i_cal_trigger_get_duration;

    /// Gets the time from `ICalTrigger`.
    extern fn i_cal_trigger_get_time(p_trigger: *Trigger) *icalglib.Time;
    pub const getTime = i_cal_trigger_get_time;

    /// Checks if a `ICalTrigger` is a bad trigger.
    extern fn i_cal_trigger_is_bad_trigger(p_tr: *Trigger) c_int;
    pub const isBadTrigger = i_cal_trigger_is_bad_trigger;

    /// Checks if a `ICalTrigger` is a null trigger.
    extern fn i_cal_trigger_is_null_trigger(p_tr: *Trigger) c_int;
    pub const isNullTrigger = i_cal_trigger_is_null_trigger;

    /// Sets the duration from `ICalTrigger`.
    extern fn i_cal_trigger_set_duration(p_trigger: *Trigger, p_duration: *icalglib.Duration) void;
    pub const setDuration = i_cal_trigger_set_duration;

    /// Sets the time from `ICalTrigger`.
    extern fn i_cal_trigger_set_time(p_trigger: *Trigger, p_time: *icalglib.Time) void;
    pub const setTime = i_cal_trigger_set_time;

    extern fn i_cal_trigger_get_type() usize;
    pub const getGObjectType = i_cal_trigger_get_type;

    extern fn g_object_ref(p_self: *icalglib.Trigger) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Trigger) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Trigger, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalValue instance.
pub const Value = opaque {
    pub const Parent = icalglib.Object;
    pub const Implements = [_]type{};
    pub const Class = icalglib.ValueClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the original character string encoded by the above function.
    extern fn i_cal_value_decode_ical_string(p_szText: [*:0]const u8) ?[*:0]u8;
    pub const decodeIcalString = i_cal_value_decode_ical_string;

    /// Encodes a character string in ical format, escape certain characters, etc.
    extern fn i_cal_value_encode_ical_string(p_szText: [*:0]const u8) ?[*:0]u8;
    pub const encodeIcalString = i_cal_value_encode_ical_string;

    /// Converts a string to `icalglib.ValueKind`.
    extern fn i_cal_value_kind_from_string(p_str: [*:0]const u8) icalglib.ValueKind;
    pub const kindFromString = i_cal_value_kind_from_string;

    /// Checks whether the `icalglib.ValueKind` is valid.
    extern fn i_cal_value_kind_is_valid(p_kind: icalglib.ValueKind) c_int;
    pub const kindIsValid = i_cal_value_kind_is_valid;

    /// Converts a `icalglib.ValueKind` to a `icalglib.PropertyKind`.
    extern fn i_cal_value_kind_to_property_kind(p_kind: icalglib.ValueKind) icalglib.PropertyKind;
    pub const kindToPropertyKind = i_cal_value_kind_to_property_kind;

    /// Converts the `icalglib.ValueKind` to a string.
    extern fn i_cal_value_kind_to_string(p_kind: icalglib.ValueKind) [*:0]const u8;
    pub const kindToString = i_cal_value_kind_to_string;

    /// Creates a new `ICalValue` with specific kind.
    extern fn i_cal_value_new(p_kind: icalglib.ValueKind) *icalglib.Value;
    pub const new = i_cal_value_new;

    /// Creates a new `ICalValue` with the type action.
    extern fn i_cal_value_new_action(p_v: icalglib.PropertyAction) *icalglib.Value;
    pub const newAction = i_cal_value_new_action;

    /// Creates a new `ICalValue` with the type attach.
    extern fn i_cal_value_new_attach(p_v: *icalglib.Attach) *icalglib.Value;
    pub const newAttach = i_cal_value_new_attach;

    /// Creates a new `ICalValue` with the type binary.
    extern fn i_cal_value_new_binary(p_v: [*:0]const u8) *icalglib.Value;
    pub const newBinary = i_cal_value_new_binary;

    /// Creates a new `ICalValue` with the type boolean.
    extern fn i_cal_value_new_boolean(p_v: c_int) *icalglib.Value;
    pub const newBoolean = i_cal_value_new_boolean;

    /// Creates a new `ICalValue` with the type busytype.
    extern fn i_cal_value_new_busytype(p_v: icalglib.PropertyBusytype) *icalglib.Value;
    pub const newBusytype = i_cal_value_new_busytype;

    /// Creates a new `ICalValue` with the type caladdress.
    extern fn i_cal_value_new_caladdress(p_v: [*:0]const u8) *icalglib.Value;
    pub const newCaladdress = i_cal_value_new_caladdress;

    /// Creates a new `ICalValue` with the type carlevel.
    extern fn i_cal_value_new_carlevel(p_v: icalglib.PropertyCarlevel) *icalglib.Value;
    pub const newCarlevel = i_cal_value_new_carlevel;

    /// Creates a new `ICalValue` with the type class.
    extern fn i_cal_value_new_class(p_v: icalglib.Property_Class) *icalglib.Value;
    pub const newClass = i_cal_value_new_class;

    /// Creates a new `ICalValue` with the type cmd.
    extern fn i_cal_value_new_cmd(p_v: icalglib.PropertyCmd) *icalglib.Value;
    pub const newCmd = i_cal_value_new_cmd;

    /// Creates a new `ICalValue` with the type date.
    extern fn i_cal_value_new_date(p_v: *icalglib.Time) *icalglib.Value;
    pub const newDate = i_cal_value_new_date;

    /// Creates a new `ICalValue` with the type datetime.
    extern fn i_cal_value_new_datetime(p_v: *icalglib.Time) *icalglib.Value;
    pub const newDatetime = i_cal_value_new_datetime;

    /// Creates a new `ICalValue` with the type datetimedate (DATE-TIME or DATE).
    extern fn i_cal_value_new_datetimedate(p_v: *icalglib.Time) *icalglib.Value;
    pub const newDatetimedate = i_cal_value_new_datetimedate;

    /// Creates a new `ICalValue` with the type datetimeperiod.
    extern fn i_cal_value_new_datetimeperiod(p_v: *icalglib.Datetimeperiod) *icalglib.Value;
    pub const newDatetimeperiod = i_cal_value_new_datetimeperiod;

    /// Creates a new `ICalValue` with the type duration.
    extern fn i_cal_value_new_duration(p_v: *icalglib.Duration) *icalglib.Value;
    pub const newDuration = i_cal_value_new_duration;

    /// Creates a new `ICalValue` with the type float.
    extern fn i_cal_value_new_float(p_v: f64) *icalglib.Value;
    pub const newFloat = i_cal_value_new_float;

    /// Creates a new `ICalValue` based on the `icalglib.ValueKind` and a string.
    extern fn i_cal_value_new_from_string(p_kind: icalglib.ValueKind, p_str: [*:0]const u8) *icalglib.Value;
    pub const newFromString = i_cal_value_new_from_string;

    /// Create a new libical-glib object from the native libical object and the owner.
    extern fn i_cal_value_new_full(p_native: *anyopaque, p_owner: *gobject.Object) *icalglib.Value;
    pub const newFull = i_cal_value_new_full;

    /// Creates a new `ICalValue` with the type geo.
    extern fn i_cal_value_new_geo(p_v: *icalglib.Geo) *icalglib.Value;
    pub const newGeo = i_cal_value_new_geo;

    /// Creates a new `ICalValue` with the type integer.
    extern fn i_cal_value_new_integer(p_v: c_int) *icalglib.Value;
    pub const newInteger = i_cal_value_new_integer;

    /// Creates a new `ICalValue` with the type method.
    extern fn i_cal_value_new_method(p_v: icalglib.PropertyMethod) *icalglib.Value;
    pub const newMethod = i_cal_value_new_method;

    /// Creates a new `ICalValue` with the type period.
    extern fn i_cal_value_new_period(p_v: *icalglib.Period) *icalglib.Value;
    pub const newPeriod = i_cal_value_new_period;

    /// Creates a new `ICalValue` with the type pollcompletion.
    extern fn i_cal_value_new_pollcompletion(p_v: icalglib.PropertyPollcompletion) *icalglib.Value;
    pub const newPollcompletion = i_cal_value_new_pollcompletion;

    /// Creates a new `ICalValue` with the type pollmode.
    extern fn i_cal_value_new_pollmode(p_v: icalglib.PropertyPollmode) *icalglib.Value;
    pub const newPollmode = i_cal_value_new_pollmode;

    /// Creates a new `ICalValue` with the type query.
    extern fn i_cal_value_new_query(p_v: [*:0]const u8) *icalglib.Value;
    pub const newQuery = i_cal_value_new_query;

    /// Creates a new `ICalValue` with the type querylevel.
    extern fn i_cal_value_new_querylevel(p_v: icalglib.PropertyQuerylevel) *icalglib.Value;
    pub const newQuerylevel = i_cal_value_new_querylevel;

    /// Creates a new `ICalValue` with the type recur.
    extern fn i_cal_value_new_recur(p_v: *icalglib.Recurrence) *icalglib.Value;
    pub const newRecur = i_cal_value_new_recur;

    /// Creates a new `ICalValue` with the type requeststatus.
    extern fn i_cal_value_new_requeststatus(p_v: *icalglib.Reqstat) *icalglib.Value;
    pub const newRequeststatus = i_cal_value_new_requeststatus;

    /// Creates a new `ICalValue` with the type status.
    extern fn i_cal_value_new_status(p_v: icalglib.PropertyStatus) *icalglib.Value;
    pub const newStatus = i_cal_value_new_status;

    /// Creates a new `ICalValue` with the type string.
    extern fn i_cal_value_new_string(p_v: [*:0]const u8) *icalglib.Value;
    pub const newString = i_cal_value_new_string;

    /// Creates a new `ICalValue` with the type taskmode.
    extern fn i_cal_value_new_taskmode(p_v: icalglib.PropertyTaskmode) *icalglib.Value;
    pub const newTaskmode = i_cal_value_new_taskmode;

    /// Creates a new `ICalValue` with the type text.
    extern fn i_cal_value_new_text(p_v: [*:0]const u8) *icalglib.Value;
    pub const newText = i_cal_value_new_text;

    /// Creates a new `ICalValue` with the type transp.
    extern fn i_cal_value_new_transp(p_v: icalglib.PropertyTransp) *icalglib.Value;
    pub const newTransp = i_cal_value_new_transp;

    /// Creates a new `ICalValue` with the type trigger.
    extern fn i_cal_value_new_trigger(p_v: *icalglib.Trigger) *icalglib.Value;
    pub const newTrigger = i_cal_value_new_trigger;

    /// Creates a new `ICalValue` with the type uri.
    extern fn i_cal_value_new_uri(p_v: [*:0]const u8) *icalglib.Value;
    pub const newUri = i_cal_value_new_uri;

    /// Creates a new `ICalValue` with the type utcoffset.
    extern fn i_cal_value_new_utcoffset(p_v: c_int) *icalglib.Value;
    pub const newUtcoffset = i_cal_value_new_utcoffset;

    /// Creates a new `ICalValue` with the type x.
    extern fn i_cal_value_new_x(p_v: [*:0]const u8) *icalglib.Value;
    pub const newX = i_cal_value_new_x;

    /// Creates a new `ICalValue` with the type xlicclass.
    extern fn i_cal_value_new_xlicclass(p_v: icalglib.PropertyXlicclass) *icalglib.Value;
    pub const newXlicclass = i_cal_value_new_xlicclass;

    /// Converts the `ICalValue` to a string.
    extern fn i_cal_value_as_ical_string(p_value: *const Value) [*:0]u8;
    pub const asIcalString = i_cal_value_as_ical_string;

    /// Deeply clone a `ICalValue`.
    extern fn i_cal_value_clone(p_value: *const Value) *icalglib.Value;
    pub const clone = i_cal_value_clone;

    /// Compares two `ICalValue`.
    extern fn i_cal_value_compare(p_a: *const Value, p_b: *const icalglib.Value) icalglib.ParameterXliccomparetype;
    pub const compare = i_cal_value_compare;

    /// Frees a `ICalValue`.
    extern fn i_cal_value_free(p_value: *Value) void;
    pub const free = i_cal_value_free;

    /// Gets the action of `ICalValue`.
    extern fn i_cal_value_get_action(p_value: *Value) icalglib.PropertyAction;
    pub const getAction = i_cal_value_get_action;

    /// Gets the attach of `ICalValue`.
    extern fn i_cal_value_get_attach(p_value: *Value) ?*icalglib.Attach;
    pub const getAttach = i_cal_value_get_attach;

    /// Gets the binary of `ICalValue`.
    extern fn i_cal_value_get_binary(p_value: *Value) ?[*:0]const u8;
    pub const getBinary = i_cal_value_get_binary;

    /// Gets the boolean of `ICalValue`.
    extern fn i_cal_value_get_boolean(p_value: *Value) c_int;
    pub const getBoolean = i_cal_value_get_boolean;

    /// Gets the busytype of `ICalValue`.
    extern fn i_cal_value_get_busytype(p_value: *Value) icalglib.PropertyBusytype;
    pub const getBusytype = i_cal_value_get_busytype;

    /// Gets the caladdress of `ICalValue`.
    extern fn i_cal_value_get_caladdress(p_value: *Value) ?[*:0]const u8;
    pub const getCaladdress = i_cal_value_get_caladdress;

    /// Gets the carlevel of `ICalValue`.
    extern fn i_cal_value_get_carlevel(p_value: *Value) icalglib.PropertyCarlevel;
    pub const getCarlevel = i_cal_value_get_carlevel;

    /// Gets the class of `ICalValue`.
    extern fn i_cal_value_get_class(p_value: *Value) icalglib.Property_Class;
    pub const getClass = i_cal_value_get_class;

    /// Gets the cmd of `ICalValue`.
    extern fn i_cal_value_get_cmd(p_value: *Value) icalglib.PropertyCmd;
    pub const getCmd = i_cal_value_get_cmd;

    /// Gets the date of `ICalValue`.
    extern fn i_cal_value_get_date(p_value: *Value) ?*icalglib.Time;
    pub const getDate = i_cal_value_get_date;

    /// Gets the datetime of `ICalValue`.
    extern fn i_cal_value_get_datetime(p_value: *Value) ?*icalglib.Time;
    pub const getDatetime = i_cal_value_get_datetime;

    /// Gets the datetimedate (DATE-TIME or DATE) of `ICalValue`.
    extern fn i_cal_value_get_datetimedate(p_value: *Value) ?*icalglib.Time;
    pub const getDatetimedate = i_cal_value_get_datetimedate;

    /// Gets the datetimeperiod of `ICalValue`.
    extern fn i_cal_value_get_datetimeperiod(p_value: *Value) ?*icalglib.Datetimeperiod;
    pub const getDatetimeperiod = i_cal_value_get_datetimeperiod;

    /// Gets the duration of `ICalValue`.
    extern fn i_cal_value_get_duration(p_value: *Value) ?*icalglib.Duration;
    pub const getDuration = i_cal_value_get_duration;

    /// Gets the float of `ICalValue`.
    extern fn i_cal_value_get_float(p_value: *Value) f64;
    pub const getFloat = i_cal_value_get_float;

    /// Gets the geo of `ICalValue`.
    extern fn i_cal_value_get_geo(p_value: *Value) ?*icalglib.Geo;
    pub const getGeo = i_cal_value_get_geo;

    /// Gets the integer of `ICalValue`.
    extern fn i_cal_value_get_integer(p_value: *Value) c_int;
    pub const getInteger = i_cal_value_get_integer;

    /// Gets the method of `ICalValue`.
    extern fn i_cal_value_get_method(p_value: *Value) icalglib.PropertyMethod;
    pub const getMethod = i_cal_value_get_method;

    /// Gets the parent `ICalProperty` of the specified `ICalValue`.
    extern fn i_cal_value_get_parent(p_value: *Value) ?*icalglib.Property;
    pub const getParent = i_cal_value_get_parent;

    /// Gets the period of `ICalValue`.
    extern fn i_cal_value_get_period(p_value: *Value) ?*icalglib.Period;
    pub const getPeriod = i_cal_value_get_period;

    /// Gets the pollcompletion of `ICalValue`.
    extern fn i_cal_value_get_pollcompletion(p_value: *Value) icalglib.PropertyPollcompletion;
    pub const getPollcompletion = i_cal_value_get_pollcompletion;

    /// Gets the pollmode of `ICalValue`.
    extern fn i_cal_value_get_pollmode(p_value: *Value) icalglib.PropertyPollmode;
    pub const getPollmode = i_cal_value_get_pollmode;

    /// Gets the query of `ICalValue`.
    extern fn i_cal_value_get_query(p_value: *Value) ?[*:0]const u8;
    pub const getQuery = i_cal_value_get_query;

    /// Gets the querylevel of `ICalValue`.
    extern fn i_cal_value_get_querylevel(p_value: *Value) icalglib.PropertyQuerylevel;
    pub const getQuerylevel = i_cal_value_get_querylevel;

    /// Gets the recur of `ICalValue`.
    extern fn i_cal_value_get_recur(p_value: *Value) ?*icalglib.Recurrence;
    pub const getRecur = i_cal_value_get_recur;

    /// Gets the requeststatus of `ICalValue`.
    extern fn i_cal_value_get_requeststatus(p_value: *Value) ?*icalglib.Reqstat;
    pub const getRequeststatus = i_cal_value_get_requeststatus;

    /// Gets the status of `ICalValue`.
    extern fn i_cal_value_get_status(p_value: *Value) icalglib.PropertyStatus;
    pub const getStatus = i_cal_value_get_status;

    /// Gets the string of `ICalValue`.
    extern fn i_cal_value_get_string(p_value: *Value) ?[*:0]const u8;
    pub const getString = i_cal_value_get_string;

    /// Gets the taskmode of `ICalValue`.
    extern fn i_cal_value_get_taskmode(p_value: *Value) icalglib.PropertyTaskmode;
    pub const getTaskmode = i_cal_value_get_taskmode;

    /// Gets the text of `ICalValue`.
    extern fn i_cal_value_get_text(p_value: *Value) ?[*:0]const u8;
    pub const getText = i_cal_value_get_text;

    /// Gets the transp of `ICalValue`.
    extern fn i_cal_value_get_transp(p_value: *Value) icalglib.PropertyTransp;
    pub const getTransp = i_cal_value_get_transp;

    /// Gets the trigger of `ICalValue`.
    extern fn i_cal_value_get_trigger(p_value: *Value) ?*icalglib.Trigger;
    pub const getTrigger = i_cal_value_get_trigger;

    /// Gets the uri of `ICalValue`.
    extern fn i_cal_value_get_uri(p_value: *Value) ?[*:0]const u8;
    pub const getUri = i_cal_value_get_uri;

    /// Gets the utcoffset of `ICalValue`.
    extern fn i_cal_value_get_utcoffset(p_value: *Value) c_int;
    pub const getUtcoffset = i_cal_value_get_utcoffset;

    /// Gets the x of `ICalValue`.
    extern fn i_cal_value_get_x(p_value: *Value) ?[*:0]const u8;
    pub const getX = i_cal_value_get_x;

    /// Gets the xlicclass of `ICalValue`.
    extern fn i_cal_value_get_xlicclass(p_value: *Value) icalglib.PropertyXlicclass;
    pub const getXlicclass = i_cal_value_get_xlicclass;

    /// Checks if `ICalValue` is valid.
    extern fn i_cal_value_is_valid(p_value: *const Value) c_int;
    pub const isValid = i_cal_value_is_valid;

    /// Gets the kind of `ICalValue`.
    extern fn i_cal_value_isa(p_value: *const Value) icalglib.ValueKind;
    pub const isa = i_cal_value_isa;

    /// Checks whether the native part of `ICalValue` is an icalvalue.
    extern fn i_cal_value_isa_value(p_value: *Value) c_int;
    pub const isaValue = i_cal_value_isa_value;

    /// Resets the kind of `ICalValue`.
    extern fn i_cal_value_reset_kind(p_value: *Value) void;
    pub const resetKind = i_cal_value_reset_kind;

    /// Sets the action in the `ICalValue`.
    extern fn i_cal_value_set_action(p_value: *Value, p_v: icalglib.PropertyAction) void;
    pub const setAction = i_cal_value_set_action;

    /// Sets the attach in the `ICalValue`.
    extern fn i_cal_value_set_attach(p_value: *Value, p_v: *icalglib.Attach) void;
    pub const setAttach = i_cal_value_set_attach;

    /// Sets the binary in the `ICalValue`.
    extern fn i_cal_value_set_binary(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setBinary = i_cal_value_set_binary;

    /// Sets the boolean in the `ICalValue`.
    extern fn i_cal_value_set_boolean(p_value: *Value, p_v: c_int) void;
    pub const setBoolean = i_cal_value_set_boolean;

    /// Sets the busytype in the `ICalValue`.
    extern fn i_cal_value_set_busytype(p_value: *Value, p_v: icalglib.PropertyBusytype) void;
    pub const setBusytype = i_cal_value_set_busytype;

    /// Sets the caladdress in the `ICalValue`.
    extern fn i_cal_value_set_caladdress(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setCaladdress = i_cal_value_set_caladdress;

    /// Sets the carlevel in the `ICalValue`.
    extern fn i_cal_value_set_carlevel(p_value: *Value, p_v: icalglib.PropertyCarlevel) void;
    pub const setCarlevel = i_cal_value_set_carlevel;

    /// Sets the class in the `ICalValue`.
    extern fn i_cal_value_set_class(p_value: *Value, p_v: icalglib.Property_Class) void;
    pub const setClass = i_cal_value_set_class;

    /// Sets the cmd in the `ICalValue`.
    extern fn i_cal_value_set_cmd(p_value: *Value, p_v: icalglib.PropertyCmd) void;
    pub const setCmd = i_cal_value_set_cmd;

    /// Sets the date in the `ICalValue`.
    extern fn i_cal_value_set_date(p_value: *Value, p_v: *icalglib.Time) void;
    pub const setDate = i_cal_value_set_date;

    /// Sets the datetime in the `ICalValue`.
    extern fn i_cal_value_set_datetime(p_value: *Value, p_v: *icalglib.Time) void;
    pub const setDatetime = i_cal_value_set_datetime;

    /// Sets the datetimedate (DATE-TIME or DATE) in the `ICalValue`.
    extern fn i_cal_value_set_datetimedate(p_value: *Value, p_v: *icalglib.Time) void;
    pub const setDatetimedate = i_cal_value_set_datetimedate;

    /// Sets the datetimeperiod in the `ICalValue`.
    extern fn i_cal_value_set_datetimeperiod(p_value: *Value, p_v: *icalglib.Datetimeperiod) void;
    pub const setDatetimeperiod = i_cal_value_set_datetimeperiod;

    /// Sets the duration in the `ICalValue`.
    extern fn i_cal_value_set_duration(p_value: *Value, p_v: *icalglib.Duration) void;
    pub const setDuration = i_cal_value_set_duration;

    /// Sets the float in the `ICalValue`.
    extern fn i_cal_value_set_float(p_value: *Value, p_v: f64) void;
    pub const setFloat = i_cal_value_set_float;

    /// Sets the geo in the `ICalValue`.
    extern fn i_cal_value_set_geo(p_value: *Value, p_v: *icalglib.Geo) void;
    pub const setGeo = i_cal_value_set_geo;

    /// Sets the integer in the `ICalValue`.
    extern fn i_cal_value_set_integer(p_value: *Value, p_v: c_int) void;
    pub const setInteger = i_cal_value_set_integer;

    /// Sets the method in the `ICalValue`.
    extern fn i_cal_value_set_method(p_value: *Value, p_v: icalglib.PropertyMethod) void;
    pub const setMethod = i_cal_value_set_method;

    /// Sets the parent property of a value.
    extern fn i_cal_value_set_parent(p_value: *Value, p_property: ?*icalglib.Property) void;
    pub const setParent = i_cal_value_set_parent;

    /// Sets the period in the `ICalValue`.
    extern fn i_cal_value_set_period(p_value: *Value, p_v: *icalglib.Period) void;
    pub const setPeriod = i_cal_value_set_period;

    /// Sets the pollcompletion in the `ICalValue`.
    extern fn i_cal_value_set_pollcompletion(p_value: *Value, p_v: icalglib.PropertyPollcompletion) void;
    pub const setPollcompletion = i_cal_value_set_pollcompletion;

    /// Sets the pollmode in the `ICalValue`.
    extern fn i_cal_value_set_pollmode(p_value: *Value, p_v: icalglib.PropertyPollmode) void;
    pub const setPollmode = i_cal_value_set_pollmode;

    /// Sets the query in the `ICalValue`.
    extern fn i_cal_value_set_query(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setQuery = i_cal_value_set_query;

    /// Sets the querylevel in the `ICalValue`.
    extern fn i_cal_value_set_querylevel(p_value: *Value, p_v: icalglib.PropertyQuerylevel) void;
    pub const setQuerylevel = i_cal_value_set_querylevel;

    /// Sets the recur in the `ICalValue`.
    extern fn i_cal_value_set_recur(p_value: *Value, p_v: *icalglib.Recurrence) void;
    pub const setRecur = i_cal_value_set_recur;

    /// Sets the requeststatus in the `ICalValue`.
    extern fn i_cal_value_set_requeststatus(p_value: *Value, p_v: *icalglib.Reqstat) void;
    pub const setRequeststatus = i_cal_value_set_requeststatus;

    /// Sets the status in the `ICalValue`.
    extern fn i_cal_value_set_status(p_value: *Value, p_v: icalglib.PropertyStatus) void;
    pub const setStatus = i_cal_value_set_status;

    /// Sets the string in the `ICalValue`.
    extern fn i_cal_value_set_string(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setString = i_cal_value_set_string;

    /// Sets the taskmode in the `ICalValue`.
    extern fn i_cal_value_set_taskmode(p_value: *Value, p_v: icalglib.PropertyTaskmode) void;
    pub const setTaskmode = i_cal_value_set_taskmode;

    /// Sets the text in the `ICalValue`.
    extern fn i_cal_value_set_text(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setText = i_cal_value_set_text;

    /// Sets the transp in the `ICalValue`.
    extern fn i_cal_value_set_transp(p_value: *Value, p_v: icalglib.PropertyTransp) void;
    pub const setTransp = i_cal_value_set_transp;

    /// Sets the trigger in the `ICalValue`.
    extern fn i_cal_value_set_trigger(p_value: *Value, p_v: *icalglib.Trigger) void;
    pub const setTrigger = i_cal_value_set_trigger;

    /// Sets the uri in the `ICalValue`.
    extern fn i_cal_value_set_uri(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setUri = i_cal_value_set_uri;

    /// Sets the utcoffset in the `ICalValue`.
    extern fn i_cal_value_set_utcoffset(p_value: *Value, p_v: c_int) void;
    pub const setUtcoffset = i_cal_value_set_utcoffset;

    /// Sets the x in the `ICalValue`.
    extern fn i_cal_value_set_x(p_value: *Value, p_v: [*:0]const u8) void;
    pub const setX = i_cal_value_set_x;

    /// Sets the xlicclass in the `ICalValue`.
    extern fn i_cal_value_set_xlicclass(p_value: *Value, p_v: icalglib.PropertyXlicclass) void;
    pub const setXlicclass = i_cal_value_set_xlicclass;

    extern fn i_cal_value_get_type() usize;
    pub const getGObjectType = i_cal_value_get_type;

    extern fn g_object_ref(p_self: *icalglib.Value) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *icalglib.Value) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Value, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalArray class.
pub const ArrayClass = extern struct {
    pub const Instance = icalglib.Array;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ArrayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalAttach class.
pub const AttachClass = extern struct {
    pub const Instance = icalglib.Attach;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *AttachClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalCompIter class.
pub const CompIterClass = extern struct {
    pub const Instance = icalglib.CompIter;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *CompIterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalComponent class.
pub const ComponentClass = extern struct {
    pub const Instance = icalglib.Component;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ComponentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalDatetimeperiod class.
pub const DatetimeperiodClass = extern struct {
    pub const Instance = icalglib.Datetimeperiod;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *DatetimeperiodClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalDuration class.
pub const DurationClass = extern struct {
    pub const Instance = icalglib.Duration;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *DurationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalGeo class.
pub const GeoClass = extern struct {
    pub const Instance = icalglib.Geo;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *GeoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is an ICalObject class struct.
pub const ObjectClass = extern struct {
    pub const Instance = icalglib.Object;

    f_parent_class: gobject.ObjectClass,

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

/// This is the ICalParameter class.
pub const ParameterClass = extern struct {
    pub const Instance = icalglib.Parameter;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ParameterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalParser class.
pub const ParserClass = extern struct {
    pub const Instance = icalglib.Parser;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ParserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalPeriod class.
pub const PeriodClass = extern struct {
    pub const Instance = icalglib.Period;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *PeriodClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalProperty class.
pub const PropertyClass = extern struct {
    pub const Instance = icalglib.Property;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *PropertyClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalRecurIterator class.
pub const RecurIteratorClass = extern struct {
    pub const Instance = icalglib.RecurIterator;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *RecurIteratorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalRecurrence class.
pub const RecurrenceClass = extern struct {
    pub const Instance = icalglib.Recurrence;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *RecurrenceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalReqstat class.
pub const ReqstatClass = extern struct {
    pub const Instance = icalglib.Reqstat;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ReqstatClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTime class.
pub const TimeClass = extern struct {
    pub const Instance = icalglib.Time;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *TimeClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTimeSpan class.
pub const TimeSpanClass = extern struct {
    pub const Instance = icalglib.TimeSpan;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *TimeSpanClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTimezone class.
pub const TimezoneClass = extern struct {
    pub const Instance = icalglib.Timezone;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *TimezoneClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalTrigger class.
pub const TriggerClass = extern struct {
    pub const Instance = icalglib.Trigger;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *TriggerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This is the ICalValue class.
pub const ValueClass = extern struct {
    pub const Instance = icalglib.Value;

    f_parent: icalglib.ObjectClass,

    pub fn as(p_instance: *ValueClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Array = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Attach = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _CompIter = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Component = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Datetimeperiod = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Duration = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Geo = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Parameter = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Parser = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Period = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Property = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _RecurIterator = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Recurrence = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Reqstat = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Time = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _TimeSpan = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Timezone = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Trigger = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _Value = extern struct {
    f_parent: icalglib.Object,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ComponentKind = enum(c_int) {
    no_component = 0,
    any_component = 1,
    xroot_component = 2,
    xattach_component = 3,
    vevent_component = 4,
    vtodo_component = 5,
    vjournal_component = 6,
    vcalendar_component = 7,
    vagenda_component = 8,
    vfreebusy_component = 9,
    valarm_component = 10,
    xaudioalarm_component = 11,
    xdisplayalarm_component = 12,
    xemailalarm_component = 13,
    xprocedurealarm_component = 14,
    vtimezone_component = 15,
    xstandard_component = 16,
    xdaylight_component = 17,
    x_component = 18,
    vschedule_component = 19,
    vquery_component = 20,
    vreply_component = 21,
    vcar_component = 22,
    vcommand_component = 23,
    xlicinvalid_component = 24,
    xlicmimepart_component = 25,
    vavailability_component = 26,
    xavailable_component = 27,
    vpoll_component = 28,
    vvoter_component = 29,
    xvote_component = 30,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ErrorEnum = enum(c_int) {
    no_error = 0,
    badarg_error = 1,
    newfailed_error = 2,
    allocation_error = 3,
    malformeddata_error = 4,
    parse_error = 5,
    internal_error = 6,
    file_error = 7,
    usage_error = 8,
    unimplemented_error = 9,
    unknown_error = 10,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ErrorState = enum(c_int) {
    fatal = 0,
    nonfatal = 1,
    default = 2,
    unknown = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterAction = enum(c_int) {
    x = 20000,
    ask = 20001,
    abort = 20002,
    none = 20099,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterCutype = enum(c_int) {
    x = 20100,
    individual = 20101,
    group = 20102,
    resource = 20103,
    room = 20104,
    unknown = 20105,
    none = 20199,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterDisplay = enum(c_int) {
    x = 22000,
    badge = 22001,
    graphic = 22002,
    fullsize = 22003,
    thumbnail = 22004,
    none = 22099,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterEnable = enum(c_int) {
    x = 20200,
    true = 20201,
    false = 20202,
    none = 20299,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterEncoding = enum(c_int) {
    x = 20300,
    @"8bit" = 20301,
    base64 = 20302,
    none = 20399,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterFbtype = enum(c_int) {
    x = 20400,
    free = 20401,
    busy = 20402,
    busyunavailable = 20403,
    busytentative = 20404,
    none = 20499,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterFeature = enum(c_int) {
    x = 22100,
    audio = 22101,
    chat = 22102,
    feed = 22103,
    moderator = 22104,
    phone = 22105,
    screen = 22106,
    video = 22107,
    none = 22199,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterKind = enum(c_int) {
    any_parameter = 0,
    actionparam_parameter = 1,
    altrep_parameter = 2,
    charset_parameter = 3,
    cn_parameter = 4,
    cutype_parameter = 5,
    delegatedfrom_parameter = 6,
    delegatedto_parameter = 7,
    dir_parameter = 8,
    display_parameter = 46,
    email_parameter = 50,
    enable_parameter = 9,
    encoding_parameter = 10,
    fbtype_parameter = 11,
    feature_parameter = 48,
    filename_parameter = 42,
    fmttype_parameter = 12,
    iana_parameter = 33,
    id_parameter = 13,
    label_parameter = 49,
    language_parameter = 14,
    latency_parameter = 15,
    local_parameter = 16,
    localize_parameter = 17,
    managedid_parameter = 40,
    member_parameter = 18,
    modified_parameter = 44,
    options_parameter = 19,
    partstat_parameter = 20,
    patchaction_parameter = 51,
    publiccomment_parameter = 37,
    range_parameter = 21,
    reason_parameter = 43,
    related_parameter = 22,
    reltype_parameter = 23,
    response_parameter = 38,
    role_parameter = 24,
    rsvp_parameter = 25,
    scheduleagent_parameter = 34,
    scheduleforcesend_parameter = 35,
    schedulestatus_parameter = 36,
    sentby_parameter = 26,
    size_parameter = 41,
    stayinformed_parameter = 39,
    substate_parameter = 45,
    tzid_parameter = 27,
    value_parameter = 28,
    x_parameter = 29,
    xliccomparetype_parameter = 30,
    xlicerrortype_parameter = 31,
    no_parameter = 32,
    _,

    pub const required_parameter = ParameterKind.reason_parameter;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterLocal = enum(c_int) {
    x = 20500,
    true = 20501,
    false = 20502,
    none = 20599,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterPartstat = enum(c_int) {
    x = 20600,
    needsaction = 20601,
    accepted = 20602,
    declined = 20603,
    tentative = 20604,
    delegated = 20605,
    completed = 20606,
    inprocess = 20607,
    failed = 20608,
    none = 20699,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterPatchaction = enum(c_int) {
    x = 22200,
    create = 22201,
    byname = 22202,
    byvalue = 22203,
    byparam = 22204,
    none = 22299,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterRange = enum(c_int) {
    x = 20700,
    thisandprior = 20701,
    thisandfuture = 20702,
    none = 20799,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterRelated = enum(c_int) {
    x = 20800,
    start = 20801,
    end = 20802,
    none = 20899,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterReltype = enum(c_int) {
    x = 20900,
    parent = 20901,
    child = 20902,
    sibling = 20903,
    poll = 20904,
    none = 20999,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterRequired = enum(c_int) {
    x = 21000,
    true = 21001,
    false = 21002,
    none = 21099,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterRole = enum(c_int) {
    x = 21100,
    chair = 21101,
    reqparticipant = 21102,
    optparticipant = 21103,
    nonparticipant = 21104,
    none = 21199,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterRsvp = enum(c_int) {
    x = 21200,
    true = 21201,
    false = 21202,
    none = 21299,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterScheduleagent = enum(c_int) {
    x = 21300,
    server = 21301,
    client = 21302,
    none = 21399,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterScheduleforcesend = enum(c_int) {
    x = 21400,
    request = 21401,
    reply = 21402,
    none = 21499,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterStayinformed = enum(c_int) {
    x = 21500,
    true = 21501,
    false = 21502,
    none = 21599,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterSubstate = enum(c_int) {
    x = 21900,
    ok = 21901,
    @"error" = 21902,
    suspended = 21903,
    none = 21999,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterValue = enum(c_int) {
    x = 21600,
    binary = 21601,
    boolean = 21602,
    date = 21603,
    duration = 21604,
    float = 21605,
    integer = 21606,
    period = 21607,
    recur = 21608,
    text = 21609,
    uri = 21610,
    @"error" = 21611,
    datetime = 21612,
    utcoffset = 21613,
    caladdress = 21614,
    none = 21699,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterXliccomparetype = enum(c_int) {
    x = 21700,
    equal = 21701,
    notequal = 21702,
    less = 21703,
    greater = 21704,
    lessequal = 21705,
    greaterequal = 21706,
    regex = 21707,
    isnull = 21708,
    isnotnull = 21709,
    none = 21799,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParameterXlicerrortype = enum(c_int) {
    x = 21800,
    componentparseerror = 21801,
    propertyparseerror = 21802,
    parameternameparseerror = 21803,
    parametervalueparseerror = 21804,
    valueparseerror = 21805,
    invaliditip = 21806,
    unknownvcalproperror = 21807,
    mimeparseerror = 21808,
    vcalpropparseerror = 21809,
    none = 21899,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParserState = enum(c_int) {
    @"error" = 0,
    success = 1,
    begin_comp = 2,
    end_comp = 3,
    in_progress = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyAction = enum(c_int) {
    x = 10000,
    audio = 10001,
    display = 10002,
    email = 10003,
    procedure = 10004,
    none = 10099,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyBusytype = enum(c_int) {
    x = 10100,
    busy = 10101,
    busyunavailable = 10102,
    busytentative = 10103,
    none = 10199,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyCarlevel = enum(c_int) {
    x = 10200,
    carnone = 10201,
    carmin = 10202,
    carfull1 = 10203,
    none = 10299,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyCmd = enum(c_int) {
    x = 10400,
    abort = 10401,
    @"continue" = 10402,
    create = 10403,
    delete = 10404,
    generateuid = 10405,
    getcapability = 10406,
    identify = 10407,
    modify = 10408,
    move = 10409,
    reply = 10410,
    search = 10411,
    setlocale = 10412,
    none = 10499,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyKind = enum(c_int) {
    any_property = 0,
    acceptresponse_property = 102,
    acknowledged_property = 1,
    action_property = 2,
    allowconflict_property = 3,
    attach_property = 4,
    attendee_property = 5,
    busytype_property = 101,
    calid_property = 6,
    calmaster_property = 7,
    calscale_property = 8,
    capversion_property = 9,
    carlevel_property = 10,
    carid_property = 11,
    categories_property = 12,
    class_property = 13,
    cmd_property = 14,
    color_property = 118,
    comment_property = 15,
    completed_property = 16,
    components_property = 17,
    contact_property = 18,
    created_property = 19,
    csid_property = 20,
    datemax_property = 21,
    datemin_property = 22,
    decreed_property = 23,
    defaultcharset_property = 24,
    defaultlocale_property = 25,
    defaulttzid_property = 26,
    defaultvcars_property = 27,
    deny_property = 28,
    description_property = 29,
    dtend_property = 30,
    dtstamp_property = 31,
    dtstart_property = 32,
    due_property = 33,
    duration_property = 34,
    estimatedduration_property = 113,
    exdate_property = 35,
    expand_property = 36,
    exrule_property = 37,
    freebusy_property = 38,
    geo_property = 39,
    grant_property = 40,
    itipversion_property = 41,
    lastmodified_property = 42,
    location_property = 43,
    maxcomponentsize_property = 44,
    maxdate_property = 45,
    maxresults_property = 46,
    maxresultssize_property = 47,
    method_property = 48,
    mindate_property = 49,
    multipart_property = 50,
    name_property = 115,
    organizer_property = 52,
    owner_property = 53,
    percentcomplete_property = 54,
    permission_property = 55,
    pollcompletion_property = 110,
    pollitemid_property = 103,
    pollmode_property = 104,
    pollproperties_property = 105,
    pollwinner_property = 106,
    priority_property = 56,
    prodid_property = 57,
    query_property = 58,
    querylevel_property = 59,
    queryid_property = 60,
    queryname_property = 61,
    rdate_property = 62,
    recuraccepted_property = 63,
    recurexpand_property = 64,
    recurlimit_property = 65,
    recurrenceid_property = 66,
    relatedto_property = 67,
    relcalid_property = 68,
    repeat_property = 69,
    replyurl_property = 111,
    requeststatus_property = 70,
    resources_property = 71,
    response_property = 112,
    restriction_property = 72,
    rrule_property = 73,
    scope_property = 74,
    sequence_property = 75,
    status_property = 76,
    storesexpanded_property = 77,
    summary_property = 78,
    target_property = 79,
    taskmode_property = 114,
    transp_property = 80,
    trigger_property = 81,
    tzid_property = 82,
    tzidaliasof_property = 108,
    tzname_property = 83,
    tzoffsetfrom_property = 84,
    tzoffsetto_property = 85,
    tzuntil_property = 109,
    tzurl_property = 86,
    uid_property = 87,
    url_property = 88,
    version_property = 89,
    voter_property = 107,
    x_property = 90,
    xlicclass_property = 91,
    xlicclustercount_property = 92,
    xlicerror_property = 93,
    xlicmimecharset_property = 94,
    xlicmimecid_property = 95,
    xlicmimecontenttype_property = 96,
    xlicmimeencoding_property = 97,
    xlicmimefilename_property = 98,
    xlicmimeoptinfo_property = 99,
    no_property = 100,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyMethod = enum(c_int) {
    x = 10500,
    publish = 10501,
    request = 10502,
    reply = 10503,
    add = 10504,
    cancel = 10505,
    refresh = 10506,
    counter = 10507,
    declinecounter = 10508,
    create = 10509,
    read = 10510,
    response = 10511,
    move = 10512,
    modify = 10513,
    generateuid = 10514,
    delete = 10515,
    none = 10599,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyPollcompletion = enum(c_int) {
    x = 10600,
    server = 10601,
    serversubmit = 10602,
    serverchoice = 10603,
    client = 10604,
    none = 10699,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyPollmode = enum(c_int) {
    x = 10700,
    basic = 10701,
    none = 10799,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyQuerylevel = enum(c_int) {
    x = 10800,
    calql1 = 10801,
    calqlnone = 10802,
    none = 10899,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyStatus = enum(c_int) {
    x = 10900,
    tentative = 10901,
    confirmed = 10902,
    completed = 10903,
    needsaction = 10904,
    cancelled = 10905,
    inprocess = 10906,
    draft = 10907,
    final = 10908,
    submitted = 10909,
    pending = 10910,
    failed = 10911,
    deleted = 10912,
    none = 10999,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyTaskmode = enum(c_int) {
    x = 11200,
    automaticcompletion = 11201,
    automaticfailure = 11202,
    automaticstatus = 11203,
    none = 11299,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyTransp = enum(c_int) {
    x = 11000,
    @"opaque" = 11001,
    opaquenoconflict = 11002,
    transparent = 11003,
    transparentnoconflict = 11004,
    none = 11099,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertyXlicclass = enum(c_int) {
    x = 11100,
    publishnew = 11101,
    publishupdate = 11102,
    publishfreebusy = 11103,
    requestnew = 11104,
    requestupdate = 11105,
    requestreschedule = 11106,
    requestdelegate = 11107,
    requestneworganizer = 11108,
    requestforward = 11109,
    requeststatus = 11110,
    requestfreebusy = 11111,
    replyaccept = 11112,
    replydecline = 11113,
    replydelegate = 11114,
    replycrasheraccept = 11115,
    replycrasherdecline = 11116,
    addinstance = 11117,
    cancelevent = 11118,
    cancelinstance = 11119,
    cancelall = 11120,
    refresh = 11121,
    counter = 11122,
    declinecounter = 11123,
    malformed = 11124,
    obsolete = 11125,
    missequenced = 11126,
    unknown = 11127,
    none = 11199,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Property_Class = enum(c_int) {
    x = 10300,
    public = 10301,
    private = 10302,
    confidential = 10303,
    none = 10399,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RecurrenceArrayMaxValues = enum(c_int) {
    recurrence_array_max = 32639,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RecurrenceArraySizes = enum(c_int) {
    second_size = 62,
    minute_size = 61,
    hour_size = 25,
    month_size = 14,
    monthday_size = 32,
    weekno_size = 56,
    yearday_size = 386,
    _,

    pub const setpos_size = RecurrenceArraySizes.yearday_size;
    pub const day_size = RecurrenceArraySizes.yearday_size;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RecurrenceFrequency = enum(c_int) {
    secondly_recurrence = 0,
    minutely_recurrence = 1,
    hourly_recurrence = 2,
    daily_recurrence = 3,
    weekly_recurrence = 4,
    monthly_recurrence = 5,
    yearly_recurrence = 6,
    no_recurrence = 7,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RecurrenceSkip = enum(c_int) {
    backward = 0,
    forward = 1,
    omit = 2,
    undefined = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RecurrenceWeekday = enum(c_int) {
    no_weekday = 0,
    sunday_weekday = 1,
    monday_weekday = 2,
    tuesday_weekday = 3,
    wednesday_weekday = 4,
    thursday_weekday = 5,
    friday_weekday = 6,
    saturday_weekday = 7,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RequestStatus = enum(c_int) {
    unknown_status = 0,
    @"2_0_success_status" = 1,
    @"2_1_fallback_status" = 2,
    @"2_2_igprop_status" = 3,
    @"2_3_igparam_status" = 4,
    @"2_4_igxprop_status" = 5,
    @"2_5_igxparam_status" = 6,
    @"2_6_igcomp_status" = 7,
    @"2_7_forward_status" = 8,
    @"2_8_oneevent_status" = 9,
    @"2_9_trunc_status" = 10,
    @"2_10_onetodo_status" = 11,
    @"2_11_truncrrule_status" = 12,
    @"3_0_invpropname_status" = 13,
    @"3_1_invpropval_status" = 14,
    @"3_2_invparam_status" = 15,
    @"3_3_invparamval_status" = 16,
    @"3_4_invcomp_status" = 17,
    @"3_5_invtime_status" = 18,
    @"3_6_invrule_status" = 19,
    @"3_7_invcu_status" = 20,
    @"3_8_noauth_status" = 21,
    @"3_9_badversion_status" = 22,
    @"3_10_toobig_status" = 23,
    @"3_11_missreqcomp_status" = 24,
    @"3_12_unkcomp_status" = 25,
    @"3_13_badcomp_status" = 26,
    @"3_14_nocap_status" = 27,
    @"3_15_invcommand" = 28,
    @"4_0_busy_status" = 29,
    @"4_1_store_access_denied" = 30,
    @"4_2_store_failed" = 31,
    @"4_3_store_not_found" = 32,
    @"5_0_maybe_status" = 33,
    @"5_1_unavail_status" = 34,
    @"5_2_noservice_status" = 35,
    @"5_3_nosched_status" = 36,
    @"6_1_container_not_found" = 37,
    @"9_0_unrecognized_command" = 38,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RestrictionKind = enum(c_int) {
    none = 0,
    zero = 1,
    one = 2,
    zeroplus = 3,
    oneplus = 4,
    zeroorone = 5,
    oneexclusive = 6,
    onemutual = 7,
    unknown = 8,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Unknowntokenhandling = enum(c_int) {
    assume_iana_token = 1,
    discard_token = 2,
    treat_as_error = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ValueKind = enum(c_int) {
    any_value = 5000,
    action_value = 5027,
    attach_value = 5003,
    binary_value = 5011,
    boolean_value = 5021,
    busytype_value = 5032,
    caladdress_value = 5023,
    carlevel_value = 5016,
    class_value = 5019,
    cmd_value = 5010,
    date_value = 5002,
    datetime_value = 5028,
    datetimedate_value = 5036,
    datetimeperiod_value = 5015,
    duration_value = 5020,
    float_value = 5013,
    geo_value = 5004,
    integer_value = 5017,
    method_value = 5030,
    period_value = 5014,
    pollcompletion_value = 5034,
    pollmode_value = 5033,
    query_value = 5001,
    querylevel_value = 5012,
    recur_value = 5026,
    requeststatus_value = 5009,
    status_value = 5005,
    string_value = 5007,
    taskmode_value = 5035,
    text_value = 5008,
    transp_value = 5006,
    trigger_value = 5024,
    uri_value = 5018,
    utcoffset_value = 5029,
    x_value = 5022,
    xlicclass_value = 5025,
    no_value = 5031,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn i_cal_bt() void;
pub const bt = i_cal_bt;

/// Returns the error stored in the library. If no error, return I_CAL_NO_ERROR.
extern fn i_cal_errno_return() icalglib.ErrorEnum;
pub const errnoReturn = i_cal_errno_return;

extern fn i_cal_error_clear_errno() void;
pub const errorClearErrno = i_cal_error_clear_errno;

/// Shout out the errors to the compiler.
extern fn i_cal_error_crash_here() void;
pub const errorCrashHere = i_cal_error_crash_here;

/// Gets the state of an error.
extern fn i_cal_error_get_error_state(p_error: icalglib.ErrorEnum) icalglib.ErrorState;
pub const errorGetErrorState = i_cal_error_get_error_state;

/// Gets the `icalglib.ErrorEnum` in the string representation. This method called the icalerrorno_return to get
/// the current error.
extern fn i_cal_error_perror() [*:0]const u8;
pub const errorPerror = i_cal_error_perror;

/// Restores the error to specified state.
extern fn i_cal_error_restore(p_error: [*:0]const u8, p_es: icalglib.ErrorState) void;
pub const errorRestore = i_cal_error_restore;

/// Sets the errno.
extern fn i_cal_error_set_errno(p_x: icalglib.ErrorEnum) void;
pub const errorSetErrno = i_cal_error_set_errno;

/// Sets the state to the corresponding error in the library.
extern fn i_cal_error_set_error_state(p_error: icalglib.ErrorEnum, p_state: icalglib.ErrorState) void;
pub const errorSetErrorState = i_cal_error_set_error_state;

extern fn i_cal_error_stop_here() void;
pub const errorStopHere = i_cal_error_stop_here;

/// Translates the `icalglib.ErrorEnum` to the string representation.
extern fn i_cal_error_strerror(p_e: icalglib.ErrorEnum) [*:0]const u8;
pub const errorStrerror = i_cal_error_strerror;

/// Suppresses the error.
extern fn i_cal_error_supress(p_error: [*:0]const u8) icalglib.ErrorState;
pub const errorSupress = i_cal_error_supress;

/// Gets the setting of `icalglib.Unknowntokenhandling`.
extern fn i_cal_get_unknown_token_handling_setting() icalglib.Unknowntokenhandling;
pub const getUnknownTokenHandlingSetting = i_cal_get_unknown_token_handling_setting;

/// Adds an existing buffer to the buffer ring.
extern fn i_cal_memory_add_tmp_buffer(p_buf: ?*anyopaque) void;
pub const memoryAddTmpBuffer = i_cal_memory_add_tmp_buffer;

/// Append the character to the buffer. Only use them on normally allocated memory, or on buffers created
/// from icalmemory_new_buffer, never with buffers created by icalmemory_tmp_buffer. If icalmemory_append_string
/// has to resize a buffer on the ring, the ring will loose track of it an you will have memory problems.
extern fn i_cal_memory_append_char(p_buf: *[*]u8, p_pos: *[*]u8, p_buf_size: *usize, p_ch: u8) void;
pub const memoryAppendChar = i_cal_memory_append_char;

/// Appends the string to the buffer. Only use them on normally allocated memory, or on buffers created from
/// icalmemory_new_buffer, never with buffers created by icalmemory_tmp_buffer. If icalmemory_append_string
/// has to resize a buffer on the ring, the ring will loose track of it an you will have memory problems.
extern fn i_cal_memory_append_string(p_buf: *[*]u8, p_pos: *[*]u8, p_buf_size: *usize, p_str: [*:0]const u8) void;
pub const memoryAppendString = i_cal_memory_append_string;

/// Frees the buffer.
extern fn i_cal_memory_free_buffer(p_buf: ?*anyopaque) void;
pub const memoryFreeBuffer = i_cal_memory_free_buffer;

/// Frees all the memory used in the ring.
extern fn i_cal_memory_free_ring() void;
pub const memoryFreeRing = i_cal_memory_free_ring;

/// Creates a new buffer with target size. The caller should deallocate it when necessary.
extern fn i_cal_memory_new_buffer(p_size: usize) ?*anyopaque;
pub const memoryNewBuffer = i_cal_memory_new_buffer;

/// Resizes the buffer to the target size.
extern fn i_cal_memory_resize_buffer(p_buf: ?*anyopaque, p_size: usize) ?*anyopaque;
pub const memoryResizeBuffer = i_cal_memory_resize_buffer;

/// A wrapper around strdup. Partly to trap calls to strdup, partly because in -ansi, gcc on Red Hat claims
/// that strdup is undeclared.
extern fn i_cal_memory_strdup(p_s: [*:0]const u8) [*:0]u8;
pub const memoryStrdup = i_cal_memory_strdup;

/// Creates a buffer with target size.
extern fn i_cal_memory_tmp_buffer(p_size: usize) ?*anyopaque;
pub const memoryTmpBuffer = i_cal_memory_tmp_buffer;

/// Like strdup, but the buffer is on the ring.
extern fn i_cal_memory_tmp_copy(p_str: [*:0]const u8) [*:0]u8;
pub const memoryTmpCopy = i_cal_memory_tmp_copy;

/// Parses data to `ICalComponent` using the given function.
extern fn i_cal_mime_parse(p_func: icalglib.MimeParseFunc, p_user_data: ?*anyopaque) *icalglib.Component;
pub const mimeParse = i_cal_mime_parse;

/// Fills an array with the 'count' number of occurrences generated by the rrule. Note that the times are
/// returned in UTC, but the times are calculated in local time. YOu will have to convert the results back
/// into local time before using them.
extern fn i_cal_recur_expand_recurrence(p_rule: [*:0]const u8, p_start: std.posix.time_t, p_count: c_int) *glib.Array;
pub const recurExpandRecurrence = i_cal_recur_expand_recurrence;

/// Returns the code for a request status.
extern fn i_cal_request_status_code(p_stat: icalglib.RequestStatus) [*:0]u8;
pub const requestStatusCode = i_cal_request_status_code;

/// Returns the descriptive text for a request status.
extern fn i_cal_request_status_desc(p_stat: icalglib.RequestStatus) [*:0]const u8;
pub const requestStatusDesc = i_cal_request_status_desc;

/// Returns a request status for major/minor status numbers.
extern fn i_cal_request_status_from_num(p_major: c_short, p_minor: c_short) icalglib.RequestStatus;
pub const requestStatusFromNum = i_cal_request_status_from_num;

/// Returns the major number for a request status.
extern fn i_cal_request_status_major(p_stat: icalglib.RequestStatus) c_short;
pub const requestStatusMajor = i_cal_request_status_major;

/// Returns the minor number for a request status.
extern fn i_cal_request_status_minor(p_stat: icalglib.RequestStatus) c_short;
pub const requestStatusMinor = i_cal_request_status_minor;

/// Checks whether the `ICalComponent` is valid.
extern fn i_cal_restriction_check(p_comp: *icalglib.Component) c_int;
pub const restrictionCheck = i_cal_restriction_check;

/// Compares the kind of restriction and the count to determine whether it is valid.
extern fn i_cal_restriction_compare(p_restr: icalglib.RestrictionKind, p_count: c_int) c_int;
pub const restrictionCompare = i_cal_restriction_compare;

/// Sets `icalglib.Unknowntokenhandling`.
extern fn i_cal_set_unknown_token_handling_setting(p_newSetting: icalglib.Unknowntokenhandling) void;
pub const setUnknownTokenHandlingSetting = i_cal_set_unknown_token_handling_setting;

pub const ComponentForeachRecurrenceFunc = *const fn (p_comp: *icalglib.Component, p_span: *icalglib.TimeSpan, p_user_data: ?*anyopaque) callconv(.c) void;

pub const ComponentForeachTZIDFunc = *const fn (p_param: *icalglib.Parameter, p_user_data: ?*anyopaque) callconv(.c) void;

pub const MimeParseFunc = *const fn (p_bytes: [*]u8, p_size: usize, p_user_data: ?*anyopaque) callconv(.c) [*:0]u8;

pub const ParserLineGenFunc = *const fn (p_bytes: [*]u8, p_size: usize, p_user_data: ?*anyopaque) callconv(.c) [*:0]u8;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
