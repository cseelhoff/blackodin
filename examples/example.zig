//! Color Theme Demo for the Zig programming language
const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;

// Error set definition
const FileError = error{
    NotFound,
    AccessDenied,
};

// Constants and comptime values
const PI = 3.14159;
const MAX_SIZE = 100;
comptime {
    @compileLog("Compiling color theme demo");
}

// Struct with methods
const Point = struct {
    x: f32,
    y: f32,
    
    pub fn init(x: f32, y: f32) Point {
        return .{ .x = x, .y = y };
    }
    
    pub fn distance(self: Point, other: Point) f32 {
        return @sqrt(pow(self.x - other.x, 2) + pow(self.y - other.y, 2));
    }
};

// Enum with tagged union
const Shape = union(enum) {
    circle: struct { radius: f32 },
    rectangle: struct { width: f32, height: f32 },
    
    pub fn area(self: Shape) f32 {
        return switch (self) {
            .circle => |c| PI * c.radius * c.radius,
            .rectangle => |r| r.width * r.height,
        };
    }
};

// Public function with error handling
pub fn processData(data: []const u8) FileError!u32 {
    var sum: u32 = 0;
    
    // Different literals and control flow
    const hex_value = 0xFF;
    const binary = 0b1010;
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    
    if (data.len == 0) return FileError.NotFound;
    
    for (array, 0..) |item, i| {
        sum += item;
        if (i % 2 == 0) continue;
    }
    
    return sum;
}

// Test function
test "basic functionality" {
    const p1 = Point.init(0, 0);
    const p2 = Point.init(3, 4);
    try expect(p1.distance(p2) == 5);
    
    // Optional type and null
    var maybe_value: ?u32 = null;
    maybe_value = 42;
    if (maybe_value) |value| {
        print("Got value: {}\n", .{value});
    }
    
    // Defer statement
    {
        defer print("Runs at end of scope\n", .{});
        if (true) {
            // Early return with defer still working
            return;
        }
    }
}