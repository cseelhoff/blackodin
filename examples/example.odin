//
// Color Theme Demo for the Odin programming language
//
package demo

import "core:fmt"
import "core:math"
import str "core:strings"

// Constants and global variables
PI :: 3.14159
MAX_SIZE :: 100
Colors :: enum {
    Red,
    Green,
    Blue,
    Yellow,
}

// Example enum with explicit values
Season :: enum {
    Spring = 1,
    Summer = 2, 
    Autumn = 3,
    Winter = 4,
}

// Struct definition
Point :: struct {
    x, y: f32,
    name: string,
}

// Union type
Value :: union {
    int,
    f32,
    string,
}

// Procedure (function) with multiple returns
calculate_area :: proc(shape: string, values: []f32) -> (area: f32, ok: bool) {
    if shape == "circle" && len(values) >= 1 {
        return PI * math.pow(values[0], 2), true
    } else if shape == "rectangle" && len(values) >= 2 {
        return values[0] * values[1], true
    }
    return 0, false
}

// Main procedure with error handling, slices, and control flow
main :: proc() {
    points := [3]Point{
        {0, 0, "origin"},
        {1, 0, "right"},
        {0, 1, "up"},
    }
    
    // Using 'new' to allocate a Point on the heap
    dynamic_point := new(Point)
    dynamic_point.x = 10
    dynamic_point.y = 20
    dynamic_point.name = "dynamic"
    fmt.printf("Heap-allocated point: {%f, %f, %s}\n", dynamic_point.x, dynamic_point.y, dynamic_point.name)
    
    // Alternatively, allocate and initialize with a value
    another_point := new_clone(Point{5, 5, "another"})
    for value, i in values {
        #partial switch v in value {
        case int:
            fmt.printf("Integer at %d: %d\n", i, v)
        case string:
            fmt.printf("String at %d: %s\n", i, v)
        }
    }
    
    // Raw string and error handling
    text := `Raw "string" with no escapes`
    if area, ok := calculate_area("circle", []f32{5}); ok {
        fmt.println("Area:", area, text)
    }
}