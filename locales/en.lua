local L = {
	progressbar = {
		mining = 'Mining..',
		washing = 'Washing..',
		smelting = 'Smelting..',
		foundry = "Selling items for %{amount}$.."
	},
	error = {
		nopickaxe = "You don't have a pickaxe.",
		nowashpan = "You don't have a washpan.",
		notenoughstone = "You need %{amountstone} stones to wash",
		notenoughwashedstone = "You don't have washed stones",
		noitemtoresell = "You have no items to resell at the foundry",
		donthaveitem = "You don't have the required item (%{itemneeded})",
		missitemscount = "You need %{amount}x %{item} more"
	},
	info = {
		itemprice = "Price: %{price}$",
		amounttoresell = "Desired amount",
		minerals = "Minerals"
	},
	target = {
		mining = "Mine",
		washing = "Wash",
		smelting = "Smelt",
		foundry = "Foundry"
	},
	blip = {
		mining = "Mining spot",
		washing = "Washing spot",
		smelting = "Foundry spot"
	}
}

Lang = Locale:new({
  phrases = L,
  warnOnMissing = true
})