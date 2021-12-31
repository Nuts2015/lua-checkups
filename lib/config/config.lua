_M = {}

_M.main_servers = {host = "http://api.eosargentina.io"}

_M.servers = {
    {
        host = "http://api.eossweden.org",
        weight = 20,
        max_fails = 3,
        fail_timeout = 10
    }, {
        host = "http://api.main.alohaeos.com",
        weight = 20,
        max_fails = 3,
        fail_timeout = 10
    }, {
        host = "http://seed02.eosusa.news",
        weight = 20,
        max_fails = 3,
        fail_timeout = 10
    }, {
        host = "http://seed01.eosusa.news",
        weight = 20,
        max_fails = 3,
        fail_timeout = 10
    }
}

return _M
