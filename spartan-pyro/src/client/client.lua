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

Spartan = {}
Spartan.Entity = {}
Spartan.Entity.TP2 = nil
Spartan.Entity.C6 = nil
Spartan.IngitedTP2 = nil
Spartan.IngitedC6 = nil

Citizen.CreateThread(function()
	TriggerServerEvent("spartan:pyro:requestconfig")

	if not HasNamedPtfxAssetLoaded("cut_sil") then
		RequestNamedPtfxAsset("cut_sil")
		while not HasNamedPtfxAssetLoaded("cut_sil") do
			Citizen.Wait(100)
		end
	end

	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(100)
		end
	end
end)

RegisterNetEvent("spartan:pyro:sendconfig")
AddEventHandler("spartan:pyro:sendconfig", function(data)
	Spartan.Configuration = data
end)

RegisterNetEvent("spartan:pyro:client:senditems")
AddEventHandler("spartan:pyro:client:senditems", function(data)
	if data.item == "tp2" and not Spartan.Entity.TP2 then
		ThreadTP2(data)
	elseif data.item == "c6" and not Spartan.Entity.C6 then
		ThreadCobra6(data)
	else
		ESX.ShowHelpNotification("Wait for the current firework that is currently ignited!")
	end
end)

ThreadTP2 = function(data)
	local pedcoords = GetEntityCoords(PlayerPedId())
	local ped = PlayerPedId()
	local BoneCoords = GetPedBoneCoords(PlayerPedId(), 6286)

	TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	Citizen.Wait(4000)
	ClearPedTasks(ped)

	Spartan.Entity.TP2 = CreateObject(GetHashKey("spartan_tp2"), BoneCoords, true, false, false)

	PlaceObjectOnGroundProperly(Spartan.Entity.TP2)
	FreezeEntityPosition(Spartan.Entity.TP2, true)

	exports.qtarget:AddTargetEntity(Spartan.Entity.TP2, {
		options = {
			{
				label = Spartan.Configuration.Strings.IgniteString,
				event = "spartan:pyro:igniteTP2",
				icon = "fas fa-fire",
				num = 1,
			},
		},
		distance = 2.5,
	})
end

RegisterNetEvent("spartan:pyro:igniteTP2")
AddEventHandler("spartan:pyro:igniteTP2", function()
	if not Spartan.IngitedTP2 then
		Spartan.IngitedTP2 = true
		local SmallCrackerCoords = GetEntityCoords(Spartan.Entity.TP2)
		SetPtfxAssetNextCall("core")
		Citizen.Wait(2000)
		local smoke = StartParticleFxLoopedAtCoord(
			"exp_grd_flare",
			SmallCrackerCoords.x + 0.06,
			SmallCrackerCoords.y,
			SmallCrackerCoords.z,
			0.0,
			0.0,
			0.0,
			0.5,
			false,
			false,
			false,
			false
		)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 54.0, 255.0, 0.0, 1)
		Citizen.Wait(5000)
		StopParticleFxLooped(smoke, 0)
		Citizen.Wait(1000)
		AddExplosion(SmallCrackerCoords.x, SmallCrackerCoords.y, SmallCrackerCoords.z, 2, 0.9, 1, 0, 1065353216, 0)
		Wait(0)
		NetworkFadeOutEntity(Spartan.Entity.TP2, false, true)
		DeleteEntity(Spartan.Entity.TP2)
		Spartan.Entity.TP2 = nil
		Spartan.IngitedTP2 = false
	end
end)

ThreadCobra6 = function(data)
	local pedcoords = GetEntityCoords(PlayerPedId())
	local ped = PlayerPedId()
	local BoneCoords = GetPedBoneCoords(PlayerPedId(), 6286)

	TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	Citizen.Wait(3000)
	ClearPedTasks(ped)

	Spartan.Entity.C6 = CreateObject(GetHashKey("spartan_cobra6"), BoneCoords, true, false, false)

	PlaceObjectOnGroundProperly(Spartan.Entity.C6)
	FreezeEntityPosition(Spartan.Entity.C6, true)

	exports.qtarget:AddTargetEntity(Spartan.Entity.C6, {
		options = {
			{
				label = Spartan.Configuration.Strings.IgniteString,
				event = "spartan:pyro:igniteC6",
				icon = "fas fa-fire",
				num = 1,
			},
		},
		distance = 2.5,
	})
end

RegisterNetEvent("spartan:pyro:igniteC6")
AddEventHandler("spartan:pyro:igniteC6", function()
	if not Spartan.IngitedC6 then
		Spartan.IngitedC6 = true
		local CrackerCoords = GetEntityCoords(Spartan.Entity.C6)
		SetPtfxAssetNextCall("core")
		Citizen.Wait(2000)
		local smoke = StartParticleFxLoopedAtCoord(
			"exp_grd_flare",
			CrackerCoords.x,
			CrackerCoords.y,
			CrackerCoords.z + 0.16,
			0.0,
			0.0,
			0.0,
			0.5,
			false,
			false,
			false,
			false
		)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 54.0, 255.0, 0.0, 1)
		Citizen.Wait(15000)
		StopParticleFxLooped(smoke, 0)
		Citizen.Wait(1000)
		AddExplosion(CrackerCoords.x, CrackerCoords.y, CrackerCoords.z, 1, 0.9, 1, 0, 1065353216, 0)
		Wait(0)
		NetworkFadeOutEntity(Spartan.Entity.C6, false, true)
		DeleteEntity(Spartan.Entity.C6)
		Spartan.Entity.C6 = nil
		Spartan.IngitedC6 = false
	end
end)
