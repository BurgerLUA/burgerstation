/obj/structure/interactive/disposals/
	icon = 'icons/obj/structure/disposals.dmi'

	var/sorting_tag = null //Give it a sorting tag if this is also a junction.
	var/sorting_tab_label = null //If this goes into the pipe, give it a label if any.

	anchored = TRUE


/obj/structure/interactive/disposals/update_icon()
	name = "[initial(name)] ([sorting_tab_label])"
	return ..()

/obj/structure/interactive/disposals/proc/enter_pipe(var/atom/movable/M)

	if(istype(M,/obj/disposals_container/))
		LOG_ERROR("OH NO.")
		return FALSE

	var/obj/disposals_container/disposals_container = new(src)
	disposals_container.Initialize()

	M.force_move(disposals_container)
	M.glide_size = M.step_size / DECISECONDS_TO_TICKS(1)

	if(sorting_tab_label)
		disposals_container.sorting_tag = sorting_tab_label

	return TRUE

/obj/structure/interactive/disposals/proc/get_connections()
	return list()

/obj/structure/interactive/disposals/clicked_on_by_object(caller,object,location,control,params)
	var/list/connections = get_connections()
	print_list_dir("Connections:",connections)
	return TRUE


