/obj/structure/interactive/vending/nanotrasen/mining/
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/mining/clothing
	name = "mining clothing vendor"
	icon_state = "mining_clothing"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/reinforced/mining,
		/obj/item/clothing/shirt/normal/reinforced/mining,

		//Shoes and gloves.
		/obj/item/storage/shoebox/miner,
		/obj/item/storage/glovebox/padded,

		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen,

		//Helmets and masks
		/obj/item/clothing/mask/gas/mining,

		//Armor
		/obj/item/clothing/overwear/armor/explorer_suit,
		/obj/item/clothing/overwear/coat/vest/webbing,
		/obj/item/clothing/overwear/coat/vest/colored/brown,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/brown,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/storage/pouch/single/brown,
		/obj/item/storage/pouch/double/brown,
		/obj/item/storage/pouch/triple/brown,

		//Satchel, Backpack, Duffleback.
		/obj/item/clothing/back/storage/backpack/explorer,

		//Bonus
		/obj/item/clothing/overwear/hardsuit/mining


	)

/obj/structure/interactive/vending/nanotrasen/mining/guns
	name = "mining gun vendor"
	icon_state = "mining_guns"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//3 melee
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/weapon/melee/tool/pickaxe,
		/obj/item/weapon/melee/tool/shovel,
		/obj/item/weapon/melee/energy/chainsaw,


		//3 pistols
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen,
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton/prototype,
		/obj/item/weapon/ranged/bullet/revolver/big_game,

		//3 smgs or shotguns
		/obj/item/weapon/ranged/bullet/pump/shotgun/tech,
		/obj/item/weapon/ranged/energy/pump/kinetic_accelerator,
		/obj/item/weapon/ranged/energy/fed/plasma_cutter,


		//3 rifles
		/obj/item/weapon/ranged/bullet/magazine/rifle/semi,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard,


		//3 heavy weapons (lmgs, sniper rifles, rocket launchers)
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_classic,
		/obj/item/weapon/ranged/bullet/magazine/rifle/advanced,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,

		//3 grenades or equipment
		/obj/item/grenade/device/timed/explosive,
		/obj/item/grenade/device/landmine/proximity/explosive,
		/obj/item/grenade/device/special/timed/decoy

	)

/obj/structure/interactive/vending/nanotrasen/mining/ammo
	name = "mining gun vendor"
	icon_state = "mining_ammo"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(

		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm/hp,

		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm/ap,

		/obj/item/bullet_cartridge/revolver_300{amount=5},

		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,
		/obj/item/bulletbox/small/shotgun_12/techshot,

		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556/ap,

		/obj/item/magazine/lmg_556_classic,

		/obj/item/magazine/sniper_308/nato,
		/obj/item/magazine/sniper_308/nato/ap,

		/obj/item/magazine/sniper_127

	)


/obj/structure/interactive/vending/nanotrasen/mining/equipment
	name = "mining equipment vendor"
	icon_state = "mining_equipment"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/analyzer/value,
		/obj/item/analyzer/armor,
		/obj/item/analyzer/gps,
		/obj/item/analyzer/gps/advanced,
		/obj/item/weapon/melee/torch/lantern,
		/obj/item/ore_bag,
		/obj/item/storage/bags/blacksmithing,
		/obj/item/crafting_bench/smelter,
		/obj/item/weapon/melee/tool/pickaxe,
		/obj/item/weapon/melee/tool/shovel,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/wrench,
		/obj/item/supply_remote/drill,
		/obj/item/supply_remote/ore_box,
		/obj/item/flare,
		/obj/item/fulton_pack,
		/obj/item/container/syringe/medipen/mining,
		/obj/item/legion_core_stabilizer
	)