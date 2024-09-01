const std = @import("std");
const dataFilePath = "data";

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const fileContent = try readFileContents(allocator, dataFilePath);
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

fn readFileContents(allocator: std.mem.Allocator, filePath: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(filePath, .{});
    defer file.close();

    const fileSize = try file.getEndPos();
    const buffer = try allocator.alloc(u8, fileSize);

    _ = try file.readAll(buffer);

    return buffer;
}
