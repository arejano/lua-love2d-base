local MakeEnum = require 'utils'.make_enum
local Inspect = require 'libs.inspect.inspect'

local PS = require 'game.enums.player_states'

local Anim = require 'core.AniM'

-- local to_animate = {
--   { path = "bla", width = 100, height = 100 },
--   { path = "bla", width = 100, height = 100 },
--   { path = "bla", width = 100, height = 100 },
--   { path = "bla", width = 100, height = 100 },
--   { path = "bla", width = 100, height = 100 },
-- }

-- for i, k in ipairs(to_animate) do
--   print(i, k)
-- end

-- local player_states = MakeEnum({
--   "Walk",
--   "Stay",
--   "Jump"
-- })

local p = Anim:new({
  { path = "bla", width = 100, height = 100, state = PS.Walk },
  { path = "bla", width = 100, height = 100, state = PS.Death },
  { path = "bla", width = 100, height = 100, state = PS.Run },
  { path = "bla", width = 100, height = 100, state = PS.Stay },
  { path = "bla", width = 100, height = 100, state = PS.Jump },
})


print(Inspect(p))
