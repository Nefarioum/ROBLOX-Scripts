--[[ Checkpoint Datastore Handler by Nefarious
	
	Handles the loading of checkpoints	
	
--]]

--// Variables

local Checkpoints = game.Workspace:WaitForChild("NewCheckpoints")
local DatastoreService = game:GetService("DataStoreService")
local DatastoreDatabase = DatastoreService:GetDataStore("Skipzy")

--// Functions
local function dataCreation(plr)
	local DefaultValues = {
		Stage = 0,
		Deaths = 0,
		Prestige = 0}
	
	local Leaderstats = Instance.new("Folder", plr)
	Leaderstats.Name = "leaderstats"
	
	for Name, Value in pairs(DefaultValues) do
		local Value = Instance.new("IntValue", Leaderstats)
		Value.Name = Name
		Value.Value = Value
	end
end

local function dataLoad(plr)
	local TempKey
	local success, fail = pcall(function ()
		TempKey = DatastoreDatabase:GetAsync("UserID:"..plr.UserId)
	end)
	
	if success then 
		print("Successfully loaded "..plr.UserId.." data")
	else
		print("failed")
	end
	
	if TempKey then
		for Name, Value in pairs(TempKey) do 
			plr.leaderstats[Name].Value = Value
		end
		print("Completed loading "..plr.UserId.." data.")
	else
		print("No data found for "..plr.UserId.." creating new data")
	end
end

local function saveData(plr)
	local RunService = game:GetService("RunService")
	if RunService:IsStudio() then return end
	
	local TempStorage = {}
	
	for _, Stats in pairs(plr.leaderstats:GetChildren()) do
		TempStorage[Stats.Name] = Stats.Value
	end
	
	local success, fail = pcall(function ()
		DatastoreDatabase:SetAsync("UserID:"..plr.UserId, TempStorage)
	end)
	
	if success then
		print("Successfuly saved "..plr.UserID.." data.")
	else
		warn(fail)
		print("Failed to save data "..plr.UserId..", contact Nefarioum")
	end	
	
end

local function shutdownSave()
	local players = game.Players:GetPlayers()
	
	for _, plr in pairs(players) do
		saveData(plr)
		wait()
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	dataCreation(plr)
	dataLoad(plr)
end)

game.Players.PlayerRemoving:Connect(function (plr)
	saveData(plr)
end)

game:BindToClose(function() local RunService = game:GetService("RunService") if RunService:IsStudio() then return else shutdownSave() end end)

for _, Point in pairs(Checkpoints:GetChildren()) do
	Point.Touched:Connect(function (touchedPart)
		if (touchedPart.Parent:FindFirstChild("Humanoid") ~= nil) then 
			local plr = game.Players:GetPlayerFromCharacter(touchedPart.Parent	)
			plr.leaderstats.Stage.Value = plr.leaderstats.Stage.Value + 1
		end
	end)
end