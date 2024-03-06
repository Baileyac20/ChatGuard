--// Main.lua | SetAsync | March 2024.
local ChatGuard = script.Parent
local Config = require(ChatGuard)
local Offenses = {}
local HTTPService = game:GetService("HttpService")
local ClientData = {}
local ServerKicks = {}

-- Give the detective modules their punishment values.
for i, v in ChatGuard.Offenses:GetChildren() do
	local trainDetective = require(v)
	trainDetective.Punishment = Config.Offenses[v.Name]
	Offenses[i] = trainDetective
end

-- Takes a client, evaluates their punishment (if any) and executes.
function Jury(Client, LatestOffense)
	if not ServerKicks[Client.UserId] then
		ServerKicks[Client.UserId] = 0
	end
	
	local Crime = ClientData[Client.UserId]
	if Crime >= Config.ActionLevel then
		Client:Kick(Config.KickMessage)
		HTTPService:PostAsync(Config.WebhookB, HTTPService:JSONEncode({
			content = nil,
			embeds = { {
				title = "Suspicious Activity",
				description = "A player's suspicious activity level has reached `"..Crime.."`.",
				color = 16735283,
				fields = { {
					name = "Player",
					value = "["..Client.Name.."](https://www.roblox.com/users/"..Client.UserId.."/profile)"
				}, {
					name = "Server ID",
					value = "`"..game.JobId.."`"
				}, {
					name = "Punishment Level",
					value = "`"..Crime.."`"
				}, {
					name = "Latest Offense",
					value = "`"..LatestOffense.."`"
				} },
				footer = {
					text = "The player has been kicked.",
					icon_url = "https://cdn-icons-png.flaticon.com/512/10351/10351540.png"
				}
			} },
			username = "ChatGuard's Webhook Service",
			avatar_url = "https://cdn-icons-png.flaticon.com/512/10351/10351540.png",
			attachments = { }
		}))
	elseif Crime >= Config.SuspiciousLevel then
		HTTPService:PostAsync(Config.WebhookA, HTTPService:JSONEncode({
			content = nil,
			embeds = { {
				title = "Suspicious Activity",
				description = "A player's suspicious activity level has reached `"..Crime.."`.",
				color = 16735283,
				fields = { {
					name = "Player",
					value = "["..Client.Name.."](https://www.roblox.com/users/"..Client.UserId.."/profile)"
				}, {
					name = "Server ID",
					value = "`"..game.JobId.."`"
				}, {
					name = "Punishment Level",
					value = "`"..Crime.."`"
				}, {
					name = "Latest Offense",
					value = "`"..LatestOffense.."`"
				} },
				footer = {
					text = "No automatic action has been taken yet.",
					icon_url = "https://cdn-icons-png.flaticon.com/512/10351/10351540.png"
				}
			} },
			username = "ChatGuard's Webhook Service",
			avatar_url = "https://cdn-icons-png.flaticon.com/512/10351/10351540.png",
			attachments = { }
		}))
		warn("Sent suspicious activity log for "..Client..".")
	end
	
	ServerKicks[Client.UserId] += 1
end

-- Watches a client.
function HandleClient(Client)
	if ServerKicks[Client.UserId] and ServerKicks[Client.UserId] >= Config.ServerLock then
		Client:Kick("Server Ban - "..Config.KickMessage)
		return
	end
	
	ClientData[Client.UserId] = 0
	Client.Chatted:Connect(function(Message)
		local TrialNeeded = false
		for _, Detective in ipairs(Offenses) do
			local Punishment = Detective.inspectMessage(Client, Message)
			if Punishment then
				TrialNeeded = Detective.Name
				ClientData[Client.UserId] += Punishment
				warn(Client.Name.." punished with "..Punishment.." points for "..Detective.Name)
			end
		end
		if TrialNeeded then
			Jury(Client, TrialNeeded)
		end
	end)
	
	for _, Detective in ipairs(Offenses) do
		local Message = "No Content"
		local Punishment = Detective.inspectMessage(Client, Message)
		if Punishment then
			ClientData[Client.UserId] += Punishment
			warn(Client.Name.." punished with "..Punishment.." points for "..Detective.Name.." on client connect.")
		end
	end
end
for _, v in ipairs(game.Players:GetPlayers()) do
	coroutine.wrap(HandleClient)(v)
end
game.Players.PlayerAdded:Connect(HandleClient)


-- This script is held under the terms listed on www.setasync.me/tos.
