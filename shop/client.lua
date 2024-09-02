--- menu shop

n = {}

for k, v in ipairs(Config.Nourriture) do
    table.insert(n, {
        title = v.label,
		description = ("Prix: %s"):format(v.price),
		icon = v.icon,
        iconColor = v.iconColor,
		onSelect = function()
			local itemName = v.item
			local itemPrice = v.price
			TriggerServerEvent("buyItem", itemName, itemPrice)
		end,
	})
end

lib.registerContext({
	id = "Nourriture",
	title = "Nourriture",
	menu = "menu_shop",
	options = n,
})

b = {}

for k, v in ipairs(Config.Boisson) do
	table.insert(b, {
		title = v.label,
		description = ("Prix: %s"):format(v.price),
		icon = v.icon,
		iconColor = v.iconColor,
		onSelect = function()
			local itemName = v.item
			TriggerServerEvent("buyItem", itemName)
		end,
	})
end

lib.registerContext({
	id = "boisson",
	title = "Boissons",
	menu = "menu_shop",
	options = b,
})

lib.registerContext({
	id = "menu_shop",
	title = "Superrette",
	options = {
		{
			title = "Nourriture",
			icon = "utensils",
			menu = "Nourriture",
		},

		{
			title = "Boisson",
			icon = "coffee",
			menu = "boisson",
		},
	},
})

-- ouvrir le menu avec la touche E

local isEnter = false
local currentShop = nil

Citizen.CreateThread(function()
    while true do
        local sleep = 100
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, shopPos in pairs(Config.ShopPosition) do
            local distance = #(shopPos - playerCoords)

            if distance < 2 then
                currentShop = shopPos
                sleep = 0
                isEnter = true

                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] - Ouvrir le Shop", {
                        position = "top-center",
                        icon = "shop",
                        style = {
                            borderRadius = 0,
                            backgroundColor = "#48BB78",
                            color = "white",
                        },
                    })
                end

                lib.addKeybind({
                    name = 'menu_shop',
                    description = 'Ouvrir la superette',
                    defaultKey = 'E',
                    onPressed = function()
                        if #(currentShop - GetEntityCoords(PlayerPedId())) < 2 then
                            lib.showContext("menu_shop")
                        end
                    end,
                })
            elseif currentShop and #(currentShop - playerCoords) > 2 then
                if isEnter then
                    lib.hideTextUI()
                    isEnter = false
                    currentShop = nil
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)


-- RegisterCommand("menu", function()
--     lib.showContext('menue')
-- end, false)

local blips = {
	-- Example {title="", colour=, id=, x=, y=, z=},

	{ title = "Shop", colour = 5, id = 628, x = -46.57727, y = -1757.823, z = 29.42101 },
	{ title = "Shop", colour = 5, id = 628, x = 25.7, y = -1347.3, z = 29.42101 },
	{ title = "Shop", colour = 5, id = 628, x = -3038.71, y = 585.9, z = 7.9 },
	{ title = "Shop", colour = 5, id = 628, x = -3241.47, y = 1001.14, z =  12.83 },
	{ title = "Shop", colour = 5, id = 628, x = 1728.66, y = 6414.16, z = 35.03 },
	{ title = "Shop", colour = 5, id = 628, x = 1697.99, y = 4924.4, z = 42.06 },
	{ title = "Shop", colour = 5, id = 628, x = 1961.48, y = 3739.96, z = 32.34 },
	{ title = "Shop", colour = 5, id = 628, x = 547.79, y = 2671.79, z = 42.15 },
	{ title = "Shop", colour = 5, id = 628, x = 2679.25, y = 3280.12, z = 55.24 },
	{ title = "Shop", colour = 5, id = 628, x = 2557.94, y = 382.05, z = 108.62 },
	{ title = "Shop", colour = 5, id = 628, x = 373.55, y = 325.56, z = 103.56 },
	
}



Citizen.CreateThread(function()
    for _, info in pairs(Config.ShopPosition) do
        local blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(blip, 628)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Shop")
        EndTextCommandSetBlipName(blip)
    end
end) 
