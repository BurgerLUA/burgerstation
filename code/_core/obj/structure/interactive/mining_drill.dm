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

	health = /health/construction

	health_base = 1000

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/mining_drill/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 10),/material/steel)
	. = ..()
	qdel(src)
	return .

/obj/structure/interactive/mining_drill/update_icon()

	if(THINKING(src))
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

	if(THINKING(src))
		deactivate(caller)
	else
		activate(caller)

	return TRUE

/obj/structure/interactive/mining_drill/post_move()
	drill_depth = 0
	found_deposit = null
	return .

/obj/structure/interactive/mining_drill/proc/activate(var/mob/caller)
	if(!check_valid())
		caller.to_chat(span("warning","\The [src] doesn't seem to want to turn on!"))
		return FALSE
	if(caller)
		visible_message(span("notice","\The [caller.name] activates \the [src.name]."),span("notice","You activate \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] powers up on its own!."))
	set_anchored(TRUE)
	start_thinking(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/mining_drill/proc/deactivate(var/mob/caller)
	if(caller)
		visible_message(span("notice","\The [caller.name] turns off \the [src.name]."),span("notice","You turn off \the [src.name]."))
	else
		visible_message(span("warning","\The [src.name] shuts itself down!"))
	set_anchored(FALSE)
	stop_thinking(src)
	update_sprite()
	return TRUE


/obj/structure/interactive/mining_drill/proc/check_valid()

	var/valid_setup = FALSE
	for(var/obj/structure/interactive/mining_brace/MB in orange(1,src))
		if(!MB.anchored || get_step(MB,MB.dir) != src.loc)
			continue
		var/obj/structure/interactive/mining_brace/MB2 = locate() in get_step(src,MB.dir).contents
		if(!MB2 || !MB2.anchored || get_step(MB2,MB2.dir) != src.loc)
			continue
		valid_setup = TRUE
		break

	return valid_setup


/obj/structure/interactive/mining_drill/think()

	if(!found_deposit)
		found_deposit = locate() in src.loc

	 if(!anchored || !found_deposit || found_deposit.ore_score <= 0)
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

	health = /health/construction

	health_base = 500

	density = TRUE

/obj/structure/interactive/mining_brace/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 5),/material/steel)
	. = ..()
	qdel(src)
	return .

/obj/structure/interactive/mining_brace/Destroy()
	var/obj/structure/interactive/mining_drill/MD = locate() in get_step(src,dir)
	if(MD)
		MD.check_valid()
	return ..()

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