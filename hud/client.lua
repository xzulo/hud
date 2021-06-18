ESX = nil

local drunk = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local toghud = true

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

RegisterNetEvent("Hud:onTick") 
AddEventHandler("Hud:onTick", function(Status)
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        hunger = status.val / 10000  
    end)
    
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)   
        thirst = status.val / 10000  
    end)

    TriggerEvent('esx_status:getStatus', 'drunk', function(status)   
        drunk = status.val / 10000  
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end
    end 
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 2.5

        SendNUIMessage({
            action = 'updateStatusHud',
            pauseMenu = IsPauseMenuActive(),
            show = toghud,
            health = health,
            armour = armor,
            hunger = hunger,
            thirst = thirst,
            drunk = drunk,
            oxygen = oxy
        })
    end
end)