--[[ Rank Door by Nefarious
	
	// Filename: DoorHandler.lua
	// Version: 1.0
	// Description: Handles the opening of a ranked door
	
--]]


--// Services
local Players = game:GetService("Players")

--// Variables
local Player = game.Players.LocalPlayer -- This defines the player, remember you can only call a player this way in a local script.
local RankAllowed = 15 -- Change this according to the rank you would like to enter the door.
local GroupID = 5296994 --Change this according to your group ID

local GUIWaitTime = 5 --This is optional, if you want a GUI to pop-up if they are the wrong 

local DoorLocation = game.Workspace.RankDoor -- Enter the location of your door in the Workspace.
local Debounce = false


if Player:GetRankInGroup(GroupID) >= RankAllowed then
	if DoorLocation then
		DoorLocation.CanCollide = false
		DoorLocation.Transparency = 1
	else
		warn("The door doesn't exist, make sure you have a door called RankDoor in the workspace.")
	end
end


DoorLocation.Touched:Connect(function (partTouched)
	if Players:GetPlayerFromCharacter(partTouched.Parent) then 
		local TouchedPlayer = Players:GetPlayerFromCharacter(partTouched.Parent)
		if TouchedPlayer == Player then
			if TouchedPlayer:GetRankInGroup(GroupID) >= RankAllowed then 
				if Debounce == false then
					Debounce = true
					print("This user is allowed to pass.")
					
					--[[ You can add a GUI pop-up here, example would be:
					TouchedPlayer.PlayerGui.Denied.Frame.Visible = true
					--]]
					
					wait(GUIWaitTime)
					--TouchedPlayer.PlayerGui.Allowed.Frame.Visible = false
					Debounce = false
				end
			else
				if Debounce == false then
					Debounce = true
					print("This user is not allowed to pass.")
					
					--[[ You can add a GUI pop-up here, example would be:
					TouchedPlayer.PlayerGui.Denied.Frame.Visible = true
					--]]
					
					wait(GUIWaitTime)
					--TouchedPlayer.PlayerGui.Denied.Frame.Visible = false
					Debounce = false
				end
			end
		end
	end
end)