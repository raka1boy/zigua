const std = @import("std");
const runtime = @import("runtime.zig");
pub const UiuaValue = union(enum) {
    Number: UiuaDatatype(f64),
    String: UiuaDatatype(u16),
};
const TokenType = union(enum) {
    Literal: UiuaValue,
    Primitive: Primitives,
    Identifier: []u16,
    Function: []Primitives,
};
pub fn UiuaDatatype(comptime T: type) type {
    return struct {
        const Self = @This();
        shape: []i32, //1
        value: []T,
        pub fn init(sha: []i32) Self {
            const total_len = 0;
            for (sha) |value| {
                total_len *= value;
            }
            return .{ .shape = sha, .value = std.mem.zeroes([total_len]T) };
        }
        pub fn initWithData(data: T, sha: []i32) Self {
            const total_len = 0;
            for (sha) |value| {
                total_len *= value;
            }
            return .{ .shape = sha, .value = std.mem.zeroInit([total_len]T, data) };
        }

        pub fn add(self: Self, other: UiuaValue) EvalError!UiuaValue {
            const other_val = switch (other) {
                .Number => |num| num.value,
                .String => |str| str.value,
            };
            const other_sha = switch (other) {
                .Number => |num| num.shape,
                .String => |str| str.shape,
            };
            const shape_matches = self.shape == other_sha;
            const one_is_scalar = self.shape.len == 1 or other_sha == 1;
            if (!(shape_matches or one_is_scalar)) return EvalError.ShapeMismatch;
            if (one_is_scalar) {
                var adder = 0;
                const array = if (self.value.len > other_val) {
                    self.value;
                    adder = other_val;
                } else {
                    other_val;
                    adder = self.value;
                };
                for (array) |*item| {
                    item.* += adder;
                }
                return array;
            } else {
                for (self.value, other_val) |*x, *y| {
                    x.* += y.*;
                }
                return self.value;
            }
        }
    };
}
const Token = struct {
    UiuaType: TokenType,

    pub fn evalInThisContext(self: *Token, context: *runtime.UiuaInstance()) EvalError!void {
        switch (self.UiuaType) {
            .Literal => |lit| {
                context.*.stack.write(lit);
            },
            .Primitive => |prim| {
                switch (prim) {
                    .add => {
                        const a = context.*.pop_value();
                        if (!a) {
                            return EvalError.StackEmpty;
                        }
                        const b = context.*.pop_value();
                        if (!b) {
                            return EvalError.StackEmpty;
                        }
                        return a.add(b);
                    },
                }
            },
        }
    }
};
const Primitives = enum(u16) {
    add = "+",
};
pub const Function = struct {
    name: []u16,
    signature: Signature,
    body: []Token,
};
pub const Signature = enum { noadic, monadic, dyadic, triadic, unknown };
pub const EvalError = error{
    InvalidSyntax,
    StackEmpty,
    ShapeMismatch,
};
