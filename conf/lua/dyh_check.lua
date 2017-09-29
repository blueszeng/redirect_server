local path = '192.168.0.107'
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

if args.v == 'ruijin' then
    target_uri = '/api/wechat' .. target_uri
end 
ngx.log(ngx.ERR, target_uri)
ngx.req.set_uri(target_uri)
