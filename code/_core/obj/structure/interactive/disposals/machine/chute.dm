/obj/structure/interactive/disposals/machine/chute
	name = "disposals chute"
	desc = "Express delivery!"
	desc_extended = "Throw trash in here."
	icon_state = "disposal"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	var/disposals_countdown = SECONDS_TO_DECISECONDS(10)

	bullet_block_chance = 50

	density = TRUE

/obj/structure/interactive/disposals/machine/chute/think()

	if(disposals_countdown <= 0)
		var/obj/disposals_container/disposals_container = new(src)
		disposals_container.sorting_tag = "disposals"
		INITIALIZE(disposals_container)
		GENERATE(disposals_container)
		FINALIZE(disposals_container)
		for(var/atom/movable/M in src.contents)
			M.force_move(disposals_container)
		stop_thinking(src)
		disposals_countdown = initial(disposals_countdown)
		flick("disposal-flush",src)
		stop_thinking(src)

	disposals_countdown--

	return TRUE

/obj/structure/interactive/disposals/machine/chute/Crossed(atom/movable/O)
	O.force_move(src)
	start_thinking(src)
	return ..()

/obj/structure/interactive/disposals/machine/chute/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_item(object))
		var/obj/item/I = object
		I.drop_item(src)

	return ..()

/obj/structure/interactive/disposals/machine/chute/drop_on_object(var/mob/caller,var/atom/object,location,control,params)
	//Todo, interact delay.
	if(ismob(object) && caller == object)
		INTERACT_CHECK
		INTERACT_CHECK_OTHER(object)
		var/mob/living/L = object
		L.force_move(src)
		start_thinking(src)
		return TRUE

	return ..()