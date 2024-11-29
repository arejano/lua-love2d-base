Debug = {}

---@param world Ecs
function Debug:draw_debug(world, love_loop)
  local drawTimeStart = love.timer.getTime()
  local drawTimeEnd = love.timer.getTime()
  local drawTime = drawTimeEnd - drawTimeStart

  if DEBUG then
    love.graphics.push()

    local x, y = CONFIG.debug.stats.position.x, CONFIG.debug.stats.position.y
    local dy = CONFIG.debug.stats.lineHeight
    local stats = love.graphics.getStats()
    local memoryUnit = "KB"
    local ram = collectgarbage("count")
    local vram = stats.texturememory / 1024
    if not CONFIG.debug.stats.kilobytes then
      ram = ram / 1024
      vram = vram / 1024
      memoryUnit = "MB"
    end
    local info = {
      "LOVE_LOOP: " .. love_loop,
      "FPS: " .. ("%3d"):format(love.timer.getFPS()),
      "DRAW: " .. ("%7.3fms"):format(Lume.round(drawTime * 1000, .001)),
      "RAM: " .. string.format("%7.2f", Lume.round(ram, .01)) .. memoryUnit,
      "VRAM: " .. string.format("%6.2f", Lume.round(vram, .01)) .. memoryUnit,
      "Draw calls: " .. stats.drawcalls,
      "Images: " .. stats.images,
      -- "Canvases: " .. stats.canvases,
      -- "\tSwitches: " .. stats.canvasswitches,
      -- "Shader switches: " .. stats.shaderswitches,
      -- "Fonts: " .. stats.fonts,
      "Mouse_X: " .. MOUSE_INFO.x,
      "Mouse_Y: " .. MOUSE_INFO.y,
      "World: " .. Inspect(world),
    }
    -- love.graphics.setFont(CONFIG.debug.stats.font[CONFIG.debug.stats.fontSize])
    for i, text in ipairs(info) do
      local sx, sy = CONFIG.debug.stats.shadowOffset.x, CONFIG.debug.stats.shadowOffset.y
      love.graphics.setColor(CONFIG.debug.stats.shadow)
      love.graphics.print(text, x + sx, y + sy + (i - 1) * dy)
      love.graphics.setColor(CONFIG.debug.stats.foreground)
      love.graphics.print(text, x, y + (i - 1) * dy)
    end
    love.graphics.pop()
  end
end


function Debug:draw_lines()
  love.graphics.setColor(255, 0, 0)
  -- Tamanho da tela
  local largura, altura = love.graphics.getDimensions()

  -- Coordenadas do meio da tela
  local centroX = largura / 2
  local centroY = altura / 2

  -- Desenhar uma linha horizontal no meio da tela
  love.graphics.line(0, centroY, largura, centroY) -- De ponta a ponta horizontalmente

  -- Desenhar uma linha vertical no meio da tela
  love.graphics.line(centroX, 0, centroX, altura) -- De ponta a ponta verticalmente
end

return Debug
