--[[ Bar Control by Nefarioum
	
	Simple script to stop bar when screen is tapped/button is pressed.
	
	Supports both PC/Mobile (didn't bother with console support as the game probably isn't scripted to support console)
	
--]]

--// Services
local UserInputService = game:GetService("UserInputService")

--// FrameVariables
local ReachFrame = script.Parent.ReachFrame
local BarFrame1 = ReachFrame.Bar1
local BarFrame2 = ReachFrame.Bar2

local BackgroundBar = script.Parent.BackgroundBar
local EscapeBar = BackgroundBar.EscapeBar

local EscapeLabel = script.Parent.EscapeText
local EscapeText = EscapeLabel.EscapeText
local KeyText = EscapeLabel.KeyPress

--// ChangeableVariables
local LowerBar = 0.45 -- Make sure this value is always under 1 and smaller than HigherBar
local HigherBar = 0.55 -- Make sure this value is always under 1 and bigger than LowerBar
local BarMoveSpeed = 0.5 -- Time it takes the bar to move across screen once

--// Other
local keyPressed = false

--// Core
BarFrame1.Position = UDim2.new(LowerBar, 0, 0, 0)
BarFrame2.Position = UDim2.new(HigherBar, 0, 0, 0)

spawn(function()
	while true do
		wait()
		if keyPressed == false then
			if (EscapeBar.Size.X.Scale == 0) then
				EscapeBar:TweenSize(UDim2.new(1, 0 , 1, 0), "Out", "Linear", BarMoveSpeed)
			else
				EscapeBar:TweenSize(UDim2.new(0, 0 , 1, 0), "In", "Linear", BarMoveSpeed)
			end
		end
	end
end)

local activatedState;

if UserInputService.TouchEnabled then KeyText.Text = "Touch the screen to attempt escape" else KeyText.Text = "Press G to attempt escape" end

UserInputService.TextBoxFocused:Connect(function ()
	if activatedState == nil or activatedState == true then activatedState = false end
end)

UserInputService.TextBoxFocusReleased:Connect(function ()
	if activatedState == nil or activatedState == false then activatedState = true end
end)

UserInputService.InputBegan:Connect(function (pressedKey)
	if ((pressedKey.KeyCode == Enum.KeyCode.G or pressedKey.UserInputType == Enum.UserInputType.Touch) and (activatedState == true or activatedState == nil)) then
		if (keyPressed == false) and (script.Parent.Enabled == true) then
			local xScale = EscapeBar.Size.X.Scale
			local xScaleRounded = (math.floor(EscapeBar.Size.X.Scale * 100) / 100)
			
			keyPressed = true 
			EscapeBar:TweenSize(UDim2.new(xScale, 0 , 1, 0), "In", "Linear", 0.5, true) 
			
			if (xScaleRounded >= LowerBar) and (xScaleRounded <= HigherBar) then
				EscapeBar.BackgroundColor3 = Color3.fromRGB(1, 255, 137)
				KeyText.TextColor3 = Color3.fromRGB(1, 255, 137)
				
				KeyText.Text = "You have successfully escaped!"
				
				wait(1)
				script.Parent.Enabled = false
			else
				EscapeBar.BackgroundColor3 = Color3.fromRGB(255, 79, 79)
				KeyText.TextColor3 = Color3.fromRGB(255, 79, 79)
				
				for countdown = 3, 0, -1 do
					KeyText.Text = "You've failed. Try again in "..countdown.. " seconds."
					wait(1)
				end
				
				EscapeBar.BackgroundColor3 = Color3.fromRGB(255, 187, 26)
				KeyText.TextColor3 = Color3.fromRGB(255, 187, 26)
				
				if UserInputService.TouchEnabled then KeyText.Text = "Touch the screen to attempt escape" else KeyText.Text = "Press G to attempt escape" end
				keyPressed = false
			end
		elseif (keyPressed == true) and (script.Parent.Enabled == false) then
			EscapeBar.BackgroundColor3 = Color3.fromRGB(255, 187, 26)
			KeyText.TextColor3 = Color3.fromRGB(255, 187, 26)
			
			if UserInputService.TouchEnabled then KeyText.Text = "Touch the screen to attempt escape" else KeyText.Text = "Press G to attempt escape" end
			keyPressed = false
			script.Parent.Enabled = true
		end
	end
end)
