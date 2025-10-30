const config = @import("./config.zig");
const widget = @import("common").widget;
const std = @import("std");
const gtk = @import("gtk");

pub fn mapWidgetConfigToWidget(allocator: *std.mem.Allocator, cfg: config.ConfigWidgetConfig, details: widget.InitializationDetails) !widget.Component{
    return switch(cfg) {
        .example_widget_1 => |a| widget.wrapDefineComponent(widget.ExampleWidget,  try widget.ExampleWidget.init(allocator, .{ .label = a.label }, details)),
        .clock => |a| widget.wrapDefineComponent(widget.clock.Clock, try widget.clock.Clock.init(allocator, a, details)),
        .indicators => |a| widget.wrapDefineComponent(widget.indicators.Indicators, try widget.indicators.Indicators.init(allocator, a, details)),
        .icon => |a| widget.wrapDefineComponent(widget.icon.Icon, try widget.icon.Icon.init(allocator, a, details)),
        .hyprland_workspaces => |a| widget.wrapDefineComponent(widget.hyprland.HyprlandWorkspaces, try widget.hyprland.HyprlandWorkspaces.init(allocator, a, details)),
        .power_button => |a| widget.wrapDefineComponent(widget.power_button.PowerButton, try widget.power_button.PowerButton.init(allocator, a, details)),
    };
}
