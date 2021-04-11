/obj/structure/interactive/vending/virtual_reality
	name = "magic loadout vendor"
	icon_state = "vr_platform"
	var/vendor_type = "ammo"

/obj/structure/interactive/vending/virtual_reality/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/vending/virtual_reality/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"vr_[vendor_type]")
	I.plane = PLANE_EFFECT_LIGHTING
	I.layer = 1000
	I.pixel_z = TILE_SIZE*0.5
	I.alpha = 200
	add_overlay(I)

	var/image/I2 = new/image(initial(icon),"vr_gem")
	I2.plane = PLANE_EFFECT_LIGHTING
	I2.layer = 999
	I2.alpha = 200
	add_overlay(I2)

/obj/structure/interactive/vending/virtual_reality/modify_item(var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/mechanical


/obj/structure/interactive/vending/virtual_reality/weapons
	name = "VR Weapon Vendor"
	vendor_type = "guns"
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/weapon/ranged/bullet/magazine/pistol/brown,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,
		/obj/item/weapon/ranged/bullet/revolver/commander,

		/obj/item/weapon/ranged/bullet/magazine/smg/handheld,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi/mod,
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech,
		/obj/item/weapon/ranged/bullet/magazine/smg/bizon,

		/obj/item/weapon/ranged/bullet/pump/shotgun/wood,
		/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod,
		/obj/item/weapon/ranged/bullet/pump/shotgun/semi,
		/obj/item/weapon/ranged/bullet/pump/shotgun/ks23,

		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst/prototype,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak14,
		/obj/item/weapon/ranged/bullet/magazine/rifle/merc,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman,

		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg,
		/obj/item/weapon/ranged/bullet/magazine/rifle/rpk,

		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper,
	)


/obj/structure/interactive/vending/virtual_reality/ammo
	name = "VR Ammo Vendor"
	vendor_type = "ammo"
	stored_types = list(
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/clip/revolver/bullet_44,

		/obj/item/magazine/smp_9mm,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_10mm,
		/obj/item/magazine/smg_10mm,
		/obj/item/magazine/smg_9mm,
		/obj/item/magazine/bizon_9mm,

		/obj/item/bullet_cartridge/shotgun_12/buckshot,
		/obj/item/bullet_cartridge/shotgun_23/buckshot,

		/obj/item/magazine/carbine_223,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_762_long_ak,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_308,

		/obj/item/magazine/lmg_223,
		/obj/item/magazine/lmg_545,

		/obj/item/magazine/rifle_762_long,
		/obj/item/magazine/sniper_762,
		/obj/item/magazine/sniper_127,
		/obj/item/magazine/sniper_50
	)
