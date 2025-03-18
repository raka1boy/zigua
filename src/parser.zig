const std = @import("std");
//const runtime = @import("runtime.zig");
const unicode = std.unicode;
const zon = std.zon;
const primitives: []const Primitive = @import("tokens/primitives.zon");

pub fn getClosestPrimitive(src: []const u21) !Primitive {
    var len: usize = 1;
    var indeces: [primitives.len]?usize = undefined;
    for (0..primitives.len) |i| indeces[i] = i;
    std.debug.print("indeces{any}\n", .{indeces}); //indeces{ 0, 1, 2, 3, 4 }
    var validIndeces: u8 = 0;
    while (validIndeces != 1) : ({
        len += 1;
        for (indeces) |indexNullcheck| {
            if (indexNullcheck != null) {
                validIndeces += 1;
            } else {
                validIndeces = std.math.sub(u8, validIndeces, 1) catch blk: {
                    break :blk 0;
                };
            }
        }
        if (validIndeces == 0) {
            return error.NoPrimitivesFound;
        }
    }) {
        std.debug.print("indeces{any}", .{indeces});
        for (indeces) |index| {
            if (validIndeces == 1) {
                for (indeces) |indx| {
                    if (indx != null) return primitives[indx.?];
                }
            }
            if (index != null) {
                for (primitives[index.?].names) |name| {
                    var name_slice: [10]u21 = undefined;
                    for (name[0..len], 0..) |value, i| {
                        name_slice[i] = @intCast(value);
                    }
                    std.debug.print("comparing slices: {u} and {u}\n", .{ src[0..len], name_slice[0..len] });
                    if (!std.mem.eql(u21, src[0..len], name_slice[0..len])) {
                        indeces[index.?] = null;
                    }
                }
            } else continue;
        }
    }
    return error.NotFound;
}
test "glyph recognition" {
    const data: []const u21 = @alignCast(@ptrCast("identity"));
    const prim = try getClosestPrimitive(data);
    try std.testing.expectEqual(prim.names[0], "identity");
}
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

test "tokens validity" {
    try std.testing.expectEqual(primitives[0].glyph[0], '∘');
}
