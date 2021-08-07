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


/obj/structure/interactive/crate/chest/proc/create_lockpicker(var/mob/living/advanced/A)
	current_user = A
	var/obj/hud/button/lockpicking/L = new
	L.update_owner(A)
	L.associated_chest = src
	L.sweet_spot = rand(1,179)
	L.difficulty = difficulty
	HOOK_ADD("post_move","\ref[src]_post_move",A,src,.proc/boot_lockpicker)
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
			if(current_user.dead || current_user.qdeleting)
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

/obj/structure/interactive/crate/chest/filled/Generate()
	. = ..()
	if(prob(chance_none))
		qdel(src)
	else
		difficulty = rand(1,10)
		gold_count = (11 - difficulty)*5 + rand(5,10)