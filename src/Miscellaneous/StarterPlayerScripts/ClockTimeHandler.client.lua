--[[ timeHandler by Nefarioum
	
	Handles EDI Showcase iPad time to local time
	
--]]

--// Variables 

local timeToAlter = script.Parent.Parent.iPadFrame.iPadPages.LockScreen.TimeText
local timeToAlter2 = script.Parent.Parent.iPadFrame.iPadPages.PinScreen.TimeText2

local function to12H(hour)
    hour = hour % 24
    return (hour - 1) % 12 + 1
end

local function getTime()
    local date = os.date("*t")
    return ("%02d:%02d"):format(((date.hour % 24) - 1) + 1, date.min)
end

while wait(1) do
	local currentHour = os.date("*t")["hour"]
	timeToAlter.Text = getTime()
	timeToAlter2.Text = getTime()
end