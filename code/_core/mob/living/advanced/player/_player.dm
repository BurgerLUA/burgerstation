var/global/list/mob/living/advanced/player/all_players = list()

/mob/living/advanced/player/
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

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

	var/currency = 1000

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

	damage_received_multiplier = 0.75

	queue_delete_on_death = FALSE

	known_cqc = list(
		/cqc/sleeping_carp/crashing_wave_kick,
		/cqc/sleeping_carp/keelhaul,
		/cqc/sleeping_carp/gnashing_teeth
	)

	var/allow_save = TRUE

	var/list/mob/living/followers = list()

	//movement_delay = DECISECONDS_TO_TICKS(1.5)

/mob/living/advanced/player/New(loc,desired_client,desired_level_multiplier)
	. = ..()
	click_and_drag_icon	= new(src)
	INITIALIZE(click_and_drag_icon)
	return .

/mob/living/advanced/player/apply_mob_parts(var/teleport=TRUE,var/do_load=TRUE,var/update_blends=TRUE)

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata || !length(mobdata.loaded_data["organs"]) || !do_load)
		return ..()

	add_species_languages()

	mobdata.apply_data_to_mob(src,teleport,update_blends)

	return TRUE

/mob/living/advanced/player/Initialize()
	. = ..()
	all_players += src
	return .

/mob/living/advanced/player/setup_name()

	if(real_name == DEFAULT_NAME)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	name = "[real_name] ([client ? client : "NO CKEY"])"

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

	if(area && area.players_inside)
		area.players_inside -= src
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
			close_menu(src,"dialogue")

		if(active_structure && get_dist(src,active_structure) > 1)
			set_structure_unactive()

		if(active_device && get_dist(src,active_device) > 1)
			set_device_unactive()

		if( (x % VIEW_RANGE == 0) || (y % VIEW_RANGE == 0) )
			for(var/mob/living/advanced/npc/L in view(src,VIEW_RANGE))
				if(!L.ai)
					continue
				L.ai.enabled = TRUE
			for(var/mob/living/simple/npc/L in view(src,VIEW_RANGE))
				if(!L.ai)
					continue
				L.ai.enabled = TRUE


	return .