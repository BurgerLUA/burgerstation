/obj/item/hope
	name = "beacon of hope"
	desc = "For when all is lost."
	desc_extended = "A magical beacon that can be used to resurrect any allied humanoid to full health, once every 15 minutes. Use on a corpse to trigger resurrection."

	rarity = RARITY_MYTHICAL

	icon = 'icons/obj/item/hope.dmi'
	icon_state = "inventory"

	var/next_resurrect = 0

	value = 8000

/obj/item/hope/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("next_resurrect")

/obj/item/hope/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("next_resurrect")

/obj/item/hope/Finalize()
	. = ..()
	check_resurrection(make_sound=FALSE)

/obj/item/hope/update_sprite()
	. = ..()
	icon_state = initial(icon_state)
	if(next_resurrect > world.realtime)
		icon_state = "[icon_state]_drained"

/obj/item/hope/proc/check_resurrection(var/make_sound=TRUE)

	if(next_resurrect <= world.realtime)
		update_sprite()
		if(make_sound)
			var/turf/T = get_turf(src)
			T.visible_message(span("notice","\The [src.name] chimes as it is ready to be used again."))
			play_sound('sound/weapons/magic/creation.ogg',T)
	else
		CALLBACK("\ref[src]_check_ressurection",SECONDS_TO_DECISECONDS(60),src,.proc/check_resurrection)

/obj/item/hope/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(object))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = object

	if(!A.dead || !A.is_player_controlled())
		caller.to_chat(span("warning","You can't seem to use this on \the [A.name]..."))
		return FALSE

	A.resurrect()

	play_sound('sound/weapons/magic/heal.ogg',get_turf(object))

	A.visible_message(
		span("notice","\The [A.name] was resurrected with \the [src.name] by \the [caller.name]!"),
		span("notice","You were resurrected with \the [src.name] by \the [caller.name]!")
	)

	next_resurrect = world.realtime + SECONDS_TO_DECISECONDS(60)*15 //15 minutes.

	update_sprite()
	check_resurrection()

	return TRUE