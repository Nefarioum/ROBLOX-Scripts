local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChatHandlerEvent = ReplicatedStorage:FindFirstChild("Announcer"):FindFirstChild("Events").ChatHandler

ChatHandlerEvent.OnClientEvent:Connect(function(chatProperties)
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", chatProperties);
end)