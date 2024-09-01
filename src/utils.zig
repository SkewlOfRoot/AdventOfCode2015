const std = @import("std");

pub fn readFileContents(allocator: std.mem.Allocator, filePath: []const u8) ![]u8 {
    std.debug.print("open file: {s}\n", .{filePath});
    const cwd = try std.fs.cwd().realpathAlloc(allocator, "");
    defer allocator.free(cwd);
    std.debug.print("cwd: {s}\n", .{cwd});
    const file = try std.fs.cwd().openFile(filePath, .{});
    defer file.close();

    const fileSize = try file.getEndPos();
    const buffer = try allocator.alloc(u8, fileSize);

    _ = try file.readAll(buffer);

    return buffer;
}
