//Engineering
/obj/structure/interactive/vending/nanotrasen/gundrobe/engineering
	icon_state = "gundrobe_engineering"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null
	stored_types = list(
		//1 melee
		/obj/item/weapon/melee/axe/fireaxe,

		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/classic,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/revolver/defender,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/magazine/smg/smart,
		/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten, //Really an SMG.
		/obj/item/weapon/ranged/bullet/pump/shotgun/classic,

		//3 rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/ooc,
		/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/nanotrasen,
		/obj/item/weapon/ranged/bullet/revolver/rocket,

		//3 grenades or equipment
		/obj/item/deployable/barbed_wire,
		/obj/item/deployable/barricade,
		/obj/item/deployable/mob/sentry
	)

/obj/structure/interactive/vending/nanotrasen/wardrobe/engineering
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