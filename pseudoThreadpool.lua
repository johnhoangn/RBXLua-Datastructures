-- not actually threadpool but it works roughly the same
function threadPool(numThreads, workPool, callback)
    local numWork = #workPool
    local batchSize = math.floor(#workPool/numThreads)
    local remainder = numWork % batchSize

    -- spawned threads
    for i = 0, numThreads - 1 do
        coroutine.resume(coroutine.create(function()
            for j = 1, batchSize do
                callback(workPool[i * batchSize + j])
            end
        end))
    end

    -- main thread's share of the work, if any exists
    if remainder ~= 0 then
        for i = 0, remainder + 1 do
            callback(workPool[numWork - i])
        end
    end
end

--[[
local nums = {}
local processed = {}

for i = 1, 100 do
    table.insert(nums, i)
end

threadPool(6, nums, function(n)
    processed[tostring(n)] = true
    print('processed', n)
end)

for i = 1, #nums do
    if not processed[tostring(i)] then
        warn('missed', i)
    end
end
]]
