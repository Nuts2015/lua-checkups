local config = require "config.config"

local _M = {}
function _M.get_proxy()
    local server = _M.get_rand_server()
    local url = server["host"]

    return "http://api.eosargentina.io"
end

function _M.get_rand_server()
    local count = 0
    local server_list = config.servers
    for k, v in pairs(server_list) do count = count + 1 end
    local num = math.random(0, (count - 1))
    return server_list[num]
end

return _M

