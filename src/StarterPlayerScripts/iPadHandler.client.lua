--[[ iPadCore by Nefarioum
	
	To be showcased at the EDI Showcase
	
--]]


--// Variables
local UIPageLayout = script.Parent.iPadFrame.iPadPages.UIPageLayout
local LockScreen = script.Parent.iPadFrame.iPadPages.LockScreen
local PinScreen = script.Parent.iPadFrame.iPadPages.PinScreen

local NotificationArea = LockScreen.NotificationArea
local NotificationSound = LockScreen.NotificationArea.Notification
local Notificaiton1 = LockScreen.NotificationArea.Notification1

local HiddenPin = PinScreen.Keys
local PinCancel = PinScreen.Cancel
local PinBack = PinScreen.Back

local CurrentAttempts = 1
local CurrentEnteredPin;

game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 100
game:GetService("Players").LocalPlayer.CameraMinZoomDistance = 100

local Player = game.Players.LocalPlayer.Character
local BackgroundBlur = Instance.new("BlurEffect", game:GetService("Lighting"))

--// AVariables
local CurrentUserPin = 1234




--// Core

BackgroundBlur.Size = 20

	Player:WaitForChild("Humanoid").WalkSpeed = 0
	Player:WaitForChild("Humanoid").JumpPower = 0


LockScreen.MouseButton1Click:Connect(function ()
	if LockScreen.ImageColor3 == Color3.fromRGB(35, 35, 35) then
		for Activation = 35, 180, 5 do
			LockScreen.ImageColor3 = Color3.fromRGB(Activation, Activation, Activation)
			wait()
		end
		wait(1)		
		Notificaiton1.Visible = true
		NotificationSound:Play()
		Notificaiton1:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 1)
	
	else 
		UIPageLayout:JumpTo(PinScreen)	
		
		wait(0.5)
				
		for i = 1, 0, -0.1 do
			PinScreen.TimeText2.TextTransparency = i
			wait()
		end
	end
end)

Notificaiton1.MouseButton1Click:Connect(function ()
	Notificaiton1:TweenPosition(UDim2.new(-4, 0, 0, 0), "In", "Quad", 0.8)
end)

for i, v in pairs(PinScreen.PinArea:GetChildren()) do
	if v.Name ~= "UIGridLayout" then
		v.MouseButton1Click:Connect(function ()
			if CurrentAttempts == 1 and v.Name ~= "10" then 
				CurrentEnteredPin = tonumber(v.Name)
				HiddenPin.Text = "*"
				CurrentAttempts = CurrentAttempts + 1
			elseif CurrentAttempts == 4 and v.Name ~= "10" then 
				CurrentEnteredPin = CurrentEnteredPin .. tonumber(v.Name)
				if tonumber(CurrentEnteredPin) == CurrentUserPin then 
					HiddenPin.Text  = "Correct pin entered!"
					wait(2)
					CurrentEnteredPin = 0 
					CurrentAttempts = 0
					UIPageLayout:JumpTo(LockScreen)
					HiddenPin.Text = ""
				else
					CurrentAttempts = 1
					HiddenPin.Text = "Invalid pin entered!"
					CurrentEnteredPin = nil
				end
			elseif v.Name ~= "10" then
				CurrentEnteredPin = CurrentEnteredPin .. tonumber(v.Name)
				HiddenPin.Text  = HiddenPin.Text .."*"
				CurrentAttempts = CurrentAttempts + 1
			end
		end)
	end
end

PinBack.MouseButton1Click:Connect(function ()
	if CurrentAttempts >= 2 then 
		CurrentAttempts = CurrentAttempts - 1
		CurrentEnteredPin = ((CurrentEnteredPin - math.floor(CurrentEnteredPin % 10))/ 10)
		HiddenPin.Text = string.sub(HiddenPin.Text, 0, string.len(HiddenPin.Text) - 1)
	end
end)

PinCancel.MouseButton1Click:Connect(function ()
	UIPageLayout:JumpTo(LockScreen)
					
	for i = 0, 1, 0.1 do
		PinScreen.TimeText2.TextTransparency = i
		wait()
	end
end)