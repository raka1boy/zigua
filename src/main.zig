const std = @import("std");
const Uiua = @import("runtime.zig").UiuaInstance;
const FILO = @import("filo.zig").FILOStack;
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const gpalloc = gpa.allocator();
    defer _ = gpa.deinit();
    var filo = FILO(i32).init(gpalloc);
    defer filo.deinit();
    try filo.push(1);
    try filo.push(2);
    try filo.push(3);
    std.debug.print("{any}\n", .{try filo.pop()});
}
