/obj/item/cassette_player
	name = "cassette player"
	desc = "Finally, some good fucking music."
	desc_extended = "Old cassette player that can play pre-recorded songs. Use it in hand to start playing it for yourself to hear, or turn the currently playing song off."
	icon = 'icons/obj/item/tape.dmi'
	icon_state = "taperecorder_empty"
	value = 1000
	value_burgerbux = 1
	rarity = RARITY_RARE
	weight = 1
	size = SIZE_1

	var/mob/current_hearer
	var/obj/item/cassette_tape/stored_tape
	var/playing = FALSE

/obj/item/cassette_player/get_examine_list(var/mob/examiner)
	. = ..()
	if(stored_tape)
		. += div("notice","It currently holding [stored_tape.name] inside.")
	. += div("notice","It is currently [playing ? "playing" : "not playing"].")

/obj/item/cassette_player/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_tape")

/obj/item/cassette_player/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_tape")

/obj/item/cassette_player/Finalize()
	. = ..()
	update_sprite()

/obj/item/cassette_player/update_icon()
	. = ..()
	if(!stored_tape)
		icon_state = "taperecorder_empty"
	else if(playing)
		icon_state = "taperecorder_playing"
	else
		icon_state = "taperecorder_idle"

/obj/item/cassette_player/proc/disable()
	if(current_hearer && current_hearer.client)
		stop_music_track(current_hearer.client)
		if(playing) current_hearer.to_chat(span("notice","\The [src.name] turns off."))
		HOOK_REMOVE("post_move","loc_check_\ref[src]",current_hearer)
		CALLBACK_REMOVE("tape_stop_\ref[src]")
	playing = FALSE
	update_sprite()

/obj/item/cassette_player/proc/enable()
	if(current_hearer && current_hearer.client)
		var/track/T = SStrack.all_tracks[stored_tape.stored_track]
		if(!T)
			return
		play_music_track(stored_tape.stored_track,current_hearer.client)
		if(!playing) current_hearer.to_chat(span("notice","\The [src.name] turns on."))
		HOOK_ADD("post_move","loc_check_\ref[src]",current_hearer,src,.proc/check_valid)
		CALLBACK("tape_stop_\ref[src]",SECONDS_TO_DECISECONDS(T.length),src,.proc/disable)
	playing = TRUE
	update_sprite()


/obj/item/cassette_player/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(istype(object,/obj/item/cassette_tape))
		disable()
		var/obj/item/old_tape
		if(stored_tape)
			old_tape = stored_tape
			old_tape.drop_item(get_turf(src))
			caller.to_chat(span("notice","You eject \the [old_tape.name] from \the [src.name]."))
			stored_tape = null
		stored_tape = object
		stored_tape.drop_item(src)
		caller.to_chat(span("notice","You insert \the [stored_tape.name] into \the [src.name]."))
		if(old_tape && is_advanced(caller))
			var/mob/living/advanced/A = caller
			A.put_in_hands(stored_tape,left = params["left"])
		return TRUE

	if(is_inventory(object))
		disable()
		var/obj/hud/inventory/I = object
		caller.to_chat(span("notice","You eject \the [stored_tape.name] from \the [src.name]."))
		I.add_object(stored_tape)
		stored_tape = null
		return TRUE

	. = ..()

/obj/item/cassette_player/click_self(var/mob/caller,var/atom/object)

	INTERACT_CHECK
	INTERACT_DELAY(20)

	if(playing)
		disable()
	else if(!stored_tape || !stored_tape.stored_track)
		caller.to_chat(span("warning","There is no tape to play in \the [src.name]!"))
	else
		if(is_inventory(src.loc))
			var/obj/hud/inventory/I = src.loc
			if(I.essential)
				current_hearer = I.owner
				enable()

/obj/item/cassette_player/proc/check_valid()

	if(!current_hearer)
		disable()
		return FALSE

	if(get_turf(src) != get_turf(current_hearer))
		disable()
		return FALSE

	return TRUE

/obj/item/cassette_player/post_move(var/atom/old_loc)
	. = ..()
	check_valid()


/obj/item/cassette_tape
	name = "cassette tape"
	var/track/stored_track
	icon = 'icons/obj/item/tape.dmi'
	icon_state = "tape_white"

	value = 200

/obj/item/cassette_tape/Finalize()
	. = ..()
	if(stored_track)
		var/track/T = SStrack.all_tracks[stored_track]
		if(T)
			name = "[initial(name)]: [T.name]"

/obj/item/cassette_tape/Generate()
	. = ..()
	if(!stored_track)
		stored_track = pick(SStrack.all_tracks)
		icon_state = "tape_blue"

/obj/item/cassette_tape/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEPATH("stored_track")

/obj/item/cassette_tape/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADPATH("stored_track")