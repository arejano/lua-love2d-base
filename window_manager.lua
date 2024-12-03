local wm = {
  icon = Love.image.newImageData(CONFIG.window.icon),
  title = CONFIG.window.title .. ' - ' .. CONFIG.window.version,
  fullscreen = false,
  resolution = {
    width = 630,
    height = 900,
  },
  position = {
    x = 0,
    y = 0,
  },
  resolutions = {
    SVGA = { width = 800, height = 600 },
    XGA = { width = 1024, height = 768 },
    HD = { width = 1280, height = 720 },
    WXGA = { width = 1280, height = 800 },
    HD_plus = { width = 1366, height = 768 },
    WXGA_plus = { width = 1440, height = 900 },
    WSXGA_plus = { width = 1680, height = 1050 },
    Full_HD = { width = 1920, height = 1080 },
    WUXGA = { width = 1920, height = 1200 },
    QHD_WQHD = { width = 2560, height = 1440 },
    WQXGA = { width = 2560, height = 1600 },
    UHD_4K = { width = 3840, height = 2160 },
    UHD_5K = { width = 5120, height = 2880 },
    UHD_8K = { width = 7680, height = 4320 },
  }
}


--- @param resolution Resolution
function wm:setResolution(resolution)
  self.resolution = resolution
  Love.window.setMode(self.resolution.width, self.resolution.height, self:flags())
end

function wm:flags()
  return {
    resizable = true,
    -- minwidth = self.resolution.width,
    -- minheight = self.resolution.height
  }
end

function wm:setDefault()
  self:setResolution(self.resolutions.SVGA)

  Love.window.setIcon(self.icon)
  Love.window.setTitle(self.title)

  -- Love.window.setPosition(self.position.x, self.position.y)
end

function wm:toggleFullScreen()
  if self.fullscreen then
    self.fullscreen = false
  else
    self.fullscreen = true
  end

  Love.window.setFullscreen(self.fullscreen)
end

return wm
