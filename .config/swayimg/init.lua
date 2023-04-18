-- Text overlay configuration
swayimg.text.set_size(16) -- font size in pixels

-- Image viewer mode
swayimg.text.hide() -- start without infos

-- Common functions
local next = function()
  swayimg.viewer.switch_image("next")
end

local setAsWallpaper = function(mode)
  local image = swayimg[mode].get_image()
  os.execute(string.format("setbg %s", image.path))
  swayimg.text.set_status("File "..image.path.." set as wallpaper")
end

local delete = function(mode)
  local image = swayimg[mode].get_image()
  os.remove(image.path)
  swayimg.text.set_status("File "..image.path.." removed")
end

-- Key and mouse bindings in viewer mode (example only, not all):

swayimg.viewer.on_key("i", function()
  local visible = swayimg.text.visible()
  if visible then
    swayimg.text.hide()
  else
    swayimg.text.show()
  end
end)

swayimg.viewer.on_key("n", next)
swayimg.viewer.on_key("space", next)
swayimg.viewer.on_key("p", function()
  swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)

swayimg.viewer.on_key("w", function()
  setAsWallpaper("viewer")
end)

-- zoom on +
swayimg.viewer.on_key("plus", function()
  local pos = swayimg.viewer.get_position()
  local scale = swayimg.viewer.get_scale()
  scale = scale + scale / 10
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)

swayimg.viewer.on_key("Delete", function()
  delete("viewer")
end)

-- Slide show mode, same config as for viewer mode with the following defaults:

-- Gallery mode

-- Key and mouse bindings in gallery mode (example only, not all):
swayimg.gallery.on_key("q", function()
  swayimg.exit()
end)

swayimg.gallery.on_key("h", function()
  swayimg.gallery.switch_image("left")
end)

swayimg.gallery.on_key("l", function()
  swayimg.gallery.switch_image("right")
end)

swayimg.gallery.on_key("j", function()
  swayimg.gallery.switch_image("down")
end)

swayimg.gallery.on_key("k", function()
  swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("Delete", function()
  delete("gallery")
end)

--
-- Other configuration examples
--

-- force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
  swayimg.viewer.set_fix_scale("optimal")
end)


-- print paths to all marked files by pressing Ctrl-p in gallery mode
swayimg.gallery.on_key("Ctrl-p", function()
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then
        print(entry.path)
    end
  end
end)
