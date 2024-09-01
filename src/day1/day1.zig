const std = @import("std");
const utils = @import("../utils.zig");

const data_file_path = "./src/day1/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;
    const file_content = try utils.readFileContents(allocator, data_file_path);
    defer allocator.free(file_content);
    std.debug.print("{s}\n", .{file_content});

    var counter: i16 = 0;
    for (file_content, 0..) |char, index| {
        if (char == '(') counter += 1 else counter -= 1;
        if (counter == -1) {
            std.debug.print("basement at pos {}\n", .{index + 1});
        }
    }

    std.debug.print("{}", .{counter});
}
