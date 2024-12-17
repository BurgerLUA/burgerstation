/loadout/blood_fiend

	spawning_items = list(

		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,

		/obj/item/clothing/pants/normal/priest,
		/obj/item/clothing/shirt/normal/priest,

		/obj/item/clothing/head/hat/tricorn,
		/obj/item/clothing/neck/neck_wrap,
		/obj/item/clothing/overwear/coat/trench,

		/obj/item/clothing/belt/storage/colored/brown,
		/obj/item/clothing/back/storage/satchel,

		/loot/rings/minor,
		/loot/rings/moderate,
		/loot/rings/major,
		/loot/rings/horseman,

		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/triple/black,

	)

	var/list/possible_weapons = list(
		/obj/item/weapon/melee/sword/uncoiled,
		/obj/item/weapon/melee/sword/csaw,
		/obj/item/weapon/melee/sword/cblade
	)

	var/list/thegun = list(
		/obj/item/weapon/ranged/bullet/revolver/fiendish,
		/obj/item/bullet_cartridge/pistol_45{amount=6},
		/obj/item/bullet_cartridge/pistol_45{amount=6},
		/obj/item/bullet_cartridge/pistol_45{amount=6},
	)

/loadout/blood_fiend/get_spawning_items()

	. = ..()

	if(length(possible_weapons))
		. += pickweight(possible_weapons)

	if(length(thegun))
		. += thegun