---@alias TiledObject {id:string,name:string,type:string,shape:string,x:number,y:number,width:number,height:number,rotation:number,visible:boolean,properties:table}

---@class Layer
---@field type string
---@field id number
---@field name string
---@field x number
---@field y number
---@field width string
---@field height string
---@field visible boolean
---@field opacity number
---@field offsetx number
---@field offsety number
---@field properties table
---@field objects TiledObject[]
---@field encode string
---@field compression string
---@field data string
local Layer = {

}

function Layer:new(layer)
  local _self = setmetatable({}, layer)
  return _self
end

return Layer;
