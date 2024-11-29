OrthographicGrid = {}

tile_width = 64
tile_height = 32
grid_width = 10
grid_height = 10

offset_x = 400
offset_y = 100


player = { x = 5, y = 5 } -- Começa no centro do grid

function OrthographicGrid:drawGrid()
  -- love.graphics.setColor(1, 0, 0)   -- Vermelho
  -- love.graphics.rectangle("fill",
  --   player.x,
  --   player.y,
  --   tile_width / 2,
  --   tile_height / 2
  -- )

  for y = 1, grid_height do
    for x = 1, grid_width do
      local screen_x = (x - y) * tile_width / 2 + offset_x
      local screen_y = (x + y) * tile_height / 2 + offset_y

      love.graphics.setColor(1, 1, 1)
      love.graphics.polygon("line",
        screen_x, screen_y,
        screen_x + tile_width / 2, screen_y + tile_height / 2,
        screen_x, screen_y + tile_height,
        screen_x - tile_width / 2, screen_y + tile_height / 2
      )
    end
  end
end

-- function screenToGrid(mouse_x, mouse_y)
--   local x = ((mouse_x - offset_x) / (tile_width / 2) + (mouse_y - offset_y) / (tile_height / 2)) / 2
--   local y = ((mouse_y - offset_y) / (tile_height / 2) - (mouse_x - offset_x) / (tile_width / 2)) / 2
--   return math.floor(x + 1), math.floor(y + 1)
-- end

return OrthographicGrid
