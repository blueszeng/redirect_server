local checkHtml = {  --允许放行的页面
-- 支付页面
 'dyh.html', 
 'order.html',
 'sell.html',
 'sellhis.html',
 'weichat.html',
 'buyhis.html',
-- 下载页面
 'ruijin.html',
 'shaoguan.html',
 }

local path = '127.0.0.1'
-- '192.168.0.107' --外网地址

local configPort = {
    ['shaoguan'] = 8085,
    ['ruijin'] = 8086
} --对应不同支付服的端口 

--获取文件名
function strippath(filename)  
    return string.match(filename, ".+/([^/]*%.%w+)$")
end  
local filename = strippath(ngx.var[1])

local matchStatus = false
for i, v in ipairs(checkHtml) do
     if filename == v then 
        matchStatus = true
        break
     end 
end  

ngx.log(ngx.ERR, matchStatus, filename)

if matchStatus == false then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end 

local args = ngx.req.get_uri_args()

ngx.log(ngx.ERR, string.format("resolved args: %s", args.v))

if args == nil or args.v == nil then
    args.v = 'shaoguan'
end 

if not args.v then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end

if not (args.v == 'shaoguan' or args.v == 'ruijin') then 
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end 

ngx.log(ngx.ERR, string.format("resolved target_uri: %s", args.v))

ngx.var.backend_host = path .. ':' .. configPort[args.v]
local target_uri  = ngx.var.uri
local target_args = ngx.var.args
ngx.log(ngx.ERR, string.format("resolved target_uri: %s, %s", target_uri, target_args))

ngx.req.set_uri(target_uri)

if target_args ~= nil then
    ngx.req.set_uri_args(target_args)
end
