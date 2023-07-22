/obj/item/halo/mortar
	name = "portable pointing device"
	desc = "When you need things delivered."
	desc_extended = "A special remote designed to burn the battlefield."
	icon = 'icons/obj/item/supply_remote_mech.dmi'
	icon_state = "inventory"

	var/charges = 6

	value = 1000

	weight = 4

/obj/item/halo/mortar/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("charges")
	return .

/obj/item/halo/mortar/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("charges")
	return .

/obj/item/halo/mortar/get_value()
	return  charges ? charges * value : 10

/obj/item/halo/mortar/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(120)

	if(charges <= 0)
		caller.to_chat(span("warning","There are no charges left in \the [src.name]!"))
		return TRUE

	charges--

	var/turf/T = get_turf(object)

	var/amount_multiplier = FLOOR(10 + 20, 1)

	for(var/i=1,i<=amount_multiplier,i++)
		new/obj/effect/temp/target/(T)
		new/obj/effect/falling_fireball(T)
		play_sound('sound/effects/mortar_long_whistle.ogg',get_turf(src),range_min = VIEW_RANGE*0.5,range_max = VIEW_RANGE * 2)

	return TRUE