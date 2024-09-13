package sand_sim

import "core:log"
import "core:slice"
import rl "vendor:raylib"

Colors : []rl.Color = {rl.RED, rl.GREEN, rl.ORANGE, rl.BLUE}

main :: proc() {
    win_height := 720
    win_width := 1280
    height := 360
    width := 640
    grid := make([]rl.Color, height * width)

    // test sand
    // this should draw sand on the bottom
    for i in 0..<width {
        for j in 10..<20 {
            grid[(j * width) + i] = rl.GREEN
        }
    }

    context.logger = log.create_console_logger(.Info)
    rl.InitWindow(i32(win_width), i32(win_height), "Sand is coarse and rough")

    for !rl.WindowShouldClose() {
        // update
        // goes from bottom up (which is the order of the grid)
        for y in 0..< height - 1 {
            for x in 0..< width - 1 {
                curr_idx := (y * width) + x
                above_idx := ((y + 1) * width) + x
                slice.swap(grid, curr_idx, above_idx)
            }
        }

        img := rl.Image {
            data = raw_data(grid),
            width = i32(width),
            height = i32(height),
            mipmaps = 1,
            format = rl.PixelFormat.UNCOMPRESSED_R8G8B8A8
        }
        texture := rl.LoadTextureFromImage(img)

        // draw
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)
        // neg height flips the image
        rl.DrawTexturePro(texture, {0,0,f32(width), f32(-height)}, {0,0, f32(win_width), f32(win_height)}, {0, 0}, 0, rl.WHITE)
        rl.EndDrawing()
    }
    rl.CloseWindow()
}
