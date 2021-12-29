/obj/item/weapon/ranged/wand
	name = "wand"
	desc = "Wingardium Leviosa!"
	desc_extended = "A magic imbued wand that can fit any type of spell gem to amplify and improve its powers."
	icon_state = "inventory"

	value = -1

	var/obj/item/weapon/ranged/spellgem/socketed_spellgem

	automatic = TRUE

	var/wand_damage_multiplier = 1

	dan_mode = TRUE

	use_loyalty_tag = TRUE

	bypass_balance_check = TRUE

/obj/item/weapon/ranged/wand/Destroy()
	QDEL_NULL(socketed_spellgem)
	. = ..()

/obj/item/weapon/ranged/wand/get_base_value()
	. = ..()
	. *= wand_damage_multiplier**2

/obj/item/weapon/ranged/wand/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("socketed_spellgem")

/obj/item/weapon/ranged/wand/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("socketed_spellgem")

/obj/item/weapon/ranged/wand/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)
	if(!socketed_spellgem)
		return FALSE
	return socketed_spellgem.shoot(caller,object,location,params,damage_multiplier*wand_damage_multiplier)

/obj/item/weapon/ranged/wand/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/ranged/spellgem/))
		var/obj/item/weapon/ranged/spellgem/SG = object
		if(socketed_spellgem)
			caller.to_chat(span("warning","Remove \the [socketed_spellgem.name] before inserting a new spellgem!"))
			return TRUE
		socketed_spellgem = SG
		SG.drop_item(src)
		caller.to_chat(span("notice","You insert \the [SG.name] into \the [src.name]."))
		return TRUE

	if(istype(object,/obj/hud/inventory/))
		var/obj/hud/inventory/I = object
		if(!socketed_spellgem)
			caller.to_chat(span("warning","There is no socketed spellgem to remove!"))
			return TRUE
		I.add_object(socketed_spellgem)
		caller.to_chat(span("notice","You remove \the [socketed_spellgem.name] from \the [src.name]."))
		socketed_spellgem = null
		return TRUE

	. = ..()

/obj/item/weapon/ranged/wand/branch
	name = "branch wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/branch.dmi'

	wand_damage_multiplier = 1.1

	value = 100

/obj/item/weapon/ranged/wand/crafted
	name = "crafted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/crafted.dmi'

	wand_damage_multiplier = 1.2

	value = 100

/obj/item/weapon/ranged/wand/quartz
	name = "crafted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/crafted.dmi'

	wand_damage_multiplier = 1.3

	value = 100

/obj/item/weapon/ranged/wand/twisted
	name = "twisted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/twisted.dmi'

	wand_damage_multiplier = 1.4

	value = 100

/obj/item/weapon/ranged/wand/profane
	name = "profane wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/profane.dmi'

	wand_damage_multiplier = 1.5

	value = 100

/obj/item/weapon/ranged/wand/sage
	name = "sage wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/sage.dmi'

	wand_damage_multiplier = 1.6

	value = 100

