const std = @import("std");
const utils = @import("../utils.zig");
const filePath = "./src/day2/data";

pub fn run() !void {
    const allocator = std.heap.page_allocator;
    const file_contents = try utils.readFileContents(allocator, filePath);
    defer allocator.free(file_contents);

    std.debug.print("{s}\n", .{file_contents});

    var line_tokenizer = std.mem.tokenizeAny(u8, file_contents, "\n");

    var wrapping_list = std.ArrayList(u16).init(allocator);
    defer wrapping_list.deinit();

    var ribbon_list = std.ArrayList(u16).init(allocator);
    defer ribbon_list.deinit();

    while (line_tokenizer.next()) |line| {
        const bla = if (line[line.len - 1] == '\r') line[0 .. line.len - 1] else line;

        var dimension_tokenizer = std.mem.tokenizeAny(u8, bla, "x");
        const l: u16 = try std.fmt.parseInt(u8, dimension_tokenizer.next().?, 10);
        const w: u16 = try std.fmt.parseInt(u8, dimension_tokenizer.next().?, 10);
        const h: u16 = try std.fmt.parseInt(u8, dimension_tokenizer.next().?, 10);

        const side1 = l * w;
        const side2 = w * h;
        const side3 = h * l;

        const smallest_side = @min(side1, side2, side3);

        const wrapping_result = (2 * side1) + (2 * side2) + (2 * side3) + smallest_side;
        try wrapping_list.append(wrapping_result);

        var sides_list: [3]u16 = [3]u16{ l, w, h };

        // Sort list ascending
        std.mem.sort(u16, &sides_list, {}, comptime std.sort.asc(u16));

        const cube = l * w * h;
        const ribbon_result = (sides_list[0] * 2) + (sides_list[1] * 2) + cube;
        try ribbon_list.append(ribbon_result);
    }

    var wrapping_sum: u32 = 0;
    for (wrapping_list.items) |n| {
        wrapping_sum += n;
    }

    var ribbon_sum: u32 = 0;
    for (ribbon_list.items) |n| {
        ribbon_sum += n;
    }

    std.debug.print("Wrapping result: {}\n", .{wrapping_sum});
    std.debug.print("Ribbon result: {}\n", .{ribbon_sum});
}
