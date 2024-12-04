local RaiderCharacter = {
  assets = {
    { file = "assets/Raider/Attack_1.png", w = 768,  h = 128, parts = 0 },
    { file = "assets/Raider/Attack_2.png", w = 384,  h = 128, parts = 0 },
    { file = "assets/Raider/Dead.png",     w = 512,  h = 128, parts = 0 },
    { file = "assets/Raider/Hurt.png",     w = 256,  h = 128, parts = 0 },
    { file = "assets/Raider/Idle.png",     w = 768,  h = 128, parts = 0 },
    { file = "assets/Raider/Jump.png",     w = 1408, h = 128, parts = 0 },
    { file = "assets/Raider/Recharge.png", w = 1536, h = 128, parts = 0 },
    { file = "assets/Raider/Run.png",      w = 1024, h = 128, parts = 0 },
    { file = "assets/Raider/Shot.png",     w = 1536, h = 128, parts = 0 },
    { file = "assets/Raider/Walk.png",     w = 1024, h = 128, parts = 0 },
  }

}

function RaiderCharacter:newEntity()
end

function RaiderCharacter:updateParts()
  for i, key in ipairs(self.assets) do
    self.assets[i].parts = self.assets[i].w / self.assets[i].h;
  end
end

return RaiderCharacter:newEntity()
