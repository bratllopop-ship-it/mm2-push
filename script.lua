local SG = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")
SG.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
SG.ResetOnSpawn = false
Btn.Parent = SG
Btn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
Btn.Position = UDim2.new(0.4, 0, 0.8, 0)
Btn.Size = UDim2.new(0, 220, 0, 50)
Btn.Text = "Оттолкнуть в MM2"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.TextSize = 16

local function getClosest()
    local lp = game.Players.LocalPlayer
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local closest, shortDist = nil, math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local dist = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < shortDist then shortDist = dist; closest = p end
            end
        end
    end
    return closest
end

Btn.MouseButton1Click:Connect(function()
    local lp = game.Players.LocalPlayer
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local target = getClosest()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myHRP = lp.Character.HumanoidRootPart
        local tHRP = target.Character.HumanoidRootPart
        local oldPos = myHRP.CFrame
        myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 2)
        task.wait(0.05)
        local att = Instance.new("Attachment", tHRP)
        local vf = Instance.new("VectorForce")
        vf.Attachment0 = att
        vf.Force = (tHRP.Position - myHRP.Position).Unit * 40000 + Vector3.new(0, 50000, 0)
        vf.RelativeTo = Enum.ActuatorRelativeTo.World
        vf.Parent = tHRP
        task.wait(0.05)
        myHRP.CFrame = oldPos
        task.wait(0.2)
        vf:Destroy()
        att:Destroy()
    end
end)
