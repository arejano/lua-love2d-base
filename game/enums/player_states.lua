local player_states = require 'core.utils'.make_enum({
  "Stay",
  "Jump",
  "Run",
  "Death",
  "Walk",
})

return player_states
