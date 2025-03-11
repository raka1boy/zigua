const std = @import("std");
const FILO = @import("filo.zig").FILOStack;
const FixedPointFloat = @import("fixedpoint.zig").FixedPointFloat;
pub const NumType = f64; //FixedPointFloat(48, 16),

pub const UiuaValue = struct { va };
const UiuaInstance = struct {
    alloc: std.mem.Allocator,
    is_experimental: bool,
    stack: FILO(UiuaValue),

    pub fn init(comptime allocator: std.mem.Allocator) UiuaInstance {
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
