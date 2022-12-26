--[[
	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀
⠀⠀⠀⢀⣾⣿⣿⣿⣿⠟⠋⠉⠀⢤⡄⠀⠀⣄⠉⠛⠿⣿⣿⣿⣿⣿⡦⠀⠀⠀
⠀⠀⠀⣼⣿⣿⣿⠟⠁⠀⠛⣷⡀⠸⠧⠀⠸⠏⠀⠀⠀⠈⠻⡿⠟⠋⠀⠀⠀⠀
⠀⠀⠀⣿⣿⣿⠃⠀⠀⠀⠀⠈⣁⣤⣴⣶⣶⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢿⣿⡇⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⠿⠋⣀⣴⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠸⣿⣧⠀⠀⠀⠀⣸⣿⣿⠿⠿⠟⠛⣉⣠⣶⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢻⣿⣆⠀⠀⠀⢿⣿⡇⢰⣶⣾⣿⡟⠻⢿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠻⣿⣦⠀⠀⠸⣿⡇⠸⣿⣿⣿⡀⠀⠀⠀⠉⠉⢻⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀⢻⣷⡀⢻⣿⣿⣿⣶⣤⣄⡀⠀⠸⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⡿⠁⠀⠀⢸⣿⠗⠀⠉⠻⣿⣿⣿⣿⣿⣇⠀⠇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⡞⠁⠀⠀⢀⣾⣿⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⠴⠋⠀⠀⠀⠰⠛⠋⠁⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀
       Spartan - @sprtan
]]--

RegisterServerEvent("spartan:pyro:requestconfig")
AddEventHandler("spartan:pyro:requestconfig", function()
	TriggerClientEvent("spartan:pyro:sendconfig", source, Spartan.Configuration)
end)

AddEventHandler("onResourceStart", function(resourceName)
	if GetCurrentResourceName() == resourceName then
		for k, v in pairs(Spartan.Configuration.Fireworks) do
			ESX.RegisterUsableItem(v.item, function(playerId)
				local xPlayer = ESX.GetPlayerFromId(playerId)
				xPlayer.triggerEvent("spartan:pyro:client:senditems", v)
			end)
		end
	end
end)
