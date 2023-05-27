/obj/structure/interactive/vending/nanotrasen/ops/
	icon = 'icons/obj/structure/vending_new.dmi'





/obj/structure/interactive/vending/nanotrasen/ops/guns
	name = "nanotrasen special ops gun vendor"
	icon_state = "ops_guns"


	stored_types = list(

		//3 melee
		/obj/item/weapon/melee/energy/stunbaton,
		/obj/item/weapon/unarmed/powerfist,
		/obj/item/weapon/melee/energy/sword/blue,

		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw,
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi,

		//3 rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/semi,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard,
		/obj/item/weapon/ranged/energy/rifle/xray,

		//3 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/energy/iongun,
		/obj/item/weapon/ranged/bullet/magazine/rifle/advanced,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,

		//3 grenades or equipment
		/obj/item/grenade/device/large/timed/explosive_large,
		/obj/item/grenade/device/landmine/proximity/explosive,
		/obj/item/weapon/ranged/thrown/kunai

	)


/obj/structure/interactive/vending/nanotrasen/ops/ammo
	name = "nanotrasen special ops ammo vendor"
	icon_state = "ops_ammo"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm/hp,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm/ap,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm/ap,
		/obj/item/magazine/smg_pdw,
		/obj/item/magazine/smg_pdw/ap,
		/obj/item/magazine/smg_pdw/incendiary,
		/obj/item/magazine/smg_pdw/ion,
		/obj/item/magazine/smg_pdw/toxin,
		/obj/item/magazine/smg_4mm_standard,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45/ap,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556/ap,
		/obj/item/magazine/sniper_308/nato,
		/obj/item/magazine/sniper_308/nato/ap,
		/obj/item/magazine/lmg_762,
		/obj/item/magazine/sniper_127
	)




/obj/structure/interactive/vending/nanotrasen/ops/clothing
	name = "nanotrasen special ops clothing vendor"
	icon_state = "ops_clothing"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(

		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/reinforced/ntops,
		/obj/item/clothing/shirt/normal/reinforced/ntops,

		//Shoes and gloves.
		/obj/item/storage/shoebox/jackboot,
		/obj/item/storage/glovebox/padded,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen,
		/obj/item/clothing/glasses/sun/security,

		//Helmets and masks
		/obj/item/clothing/head/helmet/polymorphic/reinforced/ntops,
		/obj/item/clothing/head/hat/skimask/black,
		/obj/item/clothing/head/hat/skimask/tactical/black,
		/obj/item/clothing/mask/gas/poly/nt_ops,

		//Armor
		/obj/item/clothing/overwear/armor/molded_armor/black,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/overwear/coat/vest,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,

		//Satchel, Backpack, Duffleback.
		/obj/item/clothing/back/storage/satchel/poly/ntops,
		/obj/item/clothing/back/storage/backpack/poly/ntops,
		/obj/item/clothing/back/storage/dufflebag/poly/ntops,

		//Bonus
		/obj/item/clothing/overwear/armor/nanotrasen/nt_ops,
		/obj/item/clothing/head/helmet/full/nanotrasen/nt_ops,
		/obj/item/storage/nanotrasen_elite

	)


