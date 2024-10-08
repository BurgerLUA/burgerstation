//Engineering

/obj/structure/interactive/vending/nanotrasen/engineering/
	icon = 'icons/obj/structure/vending_new.dmi'


/obj/structure/interactive/vending/nanotrasen/engineering/guns
	name = "engineering gun vendor"
	icon_state = "engineering_guns"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null
	stored_types = list(
		//3 melee
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/weapon/melee/tool/wrench/high,
		/obj/item/weapon/melee/axe/fireaxe,

		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/revolver/defender,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/magazine/smg/smart,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi,
		/obj/item/weapon/ranged/bullet/pump/shotgun/nt,

		//3 rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ooc,

		//3 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt,
		/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/nanotrasen,
		/obj/item/weapon/ranged/bullet/revolver/rocket,

		//3 grenades or equipment
		/obj/item/grenade/device/landmine/proximity/explosive,
		/obj/item/grenade/device/special/timed/barrier,
		/obj/item/grenade/device/special/timed/shell

	)

/obj/structure/interactive/vending/nanotrasen/engineering/ammo
	name = "engineering ammo vendor"
	icon_state = "engineering_ammo"

	stored_types = list(

		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/clip/revolver/bullet_38,

		/obj/item/magazine/smg_smart,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/rifle_tungsten,

		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556/ap,

		/obj/item/magazine/lmg_762,

		/obj/item/bullet_cartridge/rocket_70mm,
		/obj/item/bullet_cartridge/rocket_70mm/ap,

		/obj/item/bullet_cartridge/grenade_40mm,
		/obj/item/bullet_cartridge/grenade_40mm/hv,

		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,

		/obj/item/bulletbox/shotgun_12,
		/obj/item/bulletbox/shotgun_12/flechette,
		/obj/item/bulletbox/shotgun_12/slug,

		/obj/item/magazine/minigun_46

	)





/obj/structure/interactive/vending/nanotrasen/engineering/clothing
	name = "engineering clothing vendor"
	icon_state = "engineering_clothing"

	stored_types = list(
		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/striped/engineering,
		/obj/item/clothing/shirt/normal/uniform/engineering,

		//Shoes and gloves.
		/obj/item/storage/shoebox/workboot,
		/obj/item/storage/glovebox/yellow,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen,

		//Helmets and masks
		/obj/item/clothing/head/helmet/polymorphic/engineering,
		/obj/item/clothing/mask/gas/poly/engineering,

		//Armor
		/obj/item/clothing/overwear/armor/medium_armor/brown,

		//Belts and pockets
		/obj/item/clothing/belt/storage/colored/brown,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/storage/pouch/single/brown,
		/obj/item/storage/pouch/double/brown,
		/obj/item/storage/pouch/triple/brown,

		//Satchel, Backpack, Duffleback
		/obj/item/clothing/back/storage/satchel/poly/engineering,
		/obj/item/clothing/back/storage/dufflebag/poly/engineering,
		/obj/item/clothing/back/storage/backpack/poly/engineering,

		//Bonus
		/obj/item/clothing/overwear/armor/nanotrasen/engineering,
		/obj/item/clothing/head/helmet/full/nanotrasen/engineering
	)

/obj/structure/interactive/vending/nanotrasen/engineering/equipment
	name = "engineering equipment vendor"
	icon_state = "engineering_equipment"

	stored_types = list(
		/obj/item/powercell,
		/obj/item/powercell/industrial,
		/obj/item/weapon/melee/toolbox/red,
		/obj/item/weapon/melee/toolbox/green,
		/obj/item/weapon/melee/toolbox/blue,
		/obj/item/weapon/melee/toolbox/yellow,
		/obj/item/weapon/melee/tool/crowbar,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/weapon/melee/tool/welder,
		/obj/item/weapon/melee/tool/wrench,
		/obj/item/supply_remote/ammo,
		/obj/item/deployable/barbed_wire,
		/obj/item/deployable/barricade,
		/obj/item/deployable/mob/sentry,
		/obj/item/material/sheet/steel{amount=50},
		/obj/item/material/sheet/glass{amount=50},
		/obj/item/material/sheet/iron{amount=50}
	)

/obj/structure/interactive/vending/nanotrasen/engineering/rcd
	name = "engineering RCD vendor"
	icon_state = "engineering_rcd"

	stored_types = list(
		/obj/item/rcd,
		/obj/item/matter_cartridge,
		/obj/item/disk/rcd/airlock,
		/obj/item/disk/rcd/chair,
		/obj/item/disk/rcd/conveyor,
		/obj/item/disk/rcd/diverter,
		/obj/item/disk/rcd/flap,
		/obj/item/disk/rcd/glass_window,
		/obj/item/disk/rcd/light,
		/obj/item/disk/rcd/metal_plating,
		/obj/item/disk/rcd/metal_wall,
		/obj/item/disk/rcd/oresmelter,
		/obj/item/disk/rcd/orestorage,
		/obj/item/disk/rcd/stacker,
		/obj/item/disk/rcd/table,
		/obj/item/disk/rcd/tube_light
	)
