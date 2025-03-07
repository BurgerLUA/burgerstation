/obj/structure/interactive/boss_loot
	name = "wishgranter"
	desc = "Do you dare touch it?"
	desc_extended = "A corrupt pillar of radioactive energy that seems to grant the user a predetermined wish... if you are worthy."

	icon = 'icons/obj/structure/wishgranter.dmi'
	icon_state = "wishgranter_on"
	//icon_state = "wishgranter_off"

	plane = PLANE_MOVABLE
	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE

	var/list/mob/living/advanced/allowed_users = list()
	var/loot/loot_to_give
	var/die_time = 0
	var/next_speak = 0

	enable_chunk_clean = TRUE
	enable_chunk_handling = TRUE

	var/static/list/wishgranter_speak_lines = list(
		"Come... I know what you want.",
		"Come to me. You seek riches. Power.",
		"Are you worthy? Come...",
		"I see you. Come to the light...",
		"It is your fate to see me. Do you not believe in fate?",
		"You get what you deserve!",
		"Money? Fame? Power? It can be yours...",
		"Just reach out and grab it...",
		"Simply sign the dotted line... Just kidding!",

	)

/obj/structure/interactive/boss_loot/Destroy()
	allowed_users?.Cut()
	return ..()

/obj/structure/interactive/boss_loot/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)
	SPAM_CHECK(10)

	if(is_inventory(object) && is_player(activator))
		var/mob/living/advanced/player/P = activator
		var/rarity = P.get_rarity()
		activator.to_chat(span("warning","You carefully reach in to gently touch \the [src.name]..."))
		if(icon_state == "wishranter_off")
			activator.to_chat(span("warning","The power of \the [src.name] seems to have faded..."))
			return TRUE
		if(!(activator in allowed_users))
			activator.to_chat(span("warning","\The [src.name] seems to find you unworthy of its reward..."))
			return TRUE
		var/turf/T = get_turf(activator)
		var/list/atom/created_loot = SPAWN_LOOT(loot_to_give,T,rarity)
		if(!length(created_loot))
			log_error("Warning: Wishgranter had invalid loot ([loot_to_give]).")
			return TRUE
		for(var/obj/item/I in created_loot)
			// https://www.desmos.com/calculator/78f8zulsjq
			if(I.quality != -1)
				I.quality = 100 + min(round(5 + ((rand(1,1000)*0.0025)**4),5),40)

		activator.to_chat(span("warning","\The [src.name] grants you a [created_loot[1].name]!"))
		play_sound('sound/effects/wishgranter.ogg', T, range_max = VIEW_RANGE)
		var/obj/hud/inventory/I = object
		if(is_item(created_loot[1]))
			I.add_object(created_loot[1])
		allowed_users -= activator
		return TRUE

	return ..()

/obj/structure/interactive/boss_loot/proc/clear_self()
	allowed_users.Cut()
	icon_state = "wishgranter_off"
	return TRUE

/obj/structure/interactive/boss_loot/on_chunk_clean()
	if(length(allowed_users))
		return FALSE
	return ..()

/obj/structure/interactive/boss_loot/Finalize()

	die_time = world.time + SECONDS_TO_DECISECONDS(180)
	START_THINKING(src)

	var/turf/T = get_turf(src)
	var/list/direction_loop = list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
	var/list/turf_loop = list()
	//Setup turf_loop
	for(var/i=1,i<=length(direction_loop),i++)
		turf_loop += get_step(T,direction_loop[i])

	//Spawn the loot
	var/loot/L = LOOT(/loot/boss/always_single)
	var/list/spawned_loot = list()
	for(var/i=1,i<=rand(8,8 + length(allowed_users)),i++)
		spawned_loot += L.do_spawn(T)

	//Calculate delays.
	var/desired_delay = max(1, 5 - length(spawned_loot)*(1/8))
	desired_delay = round(desired_delay,1)

	//Run the animations.
	for(var/i=1,i<=length(spawned_loot),i++)
		var/atom/movable/M = spawned_loot[i]
		var/chosen_number = 1 + (i % length(direction_loop))
		var/chosen_direction = direction_loop[chosen_number]
		var/chosen_turf = turf_loop[chosen_number]
		M.invisibility = 101
		M.force_move(chosen_turf)
		CALLBACK("\ref[src]_make_loot_[i]",5 + i*desired_delay,src,src::spawn_loot_instance(),M,chosen_direction,chosen_turf)

	return ..()


/obj/structure/interactive/boss_loot/proc/spawn_loot_instance(var/atom/movable/M,var/desired_direction,var/desired_turf)

	var/direction_offset = direction_to_pixel_offset(desired_direction)
	var/desired_time = rand(4,8)

	M.pixel_x = -direction_offset[1]*TILE_SIZE
	M.pixel_y = -direction_offset[2]*TILE_SIZE
	M.pixel_z = rand(4,8)
	M.invisibility = initial(M.invisibility)

	animate(
		M,
		pixel_z=rand(16,32),
		time=desired_time*0.5,
		easing=QUAD_EASING|EASE_OUT,
		flags=ANIMATION_PARALLEL
	)
	animate(
		pixel_z=0,
		time=desired_time*0.5,
		easing=QUAD_EASING|EASE_IN
	)

	animate(
		M,
		pixel_x = rand(-4,4),
		pixel_y = rand(-4,4),
		time=desired_time,
		flags=ANIMATION_PARALLEL
	)


/obj/structure/interactive/boss_loot/think()

	. = ..()

	if(die_time <= world.time)
		clear_self()
		qdel(src)
		return FALSE

	if(next_speak <= world.time && prob(3))
		var/line_to_say = pick(wishgranter_speak_lines)
		do_say(line_to_say, language_to_use = LANGUAGE_SLAVIC)
		next_speak = world.time + SECONDS_TO_DECISECONDS(30)

