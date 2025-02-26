const std = @import("std");
//const runtime = @import("runtime.zig");
const zon = std.zon;
const Types = enum {
    any,
    number,
    string,
    char,
};
const Signature = struct { input: []const Types, output: []const Types };
const Token = struct { name: []const u8, glyph: u16, signature: Signature, description: []const u16 };
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const comptime_alloc = gpa.allocator();
const tokens = zon.parse.fromSlice(
    Token,
    comptime_alloc,
    @embedFile("tokens/primitives.zon"),
    null,
    .{},
).?;

test "tokens validity" {
    std.debug.print("{any}", .{tokens});
    std.testing.expectEqual(true, true);
}
