-- Services
local ServerScriptService = game:GetService("ServerScriptService");
local Players = game:GetService("Players");

-- Modules
local AnnouncerModule = require(ServerScriptService.Announcer.AnnouncementHandler.AnnouncerMain);

-- Code

Players.PlayerAdded:Connect(function(player)
	local Announcement = AnnouncerModule.new(player.UserId, player.DisplayName, 'A new player has joined the server!', 'chat', true);
	Announcement:TriggerAnnouncement();
	
	player.Chatted:Connect(function (msg)
		local ChatAnnouncement = AnnouncerModule.new(player.UserId, player.DisplayName, msg, 'chat', true);
		ChatAnnouncement:TriggerAnnouncement();
	end)
end)
