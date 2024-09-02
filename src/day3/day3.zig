const std = @import("std");
const utils = @import("../utils.zig");

const filePath = "./src/day3/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;

    const file_contents = try utils.readFileContents(allocator, filePath);
    defer allocator.free(file_contents);

    std.debug.print("File contents: {s}\n", .{file_contents});

    var map = std.HashMap(Point, u8, Point, std.hash_map.default_max_load_percentage).initContext(allocator, Point{ .x = 0, .y = 0 });
    defer map.deinit();

    var current_x: i16 = 0;
    var current_y: i16 = 0;
    const starting_point = Point{ .x = current_x, .y = current_y };
    try map.put(starting_point, 1);

    for (file_contents) |c| {
        switch (c) {
            '^' => current_y += 1,
            'v' => current_y -= 1,
            '>' => current_x += 1,
            '<' => current_x -= 1,
            else => std.debug.print("ERROR", .{}),
        }
        const point = Point{ .x = current_x, .y = current_y };
        const entry = try map.getOrPut(point);
        if (entry.found_existing) {
            entry.value_ptr.* += 1;
        } else {
            entry.value_ptr.* = 1;
        }
    }

    const result = map.count();
    std.debug.print("Result: {}", .{result});
}

fn returnLen(t: anytype) usize {
    return t.len;
}

const Point = struct {
    x: i32,
    y: i32,

    pub fn hash(_: Point, p: Point) u64 {
        var hash_value: u64 = 0;
        const allocator = std.heap.page_allocator;

        // Can't figure out how to hash a i32, so converting to str instead. Ugly.
        const xstr = std.fmt.allocPrint(allocator, "{d}", .{p.x}) catch "0";
        defer allocator.free(xstr);
        const ystr = std.fmt.allocPrint(allocator, "{d}", .{p.y}) catch "0";
        defer allocator.free(ystr);

        hash_value = std.hash.CityHash64.hashWithSeed(xstr, hash_value);
        hash_value = std.hash.CityHash64.hashWithSeed(ystr, hash_value);
        return hash_value;
    }

    pub fn eql(_: Point, a: Point, b: Point) bool {
        return a.x == b.x and a.y == b.y;
    }
};

pub fn pointToStr(allocator: std.mem.Allocator, p: Point) ![]const u8 {
    return try std.fmt.allocPrint(allocator, "{d},{d}", .{ p.x, p.y });
}
