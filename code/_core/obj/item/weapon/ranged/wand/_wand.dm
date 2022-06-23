/obj/item/weapon/ranged/wand
	name = "wand"
	desc = "Wingardium Leviosa!"
	desc_extended = "A magic imbued wand that can fit any type of spell gem to amplify and improve its powers."
	icon_state = "inventory"

	value = -1

	var/obj/item/weapon/ranged/spellgem/socketed_spellgem
	var/list/obj/item/supportgem/socketed_supportgems = list()

	automatic = TRUE

	var/wand_damage_multiplier = 1

	dan_mode = TRUE

	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	bypass_balance_check = TRUE

	var/sockets = 2
	var/sockets_max = 7

/obj/item/weapon/ranged/wand/Generate()
	. = ..()
	if(sockets == 0) //Sockets are given in the wild.
		// https://www.desmos.com/calculator/eomhtrxl2v
		var/diceroll = rand(1,1000)
		var/magic_number = (1000/6)**1.25
		sockets = 1 + (diceroll/magic_number)**3.5
		sockets = FLOOR(sockets,1)

/obj/item/weapon/ranged/wand/Destroy()
	QDEL_NULL(socketed_spellgem)
	QDEL_CUT(socketed_supportgems)
	. = ..()

/obj/item/weapon/ranged/wand/get_base_value()
	. = ..()
	// https://www.desmos.com/calculator/bofczfvcar
	. += ((sockets*5)**3)*0.25 + (x**(x-1))*0.2
	. *= wand_damage_multiplier**1.5
	. = CEILING(.,1)


/obj/item/weapon/ranged/wand/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","Has <b>1</b> slot(s) for spell gems.")
	. += div("notice","Has <b>[sockets]</b> slot(s) for support gems.")
	. += div("notice","This wand type increases the power of support gems by [(wand_damage_multiplier-1)*100]%.")

/obj/item/weapon/ranged/wand/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEATOM("socketed_spellgem")
	SAVELISTATOM("socketed_supportgems")

/obj/item/weapon/ranged/wand/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("socketed_spellgem")
	LOADLISTATOM("socketed_supportgems")

/obj/item/weapon/ranged/wand/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1,var/click_called=FALSE)
	if(!socketed_spellgem)
		return FALSE
	return socketed_spellgem.shoot(caller,object,location,params,damage_multiplier*wand_damage_multiplier,click_called)

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

/obj/item/weapon/ranged/wand/branch/socket_test
	value_burgerbux = 9999

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

