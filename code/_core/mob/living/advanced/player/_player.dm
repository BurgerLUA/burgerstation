var/global/list/mob/living/advanced/player/all_players = list()
var/global/list/mob/living/advanced/player/dead_player_mobs = list()

/mob/living/advanced/player/
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	movement_delay = DECISECONDS_TO_TICKS(1)

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

	var/currency = 8000
	var/revenue = 0
	var/expenses = 0
	var/partial_tax = 0 //Taxes you couldn't pay.
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

	var/obj/hud/click_and_drag/click_and_drag_icon

	value = 0

	known_cqc = list(
		/cqc/sleeping_carp/crashing_wave_kick,
		/cqc/sleeping_carp/keelhaul,
		/cqc/sleeping_carp/gnashing_teeth
	)

	var/allow_save = TRUE

	var/list/mob/living/followers = list()

	var/save_id

	var/ai_steps = 0 //Determining when the AI activates.

	var/death_ckey //The ckey belonging to this person that died. Cleared on revive.

	var/list/prestige_count = list() //Prestige count for each of the skills. Each count increases maximum skill by 5.

	var/tutorial = FALSE //Are you in the tutorial level?

	var/list/linked_portals

	var/last_autosave = 0 //The last time this player saved.

	enable_chunk_clean = FALSE

	var/is_saving = FALSE //Debug var that checks if the player is saving and freaks out if it's saving if it's qdeleted.

	var/job/job
	var/job_rank = 1
	var/job_next_promotion

	damage_received_multiplier = 0.75

/mob/living/advanced/player/New(loc,desired_client,desired_level_multiplier)
	click_and_drag_icon	= new(src)
	last_autosave = world.time
	all_players += src
	return ..()

/mob/living/advanced/player/restore_inventory()

	. = ..()

	if(.)
		client.screen += click_and_drag_icon

/mob/living/advanced/player/apply_mob_parts(var/teleport=TRUE,var/do_load=TRUE,var/update_blends=TRUE)

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata || !length(mobdata.loaded_data["organs"]) || !do_load)
		return ..()

	add_species_languages()

	set_mob_data(mobdata["loaded_data"],teleport && allow_save,update_blends,!allow_save)

	return TRUE

/mob/living/advanced/player/setup_name()

	if(real_name == DEFAULT_NAME)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	name = SStext.check_duplicate_player_name(real_name,ckey_last)

	return TRUE

/mob/living/advanced/player/Destroy()

	if(is_saving)
		log_error("FATAL ERROR: Mob [src.get_debug_name()] was qdeleted while saving! Save errors expected!")

	if(followers)
		for(var/k in followers)
			var/mob/living/L = k
			L.ai.set_move_objective(null)
			L.following = null
			followers -= L
		followers.Cut()

	if(client)
		client.make_ghost(src.loc ? src.loc : FALLBACK_TURF)

	dialogue_target = null

	if(src in equipped_antags)
		equipped_antags -= src

	if(current_squad)
		current_squad.remove_member(src)
		current_squad = null

	all_players -= src

	active_device = null
	active_structure = null
	active_paper = null

	clear_portals()

	QDEL_NULL(click_and_drag_icon)

	return ..()

/mob/living/advanced/player/proc/clear_portals()

	if(linked_portals)
		for(var/k in linked_portals)
			var/obj/effect/temp/portal/P = k
			qdel(P)
		linked_portals.Cut()
		linked_portals = null

	return TRUE

/mob/living/advanced/player/on_life_client()
	. = ..()
	spam_protection_command = max(0,spam_protection_command-TICKS_TO_SECONDS(1))

/mob/living/advanced/player/post_move(var/atom/old_loc)

	. = ..()

	if(.)

		if(!dead && ckey_last && last_autosave + SECONDS_TO_DECISECONDS(600) <= world.time)
			var/area/A = get_area(src)
			if(istype(A,/area/burgerstation))
				var/area/A2 = get_area(old_loc)
				if(!istype(A2,/area/burgerstation))
					last_autosave = world.time //Safety
					var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
					mobdata?.save_character(src)

		if(dialogue_target_id)
			dialogue_target_id = null
			close_menu(src,/menu/dialogue/)

		if(active_structure && get_dist(src,active_structure) > 1)
			set_structure_unactive()

		if(active_device && get_dist(src,active_device) > 1)
			set_device_unactive()

		ai_steps++

		if(src.loc && (ai_steps >= VIEW_RANGE || (old_loc && old_loc.z != src.loc.z)))
			for(var/k in SSai.inactive_ai_by_z["[src.loc.z]"])
				var/ai/A = k
				if(!A.owner)
					log_error("Warning! [A.get_debug_name()] had no owner!")
					qdel(A)
					if(SSai.inactive_ai_by_z["[src.loc.z]"])
						log_error("Error: [A.get_debug_name()] wasn't deleted properly!")
						SSai.inactive_ai_by_z["[src.loc.z]"] -= k
					continue
				if(A.owner.dead || A.owner.qdeleting)
					SSai.inactive_ai_by_z["[src.loc.z]"] -= k
					continue
				var/dist = get_dist(src,A.owner)
				if(dist > VIEW_RANGE + ZOOM_RANGE)
					continue
				A.set_active(TRUE)
			for(var/k in SSbossai.inactive_ai_by_z["[src.loc.z]"])
				var/ai/A = k
				if(!A.owner)
					log_error("Warning! [A.get_debug_name()] had no owner!")
					qdel(A)
					if(SSbossai.inactive_ai_by_z["[src.loc.z]"])
						log_error("Error: [A.get_debug_name()] wasn't deleted properly!")
						SSbossai.inactive_ai_by_z["[src.loc.z]"] -= k
					continue
				if(A.owner.dead || A.owner.qdeleting)
					SSbossai.inactive_ai_by_z["[src.loc.z]"] -= k
					continue
				var/dist = get_dist(src,A.owner)
				if(dist > VIEW_RANGE + ZOOM_RANGE)
					continue
				A.set_active(TRUE)
			ai_steps = 0

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


/mob/living/advanced/player/proc/prestige(var/skill_id)
	if(!prestige_count[skill_id])
		prestige_count[skill_id] = 1
	else
		prestige_count[skill_id] += 1
	set_skill_level(skill_id,5)
	src.to_chat(span("warning","Your loyalty implant buzzes as you feel your brain tampered with... seems like you've forgot everything about [skill_id]..."))
	src.to_chat(span("notice","You have prestiged your [skill_id]. It is now at prestige level [prestige_count[skill_id]], requiring skill level [100 + prestige_count[skill_id]*5] to prestige again."))
	//broadcast_to_clients(span("notice","[src.real_name] prestiged their [skill_id] to level [prestige_count[skill_id]]!"))
	return TRUE