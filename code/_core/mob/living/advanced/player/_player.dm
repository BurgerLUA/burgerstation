var/global/list/mob/living/advanced/player/all_players = list()

/mob/living/advanced/player/
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	health_base = 200
	stamina_base = 100
	mana_base = 100

	class = /class/player

	var/dialogue_target_id
	var/atom/dialogue_target

	invisibility = INVISIBILITY_PLAYERS

	var/spam_protection_command = 0
	//Increases by a certain amount every time something is used.
	//Measured in seconds.
	//Reduces by 1 every second.

	var/last_track_time = -1

	//var/spawn_protection = 0

	respawn = FALSE

	has_hard_crit = TRUE

	var/list/attack_logs = list()

	var/currency = 3000
	var/revenue = 0
	var/expenses = 0
	var/last_tax_payment = 0

	var/insurance = INSURANCE_PAYOUT * 4 //How much insurance the user has. This amount is paid out in death, up to 8000 credits.
	var/insurance_premiums = 0.05 //How much your insurance premiums are. This is taxed from your current amount each payday.

	var/logout_time = 0

	death_threshold = -100

	var/attack_mode = 1
	var/list/attack_left = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)

	)
	var/list/attack_right = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

	allow_experience_gains = TRUE

	var/obj/item/device/active_device
	var/obj/structure/active_structure
	var/obj/item/paper/active_paper

	var/squad/current_squad

	var/geared_up

	var/obj/hud/click_and_drag/click_and_drag_icon

	value = 0

	damage_received_multiplier = 0.5

	queue_delete_on_death = FALSE

	known_cqc = list(
		/cqc/sleeping_carp/crashing_wave_kick,
		/cqc/sleeping_carp/keelhaul,
		/cqc/sleeping_carp/gnashing_teeth
	)

	var/allow_save = TRUE

	var/list/mob/living/followers = list()

	var/save_id

	//movement_delay = DECISECONDS_TO_TICKS(1.5)

	var/ai_steps = 0 //Determining when the AI activates.

	var/tutorial = FALSE

	damage_received_multiplier = 0.75

/mob/living/advanced/player/New(loc,desired_client,desired_level_multiplier)
	click_and_drag_icon	= new(src)
	INITIALIZE(click_and_drag_icon)
	FINALIZE(click_and_drag_icon)
	return ..()

/mob/living/advanced/player/restore_inventory()

	. = ..()

	if(.)
		client.screen += click_and_drag_icon

	return .

/mob/living/advanced/player/apply_mob_parts(var/teleport=TRUE,var/do_load=TRUE,var/update_blends=TRUE)

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata || !length(mobdata.loaded_data["organs"]) || !do_load)
		return ..()

	add_species_languages()

	set_mob_data(mobdata["loaded_data"],teleport,update_blends)

	return TRUE

/mob/living/advanced/player/Initialize()
	. = ..()
	all_players += src
	return .

/mob/living/advanced/player/setup_name()

	if(real_name == DEFAULT_NAME)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	name = SStext.check_duplicate_player_name(real_name,ckey_last)

	return TRUE

/mob/living/advanced/player/Destroy()

	if(client)
		client.make_ghost(src.loc ? src.loc : FALLBACK_TURF)

	dialogue_target = null

	if(src in equipped_antags)
		equipped_antags -= src

	if(current_squad)
		current_squad.remove_member(src)
		current_squad = null

	all_players -= src
	attack_logs.Cut()

	active_device = null
	active_structure = null
	active_paper = null

	QDEL_NULL(click_and_drag_icon)

	return ..()

mob/living/advanced/player/on_life_client()
	. = ..()
	spam_protection_command = max(0,spam_protection_command-TICKS_TO_SECONDS(1))
	return .

/mob/living/advanced/player/post_move(var/atom/old_loc)

	. = ..()

	if(.)

		if(dialogue_target_id)
			dialogue_target_id = null
			close_menu(src,/menu/dialogue/)

		if(active_structure && get_dist(src,active_structure) > 1)
			set_structure_unactive()

		if(active_device && get_dist(src,active_device) > 1)
			set_device_unactive()

		ai_steps++

		if(ai_steps >= VIEW_RANGE || (old_loc && src.loc && old_loc.z != src.loc.z))
			for(var/k in SSai.inactive_ai)
				var/ai/A = k
				if(!A.owner)
					log_error("Warning! [A.get_debug_name()] had no owner!")
					qdel(A)
					continue
				var/dist = get_dist(src,A.owner)
				if(dist > VIEW_RANGE + ZOOM_RANGE)
					continue
				A.set_active(TRUE)
			ai_steps = 0


	return .

/mob/living/advanced/player/can_be_grabbed(var/atom/grabber,var/messages=TRUE)
	// only prevent dead bodies from being grabbed if person grabbing is antag
	// unfortunately due to code in datum/damagetype/unarmed/fists.dm, a GRAB! message will be displayed anyway
	if(dead && istype(grabber, /mob/living/advanced/player/antagonist/))
		if(istype(src, /mob/living/advanced/player/antagonist/))
			return ..() // person being grabbed is also antag, allows revs and syndies to grab each other (maybe check IFF?)
		
		if(messages)
			var/mob/living/grabberMob = grabber
			grabberMob.to_chat(span("warning", "Ew! Why would I touch a disgusting [name]!"))
		
		return FALSE
	return ..()
