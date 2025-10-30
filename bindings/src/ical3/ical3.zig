pub const ext = @import("ext.zig");
const ical = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
pub const array = extern struct {
    f_element_size: usize,
    f_increment_size: usize,
    f_num_elements: usize,
    f_space_allocated: usize,
    f_chunks: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const attach = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const compiter = extern struct {
    f_kind: ical.component_kind,
    f_iter: ?ical.pvl_elem,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const component = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const datetimeperiodtype = extern struct {
    f_time: ?*anyopaque,
    f_period: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const durationtype = extern struct {
    f_is_neg: c_int,
    f_days: c_uint,
    f_weeks: c_uint,
    f_hours: c_uint,
    f_minutes: c_uint,
    f_seconds: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const geotype = extern struct {
    f_lat: f64,
    f_lon: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const parameter = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const parser = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const periodtype = extern struct {
    f_start: ?*anyopaque,
    f_end: ?*anyopaque,
    f_duration: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const property = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const pvl_elem = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const pvl_elem_t = extern struct {
    f_MAGIC: c_int,
    f_d: ?*anyopaque,
    f_next: ?*anyopaque,
    f_prior: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const pvl_list = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const recur_iterator = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const recurrencetype = extern struct {
    f_freq: ical.recurrencetype_frequency,
    f_until: ?*anyopaque,
    f_count: c_int,
    f_interval: c_short,
    f_week_start: ical.recurrencetype_weekday,
    f_by_second: [62]c_short,
    f_by_minute: [61]c_short,
    f_by_hour: [25]c_short,
    f_by_day: [386]c_short,
    f_by_month_day: [32]c_short,
    f_by_year_day: [386]c_short,
    f_by_week_no: [56]c_short,
    f_by_month: [14]c_short,
    f_by_set_pos: [386]c_short,
    f_rscale: ?[*:0]u8,
    f_skip: ical.recurrencetype_skip,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const reqstattype = extern struct {
    f_code: ical.requeststatus,
    f_desc: ?[*:0]const u8,
    f_debug: ?[*:0]const u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const sspm_action_map = extern struct {
    f_major: ?*anyopaque,
    f_minor: ?*anyopaque,
    f_new_part: ?*const fn () callconv(.c) *anyopaque,
    f_add_line: ?*const fn (p_part: *anyopaque, p_header: *anyopaque, p_line: [*:0]const u8, p_size: usize) callconv(.c) void,
    f_end_part: ?*const fn (p_part: *anyopaque) callconv(.c) *anyopaque,
    f_free_part: ?*const fn (p_part: *anyopaque) callconv(.c) void,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const sspm_header = extern struct {
    f_def: c_int,
    f_boundary: ?[*:0]u8,
    f_major: ?*anyopaque,
    f_minor: ?*anyopaque,
    f_minor_text: ?[*:0]u8,
    f_content_type_params: ?*[*:0]u8,
    f_charset: ?[*:0]u8,
    f_encoding: ?*anyopaque,
    f_filename: ?[*:0]u8,
    f_content_id: ?[*:0]u8,
    f_error: ?*anyopaque,
    f_error_text: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const sspm_part = extern struct {
    f_header: ?*anyopaque,
    f_level: c_int,
    f_data_size: usize,
    f_data: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const time_span = extern struct {
    f_start: std.posix.time_t,
    f_end: std.posix.time_t,
    f_is_busy: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const timetype = extern struct {
    f_year: c_int,
    f_month: c_int,
    f_day: c_int,
    f_hour: c_int,
    f_minute: c_int,
    f_second: c_int,
    f_is_date: c_int,
    f_is_daylight: c_int,
    f_zone: ?*const ical.timezone,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const timezone = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const timezonephase = extern struct {
    f_tzname: ?[*:0]const u8,
    f_is_stdandard: c_int,
    f_dtstart: ?*anyopaque,
    f_offsetto: c_int,
    f_tzoffsetfrom: c_int,
    f_comment: ?[*:0]const u8,
    f_rdate: ?*anyopaque,
    f_rrule: ?[*:0]const u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const timezonetype = extern struct {
    f_tzid: ?[*:0]const u8,
    f_last_mod: ?*anyopaque,
    f_tzurl: ?[*:0]const u8,
    f_phases: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const triggertype = extern struct {
    f_time: ?*anyopaque,
    f_duration: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const value = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const _unknown_token_handling = enum(c_int) {
    assume_iana_token = 1,
    discard_token = 2,
    treat_as_error = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const component_kind = enum(c_int) {
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
    vpatch_component = 31,
    xpatch_component = 32,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const errorenum = enum(c_int) {
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

pub const errorstate = enum(c_int) {
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

pub const parameter_action = enum(c_int) {
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

pub const parameter_cutype = enum(c_int) {
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

pub const parameter_display = enum(c_int) {
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

pub const parameter_enable = enum(c_int) {
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

pub const parameter_encoding = enum(c_int) {
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

pub const parameter_fbtype = enum(c_int) {
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

pub const parameter_feature = enum(c_int) {
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

pub const parameter_kind = enum(c_int) {
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

    pub const required_parameter = parameter_kind.reason_parameter;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const parameter_local = enum(c_int) {
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

pub const parameter_partstat = enum(c_int) {
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

pub const parameter_patchaction = enum(c_int) {
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

pub const parameter_range = enum(c_int) {
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

pub const parameter_related = enum(c_int) {
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

pub const parameter_reltype = enum(c_int) {
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

pub const parameter_required = enum(c_int) {
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

pub const parameter_role = enum(c_int) {
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

pub const parameter_rsvp = enum(c_int) {
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

pub const parameter_scheduleagent = enum(c_int) {
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

pub const parameter_scheduleforcesend = enum(c_int) {
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

pub const parameter_stayinformed = enum(c_int) {
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

pub const parameter_substate = enum(c_int) {
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

pub const parameter_value = enum(c_int) {
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

pub const parameter_xliccomparetype = enum(c_int) {
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

pub const parameter_xlicerrortype = enum(c_int) {
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

pub const parser_state = enum(c_int) {
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

pub const property_action = enum(c_int) {
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

pub const property_busytype = enum(c_int) {
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

pub const property_carlevel = enum(c_int) {
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

pub const property_class = enum(c_int) {
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

pub const property_cmd = enum(c_int) {
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

pub const property_kind = enum(c_int) {
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
    conference_property = 120,
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
    image_property = 119,
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
    patchdelete_property = 124,
    patchorder_property = 122,
    patchparameter_property = 125,
    patchtarget_property = 123,
    patchversion_property = 121,
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
    refreshinterval_property = 116,
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
    source_property = 117,
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

pub const property_method = enum(c_int) {
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
    pollstatus = 10516,
    none = 10599,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const property_pollcompletion = enum(c_int) {
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

pub const property_pollmode = enum(c_int) {
    x = 10700,
    basic = 10701,
    none = 10799,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const property_querylevel = enum(c_int) {
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

pub const property_status = enum(c_int) {
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

pub const property_taskmode = enum(c_int) {
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

pub const property_transp = enum(c_int) {
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

pub const property_xlicclass = enum(c_int) {
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

pub const recurrencetype_frequency = enum(c_int) {
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

pub const recurrencetype_skip = enum(c_int) {
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

pub const recurrencetype_weekday = enum(c_int) {
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

pub const requeststatus = enum(c_int) {
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

pub const restriction_kind = enum(c_int) {
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

pub const value_kind = enum(c_int) {
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

/// }
/// ```
extern fn ical_bt() void;
pub const bt = ical_bt;

extern fn decode_base64(p_dest: [*:0]u8, p_src: [*:0]u8, p_size: *usize) [*:0]u8;
pub const decodeBase64 = decode_base64;

extern fn decode_quoted_printable(p_dest: [*:0]u8, p_src: [*:0]u8, p_size: *usize) [*:0]u8;
pub const decodeQuotedPrintable = decode_quoted_printable;

extern fn free_zone_directory() void;
pub const freeZoneDirectory = free_zone_directory;

extern fn ical_get_unknown_token_handling_setting() ical._unknown_token_handling;
pub const getUnknownTokenHandlingSetting = ical_get_unknown_token_handling_setting;

extern fn get_zone_directory() [*:0]const u8;
pub const getZoneDirectory = get_zone_directory;

extern fn icalarray_append(p_array: *ical.array, p_element: ?*anyopaque) void;
pub const icalarrayAppend = icalarray_append;

extern fn icalarray_copy(p_array: *ical.array) *ical.array;
pub const icalarrayCopy = icalarray_copy;

extern fn icalarray_element_at(p_array: *ical.array, p_position: usize) ?*anyopaque;
pub const icalarrayElementAt = icalarray_element_at;

/// `par` Usage
/// ```c
/// // create new array
/// icalarray *array = icalarray_new(sizeof(int), 1);
///
/// // use array
/// int a = 4;
/// icalarray_append(array, &a);
/// assert(*icalarray_element_at(array, 0) == a);
///
/// // release memory
/// icalarray_free(array);
/// ```
extern fn icalarray_free(p_array: *ical.array) void;
pub const icalarrayFree = icalarray_free;

extern fn icalarray_new(p_element_size: usize, p_increment_size: usize) *ical.array;
pub const icalarrayNew = icalarray_new;

extern fn icalarray_remove_element_at(p_array: *ical.array, p_position: usize) void;
pub const icalarrayRemoveElementAt = icalarray_remove_element_at;

extern fn icalarray_sort(p_array: *ical.array, p_compare: ?*anyopaque) void;
pub const icalarraySort = icalarray_sort;

extern fn icalattach_get_data(p_attach: *ical.attach) *u8;
pub const icalattachGetData = icalattach_get_data;

extern fn icalattach_get_is_url(p_attach: *ical.attach) c_int;
pub const icalattachGetIsUrl = icalattach_get_is_url;

extern fn icalattach_get_url(p_attach: *ical.attach) [*:0]const u8;
pub const icalattachGetUrl = icalattach_get_url;

extern fn icalattach_new_from_data(p_data: [*:0]const u8, p_free_fn: ical.icalattach_free_fn_t, p_free_fn_data: ?*anyopaque) *ical.attach;
pub const icalattachNewFromData = icalattach_new_from_data;

extern fn icalattach_new_from_url(p_url: [*:0]const u8) *ical.attach;
pub const icalattachNewFromUrl = icalattach_new_from_url;

extern fn icalattach_ref(p_attach: *ical.attach) void;
pub const icalattachRef = icalattach_ref;

extern fn icalattach_unref(p_attach: *ical.attach) void;
pub const icalattachUnref = icalattach_unref;

extern fn icalcompiter_deref(p_i: *ical.compiter) *ical.component;
pub const icalcompiterDeref = icalcompiter_deref;

extern fn icalcompiter_next(p_i: *ical.compiter) *ical.component;
pub const icalcompiterNext = icalcompiter_next;

extern fn icalcompiter_prior(p_i: *ical.compiter) *ical.component;
pub const icalcompiterPrior = icalcompiter_prior;

extern fn icalcomponent_add_component(p_parent: *ical.component, p_child: *ical.component) void;
pub const icalcomponentAddComponent = icalcomponent_add_component;

extern fn icalcomponent_add_property(p_component: *ical.component, p_property: *ical.property) void;
pub const icalcomponentAddProperty = icalcomponent_add_property;

extern fn icalcomponent_as_ical_string(p_component: *ical.component) [*:0]u8;
pub const icalcomponentAsIcalString = icalcomponent_as_ical_string;

extern fn icalcomponent_as_ical_string_r(p_component: *ical.component) [*:0]u8;
pub const icalcomponentAsIcalStringR = icalcomponent_as_ical_string_r;

extern fn icalcomponent_begin_component(p_component: *ical.component, p_kind: ical.component_kind) ical.compiter;
pub const icalcomponentBeginComponent = icalcomponent_begin_component;

extern fn icalcomponent_check_restrictions(p_comp: *ical.component) c_int;
pub const icalcomponentCheckRestrictions = icalcomponent_check_restrictions;

extern fn icalcomponent_convert_errors(p_component: *ical.component) void;
pub const icalcomponentConvertErrors = icalcomponent_convert_errors;

extern fn icalcomponent_count_components(p_component: *ical.component, p_kind: ical.component_kind) c_int;
pub const icalcomponentCountComponents = icalcomponent_count_components;

extern fn icalcomponent_count_errors(p_component: *ical.component) c_int;
pub const icalcomponentCountErrors = icalcomponent_count_errors;

extern fn icalcomponent_count_properties(p_component: *ical.component, p_kind: ical.property_kind) c_int;
pub const icalcomponentCountProperties = icalcomponent_count_properties;

extern fn icalcomponent_end_component(p_component: *ical.component, p_kind: ical.component_kind) ical.compiter;
pub const icalcomponentEndComponent = icalcomponent_end_component;

extern fn icalcomponent_foreach_recurrence(p_comp: *ical.component, p_start: ?*anyopaque, p_end: ?*anyopaque, p_callback: ?*anyopaque, p_callback_data: ?*anyopaque) void;
pub const icalcomponentForeachRecurrence = icalcomponent_foreach_recurrence;

extern fn icalcomponent_foreach_tzid(p_comp: *ical.component, p_callback: ?*anyopaque, p_callback_data: ?*anyopaque) void;
pub const icalcomponentForeachTzid = icalcomponent_foreach_tzid;

extern fn icalcomponent_free(p_component: *ical.component) void;
pub const icalcomponentFree = icalcomponent_free;

extern fn icalcomponent_get_comment(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetComment = icalcomponent_get_comment;

extern fn icalcomponent_get_current_component(p_component: *ical.component) *ical.component;
pub const icalcomponentGetCurrentComponent = icalcomponent_get_current_component;

extern fn icalcomponent_get_current_property(p_component: *ical.component) *ical.property;
pub const icalcomponentGetCurrentProperty = icalcomponent_get_current_property;

extern fn icalcomponent_get_description(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetDescription = icalcomponent_get_description;

extern fn icalcomponent_get_dtend(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetDtend = icalcomponent_get_dtend;

extern fn icalcomponent_get_dtstamp(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetDtstamp = icalcomponent_get_dtstamp;

extern fn icalcomponent_get_dtstart(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetDtstart = icalcomponent_get_dtstart;

extern fn icalcomponent_get_due(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetDue = icalcomponent_get_due;

extern fn icalcomponent_get_duration(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetDuration = icalcomponent_get_duration;

extern fn icalcomponent_get_first_component(p_component: *ical.component, p_kind: ical.component_kind) *ical.component;
pub const icalcomponentGetFirstComponent = icalcomponent_get_first_component;

extern fn icalcomponent_get_first_property(p_component: *ical.component, p_kind: ical.property_kind) *ical.property;
pub const icalcomponentGetFirstProperty = icalcomponent_get_first_property;

extern fn icalcomponent_get_first_real_component(p_c: *ical.component) *ical.component;
pub const icalcomponentGetFirstRealComponent = icalcomponent_get_first_real_component;

extern fn icalcomponent_get_inner(p_comp: *ical.component) *ical.component;
pub const icalcomponentGetInner = icalcomponent_get_inner;

extern fn icalcomponent_get_location(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetLocation = icalcomponent_get_location;

extern fn icalcomponent_get_method(p_comp: *ical.component) ical.property_method;
pub const icalcomponentGetMethod = icalcomponent_get_method;

extern fn icalcomponent_get_next_component(p_component: *ical.component, p_kind: ical.component_kind) *ical.component;
pub const icalcomponentGetNextComponent = icalcomponent_get_next_component;

extern fn icalcomponent_get_next_property(p_component: *ical.component, p_kind: ical.property_kind) *ical.property;
pub const icalcomponentGetNextProperty = icalcomponent_get_next_property;

extern fn icalcomponent_get_parent(p_component: *ical.component) *ical.component;
pub const icalcomponentGetParent = icalcomponent_get_parent;

extern fn icalcomponent_get_recurrenceid(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetRecurrenceid = icalcomponent_get_recurrenceid;

extern fn icalcomponent_get_relcalid(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetRelcalid = icalcomponent_get_relcalid;

extern fn icalcomponent_get_sequence(p_comp: *ical.component) c_int;
pub const icalcomponentGetSequence = icalcomponent_get_sequence;

extern fn icalcomponent_get_span(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetSpan = icalcomponent_get_span;

extern fn icalcomponent_get_status(p_comp: *ical.component) ?*anyopaque;
pub const icalcomponentGetStatus = icalcomponent_get_status;

extern fn icalcomponent_get_summary(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetSummary = icalcomponent_get_summary;

extern fn icalcomponent_get_timezone(p_comp: *ical.component, p_tzid: [*:0]const u8) *ical.timezone;
pub const icalcomponentGetTimezone = icalcomponent_get_timezone;

extern fn icalcomponent_get_uid(p_comp: *ical.component) [*:0]const u8;
pub const icalcomponentGetUid = icalcomponent_get_uid;

extern fn icalcomponent_is_valid(p_component: *ical.component) c_int;
pub const icalcomponentIsValid = icalcomponent_is_valid;

extern fn icalcomponent_isa(p_component: *const ical.component) ical.component_kind;
pub const icalcomponentIsa = icalcomponent_isa;

extern fn icalcomponent_isa_component(p_component: ?*anyopaque) c_int;
pub const icalcomponentIsaComponent = icalcomponent_isa_component;

extern fn icalcomponent_kind_is_valid(p_kind: ical.component_kind) c_int;
pub const icalcomponentKindIsValid = icalcomponent_kind_is_valid;

extern fn icalcomponent_kind_to_string(p_kind: ical.component_kind) [*:0]const u8;
pub const icalcomponentKindToString = icalcomponent_kind_to_string;

extern fn icalcomponent_merge_component(p_comp: *ical.component, p_comp_to_merge: *ical.component) void;
pub const icalcomponentMergeComponent = icalcomponent_merge_component;

extern fn icalcomponent_new(p_kind: ical.component_kind) *ical.component;
pub const icalcomponentNew = icalcomponent_new;

extern fn icalcomponent_new_clone(p_component: *ical.component) *ical.component;
pub const icalcomponentNewClone = icalcomponent_new_clone;

extern fn icalcomponent_new_from_string(p_str: [*:0]const u8) *ical.component;
pub const icalcomponentNewFromString = icalcomponent_new_from_string;

extern fn icalcomponent_new_vagenda() *ical.component;
pub const icalcomponentNewVagenda = icalcomponent_new_vagenda;

extern fn icalcomponent_new_valarm() *ical.component;
pub const icalcomponentNewValarm = icalcomponent_new_valarm;

extern fn icalcomponent_new_vavailability() *ical.component;
pub const icalcomponentNewVavailability = icalcomponent_new_vavailability;

extern fn icalcomponent_new_vcalendar() *ical.component;
pub const icalcomponentNewVcalendar = icalcomponent_new_vcalendar;

extern fn icalcomponent_new_vevent() *ical.component;
pub const icalcomponentNewVevent = icalcomponent_new_vevent;

extern fn icalcomponent_new_vfreebusy() *ical.component;
pub const icalcomponentNewVfreebusy = icalcomponent_new_vfreebusy;

extern fn icalcomponent_new_vjournal() *ical.component;
pub const icalcomponentNewVjournal = icalcomponent_new_vjournal;

extern fn icalcomponent_new_vpatch() *ical.component;
pub const icalcomponentNewVpatch = icalcomponent_new_vpatch;

extern fn icalcomponent_new_vpoll() *ical.component;
pub const icalcomponentNewVpoll = icalcomponent_new_vpoll;

extern fn icalcomponent_new_vquery() *ical.component;
pub const icalcomponentNewVquery = icalcomponent_new_vquery;

extern fn icalcomponent_new_vtimezone() *ical.component;
pub const icalcomponentNewVtimezone = icalcomponent_new_vtimezone;

extern fn icalcomponent_new_vtodo() *ical.component;
pub const icalcomponentNewVtodo = icalcomponent_new_vtodo;

extern fn icalcomponent_new_vvoter() *ical.component;
pub const icalcomponentNewVvoter = icalcomponent_new_vvoter;

extern fn icalcomponent_new_x(p_x_name: [*:0]const u8) *ical.component;
pub const icalcomponentNewX = icalcomponent_new_x;

extern fn icalcomponent_new_xavailable() *ical.component;
pub const icalcomponentNewXavailable = icalcomponent_new_xavailable;

extern fn icalcomponent_new_xdaylight() *ical.component;
pub const icalcomponentNewXdaylight = icalcomponent_new_xdaylight;

extern fn icalcomponent_new_xpatch() *ical.component;
pub const icalcomponentNewXpatch = icalcomponent_new_xpatch;

extern fn icalcomponent_new_xstandard() *ical.component;
pub const icalcomponentNewXstandard = icalcomponent_new_xstandard;

extern fn icalcomponent_new_xvote() *ical.component;
pub const icalcomponentNewXvote = icalcomponent_new_xvote;

extern fn icalcomponent_normalize(p_comp: *ical.component) void;
pub const icalcomponentNormalize = icalcomponent_normalize;

extern fn icalcomponent_remove_component(p_parent: *ical.component, p_child: *ical.component) void;
pub const icalcomponentRemoveComponent = icalcomponent_remove_component;

extern fn icalcomponent_remove_property(p_component: *ical.component, p_property: *ical.property) void;
pub const icalcomponentRemoveProperty = icalcomponent_remove_property;

extern fn icalcomponent_set_comment(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetComment = icalcomponent_set_comment;

extern fn icalcomponent_set_description(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetDescription = icalcomponent_set_description;

extern fn icalcomponent_set_dtend(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetDtend = icalcomponent_set_dtend;

extern fn icalcomponent_set_dtstamp(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetDtstamp = icalcomponent_set_dtstamp;

extern fn icalcomponent_set_dtstart(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetDtstart = icalcomponent_set_dtstart;

extern fn icalcomponent_set_due(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetDue = icalcomponent_set_due;

extern fn icalcomponent_set_duration(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetDuration = icalcomponent_set_duration;

extern fn icalcomponent_set_location(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetLocation = icalcomponent_set_location;

extern fn icalcomponent_set_method(p_comp: *ical.component, p_method: ical.property_method) void;
pub const icalcomponentSetMethod = icalcomponent_set_method;

extern fn icalcomponent_set_parent(p_component: *ical.component, p_parent: *ical.component) void;
pub const icalcomponentSetParent = icalcomponent_set_parent;

extern fn icalcomponent_set_recurrenceid(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetRecurrenceid = icalcomponent_set_recurrenceid;

extern fn icalcomponent_set_relcalid(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetRelcalid = icalcomponent_set_relcalid;

extern fn icalcomponent_set_sequence(p_comp: *ical.component, p_v: c_int) void;
pub const icalcomponentSetSequence = icalcomponent_set_sequence;

extern fn icalcomponent_set_status(p_comp: *ical.component, p_v: ?*anyopaque) void;
pub const icalcomponentSetStatus = icalcomponent_set_status;

extern fn icalcomponent_set_summary(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetSummary = icalcomponent_set_summary;

extern fn icalcomponent_set_uid(p_comp: *ical.component, p_v: [*:0]const u8) void;
pub const icalcomponentSetUid = icalcomponent_set_uid;

extern fn icalcomponent_string_to_kind(p_string: [*:0]const u8) ical.component_kind;
pub const icalcomponentStringToKind = icalcomponent_string_to_kind;

extern fn icalcomponent_strip_errors(p_component: *ical.component) void;
pub const icalcomponentStripErrors = icalcomponent_strip_errors;

extern fn icalcomponent_vanew(p_kind: ical.component_kind, ...) *ical.component;
pub const icalcomponentVanew = icalcomponent_vanew;

extern fn icaldurationtype_as_ical_string(p_d: ?*anyopaque) [*:0]u8;
pub const icaldurationtypeAsIcalString = icaldurationtype_as_ical_string;

extern fn icaldurationtype_as_ical_string_r(p_d: ?*anyopaque) [*:0]u8;
pub const icaldurationtypeAsIcalStringR = icaldurationtype_as_ical_string_r;

extern fn icaldurationtype_as_int(p_duration: ?*anyopaque) c_int;
pub const icaldurationtypeAsInt = icaldurationtype_as_int;

extern fn icaldurationtype_bad_duration() ?*anyopaque;
pub const icaldurationtypeBadDuration = icaldurationtype_bad_duration;

extern fn icaldurationtype_from_int(p_t: c_int) ?*anyopaque;
pub const icaldurationtypeFromInt = icaldurationtype_from_int;

extern fn icaldurationtype_from_string(p_dur: [*:0]const u8) ?*anyopaque;
pub const icaldurationtypeFromString = icaldurationtype_from_string;

extern fn icaldurationtype_is_bad_duration(p_d: ?*anyopaque) c_int;
pub const icaldurationtypeIsBadDuration = icaldurationtype_is_bad_duration;

extern fn icaldurationtype_is_null_duration(p_d: ?*anyopaque) c_int;
pub const icaldurationtypeIsNullDuration = icaldurationtype_is_null_duration;

extern fn icaldurationtype_null_duration() ?*anyopaque;
pub const icaldurationtypeNullDuration = icaldurationtype_null_duration;

extern fn icalenum_num_to_reqstat(p_major: c_short, p_minor: c_short) ical.requeststatus;
pub const icalenumNumToReqstat = icalenum_num_to_reqstat;

extern fn icalenum_reqstat_code(p_stat: ical.requeststatus) [*:0]u8;
pub const icalenumReqstatCode = icalenum_reqstat_code;

extern fn icalenum_reqstat_code_r(p_stat: ical.requeststatus) [*:0]u8;
pub const icalenumReqstatCodeR = icalenum_reqstat_code_r;

extern fn icalenum_reqstat_desc(p_stat: ical.requeststatus) [*:0]const u8;
pub const icalenumReqstatDesc = icalenum_reqstat_desc;

extern fn icalenum_reqstat_major(p_stat: ical.requeststatus) c_short;
pub const icalenumReqstatMajor = icalenum_reqstat_major;

extern fn icalenum_reqstat_minor(p_stat: ical.requeststatus) c_short;
pub const icalenumReqstatMinor = icalenum_reqstat_minor;

extern fn icalerrno_return() *ical.errorenum;
pub const icalerrnoReturn = icalerrno_return;

/// }
/// ```
extern fn icalerror_clear_errno() void;
pub const icalerrorClearErrno = icalerror_clear_errno;

extern fn icalerror_crash_here() void;
pub const icalerrorCrashHere = icalerror_crash_here;

extern fn icalerror_error_from_string(p_str: [*:0]const u8) ical.errorenum;
pub const icalerrorErrorFromString = icalerror_error_from_string;

extern fn icalerror_get_error_state(p_error: ical.errorenum) ical.errorstate;
pub const icalerrorGetErrorState = icalerror_get_error_state;

extern fn icalerror_get_errors_are_fatal() c_int;
pub const icalerrorGetErrorsAreFatal = icalerror_get_errors_are_fatal;

extern fn icalerror_perror() [*:0]const u8;
pub const icalerrorPerror = icalerror_perror;

extern fn icalerror_restore(p_error: [*:0]const u8, p_es: ical.errorstate) void;
pub const icalerrorRestore = icalerror_restore;

extern fn icalerror_set_errno(p_x: ical.errorenum) void;
pub const icalerrorSetErrno = icalerror_set_errno;

extern fn icalerror_set_error_state(p_error: ical.errorenum, p_state: ical.errorstate) void;
pub const icalerrorSetErrorState = icalerror_set_error_state;

extern fn icalerror_set_errors_are_fatal(p_fatal: c_int) void;
pub const icalerrorSetErrorsAreFatal = icalerror_set_errors_are_fatal;

extern fn icalerror_stop_here() void;
pub const icalerrorStopHere = icalerror_stop_here;

extern fn icalerror_strerror(p_e: ical.errorenum) [*:0]const u8;
pub const icalerrorStrerror = icalerror_strerror;

extern fn icalerror_supress(p_error: [*:0]const u8) ical.errorstate;
pub const icalerrorSupress = icalerror_supress;

extern fn icallangbind_access_array(p_array: *c_int, p_index: c_int) c_int;
pub const icallangbindAccessArray = icallangbind_access_array;

extern fn icallangbind_free_array(p_array: *c_int) void;
pub const icallangbindFreeArray = icallangbind_free_array;

extern fn icallangbind_get_first_component(p_c: *ical.component, p_comp: [*:0]const u8) *ical.component;
pub const icallangbindGetFirstComponent = icallangbind_get_first_component;

extern fn icallangbind_get_first_parameter(p_prop: *ical.property) *ical.parameter;
pub const icallangbindGetFirstParameter = icallangbind_get_first_parameter;

extern fn icallangbind_get_first_property(p_c: *ical.component, p_prop: [*:0]const u8) *ical.property;
pub const icallangbindGetFirstProperty = icallangbind_get_first_property;

extern fn icallangbind_get_next_component(p_c: *ical.component, p_comp: [*:0]const u8) *ical.component;
pub const icallangbindGetNextComponent = icallangbind_get_next_component;

extern fn icallangbind_get_next_parameter(p_prop: *ical.property) *ical.parameter;
pub const icallangbindGetNextParameter = icallangbind_get_next_parameter;

extern fn icallangbind_get_next_property(p_c: *ical.component, p_prop: [*:0]const u8) *ical.property;
pub const icallangbindGetNextProperty = icallangbind_get_next_property;

extern fn icallangbind_new_array(p_size: c_int) *c_int;
pub const icallangbindNewArray = icallangbind_new_array;

extern fn icallangbind_property_eval_string(p_prop: *ical.property, p_sep: [*:0]const u8) [*:0]const u8;
pub const icallangbindPropertyEvalString = icallangbind_property_eval_string;

extern fn icallangbind_property_eval_string_r(p_prop: *ical.property, p_sep: [*:0]const u8) [*:0]u8;
pub const icallangbindPropertyEvalStringR = icallangbind_property_eval_string_r;

extern fn icallangbind_quote_as_ical(p_str: [*:0]const u8) [*:0]const u8;
pub const icallangbindQuoteAsIcal = icallangbind_quote_as_ical;

extern fn icallangbind_quote_as_ical_r(p_str: [*:0]const u8) [*:0]u8;
pub const icallangbindQuoteAsIcalR = icallangbind_quote_as_ical_r;

extern fn icallangbind_string_to_open_flag(p_str: [*:0]const u8) c_int;
pub const icallangbindStringToOpenFlag = icallangbind_string_to_open_flag;

extern fn icalmemory_add_tmp_buffer(p_buf: ?*anyopaque) void;
pub const icalmemoryAddTmpBuffer = icalmemory_add_tmp_buffer;

extern fn icalmemory_append_char(p_buf: *[*:0]u8, p_pos: *[*:0]u8, p_buf_size: *usize, p_ch: u8) void;
pub const icalmemoryAppendChar = icalmemory_append_char;

extern fn icalmemory_append_string(p_buf: *[*:0]u8, p_pos: *[*:0]u8, p_buf_size: *usize, p_string: [*:0]const u8) void;
pub const icalmemoryAppendString = icalmemory_append_string;

extern fn icalmemory_free_buffer(p_buf: ?*anyopaque) void;
pub const icalmemoryFreeBuffer = icalmemory_free_buffer;

/// ```
extern fn icalmemory_free_ring() void;
pub const icalmemoryFreeRing = icalmemory_free_ring;

extern fn icalmemory_new_buffer(p_size: usize) ?*anyopaque;
pub const icalmemoryNewBuffer = icalmemory_new_buffer;

extern fn icalmemory_resize_buffer(p_buf: ?*anyopaque, p_size: usize) ?*anyopaque;
pub const icalmemoryResizeBuffer = icalmemory_resize_buffer;

extern fn icalmemory_strdup(p_s: [*:0]const u8) [*:0]u8;
pub const icalmemoryStrdup = icalmemory_strdup;

extern fn icalmemory_tmp_buffer(p_size: usize) ?*anyopaque;
pub const icalmemoryTmpBuffer = icalmemory_tmp_buffer;

extern fn icalmemory_tmp_copy(p_str: [*:0]const u8) [*:0]u8;
pub const icalmemoryTmpCopy = icalmemory_tmp_copy;

extern fn icalmime_parse(p_line_gen_func: ?*anyopaque, p_data: ?*anyopaque) *ical.component;
pub const icalmimeParse = icalmime_parse;

/// `par` Usage
/// ```c
/// icalparameter *param = icalparameter_new_from_string("ROLE=CHAIR");
///
/// if(param) {
///     char *str = icalparameter_as_ical_string(param);
///     printf("`s`\n", str);
///     free(str);
/// }
///
/// icalparameter_free(param);
/// ```
extern fn icalparameter_as_ical_string(p_parameter: *ical.parameter) [*:0]u8;
pub const icalparameterAsIcalString = icalparameter_as_ical_string;

extern fn icalparameter_as_ical_string_r(p_parameter: *ical.parameter) [*:0]u8;
pub const icalparameterAsIcalStringR = icalparameter_as_ical_string_r;

extern fn icalparameter_enum_to_string(p_e: c_int) [*:0]const u8;
pub const icalparameterEnumToString = icalparameter_enum_to_string;

extern fn icalparameter_free(p_parameter: *ical.parameter) void;
pub const icalparameterFree = icalparameter_free;

extern fn icalparameter_get_actionparam(p_value: *const ical.parameter) ical.parameter_action;
pub const icalparameterGetActionparam = icalparameter_get_actionparam;

extern fn icalparameter_get_altrep(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetAltrep = icalparameter_get_altrep;

extern fn icalparameter_get_charset(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetCharset = icalparameter_get_charset;

extern fn icalparameter_get_cn(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetCn = icalparameter_get_cn;

extern fn icalparameter_get_cutype(p_value: *const ical.parameter) ical.parameter_cutype;
pub const icalparameterGetCutype = icalparameter_get_cutype;

extern fn icalparameter_get_delegatedfrom(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetDelegatedfrom = icalparameter_get_delegatedfrom;

extern fn icalparameter_get_delegatedto(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetDelegatedto = icalparameter_get_delegatedto;

extern fn icalparameter_get_dir(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetDir = icalparameter_get_dir;

extern fn icalparameter_get_display(p_value: *const ical.parameter) ical.parameter_display;
pub const icalparameterGetDisplay = icalparameter_get_display;

extern fn icalparameter_get_email(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetEmail = icalparameter_get_email;

extern fn icalparameter_get_enable(p_value: *const ical.parameter) ical.parameter_enable;
pub const icalparameterGetEnable = icalparameter_get_enable;

extern fn icalparameter_get_encoding(p_value: *const ical.parameter) ical.parameter_encoding;
pub const icalparameterGetEncoding = icalparameter_get_encoding;

extern fn icalparameter_get_fbtype(p_value: *const ical.parameter) ical.parameter_fbtype;
pub const icalparameterGetFbtype = icalparameter_get_fbtype;

extern fn icalparameter_get_feature(p_value: *const ical.parameter) ical.parameter_feature;
pub const icalparameterGetFeature = icalparameter_get_feature;

extern fn icalparameter_get_filename(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetFilename = icalparameter_get_filename;

extern fn icalparameter_get_fmttype(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetFmttype = icalparameter_get_fmttype;

extern fn icalparameter_get_iana(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetIana = icalparameter_get_iana;

extern fn icalparameter_get_iana_name(p_param: *ical.parameter) [*:0]const u8;
pub const icalparameterGetIanaName = icalparameter_get_iana_name;

extern fn icalparameter_get_iana_value(p_param: *ical.parameter) [*:0]const u8;
pub const icalparameterGetIanaValue = icalparameter_get_iana_value;

extern fn icalparameter_get_id(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetId = icalparameter_get_id;

extern fn icalparameter_get_label(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetLabel = icalparameter_get_label;

extern fn icalparameter_get_language(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetLanguage = icalparameter_get_language;

extern fn icalparameter_get_latency(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetLatency = icalparameter_get_latency;

extern fn icalparameter_get_local(p_value: *const ical.parameter) ical.parameter_local;
pub const icalparameterGetLocal = icalparameter_get_local;

extern fn icalparameter_get_localize(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetLocalize = icalparameter_get_localize;

extern fn icalparameter_get_managedid(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetManagedid = icalparameter_get_managedid;

extern fn icalparameter_get_member(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetMember = icalparameter_get_member;

extern fn icalparameter_get_modified(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetModified = icalparameter_get_modified;

extern fn icalparameter_get_options(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetOptions = icalparameter_get_options;

extern fn icalparameter_get_parent(p_param: *ical.parameter) *ical.property;
pub const icalparameterGetParent = icalparameter_get_parent;

extern fn icalparameter_get_partstat(p_value: *const ical.parameter) ical.parameter_partstat;
pub const icalparameterGetPartstat = icalparameter_get_partstat;

extern fn icalparameter_get_patchaction(p_value: *const ical.parameter) ical.parameter_patchaction;
pub const icalparameterGetPatchaction = icalparameter_get_patchaction;

extern fn icalparameter_get_publiccomment(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetPubliccomment = icalparameter_get_publiccomment;

extern fn icalparameter_get_range(p_value: *const ical.parameter) ical.parameter_range;
pub const icalparameterGetRange = icalparameter_get_range;

extern fn icalparameter_get_reason(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetReason = icalparameter_get_reason;

extern fn icalparameter_get_related(p_value: *const ical.parameter) ical.parameter_related;
pub const icalparameterGetRelated = icalparameter_get_related;

extern fn icalparameter_get_reltype(p_value: *const ical.parameter) ical.parameter_reltype;
pub const icalparameterGetReltype = icalparameter_get_reltype;

extern fn icalparameter_get_required(p_value: *const ical.parameter) ical.parameter_required;
pub const icalparameterGetRequired = icalparameter_get_required;

extern fn icalparameter_get_response(p_value: *const ical.parameter) c_int;
pub const icalparameterGetResponse = icalparameter_get_response;

extern fn icalparameter_get_role(p_value: *const ical.parameter) ical.parameter_role;
pub const icalparameterGetRole = icalparameter_get_role;

extern fn icalparameter_get_rsvp(p_value: *const ical.parameter) ical.parameter_rsvp;
pub const icalparameterGetRsvp = icalparameter_get_rsvp;

extern fn icalparameter_get_scheduleagent(p_value: *const ical.parameter) ical.parameter_scheduleagent;
pub const icalparameterGetScheduleagent = icalparameter_get_scheduleagent;

extern fn icalparameter_get_scheduleforcesend(p_value: *const ical.parameter) ical.parameter_scheduleforcesend;
pub const icalparameterGetScheduleforcesend = icalparameter_get_scheduleforcesend;

extern fn icalparameter_get_schedulestatus(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetSchedulestatus = icalparameter_get_schedulestatus;

extern fn icalparameter_get_sentby(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetSentby = icalparameter_get_sentby;

extern fn icalparameter_get_size(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetSize = icalparameter_get_size;

extern fn icalparameter_get_stayinformed(p_value: *const ical.parameter) ical.parameter_stayinformed;
pub const icalparameterGetStayinformed = icalparameter_get_stayinformed;

extern fn icalparameter_get_substate(p_value: *const ical.parameter) ical.parameter_substate;
pub const icalparameterGetSubstate = icalparameter_get_substate;

extern fn icalparameter_get_tzid(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetTzid = icalparameter_get_tzid;

extern fn icalparameter_get_value(p_value: *const ical.parameter) ical.parameter_value;
pub const icalparameterGetValue = icalparameter_get_value;

extern fn icalparameter_get_x(p_value: *const ical.parameter) [*:0]const u8;
pub const icalparameterGetX = icalparameter_get_x;

extern fn icalparameter_get_xliccomparetype(p_value: *const ical.parameter) ical.parameter_xliccomparetype;
pub const icalparameterGetXliccomparetype = icalparameter_get_xliccomparetype;

extern fn icalparameter_get_xlicerrortype(p_value: *const ical.parameter) ical.parameter_xlicerrortype;
pub const icalparameterGetXlicerrortype = icalparameter_get_xlicerrortype;

extern fn icalparameter_get_xname(p_param: *ical.parameter) [*:0]const u8;
pub const icalparameterGetXname = icalparameter_get_xname;

extern fn icalparameter_get_xvalue(p_param: *ical.parameter) [*:0]const u8;
pub const icalparameterGetXvalue = icalparameter_get_xvalue;

extern fn icalparameter_has_same_name(p_param1: *ical.parameter, p_param2: *ical.parameter) c_int;
pub const icalparameterHasSameName = icalparameter_has_same_name;

extern fn icalparameter_isa(p_parameter: *ical.parameter) ical.parameter_kind;
pub const icalparameterIsa = icalparameter_isa;

extern fn icalparameter_isa_parameter(p_param: ?*anyopaque) c_int;
pub const icalparameterIsaParameter = icalparameter_isa_parameter;

extern fn icalparameter_kind_is_valid(p_kind: ical.parameter_kind) c_int;
pub const icalparameterKindIsValid = icalparameter_kind_is_valid;

extern fn icalparameter_kind_to_string(p_kind: ical.parameter_kind) [*:0]const u8;
pub const icalparameterKindToString = icalparameter_kind_to_string;

extern fn icalparameter_new(p_kind: ical.parameter_kind) *ical.parameter;
pub const icalparameterNew = icalparameter_new;

extern fn icalparameter_new_actionparam(p_v: ical.parameter_action) *ical.parameter;
pub const icalparameterNewActionparam = icalparameter_new_actionparam;

extern fn icalparameter_new_altrep(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewAltrep = icalparameter_new_altrep;

extern fn icalparameter_new_charset(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewCharset = icalparameter_new_charset;

extern fn icalparameter_new_clone(p_p: *ical.parameter) *ical.parameter;
pub const icalparameterNewClone = icalparameter_new_clone;

extern fn icalparameter_new_cn(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewCn = icalparameter_new_cn;

extern fn icalparameter_new_cutype(p_v: ical.parameter_cutype) *ical.parameter;
pub const icalparameterNewCutype = icalparameter_new_cutype;

extern fn icalparameter_new_delegatedfrom(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewDelegatedfrom = icalparameter_new_delegatedfrom;

extern fn icalparameter_new_delegatedto(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewDelegatedto = icalparameter_new_delegatedto;

extern fn icalparameter_new_dir(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewDir = icalparameter_new_dir;

extern fn icalparameter_new_display(p_v: ical.parameter_display) *ical.parameter;
pub const icalparameterNewDisplay = icalparameter_new_display;

extern fn icalparameter_new_email(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewEmail = icalparameter_new_email;

extern fn icalparameter_new_enable(p_v: ical.parameter_enable) *ical.parameter;
pub const icalparameterNewEnable = icalparameter_new_enable;

extern fn icalparameter_new_encoding(p_v: ical.parameter_encoding) *ical.parameter;
pub const icalparameterNewEncoding = icalparameter_new_encoding;

extern fn icalparameter_new_fbtype(p_v: ical.parameter_fbtype) *ical.parameter;
pub const icalparameterNewFbtype = icalparameter_new_fbtype;

extern fn icalparameter_new_feature(p_v: ical.parameter_feature) *ical.parameter;
pub const icalparameterNewFeature = icalparameter_new_feature;

extern fn icalparameter_new_filename(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewFilename = icalparameter_new_filename;

extern fn icalparameter_new_fmttype(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewFmttype = icalparameter_new_fmttype;

/// when they are not needed anymore and to be released.
/// `par` Usage
/// ```c
/// icalparameter *param = `ical.icalparameterNew`;
///
/// if(param) {
///     // use param...
/// }
///
/// // after use, release it
/// icalparameter_free(param);
/// ```
extern fn icalparameter_new_from_string(p_value: [*:0]const u8) *ical.parameter;
pub const icalparameterNewFromString = icalparameter_new_from_string;

extern fn icalparameter_new_from_value_string(p_kind: ical.parameter_kind, p_value: [*:0]const u8) *ical.parameter;
pub const icalparameterNewFromValueString = icalparameter_new_from_value_string;

extern fn icalparameter_new_iana(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewIana = icalparameter_new_iana;

extern fn icalparameter_new_id(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewId = icalparameter_new_id;

extern fn icalparameter_new_label(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewLabel = icalparameter_new_label;

extern fn icalparameter_new_language(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewLanguage = icalparameter_new_language;

extern fn icalparameter_new_latency(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewLatency = icalparameter_new_latency;

extern fn icalparameter_new_local(p_v: ical.parameter_local) *ical.parameter;
pub const icalparameterNewLocal = icalparameter_new_local;

extern fn icalparameter_new_localize(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewLocalize = icalparameter_new_localize;

extern fn icalparameter_new_managedid(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewManagedid = icalparameter_new_managedid;

extern fn icalparameter_new_member(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewMember = icalparameter_new_member;

extern fn icalparameter_new_modified(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewModified = icalparameter_new_modified;

extern fn icalparameter_new_options(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewOptions = icalparameter_new_options;

extern fn icalparameter_new_partstat(p_v: ical.parameter_partstat) *ical.parameter;
pub const icalparameterNewPartstat = icalparameter_new_partstat;

extern fn icalparameter_new_patchaction(p_v: ical.parameter_patchaction) *ical.parameter;
pub const icalparameterNewPatchaction = icalparameter_new_patchaction;

extern fn icalparameter_new_publiccomment(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewPubliccomment = icalparameter_new_publiccomment;

extern fn icalparameter_new_range(p_v: ical.parameter_range) *ical.parameter;
pub const icalparameterNewRange = icalparameter_new_range;

extern fn icalparameter_new_reason(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewReason = icalparameter_new_reason;

extern fn icalparameter_new_related(p_v: ical.parameter_related) *ical.parameter;
pub const icalparameterNewRelated = icalparameter_new_related;

extern fn icalparameter_new_reltype(p_v: ical.parameter_reltype) *ical.parameter;
pub const icalparameterNewReltype = icalparameter_new_reltype;

extern fn icalparameter_new_required(p_v: ical.parameter_required) *ical.parameter;
pub const icalparameterNewRequired = icalparameter_new_required;

extern fn icalparameter_new_response(p_v: c_int) *ical.parameter;
pub const icalparameterNewResponse = icalparameter_new_response;

extern fn icalparameter_new_role(p_v: ical.parameter_role) *ical.parameter;
pub const icalparameterNewRole = icalparameter_new_role;

extern fn icalparameter_new_rsvp(p_v: ical.parameter_rsvp) *ical.parameter;
pub const icalparameterNewRsvp = icalparameter_new_rsvp;

extern fn icalparameter_new_scheduleagent(p_v: ical.parameter_scheduleagent) *ical.parameter;
pub const icalparameterNewScheduleagent = icalparameter_new_scheduleagent;

extern fn icalparameter_new_scheduleforcesend(p_v: ical.parameter_scheduleforcesend) *ical.parameter;
pub const icalparameterNewScheduleforcesend = icalparameter_new_scheduleforcesend;

extern fn icalparameter_new_schedulestatus(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewSchedulestatus = icalparameter_new_schedulestatus;

extern fn icalparameter_new_sentby(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewSentby = icalparameter_new_sentby;

extern fn icalparameter_new_size(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewSize = icalparameter_new_size;

extern fn icalparameter_new_stayinformed(p_v: ical.parameter_stayinformed) *ical.parameter;
pub const icalparameterNewStayinformed = icalparameter_new_stayinformed;

extern fn icalparameter_new_substate(p_v: ical.parameter_substate) *ical.parameter;
pub const icalparameterNewSubstate = icalparameter_new_substate;

extern fn icalparameter_new_tzid(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewTzid = icalparameter_new_tzid;

extern fn icalparameter_new_value(p_v: ical.parameter_value) *ical.parameter;
pub const icalparameterNewValue = icalparameter_new_value;

extern fn icalparameter_new_x(p_v: [*:0]const u8) *ical.parameter;
pub const icalparameterNewX = icalparameter_new_x;

extern fn icalparameter_new_xliccomparetype(p_v: ical.parameter_xliccomparetype) *ical.parameter;
pub const icalparameterNewXliccomparetype = icalparameter_new_xliccomparetype;

extern fn icalparameter_new_xlicerrortype(p_v: ical.parameter_xlicerrortype) *ical.parameter;
pub const icalparameterNewXlicerrortype = icalparameter_new_xlicerrortype;

extern fn icalparameter_set_actionparam(p_value: *ical.parameter, p_v: ical.parameter_action) void;
pub const icalparameterSetActionparam = icalparameter_set_actionparam;

extern fn icalparameter_set_altrep(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetAltrep = icalparameter_set_altrep;

extern fn icalparameter_set_charset(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetCharset = icalparameter_set_charset;

extern fn icalparameter_set_cn(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetCn = icalparameter_set_cn;

extern fn icalparameter_set_cutype(p_value: *ical.parameter, p_v: ical.parameter_cutype) void;
pub const icalparameterSetCutype = icalparameter_set_cutype;

extern fn icalparameter_set_delegatedfrom(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetDelegatedfrom = icalparameter_set_delegatedfrom;

extern fn icalparameter_set_delegatedto(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetDelegatedto = icalparameter_set_delegatedto;

extern fn icalparameter_set_dir(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetDir = icalparameter_set_dir;

extern fn icalparameter_set_display(p_value: *ical.parameter, p_v: ical.parameter_display) void;
pub const icalparameterSetDisplay = icalparameter_set_display;

extern fn icalparameter_set_email(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetEmail = icalparameter_set_email;

extern fn icalparameter_set_enable(p_value: *ical.parameter, p_v: ical.parameter_enable) void;
pub const icalparameterSetEnable = icalparameter_set_enable;

extern fn icalparameter_set_encoding(p_value: *ical.parameter, p_v: ical.parameter_encoding) void;
pub const icalparameterSetEncoding = icalparameter_set_encoding;

extern fn icalparameter_set_fbtype(p_value: *ical.parameter, p_v: ical.parameter_fbtype) void;
pub const icalparameterSetFbtype = icalparameter_set_fbtype;

extern fn icalparameter_set_feature(p_value: *ical.parameter, p_v: ical.parameter_feature) void;
pub const icalparameterSetFeature = icalparameter_set_feature;

extern fn icalparameter_set_filename(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetFilename = icalparameter_set_filename;

extern fn icalparameter_set_fmttype(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetFmttype = icalparameter_set_fmttype;

extern fn icalparameter_set_iana(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetIana = icalparameter_set_iana;

extern fn icalparameter_set_iana_name(p_param: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetIanaName = icalparameter_set_iana_name;

extern fn icalparameter_set_iana_value(p_param: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetIanaValue = icalparameter_set_iana_value;

extern fn icalparameter_set_id(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetId = icalparameter_set_id;

extern fn icalparameter_set_label(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetLabel = icalparameter_set_label;

extern fn icalparameter_set_language(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetLanguage = icalparameter_set_language;

extern fn icalparameter_set_latency(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetLatency = icalparameter_set_latency;

extern fn icalparameter_set_local(p_value: *ical.parameter, p_v: ical.parameter_local) void;
pub const icalparameterSetLocal = icalparameter_set_local;

extern fn icalparameter_set_localize(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetLocalize = icalparameter_set_localize;

extern fn icalparameter_set_managedid(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetManagedid = icalparameter_set_managedid;

extern fn icalparameter_set_member(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetMember = icalparameter_set_member;

extern fn icalparameter_set_modified(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetModified = icalparameter_set_modified;

extern fn icalparameter_set_options(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetOptions = icalparameter_set_options;

extern fn icalparameter_set_parent(p_param: *ical.parameter, p_property: *ical.property) void;
pub const icalparameterSetParent = icalparameter_set_parent;

extern fn icalparameter_set_partstat(p_value: *ical.parameter, p_v: ical.parameter_partstat) void;
pub const icalparameterSetPartstat = icalparameter_set_partstat;

extern fn icalparameter_set_patchaction(p_value: *ical.parameter, p_v: ical.parameter_patchaction) void;
pub const icalparameterSetPatchaction = icalparameter_set_patchaction;

extern fn icalparameter_set_publiccomment(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetPubliccomment = icalparameter_set_publiccomment;

extern fn icalparameter_set_range(p_value: *ical.parameter, p_v: ical.parameter_range) void;
pub const icalparameterSetRange = icalparameter_set_range;

extern fn icalparameter_set_reason(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetReason = icalparameter_set_reason;

extern fn icalparameter_set_related(p_value: *ical.parameter, p_v: ical.parameter_related) void;
pub const icalparameterSetRelated = icalparameter_set_related;

extern fn icalparameter_set_reltype(p_value: *ical.parameter, p_v: ical.parameter_reltype) void;
pub const icalparameterSetReltype = icalparameter_set_reltype;

extern fn icalparameter_set_required(p_value: *ical.parameter, p_v: ical.parameter_required) void;
pub const icalparameterSetRequired = icalparameter_set_required;

extern fn icalparameter_set_response(p_value: *ical.parameter, p_v: c_int) void;
pub const icalparameterSetResponse = icalparameter_set_response;

extern fn icalparameter_set_role(p_value: *ical.parameter, p_v: ical.parameter_role) void;
pub const icalparameterSetRole = icalparameter_set_role;

extern fn icalparameter_set_rsvp(p_value: *ical.parameter, p_v: ical.parameter_rsvp) void;
pub const icalparameterSetRsvp = icalparameter_set_rsvp;

extern fn icalparameter_set_scheduleagent(p_value: *ical.parameter, p_v: ical.parameter_scheduleagent) void;
pub const icalparameterSetScheduleagent = icalparameter_set_scheduleagent;

extern fn icalparameter_set_scheduleforcesend(p_value: *ical.parameter, p_v: ical.parameter_scheduleforcesend) void;
pub const icalparameterSetScheduleforcesend = icalparameter_set_scheduleforcesend;

extern fn icalparameter_set_schedulestatus(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetSchedulestatus = icalparameter_set_schedulestatus;

extern fn icalparameter_set_sentby(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetSentby = icalparameter_set_sentby;

extern fn icalparameter_set_size(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetSize = icalparameter_set_size;

extern fn icalparameter_set_stayinformed(p_value: *ical.parameter, p_v: ical.parameter_stayinformed) void;
pub const icalparameterSetStayinformed = icalparameter_set_stayinformed;

extern fn icalparameter_set_substate(p_value: *ical.parameter, p_v: ical.parameter_substate) void;
pub const icalparameterSetSubstate = icalparameter_set_substate;

extern fn icalparameter_set_tzid(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetTzid = icalparameter_set_tzid;

extern fn icalparameter_set_value(p_value: *ical.parameter, p_v: ical.parameter_value) void;
pub const icalparameterSetValue = icalparameter_set_value;

extern fn icalparameter_set_x(p_value: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetX = icalparameter_set_x;

extern fn icalparameter_set_xliccomparetype(p_value: *ical.parameter, p_v: ical.parameter_xliccomparetype) void;
pub const icalparameterSetXliccomparetype = icalparameter_set_xliccomparetype;

extern fn icalparameter_set_xlicerrortype(p_value: *ical.parameter, p_v: ical.parameter_xlicerrortype) void;
pub const icalparameterSetXlicerrortype = icalparameter_set_xlicerrortype;

extern fn icalparameter_set_xname(p_param: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetXname = icalparameter_set_xname;

extern fn icalparameter_set_xvalue(p_param: *ical.parameter, p_v: [*:0]const u8) void;
pub const icalparameterSetXvalue = icalparameter_set_xvalue;

extern fn icalparameter_string_to_enum(p_str: [*:0]const u8) c_int;
pub const icalparameterStringToEnum = icalparameter_string_to_enum;

extern fn icalparameter_string_to_kind(p_string: [*:0]const u8) ical.parameter_kind;
pub const icalparameterStringToKind = icalparameter_string_to_kind;

extern fn icalparameter_value_to_value_kind(p_value: ical.parameter_value) ical.value_kind;
pub const icalparameterValueToValueKind = icalparameter_value_to_value_kind;

extern fn icalparser_add_line(p_parser: *ical.parser, p_str: [*:0]u8) *ical.component;
pub const icalparserAddLine = icalparser_add_line;

extern fn icalparser_clean(p_parser: *ical.parser) *ical.component;
pub const icalparserClean = icalparser_clean;

extern fn icalparser_free(p_parser: *ical.parser) void;
pub const icalparserFree = icalparser_free;

extern fn icalparser_get_ctrl() ?*anyopaque;
pub const icalparserGetCtrl = icalparser_get_ctrl;

extern fn icalparser_get_line(p_parser: *ical.parser, p_line_gen_func: ical.icalparser_line_gen_func) [*:0]u8;
pub const icalparserGetLine = icalparser_get_line;

extern fn icalparser_get_state(p_parser: *ical.parser) ical.parser_state;
pub const icalparserGetState = icalparser_get_state;

extern fn icalparser_new() *ical.parser;
pub const icalparserNew = icalparser_new;

extern fn icalparser_parse(p_parser: *ical.parser, p_line_gen_func: ical.icalparser_line_gen_func) *ical.component;
pub const icalparserParse = icalparser_parse;

extern fn icalparser_parse_string(p_str: [*:0]const u8) *ical.component;
pub const icalparserParseString = icalparser_parse_string;

extern fn icalparser_set_ctrl(p_ctrl: ?*anyopaque) void;
pub const icalparserSetCtrl = icalparser_set_ctrl;

extern fn icalparser_set_gen_data(p_parser: *ical.parser, p_data: ?*anyopaque) void;
pub const icalparserSetGenData = icalparser_set_gen_data;

extern fn icalparser_string_line_generator(p_out: [*:0]u8, p_buf_size: usize, p_d: ?*anyopaque) [*:0]u8;
pub const icalparserStringLineGenerator = icalparser_string_line_generator;

extern fn icalperiodtype_as_ical_string(p_p: ?*anyopaque) [*:0]const u8;
pub const icalperiodtypeAsIcalString = icalperiodtype_as_ical_string;

extern fn icalperiodtype_as_ical_string_r(p_p: ?*anyopaque) [*:0]u8;
pub const icalperiodtypeAsIcalStringR = icalperiodtype_as_ical_string_r;

extern fn icalperiodtype_from_string(p_str: [*:0]const u8) ?*anyopaque;
pub const icalperiodtypeFromString = icalperiodtype_from_string;

extern fn icalperiodtype_is_null_period(p_p: ?*anyopaque) c_int;
pub const icalperiodtypeIsNullPeriod = icalperiodtype_is_null_period;

extern fn icalperiodtype_is_valid_period(p_p: ?*anyopaque) c_int;
pub const icalperiodtypeIsValidPeriod = icalperiodtype_is_valid_period;

extern fn icalperiodtype_null_period() ?*anyopaque;
pub const icalperiodtypeNullPeriod = icalperiodtype_null_period;

extern fn icalproperty_add_parameter(p_prop: *ical.property, p_parameter: *ical.parameter) void;
pub const icalpropertyAddParameter = icalproperty_add_parameter;

extern fn icalproperty_add_parameters(p_prop: ?*anyopaque, p_args: std.builtin.VaList) void;
pub const icalpropertyAddParameters = icalproperty_add_parameters;

extern fn icalproperty_as_ical_string(p_prop: *ical.property) [*:0]const u8;
pub const icalpropertyAsIcalString = icalproperty_as_ical_string;

extern fn icalproperty_as_ical_string_r(p_prop: *ical.property) [*:0]u8;
pub const icalpropertyAsIcalStringR = icalproperty_as_ical_string_r;

extern fn icalproperty_count_parameters(p_prop: *const ical.property) c_int;
pub const icalpropertyCountParameters = icalproperty_count_parameters;

extern fn icalproperty_enum_belongs_to_property(p_kind: ical.property_kind, p_e: c_int) c_int;
pub const icalpropertyEnumBelongsToProperty = icalproperty_enum_belongs_to_property;

extern fn icalproperty_enum_to_string(p_e: c_int) [*:0]const u8;
pub const icalpropertyEnumToString = icalproperty_enum_to_string;

extern fn icalproperty_enum_to_string_r(p_e: c_int) [*:0]u8;
pub const icalpropertyEnumToStringR = icalproperty_enum_to_string_r;

extern fn icalproperty_free(p_prop: *ical.property) void;
pub const icalpropertyFree = icalproperty_free;

extern fn icalproperty_get_acceptresponse(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetAcceptresponse = icalproperty_get_acceptresponse;

extern fn icalproperty_get_acknowledged(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetAcknowledged = icalproperty_get_acknowledged;

extern fn icalproperty_get_action(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetAction = icalproperty_get_action;

extern fn icalproperty_get_allowconflict(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetAllowconflict = icalproperty_get_allowconflict;

extern fn icalproperty_get_attach(p_prop: *const ical.property) *ical.attach;
pub const icalpropertyGetAttach = icalproperty_get_attach;

extern fn icalproperty_get_attendee(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetAttendee = icalproperty_get_attendee;

extern fn icalproperty_get_busytype(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetBusytype = icalproperty_get_busytype;

extern fn icalproperty_get_calid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCalid = icalproperty_get_calid;

extern fn icalproperty_get_calmaster(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCalmaster = icalproperty_get_calmaster;

extern fn icalproperty_get_calscale(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCalscale = icalproperty_get_calscale;

extern fn icalproperty_get_capversion(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCapversion = icalproperty_get_capversion;

extern fn icalproperty_get_carid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCarid = icalproperty_get_carid;

extern fn icalproperty_get_carlevel(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetCarlevel = icalproperty_get_carlevel;

extern fn icalproperty_get_categories(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCategories = icalproperty_get_categories;

extern fn icalproperty_get_class(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetClass = icalproperty_get_class;

extern fn icalproperty_get_cmd(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetCmd = icalproperty_get_cmd;

extern fn icalproperty_get_color(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetColor = icalproperty_get_color;

extern fn icalproperty_get_comment(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetComment = icalproperty_get_comment;

extern fn icalproperty_get_completed(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetCompleted = icalproperty_get_completed;

extern fn icalproperty_get_components(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetComponents = icalproperty_get_components;

extern fn icalproperty_get_conference(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetConference = icalproperty_get_conference;

extern fn icalproperty_get_contact(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetContact = icalproperty_get_contact;

extern fn icalproperty_get_created(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetCreated = icalproperty_get_created;

extern fn icalproperty_get_csid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetCsid = icalproperty_get_csid;

extern fn icalproperty_get_datemax(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDatemax = icalproperty_get_datemax;

extern fn icalproperty_get_datemin(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDatemin = icalproperty_get_datemin;

extern fn icalproperty_get_datetime_with_component(p_prop: *ical.property, p_comp: *ical.component) ?*anyopaque;
pub const icalpropertyGetDatetimeWithComponent = icalproperty_get_datetime_with_component;

extern fn icalproperty_get_decreed(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDecreed = icalproperty_get_decreed;

extern fn icalproperty_get_defaultcharset(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDefaultcharset = icalproperty_get_defaultcharset;

extern fn icalproperty_get_defaultlocale(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDefaultlocale = icalproperty_get_defaultlocale;

extern fn icalproperty_get_defaulttzid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDefaulttzid = icalproperty_get_defaulttzid;

extern fn icalproperty_get_defaultvcars(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDefaultvcars = icalproperty_get_defaultvcars;

extern fn icalproperty_get_deny(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDeny = icalproperty_get_deny;

extern fn icalproperty_get_description(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetDescription = icalproperty_get_description;

extern fn icalproperty_get_dtend(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDtend = icalproperty_get_dtend;

extern fn icalproperty_get_dtstamp(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDtstamp = icalproperty_get_dtstamp;

extern fn icalproperty_get_dtstart(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDtstart = icalproperty_get_dtstart;

extern fn icalproperty_get_due(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDue = icalproperty_get_due;

extern fn icalproperty_get_duration(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetDuration = icalproperty_get_duration;

extern fn icalproperty_get_estimatedduration(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetEstimatedduration = icalproperty_get_estimatedduration;

extern fn icalproperty_get_exdate(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetExdate = icalproperty_get_exdate;

extern fn icalproperty_get_expand(p_prop: *const ical.property) c_int;
pub const icalpropertyGetExpand = icalproperty_get_expand;

extern fn icalproperty_get_exrule(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetExrule = icalproperty_get_exrule;

extern fn icalproperty_get_first_parameter(p_prop: *ical.property, p_kind: ical.parameter_kind) *ical.parameter;
pub const icalpropertyGetFirstParameter = icalproperty_get_first_parameter;

extern fn icalproperty_get_freebusy(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetFreebusy = icalproperty_get_freebusy;

extern fn icalproperty_get_geo(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetGeo = icalproperty_get_geo;

extern fn icalproperty_get_grant(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetGrant = icalproperty_get_grant;

extern fn icalproperty_get_image(p_prop: *const ical.property) *ical.attach;
pub const icalpropertyGetImage = icalproperty_get_image;

extern fn icalproperty_get_itipversion(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetItipversion = icalproperty_get_itipversion;

extern fn icalproperty_get_lastmodified(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetLastmodified = icalproperty_get_lastmodified;

extern fn icalproperty_get_location(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetLocation = icalproperty_get_location;

extern fn icalproperty_get_maxcomponentsize(p_prop: *const ical.property) c_int;
pub const icalpropertyGetMaxcomponentsize = icalproperty_get_maxcomponentsize;

extern fn icalproperty_get_maxdate(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetMaxdate = icalproperty_get_maxdate;

extern fn icalproperty_get_maxresults(p_prop: *const ical.property) c_int;
pub const icalpropertyGetMaxresults = icalproperty_get_maxresults;

extern fn icalproperty_get_maxresultssize(p_prop: *const ical.property) c_int;
pub const icalpropertyGetMaxresultssize = icalproperty_get_maxresultssize;

extern fn icalproperty_get_method(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetMethod = icalproperty_get_method;

extern fn icalproperty_get_mindate(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetMindate = icalproperty_get_mindate;

extern fn icalproperty_get_multipart(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetMultipart = icalproperty_get_multipart;

extern fn icalproperty_get_name(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetName = icalproperty_get_name;

extern fn icalproperty_get_next_parameter(p_prop: *ical.property, p_kind: ical.parameter_kind) *ical.parameter;
pub const icalpropertyGetNextParameter = icalproperty_get_next_parameter;

extern fn icalproperty_get_organizer(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetOrganizer = icalproperty_get_organizer;

extern fn icalproperty_get_owner(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetOwner = icalproperty_get_owner;

extern fn icalproperty_get_parameter_as_string(p_prop: *ical.property, p_name: [*:0]const u8) [*:0]const u8;
pub const icalpropertyGetParameterAsString = icalproperty_get_parameter_as_string;

extern fn icalproperty_get_parameter_as_string_r(p_prop: *ical.property, p_name: [*:0]const u8) [*:0]u8;
pub const icalpropertyGetParameterAsStringR = icalproperty_get_parameter_as_string_r;

extern fn icalproperty_get_parent(p_property: *const ical.property) *ical.component;
pub const icalpropertyGetParent = icalproperty_get_parent;

extern fn icalproperty_get_patchdelete(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPatchdelete = icalproperty_get_patchdelete;

extern fn icalproperty_get_patchorder(p_prop: *const ical.property) c_int;
pub const icalpropertyGetPatchorder = icalproperty_get_patchorder;

extern fn icalproperty_get_patchparameter(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPatchparameter = icalproperty_get_patchparameter;

extern fn icalproperty_get_patchtarget(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPatchtarget = icalproperty_get_patchtarget;

extern fn icalproperty_get_patchversion(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPatchversion = icalproperty_get_patchversion;

extern fn icalproperty_get_percentcomplete(p_prop: *const ical.property) c_int;
pub const icalpropertyGetPercentcomplete = icalproperty_get_percentcomplete;

extern fn icalproperty_get_permission(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPermission = icalproperty_get_permission;

extern fn icalproperty_get_pollcompletion(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetPollcompletion = icalproperty_get_pollcompletion;

extern fn icalproperty_get_pollitemid(p_prop: *const ical.property) c_int;
pub const icalpropertyGetPollitemid = icalproperty_get_pollitemid;

extern fn icalproperty_get_pollmode(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetPollmode = icalproperty_get_pollmode;

extern fn icalproperty_get_pollproperties(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPollproperties = icalproperty_get_pollproperties;

extern fn icalproperty_get_pollwinner(p_prop: *const ical.property) c_int;
pub const icalpropertyGetPollwinner = icalproperty_get_pollwinner;

extern fn icalproperty_get_priority(p_prop: *const ical.property) c_int;
pub const icalpropertyGetPriority = icalproperty_get_priority;

extern fn icalproperty_get_prodid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetProdid = icalproperty_get_prodid;

extern fn icalproperty_get_property_name(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetPropertyName = icalproperty_get_property_name;

extern fn icalproperty_get_property_name_r(p_prop: *const ical.property) [*:0]u8;
pub const icalpropertyGetPropertyNameR = icalproperty_get_property_name_r;

extern fn icalproperty_get_query(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetQuery = icalproperty_get_query;

extern fn icalproperty_get_queryid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetQueryid = icalproperty_get_queryid;

extern fn icalproperty_get_querylevel(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetQuerylevel = icalproperty_get_querylevel;

extern fn icalproperty_get_queryname(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetQueryname = icalproperty_get_queryname;

extern fn icalproperty_get_rdate(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetRdate = icalproperty_get_rdate;

extern fn icalproperty_get_recuraccepted(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRecuraccepted = icalproperty_get_recuraccepted;

extern fn icalproperty_get_recurexpand(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRecurexpand = icalproperty_get_recurexpand;

extern fn icalproperty_get_recurlimit(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRecurlimit = icalproperty_get_recurlimit;

extern fn icalproperty_get_recurrenceid(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetRecurrenceid = icalproperty_get_recurrenceid;

extern fn icalproperty_get_refreshinterval(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetRefreshinterval = icalproperty_get_refreshinterval;

extern fn icalproperty_get_relatedto(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRelatedto = icalproperty_get_relatedto;

extern fn icalproperty_get_relcalid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRelcalid = icalproperty_get_relcalid;

extern fn icalproperty_get_repeat(p_prop: *const ical.property) c_int;
pub const icalpropertyGetRepeat = icalproperty_get_repeat;

extern fn icalproperty_get_replyurl(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetReplyurl = icalproperty_get_replyurl;

extern fn icalproperty_get_requeststatus(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetRequeststatus = icalproperty_get_requeststatus;

extern fn icalproperty_get_resources(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetResources = icalproperty_get_resources;

extern fn icalproperty_get_response(p_prop: *const ical.property) c_int;
pub const icalpropertyGetResponse = icalproperty_get_response;

extern fn icalproperty_get_restriction(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetRestriction = icalproperty_get_restriction;

extern fn icalproperty_get_rrule(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetRrule = icalproperty_get_rrule;

extern fn icalproperty_get_scope(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetScope = icalproperty_get_scope;

extern fn icalproperty_get_sequence(p_prop: *const ical.property) c_int;
pub const icalpropertyGetSequence = icalproperty_get_sequence;

extern fn icalproperty_get_source(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetSource = icalproperty_get_source;

extern fn icalproperty_get_status(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetStatus = icalproperty_get_status;

extern fn icalproperty_get_storesexpanded(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetStoresexpanded = icalproperty_get_storesexpanded;

extern fn icalproperty_get_summary(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetSummary = icalproperty_get_summary;

extern fn icalproperty_get_target(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetTarget = icalproperty_get_target;

extern fn icalproperty_get_taskmode(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetTaskmode = icalproperty_get_taskmode;

extern fn icalproperty_get_transp(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetTransp = icalproperty_get_transp;

extern fn icalproperty_get_trigger(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetTrigger = icalproperty_get_trigger;

extern fn icalproperty_get_tzid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetTzid = icalproperty_get_tzid;

extern fn icalproperty_get_tzidaliasof(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetTzidaliasof = icalproperty_get_tzidaliasof;

extern fn icalproperty_get_tzname(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetTzname = icalproperty_get_tzname;

extern fn icalproperty_get_tzoffsetfrom(p_prop: *const ical.property) c_int;
pub const icalpropertyGetTzoffsetfrom = icalproperty_get_tzoffsetfrom;

extern fn icalproperty_get_tzoffsetto(p_prop: *const ical.property) c_int;
pub const icalpropertyGetTzoffsetto = icalproperty_get_tzoffsetto;

extern fn icalproperty_get_tzuntil(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetTzuntil = icalproperty_get_tzuntil;

extern fn icalproperty_get_tzurl(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetTzurl = icalproperty_get_tzurl;

extern fn icalproperty_get_uid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetUid = icalproperty_get_uid;

extern fn icalproperty_get_url(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetUrl = icalproperty_get_url;

extern fn icalproperty_get_value(p_prop: *const ical.property) *ical.value;
pub const icalpropertyGetValue = icalproperty_get_value;

extern fn icalproperty_get_value_as_string(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetValueAsString = icalproperty_get_value_as_string;

extern fn icalproperty_get_value_as_string_r(p_prop: *const ical.property) [*:0]u8;
pub const icalpropertyGetValueAsStringR = icalproperty_get_value_as_string_r;

extern fn icalproperty_get_version(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetVersion = icalproperty_get_version;

extern fn icalproperty_get_voter(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetVoter = icalproperty_get_voter;

extern fn icalproperty_get_x(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetX = icalproperty_get_x;

extern fn icalproperty_get_x_name(p_prop: *ical.property) [*:0]const u8;
pub const icalpropertyGetXName = icalproperty_get_x_name;

extern fn icalproperty_get_xlicclass(p_prop: *const ical.property) ?*anyopaque;
pub const icalpropertyGetXlicclass = icalproperty_get_xlicclass;

extern fn icalproperty_get_xlicclustercount(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicclustercount = icalproperty_get_xlicclustercount;

extern fn icalproperty_get_xlicerror(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicerror = icalproperty_get_xlicerror;

extern fn icalproperty_get_xlicmimecharset(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimecharset = icalproperty_get_xlicmimecharset;

extern fn icalproperty_get_xlicmimecid(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimecid = icalproperty_get_xlicmimecid;

extern fn icalproperty_get_xlicmimecontenttype(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimecontenttype = icalproperty_get_xlicmimecontenttype;

extern fn icalproperty_get_xlicmimeencoding(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimeencoding = icalproperty_get_xlicmimeencoding;

extern fn icalproperty_get_xlicmimefilename(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimefilename = icalproperty_get_xlicmimefilename;

extern fn icalproperty_get_xlicmimeoptinfo(p_prop: *const ical.property) [*:0]const u8;
pub const icalpropertyGetXlicmimeoptinfo = icalproperty_get_xlicmimeoptinfo;

extern fn icalproperty_isa(p_property: *ical.property) ical.property_kind;
pub const icalpropertyIsa = icalproperty_isa;

extern fn icalproperty_isa_property(p_property: ?*anyopaque) c_int;
pub const icalpropertyIsaProperty = icalproperty_isa_property;

extern fn icalproperty_kind_and_string_to_enum(p_kind: c_int, p_str: [*:0]const u8) c_int;
pub const icalpropertyKindAndStringToEnum = icalproperty_kind_and_string_to_enum;

extern fn icalproperty_kind_is_valid(p_kind: ical.property_kind) c_int;
pub const icalpropertyKindIsValid = icalproperty_kind_is_valid;

extern fn icalproperty_kind_to_string(p_kind: ical.property_kind) [*:0]const u8;
pub const icalpropertyKindToString = icalproperty_kind_to_string;

extern fn icalproperty_kind_to_value_kind(p_kind: ical.property_kind) ical.value_kind;
pub const icalpropertyKindToValueKind = icalproperty_kind_to_value_kind;

extern fn icalproperty_method_to_string(p_method: ical.property_method) [*:0]const u8;
pub const icalpropertyMethodToString = icalproperty_method_to_string;

extern fn icalproperty_new(p_kind: ical.property_kind) *ical.property;
pub const icalpropertyNew = icalproperty_new;

extern fn icalproperty_new_acceptresponse(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewAcceptresponse = icalproperty_new_acceptresponse;

extern fn icalproperty_new_acknowledged(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewAcknowledged = icalproperty_new_acknowledged;

extern fn icalproperty_new_action(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewAction = icalproperty_new_action;

extern fn icalproperty_new_allowconflict(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewAllowconflict = icalproperty_new_allowconflict;

extern fn icalproperty_new_attach(p_v: *ical.attach) *ical.property;
pub const icalpropertyNewAttach = icalproperty_new_attach;

extern fn icalproperty_new_attendee(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewAttendee = icalproperty_new_attendee;

extern fn icalproperty_new_busytype(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewBusytype = icalproperty_new_busytype;

extern fn icalproperty_new_calid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCalid = icalproperty_new_calid;

extern fn icalproperty_new_calmaster(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCalmaster = icalproperty_new_calmaster;

extern fn icalproperty_new_calscale(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCalscale = icalproperty_new_calscale;

extern fn icalproperty_new_capversion(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCapversion = icalproperty_new_capversion;

extern fn icalproperty_new_carid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCarid = icalproperty_new_carid;

extern fn icalproperty_new_carlevel(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewCarlevel = icalproperty_new_carlevel;

extern fn icalproperty_new_categories(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCategories = icalproperty_new_categories;

extern fn icalproperty_new_class(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewClass = icalproperty_new_class;

extern fn icalproperty_new_clone(p_prop: *ical.property) *ical.property;
pub const icalpropertyNewClone = icalproperty_new_clone;

extern fn icalproperty_new_cmd(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewCmd = icalproperty_new_cmd;

extern fn icalproperty_new_color(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewColor = icalproperty_new_color;

extern fn icalproperty_new_comment(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewComment = icalproperty_new_comment;

extern fn icalproperty_new_completed(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewCompleted = icalproperty_new_completed;

extern fn icalproperty_new_components(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewComponents = icalproperty_new_components;

extern fn icalproperty_new_conference(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewConference = icalproperty_new_conference;

extern fn icalproperty_new_contact(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewContact = icalproperty_new_contact;

extern fn icalproperty_new_created(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewCreated = icalproperty_new_created;

extern fn icalproperty_new_csid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewCsid = icalproperty_new_csid;

extern fn icalproperty_new_datemax(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDatemax = icalproperty_new_datemax;

extern fn icalproperty_new_datemin(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDatemin = icalproperty_new_datemin;

extern fn icalproperty_new_decreed(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDecreed = icalproperty_new_decreed;

extern fn icalproperty_new_defaultcharset(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDefaultcharset = icalproperty_new_defaultcharset;

extern fn icalproperty_new_defaultlocale(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDefaultlocale = icalproperty_new_defaultlocale;

extern fn icalproperty_new_defaulttzid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDefaulttzid = icalproperty_new_defaulttzid;

extern fn icalproperty_new_defaultvcars(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDefaultvcars = icalproperty_new_defaultvcars;

extern fn icalproperty_new_deny(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDeny = icalproperty_new_deny;

extern fn icalproperty_new_description(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewDescription = icalproperty_new_description;

extern fn icalproperty_new_dtend(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDtend = icalproperty_new_dtend;

extern fn icalproperty_new_dtstamp(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDtstamp = icalproperty_new_dtstamp;

extern fn icalproperty_new_dtstart(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDtstart = icalproperty_new_dtstart;

extern fn icalproperty_new_due(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDue = icalproperty_new_due;

extern fn icalproperty_new_duration(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewDuration = icalproperty_new_duration;

extern fn icalproperty_new_estimatedduration(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewEstimatedduration = icalproperty_new_estimatedduration;

extern fn icalproperty_new_exdate(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewExdate = icalproperty_new_exdate;

extern fn icalproperty_new_expand(p_v: c_int) *ical.property;
pub const icalpropertyNewExpand = icalproperty_new_expand;

extern fn icalproperty_new_exrule(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewExrule = icalproperty_new_exrule;

extern fn icalproperty_new_freebusy(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewFreebusy = icalproperty_new_freebusy;

extern fn icalproperty_new_from_string(p_str: [*:0]const u8) *ical.property;
pub const icalpropertyNewFromString = icalproperty_new_from_string;

extern fn icalproperty_new_geo(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewGeo = icalproperty_new_geo;

extern fn icalproperty_new_grant(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewGrant = icalproperty_new_grant;

extern fn icalproperty_new_image(p_v: *ical.attach) *ical.property;
pub const icalpropertyNewImage = icalproperty_new_image;

extern fn icalproperty_new_impl(p_kind: ical.property_kind) *ical.property;
pub const icalpropertyNewImpl = icalproperty_new_impl;

extern fn icalproperty_new_itipversion(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewItipversion = icalproperty_new_itipversion;

extern fn icalproperty_new_lastmodified(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewLastmodified = icalproperty_new_lastmodified;

extern fn icalproperty_new_location(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewLocation = icalproperty_new_location;

extern fn icalproperty_new_maxcomponentsize(p_v: c_int) *ical.property;
pub const icalpropertyNewMaxcomponentsize = icalproperty_new_maxcomponentsize;

extern fn icalproperty_new_maxdate(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewMaxdate = icalproperty_new_maxdate;

extern fn icalproperty_new_maxresults(p_v: c_int) *ical.property;
pub const icalpropertyNewMaxresults = icalproperty_new_maxresults;

extern fn icalproperty_new_maxresultssize(p_v: c_int) *ical.property;
pub const icalpropertyNewMaxresultssize = icalproperty_new_maxresultssize;

extern fn icalproperty_new_method(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewMethod = icalproperty_new_method;

extern fn icalproperty_new_mindate(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewMindate = icalproperty_new_mindate;

extern fn icalproperty_new_multipart(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewMultipart = icalproperty_new_multipart;

extern fn icalproperty_new_name(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewName = icalproperty_new_name;

extern fn icalproperty_new_organizer(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewOrganizer = icalproperty_new_organizer;

extern fn icalproperty_new_owner(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewOwner = icalproperty_new_owner;

extern fn icalproperty_new_patchdelete(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPatchdelete = icalproperty_new_patchdelete;

extern fn icalproperty_new_patchorder(p_v: c_int) *ical.property;
pub const icalpropertyNewPatchorder = icalproperty_new_patchorder;

extern fn icalproperty_new_patchparameter(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPatchparameter = icalproperty_new_patchparameter;

extern fn icalproperty_new_patchtarget(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPatchtarget = icalproperty_new_patchtarget;

extern fn icalproperty_new_patchversion(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPatchversion = icalproperty_new_patchversion;

extern fn icalproperty_new_percentcomplete(p_v: c_int) *ical.property;
pub const icalpropertyNewPercentcomplete = icalproperty_new_percentcomplete;

extern fn icalproperty_new_permission(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPermission = icalproperty_new_permission;

extern fn icalproperty_new_pollcompletion(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewPollcompletion = icalproperty_new_pollcompletion;

extern fn icalproperty_new_pollitemid(p_v: c_int) *ical.property;
pub const icalpropertyNewPollitemid = icalproperty_new_pollitemid;

extern fn icalproperty_new_pollmode(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewPollmode = icalproperty_new_pollmode;

extern fn icalproperty_new_pollproperties(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewPollproperties = icalproperty_new_pollproperties;

extern fn icalproperty_new_pollwinner(p_v: c_int) *ical.property;
pub const icalpropertyNewPollwinner = icalproperty_new_pollwinner;

extern fn icalproperty_new_priority(p_v: c_int) *ical.property;
pub const icalpropertyNewPriority = icalproperty_new_priority;

extern fn icalproperty_new_prodid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewProdid = icalproperty_new_prodid;

extern fn icalproperty_new_query(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewQuery = icalproperty_new_query;

extern fn icalproperty_new_queryid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewQueryid = icalproperty_new_queryid;

extern fn icalproperty_new_querylevel(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewQuerylevel = icalproperty_new_querylevel;

extern fn icalproperty_new_queryname(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewQueryname = icalproperty_new_queryname;

extern fn icalproperty_new_rdate(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewRdate = icalproperty_new_rdate;

extern fn icalproperty_new_recuraccepted(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRecuraccepted = icalproperty_new_recuraccepted;

extern fn icalproperty_new_recurexpand(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRecurexpand = icalproperty_new_recurexpand;

extern fn icalproperty_new_recurlimit(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRecurlimit = icalproperty_new_recurlimit;

extern fn icalproperty_new_recurrenceid(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewRecurrenceid = icalproperty_new_recurrenceid;

extern fn icalproperty_new_refreshinterval(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewRefreshinterval = icalproperty_new_refreshinterval;

extern fn icalproperty_new_relatedto(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRelatedto = icalproperty_new_relatedto;

extern fn icalproperty_new_relcalid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRelcalid = icalproperty_new_relcalid;

extern fn icalproperty_new_repeat(p_v: c_int) *ical.property;
pub const icalpropertyNewRepeat = icalproperty_new_repeat;

extern fn icalproperty_new_replyurl(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewReplyurl = icalproperty_new_replyurl;

extern fn icalproperty_new_requeststatus(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewRequeststatus = icalproperty_new_requeststatus;

extern fn icalproperty_new_resources(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewResources = icalproperty_new_resources;

extern fn icalproperty_new_response(p_v: c_int) *ical.property;
pub const icalpropertyNewResponse = icalproperty_new_response;

extern fn icalproperty_new_restriction(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewRestriction = icalproperty_new_restriction;

extern fn icalproperty_new_rrule(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewRrule = icalproperty_new_rrule;

extern fn icalproperty_new_scope(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewScope = icalproperty_new_scope;

extern fn icalproperty_new_sequence(p_v: c_int) *ical.property;
pub const icalpropertyNewSequence = icalproperty_new_sequence;

extern fn icalproperty_new_source(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewSource = icalproperty_new_source;

extern fn icalproperty_new_status(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewStatus = icalproperty_new_status;

extern fn icalproperty_new_storesexpanded(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewStoresexpanded = icalproperty_new_storesexpanded;

extern fn icalproperty_new_summary(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewSummary = icalproperty_new_summary;

extern fn icalproperty_new_target(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewTarget = icalproperty_new_target;

extern fn icalproperty_new_taskmode(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewTaskmode = icalproperty_new_taskmode;

extern fn icalproperty_new_transp(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewTransp = icalproperty_new_transp;

extern fn icalproperty_new_trigger(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewTrigger = icalproperty_new_trigger;

extern fn icalproperty_new_tzid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewTzid = icalproperty_new_tzid;

extern fn icalproperty_new_tzidaliasof(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewTzidaliasof = icalproperty_new_tzidaliasof;

extern fn icalproperty_new_tzname(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewTzname = icalproperty_new_tzname;

extern fn icalproperty_new_tzoffsetfrom(p_v: c_int) *ical.property;
pub const icalpropertyNewTzoffsetfrom = icalproperty_new_tzoffsetfrom;

extern fn icalproperty_new_tzoffsetto(p_v: c_int) *ical.property;
pub const icalpropertyNewTzoffsetto = icalproperty_new_tzoffsetto;

extern fn icalproperty_new_tzuntil(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewTzuntil = icalproperty_new_tzuntil;

extern fn icalproperty_new_tzurl(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewTzurl = icalproperty_new_tzurl;

extern fn icalproperty_new_uid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewUid = icalproperty_new_uid;

extern fn icalproperty_new_url(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewUrl = icalproperty_new_url;

extern fn icalproperty_new_version(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewVersion = icalproperty_new_version;

extern fn icalproperty_new_voter(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewVoter = icalproperty_new_voter;

extern fn icalproperty_new_x(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewX = icalproperty_new_x;

extern fn icalproperty_new_xlicclass(p_v: ?*anyopaque) *ical.property;
pub const icalpropertyNewXlicclass = icalproperty_new_xlicclass;

extern fn icalproperty_new_xlicclustercount(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicclustercount = icalproperty_new_xlicclustercount;

extern fn icalproperty_new_xlicerror(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicerror = icalproperty_new_xlicerror;

extern fn icalproperty_new_xlicmimecharset(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimecharset = icalproperty_new_xlicmimecharset;

extern fn icalproperty_new_xlicmimecid(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimecid = icalproperty_new_xlicmimecid;

extern fn icalproperty_new_xlicmimecontenttype(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimecontenttype = icalproperty_new_xlicmimecontenttype;

extern fn icalproperty_new_xlicmimeencoding(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimeencoding = icalproperty_new_xlicmimeencoding;

extern fn icalproperty_new_xlicmimefilename(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimefilename = icalproperty_new_xlicmimefilename;

extern fn icalproperty_new_xlicmimeoptinfo(p_v: [*:0]const u8) *ical.property;
pub const icalpropertyNewXlicmimeoptinfo = icalproperty_new_xlicmimeoptinfo;

extern fn icalproperty_normalize(p_prop: *ical.property) void;
pub const icalpropertyNormalize = icalproperty_normalize;

extern fn icalproperty_recurrence_is_excluded(p_comp: *ical.component, p_dtstart: ?*anyopaque, p_recurtime: ?*anyopaque) c_int;
pub const icalpropertyRecurrenceIsExcluded = icalproperty_recurrence_is_excluded;

extern fn icalproperty_remove_parameter_by_kind(p_prop: *ical.property, p_kind: ical.parameter_kind) void;
pub const icalpropertyRemoveParameterByKind = icalproperty_remove_parameter_by_kind;

extern fn icalproperty_remove_parameter_by_name(p_prop: *ical.property, p_name: [*:0]const u8) void;
pub const icalpropertyRemoveParameterByName = icalproperty_remove_parameter_by_name;

/// parameters
extern fn icalproperty_remove_parameter_by_ref(p_prop: *ical.property, p_param: *ical.parameter) void;
pub const icalpropertyRemoveParameterByRef = icalproperty_remove_parameter_by_ref;

extern fn icalproperty_set_acceptresponse(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetAcceptresponse = icalproperty_set_acceptresponse;

extern fn icalproperty_set_acknowledged(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetAcknowledged = icalproperty_set_acknowledged;

extern fn icalproperty_set_action(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetAction = icalproperty_set_action;

extern fn icalproperty_set_allowconflict(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetAllowconflict = icalproperty_set_allowconflict;

extern fn icalproperty_set_attach(p_prop: *ical.property, p_v: *ical.attach) void;
pub const icalpropertySetAttach = icalproperty_set_attach;

extern fn icalproperty_set_attendee(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetAttendee = icalproperty_set_attendee;

extern fn icalproperty_set_busytype(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetBusytype = icalproperty_set_busytype;

extern fn icalproperty_set_calid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCalid = icalproperty_set_calid;

extern fn icalproperty_set_calmaster(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCalmaster = icalproperty_set_calmaster;

extern fn icalproperty_set_calscale(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCalscale = icalproperty_set_calscale;

extern fn icalproperty_set_capversion(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCapversion = icalproperty_set_capversion;

extern fn icalproperty_set_carid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCarid = icalproperty_set_carid;

extern fn icalproperty_set_carlevel(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetCarlevel = icalproperty_set_carlevel;

extern fn icalproperty_set_categories(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCategories = icalproperty_set_categories;

extern fn icalproperty_set_class(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetClass = icalproperty_set_class;

extern fn icalproperty_set_cmd(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetCmd = icalproperty_set_cmd;

extern fn icalproperty_set_color(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetColor = icalproperty_set_color;

extern fn icalproperty_set_comment(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetComment = icalproperty_set_comment;

extern fn icalproperty_set_completed(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetCompleted = icalproperty_set_completed;

extern fn icalproperty_set_components(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetComponents = icalproperty_set_components;

extern fn icalproperty_set_conference(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetConference = icalproperty_set_conference;

extern fn icalproperty_set_contact(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetContact = icalproperty_set_contact;

extern fn icalproperty_set_created(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetCreated = icalproperty_set_created;

extern fn icalproperty_set_csid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetCsid = icalproperty_set_csid;

extern fn icalproperty_set_datemax(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDatemax = icalproperty_set_datemax;

extern fn icalproperty_set_datemin(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDatemin = icalproperty_set_datemin;

extern fn icalproperty_set_decreed(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDecreed = icalproperty_set_decreed;

extern fn icalproperty_set_defaultcharset(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDefaultcharset = icalproperty_set_defaultcharset;

extern fn icalproperty_set_defaultlocale(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDefaultlocale = icalproperty_set_defaultlocale;

extern fn icalproperty_set_defaulttzid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDefaulttzid = icalproperty_set_defaulttzid;

extern fn icalproperty_set_defaultvcars(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDefaultvcars = icalproperty_set_defaultvcars;

extern fn icalproperty_set_deny(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDeny = icalproperty_set_deny;

extern fn icalproperty_set_description(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetDescription = icalproperty_set_description;

extern fn icalproperty_set_dtend(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDtend = icalproperty_set_dtend;

extern fn icalproperty_set_dtstamp(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDtstamp = icalproperty_set_dtstamp;

extern fn icalproperty_set_dtstart(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDtstart = icalproperty_set_dtstart;

extern fn icalproperty_set_due(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDue = icalproperty_set_due;

extern fn icalproperty_set_duration(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetDuration = icalproperty_set_duration;

extern fn icalproperty_set_estimatedduration(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetEstimatedduration = icalproperty_set_estimatedduration;

extern fn icalproperty_set_exdate(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetExdate = icalproperty_set_exdate;

extern fn icalproperty_set_expand(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetExpand = icalproperty_set_expand;

extern fn icalproperty_set_exrule(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetExrule = icalproperty_set_exrule;

extern fn icalproperty_set_freebusy(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetFreebusy = icalproperty_set_freebusy;

extern fn icalproperty_set_geo(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetGeo = icalproperty_set_geo;

extern fn icalproperty_set_grant(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetGrant = icalproperty_set_grant;

extern fn icalproperty_set_image(p_prop: *ical.property, p_v: *ical.attach) void;
pub const icalpropertySetImage = icalproperty_set_image;

extern fn icalproperty_set_itipversion(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetItipversion = icalproperty_set_itipversion;

extern fn icalproperty_set_lastmodified(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetLastmodified = icalproperty_set_lastmodified;

extern fn icalproperty_set_location(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetLocation = icalproperty_set_location;

extern fn icalproperty_set_maxcomponentsize(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetMaxcomponentsize = icalproperty_set_maxcomponentsize;

extern fn icalproperty_set_maxdate(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetMaxdate = icalproperty_set_maxdate;

extern fn icalproperty_set_maxresults(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetMaxresults = icalproperty_set_maxresults;

extern fn icalproperty_set_maxresultssize(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetMaxresultssize = icalproperty_set_maxresultssize;

extern fn icalproperty_set_method(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetMethod = icalproperty_set_method;

extern fn icalproperty_set_mindate(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetMindate = icalproperty_set_mindate;

extern fn icalproperty_set_multipart(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetMultipart = icalproperty_set_multipart;

extern fn icalproperty_set_name(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetName = icalproperty_set_name;

extern fn icalproperty_set_organizer(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetOrganizer = icalproperty_set_organizer;

extern fn icalproperty_set_owner(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetOwner = icalproperty_set_owner;

extern fn icalproperty_set_parameter(p_prop: *ical.property, p_parameter: *ical.parameter) void;
pub const icalpropertySetParameter = icalproperty_set_parameter;

extern fn icalproperty_set_parameter_from_string(p_prop: *ical.property, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
pub const icalpropertySetParameterFromString = icalproperty_set_parameter_from_string;

extern fn icalproperty_set_parent(p_property: *ical.property, p_component: *ical.component) void;
pub const icalpropertySetParent = icalproperty_set_parent;

extern fn icalproperty_set_patchdelete(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPatchdelete = icalproperty_set_patchdelete;

extern fn icalproperty_set_patchorder(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetPatchorder = icalproperty_set_patchorder;

extern fn icalproperty_set_patchparameter(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPatchparameter = icalproperty_set_patchparameter;

extern fn icalproperty_set_patchtarget(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPatchtarget = icalproperty_set_patchtarget;

extern fn icalproperty_set_patchversion(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPatchversion = icalproperty_set_patchversion;

extern fn icalproperty_set_percentcomplete(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetPercentcomplete = icalproperty_set_percentcomplete;

extern fn icalproperty_set_permission(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPermission = icalproperty_set_permission;

extern fn icalproperty_set_pollcompletion(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetPollcompletion = icalproperty_set_pollcompletion;

extern fn icalproperty_set_pollitemid(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetPollitemid = icalproperty_set_pollitemid;

extern fn icalproperty_set_pollmode(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetPollmode = icalproperty_set_pollmode;

extern fn icalproperty_set_pollproperties(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetPollproperties = icalproperty_set_pollproperties;

extern fn icalproperty_set_pollwinner(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetPollwinner = icalproperty_set_pollwinner;

extern fn icalproperty_set_priority(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetPriority = icalproperty_set_priority;

extern fn icalproperty_set_prodid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetProdid = icalproperty_set_prodid;

extern fn icalproperty_set_query(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetQuery = icalproperty_set_query;

extern fn icalproperty_set_queryid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetQueryid = icalproperty_set_queryid;

extern fn icalproperty_set_querylevel(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetQuerylevel = icalproperty_set_querylevel;

extern fn icalproperty_set_queryname(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetQueryname = icalproperty_set_queryname;

extern fn icalproperty_set_rdate(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetRdate = icalproperty_set_rdate;

extern fn icalproperty_set_recuraccepted(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRecuraccepted = icalproperty_set_recuraccepted;

extern fn icalproperty_set_recurexpand(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRecurexpand = icalproperty_set_recurexpand;

extern fn icalproperty_set_recurlimit(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRecurlimit = icalproperty_set_recurlimit;

extern fn icalproperty_set_recurrenceid(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetRecurrenceid = icalproperty_set_recurrenceid;

extern fn icalproperty_set_refreshinterval(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetRefreshinterval = icalproperty_set_refreshinterval;

extern fn icalproperty_set_relatedto(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRelatedto = icalproperty_set_relatedto;

extern fn icalproperty_set_relcalid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRelcalid = icalproperty_set_relcalid;

extern fn icalproperty_set_repeat(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetRepeat = icalproperty_set_repeat;

extern fn icalproperty_set_replyurl(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetReplyurl = icalproperty_set_replyurl;

extern fn icalproperty_set_requeststatus(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetRequeststatus = icalproperty_set_requeststatus;

extern fn icalproperty_set_resources(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetResources = icalproperty_set_resources;

extern fn icalproperty_set_response(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetResponse = icalproperty_set_response;

extern fn icalproperty_set_restriction(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetRestriction = icalproperty_set_restriction;

extern fn icalproperty_set_rrule(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetRrule = icalproperty_set_rrule;

extern fn icalproperty_set_scope(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetScope = icalproperty_set_scope;

extern fn icalproperty_set_sequence(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetSequence = icalproperty_set_sequence;

extern fn icalproperty_set_source(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetSource = icalproperty_set_source;

extern fn icalproperty_set_status(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetStatus = icalproperty_set_status;

extern fn icalproperty_set_storesexpanded(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetStoresexpanded = icalproperty_set_storesexpanded;

extern fn icalproperty_set_summary(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetSummary = icalproperty_set_summary;

extern fn icalproperty_set_target(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetTarget = icalproperty_set_target;

extern fn icalproperty_set_taskmode(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetTaskmode = icalproperty_set_taskmode;

extern fn icalproperty_set_transp(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetTransp = icalproperty_set_transp;

extern fn icalproperty_set_trigger(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetTrigger = icalproperty_set_trigger;

extern fn icalproperty_set_tzid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetTzid = icalproperty_set_tzid;

extern fn icalproperty_set_tzidaliasof(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetTzidaliasof = icalproperty_set_tzidaliasof;

extern fn icalproperty_set_tzname(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetTzname = icalproperty_set_tzname;

extern fn icalproperty_set_tzoffsetfrom(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetTzoffsetfrom = icalproperty_set_tzoffsetfrom;

extern fn icalproperty_set_tzoffsetto(p_prop: *ical.property, p_v: c_int) void;
pub const icalpropertySetTzoffsetto = icalproperty_set_tzoffsetto;

extern fn icalproperty_set_tzuntil(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetTzuntil = icalproperty_set_tzuntil;

extern fn icalproperty_set_tzurl(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetTzurl = icalproperty_set_tzurl;

extern fn icalproperty_set_uid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetUid = icalproperty_set_uid;

extern fn icalproperty_set_url(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetUrl = icalproperty_set_url;

extern fn icalproperty_set_value(p_prop: *ical.property, p_value: *ical.value) void;
pub const icalpropertySetValue = icalproperty_set_value;

extern fn icalproperty_set_value_from_string(p_prop: *ical.property, p_value: [*:0]const u8, p_kind: [*:0]const u8) void;
pub const icalpropertySetValueFromString = icalproperty_set_value_from_string;

extern fn icalproperty_set_version(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetVersion = icalproperty_set_version;

extern fn icalproperty_set_voter(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetVoter = icalproperty_set_voter;

extern fn icalproperty_set_x(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetX = icalproperty_set_x;

extern fn icalproperty_set_x_name(p_prop: *ical.property, p_name: [*:0]const u8) void;
pub const icalpropertySetXName = icalproperty_set_x_name;

extern fn icalproperty_set_xlicclass(p_prop: *ical.property, p_v: ?*anyopaque) void;
pub const icalpropertySetXlicclass = icalproperty_set_xlicclass;

extern fn icalproperty_set_xlicclustercount(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicclustercount = icalproperty_set_xlicclustercount;

extern fn icalproperty_set_xlicerror(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicerror = icalproperty_set_xlicerror;

extern fn icalproperty_set_xlicmimecharset(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimecharset = icalproperty_set_xlicmimecharset;

extern fn icalproperty_set_xlicmimecid(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimecid = icalproperty_set_xlicmimecid;

extern fn icalproperty_set_xlicmimecontenttype(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimecontenttype = icalproperty_set_xlicmimecontenttype;

extern fn icalproperty_set_xlicmimeencoding(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimeencoding = icalproperty_set_xlicmimeencoding;

extern fn icalproperty_set_xlicmimefilename(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimefilename = icalproperty_set_xlicmimefilename;

extern fn icalproperty_set_xlicmimeoptinfo(p_prop: *ical.property, p_v: [*:0]const u8) void;
pub const icalpropertySetXlicmimeoptinfo = icalproperty_set_xlicmimeoptinfo;

extern fn icalproperty_status_to_string(p_arg0: ical.property_status) [*:0]const u8;
pub const icalpropertyStatusToString = icalproperty_status_to_string;

extern fn icalproperty_string_to_kind(p_string: [*:0]const u8) ical.property_kind;
pub const icalpropertyStringToKind = icalproperty_string_to_kind;

extern fn icalproperty_string_to_method(p_str: [*:0]const u8) ical.property_method;
pub const icalpropertyStringToMethod = icalproperty_string_to_method;

extern fn icalproperty_string_to_status(p_string: [*:0]const u8) ical.property_status;
pub const icalpropertyStringToStatus = icalproperty_string_to_status;

extern fn icalproperty_value_kind_to_kind(p_kind: ical.value_kind) ical.property_kind;
pub const icalpropertyValueKindToKind = icalproperty_value_kind_to_kind;

extern fn icalproperty_vanew_acceptresponse(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewAcceptresponse = icalproperty_vanew_acceptresponse;

extern fn icalproperty_vanew_acknowledged(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewAcknowledged = icalproperty_vanew_acknowledged;

extern fn icalproperty_vanew_action(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewAction = icalproperty_vanew_action;

extern fn icalproperty_vanew_allowconflict(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewAllowconflict = icalproperty_vanew_allowconflict;

extern fn icalproperty_vanew_attach(p_v: *ical.attach, ...) *ical.property;
pub const icalpropertyVanewAttach = icalproperty_vanew_attach;

extern fn icalproperty_vanew_attendee(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewAttendee = icalproperty_vanew_attendee;

extern fn icalproperty_vanew_busytype(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewBusytype = icalproperty_vanew_busytype;

extern fn icalproperty_vanew_calid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCalid = icalproperty_vanew_calid;

extern fn icalproperty_vanew_calmaster(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCalmaster = icalproperty_vanew_calmaster;

extern fn icalproperty_vanew_calscale(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCalscale = icalproperty_vanew_calscale;

extern fn icalproperty_vanew_capversion(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCapversion = icalproperty_vanew_capversion;

extern fn icalproperty_vanew_carid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCarid = icalproperty_vanew_carid;

extern fn icalproperty_vanew_carlevel(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewCarlevel = icalproperty_vanew_carlevel;

extern fn icalproperty_vanew_categories(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCategories = icalproperty_vanew_categories;

extern fn icalproperty_vanew_class(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewClass = icalproperty_vanew_class;

extern fn icalproperty_vanew_cmd(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewCmd = icalproperty_vanew_cmd;

extern fn icalproperty_vanew_color(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewColor = icalproperty_vanew_color;

extern fn icalproperty_vanew_comment(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewComment = icalproperty_vanew_comment;

extern fn icalproperty_vanew_completed(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewCompleted = icalproperty_vanew_completed;

extern fn icalproperty_vanew_components(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewComponents = icalproperty_vanew_components;

extern fn icalproperty_vanew_conference(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewConference = icalproperty_vanew_conference;

extern fn icalproperty_vanew_contact(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewContact = icalproperty_vanew_contact;

extern fn icalproperty_vanew_created(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewCreated = icalproperty_vanew_created;

extern fn icalproperty_vanew_csid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewCsid = icalproperty_vanew_csid;

extern fn icalproperty_vanew_datemax(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDatemax = icalproperty_vanew_datemax;

extern fn icalproperty_vanew_datemin(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDatemin = icalproperty_vanew_datemin;

extern fn icalproperty_vanew_decreed(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDecreed = icalproperty_vanew_decreed;

extern fn icalproperty_vanew_defaultcharset(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDefaultcharset = icalproperty_vanew_defaultcharset;

extern fn icalproperty_vanew_defaultlocale(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDefaultlocale = icalproperty_vanew_defaultlocale;

extern fn icalproperty_vanew_defaulttzid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDefaulttzid = icalproperty_vanew_defaulttzid;

extern fn icalproperty_vanew_defaultvcars(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDefaultvcars = icalproperty_vanew_defaultvcars;

extern fn icalproperty_vanew_deny(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDeny = icalproperty_vanew_deny;

extern fn icalproperty_vanew_description(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewDescription = icalproperty_vanew_description;

extern fn icalproperty_vanew_dtend(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDtend = icalproperty_vanew_dtend;

extern fn icalproperty_vanew_dtstamp(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDtstamp = icalproperty_vanew_dtstamp;

extern fn icalproperty_vanew_dtstart(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDtstart = icalproperty_vanew_dtstart;

extern fn icalproperty_vanew_due(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDue = icalproperty_vanew_due;

extern fn icalproperty_vanew_duration(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewDuration = icalproperty_vanew_duration;

extern fn icalproperty_vanew_estimatedduration(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewEstimatedduration = icalproperty_vanew_estimatedduration;

extern fn icalproperty_vanew_exdate(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewExdate = icalproperty_vanew_exdate;

extern fn icalproperty_vanew_expand(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewExpand = icalproperty_vanew_expand;

extern fn icalproperty_vanew_exrule(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewExrule = icalproperty_vanew_exrule;

extern fn icalproperty_vanew_freebusy(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewFreebusy = icalproperty_vanew_freebusy;

extern fn icalproperty_vanew_geo(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewGeo = icalproperty_vanew_geo;

extern fn icalproperty_vanew_grant(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewGrant = icalproperty_vanew_grant;

extern fn icalproperty_vanew_image(p_v: *ical.attach, ...) *ical.property;
pub const icalpropertyVanewImage = icalproperty_vanew_image;

extern fn icalproperty_vanew_itipversion(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewItipversion = icalproperty_vanew_itipversion;

extern fn icalproperty_vanew_lastmodified(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewLastmodified = icalproperty_vanew_lastmodified;

extern fn icalproperty_vanew_location(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewLocation = icalproperty_vanew_location;

extern fn icalproperty_vanew_maxcomponentsize(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewMaxcomponentsize = icalproperty_vanew_maxcomponentsize;

extern fn icalproperty_vanew_maxdate(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewMaxdate = icalproperty_vanew_maxdate;

extern fn icalproperty_vanew_maxresults(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewMaxresults = icalproperty_vanew_maxresults;

extern fn icalproperty_vanew_maxresultssize(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewMaxresultssize = icalproperty_vanew_maxresultssize;

extern fn icalproperty_vanew_method(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewMethod = icalproperty_vanew_method;

extern fn icalproperty_vanew_mindate(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewMindate = icalproperty_vanew_mindate;

extern fn icalproperty_vanew_multipart(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewMultipart = icalproperty_vanew_multipart;

extern fn icalproperty_vanew_name(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewName = icalproperty_vanew_name;

extern fn icalproperty_vanew_organizer(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewOrganizer = icalproperty_vanew_organizer;

extern fn icalproperty_vanew_owner(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewOwner = icalproperty_vanew_owner;

extern fn icalproperty_vanew_patchdelete(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPatchdelete = icalproperty_vanew_patchdelete;

extern fn icalproperty_vanew_patchorder(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewPatchorder = icalproperty_vanew_patchorder;

extern fn icalproperty_vanew_patchparameter(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPatchparameter = icalproperty_vanew_patchparameter;

extern fn icalproperty_vanew_patchtarget(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPatchtarget = icalproperty_vanew_patchtarget;

extern fn icalproperty_vanew_patchversion(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPatchversion = icalproperty_vanew_patchversion;

extern fn icalproperty_vanew_percentcomplete(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewPercentcomplete = icalproperty_vanew_percentcomplete;

extern fn icalproperty_vanew_permission(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPermission = icalproperty_vanew_permission;

extern fn icalproperty_vanew_pollcompletion(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewPollcompletion = icalproperty_vanew_pollcompletion;

extern fn icalproperty_vanew_pollitemid(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewPollitemid = icalproperty_vanew_pollitemid;

extern fn icalproperty_vanew_pollmode(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewPollmode = icalproperty_vanew_pollmode;

extern fn icalproperty_vanew_pollproperties(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewPollproperties = icalproperty_vanew_pollproperties;

extern fn icalproperty_vanew_pollwinner(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewPollwinner = icalproperty_vanew_pollwinner;

extern fn icalproperty_vanew_priority(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewPriority = icalproperty_vanew_priority;

extern fn icalproperty_vanew_prodid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewProdid = icalproperty_vanew_prodid;

extern fn icalproperty_vanew_query(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewQuery = icalproperty_vanew_query;

extern fn icalproperty_vanew_queryid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewQueryid = icalproperty_vanew_queryid;

extern fn icalproperty_vanew_querylevel(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewQuerylevel = icalproperty_vanew_querylevel;

extern fn icalproperty_vanew_queryname(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewQueryname = icalproperty_vanew_queryname;

extern fn icalproperty_vanew_rdate(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewRdate = icalproperty_vanew_rdate;

extern fn icalproperty_vanew_recuraccepted(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRecuraccepted = icalproperty_vanew_recuraccepted;

extern fn icalproperty_vanew_recurexpand(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRecurexpand = icalproperty_vanew_recurexpand;

extern fn icalproperty_vanew_recurlimit(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRecurlimit = icalproperty_vanew_recurlimit;

extern fn icalproperty_vanew_recurrenceid(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewRecurrenceid = icalproperty_vanew_recurrenceid;

extern fn icalproperty_vanew_refreshinterval(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewRefreshinterval = icalproperty_vanew_refreshinterval;

extern fn icalproperty_vanew_relatedto(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRelatedto = icalproperty_vanew_relatedto;

extern fn icalproperty_vanew_relcalid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRelcalid = icalproperty_vanew_relcalid;

extern fn icalproperty_vanew_repeat(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewRepeat = icalproperty_vanew_repeat;

extern fn icalproperty_vanew_replyurl(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewReplyurl = icalproperty_vanew_replyurl;

extern fn icalproperty_vanew_requeststatus(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewRequeststatus = icalproperty_vanew_requeststatus;

extern fn icalproperty_vanew_resources(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewResources = icalproperty_vanew_resources;

extern fn icalproperty_vanew_response(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewResponse = icalproperty_vanew_response;

extern fn icalproperty_vanew_restriction(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewRestriction = icalproperty_vanew_restriction;

extern fn icalproperty_vanew_rrule(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewRrule = icalproperty_vanew_rrule;

extern fn icalproperty_vanew_scope(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewScope = icalproperty_vanew_scope;

extern fn icalproperty_vanew_sequence(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewSequence = icalproperty_vanew_sequence;

extern fn icalproperty_vanew_source(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewSource = icalproperty_vanew_source;

extern fn icalproperty_vanew_status(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewStatus = icalproperty_vanew_status;

extern fn icalproperty_vanew_storesexpanded(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewStoresexpanded = icalproperty_vanew_storesexpanded;

extern fn icalproperty_vanew_summary(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewSummary = icalproperty_vanew_summary;

extern fn icalproperty_vanew_target(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewTarget = icalproperty_vanew_target;

extern fn icalproperty_vanew_taskmode(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewTaskmode = icalproperty_vanew_taskmode;

extern fn icalproperty_vanew_transp(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewTransp = icalproperty_vanew_transp;

extern fn icalproperty_vanew_trigger(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewTrigger = icalproperty_vanew_trigger;

extern fn icalproperty_vanew_tzid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewTzid = icalproperty_vanew_tzid;

extern fn icalproperty_vanew_tzidaliasof(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewTzidaliasof = icalproperty_vanew_tzidaliasof;

extern fn icalproperty_vanew_tzname(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewTzname = icalproperty_vanew_tzname;

extern fn icalproperty_vanew_tzoffsetfrom(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewTzoffsetfrom = icalproperty_vanew_tzoffsetfrom;

extern fn icalproperty_vanew_tzoffsetto(p_v: c_int, ...) *ical.property;
pub const icalpropertyVanewTzoffsetto = icalproperty_vanew_tzoffsetto;

extern fn icalproperty_vanew_tzuntil(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewTzuntil = icalproperty_vanew_tzuntil;

extern fn icalproperty_vanew_tzurl(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewTzurl = icalproperty_vanew_tzurl;

extern fn icalproperty_vanew_uid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewUid = icalproperty_vanew_uid;

extern fn icalproperty_vanew_url(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewUrl = icalproperty_vanew_url;

extern fn icalproperty_vanew_version(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewVersion = icalproperty_vanew_version;

extern fn icalproperty_vanew_voter(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewVoter = icalproperty_vanew_voter;

extern fn icalproperty_vanew_x(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewX = icalproperty_vanew_x;

extern fn icalproperty_vanew_xlicclass(p_v: ?*anyopaque, ...) *ical.property;
pub const icalpropertyVanewXlicclass = icalproperty_vanew_xlicclass;

extern fn icalproperty_vanew_xlicclustercount(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicclustercount = icalproperty_vanew_xlicclustercount;

extern fn icalproperty_vanew_xlicerror(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicerror = icalproperty_vanew_xlicerror;

extern fn icalproperty_vanew_xlicmimecharset(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimecharset = icalproperty_vanew_xlicmimecharset;

extern fn icalproperty_vanew_xlicmimecid(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimecid = icalproperty_vanew_xlicmimecid;

extern fn icalproperty_vanew_xlicmimecontenttype(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimecontenttype = icalproperty_vanew_xlicmimecontenttype;

extern fn icalproperty_vanew_xlicmimeencoding(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimeencoding = icalproperty_vanew_xlicmimeencoding;

extern fn icalproperty_vanew_xlicmimefilename(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimefilename = icalproperty_vanew_xlicmimefilename;

extern fn icalproperty_vanew_xlicmimeoptinfo(p_v: [*:0]const u8, ...) *ical.property;
pub const icalpropertyVanewXlicmimeoptinfo = icalproperty_vanew_xlicmimeoptinfo;

extern fn icalrecur_expand_recurrence(p_rule: [*:0]const u8, p_start: std.posix.time_t, p_count: c_int, p_array: *std.posix.time_t) c_int;
pub const icalrecurExpandRecurrence = icalrecur_expand_recurrence;

extern fn icalrecur_freq_to_string(p_kind: ical.recurrencetype_frequency) [*:0]const u8;
pub const icalrecurFreqToString = icalrecur_freq_to_string;

extern fn icalrecur_iterator_free(p_arg0: *ical.recur_iterator) void;
pub const icalrecurIteratorFree = icalrecur_iterator_free;

extern fn icalrecur_iterator_new(p_rule: ?*anyopaque, p_dtstart: ?*anyopaque) *ical.recur_iterator;
pub const icalrecurIteratorNew = icalrecur_iterator_new;

extern fn icalrecur_iterator_next(p_arg0: *ical.recur_iterator) ?*anyopaque;
pub const icalrecurIteratorNext = icalrecur_iterator_next;

extern fn icalrecur_iterator_set_start(p_impl: *ical.recur_iterator, p_start: ?*anyopaque) c_int;
pub const icalrecurIteratorSetStart = icalrecur_iterator_set_start;

extern fn icalrecur_skip_to_string(p_kind: ical.recurrencetype_skip) [*:0]const u8;
pub const icalrecurSkipToString = icalrecur_skip_to_string;

extern fn icalrecur_string_to_freq(p_str: [*:0]const u8) ical.recurrencetype_frequency;
pub const icalrecurStringToFreq = icalrecur_string_to_freq;

extern fn icalrecur_string_to_skip(p_str: [*:0]const u8) ical.recurrencetype_skip;
pub const icalrecurStringToSkip = icalrecur_string_to_skip;

extern fn icalrecur_string_to_weekday(p_str: [*:0]const u8) ical.recurrencetype_weekday;
pub const icalrecurStringToWeekday = icalrecur_string_to_weekday;

extern fn icalrecur_weekday_to_string(p_kind: ical.recurrencetype_weekday) [*:0]const u8;
pub const icalrecurWeekdayToString = icalrecur_weekday_to_string;

extern fn icalrecurrencetype_as_string(p_recur: ?*anyopaque) [*:0]u8;
pub const icalrecurrencetypeAsString = icalrecurrencetype_as_string;

extern fn icalrecurrencetype_as_string_r(p_recur: ?*anyopaque) [*:0]u8;
pub const icalrecurrencetypeAsStringR = icalrecurrencetype_as_string_r;

extern fn icalrecurrencetype_clear(p_r: ?*anyopaque) void;
pub const icalrecurrencetypeClear = icalrecurrencetype_clear;

extern fn icalrecurrencetype_day_day_of_week(p_day: c_short) ?*anyopaque;
pub const icalrecurrencetypeDayDayOfWeek = icalrecurrencetype_day_day_of_week;

extern fn icalrecurrencetype_day_position(p_day: c_short) c_int;
pub const icalrecurrencetypeDayPosition = icalrecurrencetype_day_position;

extern fn icalrecurrencetype_from_string(p_str: [*:0]const u8) ?*anyopaque;
pub const icalrecurrencetypeFromString = icalrecurrencetype_from_string;

extern fn icalrecurrencetype_month_is_leap(p_month: c_short) c_int;
pub const icalrecurrencetypeMonthIsLeap = icalrecurrencetype_month_is_leap;

extern fn icalrecurrencetype_month_month(p_month: c_short) c_int;
pub const icalrecurrencetypeMonthMonth = icalrecurrencetype_month_month;

extern fn icalrecurrencetype_rscale_is_supported() c_int;
pub const icalrecurrencetypeRscaleIsSupported = icalrecurrencetype_rscale_is_supported;

extern fn icalrecurrencetype_rscale_supported_calendars() *ical.array;
pub const icalrecurrencetypeRscaleSupportedCalendars = icalrecurrencetype_rscale_supported_calendars;

extern fn icalreqstattype_as_string(p_arg0: ?*anyopaque) [*:0]const u8;
pub const icalreqstattypeAsString = icalreqstattype_as_string;

extern fn icalreqstattype_as_string_r(p_arg0: ?*anyopaque) [*:0]u8;
pub const icalreqstattypeAsStringR = icalreqstattype_as_string_r;

extern fn icalreqstattype_from_string(p_str: [*:0]const u8) ?*anyopaque;
pub const icalreqstattypeFromString = icalreqstattype_from_string;

extern fn icalrestriction_check(p_comp: *ical.component) c_int;
pub const icalrestrictionCheck = icalrestriction_check;

extern fn icalrestriction_compare(p_restr: ical.restriction_kind, p_count: c_int) c_int;
pub const icalrestrictionCompare = icalrestriction_compare;

extern fn icaltime_add(p_t: ?*anyopaque, p_d: ?*anyopaque) ?*anyopaque;
pub const icaltimeAdd = icaltime_add;

extern fn icaltime_adjust(p_tt: ?*anyopaque, p_days: c_int, p_hours: c_int, p_minutes: c_int, p_seconds: c_int) void;
pub const icaltimeAdjust = icaltime_adjust;

extern fn icaltime_as_ical_string(p_tt: ?*anyopaque) [*:0]const u8;
pub const icaltimeAsIcalString = icaltime_as_ical_string;

extern fn icaltime_as_ical_string_r(p_tt: ?*anyopaque) [*:0]u8;
pub const icaltimeAsIcalStringR = icaltime_as_ical_string_r;

extern fn icaltime_as_timet(p_arg0: ?*anyopaque) std.posix.time_t;
pub const icaltimeAsTimet = icaltime_as_timet;

extern fn icaltime_as_timet_with_zone(p_tt: ?*anyopaque, p_zone: *const ical.timezone) std.posix.time_t;
pub const icaltimeAsTimetWithZone = icaltime_as_timet_with_zone;

extern fn icaltime_compare(p_a: ?*anyopaque, p_b: ?*anyopaque) c_int;
pub const icaltimeCompare = icaltime_compare;

extern fn icaltime_compare_date_only(p_a: ?*anyopaque, p_b: ?*anyopaque) c_int;
pub const icaltimeCompareDateOnly = icaltime_compare_date_only;

extern fn icaltime_compare_date_only_tz(p_a: ?*anyopaque, p_b: ?*anyopaque, p_tz: *ical.timezone) c_int;
pub const icaltimeCompareDateOnlyTz = icaltime_compare_date_only_tz;

/// There are several ways to create a new icaltimetype:
///
///      - `ical.icaltimeNullTime`
///      - `ical.icaltimeNullDate`
///      - `ical.icaltimeCurrentTimeWithZone`
///      - `ical.icaltimeToday`
///      - icaltime_from_timet_with_zone(time_t tm, int is_date,
///              icaltimezone *zone)
///      - icaltime_from_day_of_year(int doy, int year)
///
///      italtimetype objects can be converted to different formats:
///
///      - icaltime_as_timet(struct icaltimetype tt)
///      - icaltime_as_timet_with_zone(struct icaltimetype tt,
///              icaltimezone *zone)
///      - icaltime_as_ical_string(struct icaltimetype tt)
///
///      Accessor methods include:
///
///      - icaltime_get_timezone(struct icaltimetype t)
///      - icaltime_get_tzid(struct icaltimetype t)
///      - icaltime_set_timezone(struct icaltimetype t, const icaltimezone *zone)
///      - icaltime_day_of_year(struct icaltimetype t)
///      - icaltime_day_of_week(struct icaltimetype t)
///      - icaltime_start_doy_week(struct icaltimetype t, int fdow)
///      - icaltime_week_number(struct icaltimetype t)
///
///      Query methods include:
///
///      - icaltime_is_null_time(struct icaltimetype t)
///      - icaltime_is_valid_time(struct icaltimetype t)
///      - icaltime_is_date(struct icaltimetype t)
///      - icaltime_is_utc(struct icaltimetype t)
///
///      Modify, compare and utility methods include:
///
///      - icaltime_compare(struct icaltimetype a,struct icaltimetype b)
///      - icaltime_compare_date_only(struct icaltimetype a,
///              struct icaltimetype b)
///      - icaltime_adjust(struct icaltimetype *tt, int days, int hours,
///              int minutes, int seconds);
///      - icaltime_normalize(struct icaltimetype t);
///      - icaltime_convert_to_zone(const struct icaltimetype tt,
///              icaltimezone *zone);
extern fn icaltime_convert_to_zone(p_tt: ?*anyopaque, p_zone: *ical.timezone) ?*anyopaque;
pub const icaltimeConvertToZone = icaltime_convert_to_zone;

extern fn icaltime_current_time_with_zone(p_zone: *const ical.timezone) ?*anyopaque;
pub const icaltimeCurrentTimeWithZone = icaltime_current_time_with_zone;

extern fn icaltime_day_of_week(p_t: ?*anyopaque) c_int;
pub const icaltimeDayOfWeek = icaltime_day_of_week;

extern fn icaltime_day_of_year(p_t: ?*anyopaque) c_int;
pub const icaltimeDayOfYear = icaltime_day_of_year;

extern fn icaltime_days_in_month(p_month: c_int, p_year: c_int) c_int;
pub const icaltimeDaysInMonth = icaltime_days_in_month;

extern fn icaltime_days_in_year(p_year: c_int) c_int;
pub const icaltimeDaysInYear = icaltime_days_in_year;

extern fn icaltime_from_day_of_year(p_doy: c_int, p_year: c_int) ?*anyopaque;
pub const icaltimeFromDayOfYear = icaltime_from_day_of_year;

/// is the same as that used by `ical.icaldurationtypeFromString`.
/// `par` Usage
/// ```c
/// // create icalperiodtype
/// const char *period_string = "20170606T090000/20170607T090000";
/// struct icalperiodtype period = icalperiodtype_from_string(period_string);
///
/// // print period in iCal format
/// printf("`s`\n", icalperiodtype_as_ical_string(period));
/// ```
extern fn icaltime_from_string(p_str: [*:0]const u8) ?*anyopaque;
pub const icaltimeFromString = icaltime_from_string;

extern fn icaltime_from_timet_with_zone(p_tm: std.posix.time_t, p_is_date: c_int, p_zone: *const ical.timezone) ?*anyopaque;
pub const icaltimeFromTimetWithZone = icaltime_from_timet_with_zone;

extern fn icaltime_get_timezone(p_t: ?*anyopaque) *const ical.timezone;
pub const icaltimeGetTimezone = icaltime_get_timezone;

extern fn icaltime_get_tzid(p_t: ?*anyopaque) [*:0]const u8;
pub const icaltimeGetTzid = icaltime_get_tzid;

extern fn icaltime_is_date(p_t: ?*anyopaque) c_int;
pub const icaltimeIsDate = icaltime_is_date;

extern fn icaltime_is_leap_year(p_year: c_int) c_int;
pub const icaltimeIsLeapYear = icaltime_is_leap_year;

extern fn icaltime_is_null_time(p_t: ?*anyopaque) c_int;
pub const icaltimeIsNullTime = icaltime_is_null_time;

extern fn icaltime_is_utc(p_t: ?*anyopaque) c_int;
pub const icaltimeIsUtc = icaltime_is_utc;

extern fn icaltime_is_valid_time(p_t: ?*anyopaque) c_int;
pub const icaltimeIsValidTime = icaltime_is_valid_time;

extern fn icaltime_normalize(p_tt: ?*anyopaque) ?*anyopaque;
pub const icaltimeNormalize = icaltime_normalize;

extern fn icaltime_null_date() ?*anyopaque;
pub const icaltimeNullDate = icaltime_null_date;

extern fn icaltime_null_time() ?*anyopaque;
pub const icaltimeNullTime = icaltime_null_time;

extern fn icaltime_set_timezone(p_t: ?*anyopaque, p_zone: *const ical.timezone) ?*anyopaque;
pub const icaltimeSetTimezone = icaltime_set_timezone;

extern fn icaltime_span_contains(p_s: *ical.time_span, p_container: *ical.time_span) c_int;
pub const icaltimeSpanContains = icaltime_span_contains;

extern fn icaltime_span_new(p_dtstart: ?*anyopaque, p_dtend: ?*anyopaque, p_is_busy: c_int) ?*anyopaque;
pub const icaltimeSpanNew = icaltime_span_new;

extern fn icaltime_span_overlaps(p_s1: *ical.time_span, p_s2: *ical.time_span) c_int;
pub const icaltimeSpanOverlaps = icaltime_span_overlaps;

extern fn icaltime_start_doy_week(p_t: ?*anyopaque, p_fdow: c_int) c_int;
pub const icaltimeStartDoyWeek = icaltime_start_doy_week;

extern fn icaltime_subtract(p_t1: ?*anyopaque, p_t2: ?*anyopaque) ?*anyopaque;
pub const icaltimeSubtract = icaltime_subtract;

extern fn icaltime_today() ?*anyopaque;
pub const icaltimeToday = icaltime_today;

extern fn icaltime_week_number(p_t: ?*anyopaque) c_int;
pub const icaltimeWeekNumber = icaltime_week_number;

extern fn icaltimezone_array_append_from_vtimezone(p_timezones: *ical.array, p_child: *ical.component) void;
pub const icaltimezoneArrayAppendFromVtimezone = icaltimezone_array_append_from_vtimezone;

extern fn icaltimezone_array_free(p_timezones: *ical.array) void;
pub const icaltimezoneArrayFree = icaltimezone_array_free;

extern fn icaltimezone_array_new() *ical.array;
pub const icaltimezoneArrayNew = icaltimezone_array_new;

extern fn icaltimezone_convert_time(p_tt: ?*anyopaque, p_from_zone: *ical.timezone, p_to_zone: *ical.timezone) void;
pub const icaltimezoneConvertTime = icaltimezone_convert_time;

extern fn icaltimezone_copy(p_originalzone: *ical.timezone) *ical.timezone;
pub const icaltimezoneCopy = icaltimezone_copy;

extern fn icaltimezone_dump_changes(p_zone: *ical.timezone, p_max_year: c_int, p_fp: ?*anyopaque) c_int;
pub const icaltimezoneDumpChanges = icaltimezone_dump_changes;

extern fn icaltimezone_expand_vtimezone(p_comp: *ical.component, p_end_year: c_int, p_changes: *ical.array) void;
pub const icaltimezoneExpandVtimezone = icaltimezone_expand_vtimezone;

extern fn icaltimezone_free(p_zone: *ical.timezone, p_free_struct: c_int) void;
pub const icaltimezoneFree = icaltimezone_free;

extern fn icaltimezone_free_builtin_timezones() void;
pub const icaltimezoneFreeBuiltinTimezones = icaltimezone_free_builtin_timezones;

extern fn icaltimezone_get_builtin_timezone(p_location: [*:0]const u8) *ical.timezone;
pub const icaltimezoneGetBuiltinTimezone = icaltimezone_get_builtin_timezone;

extern fn icaltimezone_get_builtin_timezone_from_offset(p_offset: c_int, p_tzname: [*:0]const u8) *ical.timezone;
pub const icaltimezoneGetBuiltinTimezoneFromOffset = icaltimezone_get_builtin_timezone_from_offset;

extern fn icaltimezone_get_builtin_timezone_from_tzid(p_tzid: [*:0]const u8) *ical.timezone;
pub const icaltimezoneGetBuiltinTimezoneFromTzid = icaltimezone_get_builtin_timezone_from_tzid;

extern fn icaltimezone_get_builtin_timezones() *ical.array;
pub const icaltimezoneGetBuiltinTimezones = icaltimezone_get_builtin_timezones;

extern fn icaltimezone_get_builtin_tzdata() c_int;
pub const icaltimezoneGetBuiltinTzdata = icaltimezone_get_builtin_tzdata;

extern fn icaltimezone_get_component(p_zone: *ical.timezone) *ical.component;
pub const icaltimezoneGetComponent = icaltimezone_get_component;

extern fn icaltimezone_get_display_name(p_zone: *ical.timezone) [*:0]const u8;
pub const icaltimezoneGetDisplayName = icaltimezone_get_display_name;

extern fn icaltimezone_get_latitude(p_zone: *ical.timezone) f64;
pub const icaltimezoneGetLatitude = icaltimezone_get_latitude;

extern fn icaltimezone_get_location(p_zone: *ical.timezone) [*:0]const u8;
pub const icaltimezoneGetLocation = icaltimezone_get_location;

extern fn icaltimezone_get_location_from_vtimezone(p_component: *ical.component) [*:0]u8;
pub const icaltimezoneGetLocationFromVtimezone = icaltimezone_get_location_from_vtimezone;

extern fn icaltimezone_get_longitude(p_zone: *ical.timezone) f64;
pub const icaltimezoneGetLongitude = icaltimezone_get_longitude;

extern fn icaltimezone_get_tzid(p_zone: *ical.timezone) [*:0]const u8;
pub const icaltimezoneGetTzid = icaltimezone_get_tzid;

extern fn icaltimezone_get_tznames(p_zone: *ical.timezone) [*:0]const u8;
pub const icaltimezoneGetTznames = icaltimezone_get_tznames;

extern fn icaltimezone_get_tznames_from_vtimezone(p_component: *ical.component) [*:0]u8;
pub const icaltimezoneGetTznamesFromVtimezone = icaltimezone_get_tznames_from_vtimezone;

extern fn icaltimezone_get_utc_offset(p_zone: *ical.timezone, p_tt: ?*anyopaque, p_is_daylight: *c_int) c_int;
pub const icaltimezoneGetUtcOffset = icaltimezone_get_utc_offset;

extern fn icaltimezone_get_utc_offset_of_utc_time(p_zone: *ical.timezone, p_tt: ?*anyopaque, p_is_daylight: *c_int) c_int;
pub const icaltimezoneGetUtcOffsetOfUtcTime = icaltimezone_get_utc_offset_of_utc_time;

extern fn icaltimezone_get_utc_timezone() *ical.timezone;
pub const icaltimezoneGetUtcTimezone = icaltimezone_get_utc_timezone;

extern fn icaltimezone_new() *ical.timezone;
pub const icaltimezoneNew = icaltimezone_new;

extern fn icaltimezone_release_zone_tab() void;
pub const icaltimezoneReleaseZoneTab = icaltimezone_release_zone_tab;

extern fn icaltimezone_set_builtin_tzdata(p_set: c_int) void;
pub const icaltimezoneSetBuiltinTzdata = icaltimezone_set_builtin_tzdata;

extern fn icaltimezone_set_component(p_zone: *ical.timezone, p_comp: *ical.component) c_int;
pub const icaltimezoneSetComponent = icaltimezone_set_component;

extern fn icaltimezone_set_tzid_prefix(p_new_prefix: [*:0]const u8) void;
pub const icaltimezoneSetTzidPrefix = icaltimezone_set_tzid_prefix;

extern fn icaltimezone_truncate_vtimezone(p_vtz: *ical.component, p_start: ical.timetype, p_end: ical.timetype, p_ms_compatible: c_int) void;
pub const icaltimezoneTruncateVtimezone = icaltimezone_truncate_vtimezone;

extern fn icaltimezone_tzid_prefix() [*:0]const u8;
pub const icaltimezoneTzidPrefix = icaltimezone_tzid_prefix;

extern fn icaltriggertype_from_int(p_reltime: c_int) ?*anyopaque;
pub const icaltriggertypeFromInt = icaltriggertype_from_int;

extern fn icaltriggertype_from_string(p_str: [*:0]const u8) ?*anyopaque;
pub const icaltriggertypeFromString = icaltriggertype_from_string;

extern fn icaltriggertype_is_bad_trigger(p_tr: ?*anyopaque) c_int;
pub const icaltriggertypeIsBadTrigger = icaltriggertype_is_bad_trigger;

extern fn icaltriggertype_is_null_trigger(p_tr: ?*anyopaque) c_int;
pub const icaltriggertypeIsNullTrigger = icaltriggertype_is_null_trigger;

extern fn icaltzutil_fetch_timezone(p_location: [*:0]const u8) *ical.component;
pub const icaltzutilFetchTimezone = icaltzutil_fetch_timezone;

extern fn icaltzutil_get_zone_directory() [*:0]const u8;
pub const icaltzutilGetZoneDirectory = icaltzutil_get_zone_directory;

extern fn icalvalue_as_ical_string(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueAsIcalString = icalvalue_as_ical_string;

extern fn icalvalue_as_ical_string_r(p_value: *const ical.value) [*:0]u8;
pub const icalvalueAsIcalStringR = icalvalue_as_ical_string_r;

extern fn icalvalue_compare(p_a: *const ical.value, p_b: *const ical.value) ical.parameter_xliccomparetype;
pub const icalvalueCompare = icalvalue_compare;

extern fn icalvalue_decode_ical_string(p_szText: [*:0]const u8, p_szDecText: [*:0]u8, p_nMaxBufferLen: c_int) c_int;
pub const icalvalueDecodeIcalString = icalvalue_decode_ical_string;

extern fn icalvalue_encode_ical_string(p_szText: [*:0]const u8, p_szEncText: [*:0]u8, p_MaxBufferLen: c_int) c_int;
pub const icalvalueEncodeIcalString = icalvalue_encode_ical_string;

extern fn icalvalue_free(p_value: *ical.value) void;
pub const icalvalueFree = icalvalue_free;

extern fn icalvalue_get_action(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetAction = icalvalue_get_action;

extern fn icalvalue_get_attach(p_value: *const ical.value) *ical.attach;
pub const icalvalueGetAttach = icalvalue_get_attach;

extern fn icalvalue_get_binary(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetBinary = icalvalue_get_binary;

extern fn icalvalue_get_boolean(p_value: *const ical.value) c_int;
pub const icalvalueGetBoolean = icalvalue_get_boolean;

extern fn icalvalue_get_busytype(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetBusytype = icalvalue_get_busytype;

extern fn icalvalue_get_caladdress(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetCaladdress = icalvalue_get_caladdress;

extern fn icalvalue_get_carlevel(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetCarlevel = icalvalue_get_carlevel;

extern fn icalvalue_get_class(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetClass = icalvalue_get_class;

extern fn icalvalue_get_cmd(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetCmd = icalvalue_get_cmd;

extern fn icalvalue_get_date(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetDate = icalvalue_get_date;

extern fn icalvalue_get_datetime(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetDatetime = icalvalue_get_datetime;

extern fn icalvalue_get_datetimedate(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetDatetimedate = icalvalue_get_datetimedate;

extern fn icalvalue_get_datetimeperiod(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetDatetimeperiod = icalvalue_get_datetimeperiod;

extern fn icalvalue_get_duration(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetDuration = icalvalue_get_duration;

extern fn icalvalue_get_float(p_value: *const ical.value) f32;
pub const icalvalueGetFloat = icalvalue_get_float;

extern fn icalvalue_get_geo(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetGeo = icalvalue_get_geo;

extern fn icalvalue_get_integer(p_value: *const ical.value) c_int;
pub const icalvalueGetInteger = icalvalue_get_integer;

extern fn icalvalue_get_method(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetMethod = icalvalue_get_method;

extern fn icalvalue_get_parent(p_value: *ical.value) *ical.property;
pub const icalvalueGetParent = icalvalue_get_parent;

extern fn icalvalue_get_period(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetPeriod = icalvalue_get_period;

extern fn icalvalue_get_pollcompletion(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetPollcompletion = icalvalue_get_pollcompletion;

extern fn icalvalue_get_pollmode(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetPollmode = icalvalue_get_pollmode;

extern fn icalvalue_get_query(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetQuery = icalvalue_get_query;

extern fn icalvalue_get_querylevel(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetQuerylevel = icalvalue_get_querylevel;

extern fn icalvalue_get_recur(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetRecur = icalvalue_get_recur;

extern fn icalvalue_get_requeststatus(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetRequeststatus = icalvalue_get_requeststatus;

extern fn icalvalue_get_status(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetStatus = icalvalue_get_status;

extern fn icalvalue_get_string(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetString = icalvalue_get_string;

extern fn icalvalue_get_taskmode(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetTaskmode = icalvalue_get_taskmode;

extern fn icalvalue_get_text(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetText = icalvalue_get_text;

extern fn icalvalue_get_transp(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetTransp = icalvalue_get_transp;

extern fn icalvalue_get_trigger(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetTrigger = icalvalue_get_trigger;

extern fn icalvalue_get_uri(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetUri = icalvalue_get_uri;

extern fn icalvalue_get_utcoffset(p_value: *const ical.value) c_int;
pub const icalvalueGetUtcoffset = icalvalue_get_utcoffset;

extern fn icalvalue_get_x(p_value: *const ical.value) [*:0]const u8;
pub const icalvalueGetX = icalvalue_get_x;

extern fn icalvalue_get_xlicclass(p_value: *const ical.value) ?*anyopaque;
pub const icalvalueGetXlicclass = icalvalue_get_xlicclass;

extern fn icalvalue_is_valid(p_value: *const ical.value) c_int;
pub const icalvalueIsValid = icalvalue_is_valid;

extern fn icalvalue_isa(p_value: *const ical.value) ical.value_kind;
pub const icalvalueIsa = icalvalue_isa;

extern fn icalvalue_isa_value(p_arg0: ?*anyopaque) c_int;
pub const icalvalueIsaValue = icalvalue_isa_value;

extern fn icalvalue_kind_is_valid(p_kind: ical.value_kind) c_int;
pub const icalvalueKindIsValid = icalvalue_kind_is_valid;

extern fn icalvalue_kind_to_string(p_kind: ical.value_kind) [*:0]const u8;
pub const icalvalueKindToString = icalvalue_kind_to_string;

extern fn icalvalue_new(p_kind: ical.value_kind) *ical.value;
pub const icalvalueNew = icalvalue_new;

extern fn icalvalue_new_action(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewAction = icalvalue_new_action;

extern fn icalvalue_new_attach(p_attach: *ical.attach) *ical.value;
pub const icalvalueNewAttach = icalvalue_new_attach;

extern fn icalvalue_new_binary(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewBinary = icalvalue_new_binary;

extern fn icalvalue_new_boolean(p_v: c_int) *ical.value;
pub const icalvalueNewBoolean = icalvalue_new_boolean;

extern fn icalvalue_new_busytype(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewBusytype = icalvalue_new_busytype;

extern fn icalvalue_new_caladdress(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewCaladdress = icalvalue_new_caladdress;

extern fn icalvalue_new_carlevel(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewCarlevel = icalvalue_new_carlevel;

extern fn icalvalue_new_class(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewClass = icalvalue_new_class;

extern fn icalvalue_new_clone(p_value: *const ical.value) *ical.value;
pub const icalvalueNewClone = icalvalue_new_clone;

extern fn icalvalue_new_cmd(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewCmd = icalvalue_new_cmd;

extern fn icalvalue_new_date(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewDate = icalvalue_new_date;

extern fn icalvalue_new_datetime(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewDatetime = icalvalue_new_datetime;

extern fn icalvalue_new_datetimedate(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewDatetimedate = icalvalue_new_datetimedate;

extern fn icalvalue_new_datetimeperiod(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewDatetimeperiod = icalvalue_new_datetimeperiod;

extern fn icalvalue_new_duration(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewDuration = icalvalue_new_duration;

extern fn icalvalue_new_float(p_v: f32) *ical.value;
pub const icalvalueNewFloat = icalvalue_new_float;

extern fn icalvalue_new_from_string(p_kind: ical.value_kind, p_str: [*:0]const u8) *ical.value;
pub const icalvalueNewFromString = icalvalue_new_from_string;

extern fn icalvalue_new_geo(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewGeo = icalvalue_new_geo;

extern fn icalvalue_new_integer(p_v: c_int) *ical.value;
pub const icalvalueNewInteger = icalvalue_new_integer;

extern fn icalvalue_new_method(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewMethod = icalvalue_new_method;

extern fn icalvalue_new_period(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewPeriod = icalvalue_new_period;

extern fn icalvalue_new_pollcompletion(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewPollcompletion = icalvalue_new_pollcompletion;

extern fn icalvalue_new_pollmode(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewPollmode = icalvalue_new_pollmode;

extern fn icalvalue_new_query(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewQuery = icalvalue_new_query;

extern fn icalvalue_new_querylevel(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewQuerylevel = icalvalue_new_querylevel;

extern fn icalvalue_new_recur(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewRecur = icalvalue_new_recur;

extern fn icalvalue_new_requeststatus(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewRequeststatus = icalvalue_new_requeststatus;

extern fn icalvalue_new_status(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewStatus = icalvalue_new_status;

extern fn icalvalue_new_string(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewString = icalvalue_new_string;

extern fn icalvalue_new_taskmode(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewTaskmode = icalvalue_new_taskmode;

extern fn icalvalue_new_text(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewText = icalvalue_new_text;

extern fn icalvalue_new_transp(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewTransp = icalvalue_new_transp;

extern fn icalvalue_new_trigger(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewTrigger = icalvalue_new_trigger;

extern fn icalvalue_new_uri(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewUri = icalvalue_new_uri;

extern fn icalvalue_new_utcoffset(p_v: c_int) *ical.value;
pub const icalvalueNewUtcoffset = icalvalue_new_utcoffset;

extern fn icalvalue_new_x(p_v: [*:0]const u8) *ical.value;
pub const icalvalueNewX = icalvalue_new_x;

extern fn icalvalue_new_xlicclass(p_v: ?*anyopaque) *ical.value;
pub const icalvalueNewXlicclass = icalvalue_new_xlicclass;

extern fn icalvalue_reset_kind(p_value: *ical.value) void;
pub const icalvalueResetKind = icalvalue_reset_kind;

extern fn icalvalue_set_action(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetAction = icalvalue_set_action;

extern fn icalvalue_set_attach(p_value: *ical.value, p_attach: *ical.attach) void;
pub const icalvalueSetAttach = icalvalue_set_attach;

extern fn icalvalue_set_binary(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetBinary = icalvalue_set_binary;

extern fn icalvalue_set_boolean(p_value: *ical.value, p_v: c_int) void;
pub const icalvalueSetBoolean = icalvalue_set_boolean;

extern fn icalvalue_set_busytype(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetBusytype = icalvalue_set_busytype;

extern fn icalvalue_set_caladdress(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetCaladdress = icalvalue_set_caladdress;

extern fn icalvalue_set_carlevel(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetCarlevel = icalvalue_set_carlevel;

extern fn icalvalue_set_class(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetClass = icalvalue_set_class;

extern fn icalvalue_set_cmd(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetCmd = icalvalue_set_cmd;

extern fn icalvalue_set_date(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetDate = icalvalue_set_date;

extern fn icalvalue_set_datetime(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetDatetime = icalvalue_set_datetime;

extern fn icalvalue_set_datetimedate(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetDatetimedate = icalvalue_set_datetimedate;

extern fn icalvalue_set_datetimeperiod(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetDatetimeperiod = icalvalue_set_datetimeperiod;

extern fn icalvalue_set_duration(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetDuration = icalvalue_set_duration;

extern fn icalvalue_set_float(p_value: *ical.value, p_v: f32) void;
pub const icalvalueSetFloat = icalvalue_set_float;

extern fn icalvalue_set_geo(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetGeo = icalvalue_set_geo;

extern fn icalvalue_set_integer(p_value: *ical.value, p_v: c_int) void;
pub const icalvalueSetInteger = icalvalue_set_integer;

extern fn icalvalue_set_method(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetMethod = icalvalue_set_method;

extern fn icalvalue_set_parent(p_value: *ical.value, p_property: *ical.property) void;
pub const icalvalueSetParent = icalvalue_set_parent;

extern fn icalvalue_set_period(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetPeriod = icalvalue_set_period;

extern fn icalvalue_set_pollcompletion(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetPollcompletion = icalvalue_set_pollcompletion;

extern fn icalvalue_set_pollmode(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetPollmode = icalvalue_set_pollmode;

extern fn icalvalue_set_query(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetQuery = icalvalue_set_query;

extern fn icalvalue_set_querylevel(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetQuerylevel = icalvalue_set_querylevel;

extern fn icalvalue_set_recur(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetRecur = icalvalue_set_recur;

extern fn icalvalue_set_requeststatus(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetRequeststatus = icalvalue_set_requeststatus;

extern fn icalvalue_set_status(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetStatus = icalvalue_set_status;

extern fn icalvalue_set_string(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetString = icalvalue_set_string;

extern fn icalvalue_set_taskmode(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetTaskmode = icalvalue_set_taskmode;

extern fn icalvalue_set_text(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetText = icalvalue_set_text;

extern fn icalvalue_set_transp(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetTransp = icalvalue_set_transp;

extern fn icalvalue_set_trigger(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetTrigger = icalvalue_set_trigger;

extern fn icalvalue_set_uri(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetUri = icalvalue_set_uri;

extern fn icalvalue_set_utcoffset(p_value: *ical.value, p_v: c_int) void;
pub const icalvalueSetUtcoffset = icalvalue_set_utcoffset;

extern fn icalvalue_set_x(p_value: *ical.value, p_v: [*:0]const u8) void;
pub const icalvalueSetX = icalvalue_set_x;

extern fn icalvalue_set_xlicclass(p_value: *ical.value, p_v: ?*anyopaque) void;
pub const icalvalueSetXlicclass = icalvalue_set_xlicclass;

extern fn icalvalue_string_to_kind(p_str: [*:0]const u8) ical.value_kind;
pub const icalvalueStringToKind = icalvalue_string_to_kind;

extern fn print_date_to_string(p_str: [*:0]u8, p_data: ?*anyopaque) void;
pub const printDateToString = print_date_to_string;

extern fn print_datetime_to_string(p_str: [*:0]u8, p_data: ?*anyopaque) void;
pub const printDatetimeToString = print_datetime_to_string;

extern fn pvl_apply(p_l: ical.pvl_list, p_f: ical.pvl_applyf, p_v: ?*anyopaque) void;
pub const pvlApply = pvl_apply;

extern fn pvl_clear(p_arg0: ical.pvl_list) void;
pub const pvlClear = pvl_clear;

extern fn pvl_count(p_arg0: ical.pvl_list) c_int;
pub const pvlCount = pvl_count;

extern fn pvl_data(p_arg0: ical.pvl_elem) ?*anyopaque;
pub const pvlData = pvl_data;

extern fn pvl_find(p_l: ical.pvl_list, p_f: ical.pvl_findf, p_v: ?*anyopaque) ical.pvl_elem;
pub const pvlFind = pvl_find;

extern fn pvl_find_next(p_l: ical.pvl_list, p_f: ical.pvl_findf, p_v: ?*anyopaque) ical.pvl_elem;
pub const pvlFindNext = pvl_find_next;

extern fn pvl_free(p_arg0: ical.pvl_list) void;
pub const pvlFree = pvl_free;

extern fn pvl_head(p_arg0: ical.pvl_list) ical.pvl_elem;
pub const pvlHead = pvl_head;

extern fn pvl_insert_after(p_l: ical.pvl_list, p_e: ical.pvl_elem, p_d: ?*anyopaque) void;
pub const pvlInsertAfter = pvl_insert_after;

extern fn pvl_insert_before(p_l: ical.pvl_list, p_e: ical.pvl_elem, p_d: ?*anyopaque) void;
pub const pvlInsertBefore = pvl_insert_before;

extern fn pvl_insert_ordered(p_l: ical.pvl_list, p_f: ical.pvl_comparef, p_d: ?*anyopaque) void;
pub const pvlInsertOrdered = pvl_insert_ordered;

extern fn pvl_new_element(p_d: ?*anyopaque, p_next: ical.pvl_elem, p_prior: ical.pvl_elem) ical.pvl_elem;
pub const pvlNewElement = pvl_new_element;

extern fn pvl_newlist() ical.pvl_list;
pub const pvlNewlist = pvl_newlist;

extern fn pvl_next(p_e: ical.pvl_elem) ical.pvl_elem;
pub const pvlNext = pvl_next;

extern fn pvl_pop(p_l: ical.pvl_list) ?*anyopaque;
pub const pvlPop = pvl_pop;

extern fn pvl_prior(p_e: ical.pvl_elem) ical.pvl_elem;
pub const pvlPrior = pvl_prior;

extern fn pvl_push(p_l: ical.pvl_list, p_d: ?*anyopaque) void;
pub const pvlPush = pvl_push;

extern fn pvl_remove(p_arg0: ical.pvl_list, p_arg1: ical.pvl_elem) ?*anyopaque;
pub const pvlRemove = pvl_remove;

extern fn pvl_shift(p_l: ical.pvl_list) ?*anyopaque;
pub const pvlShift = pvl_shift;

extern fn pvl_tail(p_arg0: ical.pvl_list) ical.pvl_elem;
pub const pvlTail = pvl_tail;

extern fn pvl_unshift(p_l: ical.pvl_list, p_d: ?*anyopaque) void;
pub const pvlUnshift = pvl_unshift;

extern fn ical_set_unknown_token_handling_setting(p_newSetting: ical._unknown_token_handling) void;
pub const setUnknownTokenHandlingSetting = ical_set_unknown_token_handling_setting;

extern fn set_zone_directory(p_path: [*:0]const u8) void;
pub const setZoneDirectory = set_zone_directory;

extern fn sspm_encoding_string(p_type: ?*anyopaque) [*:0]const u8;
pub const sspmEncodingString = sspm_encoding_string;

extern fn sspm_free_parts(p_parts: ?*anyopaque, p_max_parts: usize) void;
pub const sspmFreeParts = sspm_free_parts;

extern fn sspm_major_type_string(p_type: ?*anyopaque) [*:0]const u8;
pub const sspmMajorTypeString = sspm_major_type_string;

extern fn sspm_minor_type_string(p_type: ?*anyopaque) [*:0]const u8;
pub const sspmMinorTypeString = sspm_minor_type_string;

extern fn sspm_parse_mime(p_parts: ?*anyopaque, p_max_parts: usize, p_actions: ?*anyopaque, p_get_string: ?*anyopaque, p_get_string_data: ?*anyopaque, p_first_header: ?*anyopaque) c_int;
pub const sspmParseMime = sspm_parse_mime;

extern fn sspm_write_mime(p_parts: ?*anyopaque, p_num_parts: usize, p_output_string: *[*:0]u8, p_header: [*:0]const u8) c_int;
pub const sspmWriteMime = sspm_write_mime;

pub const icalattach_free_fn_t = *const fn (p_data: [*:0]u8, p_user_data: ?*anyopaque) callconv(.c) void;

pub const icalparser_line_gen_func = *const fn (p_s: [*:0]u8, p_size: usize, p_d: ?*anyopaque) callconv(.c) [*:0]u8;

pub const pvl_applyf = *const fn (p_a: ?*anyopaque, p_b: ?*anyopaque) callconv(.c) void;

pub const pvl_comparef = *const fn (p_a: ?*anyopaque, p_b: ?*anyopaque) callconv(.c) c_int;

pub const pvl_findf = *const fn (p_a: ?*anyopaque, p_b: ?*anyopaque) callconv(.c) c_int;

pub const BOOLEAN_FALSE = 0;
pub const BOOLEAN_TRUE = 1;
pub const BY_DAY_SIZE = -6;
pub const BY_HOUR_SIZE = 25;
pub const BY_MINUTE_SIZE = 61;
pub const BY_MONTHDAY_SIZE = 32;
pub const BY_MONTH_SIZE = 14;
pub const BY_SECOND_SIZE = 62;
pub const BY_WEEKNO_SIZE = 56;
pub const BY_YEARDAY_SIZE = 386;
pub const ERRORS_ARE_FATAL = 0;
pub const ICALPARAMETER_FIRST_ENUM = 20000;
pub const ICALPARAMETER_LAST_ENUM = 22300;
pub const ICALPROPERTY_FIRST_ENUM = 10000;
pub const ICALPROPERTY_LAST_ENUM = 11300;
pub const MAJOR_VERSION = 3;
pub const MINOR_VERSION = 0;
pub const PACKAGE = "libical";
pub const PATCH_VERSION = 20;
pub const VERSION = "3.0";
pub const ZONES_TAB_SYSTEM_FILENAME = "tab/zone_sun.tab";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
