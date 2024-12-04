local Animation = require 'core.Animation'

---@alias ToAnimate { path:string,width:number,height:number,split:number, state:number}

---@class Anim
---@field animations Animation[]
local Anim = {
  animations = {},
  animations_by_state = {}
}
Anim.__index = Anim

---@param to_animate ToAnimate[]
function Anim:new(to_animate)
  local _self = setmetatable({}, Anim)
  for _, animate in ipairs(to_animate) do
    table.insert(_self.animations, Animation:new(animate))

    if _self.animations_by_state[animate.state] == nil then
      _self.animations_by_state[animate.state] = {}
    end

    table.insert(_self.animations_by_state[animate.state], #_self.animations)
  end

  return _self
end

function Anim:draw()

end

return Anim
