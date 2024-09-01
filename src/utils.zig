const std = @import("std");

pub fn readFileContents(allocator: std.mem.Allocator, filePath: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(filePath, .{});
    defer file.close();

    const fileSize = try file.getEndPos();
    const buffer = try allocator.alloc(u8, fileSize);

    _ = try file.readAll(buffer);

    return buffer;
}
