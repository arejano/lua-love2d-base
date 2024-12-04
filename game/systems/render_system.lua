---@type System
local RenderSystem = {
  name = 'RenderSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Render, },
  data = {
    camera = nil
  },
  to_render = {}
}


---@param w Ecs
function RenderSystem:start(w)
  w.counters[self.name] = 0
  self.data.camera = w:get_resource("Camera")
end

---@param w Ecs
---@param dt number
---@param e NewEvent
function RenderSystem:process(w, dt, e)
  w.counters[self.name] = w.counters[self.name] + 1

  local alpha = e.event.data;

  local entities = w:query({ CTS.Renderable })
  if entities ~= nil then
    for _, entity in ipairs(entities) do
      local position = w:get_component(entity, CTS.Position).data
      ---@type TransformData
      local transform = w:get_component(entity, CTS.Transform).data
      local render_data = w:get_component(entity, CTS.Renderable).data

      -- if render_data.order ~= nil then
      table.insert(self.to_render, {
        position = position,
        transform = transform,
        render_data = render_data,
      })
      -- end
    end

    table.sort(self.to_render, function(a, b)
      return a.render_data.order < b.render_data.order
    end)

    self.data.camera:applyTransform()

    for _, entity in ipairs(self.to_render) do
      print(entity.render_data.order)
      --   if entity.position and entity.previousPosition then
      --     local x = entity.previousPosition.x + (entity.position.x - entity.previousPosition.x) * alpha
      --     local y = entity.previousPosition.y + (entity.position.y - entity.previousPosition.y) * alpha

      --     local rotation = 0
      --     if entity.previousRotation and entity.rotation then
      --       rotation = entity.previousRotation + (entity.rotation - entity.previousRotation) * alpha
      --     end

      --     local scaleX, scaleY = 1, 1
      --     if entity.previousScaleX and entity.previousScaleY and entity.scaleX and entity.scaleY then
      --       scaleX = entity.previousScaleX + (entity.scaleX - entity.previousScaleX) * alpha
      --       scaleY = entity.previousScaleY + (entity.scaleY - entity.previousScaleY) * alpha
      --     end

      -- Love.graphics.setCanvas(self.data.canva)

      -- self.data.camera:attach()

      -- Renderize a entidade com posição interpolada, rotação e escala
      if entity.render_data and entity.position and entity.transform then
        -- Sprite
        if entity.render_data.sprite ~= nil then
          Love.graphics.draw(
            entity.render_data.sprite,
            entity.position.x,
            entity.position.y,
            entity.transform.rotation,
            entity.transform.scale.x,
            entity.transform.scale.y,
            entity.transform.origem.x,
            entity.transform.origem.y,
            entity.transform.inclination.x,
            entity.transform.inclination.x
          )
        end

        -- Atlas+Quad
        if entity.render_data.quad ~= nil and entity.render_data.atlas ~= nil then
          Love.graphics.draw(
            entity.render_data.atlas,
            entity.render_data.quad,
            entity.position.x,
            entity.position.y,
            entity.transform.rotation,
            entity.transform.scale.x,
            entity.transform.scale.y,
            entity.transform.origem.x,
            entity.transform.origem.y,
            entity.transform.inclination.x,
            entity.transform.inclination.x
          )
        end
      end
    end

    for k, _ in pairs(self.to_render) do self.to_render[k] = nil end
    self.data.camera:resetTransform()
  else
    return
  end
end

function RenderSystem:destroy()
end

return RenderSystem
