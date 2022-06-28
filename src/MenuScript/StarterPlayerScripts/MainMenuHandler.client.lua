local _menuModule = require(script:WaitForChild("MenuModule"));

local AnimationsButton = script.Parent:WaitForChild("Animations", 10);
local ChatSoundsButton = script.Parent:WaitForChild("ChatSounds", 10);
local CourtRecordButton = script.Parent:WaitForChild("CourtRecord", 10);
local CustomizerButton = script.Parent:WaitForChild("Customizer", 10);
local ToolsButton = script.Parent:WaitForChild("Tools", 10);

local AnimationsFrame = script.Parent.Parent:WaitForChild("Animations", 10);
local ChatSoundsFrame = script.Parent.Parent:WaitForChild("ChatSounds", 10);
local CourtRecordFrame = script.Parent.Parent:WaitForChild("CourtRecord", 10);
local CustomizerFrame = script.Parent.Parent:WaitForChild("Customizer",	 10);
local ToolsFrame = script.Parent.Parent:WaitForChild("Tools", 10);

-- Define all the buttons and frames
local ButtonToTool = {
	["Animations"] = { 
		["Button"] = AnimationsButton,
		["Frame"] = AnimationsFrame 
	},
	
	["ChatSounds"] = { 
		["Button"] = ChatSoundsButton,
		["Frame"] = ChatSoundsFrame
	},
	
	["CourtRecords"] = { 
		["Button"] = CourtRecordButton,
		["Frame"] = CourtRecordFrame
	},
	
	["Customizer"] = { 
		["Button"] = CustomizerButton,
		["Frame"] = CustomizerFrame
	},
	
	["Tools"] = { 
		["Button"] = ToolsButton,
		["Frame"] = ToolsFrame
	}
}

-- Loop through them all and create a new module instance of each
for _k, _v in pairs(ButtonToTool) do
	_menuModule.new(_k, _v["Button"], _v["Frame"]);
end