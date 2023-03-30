/obj/structure/interactive/vending/nanotrasen/science/
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/science/clothing
	name = "science clothing vendor"
	icon_state = "science_clothing"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/striped/scientist,
		/obj/item/clothing/shirt/normal/uniform/science,

		//Shoes and gloves.
		/obj/item/storage/shoebox/colored,
		/obj/item/storage/glovebox/white,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen,
		/obj/item/clothing/glasses/science,

		//Helmets and masks
		/obj/item/clothing/head/hat/beret/science,
		/obj/item/clothing/head/helmet/polymorphic/science,
		/obj/item/clothing/mask/gas/poly/science,

		//Armor
		/obj/item/clothing/overwear/armor/medium_armor/black,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,

		//Satchel, Backpack, Duffleback.
		/obj/item/clothing/back/storage/satchel/poly/science,
		/obj/item/clothing/back/storage/dufflebag/poly/science,
		/obj/item/clothing/back/storage/backpack/poly/science,

		//Bonus
		/obj/item/clothing/overwear/armor/nanotrasen/science,
		/obj/item/clothing/head/helmet/full/nanotrasen/science,


	)

/obj/structure/interactive/vending/nanotrasen/science/guns
	name = "science gun vendor"
	icon_state = "science_guns"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//3 melee
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/weapon/unarmed/powerfist,
		/obj/item/weapon/melee/tool/crowbar/red,

		//3 pistols
		/obj/item/weapon/ranged/energy/hybrid/carbine/small,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen,
		/obj/item/weapon/ranged/bullet/revolver/defender,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw,
		/obj/item/weapon/ranged/energy/hybrid/carbine,
		/obj/item/weapon/ranged/bullet/pump/shotgun/tech,

		//3 assault rifles
		/obj/item/weapon/ranged/energy/rifle,
		/obj/item/weapon/ranged/energy/rifle/hardlight,
		/obj/item/weapon/ranged/energy/rifle/xray,

		//3 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/energy/iongun,
		/obj/item/weapon/ranged/energy/freezegun,

		//3 grenades or equipment
		/obj/item/grenade/timed/decoy,
		/obj/item/grenade/timed/incendiary,
		/obj/item/grenade/timed/emp

	)

/obj/structure/interactive/vending/nanotrasen/science/ammo
	name = "science gun vendor"
	icon_state = "science_ammo"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/cell_charger,
		/obj/item/powercell/tiny,
		/obj/item/powercell,
		/obj/item/powercell/advanced,
		/obj/item/powercell/industrial,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm/hp,
		/obj/item/magazine/smg_pdw,
		/obj/item/magazine/smg_pdw/ap,
		/obj/item/magazine/smg_pdw/incendiary,
		/obj/item/magazine/smg_pdw/ion,
		/obj/item/magazine/smg_pdw/toxin,
		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,
		/obj/item/bulletbox/small/shotgun_12/techshot
	)