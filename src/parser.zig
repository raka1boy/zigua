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
const Token = struct {
    names: []const []const u8,
    glyph: u21,
    signature: Signature,
    description: []const u8,

    pub fn print_token(self: Token) void {
        std.debug.print(" names: ", .{});
        for (self.names) |name| {
            std.debug.print("{s}, ", .{name});
        }
        std.debug.print("\n glyph: {u}\n", .{self.glyph});
        std.debug.print(" signature: {any}\n desription: {s}\n", .{ self.signature, self.description });
    }
};
const tokens: []const Token = @import("tokens/primitives.zon");

test "tokens validity" {
    tokens[0].print_token();
    try std.testing.expectEqual(true, true);
}
