local validWeapons = {
	-- Pistols
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
}                                                                                                                                                                                                                                                                                                                    --Made By SaskaTheBlessed

function KillYourself()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)

		local canSuicide = false
		local foundWeapon = nil

		for i=1, #validWeapons do
			if HasPedGotWeapon(playerPed, GetHashKey(validWeapons[i]), false) then
				if GetAmmoInPedWeapon(playerPed, GetHashKey(validWeapons[i])) >= 1 then
					canSuicide = true
					foundWeapon = GetHashKey(validWeapons[i])
					break
				end
			end
		end

		if canSuicide then
			if not HasAnimDictLoaded('mp_suicide') then
				RequestAnimDict('mp_suicide')
				
				while not HasAnimDictLoaded('mp_suicide') do
					Wait(1)
				end
			end

			SetCurrentPedWeapon(playerPed, foundWeapon, true)

			TaskPlayAnim(playerPed, "mp_suicide", "pistol", 5.0, 1.0, -1, 2, 0, 0, 0, 0 )

			Wait(750)

			SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
			SetEntityHealth(playerPed, 0)
		end
	end)
end

function DontKillYourself()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)

		local cantSuicide = false
		local foundWeapon = nil

		for i=1, #validWeapons do
			if HasPedGotWeapon(playerPed, GetHashKey(validWeapons[i]), false) then
				if GetAmmoInPedWeapon(playerPed, GetHashKey(validWeapons[i])) >= 1 then
					cantSuicide = true
					foundWeapon = GetHashKey(validWeapons[i])
					break
				end
			end
		end

		if cantSuicide then
			if not HasAnimDictLoaded('weapons@first_person@aim_rng@generic@pistol@pistol_50@') then
				RequestAnimDict('weapons@first_person@aim_rng@generic@pistol@pistol_50@')
				
				while not HasAnimDictLoaded('weapons@first_person@aim_rng@generic@pistol@pistol_50@') do
					Wait(800)
				end
			end
			if not HasAnimDictLoaded('mp_suicide') then
				RequestAnimDict('mp_suicide')
				
				while not HasAnimDictLoaded('mp_suicide') do
					Wait(800)
				end
			end
			SetCurrentPedWeapon(playerPed, foundWeapon, true)
			TaskPlayAnim(playerPed, "mp_suicide", "pistol_fp", 8.0, 4.0, 20.0, 232, 0, 0, 0, 0 )
			Wait(700)
			TaskPlayAnim(playerPed, 'weapons@first_person@aim_rng@generic@pistol@pistol_50@str', 'w_reload_aim_l', 1.0, -1.0, -1,122,0,0, 0,0)
		end
	end)
end

RegisterCommand('rruletti', function()
	local mahdollisuus = math.random(0,3)
	if mahdollisuus == 1 then
		KillYourself()
	else
		DontKillYourself()
	end
end, false)