local command_mt = {}
command_mt.__command_cache = {}
command_mt.__index = function(self, key)
  if command_mt.__command_cache[key] == nil then
    local req_loc = string.format("RvcRunMode.client.commands.%s", key)
    local raw_def = require(req_loc)
    local cluster = rawget(self, "_cluster")
    command_mt.__command_cache[key] = raw_def:set_parent_cluster(cluster)
  end
  return command_mt.__command_cache[key]
end

local RvcRunModeClientCommands = {}

function RvcRunModeClientCommands:set_parent_cluster(cluster)
  self._cluster = cluster
  return self
end

setmetatable(RvcRunModeClientCommands, command_mt)

return RvcRunModeClientCommands
