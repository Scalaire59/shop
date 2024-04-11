RegisterNetEvent('buyItem', function(itemName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Playermoney = xPlayer.getMoney()

    local itemPrice
    for _,v in pairs(Config.Nourriture) do
        if v.item == itemName then
            itemPrice = v.price
        end
    end
    if not itemPrice then
        for _,v in pairs(Config.Boisson) do
            if v.item == itemName then
                itemPrice = v.price
            end
        end
    end
    if not itemPrice then
        return
    end

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

