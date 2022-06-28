-- Services
local ServerScriptService = game:GetService("ServerScriptService");
local Players = game:GetService("Players");

-- Modules
local AnnouncerModule = require(ServerScriptService.Announcer.AnnouncementHandler.AnnouncerMain);

-- Code

Players.PlayerAdded:Connect(function(player)
    -- Create new announcement module instance when player joins
	local Announcement = AnnouncerModule.new(player.UserId, player.DisplayName, 'A new player has joined the server!', 'chat', true);
    -- Trigger the announcement after its instance is made
	Announcement:TriggerAnnouncement();
	
    -- Runs everytime player sends chat message
	player.Chatted:Connect(function (msg)
        -- Broadcast chat message to all servers
		local ChatAnnouncement = AnnouncerModule.new(player.UserId, player.DisplayName, msg, 'chat', true);
		ChatAnnouncement:TriggerAnnouncement();
	end)
end)
