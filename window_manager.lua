wm = {}

--- @param resolution Resolution
function wm:setResolution(resolution)
  love.window.setMode(resolution.width, resolution.height)
end

function wm:setDefault()
  
  self:setResolution({ width = 630, height = 1000 })

  love.window.setIcon(love.image.newImageData(CONFIG.window.icon))
  love.window.setTitle(CONFIG.window.title .. ' - ' .. CONFIG.window.version)
  
  love.window.setPosition(1, 30)
end

return wm
