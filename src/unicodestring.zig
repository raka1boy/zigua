const std = @import("std");
const unicode = std.unicode;

const UnicodeStringType = enum {
    static, //no allocator
    dynamic, //needs alloc
};
pub fn UnicodeString(str_type: UnicodeStringType) type {
    return struct {
        const Self = @This();
        const MaybeAllocator = if (str_type == .dynamic) std.mem.Allocator else void;
        alloc: MaybeAllocator,
        _rodata: []const u8,
        len: usize,

        fn init(alloc: MaybeAllocator, src: []const u8) !Self {
            if (!unicode.utf8ValidateSlice(src)) return UnicodeStrError.InvalidUTF8;
            const length = 10;
            return .{
                .alloc = alloc,
                ._rodata = src,
                .len = length,
            };
        }

        pub fn equals(self: Self, other: Self) bool {
            return std.mem.eql(u8, self._rodata, other._rodata);
        }
    };
}
pub const UnicodeStrError = error{
    InvalidUTF8,
};
test "unicode str functionality" {
    const str1 = try UnicodeString(.static).init({}, "∘∘∘");
    const str2 = try UnicodeString(.static).init({}, "∘∘∘");
    try std.testing.expectEqual(str1.equals(str2), true);
}
