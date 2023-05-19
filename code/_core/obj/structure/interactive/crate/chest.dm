/obj/structure/interactive/crate/chest
	name = "treasure chest"
	icon_state = "chest"

	var/locked = TRUE
	var/mob/living/advanced/current_user
	var/difficulty = 10 //Lower difficulty means harder.

	var/gold_count = 0

	anchored = TRUE

	open_sound = 'sound/effects/lockpicking/chest_open.ogg'
	close_sound = 'sound/effects/lockpicking/chest_close.ogg'

	enable_chunk_handling = TRUE
	enable_chunk_clean = TRUE

/obj/structure/interactive/crate/chest/on_chunk_clean()
	if(locked || current_user)
		return FALSE
	locked = TRUE
	loot = initial(loot)
	difficulty = rand(1,10)
	gold_count = (11 - difficulty)*5 + rand(5,10)
	open = FALSE
	update_sprite()
	return TRUE

/obj/structure/interactive/crate/chest/proc/picked(var/mob/living/advanced/A)
	boot_lockpicker()
	locked = FALSE
	open()
	if(gold_count > 0)
		create_gold_drop(get_turf(src),gold_count)
	return TRUE


var/global/list/lockpick_difficulty_mul = list(
	DIFFICULTY_EASY = 0.5,
	DIFFICULTY_NORMAL = 1,
	DIFFICULTY_HARD = 1.25,
	DIFFICULTY_EXTREME = 1.5,
	DIFFICULTY_NIGHTMARE = 2
)

/obj/structure/interactive/crate/chest/proc/create_lockpicker(var/mob/living/advanced/A)
	current_user = A
	var/obj/hud/button/lockpicking/L = new
	L.update_owner(A)
	L.associated_chest = src
	L.sweet_spot = rand(1,179)
	L.difficulty = difficulty
	if(is_player(A))
		var/mob/living/advanced/player/P = A
		L.difficulty *= 1/lockpick_difficulty_mul[P.get_difficulty()] //Reminder that lower difficulty (for Lockpick) means harder.
		L.difficulty = round(L.difficulty+1,1)

	HOOK_ADD("post_move","\ref[src]_post_move",A,src,src::boot_lockpicker())
	visible_message(span("notice","\The [A.name] starts picking \the [src.name]'s lock..."))
	return TRUE

/obj/structure/interactive/crate/chest/proc/boot_lockpicker()

	if(!current_user)
		return FALSE

	for(var/obj/hud/button/lockpicking/L in current_user.buttons)
		L.update_owner(null)

	HOOK_REMOVE("post_move","\ref[src]_post_move",current_user)

	visible_message(span("notice","\The [current_user.name] stops picking \the [src.name]'s lock."))

	current_user = null

	return TRUE

/obj/structure/interactive/crate/chest/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	if(!open && locked)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		if(current_user)
			if(current_user.dead || current_user.qdeleting || current_user.horizontal || !current_user.ckey)
				boot_lockpicker()
			else
				caller.to_chat(span("notice","\The [current_user.name] is currently lockpicking this!"))
				return TRUE
		//Begin lockpicking
		create_lockpicker(caller)
		return TRUE

	. = ..()

/obj/structure/interactive/crate/chest/filled
	loot = /loot/treasure
	var/chance_none = 0

/obj/structure/interactive/crate/chest/filled/New(var/desired_loc)

	if(prob(chance_none))
		qdel(src)

	. = ..()

/obj/structure/interactive/crate/chest/filled/Generate()
	. = ..()
	difficulty = rand(1,10)
	gold_count = (11 - difficulty)*5 + rand(5,10)