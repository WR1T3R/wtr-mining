-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Config = {}

Config.Currency = "bank"
Config.Inventory = {ExportName = "qb-inventory", MaxWeight = 250000}
Config.Blip = {
	Mining = {
		Sprite = 365,
		Color = 5
	},
	Washing = {
		Sprite = 365,
		Color = 5
	},
	Smelting = {
		Sprite = 365,
		Color = 5
	}
}

Config.Ped = {
	Coords = vector4(1109.92, -2008.22, 30.06, 65.33),
	Model = "csb_agent",
}

Config.Mining = {
	Props = "prop_rock_3_a",
	Places = {
		[1] = {Coords = vector4(2941.26, 2844.94, 47.77, 210.65), Blip = true},
		[2] = {Coords = vector4(2946.27, 2846.16, 47.47, 189.91), Blip = true},
		[3] = {Coords = vector4(2951.14, 2846.16, 46.94, 349.04), Blip = true},
		[4] = {Coords = vector4(2955.42, 2845.11, 46.52, 257.2), Blip = true},
		[5] = {Coords = vector4(2960.66, 2842.03, 45.78, 227.88), Blip = true},
		[6] = {Coords = vector4(2963.86, 2838.87, 45.14, 219.86), Blip = true},
		[7] = {Coords = vector4(2967.35, 2834.42, 44.54, 216.24), Blip = true},
		[8] = {Coords = vector4(2971.5, 2828.31, 44.15, 212.97), Blip = true},
		[9] = {Coords = vector4(2974.81, 2823.13, 44.11, 211.58), Blip = true},
		[10] = {Coords = vector4(2979.69, 2815.92, 44.07, 214.61), Blip = true}
	}
}

Config.Washing = {
	[1] = {Coords = {1967.9, 555.65, 160.85}, Size = {1.8, 0.45, 1.65}, Rotation = 0.0, Blip = true},
	[2] = {Coords = {1965.95, 556.5, 161.0}, Size = {1.8, 0.5, 2.0}, Rotation = 0.0, Blip = true}
}

Config.Smelting = {
	[1] = {Coords = {1086.3, -2003.65, 30.0}, Size = {4.0, 2.9, 4.0}, Rotation = 47.75, Blip = true}
}

Config.Settings = {
	Mining = {
		Items = {Pickaxe = "pickaxe", Stone = "stone"},
		Output = {min = 1, max = 5}
	},
	Washing = {
		Items = {Washpan = "washpan", WashedStone = "washed_stone"},
		Input = 10,
	},
	Smelting = {
		MaximumInput = 1000,
		Reward = {
			[1] = {item = 'ruby', chance = 10, amount = {min = 2, max = 3}, pricetosell = 670},
			[2] = {item = 'gold', chance = 25, amount = {min = 2, max = 4}, pricetosell = 500},
			[3] = {item = 'silver', chance = 25, amount = {min = 2, max = 4}, pricetosell = 300},
			[4] = {item = 'copper', chance = 50, amount = {min = 2, max = 5}, pricetosell = 200},
			[5] = {item = 'iron_ore', chance = 100, amount = {min = 2, max = 10}, pricetosell = 100},
		}
	}
}

