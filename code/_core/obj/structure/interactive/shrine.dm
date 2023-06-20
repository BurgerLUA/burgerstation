var/global/list/all_rituals = list()

var/global/list/possible_ritual_spawns = list(
	/mob/living/advanced/npc/beefman = 20,
	/mob/living/simple/devil = 15,
	/mob/living/simple/bear/space = 20,
	/mob/living/simple/clockwork_marauder = 20,
	/mob/living/simple/halloween_spirit = 40,
	/mob/living/simple/spider/twilight = 15
)

/obj/structure/interactive/ritual
	name = "ritual shrine"
	desc = "Pray at the shrine, if you dare."
	desc_extended = "An occult ritual shrine constructed to honor the gods of battle. Activating it will trap the user in an arena and force them and anyone around them to fight for their life."
	icon = 'icons/obj/structure/shrine.dmi'
	icon_state = "icon"

	pixel_x = -16
	pixel_y = -8

	var/list/connected_smoke = list()

	density = TRUE

	var/ritual_size = VIEW_RANGE

	var/mob/living/enemy_type_to_spawn
	var/spawns_left = 0
	var/list/tracked_enemies = list()
	var/list/valid_turfs = list()
	var/list/tracked_players = list()
	var/next_enemy_spawn = 0

	var/complete = FALSE //Set to true if the ritual is complete.

	enable_chunk_handling = TRUE
	enable_chunk_clean = TRUE


/obj/structure/interactive/ritual/New(var/desired_loc)
	all_rituals += src
	. = ..()

/obj/structure/interactive/ritual/on_chunk_clean()
	if(complete)
		var/turf/T = get_turf(src)
		if(T) CREATE(/obj/structure/interactive/ritual,T) //Yeah I could just make the current one fresh but uh you know. Shitcode.
		qdel(src)
		return TRUE
	return FALSE

/obj/structure/interactive/ritual/PreDestroy()
	all_rituals -= src
	end_ritual()
	. = ..()

/obj/structure/interactive/ritual/Destroy()
	valid_turfs.Cut()
	valid_turfs = null
	. = ..()

/obj/structure/interactive/ritual/proc/remove_mob(var/mob/living/L,args)
	tracked_enemies -= L
	HOOK_REMOVE("post_death","\ref[src]_post_death",L)
	HOOK_REMOVE("Destroy","\ref[src]_destroy",L)
	HOOK_REMOVE("post_move","\ref[src]_post_move",L)
	if(length(tracked_enemies) <= 0 && IS_THINKING(src))
		end_ritual(TRUE)
	return TRUE

/obj/structure/interactive/ritual/proc/remove_player(var/mob/living/advanced/player/P,args)
	tracked_players -= P
	HOOK_REMOVE("post_death","\ref[src]_post_death",P)
	HOOK_REMOVE("Destroy","\ref[src]_destroy",P)
	HOOK_REMOVE("post_move","\ref[src]_post_move",P)
	if(length(tracked_players) <= 0 && IS_THINKING(src))
		end_ritual()
	return TRUE

/obj/structure/interactive/ritual/proc/check_valid_mob_position(var/mob/living/L,args)
	var/turf/T = get_turf(L)
	if(T.z != src.z || get_dist(T,src) > VIEW_RANGE)
		remove_mob(L)

/obj/structure/interactive/ritual/proc/check_valid_player_position(var/mob/living/advanced/player/P,args)
	var/turf/T = get_turf(P)
	if(T.z != src.z || get_dist(T,src) > VIEW_RANGE)
		remove_player(P)

/obj/structure/interactive/ritual/think()

	if(complete)
		return FALSE //Something went wrong.

	if(next_enemy_spawn > 0 && next_enemy_spawn <= world.time && spawns_left > 0 && (next_enemy_spawn + SECONDS_TO_DECISECONDS(20) <= world.time || length(tracked_enemies) < CEILING(possible_ritual_spawns[enemy_type_to_spawn]*0.2,1)))
		spawns_left--
		next_enemy_spawn = world.time + SECONDS_TO_DECISECONDS(2)
		var/turf/simulated/T = pick(valid_turfs)
		var/mob/living/L = new enemy_type_to_spawn(T)
		L.delete_on_death = TRUE
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		tracked_enemies += L
		HOOK_ADD("post_death","\ref[src]_post_death",L,src,src::remove_mob())
		HOOK_ADD("Destroy","\ref[src]_destroy",L,src,src::remove_mob())
		HOOK_ADD("post_move","\ref[src]_post_move",L,src,src::check_valid_mob_position())
		if(L.ai && length(tracked_players))
			var/mob/living/advanced/player/P = pick(tracked_players)
			L.ai.set_objective(P)
		play_sound('sound/effects/manifest.ogg',T)

	return TRUE

/obj/structure/interactive/ritual/proc/start_ritual(var/mob/caller)

	for(var/mob/living/advanced/player/P in range(src,ritual_size))
		if(!P || P.dead || P.qdeleting)
			continue
		tracked_players += P
		HOOK_ADD("post_death","\ref[src]_post_death",P,src,src::remove_player())
		HOOK_ADD("Destroy","\ref[src]_destroy",P,src,src::remove_player())
		HOOK_ADD("post_move","\ref[src]_post_move",P,src,src::check_valid_player_position())
		CHECK_TICK(50,FPS_SERVER)

	if(!length(tracked_players))
		log_error("Could not start [src.get_debug_name()], no found players!")
		return FALSE

	if(!length(valid_turfs)) //Something went wrong.
		log_error("Could not find any good edge turfs for [src.get_debug_name()]. Choosing random ones...")
		for(var/turf/simulated/floor/F in orange(src,ritual_size-1))
			valid_turfs += F
		if(!length(valid_turfs)) //Ok, I give up.
			log_error("Could not start [src.get_debug_name()], no valid turfs!")
			return FALSE

	caller?.visible_message(span("danger","\The [caller.name] activates \the [src.name]!"),span("danger","You activate \the [src.name]!"))
	play_sound('sound/effects/ritual_start.ogg',get_turf(src))

	enemy_type_to_spawn = pickweight(possible_ritual_spawns)
	spawns_left = possible_ritual_spawns[enemy_type_to_spawn]
	create_smoke()
	START_THINKING(src)
	next_enemy_spawn = world.time + SECONDS_TO_DECISECONDS(6)
	return TRUE

/obj/structure/interactive/ritual/proc/end_ritual(var/success = FALSE)

	STOP_THINKING(src)

	for(var/k in tracked_players)
		var/mob/living/advanced/player/P = k
		remove_player(P)

	for(var/k in tracked_enemies)
		var/mob/living/L = k
		qdel(L) //removes via hook call.

	for(var/k in connected_smoke)
		var/atom/movable/M = k
		qdel(M)
		connected_smoke -= M

	complete = TRUE
	animate(src,color="#444444",time=10)

	if(success)
		create_gold_drop(get_turf(src),500)


/obj/structure/interactive/ritual/proc/create_smoke()

	for(var/ix=-ritual_size,ix<=ritual_size,ix++)
		for(var/iy=-ritual_size,iy<=ritual_size,iy++)
			//Okay. Corners only, please.
			if( (ix==-ritual_size || ix==ritual_size) || (iy==-ritual_size || iy==ritual_size) ) //Outer corner.
				var/turf/T = locate(x+ix,y+iy,z)
				if(!T)
					continue
				var/obj/effect/ritual_smoke/outer/RS = new(T)
				var/abs_x = abs(ix)
				var/abs_y = abs(iy)
				var/desired_dir = 0x0
				if(abs_x >= abs_y) //Left/Right
					if(ix > 0)
						desired_dir |= EAST
					else
						desired_dir |= WEST
				if(abs_x <= abs_y) //Up/down
					if(iy > 0)
						desired_dir |= NORTH
					else
						desired_dir |= SOUTH
				RS.dir = desired_dir
				RS.name = "[ix].[iy]: [dir2text(desired_dir)]"
				RS.color = "#000000"
				connected_smoke += RS

			else if( (ix==-(ritual_size-1) || ix==(ritual_size-1)) || (iy==-(ritual_size-1) || iy==(ritual_size-1)) ) //Inner corner
				var/turf/T = locate(x+ix,y+iy,z)
				if(!T)
					continue
				var/obj/effect/ritual_smoke/inner/RS = new(T)
				var/abs_x = abs(ix)
				var/abs_y = abs(iy)
				var/desired_dir = 0x0
				if(abs_x >= abs_y) //Left/Right
					if(ix > 0)
						desired_dir |= WEST
					else
						desired_dir |= EAST
				if(abs_x <= abs_y) //Up/down
					if(iy > 0)
						desired_dir |= SOUTH
					else
						desired_dir |= NORTH
				RS.dir = desired_dir
				RS.name = "[ix].[iy]: [dir2text(desired_dir)]"
				RS.color = "#000000"
				connected_smoke += RS
			else if( (ix==-(ritual_size-2) || ix==(ritual_size-2)) || (iy==-(ritual_size-2) || iy==(ritual_size-2)) ) //Inner area
				var/turf/T = locate(x+ix,y+iy,z)
				if(!T)
					continue
				if(T.is_safe() && T.can_move_to())
					valid_turfs += T


/obj/structure/interactive/ritual/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_living(caller))
		return ..()

	var/mob/living/L = caller
	if(!L.client)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!IS_THINKING(src) && !complete)
		start_ritual()