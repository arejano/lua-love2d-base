local utils = require 'core.utils'

---@class Array<T>: { [integer]: T }

local C_COUNTER = 0

---@class Ecs
---@field game_modes table
---@field game_events any[]
---@field counters table
---@field actual_state integer
---@field running_state integer
---@field paused_state integer
---@field resources table
local Ecs = {
  actual_state = 0,
  running_state = 0,
  paused_state = 0,
  game_modes = {},
  game_events = {},

  entities = {},
  entity_by_c_type = {},
  components = {},

  systems = {},
  systems_by_event = {},
  systems_by_state = {},

  pool_event = {},
  counters = { events = 0, ent = 0 },

  -- query
  query_data = nil,
  query_types = nil,
  delta_time = 0,
  resources = {}
}
Ecs.__index = Ecs

function Ecs:new()
  local _self = setmetatable({}, Ecs)
  return _self
end

function Ecs:add_resource(key, resource)
  self.resources[key] = resource
end

function Ecs:get_resource(key)
  if self.resources[key] ~= nil then
    return self.resources[key]
  end
end

---@param running integer
---@param paused integer
function Ecs:set_state(running, paused)
  self.running_state = running
  self.actual_state = running
  self.paused_state = paused
end

---@param ctypes Array<integer>
function Ecs:query(ctypes)
  self.query_types = ctypes
  ---@type Array<integer>
  local entities = {}

  for _, v in pairs(ctypes) do
    if self.entity_by_c_type[v] then
      for _, entity_id in ipairs(self.entity_by_c_type[v]) do
        if not entities[entity_id] then
          table.insert(entities, entity_id)
        end
      end
    end
  end
  self.query_data = entities
  return self.query_data
end

function Ecs:each(fn)
  if fn == nil then return end
  fn(self.query_data)
end

---@param components Array<any>
function Ecs:add_entity(components)
  local new_entity = #self.entities + 1

  self.counters["ent"] = self.counters["ent"] + 1

  for _, component in pairs(components) do
    self:register_component(new_entity, component)
  end
end

---@param entity integer
---@param component Component
function Ecs:register_component(entity, component)
  -- Escape
  local invalid_keys = utils.check_keys({ "type", "data" }, component)
  if #invalid_keys > 0 then return nil end

  -- local new_component_id = #self.components + 1

  -- Cria a tabela caso nao exista
  if self.entity_by_c_type[component.type] == nil then
    self.entity_by_c_type[component.type] = {}
  end
  table.insert(self.entity_by_c_type[component.type], entity)

  -- Update Componentes
  local key = entity .. component.type
  if self.components[key] == nil then
    self.components[key] = {}
  end
  -- table.insert(self.components[key], component.data)
  self.components[key] = component.data

  -- Update Entitites -> List<CType>
  if self.entities[entity] == nil then
    self.entities[entity] = {}
  end

  table.insert(self.entities[entity], component.type)
  C_COUNTER = C_COUNTER + 1
end

---@param event NewEvent
function Ecs:add_event(event)
  if self.actual_state == self.paused_state then
    return
  end
  self.counters.events = self.counters.events + 1
  table.insert(self.pool_event, event)
end

---@param entity integer
---@param c_type integer
---@return ComponentResult|nil
function Ecs:get_component(entity, c_type)
  if entity == nil then return nil end
  return {
    key = entity .. c_type,
    sucess = self.components[entity .. c_type] ~= nil,
    data = self.components[entity .. c_type]
  }
end

---@param entity integer
---@param c_type integer
---@param data table
function Ecs:set_component(entity, c_type, data)
  self.components[entity .. c_type] = data
end

---@param system System
function Ecs:add_system(system)
  print("Adicionando sistema: " .. system.name)
  local new_id = #self.systems + 1;
  self.systems[new_id] = system

  if system.start then
    system:start(self)
  end

  for _, state in pairs(system.states) do
    if self.systems_by_state[state] == nil then
      self.systems_by_state[state] = {}
    end

    for _, event in pairs(system.events) do
      if self.systems_by_state[state][event] == nil then
        self.systems_by_state[state][event] = {}
      end
      table.insert(self.systems_by_state[state][event], new_id)
    end
  end
end

---@param dt integer
function Ecs:update(dt)
  if self.actual_state == self.paused_state then
    return
  end

  self.delta_time = dt;
  while #self.pool_event > 0 do
    local event = table.remove(self.pool_event, 1)
    local to_run = self.systems_by_state[self.actual_state][event.type]
    if to_run ~= nil then
      for _, system_id in pairs(to_run) do
        self.systems[system_id]:process(self, self.delta_time, event)
      end
    end
  end
end

function Ecs:toogle_pause()
  if self.actual_state == self.paused_state then
    self.actual_state = self.running_state
  else
    self.actual_state = self.paused_state
  end
end

return Ecs
