#define SLAVIC_DEFAULT /obj/item/clothing/pants/gorka, /obj/item/clothing/shirt/gorka, /obj/item/clothing/head/hat/skimask/black, /obj/item/clothing/hands/gloves/colored/padded/black, /obj/item/clothing/hands/gloves/colored/padded/black/left, /obj/item/clothing/feet/shoes/black_boots, /obj/item/clothing/feet/shoes/black_boots/left, /obj/item/clothing/belt/storage/colored/black, /obj/item/storage/pouch/double/brown, /obj/item/storage/pouch/single/brown, /loot/revolutionary/back_storage

/loadout/slavic
	spawning_items = list(
		SLAVIC_DEFAULT
	)

	var/quality_min = 30
	var/quality_max = 60


/loadout/slavic/pre_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn

	. = ..()

	if(I.quality != -1)
		I.quality = rand(quality_min,quality_max)

	else if(is_magazine(I)) //Force surplus ammo.
		var/obj/item/magazine/M = I
		if(M.ammo_surplus)
			M.ammo = M.ammo_surplus

/loadout/slavic/on_add(var/mob/living/advanced/A,var/obj/item/I) //added after initialize and spawn

	. = ..()

	if(is_magazine(I)) //Makes it work again with ammo restockers.
		var/obj/item/magazine/M = I
		if(M.ammo_surplus)
			M.ammo = initial(M.ammo)


/loadout/slavic/infantry

	spawning_items = list(
		SLAVIC_DEFAULT,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak47,
		/obj/item/magazine/rifle_762_short/,
		/obj/item/magazine/rifle_762_short,
		/obj/item/magazine/rifle_762_short,
		/obj/item/magazine/rifle_762_short,

		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/slavic,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,

		/obj/item/weapon/melee/sword/rev_bayonet
	)

/loadout/slavic/sniper

	spawning_items = list(
		SLAVIC_DEFAULT,

		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/magazine/rifle_939,
		/obj/item/magazine/rifle_939,
		/obj/item/magazine/rifle_939,
		/obj/item/magazine/rifle_939,

		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/slavic,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,

		/obj/item/weapon/melee/sword/rev_bayonet
	)


/loadout/slavic/heavy

	quality_min = 60
	quality_max = 70

	spawning_items = list(
		SLAVIC_DEFAULT,

		/obj/item/clothing/head/helmet/slavticool,
		/obj/item/clothing/overwear/armor/slavticool,

		/obj/item/weapon/ranged/bullet/magazine/rifle/pkm,
		/obj/item/magazine/lmg_762_r,
		/obj/item/magazine/lmg_762_r,
		/obj/item/magazine/lmg_762_r,


		/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,

		/obj/item/weapon/melee/sword/rev_bayonet
	)

/loadout/slavic/infantry/advanced

	quality_min = 60
	quality_max = 70

	spawning_items = list(
		SLAVIC_DEFAULT,
		/obj/item/clothing/head/helmet/slavticool,
		/obj/item/clothing/overwear/armor/slavticool,

		/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,

		/obj/item/grenade/fuse/he,

		/obj/item/weapon/melee/sword/rev_bayonet
	)

	var/list/possible_guns = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/an94,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza/equipped,
		/obj/item/weapon/ranged/bullet/magazine/rifle/val,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_20
	)

	var/list/possible_guns_to_magazine = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/an94 = /obj/item/magazine/rifle_939,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza/equipped = /obj/item/magazine/rifle_939,
		/obj/item/weapon/ranged/bullet/magazine/rifle/val = /obj/item/magazine/rifle_939,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_20 = /obj/item/magazine/shotgun_auto,
		/obj/item/weapon/ranged/bullet/magazine/smg/bizon = /obj/item/magazine/bizon_9mm
	)

	var/list/possible_masks = list(
		/obj/item/clothing/mask/gas/tactical,
		/obj/item/clothing/mask/gas/mercenary,
		/obj/item/clothing/mask/gas/glass,
	)

	var/mask_chance = 20

/loadout/slavic/infantry/advanced/get_spawning_items()
	. = list()
	var/obj/item/chosen_gun = pick(possible_guns)
	. += chosen_gun
	if(possible_guns_to_magazine[chosen_gun])
		for(var/i=1,i<=rand(4,5),i++)
			. += possible_guns_to_magazine[chosen_gun]
	if(prob(mask_chance))
		. += pick(possible_masks)
	. = ..()

/loadout/slavic/sniper/advanced

	quality_min = 60
	quality_max = 70

	spawning_items = list(
		SLAVIC_DEFAULT,
		/obj/item/clothing/overwear/armor/seva,

		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun,
		/obj/item/magazine/gauss_gun,
		/obj/item/magazine/gauss_gun,
		/obj/item/magazine/gauss_gun,
		/obj/item/magazine/gauss_gun,

		/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,

		/obj/item/weapon/melee/sword/rev_bayonet
	)


/loadout/slavic/commander

	quality_min = 100
	quality_max = 120

	spawning_items = list(

		/obj/item/clothing/pants/gorka,
		/obj/item/clothing/shirt/gorka,

		/obj/item/clothing/feet/shoes/winter,
		/obj/item/clothing/feet/shoes/winter/left,

		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,

		/obj/item/clothing/belt/storage/colored/black,

		/obj/item/clothing/overwear/armor/slavticool,
		/obj/item/clothing/overwear/coat/hos/revfficer,

		/obj/item/clothing/head/hat/ushanka,
		/obj/item/clothing/glasses/eyepatch,

		/obj/item/weapon/ranged/bullet/pump/gm94,

		/obj/item/weapon/ranged/bullet/pump/shotgun/ks23,
		/obj/item/bullet_cartridge/shotgun_23{amount=4},
		/obj/item/bullet_cartridge/shotgun_23{amount=4},

		/obj/item/weapon/ranged/bullet/revolver/nagant,
		/obj/item/bullet_cartridge/revolver_762{amount=7},
		/obj/item/bullet_cartridge/revolver_762{amount=7},

		/obj/item/grenade/fuse/he,
		/obj/item/grenade/fuse/he,

		/obj/item/weapon/melee/sword/rev_bayonet

	)