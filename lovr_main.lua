require 'globals'

local _game = require 'game'

GAME = nil

function lovr.load()
  GAME = _game:new()
end

function lovr.draw(pass)
  -- Renderiza o mundo 3D
  pass:box(0, 1, -3, 1, 1, 1) -- Caixa 3D

  m = lovr.math.newMat4()
  -- Configura o pass para desenhar em 2D
  pass:text('HUD fixo!', -0.9, 0.9, 0, 0.1) -- Ajuste de posição e escala para 2D
end

---@param dt number
function lovr.update(dt)
  -- GAME:tick(dt)
end
