sqlite3 = require "sqlite3"
cjson = require "cjson"


local db_name, z, x, y =
  ngx.var.db_name, ngx.var.z, ngx.var.x, ngx.var.y


if (not db_name) then -- DROP if no db_name
    ngx.header['Content-Type'] = 'application/json'
    ngx.status = 400
    ngx.say("No DB selected")
    return ngx.exit(ngx.OK)
end

local db = sqlite3.open(string.format("/usr/local/openresty/nginx/conf/dbs/%s", db_name))

local get_tile_blob = db:prepare([[SELECT image AS tile
                             FROM tiles WHERE
                             z = :z AND
                             x = :x AND
                             y = :y
                             LIMIT 1;]]):bind(17-z, x, y)
ngx.log(ngx.STDERR, '\n==========\n' .. 17-z .. ' ' .. x .. ' '.. y .. '\n==========\n')
ngx.status  = ngx.HTTP_OK
-- ngx.log(ngx.STDERR, '\n====================\n')
-- ngx.log(ngx.STDERR, get_tile_blob:columns())
-- ngx.log(ngx.STDERR, '\n====================\n')

for row in get_tile_blob:rows() do
   ngx.say(row.tile)
end
return ngx.exit(ngx.HTTP_OK)
