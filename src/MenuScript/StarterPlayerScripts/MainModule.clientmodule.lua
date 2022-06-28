local MenuModule = {}
MenuModule.__index = MenuModule

local menuInstances = {}
local menuDebounce = false
-- Function to create a new instance of each menu
MenuModule.new = function(name, button, frame)
	local self = setmetatable({
		Name = name,
		Button = button, 
		Frame = frame,
		IsOpen = false
	}, MenuModule)
	
	table.insert(menuInstances, self)
    -- Run the init function
	self:Init()

	return self;
end

function MenuModule:Init()
    -- Button click event initailized for each of the instances
	self.Button.MouseButton1Click:Connect(function() 
		if menuDebounce == false then 
			menuDebounce = true;
			if MenuModule.returnOpenArray() then
				if MenuModule.returnOpenArray() == self then
                    -- Runs when closed is press
					print(self.Name.. ' has been closed.')
					
					self.IsOpen = false;
					
					self:Tween(self.IsOpen)
					self:ToggleFrame(self.IsOpen)
					
					menuDebounce = false;
					return;
				else
                    -- Runs when opening of another button is pressed, closes the previous frame
					local CurrentOpenMenu = MenuModule.returnOpenArray();
					CurrentOpenMenu.IsOpen = false;
					
					CurrentOpenMenu:Tween(CurrentOpenMenu.IsOpen)
					CurrentOpenMenu:ToggleFrame(CurrentOpenMenu.IsOpen)
					print(CurrentOpenMenu.Name.. ' has been closed.')	
				end
			
			end
            -- Opens a new frame
			print(self.Name.. ' has been opened.')
			
			self.IsOpen = true;
			
			self:Tween(self.IsOpen)
			self:ToggleFrame(self.IsOpen)
			
			menuDebounce = false;
		end
	end)
	
	warn("Button "..self.Name.." has been initalised.")
end
-- Handle the tween animations
function MenuModule:Tween(handler)
	if handler then
		self.Frame:TweenPosition(UDim2.new(1, 0, 0.5, 0), "In", "Quad", 1, false)
	else
		self.Frame:TweenPosition(UDim2.new(1.5, 0, 0.5, 0), "Out", "Quad", 1, false, function()
			self.Frame.Visible = false;
		end)
	end
end
-- Toggle the visibiltiy of the frame
function MenuModule:ToggleFrame(handler)
	if handler then
		self.Frame.Visible = true;
		wait(0.5)
	else
		wait(0.5)
		self.Frame.Visible = false;
	end
end

-- Return which frame is currently open
MenuModule.returnOpenArray = function()
	for _k, _v in pairs(menuInstances) do
		if _v.IsOpen then
			return _v;
		end
	end
	return false;
end

return MenuModule