local MessagingService = game:GetService("MessagingService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local AnnouncementStyle = require(script.Parent.AnnouncementStyle);

local Announcer = {}
Announcer.__index = Announcer

local instances = {}

Announcer.new = function(userid, name, message, style, global)
	local self = setmetatable({
		UserId = userid,
		Name = name or "Server",
		Message = message,
		Global = global,
		Style = AnnouncementStyle.new(style),
		TimeSent = os.time()
	}, Announcer)
	
	instances[userid] = self;
	self:Init()
	
	return self;
end

function Announcer:Init()
	warn("Announcement from "..self.Name.." has been initalised.")
end

function Announcer:TriggerAnnouncement()
	local messageObject = Announcer.getTextObject(self.Message, self.UserId);
	local filteredMessage = Announcer.getFilteredMessage(messageObject);
	
	print(filteredMessage)
	self.Message = filteredMessage;
	
	if self.Global == true then 
		if (not RunService:IsStudio()) then 
			return MessagingService:PublishAsync("AnnouncerHandler", (self.UserId..'|'..self.Name.. '|'.. self.Message.. '|'.. self:GetDate()..'|'.. self.TimeSent)) 
		else
			print("Messaging Service Disabled due to Studio")
		end
	end;
	
	return self.Style.TriggerFunction(self.Name, self.Message, self:GetDate()) 
end

function Announcer:GetDate()
	local days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
	
	return string.format('%s - %d:%d', days[os.date("*t", self.TimeSent)["wday"]], string.format("%0.2i", os.date("*t", self.TimeSent)["hour"]), os.date("*t", self.TimeSent)["min"]);
end

if (not RunService:IsStudio()) then 
	MessagingService:SubscribeAsync("AnnouncerHandler", function(message)
		local parameters = message.Data:split("|");
		print(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4])
		local GetClass = Announcer.GetMetatableFromUserId(tonumber(parameters[1]))
		if GetClass == nil then
			GetClass = Announcer.new(tonumber(parameters[1]), parameters[2], parameters[3], 'chat', false)
			GetClass.TimeSent = tonumber(parameters[5]);
			
			return GetClass.Style.TriggerFunction(GetClass.Name, GetClass.Message, GetClass:GetDate())
		end

		return GetClass.Style.TriggerFunction(parameters[2], parameters[3], parameters[4])
	end)
end


Announcer.getTextObject = function(message, fromPlayerId)
	local textObject
	local success, errorMessage = pcall(function()
		textObject = TextService:FilterStringAsync(message, fromPlayerId)
	end)
	if success then
		return textObject
	elseif errorMessage then
		print("Error generating TextFilterResult:", errorMessage)
	end
	return false
end

Announcer.getFilteredMessage = function(textObject)
	local filteredMessage
	local success, errorMessage = pcall(function()
		filteredMessage = textObject:GetNonChatStringForBroadcastAsync()
	end)
	if success then
		return filteredMessage
	elseif errorMessage then
		print("Error filtering message:", errorMessage)
	end
	return false
end

Announcer.GetMetatableFromUserId = function(userID)
	return instances[userID]
end

return Announcer