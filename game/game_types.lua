---@alias ComponentResult { key:string,data:any}

---@alias Vec2 { x: integer, y:integer}
---@alias Vec3 { x: integer, y:integer, z:integer}


---@alias NewEvent { type: GameEvent,state: GameState , event: any}

---@alias ControllerEvent { type: GameEvent,state: GameState , data: KeyboardEvent}
---@alias KeyboardEvent { key: string,code: string, pressed: boolean}

---@alias PositionData { x : integer, y : integer }

---@alias RotationData integer

---@alias TransformData { scale : ScaleData, rotation : RotationData, origem : OrigemData, inclination : InclinationData }
---@alias ScaleData { x : integer, y : integer }
---@alias OrigemData { x : integer, y : integer }
---@alias InclinationData { x : integer, y : integer }
