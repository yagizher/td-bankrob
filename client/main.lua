

ESX = nil
PlayerData = nil

local startrob = false
local toggledoor = false
local PlayerData = {}
local hsn31 = 0 





Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local doorcoords = {
	[1] = {x = 314.06, y = -285.35, z = 54.14}, 
	[2] = {x = -351.02, y = -56.3, z = 49.01}, 
	[3] = {x = 149.58, y = -1046.98, z = 29.35}, 
}

local vaultdoors = {
	[1] = {x = 311.02, y = -284.43, z = 54.16}, 
	[2] = {x = 146.87, y = -1046.06, z = 29.37}, 
	[3] = {x = -353.7, y = -54.98, z = 49.04}, 
}

local search = {
	[1] = {x = -351.7, y = -53.79, z = 49.01, isOpen = false}, 
	[2] = {x = -349.53, y = -55.63, z = 49.01, isOpen = false}, 
	[3] = {x = -353.75, y = -57.61, z = 49.01, isOpen = false}, 
	[4] = {x = -350.21, y = -59.21, z = 49.01, isOpen = false}, 
	[5] = {x = 313.68, y = -283.17, z = 54.14, isOpen = false}, 
	[6] = {x = 315.56, y = -284.93, z = 54.14, isOpen = false}, 
	[7] = {x = 311.25, y = -286.8, z = 54.14, isOpen = false}, 
	[8] = {x = 314.99, y = -287.87, z = 54.14, isOpen = false}, 
	[9] = {x = 149.7, y = -1044.94, z = 29.35, isOpen = false}, 
	[10] = {x = 151.19, y = -1046.66, z = 29.35, isOpen = false}, 
	[11] = {x = 146.95, y = -1048.35, z = 29.35, isOpen = false}, 
	[12] = {x = 150.12, y = -1050.19, z = 29.35, isOpen = false}, 
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local coords, shn = GetEntityCoords(PlayerPedId()), true 
	   if  startrob then 
		if not toggledoor then   
       for a,b in pairs(doorcoords) do
         if GetDistanceBetweenCoords(coords, b.x, b.y, b.z, true) < 1  then 
             DrawText3Ds(b.x, b.y, b.z+0.50, "[E] - Obje Kullan")
			 if IsControlJustReleased(0,119) then   
				ESX.TriggerServerCallback("td-bankrob:itemcount", function(var)
                    if var then
						local skil = exports["reload-skillbar"]:taskBar(1500,math.random(5,15))
						if skil ~= 100 then
						   exports['mythic_notify']:SendAlert('error', 'Başarısız oldun', 2500)
						else
						   exports['mythic_notify']:SendAlert('inform', 'Kapı Açıldı 15 saniye sonra geri kapanacak', 2500)
						   toggledoor = true
						end                       
                    elseif not var then
                        exports['mythic_notify']:SendAlert('error', 'Thermite\'n Yok', 2500)
                    end
                end, "thermite")             
				 end
             end
         end
     end
 end 

if startrob then
	for k,v in pairs(search) do
		if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1 and not v.isOpen then 
		DrawText3Ds(v.x, v.y, v.z+0.50, "Ara")
		if IsControlJustReleased(0,119) then 
			loadAnimDict( "mini@repair" ) 
				TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
			exports["aex-bar"]:taskBar(10000, "Aranıyor! ") 
			TriggerServerEvent('td-bankrob:givecash')
			v.isOpen = true
                  hsn31 = hsn31
                  if hsn31 == Config.StandLim then 
                     v.isOpen = false
                     hsn31 = 0  
                 end
		end
	end
end
end

 end
end)



function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
   end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local coords, shn = GetEntityCoords(PlayerPedId()), true 
       if  not toggledoor then    
	local PlayerPos = GetEntityCoords(PlayerPedId())
	
	door = GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 100.0, GetHashKey('v_ilev_gb_vaubar'), 0, 0, 0)
	FreezeEntityPosition(door, true)

	Citizen.Wait(1000)
else
	local PlayerPos = GetEntityCoords(PlayerPedId())
	door = GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 100.0, GetHashKey('v_ilev_gb_vaubar'), 0, 0, 0)
	
	FreezeEntityPosition(door, false)
	Citizen.Wait(15000)
	FreezeEntityPosition(door, true)
end
end
end)


function OpenVaultDoor()
    ResetDoor()

	local PlayerPos = GetEntityCoords(PlayerPedId())
    local doorvault = GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 100.0, GetHashKey('v_ilev_gb_vauldr'), 0, 0, 0)
    local rotation = GetEntityRotation(door, 15.835)

	Citizen.CreateThread(function()
		FreezeEntityPosition(door, false)

            Citizen.Wait(1)

            rotation = rotation - 0.25

            SetEntityRotation(doorvault, 0.0, 0.0, rotation)

		FreezeEntityPosition(doorvault, true)
    end)

end

function ResetDoor()
	local PlayerPos = GetEntityCoords(PlayerPedId())
    local doorvault = GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 100.0, GetHashKey('v_ilev_gb_vauldr'), 0, 0, 0)

    SetEntityRotation(doorvault, 0.0, 0.0, 0.0,0.0, 0.0)
end




function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end  

RegisterNetEvent('td-bankrob:togglevaultdoor')
AddEventHandler('td-bankrob:togglevaultdoor', function()
	local playerPed = GetPlayerPed(-1)
	local coords, shn = GetEntityCoords(PlayerPedId()), true 
	for k,v in pairs(vaultdoors) do
		if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5  then   
			ESX.TriggerServerCallback('td-bankrob:copCount', function(cops)
				if cops >= Config.PoliceCount then -- polis sayısı -- burası
			exports["aex-bar"]:taskBar(10000, "Açılıyor! ")
			OpenVaultDoor()
			TriggerServerEvent('td-bankrob:policenotif')
			startrob = true
			
			else
				exports['mythic_notify']:SendAlert('error', 'Yeterli polis yok', 2500)
			end
		end)
		end
	end
end)

RegisterNetEvent('td-bankrob:setblip') -- sürekli burası triggerlanıyor gye bastığımda normalde kapatması lazım tekrar triggerlıyor
AddEventHandler('td-bankrob:setblip', function()
    local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)

    exports["mythic_notify"]:SendAlert("infrom", "Banka Soyuluyor!", 35000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
    blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 75)
    Citizen.Wait(38000)
    TriggerEvent('td-bankrob:killblip')
end)

RegisterNetEvent('td-bankrob:killblip')
AddEventHandler('td-bankrob:killblip', function()
    RemoveBlip(blip)
end)