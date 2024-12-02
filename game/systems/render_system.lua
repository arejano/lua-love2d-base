---@type System
local RenderSystem = {
  name = 'RenderSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Render, }
}


---@param w Ecs
function RenderSystem:start(w)
  w.counters[self.name] = 0
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

      -- Renderize a entidade com posição interpolada, rotação e escala
      if render_data and position and transform then
        if render_data.sprite ~= nil then
          Love.graphics.draw(
            render_data.sprite,
            position.x,
            position.y,
            transform.rotation,
            transform.scale.x,
            transform.scale.y,
            transform.origem.x,
            transform.origem.y,
            transform.inclination.x,
            transform.inclination.x
          )
        end

        if render_data.quad ~= nil and render_data.atlas ~= nil then
          Love.graphics.draw(
            render_data.atlas,
            render_data.quad,
            position.x,
            position.y,
            transform.rotation,
            transform.scale.x,
            transform.scale.y,
            transform.origem.x,
            transform.origem.y,
            transform.inclination.x,
            transform.inclination.x
          )
        end
      end

      -- Love.graphics.rectangle("fill", position.x, position.y, 100, 100)
      --   end
    end
  else
    return
  end
end

function RenderSystem:destroy()
end

return RenderSystem