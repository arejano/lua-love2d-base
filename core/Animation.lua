---@class Animation
---@field animate any
---@field atlas any
local Animation = {
  atlas = nil,
  animate = nil,
}
Animation.__index = Animation


---@param to_animate ToAnimate
function Animation:new(to_animate)
  local _self = setmetatable({}, Animation)

  _self.atlas = Love.graphics.newImage(to_animate.path)

  local dimension = _self.atlas:getDimensions()

  _self.animate = to_animate;
  return _self
end

function Animation:draw()

end

function Animation:createQuad()
end

return Animation
