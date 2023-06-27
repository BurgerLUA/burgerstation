/obj/structure/interactive/vending/nanotrasen/janitor/
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/janitor/equipment
	name = "janitor equipment vendor"
	icon_state = "janitor_equipment"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/wet_floor_sign,
		/obj/item/mop,
		/obj/item/broom,
		/obj/item/container/simple/beaker/bucket/water,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/space_cleaner,
		/obj/item/storage/lighting/bulb,
		/obj/item/storage/lighting/tube,
		/obj/item/grenade/device/large/timed/cleaning_smoke
	)

/obj/structure/interactive/vending/nanotrasen/janitor/clothing
	name = "janitor clothing vendor"
	icon_state = "janitor_clothing"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(

		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/striped/janitor,
		/obj/item/clothing/shirt/normal/janitor,

		//Shoes and gloves.
		/obj/item/storage/shoebox/galosh,
		/obj/item/storage/glovebox/yellow,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen/medical,

		//Helmets and masks
		/obj/item/clothing/head/helmet/polymorphic/janitor,
		/obj/item/clothing/mask/gas/poly/janitor,

		//Armor
		/obj/item/clothing/overwear/armor/medium_armor/black,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/janitor,
		/obj/item/clothing/overwear/coat/vest/poly/janitor,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,

		//Satchel, Backpack, Duffleback.
		/obj/item/clothing/back/storage/satchel/poly/janitor,
		/obj/item/clothing/back/storage/backpack/poly/janitor,
		/obj/item/clothing/back/storage/dufflebag/poly/janitor,

		//Bonus
		/obj/item/clothing/overwear/armor/nanotrasen/janitor,
		/obj/item/clothing/head/helmet/full/nanotrasen/janitor

	)


/obj/structure/interactive/vending/nanotrasen/janitor/guns
	name = "janitor gun vendor"
	icon_state = "janitor_guns"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//3 melee


		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/pump/shotgun/nt,
		/obj/item/weapon/ranged/bullet/revolver/dbarrel,
		/obj/item/weapon/ranged/bullet/revolver/sweep,

		//3 rifles

		/obj/item/weapon/ranged/bullet/magazine/rifle/ooc,
		/obj/item/weapon/ranged/bullet/magazine/rifle/m4_soap,

		//3 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light,
		/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/nanotrasen,
		/obj/item/weapon/ranged/reagent_sprayer/mega_sprayer,

		//3 grenades or equipment
		/obj/item/grenade/device/large/timed/cleaning_smoke,
		/obj/item/grenade/device/special/timed/blackhole,
		/obj/item/deployable/mob/cleaning_bot



	)


/obj/structure/interactive/vending/nanotrasen/janitor/ammo
	name = "janitor ammo vendor"
	icon_state = "janitor_ammo"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm/hp,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm/ap,
		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,
		/obj/item/bulletbox/shotgun_12/slug,
		/obj/item/bulletbox/shotgun_12/slug/cleaning,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/lmg_556,
		/obj/item/bullet_cartridge/grenade_40mm,
	)