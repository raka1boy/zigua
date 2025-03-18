const std = @import("std");
const Uiua = @import("runtime.zig").UiuaInstance;
const FILO = @import("filo.zig").FILOStack;
const parse = @import("parser.zig");
const unicode = @import("code_point");
pub fn main() !void {
    const str = "Hi 😊";
    const iter = unicode.Iterator{ .bytes = str };
    std.debug.print("begin{any}", .{iter});
    // const data: []const u21 = @alignCast(@ptrCast("identity"));
    // const prim = try parse.getClosestPrimitive(data);
    // std.debug.print("{any}\n", .{prim});
}
