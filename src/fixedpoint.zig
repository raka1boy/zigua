const std = @import("std");

fn FixedPointFloat(whole_bits: comptime_int, decimal_bits: comptime_int) type {
    return struct {
        const Self = @This();
        buf: [whole_bits + decimal_bits]u1,

        pub fn add(self: *Self, other: Self) void {
            for (self.buf[0 .. whole_bits - 1]) |bit| {
                bit = bit or other.buf[0 .. whole_bits - 1][bit];
            }
        }
    };
}
