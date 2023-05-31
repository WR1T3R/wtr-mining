-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateCallback("mine:callback:getItemCount",function(source, cb, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local itemName = Player.Functions.GetItemByName(item)
	if not itemName then return QBCore.Functions.Notify(src, Lang:t("error.donthaveitem", {itemneeded = QBCore.Shared.Items[item].label}), "error") end
	cb(itemName.amount)
end)

RegisterServerEvent("mine:sv:SetupItems", function(type, func, item, amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local toAmount = tonumber(amount)
	local Weight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
	if type == "others" then
		if func == "add" then
			Player.Functions.AddItem(item, toAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", toAmount)
		elseif func == "remove" then
			Player.Functions.RemoveItem(item, toAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "remove", toAmount)
		end
	elseif type == "smelting" then
		local boxData = {}
		local a = toAmount
		local cfg = Config.Settings.Smelting.Reward
		local washed = Config.Settings.Washing.Items.WashedStone
		Player.Functions.RemoveItem(washed , toAmount)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[washed], "remove", toAmount)	
		Weight = Weight - (QBCore.Shared.Items[washed]["weight"] * toAmount) 
		for i = 1, toAmount do
			if a > 0 then
				for _, v in pairs(cfg) do
					local chance = math.random(0,100)
					if chance <= v.chance then
						local b
						local c
						if a > tonumber(v.amount.min) then b = tonumber(v.amount.min) else b = a end
						if a > tonumber(v.amount.max) then c = tonumber(v.amount.max) else c = a end
						local count = math.random(b, c)
						if (Weight + (QBCore.Shared.Items[v.item]["weight"] * count)) <= Config.Inventory.MaxWeight then
							Player.Functions.AddItem(v.item, count)
							if boxData[v.item] then boxData[v.item] = boxData[v.item] + count else boxData[v.item] = count end
							Weight = Weight + (QBCore.Shared.Items[v.item]["weight"] * count)
							a = a - count
						end
					end
				end
			end
		end
		for item,count in pairs(boxData) do
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", count)
		end
	end
end)

RegisterServerEvent("mine:sv:UpdateCash", function(data, amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	Player.Functions.AddMoney(Config.Currency, tonumber(amount * data.pricetosell))
end)
