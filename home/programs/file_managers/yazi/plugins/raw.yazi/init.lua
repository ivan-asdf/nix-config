return {
  -- NOT USED (only previwer of this plugin is used)
  peek = function(self)

    -- local cmd = string.format("convert %s bmp:- | kitty +kitten icat --stdin yes", file.url)
    -- local cmd = string.format("echo %s", file.url)


    p = ui.Paragraph.parse(self.area, "Loading raw image...")
    ya.preview_widgets(self, {p})

    url = ya.file_cache(self)
    -- local cmd = string.format("convert %s bmp:%s", file.url, url)
    -- local cmd = string.format("convert %s -resize 1920:1080 bmp:%s", file.url, url)
    -- os.execute(cmd)
    -- ya.preview_widgets(self, {})
    ya.image_show(url, self.area)
  end,

  seek = function(self)
    -- Empty
  end,

  preload = function(self)
    -- local cache = ya.file_cache(self)
    local url = ya.file_cache(self)
    if not url or fs.cha(url) then
      -- print("PRELOAD 1")
      return 1
    end

    local cmd = string.format("convert %s -resize 1920x1080 bmp:%s", self.file.url, url)
    os.execute(cmd)
    -- return ya.image_precache(self.file.url, cache) and 1 or 2
    -- print("PRELOAD 3")
    return 3
  end
}

