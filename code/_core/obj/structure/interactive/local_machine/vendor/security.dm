/obj/structure/interactive/vending/security
	name = "security vendor"
	icon_state = "sec"

/obj/structure/interactive/vending/security/wardrobe
	name = "security wardrobe vendor"
	icon_state = "secdrobe_new"

	stored_types = list(
		/obj/item/clothing/feet/socks/knee/white,
		/obj/item/clothing/underbottom/underwear/boxers/security,
		/obj/item/clothing/undertop/underwear/shirt/security,
		/obj/item/clothing/pants/normal/security,
		/obj/item/clothing/shirt/normal/security,
		/obj/item/storage/shoebox/jackboot/,
		/obj/item/storage/glovebox/padded/,
		/obj/item/clothing/back/storage/satchel/poly/security,
		/obj/item/clothing/back/storage/dufflebag/poly/security,
		/obj/item/clothing/back/storage/backpack/poly/security,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/head/hood/skimask/black,
		/obj/item/clothing/mask/gas/poly/security,
		/obj/item/clothing/head/helmet/polymorphic/security,
		/obj/item/clothing/overwear/armor/medium_armor/security,
		/obj/item/clothing/overwear/armor/molded_armor/security,
		/obj/item/clothing/overwear/armor/plate_carrier/black,
		/obj/item/armor_plate/light,
		/obj/item/armor_plate/medium,
		/obj/item/armor_plate/heavy,
		/obj/item/weapon/melee/energy/grazer,
	)

/obj/structure/interactive/vending/security/gundrobe
	name = "gun vendor"
	icon_state = "gundrobe"

	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton,
		/obj/item/magazine/pistol_9mm,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/magazine/pistol_10mm,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer,
		/obj/item/magazine/pistol_12mm/nt,
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw,
		/obj/item/magazine/smg_46,
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech,
		/obj/item/magazine/smg_9mm,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard,
		/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine,
		/obj/item/weapon/ranged/bullet/magazine/rifle/pdw,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst,
		/obj/item/weapon/ranged/bullet/magazine/rifle/semi,
		/obj/item/magazine/rifle_556,
		/obj/item/weapon/ranged/bullet/magazine/rifle/service/nt,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_nt,
		/obj/item/magazine/sniper_762,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt,
		/obj/item/magazine/lmg_762,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/equipped,
		/obj/item/magazine/sniper_127,
		/obj/item/weapon/ranged/bullet/pump/shotgun/nt,
		/obj/item/storage/ammo/buckshot,
		/obj/item/storage/ammo/slug,
		/obj/item/storage/ammo/flechette,
		/obj/item/weapon/ranged/energy/rifle,
		/obj/item/weapon/ranged/energy/rifle/hardlight,
		/obj/item/weapon/ranged/energy/rifle/xray,
		/obj/item/powercell/advanced,
		/obj/item/cell_charger
	)

/obj/structure/interactive/vending/security/gundrobe/engineering
	icon_state = "gundrobe_engineering"


/obj/structure/interactive/vending/security/attachment
	name = "attachment vendor"
	icon_state = "attachment"

	stored_types = list(
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/attachment/barrel/laser_charger,
		/obj/item/attachment/barrel/charger,
		/obj/item/attachment/barrel/compensator,
		/obj/item/attachment/barrel/extended,
		/obj/item/attachment/barrel/suppressor,
		/obj/item/attachment/sight/laser_sight,
		/obj/item/attachment/sight/quickfire_adapter,
		/obj/item/attachment/sight/red_dot,
		/obj/item/attachment/sight/scope,
		/obj/item/attachment/sight/scope/large,
		/obj/item/attachment/undermount/bipod,
		/obj/item/attachment/undermount/burst_adapter,
		/obj/item/attachment/undermount/vertical_grip
	)