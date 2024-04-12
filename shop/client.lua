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

Citizen.CreateThread(function()
	while true do
		Sleep = 1000
		local player = PlayerPedId()
		local playerCoords = GetEntityCoords(player)
		local distance = GetDistanceBetweenCoords(Config.ShopPosition, playerCoords, false)

		if distance < 2 then
			Sleep = 0
			lib.showTextUI("[E] - Ouvrir le Shop", {
				position = "top-center",
				icon = "shop",
				style = {
					borderRadius = 0,
					backgroundColor = "#48BB78",
					color = "white",
				},
			})

			if IsControlJustPressed(0, 51) then
				lib.showContext("menu_shop")
			end
		else
			lib.hideTextUI()
		end
		Wait(Sleep)
	end
end)

-- RegisterCommand("menu", function()
--     lib.showContext('menue')
-- end, false)

local blips = {
	-- Example {title="", colour=, id=, x=, y=, z=},

	{ title = "Shop-scalaire", colour = 5, id = 628, x = -46.57727, y = -1757.823, z = 29.42101 },
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)
