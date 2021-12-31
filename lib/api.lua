local _M = {}
local config = require "config.config"
function _M.get_proxy()
    local server = _M.get_rand_server()
    local url = server.host
    return url
end

function _M.get_rand_server()
    local server_list = config.servers
    local sum_weight = 0
    for id, val in pairs(server_list) do sum_weight = sum_weight + val.weight end

    local ran = math.random(1, sum_weight)
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

function _M.push()
    local main_host = config.main_servers.host
    local res = _M.push_content(main_host)
    ngx.say(res)
end

function _M.push_content(host)
    local rout = ngx.var.request_uri
    local url = host .. rout
    local content_type = ngx.var.content_type
    local request_method = ngx.var.request_method
    local arg = nil
    if request_method == "GET" then
        arg = ngx.req.get_uri_args()['params']
    elseif request_method == "POST" then
        ngx.req.read_body()
        arg = ngx.req.get_post_args()['params']
    end
    local headers = {["Content-Type"] = content_type}
    local res, err = _M.request(url, request_method, arg, headers)

    if res then ngx.status = res.status end
    if not res or ngx.status ~= 200 then
        local server = _M.get_rand_server()
        local host_new = server.host .. rout
        res, err = _M.request(host_new, request_method, arg, headers)
    end

    return res.body
end

function _M.request(url, method, body, headers)
    ngx.log(ngx.INFO, "url", url)
    local http = require "resty.http"
    local httpc = http.new()
    local res, err = httpc:request_uri(url, {
        method = method,
        body = body,
        headers = headers
    })
    return res, err
end

return _M
