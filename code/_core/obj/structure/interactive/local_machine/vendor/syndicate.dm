/obj/structure/interactive/vending/syndicate
	name = "syndicate vendor"
	accepts_item = /obj/item/currency/telecrystals
	markup = 1
	health = null
	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null
	ignore_economy = TRUE

/obj/structure/interactive/vending/syndicate/guns
	name = "syndicate armaments vendor"
	desc = "You better buy shit, and fast!"
	desc_extended = "A timed syndicate vendor that is set to destroy all their internal contents when NanoTrasen personel land on the ship. You better grab a loadout, and fast!"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_guns"
	stored_types = list(
		/obj/item/weapon/unarmed/powerfist,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/weapon/melee/energy/shield/syndicate,

		/obj/item/weapon/ranged/bullet/magazine/pistol/longcon,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre,
		/obj/item/weapon/ranged/bullet/revolver/traitor_357,

		/obj/item/weapon/ranged/bullet/magazine/smg/handheld,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup,

		/obj/item/weapon/ranged/bullet/pump/shotgun/combat,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog,

		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/prototype,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg,

		/obj/item/weapon/ranged/bullet/magazine/rifle/syringe,
		/obj/item/weapon/ranged/bow/hardlight/syndicate,
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper,

		/obj/item/grenade/fuse/fragmentation,
		/obj/item/grenade/device/landmine/proximity/explosive,
		/obj/item/grenade/device/special/timed/decoy,
		/obj/item/grenade/device/special/timed/shell,
		/obj/item/grenade/device/timed/emp,
		/obj/item/grenade/device/timed/incendiary,
		/obj/item/grenade/device/timed/smoke,

	)

/obj/structure/interactive/vending/syndicate/ammo
	name = "syndicate ammo vendor"
	desc = "You better buy shit, and fast!"
	desc_extended = "A timed syndicate vendor that is set to destroy all their internal contents when NanoTrasen personel land on the ship. You better grab a loadout, and fast!"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_ammo"
	stored_types = list(

		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm/ap,
		/obj/item/magazine/clip/revolver/bullet_357,
		/obj/item/magazine/clip/revolver/bullet_357/heap,


		/obj/item/magazine/smg_9mm,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45/ap,

		/obj/item/bulletbox/small/shotgun_12,
		/obj/item/bulletbox/small/shotgun_12/flechette,
		/obj/item/bulletbox/small/shotgun_12/slug,
		/obj/item/magazine/shotgun_auto,
		/obj/item/magazine/shotgun_auto/slug,

		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223/ap,
		/obj/item/magazine/sniper_308,
		/obj/item/magazine/sniper_308/ap,
		/obj/item/magazine/lmg_223,

		/obj/item/container/simple/beaker/bottle/medium/poison,
		/obj/item/magazine/syringe_gun,

		/obj/item/magazine/sniper_50,
		/obj/item/magazine/sniper_50/ap,
		/obj/item/magazine/sniper_50/incendiary,
		/obj/item/magazine/sniper_50/explosive
	)



/obj/structure/interactive/vending/syndicate/medicine
	name = "syndicate medicine vendor"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_medical"

	stored_types = list(
		/obj/item/analyzer/health/syndicate,
		/obj/item/container/blood_pack/full/synthblood,
		/obj/item/container/healing/nanopaste,

		/obj/item/storage/kit/filled,
		/obj/item/storage/kit/brute/filled,
		/obj/item/storage/kit/burn/filled,
		/obj/item/storage/kit/toxin/filled,
		/obj/item/storage/kit/oxy/filled,
		/obj/item/storage/kit/rad/filled,
		/obj/item/storage/kit/syndicate/filled,

		/obj/item/storage/kit/small/filled,
		/obj/item/storage/kit/small/brute/filled,
		/obj/item/storage/kit/small/burn/filled,
		/obj/item/storage/kit/small/toxin/filled,
		/obj/item/storage/kit/small/oxy/filled,
		/obj/item/storage/kit/small/rad/filled,
		/obj/item/storage/kit/small/syndicate/filled,

		/obj/item/storage/kit/advanced/filled,





		/obj/item/doctor_bag,
		/obj/item/defib,
		/obj/item/defib/belt,

	)

/obj/structure/interactive/vending/syndicate/wardrobe
	name = "syndicate wardrobe vendor"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_wardrobe"
	stored_types = list(

		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,

		/obj/item/clothing/overwear/hardsuit/syndie,
		/obj/item/clothing/overwear/hardsuit/syndie/advanced,
		/obj/item/clothing/overwear/hardsuit/syndie/elite,
		/obj/item/clothing/overwear/armor/seva/syndie,


	)

/obj/structure/interactive/vending/syndicate/attachment
	name = "syndicate attachment vendor"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_attachment"
	stored_types = list(
		/obj/item/attachment/barrel/charger,
		/obj/item/attachment/barrel/compensator,
		/obj/item/attachment/barrel/extended,
		/obj/item/attachment/barrel/gyro,
		/obj/item/attachment/barrel/suppressor,

		/obj/item/attachment/sight/laser_sight,
		/obj/item/attachment/sight/quickfire_adapter,
		/obj/item/attachment/sight/red_dot,
		/obj/item/attachment/sight/scope,
		/obj/item/attachment/sight/scope/medium,
		/obj/item/attachment/sight/scope/large,
		/obj/item/attachment/sight/targeting_computer,

		/obj/item/attachment/undermount/angled_grip,
		/obj/item/attachment/undermount/bipod,
		/obj/item/attachment/undermount/burst_adapter,
		/obj/item/attachment/undermount/vertical_grip
	)

/obj/structure/interactive/vending/syndicate/prize
	name = "hacked prize vendor"
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "syndicate_prize"

	stored_types = list(

		/obj/item/fulton_pack,
		/obj/item/handcuffs,

		/obj/item/material/sheet/iron{amount=50},
		/obj/item/material/sheet/glass{amount=50},
		/obj/item/weapon/melee/toolbox/syndicate,
		/obj/item/deployable/barbed_wire{amount = 5},
		/obj/item/deployable/barricade{amount = 5},
		/obj/item/deployable/mob/sentry,
		/obj/item/magazine/minigun_46,


		/obj/item/powercell,
		/obj/item/powercell/advanced,


		/obj/item/lighter,

		/obj/item/light_sensor,
		/obj/item/flare,
		/obj/item/weapon/melee/torch/lantern,
		/obj/item/weapon/melee/torch/flashlight/maglight,
		/obj/item/clothing/glasses/nightvision/syndicate,

		/obj/item/tempering/quality/general
	)