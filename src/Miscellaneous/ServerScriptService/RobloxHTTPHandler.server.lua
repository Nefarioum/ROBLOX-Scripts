--[[ Roblox HTTP Communication by Nefarious
	
	Handles communication utiliszing a heruko server
	
--]]

local HTTPSerivce = game:GetService("HttpService")
local ReplicatedService = game:GetService("ReplicatedStorage")

local AnnounceRemote = ReplicatedService.AnnouncementHandler

local URL = "https://.herokuapp.com"
local Req = HTTPSerivce:GetAsync(URL.."/RBXComm")

function returnReq()
	local URL = "https://.herokuapp.com"
	local Req = HTTPSerivce:GetAsync(URL.."/RBXComm", true)
	
	if Req == "-" then
		return false
	else
		return true, Req
	end
end

HTTPSerivce:PostAsync(URL.."/RBXPost", HTTPSerivce:JSONEncode({welcome = "hi"}))

local res = HTTPSerivce:RequestAsync({
	Url = URL.."/RBXPost",
	Method = "POST",
	Headers = {
		["Content-Type"] = "application/json"
	},
	Body = HTTPSerivce:JSONEncode({welcome = "hi"})})
	
if res.Success then 
	print(res.body)
else
	print("fail")
end


while true do
	wait(1)
	local success, result = returnReq()
	if success then
		AnnounceRemote:FireAllClients(result)	
	end
end

