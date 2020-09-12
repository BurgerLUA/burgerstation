/obj/structure/interactive/disposals/
	icon = 'icons/obj/structure/disposals.dmi'

	var/sorting_tag = null //Give it a sorting tag if this is also a junction.
	var/sorting_tab_label = null //If this goes into the pipe, give it a label if any.

	anchored = TRUE

/obj/structure/interactive/disposals/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/disposals/update_icon()

	if(sorting_tab_label)
		name = "[initial(name)] ([sorting_tab_label])"
	else
		name = initial(name)

	return ..()

/obj/structure/interactive/disposals/proc/enter_pipe(var/atom/movable/M)

	if(istype(M,/obj/disposals_container/))
		return FALSE

	var/obj/disposals_container/disposals_container = locate() in src.contents
	if(!disposals_container)
		disposals_container = new(src)
		INITIALIZE(disposals_container)
		GENERATE(disposals_container)
		FINALIZE(disposals_container)

	M.force_move(disposals_container)
	M.glide_size = M.step_size / DECISECONDS_TO_TICKS(1)

	if(sorting_tab_label)
		disposals_container.sorting_tag = sorting_tab_label

	return TRUE

/obj/structure/interactive/disposals/proc/get_connections()
	return list()

