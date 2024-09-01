const std = @import("std");
const utils = @import("../utils.zig");
const filePath = "./src/day2/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;
    const fileContents = try utils.readFileContents(allocator, filePath);
    defer allocator.free(fileContents);

    std.debug.print("{s}\n", .{fileContents});

    var lineTokenizer = std.mem.tokenizeAny(u8, fileContents, "\n");

    var wrappingList = std.ArrayList(u16).init(allocator);
    defer wrappingList.deinit();

    var ribbonList = std.ArrayList(u16).init(allocator);
    defer ribbonList.deinit();

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

        const wrappingResult = (2 * side1) + (2 * side2) + (2 * side3) + smallestSide;
        try wrappingList.append(wrappingResult);

        var sidesList: [3]u16 = [3]u16{ l, w, h };

        // Sort list ascending
        std.mem.sort(u16, &sidesList, {}, comptime std.sort.asc(u16));

        const cube = l * w * h;
        const ribbonResult = (sidesList[0] * 2) + (sidesList[1] * 2) + cube;
        try ribbonList.append(ribbonResult);
    }

    var wrappingSum: u32 = 0;
    for (wrappingList.items) |n| {
        wrappingSum += n;
    }

    var ribbonSum: u32 = 0;
    for (ribbonList.items) |n| {
        ribbonSum += n;
    }

    std.debug.print("Wrapping result: {}\n", .{wrappingSum});
    std.debug.print("Ribbon result: {}\n", .{ribbonSum});
}
