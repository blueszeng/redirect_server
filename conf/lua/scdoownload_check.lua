local path = '127.0.0.1:8085'

local args = ngx.req.get_uri_args()

local target_uri  = ngx.var.uri
local target_args = ngx.var.args
ngx.var.backend_host = path
ngx.req.set_uri(target_uri)
if target_args ~= nil then
    ngx.req.set_uri_args(target_args)
end