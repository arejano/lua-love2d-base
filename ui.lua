GameUI = {
  buttons = {},
}
GameUI.__index = GameUI


function GameUI:new()
  local _self = setmetatable({}, GameUI)
  return _self
end

function GameUI:button()

end

function GameUI:draw()
end

return GameUI
