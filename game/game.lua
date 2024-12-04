-- Systems
require 'game.game_globals'

local pms = require 'game.systems.player_move'
local pls = require 'game.systems.life_system'
local pcs = require 'game.systems.combat_system'

local controller_system = require 'game.systems.controller_system'
local camera_system = require 'game.systems.camera_system'

local render_system = require 'game.systems.render_system'

---@class Game
---@field world Ecs
game = {
  world = Ecs:new(),
  paused = false,
  atlases = {
    retro_interior = Love.graphics.newImage("assets/retro_interior/TopDownHouse_FurnitureState1.png")
  }
}
game.__index = game;
function game:new()
  local self = setmetatable({}, game)

  --Set running and pause state
  self.world:set_state(GAME_STATE.Running, GAME_STATE.Paused)

  self.world:add_system(pms)
  self.world:add_system(pls)
  self.world:add_system(pcs)
  self.world:add_system(controller_system)
  self.world:add_system(camera_system)
  self.world:add_system(render_system)

  FUR1 = Love.graphics.newQuad(31, 63, 48, 47, self.atlases.retro_interior:getDimensions())


  self.world:add_entity({
    { type = CTS.EntityName, data = "Background" },
    {
      type = CTS.Renderable,
      data = {
        order = 0,
        sprite = Love.graphics.newImage('assets/back_teste.jpg'),
      }
    },
    {
      type = CTS.Transform,
      data = {
        scale = { x = 1, y = 1 },
        rotation = 0,
        origem = { x = 0, y = 0, },
        inclination = { x = 0, y = 0 }
      }
    },
    { type = CTS.Position,   data = { x = -200, y = -200, z = 0 } },
    { type = CTS.Speed,      data = 1 },
  })

  self.world:add_entity({
    {
      type = CTS.Renderable,
      data = {
        order = 1,
        quad = FUR1,
        atlas = self.atlases.retro_interior
      }
    },
    {
      type = CTS.Transform,
      data = {
        scale = { x = 2, y = 2 },
        rotation = 0,
        origem = { x = 0, y = 0, },
        inclination = { x = 0, y = 0 }
      }
    },
    { type = CTS.Position, data = { x = 10, y = 20, z = 0 } },
  })



  --Player
  self.world:add_entity({
    { type = CTS.Player,     data = true },
    { type = CTS.EntityName, data = "Player" },
    {
      type = CTS.Renderable,
      data = {
        order = 3,
        sprite = Love.graphics.newImage('assets/player.png')
      }
    },
    { type = CTS.Position,    data = { x = 0, y = 0, z = 0 } },
    {
      type = CTS.Transform,
      data = {
        scale = { x = 0.2, y = 0.2 },
        rotation = 0,
        origem = { x = 0, y = 0, },
        inclination = { x = 0, y = 0 }
      }
    },
    { type = CTS.Speed,       data = 25 },
    { type = CTS.Direction,   data = "Right" },
    { type = CTS.PlayerState, data = "Stay" },
  })

  -- -- Camera
  -- self.world:add_entity({
  --   { type = CTS.EntityName, data = "Camera" },
  --   { type = CTS.Camera,     data = Camera },
  --   { type = CTS.Position,   data = { x = 0, y = 0, z = 0 } },
  -- })

  return self
end

---@param key string
---@param code string
---@param pressed boolean
function game:process_key(key, code, pressed)
  if self.paused then return end

  -- if keys[key] ~= nil then
  --   keys[key](self.world)
  -- end

  ---@type NewEvent
  local new_event = {
    type = GAME_EVENT.Keyboard,
    state = GAME_STATE.Running,
    data = {
      key = key,
      code = code,
      pressed = pressed
    }
  }
  self.world:add_event(new_event)
end

function game:spawn(x, y)
  self.world:add_entity({
    {
      type = CTS.Renderable,
      data = {
        order = 1,
        quad = FUR1,
        atlas = self.atlases.retro_interior
      }
    },
    {
      type = CTS.Transform,
      data = {
        scale = { x = 2, y = 2 },
        rotation = 0,
        origem = { x = 0, y = 0, },
        inclination = { x = 0, y = 0 }
      }
    },
    { type = CTS.Position, data = { x = x, y = y, z = 0 } },
  })
end

---@param dt number
function game:update(dt)
  if self.paused then return end

  -- Para nao ter processamento desnecessario
  if self.world.actual_state == GAME_STATE.Paused then
    return
  end
  local new_event = {
    type = GAME_EVENT.Tick,
    state = GAME_STATE.Running,
    event = nil
  }
  self.world:add_event(new_event)

  dt = math.min(dt, 0.1)
  self.world:update(dt)
end

---@param alpha integer
function game:render(alpha)
  if self.paused then return end


  local render_event = {
    type = GAME_EVENT.Render,
    state = GAME_STATE.Running,
    event = { data = alpha }
  }
  self.world:add_event(render_event)
  self.world:update(self.world.delta_time)
end

function game:toggle_pause()
  if self.paused then
    self.paused = false
  else
    self.paused = true
  end
end

return game
