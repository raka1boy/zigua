const std = @import("std");
const values = @import("values.zig");

fn UiuaInstance(alloc: std.mem.Allocator) type {
    return struct {
        const Self = @This();
        allocator: std.mem.Allocator,
        stack: std.fifo.LinearFifo(values.UiuaValue, .Dynamic),

        pub fn pop_value(self: *Self) values.EvalError!values.UiuaValue {
            const val = self.stack.readItem();
            if (val) {
                return val;
            } else {
                return .StackEmpty;
            }
        }
        pub fn put_value(self: *Self, val: values.UiuaValue) !void {
            _ = try self.stack.writeItem(val);
        }
    }{ .allocator = alloc, .stack = std.fifo.LinearFifo(values.UiuaValue, .Dynamic).init(alloc) };
}
