/loot/misc
	//misc loot you'd find in general areas such as homes. Nothing too extreme.
	loot_table = list(
		/obj/item/analyzer/gps = 10,
		/obj/item/analyzer/health = 20,
		/obj/item/ball/soccer = 5,
		/obj/item/bikehorn = 30,
		/obj/item/broom = 20,
		/obj/item/cassette_player = 5,
		/obj/item/cassette_tape = 20,
		/obj/item/cell_charger = 5,
		/obj/item/clothing/back/storage/satchel/poly/grey = 40,
		/obj/item/clothing/back/storage/backpack/poly/grey = 30,
		/obj/item/clothing/back/storage/dufflebag/poly/grey = 10,
		/obj/item/clothing/belt/storage/colored/brown = 10,
		/obj/item/clothing/head/helmet/full/paperbag/random = 10,
		/obj/item/dice/d20 = 5,
		/obj/item/dice/d6 = 20,
		/obj/item/flare = 50,
		/obj/item/id/colonist = 40,
		/obj/item/light_sensor = 20,
		/obj/item/lighter = 30,
		/obj/item/mop = 10,
		/obj/item/plate = 30,
		/obj/item/powercell = 20,
		/obj/item/powercell/advanced = 20,
		/obj/item/powercell/tiny = 50,
		/obj/item/powercell/vehicle = 10,
		/obj/item/radio = 50,
		/obj/item/storage/box = 5,
		/obj/item/storage/emergency = 20,
		/obj/item/storage/lighting/bulb = 5,
		/obj/item/storage/lighting/tube = 5,
		/obj/item/storage/wallet/random_colonist = 20,
		/loot/medicine/kits = 5,
		/loot/medicine/misc_medicine = 10,
		/loot/misc/cigarettes = 20,
		//obj/item/paper/recipe = 25

	)

/loot/misc/cigarettes
	loot_table = list(
		/obj/item/storage/cigarettes/blue = 5,
		/obj/item/storage/cigarettes/gold = 1,
		/obj/item/storage/cigarettes/green = 5,
		/obj/item/storage/cigarettes/orange = 5,
		/obj/item/storage/cigarettes/purple = 5,
		/obj/item/storage/cigarettes/red = 5
	)

/loot/misc/dangerous
	//misc loot you'd find from dangerous and/or well-equipped citizens
	loot_table = list(
		/obj/item/attachment/barrel/suppressor = 5,
		/obj/item/weapon/ranged/reagent_ammo/flamethrower/ = 5,
		/obj/item/clothing/belt/storage/medical/filled = 5,
		/obj/item/clothing/belt/storage/tool/filled = 5,
		/obj/item/clothing/glasses/blindfold = 1,
		/obj/item/container/syringe/hypodermic/opium = 1,
		/obj/item/data_laptop = 1,
		/obj/item/defib = 5,
		/obj/item/deployable/barricade = 5,
		/obj/item/deployable/bodybag = 5,
		/obj/item/emf = 1,
		/obj/item/fertilizer = 5,
		/obj/item/handcuffs = 3,
		/obj/item/matter_cartridge = 5,
		/obj/item/storage/secure = 1,
		/loot/supply_crate/solarian = 10

)

/loot/misc/safe
	loot_table_guaranteed = list(
		/loot/random/high
	)
	loot_table = list(
		/loot/currency/dosh = 100,
		/loot/currency/gold_coin = 10,
		/loot/currency/credits = 10,
		/obj/item/coin/cursed = 1
	)
	loot_count = 3
	chance_none = 90


/loot/misc/kitchen
	loot_table = list(
		//obj/item/paper/recipe = 50,
		/loot/misc/food_drink = 25,
		/loot/misc/baking = 100,
		/obj/item/weapon/melee/sword/spoon = 10,
		/obj/item/weapon/melee/sword/fork = 10,
		/obj/item/weapon/melee/sword/chef_knife = 3,
		/obj/item/weapon/melee/sword/butcher_cleaver = 1
	)

/loot/misc/food_drink
	loot_table = list(
		/loot/misc/drink = 50,
		/loot/misc/food = 100
	)

/loot/misc/clothing
	loot_table = list(
		/loot/misc/head = 2,
		/loot/misc/coat = 4,
		/loot/misc/armor = 1,
		/loot/misc/pants = 6,
		/loot/misc/shirt = 4,
		/loot/misc/accessories = 1
	)

/loot/misc/head
	loot_table = list(
		/obj/item/clothing/mask/gas/poly/grey = 50,
		/obj/item/clothing/glasses/medical_hud = 10,
		/obj/item/clothing/glasses/medical_hud/advanced = 5,
		/obj/item/clothing/glasses/sun = 20,
		/obj/item/clothing/head/hat/bandana/red = 20,
		/obj/item/clothing/head/hat/beret/armored/syndicate = 10,
		/obj/item/clothing/head/hat/headband/dark_grey = 5,
		/obj/item/clothing/head/hat/skimask/black = 5,
		/obj/item/clothing/head/helmet/polymorphic/space_military = 5,
		/obj/item/clothing/head/helmet/welding = 20,
		/obj/item/clothing/mask/clown = 10,
		/obj/item/clothing/mask/gas/tactical = 5,
		/obj/item/clothing/head/hat/beaver = 5,
		/obj/item/clothing/head/hat/beret/red = 5,
		/obj/item/clothing/head/hat/chef = 5,
	)

/loot/misc/coat
	loot_table = list(
		/obj/item/clothing/overwear/coat/hoodie/grey = 50,
		/obj/item/clothing/overwear/coat/hoodie/black = 25,
		/obj/item/clothing/overwear/coat/vest/sleeveless_leather_jacket = 10,
		/obj/item/clothing/overwear/coat/vest/colored/black = 5,
		/obj/item/clothing/overwear/coat/trench = 10,
		/obj/item/clothing/overwear/coat/apron = 5,
		/obj/item/clothing/overwear/coat/blazer_blue = 5,
		/obj/item/clothing/overwear/coat/brown = 5,
		/obj/item/clothing/overwear/coat/holster = 1,
		/obj/item/clothing/overwear/coat/labcoat = 10,
		/obj/item/clothing/overwear/coat/winter/bomber = 5,
		/obj/item/clothing/overwear/coat/winter = 10,

	)

/loot/misc/armor
	loot_table = list(
		/obj/item/clothing/overwear/armor/shit_armor = 100,
		/obj/item/clothing/overwear/armor/bulletproof = 50,
		/obj/item/clothing/overwear/armor/medium_armor/black = 20,

	)

/loot/misc/pants
	loot_table = list(
		/obj/item/clothing/pants/brown = 50,
		/obj/item/clothing/pants/normal/grey = 50,
		/obj/item/clothing/pants/normal/black = 25,
		/obj/item/clothing/pants/normal/striped = 10,
		/obj/item/clothing/pants/shorts/brown = 20,
		/obj/item/clothing/pants/shorts/red_soccer = 5,
		/obj/item/clothing/pants/shorts/blue_soccer = 5,
		/obj/item/clothing/pants/shorts/ref_soccer = 5,
	)

/loot/misc/shirt
	loot_table = list(
		/obj/item/clothing/shirt/normal = 50,
		/obj/item/clothing/shirt/normal/grey = 50,
		/obj/item/clothing/shirt/normal/random = 20,
		/obj/item/clothing/shirt/suit/red = 5,
		/obj/item/clothing/shirt/suit/black = 5,
		/obj/item/clothing/shirt/suit/brown = 5,
		/obj/item/clothing/shirt/suit/green = 5,
		/obj/item/clothing/shirt/suit/pinstripe = 5,
		/obj/item/clothing/undertop/underwear/shirt = 40,
		/obj/item/clothing/undertop/underwear/shirt/black = 20,
		/obj/item/clothing/undertop/underwear/shirt/random = 10
	)


/loot/misc/accessories
	loot_table = list(
		/obj/item/clothing/neck/tie = 30,
		/obj/item/clothing/neck/tie/black = 30,
		/obj/item/clothing/neck/tie/red = 30,
		/loot/rings/minor = 10
	)

/loot/misc/food
	loot_table = list(
		/obj/item/container/edible/package/junkfood/candy = 10,
		/obj/item/container/edible/package/junkfood/cheese_chips = 5,
		/obj/item/container/edible/package/junkfood/chips = 20,
		/obj/item/container/edible/package/junkfood/jerky = 10,
		/obj/item/container/edible/package/junkfood/raisins = 5,
		/obj/item/container/edible/package/junkfood/syndicate = 1,
		/obj/item/container/edible/package/junkfood/cake = 1,
		/obj/item/container/edible/package/junkfood/halloween/candy_bar = 1,
		/obj/item/container/edible/package/junkfood/halloween/coconut_joy = 1,
		/obj/item/container/edible/package/junkfood/halloween/credit = 1,
		/obj/item/container/edible/package/junkfood/halloween/hurr_bar = 1,
		/obj/item/container/edible/package/junkfood/halloween/kit_catgirl_metaclique_bar = 1,
		/obj/item/container/edible/package/junkfood/halloween/malf_way = 1,
		/obj/item/container/edible/package/junkfood/halloween/triggerfinger = 1,
		/obj/item/container/edible/package/junkfood/halloween/twink_bar = 1,

		/obj/item/container/spray/ketchup = 1,
		/obj/item/container/spray/mustard = 1
	)

/loot/misc/drink
	loot_table = list(
		/obj/item/container/simple/alcohol/absinthe = 10,
		/obj/item/container/simple/alcohol/ale = 50,
		/obj/item/container/simple/alcohol/beer = 100,
		/obj/item/container/simple/alcohol/brandy = 20,
		/obj/item/container/simple/alcohol/cider = 10,
		/obj/item/container/simple/alcohol/coffee_liqueur = 20,
		/obj/item/container/simple/alcohol/fernet = 5,
		/obj/item/container/simple/alcohol/gin = 10,
		/obj/item/container/simple/alcohol/grappa = 5,
		/obj/item/container/simple/alcohol/hearty_punch = 5,
		/obj/item/container/simple/alcohol/nothing = 10,
		/obj/item/container/simple/alcohol/rum = 50,
		/obj/item/container/simple/alcohol/schnapps/gold = 10,
		/obj/item/container/simple/alcohol/tequila = 10,
		/obj/item/container/simple/alcohol/vodka = 75,
		/obj/item/container/simple/alcohol/whiskey = 75,
		/obj/item/container/simple/alcohol/wine = 75,
		/obj/item/container/simple/alcohol/wine/vermouth = 50,

		/obj/item/container/simple/can/coffee/freedomno = 100,
		/obj/item/container/simple/can/coffee/black = 100,
		/obj/item/container/simple/can/coffee/latte = 200,
		/obj/item/container/simple/can/cola = 200,
		/obj/item/container/simple/can/dr_gibb = 100,
		/obj/item/container/simple/can/grape_soda = 50,
		/obj/item/container/simple/can/grey_bull = 10,
		/obj/item/container/simple/can/iced_tea = 25,
		/obj/item/container/simple/can/mountain_wind = 50,
		/obj/item/container/simple/can/orange_soda = 25,
		/obj/item/container/simple/can/space_up = 25,
	)

/loot/misc/baking
	loot_table = list(
		/obj/item/container/simple/baking/flour = 200,
		/obj/item/container/simple/baking/sugar = 50,
		/obj/item/container/simple/baking/corn_flour = 25,
		/obj/item/container/simple/baking/cream = 25,
		/obj/item/container/simple/baking/milk = 50,
		/obj/item/storage/egg_carton = 20,
	)

/loot/misc/ashwalker //Stuff found in ashwalker camps
	loot_table = list(
		/loot/currency/gold_coin = 100,
		/loot/random/scroll = 5,
		/loot/random/tempering = 5,
		/loot/soulgem = 50,
		/loot/soulgem/filled = 10,
		/loot/supply_crate/all = 5,
		//obj/item/paper/recipe = 10,
		/obj/item/bullet_cartridge/arrow/ashen{amount=5} = 70,
		/obj/item/clothing/belt/belt_quiver = 30,
		/obj/item/cannonball = 5,
		/obj/item/cannon_fuse = 5,
		/obj/item/coin/cursed = 1,
		/obj/item/cross = 1,
		/obj/item/legion_core = 20,
		/obj/item/portal_scroll = 30,
		/obj/item/soapstone/green = 1
	)


	chance_none = 20
	loot_count = 1