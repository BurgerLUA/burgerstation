/obj/structure/interactive/mining_drill
	name = "mining drill"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_drill"
	anchored = FALSE

	can_rotate = FALSE

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	health = /health/construction

	health_base = 1000

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

	plane = PLANE_MOVABLE
	layer = LAYER_LARGE_OBJ

	var/obj/structure/interactive/ore_deposit/floor/found_deposit
	var/atom/drop_atom
	var/list/obj/structure/interactive/mining_brace/attached_braces = list()

/obj/structure/interactive/mining_drill/PreDestroy()
	CALLBACK_REMOVE("\ref[src]_do_drill")
	SShorde.all_drills -= src
	. = ..()

/obj/structure/interactive/mining_drill/Destroy()
	. = ..()
	found_deposit = null
	drop_atom = null
	attached_braces.Cut()
	attached_braces = null



/obj/structure/interactive/mining_drill/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 5),/material/steel)
	. = ..()
	qdel(src)

/obj/structure/interactive/mining_drill/update_icon()

	. = ..()

	if(CALLBACK_EXISTS("\ref[src]_do_drill"))
		icon_state = "mining_drill_active"
	else if(anchored)
		icon_state = "mining_drill_braced"
	else
		icon_state = "mining_drill"



/obj/structure/interactive/mining_drill/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(CALLBACK_EXISTS("\ref[src]_do_drill"))
		deactivate(caller)
	else
		activate(caller)

	return TRUE

/obj/structure/interactive/mining_drill/post_move(var/atom/old_loc)
	. = ..()
	if(. && CALLBACK_EXISTS("\ref[src]_do_drill")) deactivate()

/obj/structure/interactive/mining_drill/proc/activate(var/mob/caller)

	if(!check_braces())
		caller.to_chat(span("warning","\The [src] doesn't seem to want to turn on!"))
		return FALSE

	if(caller)
		visible_message(span("notice","\The [caller.name] activates \the [src.name]."),span("notice","You activate \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] powers up!"))

	SShorde.all_drills[src] = world.time + SECONDS_TO_DECISECONDS(15)
	set_anchored(TRUE)
	CALLBACK("\ref[src]_do_drill",SECONDS_TO_DECISECONDS(1.8),src,src::do_drill())
	update_sprite()

	return TRUE

/obj/structure/interactive/mining_drill/proc/deactivate(var/mob/caller)

	if(caller)
		visible_message(span("notice","\The [caller.name] turns off \the [src.name]."),span("notice","You turn off \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] powers down!"))

	SShorde.all_drills -= src
	found_deposit = null
	drop_atom = null
	attached_braces.Cut()
	set_anchored(FALSE)
	CALLBACK_REMOVE("\ref[src]_do_drill")
	update_sprite()

	return TRUE

/obj/structure/interactive/mining_drill/proc/is_valid_brace(var/obj/structure/interactive/mining_brace/MB)
	return MB && MB.anchored && get_step(MB,MB.dir) == src.loc

/obj/structure/interactive/mining_drill/proc/check_braces()

	attached_braces.Cut()

	for(var/obj/structure/interactive/mining_brace/MB1 in orange(1,src))
		if(!is_valid_brace(MB1))
			continue
		var/obj/structure/interactive/mining_brace/MB2 = locate() in get_step(src,MB1.dir).contents
		if(!is_valid_brace(MB2))
			continue
		attached_braces += MB1
		attached_braces += MB2
		return TRUE

	return FALSE

/obj/structure/interactive/mining_drill/proc/do_drill()

	var/turf/current_turf = get_turf(src)

	//Check if it's actually anchored.
	if(!anchored || !current_turf)
		deactivate()
		return FALSE

	//Check for the braces.
	for(var/k in attached_braces)
		var/obj/structure/interactive/mining_brace/MB = k
		if(!is_valid_brace(MB))
			deactivate()
			return FALSE

	//Deposit checking.
	if(found_deposit && found_deposit.qdeleting)
		found_deposit = null

	if(!found_deposit) //Check the turf it is on.
		found_deposit = locate() in current_turf

	if(!found_deposit) //Check adjacent turfs.
		found_deposit = locate() in orange(1,current_turf)

	if(!found_deposit)
		deactivate()
		return FALSE

	//Figure out the drop atom.
	if(drop_atom && get_dist(current_turf,drop_atom) > 1)
		drop_atom = null

	if(!drop_atom)
		var/obj/structure/interactive/ore_box/OB = locate() in orange(1,current_turf)
		if(OB)
			drop_atom = OB

	//Fallback #1
	if(!drop_atom)
		for(var/d in list(SOUTH,NORTH,EAST,WEST))
			var/turf/T = get_step(current_turf,d)
			if(T.density || T.has_dense_atom)
				continue
			drop_atom = T
			break

	//Fallback #2
	if(!drop_atom)
		drop_atom = current_turf

	//Finally, create the ore.
	if(!found_deposit.create_ore(null,drop_atom,3))
		return null

	play_sound('sound/machines/mining_drill.ogg',current_turf)

	CALLBACK("\ref[src]_do_drill",SECONDS_TO_DECISECONDS(1.8),src,src::do_drill())

	return TRUE

/obj/structure/interactive/mining_brace
	name = "mining brace"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_brace"
	anchored = FALSE

	plane = PLANE_MOVABLE
	layer = LAYER_LARGE_OBJ

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 50

	health = /health/construction

	health_base = 500

	density = TRUE

/obj/structure/interactive/mining_brace/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 5),/material/steel)
	. = ..()
	qdel(src)

/obj/structure/interactive/mining_brace/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(caller.movement_flags & MOVEMENT_WALKING)
		if(anchored)
			caller.to_chat(span("warning","You need to unsecure \the [src.name] before rotating it!"))
		else
			caller.visible_message(span("notice","\The [caller.name] rotates \the [src.name]."),span("notice","You rotate \the [src.name]."))
			set_dir(turn(dir,90))
		return TRUE

	var/obj/structure/interactive/mining_drill/MD = locate() in get_step(src,dir)
	if(MD && MD.anchored)
		caller.to_chat(span("warning","You need to disable the mining drill first before moving this!"))
		return TRUE

	set_anchored(!anchored)

	if(anchored)
		caller.visible_message(span("notice","\The [caller.name] secures \the [src.name]."),span("notice","You secure \the [src.name]."))
	else
		caller.visible_message(span("notice","\The [caller.name] unsecures \the [src.name]."),span("notice","You unsecure \the [src.name]."))

	update_sprite()

	return TRUE

/obj/structure/interactive/mining_brace/update_icon()

	if(anchored)
		icon_state = "mining_brace_active"
	else
		icon_state = "mining_brace"

	return ..()
