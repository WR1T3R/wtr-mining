## Dependencies
1. qb-core
2. qb-inventory
3. ox_lib
4. ox_target

## Installation

1. Go to your qb-inventory/html/images and add the images from images folder

2. Go to your qb-inventory/shared/items.lua and add this:

```lua
	['pickaxe'] 			 		 	 = {['name'] = 'pickaxe', 							 ['label'] = 'Pickaxe', 					['weight'] = 2000,   ['type'] = 'item',   ['image'] = 'pickaxe.png', 					['unique'] = true,  ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['washpan'] 						 = {['name'] = 'washpan', 							 ['label'] = 'Washpan', 					['weight'] = 800, 	 ['type'] = 'item',   ['image'] = 'washpan.png', 					['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['stone'] 						 	 = {['name'] = 'stone', 							 ['label'] = 'Stone', 						['weight'] = 1500, 	 ['type'] = 'item',   ['image'] = 'stone.png', 						['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['washed_stone'] 					 = {['name'] = 'washed_stone', 						 ['label'] = 'Washed stone', 				['weight'] = 1500, 	 ['type'] = 'item',   ['image'] = 'washed_stone.png', 				['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['ruby'] 							 = {['name'] = 'ruby', 							     ['label'] = 'Ruby', 						['weight'] = 1000, 	 ['type'] = 'item',   ['image'] = 'ruby.png', 						['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['gold'] 						 	 = {['name'] = 'gold', 							     ['label'] = 'Gold', 						['weight'] = 1500, 	 ['type'] = 'item',   ['image'] = 'gold.png', 						['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['silver'] 		 					 = {['name'] = 'silver', 							 ['label'] = 'Silver', 						['weight'] = 500, 	 ['type'] = 'item',   ['image'] = 'silver.png', 					['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['copper'] 							 = {['name'] = 'copper', 							 ['label'] = 'Copper', 						['weight'] = 500, 	 ['type'] = 'item',   ['image'] = 'copper.png', 					['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
	['iron_ore'] 						 = {['name'] = 'iron_ore', 							 ['label'] = 'Iron', 						['weight'] = 500, 	 ['type'] = 'item',   ['image'] = 'iron_ore.png', 					['unique'] = false, ['useable'] = true,  ['shouldClose'] = true,  ['combinable'] = nil, ['description'] = ''},
```