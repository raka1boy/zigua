const std = @import("std");
const FILO = @import("filo.zig").FILOStack;
const FixedPointFloat = @import("fixedpoint.zig").FixedPointFloat;
pub const NumType = f64; //FixedPointFloat(48, 16),

pub const UiuaValue = struct {
    data: []NumType,
    sha: []usize,

    pub fn init(data: []NumType, sha: []usize) UiuaValue {
        return .{ .data = data, .sha = sha };
    }
    pub fn shapeCheck(self: UiuaValue, other: UiuaValue) bool {
        //Checks whether two values can be used as args to a dyadic function and still yield the correct result.
        if (self.sha != other.sha or self.sha == &.{1} or other.sha == &.{1}) return false;
    }
};
const UiuaInstance = struct {
    alloc: std.mem.Allocator,
    is_experimental: bool,
    stack: FILO(UiuaValue),

    pub fn init(comptime allocator: std.mem.Allocator) UiuaInstance {
        return .{
            .alloc = allocator,
            .is_experimental = false,
            .stack = FILO(UiuaValue).init(allocator),
        };
    }
    pub fn deinit(self: *UiuaInstance) void {
        self.stack.deinit();
    }
};
