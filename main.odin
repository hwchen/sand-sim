package sand_sim

import "core:log"
import rl "vendor:raylib"

Colors : []rl.Color = {rl.RED, rl.GREEN, rl.ORANGE, rl.BLUE}

main :: proc() {
    height := 720
    width := 1280
    grid := make([]rl.Color, height * width)

    // test sand
    // this should draw sand on the bottom
    for i in 0..<width {
        for j in 0..<10 {
            grid[(j * width) + i] = rl.GREEN
        }
    }

    context.logger = log.create_console_logger(.Info)
    rl.SetTargetFPS(60)
    rl.InitWindow(i32(width), i32(height), "Sand is coarse and rough")

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)

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
