const std = @import("std");
const Uiua = @import("runtime.zig").UiuaInstance;
const FILO = @import("filo.zig").FILOStack;
const parse = @import("parser.zig");
pub fn main() !void {
    std.debug.print("begin", .{});
    const data: []const u21 = @alignCast(@ptrCast("identity"));
    const prim = try parse.getClosestPrimitive(data);
    std.debug.print("{any}\n", .{prim});
}
