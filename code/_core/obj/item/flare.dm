/obj/item/flare
	name = "flare"
	desc = "Light your way."
	desc_extended = "A high power portable flare stick meant to light dark areas. Lasts about 5 minutes. Instructions: Remove cap, strike rough black part of cap against the red igniter pad, throw flare."
	icon = 'icons/obj/item/flare.dmi'
	icon_state = "flare"

	var/obj/item/flare_cap/stored_cap

	var/ignited = FALSE
	var/has_fuel = TRUE

	desired_light_range = VIEW_RANGE*0.75
	desired_light_power = 1
	desired_light_color = "#FF7777"

	size = SIZE_1

	value = 20

/obj/item/flare/Destroy()
	QDEL_NULL(stored_cap)
	. = ..()

/obj/item/flare/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_cap")
	SAVEVAR("ignited")
	SAVEVAR("has_fuel")

/obj/item/flare/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_cap")
	LOADVAR("ignited")
	LOADVAR("has_fuel")

/obj/item/flare/Finalize()
	. = ..()
	update_sprite()

/obj/item/flare/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/flare_cap/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(is_living(caller))
			var/mob/living/L = caller
			if(L.attack_flags & CONTROL_MOD_DISARM)
				stored_cap.drop_item(src)
				stored_cap = object
				caller.to_chat(span("notice","You put \the [object.name] back on \the [src.name]."))
				play_sound('sound/items/flare_cap.ogg',get_turf(src))
				return TRUE
		ignite(caller)
		return TRUE

	if(stored_cap && istype(object,/obj/hud/inventory) && is_advanced(caller))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		var/mob/living/advanced/A = caller
		A.put_in_hands(stored_cap)
		caller.to_chat(span("notice","You remove \the [stored_cap.name] from \the [src.name]."))
		play_sound('sound/items/flare_cap.ogg',get_turf(src))
		stored_cap = null
		update_sprite()
		return TRUE

	. = ..()

/obj/item/flare/post_move(var/atom/old_loc)

	. = ..()

	if(is_inventory(old_loc) != is_inventory(loc))
		update_sprite()


/obj/item/flare/proc/ignite(var/mob/caller)

	if(!has_fuel)
		caller.to_chat(span("warning","\The [src.name] is spent!"))
		return FALSE

	if(ignited)
		if(caller)
			if(prob(1))
				caller.to_chat(span("warning","\The [src.name] is already lit af!"))
			else
				caller.to_chat(span("warning","\The [src.name] is already lit!"))
		return FALSE

	ignited = TRUE

	caller?.visible_message(span("notice","\The [caller.name] ignites \the [src.name]."),span("notice","You ignite \the [src.name]."))

	var/flare_time = rand(280,320)
	CALLBACK("\ref[src]_flare_time",SECONDS_TO_DECISECONDS(flare_time),src,.proc/expire)

	play_sound('sound/items/flare_in.ogg',get_turf(src))

	update_sprite()
	update_atom_light()

	return TRUE

/obj/item/flare/proc/expire()
	ignited = FALSE
	has_fuel = FALSE
	update_sprite()
	update_atom_light()
	play_sound('sound/items/flare_out.ogg',get_turf(src))
	return TRUE

/obj/item/flare/update_atom_light()

	if(ignited)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)

	return TRUE

/obj/item/flare/get_base_transform()
	. = ..()
	if(is_inventory(loc))
		var/matrix/M = .
		M.Turn(90)

/obj/item/flare/update_sprite()
	. = ..()
	transform = get_base_transform()
	update_held_icon()

/obj/item/flare/update_icon()

	. = ..()

	if(has_fuel)
		icon_state = "flare"
	else
		icon_state = "flare_spent"


/obj/item/flare/update_overlays()

	. = ..()

	if(stored_cap)
		var/image/I = new/image(icon,"cap")
		add_overlay(I)

	if(ignited)
		var/image/I = new/image(icon,"fire")
		add_overlay(I)
		/*
		var/image/I2 = new/image(icon,"lense")
		I2.pixel_x = -8
		I2.blend_mode = BLEND_ADD
		add_overlay(I2)
		*/

/obj/item/flare/Generate()
	. = ..()
	stored_cap = new(src)
	INITIALIZE(stored_cap)
	GENERATE(stored_cap)
	FINALIZE(stored_cap)

/obj/item/flare_cap
	name = "flare cap"
	desc = "Do not swallow."
	desc_extended = "A discarded flare cap with a rough striker on the top of it."
	icon = 'icons/obj/item/flare.dmi'
	icon_state = "cap"

	size = SIZE_1

	value = 1