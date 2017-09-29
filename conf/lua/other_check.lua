local path = '127.0.0.1'
-- '192.168.0.107'
local configPort = {
    ['shaoguan'] = 8085,
    ['ruijin'] = 8086
}

local args = ngx.req.get_uri_args()

if args == nil or args.v == nil then
    args.v = 'shaoguan'
end 

if not (args.v == 'shaoguan' or args.v == 'ruijin') then 
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end 

ngx.var.backend_host = path .. ':' .. configPort[args.v]
local target_uri  = ngx.var.uri
local target_args = ngx.var.args

ngx.req.set_uri(target_uri)
if target_args ~= nil then
    ngx.req.set_uri_args(target_args)
end