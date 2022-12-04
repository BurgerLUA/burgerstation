/obj/structure/interactive/vending/nanotrasen
	name = "security vendor"
	icon_state = "sec"

/obj/structure/interactive/vending/nanotrasen/wardrobe/ops
	name = "nt ops wardrobe vendor"
	icon_state = "secdrobe_ops"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/normal/reinforced/ntops,
		/obj/item/clothing/shirt/normal/reinforced/ntops,
		/obj/item/storage/shoebox/jackboot,
		/obj/item/storage/glovebox/padded,
		/obj/item/clothing/back/storage/satchel/poly/ntops,
		/obj/item/clothing/back/storage/dufflebag/poly/ntops,
		/obj/item/clothing/back/storage/backpack/poly/ntops,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/belt/bandolier/shotgun_12,
		/obj/item/clothing/head/hat/skimask/black,
		/obj/item/clothing/mask/gas/tactical,
		/obj/item/clothing/head/hat/beret/armored,
		/obj/item/clothing/head/helmet/polymorphic/reinforced/ntops,
		/obj/item/clothing/overwear/armor/bulletproof,
		/obj/item/weapon/melee/energy/grazer,
		/obj/item/clothing/head/helmet/full/eod_helm,
		/obj/item/clothing/overwear/armor/eod
	)

//Security
/obj/structure/interactive/vending/nanotrasen/gundrobe/ops
	name = "NT ops gun vendor"
	icon_state = "gundrobe_ops"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/weapon/unarmed/powerfist,

		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer,

		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech,

		/obj/item/weapon/ranged/bullet/magazine/rifle/service,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,

		/obj/item/weapon/ranged/bullet/pump/shotgun/semi,

		/obj/item/grenade/timed/explosive_large
	)

//Science
/obj/structure/interactive/vending/nanotrasen/gundrobe/science
	icon_state = "gundrobe_science"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null
	stored_types = list(
		/obj/item/weapon/melee/energy/sword/katana,
		/obj/item/weapon/ranged/bullet/magazine/smg/smart,
		/obj/item/weapon/ranged/energy/rifle,
		/obj/item/weapon/ranged/energy/rifle/hardlight,
		/obj/item/weapon/ranged/energy/rifle/xray,
		/obj/item/weapon/ranged/energy/freezegun,
		/obj/item/weapon/ranged/energy/hybrid/carbine,
		/obj/item/weapon/ranged/energy/iongun,
		/obj/item/weapon/ranged/energy/sniper,


		/obj/item/grenade/timed/emp
	)

/obj/structure/interactive/vending/nanotrasen/gundrobe/dip
	name = "drip gun vendor"
	icon_state = "dipdrobe"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/weapon/ranged/bullet/magazine/pistol/dip,
		/obj/item/magazine/dip_22,
		/obj/item/magazine/dip_22,
		/obj/item/magazine/dip_22,
		/obj/item/magazine/dip_22,
		/obj/item/storage/ammo/bullet_22
	)


/obj/structure/interactive/vending/nanotrasen/ammo
	name = "ammo vendor"
	icon_state = "ammodrobe"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_12mm/nt,
		/obj/item/magazine/pistol_tranq_11m,
		/obj/item/magazine/smg_pdw,
		/obj/item/magazine/smg_4mm_standard,
		/obj/item/magazine/smg_9mm,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556/ap,
		/obj/item/magazine/lmg_556,
		/obj/item/magazine/sniper_308/nato,
		/obj/item/magazine/sniper_308/nato/ap,
		/obj/item/magazine/lmg_762,
		/obj/item/magazine/sniper_127,
		/obj/item/magazine/minigun_46,
		/obj/item/magazine/browning_127,
		/obj/item/storage/ammo/buckshot,
		/obj/item/storage/ammo/slug,
		/obj/item/storage/ammo/flechette,
		/obj/item/bullet_cartridge/rocket_70mm,
		/obj/item/bullet_cartridge/rocket_70mm/wp,
		/obj/item/bullet_cartridge/rocket_70mm/ap,
		/obj/item/bullet_cartridge/grenade_40mm,
		/obj/item/bullet_cartridge/grenade_40mm/rubber,
		/obj/item/powercell,
		/obj/item/powercell/advanced,
		/obj/item/cell_charger
	)

/obj/structure/interactive/vending/nanotrasen/ammo/ops
	icon_state = "ammodrobe_ops"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

/obj/structure/interactive/vending/nanotrasen/attachment
	name = "attachment vendor"
	icon_state = "attachment"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/attachment/barrel/charger,
		/obj/item/attachment/barrel/compensator,
		/obj/item/attachment/barrel/extended,
		/obj/item/attachment/barrel/gyro,
		/obj/item/attachment/barrel/laser_charger,
		/obj/item/attachment/barrel/suppressor,
		/obj/item/attachment/sight/laser_sight,
		/obj/item/attachment/sight/quickfire_adapter,
		/obj/item/attachment/sight/red_dot,
		/obj/item/attachment/sight/scope,
		/obj/item/attachment/sight/scope/large,
		/obj/item/attachment/sight/targeting_computer,
		/obj/item/attachment/undermount/angled_grip,
		/obj/item/attachment/undermount/bipod,
		/obj/item/attachment/undermount/burst_adapter,
		/obj/item/attachment/undermount/vertical_grip,
		/obj/item/attachment/undermount/gun/grenade_launcher
	)


/obj/structure/interactive/vending/nanotrasen/loadout
	name = "loadout vendor"
	icon_state = "gear"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		/obj/item/clothing/back/storage/dufflebag/poly/recruit
	)

	markup = 1