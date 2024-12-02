require 'globals'
require 'components.debug'
require 'components.ortho_grid'


local game = require 'game.game'
GAME = game:new();

PREVIOUS = Love.timer.getTime()
LAG = 0.0
MS_PER_SECOND = 16.67 / 1000
MAX_ITERATIONS = 5
LOVE_LOOP = 0

function love.load()
  -- Separando o controle da janela do Jogo
  WindowManager:setDefault()
end

---@param dt number -- DeltaTime
function love.update(dt)
  require("libs.lovebird.lovebird").update()
  LOVE_LOOP = LOVE_LOOP + 1

  local current = Love.timer.getTime()
  local elapsed = current - PREVIOUS
  LAG = LAG + elapsed
  PREVIOUS = current

  local iterations = 0

  while LAG >= MS_PER_SECOND and iterations < MAX_ITERATIONS do
    -- Game:update(dt)
    GAME:update(LAG / MS_PER_SECOND)
    LAG = LAG - MS_PER_SECOND
    iterations = iterations + 1
  end
end

function love.conf(t)
  t.console = true
end

function love.draw()
  Debug:draw_debug(GAME.world, LOVE_LOOP)
  -- OrthographicGrid:drawGrid()
  local alpha = LAG / MS_PER_SECOND
  GAME:render(alpha)
end

---@param key string
---@param code string
function Love.keyreleased(key, code, _)
  GAME:process_key(key, code, false)
end

---@param key string
---@param code string
--@param isRepead boolean
function love.keypressed(key, code, _)
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
  elseif key == "p" then
    GAME:toggle_pause();
  end

  GAME:process_key(key, code, true)
end

function love.mousemoved(x, y, dx, dy)
  MOUSE_INFO.x = x
  MOUSE_INFO.y = y
end

function love.treaderror(thread, errorMessage)
  print("Erro capturado: " .. tostring(msg))
  love.event.quit()
end

-- #endregion
