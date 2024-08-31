package sand_sim

import "core:log"
import "core:slice"
import rl "vendor:raylib"

Colors : []rl.Color = {rl.RED, rl.GREEN, rl.ORANGE, rl.BLUE}

main :: proc() {
    height := 720
    width := 1280
    grid := make([]rl.Color, height * width)

    // test sand
    // this should draw sand on the bottom
    for i in 0..<width {
        for j in 10..<20 {
            grid[(j * width) + i] = rl.GREEN
        }
    }

    context.logger = log.create_console_logger(.Info)
    rl.SetTargetFPS(60)
    rl.InitWindow(i32(width), i32(height), "Sand is coarse and rough")

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)

        // update
        // goes from bottom up (which is the order of the grid)
        for y in 0..< height - 1 {
            for x in 0..< width - 1 {
                curr_idx := (y * width) + x
                above_idx := ((y + 1) * width) + x
                slice.swap(grid, curr_idx, above_idx)
            }
        }

        // draw
        for y in 0..< height {
            for x in 0..< width {
                rl.DrawPixel(i32(x), i32(height - y), grid[(y * width) + x])
            }
        }

        rl.EndDrawing()
    }
    rl.CloseWindow()
}
