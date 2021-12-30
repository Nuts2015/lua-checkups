local config = require "config.config"

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

    -- local length = #server_list
    -- local ri = math.random(1, length)
    -- return server_list[ri]
end

return _M

