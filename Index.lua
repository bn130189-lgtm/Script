-- ATRAS GIABÌNH - Phần 1: Khởi tạo và Dọn dẹp hệ thống
local fn = function(arg)
    local genv = typeof(getgenv) == "function" and getgenv() or _G
    if type(genv.ChilliDebugPrint) == "function" then
        pcall(genv.ChilliDebugPrint, arg)
    end
end

local v

local function fn2()
    local response = nil

    local function fn2()
        if type(response) == "string" and #response > 0 then
            return response
        end
        response = game:HttpGet("https://pastefy.app/dVXJ7rW2/raw")
        return response
    end

    local function fn3()
        local chilliHubSaeCleanup = (typeof(getgenv) == "function" and getgenv() or _G).ChilliHubSaeCleanup

        if type(chilliHubSaeCleanup) == "function" then
            pcall(chilliHubSaeCleanup)
        end

        local tbl = { game:GetService("CoreGui") }

        if typeof(gethui) == "function" then
            local ok, result = pcall(gethui)
            ok = ok and typeof(result) == "Instance"

            if ok then
                table.insert(tbl, result)
            end
        end

        local tbl2 = {
            Settings = true,
            ChilliLeftCenter = true,
            ChilliLibrarySettings = true,
            ChilliLibraryLauncher = true,
        }
        local n = 0

        for _, v2 in ipairs(tbl) do
            for _, child in ipairs(v2:GetChildren()) do
                if
                    child:IsA("ScreenGui")
                    and (child:GetAttribute("ChilliLibraryOwned") == true or tbl2[child.Name])
                then
                    pcall(function()
                        child:Destroy()
                    end)

                    n = n + 1
                end
            end
        end

        if n > 0 then
            fn("cleared " .. n .. " leftover ATRAS GIABÌNH UI screens")
        end
    end

    local function fn4()
        local chunk, v2 = loadstring((fn2()))
        assert(chunk, v2)
        local v3 = chunk()
        assert(type(v3) == "function", "ATRAS GIABÌNH Library bootstrap is invalid.")
        local v4 = table.create(45)
        local n = 1

        for i = 1, 90, 2 do
            v4[n] = string.char(
                bit32.bxor(
                    tonumber(
                        string.sub(
                            "306908100841206d474f00185f26635b2101387507010810127d7d477a473b6f435a0916573165562900226c00",
                            i,
                            i + 1
                        ),
                        16
                    ),
                    string.byte("s9K!2vQ#", (n - 1) % 8 + 1)
                )
            )
            n = n + 1
        end

        return v3(table.concat(v4))
    end

    local str = "unknown"

    for i = 1, 6 do
        task.wait()
        pcall(fn3)
        local ok, result = pcall(fn4)
        ok = ok and type(result) == "table"
        if ok then
            return result
        end
        str = tostring(result)

        if type(str) == "string" and string.find(str, "HttpGet", 1, true) then
            response = nil
        end

        fn("library load attempt " .. i .. " failed: " .. str)
        task.wait(1 + i * 0.5)
    end

    error("ATRAS GIABÌNH Library failed to load: " .. str, 0)
end
-- ATRAS GIABÌNH - Phần 2: Giao diện Menu chính và Quản lý Tính năng
v = fn2()
assert(
    type(v) == "table" and type(v.CreateWindow) == "function" and type(v.Finalize) == "function",
    "ATRAS GIABÌNH Library returned an invalid API."
)

v.ManualQuickDefaults = {
    PinnedFeatures = { "Player > Movement > Speed Boost", "Player > Movement > Boost Speed" },
    Keybinds = { ["Player > Movement > Speed Boost"] = "Q" },
    PinGroups = {},
    LeftCenterHidden = true,
}

local genv2 = typeof(getgenv) == "function" and getgenv() or _G
genv2.ChilliLib = v

-- Đổi tiêu đề giao diện thành ATRAS GIABÌNH
local v2 = v:CreateWindow({ Name = "ATRAS GIABÌNH - Steal An Egg", DefaultTab = "Farm" })
local defaultTab = v2:GetDefaultTab()
genv2.ChilliHub_Window = v2
genv2.ChilliHub_DefaultTab = defaultTab

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local localPlayer = Players.LocalPlayer
local networking = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Networking")

local fn3 = function(arg)
    local ok, result = pcall(function()
        return require(arg())
    end)
    if not ok then
        result = ok
    end
    return result or nil
end

local tbl = {
    EggState = fn3(function() return ReplicatedStorage.Client.EggState end),
    AreaEggs = fn3(function() return ReplicatedStorage.Shared.Types.AreaEggs end),
    ToolGameplayGuard = fn3(function() return ReplicatedStorage.Client.ToolGameplayGuard end),
    Assets = fn3(function() return ReplicatedStorage.Data.Assets end),
    Guards = fn3(function() return ReplicatedStorage.Data.Guards end),
    EggRecords = fn3(function() return ReplicatedStorage.Shared.Util.EggRecords end),
    Mutations = fn3(function() return ReplicatedStorage.Shared.Modules.Mutations end),
    Save = fn3(function() return ReplicatedStorage.Shared.Save end),
    FuseKernel = fn3(function() return ReplicatedStorage.Shared.Util.FuseKernel end),
    AreaEggCycle = fn3(function() return ReplicatedStorage.Shared.Util.AreaEggCycle end),
    AreaEggResetWall = fn3(function() return ReplicatedStorage.Client.AreaEggResetWall end),
    AreaEggResetCycle = fn3(function() return ReplicatedStorage.Data.AreaEggResetCycle end),
    Gears = fn3(function() return ReplicatedStorage.Data.Gears end),
    Areas = fn3(function() return ReplicatedStorage.Data.Areas end),
    LimitedEgg = fn3(function() return ReplicatedStorage.Data.LimitedEgg end),
    BrainrotEgg = fn3(function() return ReplicatedStorage.Data.BrainrotEgg end),
    MonsterEgg = fn3(function() return ReplicatedStorage.Data.MonsterEgg end),
}

-- Khởi tạo các Section tính năng của giao diện ATRAS GIABÌNH
local v4 = defaultTab:CreateSection({ Name = "Dr Scramble Event", Expanded = false })
local v5 = defaultTab:CreateSection({ Name = "Auto Steal", Expanded = true })
local v6 = defaultTab:CreateSection({ Name = "Auto Place Egg", Expanded = false })
local v7 = defaultTab:CreateSection({ Name = "Auto Treadmill", Expanded = false })
local v8 = defaultTab:CreateSection({ Name = "Auto Hatch & Equip", Expanded = false })
local v9 = defaultTab:CreateSection({ Name = "Auto Sell", Expanded = false })
local v10 = defaultTab:CreateSection({ Name = "Auto Fuse Machine", Expanded = false })
local v11 = defaultTab:CreateSection({ Name = "Auto Favorite", Expanded = false })
local v12 = defaultTab:CreateSection({ Name = "Auto Rift & Boss", Expanded = false })

print("ATRAS GIABÌNH Loaded Successfully!")
