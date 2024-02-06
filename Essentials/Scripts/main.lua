-- author: @aytimothy on discord (you can message me from the pocketpair discord server)

local traces = require("./traces")
local essentials = require("./essentials")

local main = function()
    print("Hello World!")
    traces.RegisterDebugHooks()
    essentials.Main()
end

main()