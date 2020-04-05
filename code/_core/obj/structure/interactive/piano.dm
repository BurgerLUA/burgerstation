/obj/structure/interactive/piano
	name = "piano"
	var/song/current_song


/obj/structure/interactive/piano/Initialize()

	current_song = new(src)

	return ..()

/obj/structure/interactive/piano/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(caller && current_song)
		current_song.interact(caller)

	return TRUE