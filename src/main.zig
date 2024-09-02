const std = @import("std");
const day1 = @import("day1/day1.zig");
const day2 = @import("day2/day2.zig");
const day3 = @import("day3/day3.zig");

pub fn main() !void {
    const day = 3;

    switch (day) {
        1 => try day1.run(),
        2 => try day2.run(),
        3 => try day3.run(),
        else => std.debug.print("Nothing to run.", .{}),
    }
}
