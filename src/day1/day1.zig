const std = @import("std");
const utils = @import("../utils.zig");

const dataFilePath = "./src/day1/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;
    const fileContent = try utils.readFileContents(allocator, dataFilePath);
    defer allocator.free(fileContent);
    std.debug.print("{s}\n", .{fileContent});

    var counter: i16 = 0;
    for (fileContent, 0..) |char, index| {
        if (char == '(') counter += 1 else counter -= 1;
        if (counter == -1) {
            std.debug.print("basement at pos {}\n", .{index + 1});
        }
    }

    std.debug.print("{}", .{counter});
}
