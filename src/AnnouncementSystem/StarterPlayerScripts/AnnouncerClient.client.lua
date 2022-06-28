local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChatHandlerEvent = ReplicatedStorage:FindFirstChild("Announcer"):FindFirstChild("Events").ChatHandler

-- Runs when client has event fired from server
ChatHandlerEvent.OnClientEvent:Connect(function(chatProperties)
    -- Triggers the chat message for the player, parameters is the properties needed
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", chatProperties);
end)