GAME_STATE= require 'game.game_states'
GAME_EVENT = require 'game.game_events'
CTS = require 'game.game_components'



CONTROL_EVENT= MakeEnum({
  "TurnUp",
  "TurnDown",
  "TurnLeft",
  "TurnRight",
  "Jump",
  "Interact",
  "Talk"
})

