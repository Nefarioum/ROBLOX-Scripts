local ReplicatedStorage = game:GetService("ReplicatedStorage");

local ChatHandlerEvent = ReplicatedStorage:FindFirstChild("Announcer"):FindFirstChild("Events").ChatHandler

local AnnouncementType = {}
AnnouncementType.__index = AnnouncementType
-- New instance function for style type
AnnouncementType.new = function(style)
	local self = setmetatable({
		AnnounceStyle = style,
		TriggerFunction = 'Empty'
	}, AnnouncementType)
	
	self:StyleHandler();
	
	return self;
end
-- Handles which style should be used for main module
function AnnouncementType:StyleHandler()
	print(self.AnnounceStyle)
	if self.AnnounceStyle == 'chat' then
		self.TriggerFunction = AnnouncementType.TriggerChatMessage
	elseif self.AnnounceStyle == 'gui' then
		print('Style selected was GUI')
	elseif self.AnnounceStyle == 'discord' then
		print('Style selected was chat')
	end
end
-- Fires the chat message to all clients with the parameters needed
-- TODO: Make them customizable with the module
AnnouncementType.TriggerChatMessage = function(name, msg, date, global)
	ChatHandlerEvent:FireAllClients({  
		Text = ('['..name..'] '.. msg.. ' | Sent at '.. date);
		Color = Color3.fromRGB(0,255,215); 
		Font = Enum.Font.SourceSans;
		FontSize = Enum.FontSize.Size18;
	})
end

function AnnouncementType:DestroyAll()
	
end


return AnnouncementType