--[[ rbxVerification by Nefarioum
	
	Start of a verification system -> ROBLOX to Discord
	
--]]


--// Variables
math.randomseed(tick())

local StarterGui = game:GetService('StarterGui')
StarterGui:SetCore("TopbarEnabled", false)

local ScreenFrame = script.Parent
local Header = ScreenFrame.Header
local Body = ScreenFrame.Body

local VerifyFrame = ScreenFrame.Body.Stuff
local VerifyHeader = VerifyFrame.DarkHeader

local VerifyHeaderText = VerifyFrame.HeaderText
local VerifyNameText = VerifyFrame.NameText

local VerifyYes = VerifyFrame.YesButton
local VerifyNo = VerifyFrame.NoButton

local Request = true

--// Arrays
local Colours = {
	[1] = {["Header"] = {22, 160, 133}, ["Body"] = {26, 188, 156}, ["TextColour"] = {255, 255, 255}},
	[2] = {["Header"] = {44, 62, 80}, ["Body"] = {52, 73, 94}, ["TextColour"] = {255, 255, 255}},
	[3] = {["Header"] = {192, 57, 43}, ["Body"] = {231, 76, 60}, ["TextColour"] = {255, 255, 255}}
}

--// Core
local GeneratedColour = math.random(1, 3)
local HeadColour = Colours[GeneratedColour].Header
local BodyColour = Colours[GeneratedColour].Body

Header.BackgroundColor3 = Color3.fromRGB(HeadColour[1], HeadColour[2], HeadColour[3])
Body.BackgroundColor3 = Color3.fromRGB(BodyColour[1], BodyColour[2], BodyColour[3])

VerifyFrame.BackgroundColor3 = Color3.fromRGB(HeadColour[1], HeadColour[2], HeadColour[3])
VerifyHeader.BackgroundColor3 = Color3.fromRGB(HeadColour[1]+ -5, HeadColour[2]- 5, HeadColour[3]- 5)

VerifyNo.BackgroundColor3 = Color3.fromRGB(BodyColour[1], BodyColour[2], BodyColour[3])
VerifyYes.BackgroundColor3 = Color3.fromRGB(BodyColour[1], BodyColour[2], BodyColour[3])



if Request then 
	VerifyYes.MouseButton1Click:Connect(function () print("Verified!") end)
else
	VerifyNo.Visible = false
	VerifyYes.Visible = false
	
	VerifyNameText.Position = VerifyNameText.Position + UDim2.new(0,0,0.175,0)
	VerifyNameText.Text = "No verification requests."
end