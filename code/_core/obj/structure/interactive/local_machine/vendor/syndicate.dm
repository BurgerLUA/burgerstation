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
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull,
		/obj/item/magazine/shotgun_auto/buckshot,
		/obj/item/magazine/shotgun_auto/slug,
		/obj/item/magazine/shotgun_auto/fire,
		/obj/item/magazine/shotgun_auto/flechette,
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
		/obj/item/container/blood_pack/full/reptile,
		/obj/item/container/blood_pack/full/o_negative
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
		/obj/item/deployable/barricade/filled,
		/obj/item/grenade/landmine/proximity/explosive,
		/obj/item/grenade/timed/explosive,
		/obj/item/supply_crate/syndicate,
		/obj/item/weapon/melee/toolbox/syndicate,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
		/obj/item/pinpointer/crew/syndicate
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
		/obj/item/clothing/overwear/hardsuit/exosuit,
		/obj/item/clothing/overwear/hardsuit/seva/mono,
		/obj/item/clothing/overwear/hardsuit/skat,
		/obj/item/deployable/barricade/filled,
		/obj/item/grenade/landmine/proximity/explosive,
		/obj/item/grenade/timed/explosive,
		/obj/item/supply_crate/russian,
		/obj/item/weapon/melee/toolbox/syndicate,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
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

		/obj/item/weapon/ranged/bullet/magazine/rifle/ak13,
		/obj/item/magazine/rifle_762_short,

		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun,
		/obj/item/magazine/gauss_gun,

		/obj/item/weapon/ranged/bullet/magazine/rifle/svd,
		/obj/item/weapon/ranged/bullet/magazine/rifle/svt,
		/obj/item/magazine/rifle_762_long,

		/obj/item/weapon/ranged/bullet/magazine/rifle/val,
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza,
		/obj/item/magazine/rifle_939,

		/obj/item/weapon/ranged/bullet/pump/shotgun/ks23,
		/obj/item/storage/ammo/buckshot_23,
		/obj/item/storage/ammo/slug_23,

		/obj/item/weapon/melee/sword/allium,
		/obj/item/weapon/melee/shield
	)