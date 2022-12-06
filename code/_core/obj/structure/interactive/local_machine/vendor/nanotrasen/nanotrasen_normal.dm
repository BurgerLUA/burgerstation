/obj/structure/interactive/vending/nanotrasen/wardrobe
	name = "security wardrobe vendor"
	icon_state = "secdrobe_new"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/underbottom/underwear/boxers/nanotrasen,
		/obj/item/clothing/undertop/underwear/shirt/black,
		/obj/item/clothing/pants/normal/striped/nanotrasen,
		/obj/item/clothing/shirt/normal/uniform/nanotrasen,
		/obj/item/storage/shoebox/jackboot/,
		/obj/item/storage/glovebox/padded/,
		/obj/item/clothing/back/storage/satchel/poly/nanotrasen,
		/obj/item/clothing/back/storage/dufflebag/poly/nanotrasen,
		/obj/item/clothing/back/storage/backpack/poly/nanotrasen,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/clothing/mask/gas/poly/nanotrasen,
		/obj/item/clothing/head/helmet/polymorphic/nanotrasen,
		/obj/item/clothing/overwear/armor/medium_armor/black,
		/obj/item/clothing/overwear/armor/nanotrasen,
		/obj/item/clothing/head/helmet/full/nanotrasen,
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/flare
	)

/obj/structure/interactive/vending/nanotrasen/gundrobe
	name = "gun vendor"
	icon_state = "gundrobe"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/weapon/melee/energy/stunbaton,

		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/revolver/defender,

		//3 smgs
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi,

		// 3 rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard,
		/obj/item/weapon/ranged/bullet/magazine/rifle/semi,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,

		// 1 shotgun
		/obj/item/weapon/ranged/bullet/pump/shotgun/nt,

		// 1 grenade
		/obj/item/grenade/timed/explosive,

	)