const std = @import("std");

pub fn FILOStack(comptime T: type) type {
    return struct {
        const Self = @This();
        buf: []T,
        alloc: std.mem.Allocator,
        empty_pos: usize, //insertion boint at all times
        pub fn init(alloc: std.mem.Allocator) Self { //try alloc.alloc(T, 1)
            return .{ .alloc = alloc, .buf = &.{}, .empty_pos = 0 };
        }
        pub fn resize(self: *Self, new_size: usize) !void {
            const new_buf = try self.alloc.alloc(T, new_size);
            @memcpy(new_buf[0..self.buf.len], self.buf);
            self.alloc.free(self.buf);
            self.buf = new_buf;
            //self.buf = try self.alloc.realloc(self.buf, new_size);
        }
        pub fn deinit(self: *Self) void {
            self.alloc.free(self.buf);
        }
        pub fn growByOne(self: *Self) !void {
            try self.resize(self.buf.len + 1);
        }
        pub fn push(self: *Self, val: T) !void {
            if (self.empty_pos == self.buf.len) try self.growByOne();
            self.buf[self.empty_pos] = val;
            self.empty_pos += 1;
        }
        pub fn pop(self: *Self) !T {
            if (self.empty_pos <= 0) return error.StackEmpty;
            const return_pos = self.empty_pos - 1;
            self.empty_pos -= 1;
            return self.buf[return_pos];
        }
        pub fn peek(self: Self) T {
            return self.buf[self.buf.len - 1];
        }
    };
}

test "filo growth" {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var stack = FILOStack(i32).init(allocator);
    defer stack.deinit();
    try stack.push(123);
    try std.testing.expectEqual(@as(usize, 1), stack.buf.len);
}
