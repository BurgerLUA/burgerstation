/obj/structure/interactive/mining_drill
	name = "mining drill"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_drill"
	anchored = FALSE

	var/drill_depth = 0
	var/drill_counter = 0
	can_rotate = FALSE

	var/obj/structure/interactive/ore_deposit_ground/found_deposit

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	health = /health/construction

	health_base = 1000

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/mining_drill/Destroy()
	found_deposit = null
	. = ..()

/obj/structure/interactive/mining_drill/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 10),/material/steel)
	. = ..()
	qdel(src)

/obj/structure/interactive/mining_drill/update_icon()

	if(IS_THINKING(src))
		icon_state = "mining_drill_active"
	else if(anchored)
		icon_state = "mining_drill_braced"
	else
		icon_state = "mining_drill"

	return ..()

/obj/structure/interactive/mining_drill/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(IS_THINKING(src))
		deactivate(caller)
	else
		activate(caller)

	return TRUE

/obj/structure/interactive/mining_drill/post_move(var/atom/old_loc)
	. = ..()
	drill_depth = 0
	found_deposit = null

/obj/structure/interactive/mining_drill/proc/activate(var/mob/caller)
	if(!check_valid())
		caller.to_chat(span("warning","\The [src] doesn't seem to want to turn on!"))
		return FALSE
	if(caller)
		visible_message(span("notice","\The [caller.name] activates \the [src.name]."),span("notice","You activate \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] powers up on its own!."))
	set_anchored(TRUE)
	START_THINKING(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/mining_drill/proc/deactivate(var/mob/caller)
	if(caller)
		visible_message(span("notice","\The [caller.name] turns off \the [src.name]."),span("notice","You turn off \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] shuts itself down!"))
	set_anchored(FALSE)
	STOP_THINKING(src)
	update_sprite()
	return TRUE


/obj/structure/interactive/mining_drill/proc/check_valid()

	for(var/obj/structure/interactive/mining_brace/MB in orange(1,src))
		if(!MB.anchored || get_step(MB,MB.dir) != src.loc)
			continue
		var/obj/structure/interactive/mining_brace/MB2 = locate() in get_step(src,MB.dir).contents
		if(!MB2 || !MB2.anchored || get_step(MB2,MB2.dir) != src.loc)
			continue
		return TRUE

	return FALSE

/obj/structure/interactive/mining_drill/think()

	if(!found_deposit)
		found_deposit = locate() in src.loc

	 if(!anchored || !found_deposit || found_deposit.ore_count <= 0 || found_deposit.qdeleting)
	 	deactivate()
	 	found_deposit = null
	 	return FALSE

	drill_depth++
	if(drill_depth >= 100)
		drill_counter++
		if(drill_counter > 30)
			found_deposit.drop_ore()
			drill_counter = 0

	return TRUE

/obj/structure/interactive/mining_brace
	name = "mining brace"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_brace"
	anchored = FALSE

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 50

	health = /health/construction

	health_base = 500

	density = TRUE

/obj/structure/interactive/mining_brace/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 5),/material/steel)
	. = ..()
	qdel(src)

/obj/structure/interactive/mining_brace/Destroy()
	var/obj/structure/interactive/mining_drill/MD = locate() in get_step(src,dir)
	MD?.check_valid()
	. = ..()

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
