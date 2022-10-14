local z, x, y =
  ngx.var.z, ngx.var.x, ngx.var.y

local hostname = "i" .. (x % 4) + (y % 4) * 4
local url = "http://" .. hostname .. ".wikimapia.org/?x=" .. x .. "&y=" .. y .. "&zoom=" .. z

return ngx.redirect(url, 303)
