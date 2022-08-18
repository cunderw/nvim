local status_ok, colorizer = pcall(require, "colorizer")

if not status_ok then
  return
end

colorizer.setup({ "*" }, {
  names    = true, -- "Name" codes, see https://www.w3schools.com/colors/colors_hex.asp   Blue, HotPink, OldLace, Plum, LightGreen, Coral
  RGB      = true, -- #RGB hex codes                                                      #f0f #FAB
  RRGGBB   = true, -- #RRGGBB hex codes                                                   #ffff00 #FF00FF
  RRGGBBAA = true, -- #RRGGBBAA hex codes                                                 #ffff00ff #AbCdEf
  rgb_fn   = true, -- CSS rgb() and rgba() functions                                      rgb(100,200,50) rgba(255,255,255,1.0) rgb(100%, 0%, 0%)
  hsl_fn   = true, -- CSS hsl() and hsla() functions                                      hsl(120,100%,50%) hsla(20,100%,40%,0.7)
  css      = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn   = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  mode     = 'background'; -- Set the display mode.
})
