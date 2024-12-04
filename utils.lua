---@class Utils
---@field check_key function
---@field make_enum function
---@field split_path function
return {
  check_keys = function(keys, t)
    local invalids = {}
    for k, i in pairs(keys) do
      if t[i] == nil then
        table.insert(invalids, i)
      end
    end
    return invalids
  end,

  make_enum = function(t)
    local enum = {}
    for i, v in ipairs(t) do
      enum[v] = i
    end
    return setmetatable(enum, {
      __index = function(_, key)
        error("Chave" .. tostring(key) .. " nao existe no enum")
      end,
      __newindex = function(_, key, value)
        error("Nao eh possivel modificar o enum")
      end
    })
  end,

  split_path = function(path)
    return string.match(path, '(.-)([^\\/]-%.?([^%.\\/]*))$')
  end
}
