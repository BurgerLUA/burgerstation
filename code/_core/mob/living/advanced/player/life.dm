/mob/living/advanced/player/on_killed(var/list/attackers)
	. = ..()
	if(. && ckey_last)
		play_sound_target(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src,channel=SOUND_CHANNEL_MUSIC)
		var/turf/T = get_turf(src)
		notify_ghosts("[src.name] was killed by [english_list(attackers)]!",T)

/mob/living/advanced/player/post_death()
	. = ..()
	if(. && ckey_last)
		SSliving.dead_player_mobs += src
		death_ckey = ckey_last

/mob/living/advanced/player/revive()
	. = ..()
	if(.)
		SSliving.dead_player_mobs -= src
		death_ckey = null


/mob/living/advanced/player/proc/on_kill_player(var/mob/living/advanced/player/P)
	HOOK_CALL("on_kill_player")
	return TRUE


/mob/living/advanced/player/on_life_client()
	. = ..()
	if(spam_protection_command > 0) spam_protection_command = max(0,spam_protection_command-TICKS_TO_SECONDS(1))

/mob/living/advanced/player/make_unrevivable() //only applies to players.

	if(!allow_save)
		return ..()

	CALLBACK_REMOVE("\ref[src]_make_unrevivable")

	var/turf/T = get_turf(src)

	if(!T)
		T = FALLBACK_TURF

	create_grave_and_respawn(T)

	return TRUE

/mob/living/advanced/player/proc/create_grave_and_respawn(var/turf/T)

	var/ckey_to_use = ckey_last ? ckey_last : death_ckey

	if(!ckey_to_use)
		log_error("FATAL ERROR: [src.get_debug_name()] didn't have a ckey_last or death_ckey!")
		return null

	. = create_grave(T)

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(mobdata)
		mobdata.save_character(src,died = TRUE)

	if(!src.client)
		qdel(src)
		return

	default_nanotrasen_move()
	resurrect()

/mob/living/advanced/player/proc/create_grave(var/turf/T)

	if(!allow_save)
		return null

	var/list/items_to_store = list()
	for(var/obj/item/I as anything in worn_objects)
		if(I.save_on_death)
			continue
		items_to_store += I

	for(var/obj/item/I as anything in held_objects)
		if(I.save_on_death)
			continue
		items_to_store += I

	if(!length(items_to_store))
		return null

	var/obj/structure/interactive/grave/our_grave = locate() in T
	if(!our_grave)
		our_grave = new(T)
		INITIALIZE(our_grave)
		GENERATE(our_grave)
		FINALIZE(our_grave)

	var/obj/item/structure_storage/storage = our_grave.create_storage_for(src,length(items_to_store))

	if(!storage)
		return null

	for(var/i=1,i<=length(items_to_store),i++)
		var/obj/item/found_item = items_to_store[i]
		var/obj/hud/inventory/found_inventory = storage.inventories[i]
		found_inventory.add_object(found_item,FALSE,TRUE,TRUE)

	return our_grave
