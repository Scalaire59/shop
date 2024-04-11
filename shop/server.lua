RegisterServerEvent('buyItem')
AddEventHandler('buyItem', function(itemName, itemPrice)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Playermoney = xPlayer.getMoney()

    if Playermoney >= itemPrice then
        if xPlayer ~= nil then
            xPlayer.removeMoney(itemPrice)
            xPlayer.addInventoryItem(itemName, 1)
        end
    else
        TriggerClientEvent('ox_lib:notify', source, {
            
            title = 'Erreur',
            description = 'Vous ne possédez pas assez d\'argent pour acheter cet article.',
            position = 'top',
            duration = 5000,
            type = "error",
        })
    end
end)

