/obj/structure/interactive/crate
	name = "crate"
	desc = "Freight for hauling."
	desc_extended = "A storage container for storing goodies. Also acts as decent cover in a gunfight."
	icon = 'icons/obj/structure/crates.dmi'
	icon_state = "crate"

	anchored = FALSE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	density = TRUE
	layer = LAYER_OBJ_CRATE

	var/open = FALSE

	initialize_type = INITIALIZE_LATE

	bullet_block_chance = 50

	var/collect_contents_on_initialize = TRUE

	var/loot/loot

	value = 300

	can_rotate = FALSE

	size = SIZE_HUMAN

	pixel_y = 8

	var/open_sound = 'sound/effects/click.ogg'
	var/close_sound = 'sound/effects/click.ogg'

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_TURF_CHECKING

/obj/structure/interactive/crate/post_move(var/atom/old_loc)

	. = ..()

	for(var/k in contents)
		var/atom/movable/M = k
		M.post_move(old_loc)


/obj/structure/interactive/crate/on_crush(var/message=TRUE)

	for(var/k in contents)
		var/atom/movable/M = k
		M.on_crush(message)

	. = ..()

/obj/structure/interactive/crate/Exit(atom/movable/O, atom/newloc)

	. = ..()

	if(!open)
		open(null)
		return TRUE


/obj/structure/interactive/crate/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(!open && damage_amount > 20 & luck(src,20 + damage_amount,FALSE))
		visible_message(span("warning","\The [src.name] shoots open!"))
		open(null)

	return ..()

/obj/structure/interactive/crate/Cross(var/atom/movable/O,atom/oldloc)

	if(istype(O,/obj/structure/interactive/crate))
		return FALSE

	if(open)
		return TRUE

	if(!(O.collision_flags && FLAG_COLLISION_ETHEREAL))
		return TRUE

	return ..()

/obj/structure/interactive/crate/Uncross(var/atom/movable/O,atom/newloc)

	if(open)
		return TRUE

	return ..()

/obj/structure/interactive/crate/update_icon()
	icon_state = initial(icon_state)
	if(open)
		icon_state = "[icon_state]_open"

	return ..()

/obj/structure/interactive/crate/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!(caller.attack_flags & CONTROL_MOD_GRAB))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		toggle(caller)
		return TRUE

	return ..()

/obj/structure/interactive/crate/Generate()

	if(collect_contents_on_initialize && !open)
		for(var/k in loc.contents)
			CHECK_TICK(50,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src || M.anchored)
				continue
			if(M.loc != src.loc)
				continue
			if(can_prevent_close(M))
				continue
			M.Move(src)

	update_sprite()

	return ..()

/obj/structure/interactive/crate/proc/toggle(var/mob/caller)
	return open ? close(caller) : open(caller)

/obj/structure/interactive/crate/proc/can_store(var/atom/movable/M)
	if(M.anchored)
		return FALSE
	if(M.size > src.size)
		return FALSE
	if(!is_living(M) && !is_item(M))
		return FALSE
	if(is_player(M))
		var/mob/living/advanced/player/playerCorpse = M
		if(playerCorpse.dead)
			visible_message(span("warning", "\The [playerCorpse.name] hilariously looses balance and falls out of the crate!"))
			return FALSE
	return TRUE

/obj/structure/interactive/crate/proc/can_prevent_close(var/atom/movable/M)
	if(is_living(M))
		var/mob/living/L = M
		if(!L.horizontal || L.size > size)
			return TRUE
	return FALSE

/obj/structure/interactive/crate/proc/close(var/mob/caller)

	if(qdeleting)
		return FALSE

	if(src.health && src.health.health_current <= 0)
		return FALSE

	if(!src.z)
		if(loc) caller?.to_chat(span("warning","\The [loc.name] is preventing \the [src.name] from being closed!"))
		return FALSE

	var/atom/blocking
	for(var/k in loc.contents)
		var/atom/movable/M = k
		if(can_prevent_close(M))
			blocking = M
			break

	if(blocking)
		caller.to_chat(span("warning","\The [blocking.name] is preventing \the [src.name] from being closed!"))
		return FALSE

	var/total_size = 0
	for(var/k in loc.contents)
		var/atom/movable/M = k
		CHECK_TICK(50,FPS_SERVER)
		if(M == src)
			continue
		if(M.loc != src.loc)
			continue
		if(!can_store(M))
			continue
		M.Move(src)
		if(total_size + M.size > size)
			break
		total_size += M.size

	open = FALSE

	play_sound(close_sound,get_turf(src),range_max=VIEW_RANGE)

	update_sprite()

	return TRUE

/obj/structure/interactive/crate/proc/open(var/mob/caller)

	if(!src.z)
		if(loc) caller?.to_chat(span("warning","\The [loc.name] is preventing \the [src.name] from being opened!"))
		return FALSE

	if(loot)
		var/rarity = 0
		if(is_player(caller))
			var/mob/living/advanced/player/P = caller
			rarity = P.get_rarity()
		SPAWN_LOOT(loot,src.loc,rarity)
		loot = null

	for(var/k in contents)
		CHECK_TICK(50,FPS_SERVER)
		var/atom/movable/M = k
		if(!M.force_move(src.loc))
			log_error("Warning: [M.get_debug_name()] is stuck in a crate!")
		else if(is_item(M))
			M.pixel_y = initial(M.pixel_y) + src.pixel_y

	open = TRUE

	play_sound(open_sound,get_turf(src),range_max=VIEW_RANGE)

	update_sprite()

	return TRUE