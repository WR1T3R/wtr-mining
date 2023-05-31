-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 
local QBCore = exports["qb-core"]:GetCoreObject()
local Current = {Mining = false, Washing = false, Smelting = false, Mine = {}, Foundry = false}
local AmountProps = 0

function SpawnMineProps()
	AmountProps = #Config.Mining.Places
	for _, v in pairs(Config.Mining.Places) do
		Wait(1000)
		if v.Blip then
			local blip = AddBlipForCoord(v.Coords[1], v.Coords[2], v.Coords[3])
			SetBlipSprite(blip, Config.Blip.Mining.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.7)
			SetBlipColour (blip, Config.Blip.Mining.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Lang:t("blip.mining"))
			EndTextCommandSetBlipName(blip)
		end
		local model = joaat(Config.Mining.Props)
		lib.requestModel(model)
		local pact = CreateObject(model, v.Coords.x, v.Coords.y, v.Coords.z - 1, false, false)
		while not DoesEntityExist(pact) do Wait(10) end
		FreezeEntityPosition(pact, true)
		SetModelAsNoLongerNeeded(pact)
		PlaceObjectOnGroundProperly(pact)
		SetEntityHeading(pact, v.Coords.w - 180)
		local optmineprops = {
			{
				name = 'mineprops:localentity',
				event = "mining:client:setMineProps",
				icon = "fas fa-circle",
				label = Lang:t("target.mining"),
				pact = pact,
				canInteract = function()
					if Current.Mining or v.inUse then return false else return true end
				end
			}
		}
		exports.ox_target:addLocalEntity(pact, optmineprops)
		table.insert(Current.Mine, pact)
	end
end

function Foundry()
	local coords = Config.Ped.Coords
	local model = joaat(Config.Ped.Model)
	lib.requestModel(model)
	local peds = CreatePed(0, model, coords, coords.w, false, false)
	FreezeEntityPosition(peds, true)
	SetEntityInvincible(peds, true)
	SetBlockingOfNonTemporaryEvents(peds, true)
	TaskStartScenarioInPlace(peds, "WORLD_HUMAN_CLIPBOARD", 0, true)
	local optfoundry = {
		{
			name = 'foundry:localentity',
			event = "mining:client:setFoundry",
			icon = "fas fa-bucket",
			label = Lang:t("target.foundry"),
			canInteract = function()
				if Current.Foundry then return false else return true end
			end
		}
	}
	exports.ox_target:addLocalEntity(peds, optfoundry)
end

CreateThread(function()
	for _, v in pairs(Config.Washing) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Coords[1], v.Coords[2], v.Coords[3])
			SetBlipSprite(blip, Config.Blip.Washing.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.7)
			SetBlipColour (blip, Config.Blip.Washing.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Lang:t("blip.washing"))
			EndTextCommandSetBlipName(blip)
		end
		exports.ox_target:addBoxZone({
			coords = vec3(v.Coords[1], v.Coords[2], v.Coords[3]),
			size = vec3(v.Size[1], v.Size[2], v.Size[3]),
			rotation = v.Rotation,
			debug = false,
			options = {
				{
					name = 'wash'.._,
					event = 'mining:client:setWash',
					icon = "fas fa-hands",
					label = Lang:t("target.washing"),
					canInteract = function()
						if Current.Washing then return false else return true end
					end
				}
			}
		})
	end
	for _, v in pairs(Config.Smelting) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Coords[1], v.Coords[2], v.Coords[3])
			SetBlipSprite(blip, Config.Blip.Smelting.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.7)
			SetBlipColour(blip, Config.Blip.Smelting.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Lang:t("blip.smelting"))
			EndTextCommandSetBlipName(blip)
		end
		exports.ox_target:addBoxZone({
			coords = vec3(v.Coords[1], v.Coords[2], v.Coords[3]),
			size = vec3(v.Size[1], v.Size[2], v.Size[3]),
			rotation = v.Rotation,
			debug = false,
			options = {
				{
					name = 'smelting'.._,
					event = 'mining:client:setSmelting',
					icon = "fas fa-gem",
					label = Lang:t("target.smelting"),
					canInteract = function()
						if Current.Smelting then return false else return true end
					end
				}
			}
		})
	end
end)

RegisterNetEvent("mining:client:setWash", function()
	if QBCore.Functions.HasItem("washpan") then
		QBCore.Functions.TriggerCallback("mine:callback:getItemCount", function(result)
			if result >= Config.Settings.Washing.Input then
				exports.ox_target:disableTargeting(true)
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"))
				Wait(200)
				Current.Washing = true
				if lib.progressCircle({
					label = Lang:t("progressbar.washing"),
					duration = 10000,
					position = "bottom",
					useWhileDead = false,
					canCancel = true,
					disable = {
						car = true,
						move = true
					},
					anim = {
						scenario = "WORLD_HUMAN_BUM_WASH"
					},
				}) then
					exports.ox_target:disableTargeting(false)
					TriggerServerEvent("mine:sv:SetupItems", "others", "remove", Config.Settings.Mining.Items.Stone, Config.Settings.Washing.Input)
					TriggerServerEvent("mine:sv:SetupItems", "others", "add", Config.Settings.Washing.Items.WashedStone, Config.Settings.Washing.Input)
					Current.Washing = false
				end
			else
				QBCore.Functions.Notify(Lang:t("error.missitemscount", {amount = Config.Settings.Washing.Input - result, item = string.lower(QBCore.Shared.Items[Config.Settings.Mining.Items.Stone].label)}), "error")
			end
		end, Config.Settings.Mining.Items.Stone)
	else
		lib.requestAnimDict('mp_player_int_upper_nod')
		TaskPlayAnim(PlayerPedId(), 'mp_player_int_upper_nod', 'mp_player_int_nod_no', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
		QBCore.Functions.Notify(Lang:t("error.nowashpan"))
	end
end)

RegisterNetEvent("mining:client:setSmelting", function()
	if QBCore.Functions.HasItem(Config.Settings.Washing.Items.WashedStone) then
		QBCore.Functions.TriggerCallback("mine:callback:getItemCount", function(result)
			if not result then return end
			local max = 0
			local label = ""
			local a = 0
			if result >= Config.Settings.Smelting.MaximumInput then max = Config.Settings.Smelting.MaximumInput else max = result end
			for _, v in pairs(Config.Settings.Smelting.Reward) do
				label = label ..QBCore.Shared.Items[v.item].label
				if a ~= #Config.Settings.Smelting.Reward - 1 then label = label ..", " end
				a = a + 1
			end
			local input = lib.inputDialog("Fonte de roches", {
				{type = "input", label = Lang:t("info.minerals"), default = label, disabled = true, icon = "fas fa-martini-glass-citrus"},
				{type = "slider", label = Lang:t("info.amounttoresell"), min = 1, max = max, icon = "fas fa-martini-glass-citrus"},
			})
			if not input then return end
			if input[2] ~= nil then
				exports.ox_target:disableTargeting(true)
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"))
				Current.Smelting = true
				if lib.progressCircle({
					label = Lang:t("progressbar.smelting"),
					duration = 10000,
					position = "bottom",
					useWhileDead = false,
					canCancel = true,
					disable = {
						car = true,
						move = true
					},
					anim = {
						dict = "amb@world_human_stand_fire@male@idle_a",
						clip = "idle_a",
						flag = 16,
						duration = -1,
						blendIn = 3.0,
						blendOut = -3.0,
					},
				}) then
					exports.ox_target:disableTargeting(false)
					TriggerServerEvent("mine:sv:SetupItems", "smelting", nil, nil, input[2])
					Current.Smelting = false
				end
			end
		end, Config.Settings.Washing.Items.WashedStone)
	else
		lib.requestAnimDict('mp_player_int_upper_nod')
		TaskPlayAnim(PlayerPedId(), 'mp_player_int_upper_nod', 'mp_player_int_nod_no', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
		QBCore.Functions.Notify(Lang:t("error.notenoughwashedstone"), "error")
	end
end)

RegisterNetEvent("mining:client:setFoundry", function()
	local cfg = Config.Settings.Smelting.Reward
	local foundry = {
		id = "foundry",
		title = Lang:t("target.foundry"),
		options = {}
	}
	a = 0
	for i = 1, #cfg do
		if QBCore.Functions.HasItem(cfg[i].item) then
			a = a + 1
			foundry.options[#foundry.options + 1] = {
				title = QBCore.Shared.Items[cfg[i].item].label,
				description = Lang:t("info.itemprice", {price = cfg[i].pricetosell}),
				icon = string.format("nui://%s/html/images/%s.png", Config.Inventory.ExportName, cfg[i].item),
				onSelect = function()
					print(cfg[i].item, cfg[i].pricetosell)
					QBCore.Functions.TriggerCallback("mine:callback:getItemCount", function(result)
						local input = lib.inputDialog(QBCore.Shared.Items[cfg[i].item].label, {
							{type = "slider", label = Lang:t("info.amounttoresell"), min = 1, max = result, icon = "fas fa-bucket"},
						})
						if not input[1] then return end
						if input[1] ~= nil then
							Current.Foundry = true
							exports.ox_target:disableTargeting(true)
							if lib.progressCircle({
								label = Lang:t("progressbar.foundry", {amount = tonumber(cfg[i].pricetosell * input[1])}),
								duration = 7000,
								position = "bottom",
								canCancel = true,
								useWhileDead = false,
								disable = {
									car = true,
									move = true
								},
								anim = {
									dict = "anim@heists@heist_corona@team_idles@male_a",
									clip = "idle",
									flag = 16,
									duration = -1,
									blendIn = 3.0,
									blendOut = -3.0,
								},
							}) then
								exports.ox_target:disableTargeting(false)
								TriggerServerEvent("mine:sv:SetupItems", "others", "remove", cfg[i].item, input[1])
								TriggerServerEvent("mine:sv:UpdateCash", cfg[i], input[1])
								Current.Foundry = false
							else
								exports.ox_target:disableTargeting(false)
								Current.Foundry = false
							end
						end
					end, cfg[i].item)
				end
			}
		end
	end
	if a == 0 then
		foundry.options[#foundry.options + 1] = {
			title = Lang:t("error.noitemtoresell"),
			icon = "fas fa-circle-xmark",
		}
	end
	lib.registerContext(foundry)
	lib.showContext("foundry")
end)

RegisterNetEvent("mining:client:setMineProps", function(data)
	if QBCore.Functions.HasItem(Config.Settings.Mining.Items.Pickaxe) then
		Current.Mining = true
		exports.ox_target:disableTargeting(true)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"))
		Wait(200)
		if lib.progressCircle({
			label = Lang:t("progressbar.mining"),
			duration = 10000,
			position = "bottom",
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
				move = true
			},
			anim = {
				dict = "amb@world_human_hammering@male@base",
				clip = "base",
				flag = 31,
				duration = -1,
				blendIn = 3.0,
				blendOut = -3.0,
			},
			prop = {
				model = `prop_tool_pickaxe`,
				bone = 57005,
				pos = vec3(0.09, -0.29, -0.10),
				rot = vec3(252.0, 180.0, 0.0)
			},
		}) then 
			local amount = math.random(Config.Settings.Mining.Output.min, Config.Settings.Mining.Output.max)
			TriggerServerEvent("mine:sv:SetupItems", "others", "add", Config.Settings.Mining.Items.Stone, amount)
			Current.Mining = false
			exports.ox_target:disableTargeting(false)
			DeleteObject(data.pact)
			AmountProps = AmountProps - 1
			if AmountProps == 0 then
				SpawnMineProps()
			end
		else
			exports.ox_target:disableTargeting(false)
			Current.Mining = false
		end
	else
		lib.requestAnimDict('mp_player_int_upper_nod')
		TaskPlayAnim(PlayerPedId(), 'mp_player_int_upper_nod', 'mp_player_int_nod_no', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
		QBCore.Functions.Notify(Lang:t("error.nopickaxe"), "error")
	end
end)

--- UTILS 

function UnloadPresets()
	for _, v in pairs(Current.Mine) do
		DeleteObject(v)
	end
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
	Foundry()
	SpawnMineProps()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
	UnloadPresets()
end)

AddEventHandler("onResourceStart", function(resource)
	if GetCurrentResourceName() == resource then
		Foundry()
		SpawnMineProps()
	end
end)

AddEventHandler("onResourceStop", function(resource)
	if GetCurrentResourceName() == resource then
		UnloadPresets()
	end
end)