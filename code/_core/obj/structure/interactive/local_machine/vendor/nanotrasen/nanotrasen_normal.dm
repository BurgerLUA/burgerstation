/obj/structure/interactive/vending/nanotrasen/normal
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/normal/clothing
	name = "nanotrasen wardrobe vendor"
	icon_state = "regular_clothing"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/striped/nanotrasen,
		/obj/item/clothing/shirt/normal/uniform/nanotrasen,

		//Shoes and gloves.
		/obj/item/storage/shoebox/jackboot/,
		/obj/item/storage/glovebox/padded/,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen,
		/obj/item/clothing/glasses/sun/security,

		//Helmets and masks
		/obj/item/clothing/head/helmet/polymorphic/nanotrasen,
		/obj/item/clothing/mask/gas/poly/nanotrasen,

		//Armor
		/obj/item/clothing/overwear/armor/medium_armor/black,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,

		//Satchel, Backpack, Duffleback.
		/obj/item/clothing/back/storage/satchel/poly/nanotrasen,
		/obj/item/clothing/back/storage/dufflebag/poly/nanotrasen,
		/obj/item/clothing/back/storage/backpack/poly/nanotrasen,

		//Bonus
		/obj/item/clothing/overwear/armor/nanotrasen,
		/obj/item/clothing/head/helmet/full/nanotrasen,

	)

/obj/structure/interactive/vending/nanotrasen/normal/guns

	name = "nanotrasen gun vendor"
	icon_state = "regular_guns"


	stored_types = list(
		//4 melee
		/obj/item/weapon/unarmed/powerfist,
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/weapon/melee/energy/stunbaton,
		/obj/item/weapon/melee/sword/sabre,

		//4 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/revolver/defender,
		/obj/item/weapon/ranged/energy/hybrid/carbine/small,

		//4 smgs or shotguns.
		/obj/item/weapon/ranged/energy/hybrid/carbine,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical,
		/obj/item/weapon/ranged/bullet/pump/shotgun/nt,
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw,

		//4 assault rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/semi,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,
		/obj/item/weapon/ranged/energy/rifle,

		//4 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/energy/freezegun,
		/obj/item/weapon/ranged/bullet/magazine/rifle/service,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,

		//4 grenades or equipment
		/obj/item/grenade/device/timed/explosive,
		/obj/item/grenade/device/landmine/proximity/explosive,
		/obj/item/grenade/device/timed/incendiary,
		/obj/item/grenade/device/timed/emp

	)

/obj/structure/interactive/vending/nanotrasen/normal/ammo

	name = "nanotrasen gun vendor"
	icon_state = "regular_ammo"

	stored_types = list(
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm/hp,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm/ap,
		/obj/item/magazine/clip/revolver/bullet_38,
		/obj/item/magazine/smg_9mm,
		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,
		/obj/item/magazine/smg_pdw,
		/obj/item/magazine/smg_pdw/ap,
		/obj/item/magazine/smg_pdw/incendiary,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556/ap,
		/obj/item/magazine/lmg_556,
		/obj/item/magazine/sniper_308/nato,
		/obj/item/magazine/sniper_308/nato/ap,
		/obj/item/magazine/sniper_127
	)