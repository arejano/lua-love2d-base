---@class Camera
---@field width number
---@field height number
local Camera = {}

function Camera:new(x, y, zoom, rotation)
  local obj = {
    x = x or 0,
    y = y or 0,
    zoom = zoom or 1,
    rotation = rotation or 0,
    width = Love.graphics.getWidth(),
    height = Love.graphics.getHeight(),
  }

  self.__index = self
  return setmetatable(obj, self)
end

function Camera:setPosition(x, y)
  self.x, self.y = x, y
end

function Camera:setZoom(zoom)
  self.zoom = zoom
end

function Camera:setRotation(rotation)
  self.rotation = rotation
end

function Camera:setResolution(resolution)
  self.width = resolution.width
  self.height = resolution.height
end

function Camera:applyTransform()
  Love.graphics.push()
  Love.graphics.translate(self.width / 2, self.height / 2)
  Love.graphics.scale(self.zoom)
  Love.graphics.rotate(self.rotation)
  Love.graphics.translate(-self.x, -self.y)
end

function Camera:resetTransform()
  Love.graphics.pop()
end

return Camera
