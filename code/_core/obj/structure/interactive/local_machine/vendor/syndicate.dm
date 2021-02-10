/obj/structure/interactive/vending/syndicate
	name = "syndicate vendor"
	icon_state = "syndi"
	accepts_item = /obj/item/currency/telecrystals
	markup = 1

/obj/structure/interactive/vending/syndicate/guns
	name = "syndicate armaments vendor"
	desc = "You better buy shit, and fast!"
	desc_extended = "A timed syndicate vendor that is set to destroy all their internal contents when NanoTrasen personel land on the ship. You better grab a loadout, and fast!"
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm/ap,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm/ap,
		/obj/item/weapon/ranged/bullet/revolver/traitor_357,
		/obj/item/magazine/clip/revolver/bullet_357,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45/ap,
		/obj/item/weapon/ranged/bullet/magazine/smg/handheld,
		/obj/item/magazine/smp_9mm,
		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223/ap,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg,
		/obj/item/magazine/lmg_223,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308/ap,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog,
		/obj/item/magazine/shotgun_auto/buckshot,
		/obj/item/magazine/shotgun_auto/slug,
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper,
		/obj/item/magazine/sniper_50,
		/obj/item/magazine/sniper_50/ap,
		/obj/item/magazine/sniper_50/explosive,
		/obj/item/magazine/sniper_50/incendiary,
		/obj/item/magazine/sniper_50/ion,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/weapon/melee/energy/shield/red,
	)

/obj/structure/interactive/vending/syndicate/medicine
	name = "syndicate medicine vendor"
	icon_state = "boozeomat"

	stored_types = list(
		/obj/item/storage/kit/filled,
		/obj/item/storage/kit/brute/filled,
		/obj/item/storage/kit/burn/filled,
		/obj/item/storage/kit/toxin/filled,
		/obj/item/storage/kit/ai3/filled,
		/obj/item/container/blood_pack/full/reptile,
		/obj/item/container/blood_pack/full/o_negative,
		/obj/item/container/beaker/vial/zombie_antidote,
		/obj/item/container/medicine/nanopaste
	)
	markup = 0.75

/obj/structure/interactive/vending/syndicate/attachment
	name = "syndicate attachment vendor"
	icon_state = "attachment"
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
		/obj/item/attachment/undermount/vertical_grip
	)
	markup = 0.5

/obj/structure/interactive/vending/syndicate/prize
	name = "hacked prize vendor"
	icon_state = "prize_hacked"

	stored_types = list(
		/obj/item/announcement/syndicate,
		/obj/item/clothing/overwear/armor/plate_carrier/black,
		/obj/item/armor_plate/super,
		/obj/item/armor_plate/ultra,
		/obj/item/clothing/overwear/hardsuit/syndie,
		/obj/item/clothing/overwear/hardsuit/syndie/advanced,
		/obj/item/clothing/overwear/hardsuit/syndie/elite,
		/obj/item/clothing/overwear/coat/ghillie/forest,
		/obj/item/clothing/overwear/coat/ghillie/snow,
		/obj/item/clothing/overwear/coat/ghillie/lava,
		/obj/item/deployable/barricade/filled,
		/obj/item/grenade/landmine/proximity/explosive,
		/obj/item/grenade/timed/explosive,
		/obj/item/supply_crate/syndicate,
		/obj/item/weapon/melee/toolbox/syndicate,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
		/obj/item/pinpointer/crew/syndicate,
		/obj/item/weapon/melee/torch/flashlight/maglight,
		/obj/item/clothing/glasses/thermal,
		/obj/item/rcd,
		/obj/item/disk/rcd/glass_window,
		/obj/item/disk/rcd/metal_wall,
		/obj/item/matter_cartridge,
		/obj/item/cell_charger,
		/obj/item/powercell/industrial,
		/obj/item/deployable/mob/sentry,
		/obj/item/magazine/minigun_46
	)
	markup = 0.75

/obj/structure/interactive/vending/syndicate/prize/rev
	stored_types = list(
		/obj/item/clothing/back/storage/backpack/explorer,
		/obj/item/clothing/overwear/armor/plate_carrier/black,
		/obj/item/armor_plate/super,
		/obj/item/armor_plate/ultra,
		/obj/item/clothing/overwear/armor/slavticool,
		/obj/item/clothing/head/helmet/security/slavticool,
		/obj/item/clothing/head/helmet/security/slavticool/thermal,
		/obj/item/clothing/overwear/hardsuit/exosuit,
		/obj/item/clothing/overwear/armor/seva/mono,
		/obj/item/clothing/overwear/hardsuit/skat,
		/obj/item/clothing/overwear/coat/ghillie/forest,
		/obj/item/clothing/overwear/coat/ghillie/snow,
		/obj/item/clothing/overwear/coat/ghillie/lava,
		/obj/item/deployable/barricade/filled,
		/obj/item/grenade/landmine/proximity/explosive,
		/obj/item/grenade/timed/explosive,
		/obj/item/supply_crate/russian,
		/obj/item/weapon/melee/toolbox/syndicate,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
		/obj/item/weapon/melee/torch/flashlight/maglight,
		/obj/item/clothing/glasses/thermal,
		/obj/item/rcd,
		/obj/item/disk/rcd/glass_window,
		/obj/item/disk/rcd/metal_wall,
		/obj/item/matter_cartridge,
		/obj/item/cell_charger,
		/obj/item/powercell/industrial,
		/obj/item/deployable/mob/sentry,
		/obj/item/magazine/minigun_46,
		/obj/item/weapon/melee/sword/rev_bayonet,
		/obj/item/weapon/melee/shield/ballistic
	)


/obj/structure/interactive/vending/syndicate/guns/rev
	name = "revolutionary armaments vendor"
	icon_state = "sovietsoda"
	stored_types = list(
		/obj/item/weapon/ranged/bullet/revolver/nagant,
		/obj/item/bullet_cartridge/revolver_762,

		/obj/item/weapon/ranged/bullet/magazine/rifle/abakan,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak12,

		/obj/item/magazine/rifle_545,
		/obj/item/magazine/rifle_545/ap,

		/obj/item/weapon/ranged/bullet/magazine/rifle/ak13,
		/obj/item/magazine/rifle_762_short,

		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun,
		/obj/item/magazine/gauss_gun,

		/obj/item/weapon/ranged/bullet/magazine/rifle/svd,
		/obj/item/magazine/rifle_762_long,

		/obj/item/weapon/ranged/bullet/magazine/rifle/val,
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza,
		/obj/item/magazine/rifle_939,

		/obj/item/weapon/ranged/bullet/pump/shotgun/ks23,
		/obj/item/storage/ammo/buckshot_23,
		/obj/item/storage/ammo/slug_23,
		/obj/item/storage/ammo/fire_23,

		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_20,
		/obj/item/magazine/shotgun_auto/buckshot,
		/obj/item/magazine/shotgun_auto/slug,

		/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin,
		/obj/item/magazine/pistol_9mm,

		/obj/item/weapon/ranged/bullet/magazine/smg/bizon,
		/obj/item/magazine/bizon_9mm,

		/obj/item/weapon/ranged/bullet/revolver/gm94,
		/obj/item/storage/ammo/grenade_40mm,

		/obj/item/weapon/ranged/bullet/magazine/rifle/rpk,
		/obj/item/magazine/lmg_545,
		/obj/item/magazine/lmg_545/ap
	)