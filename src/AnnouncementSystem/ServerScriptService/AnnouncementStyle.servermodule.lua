local ReplicatedStorage = game:GetService("ReplicatedStorage");

local ChatHandlerEvent = ReplicatedStorage:FindFirstChild("Announcer"):FindFirstChild("Events").ChatHandler

local AnnouncementType = {}
AnnouncementType.__index = AnnouncementType

AnnouncementType.new = function(style)
	local self = setmetatable({
		AnnounceStyle = style,
		TriggerFunction = 'Empty'
	}, AnnouncementType)
	
	self:StyleHandler();
	
	return self;
end

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