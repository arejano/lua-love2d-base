-- Basicamente uma entidade dentro do ECS

game_object = {
  static = true,
  enabled = true,
  tags = {},
  components = {}
}



function game_object:new()
end

function game_object:find()
end

function game_object:connect()
end

function game_object:send_event()
end

function game_object:remove()
end
