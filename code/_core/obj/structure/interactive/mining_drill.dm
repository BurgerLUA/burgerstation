/obj/structure/interactive/mining_drill
	name = "mining drill"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_drill"
	anchored = FALSE

	var/drill_depth = 0
	var/drill_counter = 0

	var/obj/structure/interactive/ground_ore_deposit/found_deposit

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

/obj/structure/interactive/mining_drill/update_icon()

	if(THINKING(src))
		icon_state = "mining_drill_active"
	else if(anchored)
		icon_state = "mining_drill_braced"
	else
		icon_state = "mining_drill"

	return ..()

/obj/structure/interactive/mining_drill/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(THINKING(src))
		deactivate(caller)
	else
		activate(caller)

	return ..()

/obj/structure/interactive/mining_drill/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	. = ..()

	if(.)
		drill_depth = 0
		found_deposit = null

	return .

/obj/structure/interactive/mining_drill/proc/activate(var/mob/caller)

	if(!check_valid())
		caller.to_chat("\The [src] doesn't seem to want to turn on!")
		return FALSE

	if(caller)
		visible_message("\The [caller.name] activates \the [src.name].")
	else
		visible_message("\The [src.name] activates itself.")
	anchored = TRUE
	start_thinking(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/mining_drill/proc/deactivate(var/mob/caller)

	if(caller)
		visible_message("\The [caller.name] turns off \the [src.name].")
	else
		visible_message("\The [src.name] turns off on its own.")
	anchored = FALSE
	stop_thinking(src)
	update_sprite()
	return TRUE


/obj/structure/interactive/mining_drill/proc/check_valid()

	var/valid_setup = FALSE
	for(var/obj/structure/interactive/mining_brace/MB in orange(1,src))
		if(!MB.anchored)
			continue
		if(get_step(MB,MB.dir) != src.loc)
			continue
		var/obj/structure/interactive/mining_brace/MB2 = locate() in get_step(src,MB.dir).contents
		if(!MB2 || !MB.anchored)
			continue

		valid_setup = TRUE
		break

	return valid_setup


/obj/structure/interactive/mining_drill/think()

	if(!found_deposit)
		found_deposit = locate() in src.loc

	 if(!anchored || !check_valid() || !found_deposit || found_deposit.ore_score <= 0)
	 	deactivate()
	 	return FALSE

	drill_depth++
	if(drill_depth >= 100)
		drill_counter++
		if(drill_counter > 30)
			found_deposit.mine()
			drill_counter = 0

	return TRUE

/obj/structure/interactive/mining_brace
	name = "mining brace"
	icon = 'icons/obj/structure/big_drill.dmi'
	icon_state = "mining_brace"
	anchored = FALSE

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 50

/obj/structure/interactive/mining_brace/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(caller.movement_flags & MOVEMENT_WALKING)
		if(anchored)
			caller.to_chat("Unsecure \the [src.name] before rotating it!")
		else
			caller.to_chat("You rotate \the [src.name].")
			set_dir(turn(dir,90))
		return TRUE

	var/obj/structure/interactive/mining_drill/MD = locate() in get_step(src,dir)
	if(MD && MD.anchored)
		caller.to_chat(span("warning","You need to disable the mining drill first before moving this!"))
		return TRUE

	anchored = !anchored

	if(anchored)
		caller.visible_message("\The [caller.name] secures \the [src.name].","You secure \the [src.name].")
	else
		caller.visible_message("\The [caller.name] unsecures \the [src.name].","You unsecure \the [src.name].")

	update_sprite()

	return TRUE

/obj/structure/interactive/mining_brace/update_icon()

	if(anchored)
		icon_state = "mining_brace_active"
	else
		icon_state = "mining_brace"

	return ..()