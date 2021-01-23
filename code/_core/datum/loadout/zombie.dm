/loadout/zombie/
	var/list/possible_extra_clothing = list() //pickweight
	var/list/possible_extra_weapon = list()

	var/extra_weapon_chance = 0
	var/extra_clothing_chance = 0



/loadout/zombie/get_spawning_items()

	. = ..()

	if(prob(extra_weapon_chance))
		. += pickweight(possible_extra_weapon)

	if(prob(extra_clothing_chance))
		. += pickweight(possible_extra_clothing)

	return .

/loadout/zombie/winter
	spawning_items = list(
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/overwear/coat/winter,
		/obj/item/clothing/feet/shoes/winter,
		/obj/item/clothing/feet/shoes/winter/left
	)

/loadout/zombie/desert
	spawning_items = list(
		/obj/item/clothing/mask/mummy,
		/obj/item/clothing/uniform/mummy
	)


/loadout/zombie/greytide

	spawning_items = list(
		/obj/item/clothing/feet/shoes/colored/black,
		/obj/item/clothing/feet/shoes/colored/black/left,
		/obj/item/clothing/shirt/normal/grey,
		/obj/item/clothing/pants/normal/grey
	)

	extra_weapon_chance = 5
	extra_clothing_chance = 5

	possible_extra_clothing = list(
		/obj/item/clothing/mask/gas = 1,
		/obj/item/clothing/overwear/coat/hoodie = 1,
		/obj/item/clothing/overwear/armor/shit_armor = 2
	)

	possible_extra_weapon = list(
		/obj/item/weapon/melee/toolbox/blue = 1,
		/obj/item/weapon/melee/toolbox/green = 1,
		/obj/item/weapon/melee/toolbox/red = 1,
		/obj/item/weapon/melee/toolbox/yellow = 1,
		/obj/item/weapon/melee/spear = 1,
		/obj/item/weapon/melee/tool/crowbar/red = 4
	)


/loadout/zombie/security

	spawning_items = list(
		/obj/item/clothing/pants/normal/security/ancient,
		/obj/item/clothing/shirt/normal/security/ancient,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/armor/bulletproof,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left
	)

	possible_extra_weapon = list(
		/obj/item/weapon/melee/energy/stunbaton = 10,
		/obj/item/weapon/ranged/energy/hybrid/carbine = 5
	)

	possible_extra_clothing = list(
		/obj/item/clothing/head/helmet/security/old = 10,
		/obj/item/clothing/head/hat/beret/armored/syndicate = 5,
		/obj/item/clothing/glasses/sun/security/red = 2
	)

	extra_clothing_chance = 75
	extra_weapon_chance = 25


/loadout/zombie/botanist

	spawning_items = list(
		/obj/item/clothing/shirt/normal/uniform/botanty,
		/obj/item/clothing/pants/normal/botany,
		/obj/item/clothing/overwear/coat/apron/blue,
		/obj/item/clothing/hands/gloves/colored/padded/brown,
		/obj/item/clothing/hands/gloves/colored/padded/brown/left,
		/obj/item/clothing/feet/shoes/colored/black,
		/obj/item/clothing/feet/shoes/colored/black/left,
	)

	extra_weapon_chance = 10
	extra_clothing_chance = 0

	possible_extra_weapon = list(
		/obj/item/weapon/melee/energy/chainsaw/ = 1
	)

/loadout/zombie/chaplain

	spawning_items = list(
		/obj/item/clothing/uniform/priest,
		/obj/item/clothing/overwear/coat/chaplain,
		/obj/item/clothing/feet/shoes/colored/black,
		/obj/item/clothing/feet/shoes/colored/black/left
	)

	possible_extra_weapon = list(
		/obj/item/weapon/melee/null_rod = 1,
		/obj/item/weapon/melee/null_rod/dagger = 1,
		/obj/item/weapon/melee/null_rod/staff = 1,
		/obj/item/weapon/ranged/magic/tome/lightning = 1
	)

	extra_weapon_chance = 50
	extra_clothing_chance = 0

/loadout/zombie/captain

	spawning_items = list(
		/obj/item/clothing/uniform/captain,
		/obj/item/clothing/head/hat/captain,
		/obj/item/clothing/hands/gloves/captain,
		/obj/item/clothing/hands/gloves/captain/left,
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/feet/shoes/colored/brown,
		/obj/item/clothing/feet/shoes/colored/brown/left
	)

	possible_extra_weapon = list(
		/obj/item/weapon/melee/sword/sabre = 5,
		/obj/item/weapon/ranged/energy/captain = 1
	)

	extra_weapon_chance = 100
	extra_clothing_chance = 0

/loadout/zombie/librarian

	spawning_items = list(
		/obj/item/clothing/shirt/suit/red,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/neck/miner_talisman,
		/obj/item/clothing/glasses/prescription,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left
	)

	possible_extra_weapon = list(
		/obj/item/weapon/ranged/magic/tome/missile = 1,
		/obj/item/weapon/ranged/magic/tome/chaos = 1,
		/obj/item/weapon/ranged/magic/tome/ice = 1
	)

	extra_weapon_chance = 90
	extra_clothing_chance = 0

/loadout/zombie/scientist

	spawning_items = list(
		/obj/item/clothing/feet/shoes/colored,
		/obj/item/clothing/feet/shoes/colored/left,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/shirt/normal/medical,
		/obj/item/clothing/neck/tie/red,
		/obj/item/clothing/overwear/coat/labcoat/science
	)

	possible_extra_clothing = list(
		/obj/item/clothing/glasses/prescription = 3,
		/obj/item/clothing/glasses/prescription/blue = 3,
		/obj/item/clothing/glasses/medical_hud = 1,
		/obj/item/clothing/head/hat/beret = 1
	)

	possible_extra_weapon = list()

	extra_weapon_chance = 0
	extra_clothing_chance = 50


/loadout/zombie/clown
	spawning_items = list(
		/obj/item/clothing/uniform/clown,
		/obj/item/clothing/feet/shoes/clown,
		/obj/item/clothing/feet/shoes/clown/left,
		/obj/item/clothing/hands/gloves/colored,
		/obj/item/clothing/hands/gloves/colored/left
	)

	possible_extra_clothing = list(
		/obj/item/clothing/mask/gas/clown = 1
	)

	possible_extra_weapon = list(
		/obj/item/bikehorn = 3,
		/obj/item/container/pill/space_drugs = 1,
		/obj/item/container/pill/space_dust = 1

	)

	extra_weapon_chance = 40
	extra_clothing_chance = 85

/loadout/zombie/medical
	spawning_items = list(
		/obj/item/clothing/overwear/coat/labcoat/medical,
		/obj/item/clothing/underbottom/underwear/boxers/medical,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/normal/medical,
		/obj/item/clothing/feet/shoes/colored,
		/obj/item/clothing/feet/shoes/colored/left,
		/obj/item/clothing/hands/gloves/colored,
		/obj/item/clothing/hands/gloves/colored/left
	)

	possible_extra_clothing = list(
		/obj/item/clothing/neck/tie/red = 1,
		/obj/item/clothing/overwear/coat/labcoat/medical = 4,
		/obj/item/clothing/glasses/prescription = 1,
	)

	possible_extra_weapon = list(
		/obj/item/storage/kit/brute/filled = 1,
		/obj/item/storage/kit/burn/filled = 1,
		/obj/item/storage/kit/toxin/filled = 1,
		/obj/item/storage/kit/brute/filled = 1
	)

	extra_weapon_chance = 30
	extra_clothing_chance = 85

/loadout/zombie/chemist
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/uniform/chemist,
		/obj/item/clothing/overwear/coat/labcoat/chemist,
		/obj/item/clothing/feet/shoes/colored,
		/obj/item/clothing/feet/shoes/colored/left,
		/obj/item/clothing/hands/gloves/colored,
		/obj/item/clothing/hands/gloves/colored/left,
		/obj/item/clothing/neck/tie/red
	)

	possible_extra_clothing = list(
		/obj/item/clothing/mask/gas = 3,
		/obj/item/clothing/glasses/prescription = 1,
	)

	possible_extra_weapon = list(
				/obj/item/container/syringe = 1,
				/obj/item/container/beaker = 1,
				/obj/item/storage/pillbottle/iron_small = 2,
				/obj/item/storage/pillbottle/antihol_small = 1,
	)

	extra_weapon_chance = 40
	extra_clothing_chance = 85

/loadout/zombie/bartender
	spawning_items = list(
		/obj/item/clothing/feet/shoes/colored/black,
		/obj/item/clothing/feet/shoes/colored/black/left,
		/obj/item/clothing/neck/tie/red,
		/obj/item/clothing/pants/normal/security,
		/obj/item/clothing/shirt/normal
	)

	possible_extra_clothing = list(
		/obj/item/clothing/glasses/sun = 1
	)

	possible_extra_weapon = list(
		/obj/item/container/beaker/alcohol/whiskey = 3,
		/obj/item/container/beaker/alcohol/beer = 4,
		/obj/item/container/beaker/glass = 1,
		/obj/item/container/beaker/shot = 1
	)

	extra_weapon_chance = 50
	extra_clothing_chance = 85

/loadout/zombie/chef
	spawning_items = list(
		/obj/item/clothing/feet/shoes/colored/black,
		/obj/item/clothing/feet/shoes/colored/black/left,
		/obj/item/clothing/pants/normal/security,
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/overwear/coat/apron/chef
	)

	possible_extra_clothing = list(
		/obj/item/clothing/head/hat/chef = 1
	)

	possible_extra_weapon = list(
		/obj/item/weapon/melee/sword/sabre = 5,
		/obj/item/container/beaker/food/sugar = 1,
		/obj/item/container/beaker/bottle/large/water = 1
	)

	extra_weapon_chance = 80
	extra_clothing_chance = 75