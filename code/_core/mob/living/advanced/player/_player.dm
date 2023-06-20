var/global/list/mob/living/advanced/player/all_players = list()
var/global/list/mob/living/advanced/player/dead_player_mobs = list()

/mob/living/advanced/player/

	var/unique_pid //Snowflake system that generates a md5 hash of the player on character creation.

	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	dna = /dna/human

	movement_delay = DECISECONDS_TO_TICKS(1)

	health_base = 200
	stamina_base = 100
	mana_base = 100

	class = /class/player

	var/dialogue_target_id
	var/atom/dialogue_target

	see_invisible = INVISIBILITY_NO_PLAYERS
	invisibility = INVISIBILITY_PLAYERS

	var/spam_protection_command = 0
	//Increases by a certain amount every time something is used.
	//Measured in seconds.
	//Reduces by 1 every second.

	var/last_track_time = -1

	//var/spawn_protection = 0

	respawn = FALSE

	var/difficulty = DIFFICULTY_NORMAL

	var/currency = 0
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

	var/allow_save = TRUE

	var/list/mob/living/followers = list()

	var/save_id

	var/ai_steps = 0 //Determining when the AI activates.

	var/death_ckey //The ckey belonging to this person that died. Cleared on revive.

	var/list/prestige_count = list() //Prestige count for each of the skills. Each count increases maximum skill by 5.

	var/list/quests = list()

	var/tutorial = FALSE

	var/list/linked_portals

	var/last_autosave = 0 //The last time this player saved.

	enable_chunk_clean = FALSE
	enable_chunk_handling = TRUE

	var/is_saving = FALSE //Debug var that checks if the player is saving and freaks out if it's saving if it's qdeleted.

	var/job/job
	var/job_rank = 1
	var/job_next_promotion

	expiration_time = SECONDS_TO_DECISECONDS(180)

var/global/list/difficulty_to_damage_mul = list(
	DIFFICULTY_EASY = 0.25,
	DIFFICULTY_NORMAL = 0.5,
	DIFFICULTY_HARD = 0.75,
	DIFFICULTY_EXTREME = 1,
	DIFFICULTY_NIGHTMARE = 1
)

/mob/living/advanced/player/Finalize()
	. = ..()
	setup_difficulty()

/mob/living/advanced/player/proc/default_nanotrasen_move()

	if(length(cryo_spawnpoints))
		var/obj/structure/interactive/bed/sleeper/C = pick(cryo_spawnpoints)
		force_move(get_turf(C))
		C.door_state = SLEEPER_OPENED
		C.buckle(src,silent=TRUE)
		C.door_state = SLEEPER_CLOSED
		C.update_icon()
	else if(length(backup_spawnpoints))
		var/obj/marker/backup_spawn/BS = pick(backup_spawnpoints)
		force_move(get_turf(BS))
	else
		var/obj/marker/failsafe/FS = locate() in world
		if(FS && FS.loc)
			force_move(FS.loc)
		else
			var/desired_x = CEILING(world.maxx/2,1)
			var/desired_y = CEILING(world.maxy/2,1)
			var/desired_z = CEILING(world.maxz/2,1)
			force_move(locate(desired_x,desired_y,desired_z))

/mob/living/advanced/player/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)

	if(attacker.is_player_controlled()) //PvP is always 0.5.
		return 0.5

	return difficulty_to_damage_mul[src.get_difficulty()]

/mob/living/advanced/player/New(loc,desired_client,desired_level_multiplier)
	click_and_drag_icon	= new(src)
	last_autosave = world.time
	all_players += src
	ai_attacking_players[src] = list()
	. = ..()

/mob/living/advanced/player/restore_inventory()

	. = ..()

	if(.)
		client.screen += click_and_drag_icon

/mob/living/advanced/player/setup_name()

	if(real_name == DEFAULT_NAME)
		real_name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"

	name = SStext.check_duplicate_player_name(real_name,ckey_last)

	return TRUE


/mob/living/advanced/player/proc/setup_difficulty() //When the difficulty is changed.
	health.update_health_stats()
	return TRUE

/mob/living/advanced/player/is_safe_to_delete(var/check_loc = TRUE)
	if(is_saving)
		return FALSE
	. = ..()

/mob/living/advanced/player/PreDestroy()

	if(is_saving)
		log_error("FATAL ERROR: Mob [src.get_debug_name()] was qdeleted while saving! Save errors expected!")

	if(followers)
		for(var/k in followers)
			var/mob/living/L = k
			L.ai.set_move_objective(null)
			L.following = null
			followers -= L
		followers.Cut()

	if(current_squad)
		current_squad.remove_member(src)
		current_squad = null

	clear_portals()

	QDEL_NULL(click_and_drag_icon)

	equipped_antags -= src

	all_players -= src

	ai_attacking_players -= src

	. = ..()

/mob/living/advanced/player/Destroy()
	dialogue_target = null
	active_device = null
	active_structure = null
	active_paper = null
	return ..()

/mob/living/advanced/player/proc/clear_portals()

	if(linked_portals)
		for(var/k in linked_portals)
			var/obj/effect/temp/portal/P = k
			qdel(P)
		linked_portals.Cut()
		linked_portals = null

	return TRUE

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


/mob/living/advanced/player/proc/get_difficulty()
	return enable_friendly_fire ? DIFFICULTY_NORMAL : src.difficulty

var/global/list/difficulty_to_rarity = list(
	DIFFICULTY_EASY = 0,
	DIFFICULTY_NORMAL = 5,
	DIFFICULTY_HARD = 15,
	DIFFICULTY_EXTREME = 20,
	DIFFICULTY_NIGHTMARE = 40
)

// https://www.desmos.com/calculator/eh8dy1z0ga

/mob/living/advanced/player/proc/get_rarity()
	. = 10
	. += level*0.3
	. += src.get_attribute_power(ATTRIBUTE_LUCK,0,1,1) * 0.3
	. += difficulty_to_rarity[src.get_difficulty()] * 0.4
	// . *= 1 + (increased_rarity/100)
	return .