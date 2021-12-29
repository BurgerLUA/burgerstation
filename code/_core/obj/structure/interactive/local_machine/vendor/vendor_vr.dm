/obj/structure/interactive/vr_shop
	name = "magic loadout vendor"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "vr_platform"
	var/vendor_type = "ammo"

	var/list/vendor_types_to_spawn = list(
		/obj/structure/interactive/vending/virtual_reality/weapons/pistols,
		/obj/structure/interactive/vending/virtual_reality/weapons/smgs,
		/obj/structure/interactive/vending/virtual_reality/weapons/shotguns,
		/obj/structure/interactive/vending/virtual_reality/weapons/rifles,
		/obj/structure/interactive/vending/virtual_reality/weapons/special,
		/obj/structure/interactive/vending/virtual_reality/weapons/gear
	)

	var/list/stored_vendors = list()

	interact_distance = VIEW_RANGE

	desired_light_power = 0.8
	desired_light_range = VIEW_RANGE
	desired_light_color = "#FFFFFF"


/obj/structure/interactive/vr_shop/Destroy()
	QDEL_CUT(stored_vendors)
	. = ..()


/obj/structure/interactive/vr_shop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	for(var/obj/hud/button/vendor_close/VC in caller.buttons)
		VC.close()
		return ..()

	var/spacing = 3
	var/vendor_length = length(stored_vendors)
	var/i = 1
	for(var/k in stored_vendors)
		var/mod = (i/vendor_length)*360
		var/x_pos = sin(mod)*spacing
		var/y_pos = cos(mod)*spacing
		var/obj/structure/interactive/vending/V = k
		var/obj/hud/button/vendor_defer/B = new
		B.associated_vendor = V
		B.name = V.name
		B.update_owner(caller)
		B.screen_loc = "CENTER+[x_pos],CENTER+[y_pos]"
		i++

	var/obj/hud/button/vendor_close/V = new
	V.update_owner(caller)
	V.screen_loc = "CENTER+[spacing+1],CENTER"
	HOOK_ADD("post_move","\ref[V]_post_move",caller,V,/obj/hud/button/vendor_close/proc/close)

	return TRUE

/obj/structure/interactive/vr_shop/Initialize()
	. = ..()
	for(var/k in vendor_types_to_spawn)
		stored_vendors += CREATE(k,src)

/obj/structure/interactive/vr_shop/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/vr_shop/update_overlays()
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

/obj/structure/interactive/vending/virtual_reality/
	name = "VR Vendor"
	markup = 0.75

	ignore_economy = TRUE

/obj/structure/interactive/vending/virtual_reality/get_bullshit_price(var/desired_price)
	return CEILING(desired_price,10)

/obj/structure/interactive/vending/virtual_reality/modify_item(var/obj/item/I,var/obj/item/base_item)

	. = ..()

	if(istype(I,/obj/item/weapon/ranged))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/mechanical


/obj/structure/interactive/vending/virtual_reality/weapons
	name = "VR Weapon Vendor"
	icon_state = "inventory"
	stored_types = list()
	interact_distance = VIEW_RANGE

/obj/structure/interactive/vending/virtual_reality/weapons/pistols
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm.dmi'
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/magazine/pistol_9mm,
		/obj/item/weapon/ranged/bullet/magazine/pistol/brown,
		/obj/item/magazine/pistol_40,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical,
		/obj/item/magazine/pistol_45,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/magazine/pistol_10mm,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,
		/obj/item/magazine/pistol_50,
		/obj/item/weapon/ranged/bullet/revolver/commander,
		/obj/item/magazine/clip/revolver/bullet_44
	)
	markup = 0.5

/obj/structure/interactive/vending/virtual_reality/weapons/smgs
	icon = 'icons/obj/item/weapons/ranged/smg/9mm.dmi'
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/handheld,
		/obj/item/magazine/smp_9mm,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard,
		/obj/item/magazine/smg_45,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical,
		/obj/item/magazine/smg_10mm,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi/mod,
		/obj/item/magazine/smg_10mm,
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech,
		/obj/item/magazine/smg_9mm,
		/obj/item/weapon/ranged/bullet/magazine/smg/bizon,
		/obj/item/magazine/bizon_9mm
	)

/obj/structure/interactive/vending/virtual_reality/weapons/shotguns
	icon = 'icons/obj/item/weapons/ranged/shotgun/combat.dmi'
	stored_types = list(
		/obj/item/weapon/ranged/bullet/pump/shotgun/wood,
		/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod,
		/obj/item/weapon/ranged/bullet/pump/shotgun/semi,
		/obj/item/bullet_cartridge/shotgun_12
	)

/obj/structure/interactive/vending/virtual_reality/weapons/rifles
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/762_rifle.dmi'
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine,
		/obj/item/magazine/carbine_223,
		/obj/item/weapon/ranged/bullet/magazine/rifle/burst/mod,
		/obj/item/magazine/rifle_556,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak47,
		/obj/item/magazine/rifle_762_short,
		/obj/item/weapon/ranged/bullet/magazine/rifle/merc,
		/obj/item/magazine/rifle_556,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman,
		/obj/item/magazine/rifle_308,
	)

/obj/structure/interactive/vending/virtual_reality/weapons/special
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223_lmg.dmi'
	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg,
		/obj/item/magazine/lmg_223,
		/obj/item/weapon/ranged/bullet/magazine/rifle/pkm,
		/obj/item/magazine/lmg_762_r,

		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/magazine/rifle_939,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127,
		/obj/item/magazine/sniper_127,
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper,
		/obj/item/magazine/sniper_50
	)

/obj/structure/interactive/vending/virtual_reality/weapons/gear
	icon = 'icons/obj/item/clothing/suit/bulletproof_vest.dmi'
	stored_types = list(
		/obj/item/clothing/overwear/armor/bulletproof/vr,
		/obj/item/clothing/head/helmet/polymorphic/vr,
		/obj/item/weapon/melee/torch/flashlight/maglight,
		/obj/item/grenade/timed/explosive,
		/obj/item/grenade/timed/smoke,
		/obj/item/container/medicine/gauze,
		/obj/item/deployable/barricade
	)
	markup = 0.5