require 'globals'
require 'components.debug'
require 'components.ortho_grid'
local Game = require 'game.game'

-- local pms = require 'systems.player_move'

--game loop
PREVIOUS = love.timer.getTime()
LAG = 0.0
MS_PER_SECOND = 16.67 / 1000

LOVE_LOOP = 0

function love.load()
  -- Separando o controle da janela do Jogo
  WindowManager:setDefault()
  GAME = Game:new()
end

function love.update(dt)
  require("libs.lovebird.lovebird").update()
  LOVE_LOOP = LOVE_LOOP + 1

  local current = love.timer.getTime()
  local elapsed = current - PREVIOUS
  LAG = LAG + elapsed

  -- while LAG >= MS_PER_SECOND do
  -- Game:update(LAG / MS_PER_SECOND)
  Game:update(dt)
  -- LAG = LAG - MS_PER_SECOND
  -- end
end

function love.conf(t)
  t.console = true
end

function love.draw()
  Debug:draw_debug(Game.world, LOVE_LOOP)
  OrthographicGrid:drawGrid()
end

---@param key string
---@param code string
function Love.keyreleased(key, code, _)
  game:process_key(key, code, false)
end

---@param key string
---@param code string
--@param isRepead boolean
function Love.keypressed(key, code, _)
  if not RELEASE and code == CONFIG.debug.key then
    DEBUG = not DEBUG
    print(DEBUG)
  end

  if key == 'escape' then
    Love.event.quit()
  end

  -- Separar as keys para controle de janela
  if key == "f1" then
    WindowManager:setResolution({ width = 800, height = 600 })
  elseif key == "f2" then
    WindowManager:setResolution({ width = 1280, height = 720 })
  end

  game:process_key(key, code, true)
end

function love.mousemoved(x, y, dx, dy)
  MOUSE_INFO.x = x
  MOUSE_INFO.y = y
end

-- function love.treaderror(thread, errorMessage)
-- end

-- #endregion
