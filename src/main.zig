const std = @import("std");
const Uiua = @import("runtime.zig").UiuaInstance;
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    const instance = Uiua(allocator);
}
