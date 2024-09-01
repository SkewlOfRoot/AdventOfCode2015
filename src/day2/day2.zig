const std = @import("std");
const utils = @import("../utils.zig");
const filePath = "./src/day2/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;
    const fileContents = try utils.readFileContents(allocator, filePath);
    defer allocator.free(fileContents);

    std.debug.print("{s}\n", .{fileContents});

    var lineTokenizer = std.mem.tokenizeAny(u8, fileContents, "\n");

    var list = std.ArrayList(u16).init(allocator);
    defer list.deinit();

    while (lineTokenizer.next()) |line| {
        const bla = if (line[line.len - 1] == '\r') line[0 .. line.len - 1] else line;

        var dimensionTokenizer = std.mem.tokenizeAny(u8, bla, "x");
        const l: u16 = try std.fmt.parseInt(u8, dimensionTokenizer.next().?, 10);
        const w: u16 = try std.fmt.parseInt(u8, dimensionTokenizer.next().?, 10);
        const h: u16 = try std.fmt.parseInt(u8, dimensionTokenizer.next().?, 10);

        const side1 = l * w;
        const side2 = w * h;
        const side3 = h * l;

        const smallestSide = @min(side1, side2, side3);

        const result = (2 * side1) + (2 * side2) + (2 * side3) + smallestSide;
        try list.append(result);
    }

    var sum: u32 = 0;
    for (list.items) |n| {
        sum += n;
    }

    std.debug.print("Result: {}\n", .{sum});
}
