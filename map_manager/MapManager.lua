local Layer = require 'map_manager.Layer'
local Tileset = require 'map_manager.Tilesets'

---@class MapManager
---@field layers Layer[]
---@field version string
---@field luaversion string
---@field tiledversion string
---@field orientation string "orthogonal"
---@field renderoreder string "right-down"
---@field width number
---@field height number
---@field tilewidth number
---@field tileheight number
---@field nextlayerid number
---@field nextobjectid number
---@field properties table
---@field tileset Tileset[]
local MapManager = {
  layers = {},
}

function MapManager:loadLayers()
  for _, layer in ipairs(self.layers) do
    local new_layer = Layer:new(layer)
    table.insert(self.layers, new_layer)
  end
end

function MapManager:loadTileset()
  self.tilesets = Tileset:new()
end

return MapManager
