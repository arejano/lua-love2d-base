RELEASE = false

DEBUG = not RELEASE

CONFIG = {
  window = {
    icon = 'assets/icon.png',
    title = 'Demo',
    version = '0.1'
  },
  debug = {
    key = '`',
    stats = {
      font         = nil, -- set after fonts are created
      fontSize     = 16,
      lineHeight   = 18,
      foreground   = { 1, 1, 1, 1 },
      shadow       = { 0, 0, 0, 1 },
      shadowOffset = { x = 1, y = 1 },
      position     = { x = 8, y = 6 },

      kilobytes    = false,
    },
  }
}

WINDOW_STATE = {
  fullscreen = false,
  minimized = false,
  width = 0,
  height = 0,
}

MOUSE_INFO = {
  x = 0,
  y = 0,
}


-- #region Lick
-- Lick = require 'libs.LICK.lick'
-- Lick.reset = true
-- #endregion
Love = love

WindowManager = require 'window_manager'

Lume = require 'libs.lume.lume'
Inspect = require 'libs.inspect.inspect'
-- DebugGraph = require("libs.Love-Debug-Graph.debugGraph")
Camera = require('libs.hump.camera')

MakeEnum = require 'utils'.make_enum

Ecs = require("core.ecs")
