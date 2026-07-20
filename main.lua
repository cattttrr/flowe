local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "flowe",
    Icon = "lucide:flower",
    Folder = "flowe",
    NewElements = true,
    SearchBar = true,
    Size = UDim2.fromOffset(550, 320),
    Transparent = true, 
    Theme = "Rose",
    User = {
        Enabled = true,
        Anonymous = false, 
    }, 
    
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})

-- Create a tab
local Tab = Window:Tab({
    Title = "Animal Hospital",
    Icon = "lucide:rabbit",
})

-- Third Person Button with full script
local ThirdPersonButton = Tab:Button({
    Title = "third person",
    Desc = "permanent!",
    Icon = "eye",
    Callback = function()
        -- Executor-Friendly Third Person Narrator
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local name = player.Name
        local pronoun = "he"  -- Change to "she" or "they" if needed

        local function toThirdPerson(text)
            text = text:gsub("I ", name .. " ")
            text = text:gsub(" me", " " .. name)
            text = text:gsub(" my ", " " .. name .. "'s ")
            text = text:gsub(" am ", " is ")
            text = text:gsub("I'm ", name .. " is ")
            text = text:gsub("I've ", name .. " has ")
            text = text:gsub("I'll ", name .. " will ")
            text = text:gsub("I'd ", name .. " would ")
            
            if pronoun:lower() == "she" then
                text = text:gsub(" he ", " she "):gsub(" He ", " She ")
            elseif pronoun:lower() == "they" then
                text = text:gsub(" he ", " they "):gsub(" He ", " They ")
            end
            return text:gsub("^%s*(.-)%s*$", "%1")
        end

        -- Force Third Person Camera
        player.CameraMode = Enum.CameraMode.Classic
        print("Third Person Camera Forced!")

        -- Chat Hook for Narrator (executor safe)
        local function onChatted(msg)
            local narrated = toThirdPerson(msg)
            print("[Third Person Narrator]: " .. narrated)
        end

        -- Hook player chat
        player.Chatted:Connect(onChatted)

    end
})

local EspButton = Tab:Button({
    Title = "esp",
    Desc = "see what patients or anomalies go in the hospital",
    Icon = "lucide:users",
    Callback = function()
 local sg=game:GetService("StarterGui")local function sn(t,x,d)sg:SetCore("SendNotification",{Title=t,Text=x,Duration=d})end;task.spawn(function()while true do for _,e in pairs(workspace.NPCs:GetChildren())do if e:FindFirstChildOfClass("Highlight")then continue end;local h=Instance.new("Highlight")h.FillTransparency=0.85;local isp=e:GetAttribute("IsPatient")local sk=e:GetAttribute("Skinwalker")if (isp==false or isp==nil) and sk then sn("AnimalHospital — Notification","A sknwalker entered the building, name:"..e.Name,10)h.OutlineColor=Color3.fromRGB(0,0,0)h.FillColor=Color3.fromRGB(0,0,0)elseif isp==true or isp==nil then sn("AnimalHospital — Notification","A patient entered the building, name:"..e.Name,10)h.OutlineColor=Color3.fromRGB(51,153,51)h.FillColor=Color3.fromRGB(0,255,0)else sn("AnimalHospital — Notification","A visitor entered the building, name:"..e.Name,10)h.OutlineColor=Color3.fromRGB(255,255,255)h.FillColor=Color3.fromRGB(255,255,255)end;h.Parent=e end;task.wait(0.1)end end)

    end
})

local SpeedSlider = Tab:Slider({
    Title = "movement speed",
    Desc = "max 1000",
    Step = 1,  -- Change to 0.1 for decimals if needed
    Value = {
        Min = 16,      -- Default Roblox walk speed
        Max = 1000,     -- Max speed you want
        Default = 50,
    },
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
        print("Speed set to:", value)  -- For debugging
    end
})

local BellButton = Tab:Button({
    Title = "remove bell sound",
    Desc = "sick and tired of that stupid sound? remove it simply from this button.",
    Icon = "lucide:bell-off",
    Callback = function()
local v = workspace.Misc.CheckIn.Bell["Primary Mesh"]:FindFirstChild("BellSound");
if v then 
v:Destroy() else return end

    end
})

local Tab = Window:Tab({
    Title = "Universal",
    Icon = "lucide:layers",
})

local InfJumpButton = Tab:Button({
    Title = "infinite jump",
    Desc = "permanent!",
    Icon = "lucide:circle-arrow-up",
    Callback = function()
-- Infinite Jump Script (LocalScript)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Optional: Adjust jump height/power here
humanoid.JumpPower = 50  -- Default is usually around 50

UserInputService.JumpRequest:Connect(function()
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- Handle character respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    humanoid.JumpPower = 50
end)
