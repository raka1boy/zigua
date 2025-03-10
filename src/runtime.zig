const std = @import("std");
const FILO = @import("filo.zig").FILOStack;
const NumTypes = enum {
    int, //truncates, mostly useless емае
    smallfloat,
    bigfloat,
    fixedpoint,
};

const UiuaValue = struct {};
const UiuaInstance = struct {
    num_type: NumTypes,
    alloc: std.mem.Allocator,
    is_experimental: bool,
    stack: FILO(UiuaValue),

    pub fn init(comptime allocator: std.mem.Allocator, comptime num_type: NumTypes) UiuaInstance {
        return .{
            .alloc = allocator,
            .num_type = num_type,
            .is_experimental = false,
            .stack = FILO(UiuaValue).init(allocator),
        };
    }
    pub fn deinit(self: *UiuaInstance) void {
        self.stack.deinit();
    }
};
