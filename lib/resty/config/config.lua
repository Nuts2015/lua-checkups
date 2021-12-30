_M = {}

_M.global = {
    checkup_timer_interval = 15,
    checkup_shd_sync_enable = true,
    shd_config_timer_interval = 1,
}

_M.servers = {
    { host = "api.eosargentina.io", port = 80, weight=10, max_fails=3, fail_timeout=10 },
    { host = "api.eossweden.org", port = 80, weight=10, max_fails=3, fail_timeout=10 },
    { host = "api.main.alohaeos.com", port = 80, weight=10, max_fails=3, fail_timeout=10 },
    { host = "seed02.eosusa.news", port = 80, weight=10, max_fails=3, fail_timeout=10 },
    { host = "seed01.eosusa.news", port = 80, weight=10, max_fails=3, fail_timeout=10 },
}

return _M