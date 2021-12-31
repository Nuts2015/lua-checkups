-- local config = require "config.config"

local _M = {}
function _M.get_proxy()
    local server = _M.get_rand_server()
    local url = server.host
    return url
end

function _M.get_rand_server()
    local server_list = config.servers
    local ran = math.random(1, 100)
    local rate = 0
    local index = 1
    for i, value in pairs(server_list) do
        rate = rate + value.weight
        if ran < rate then
            index = i
            break
        end
    end
    return server_list[index]
end

function _M.push_content(host)
    local http = require "resty.http"
    local httpc = http.new()
    local rout = ngx.var.request_uri
    local url = host .. rout
    ngx.log(ngx.INFO, "url:::::::", url)

    local request_method = ngx.var.request_method
    local arg = nil
    if request_method == "GET" then
        arg = ngx.req.get_uri_args()['params']
    elseif request_method == "POST" then
        ngx.req.read_body()
        arg = ngx.req.get_post_args()['params']
    end

    local resStr -- 响应结果
    local res, err = httpc:request_uri(url, {
        method = request_method,
        body = arg,
        headers = {["Content-Type"] = "application/json"}
    })

    if not res then
        ngx.log(ngx.WARN, "failed to request: ", err)
        -- ngx.say(err)
    end
    -- 请求之后，状态码
    ngx.status = res.status
    if ngx.status ~= 200 then
        ngx.log(ngx.WARN, "非200状态，ngx.status:" .. ngx.status)
        -- ngx.say(err)
    end
    -- 响应的内容
    resStr = res.body
    ngx.say(resStr)
end

return _M
