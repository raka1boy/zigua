const std = @import("std");
//const runtime = @import("runtime.zig");
const zon = std.zon;

pub fn parse(allocator: std.mem.Allocator, src: []const u21) ![]Token {}
const UiuaValue = @import("runtime.zig").UiuaValue;
const TokenType = enum { modifier, function };
const Signature = struct { input: usize, output: usize };
const Primitive = struct {
    names: []const []const u8,
    glyph: []const u21,
    signature: Signature,
    description: []const u8,
    is_pure: bool,
};
const Function = struct {
    tokens: []const Token,
    signature: Signature,
};
const Token = union(enum) {
    primitive: Primitive,
    func: Function,
    literal: UiuaValue,
    comment: []const u21,

    // fn printToken(self: Token) void {
    //     const token_typeinfo = @typeInfo(@TypeOf(self));
    //     const fields = token_typeinfo.@"struct".fields;
    //     for (fields) |field| {
    //         std.debug.print("{any}{\n", .{field.name});
    //         switch (self) {
    //             Token.primitive =>|val| {
    //                 std.debug.print("{}\n", .{val.name});
    //             }
    //     }
    // }
};
const tokens: []const Primitive = @import("tokens/primitives.zon");

test "tokens validity" {
    try std.testing.expectEqual(tokens[0].glyph[0], '∘');
}

test "parser" {
    const src: []const u21 =
        \\+ 1 2
    ;
    const allocator = std.heap.page_allocator;
    defer allocator.free(tokens);
    const tokens = try parse(allocator, src);
    try std.testing.expectEqual(tokens[0].primitive., '∘');
}
