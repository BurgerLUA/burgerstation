/mob/living/simple/goblin_king
	name = "goblin king"
	boss_icon_state = "goblin_king"
	icon = 'icons/mob/living/simple/goblin_king.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/

	ai = /ai/boss/goblin_king/

	boss_loot = /loot/lavaland/goblin_king

	value = 4000

	health_base = 10000
	stamina_base = 4000
	mana_base = 1000

	move_delay = AI_TICK_FAST*3

	stun_angle = 0

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 80,
		BLUNT = 80,
		LASER = 80,
		HEAT = 80,
		COLD = 80,
		HOLY = -80,
		DARK = 80,
		FATIGUE = 80,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = FALSE
	)

	iff_tag = "Goblin"
	loyalty_tag = "Goblin"

	fatigue_mul = 0

	size = SIZE_BOSS

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 4

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 5000
	blood_type = /reagent/blood/goblin

	soul_size = SOUL_SIZE_RARE

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 30

	movement_delay = DECISECONDS_TO_TICKS(6)

/mob/living/simple/goblin_king/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()

/mob/living/simple/goblin_king/proc/summon_goblins(var/angered = FALSE)
	var/spawn_amount = (((angered ? 2 : 1)*length(players_fighting_boss))+2)
	spawn_amount = min(spawn_amount, 10)
	do_say("Come to us our brethren, we are being slain!")
	var/turf/T = get_turf(src)
	for(var/i=1,i<=spawn_amount,i++)
		var/choose_goblin = pick(/mob/living/advanced/npc/goblin, /mob/living/advanced/npc/goblin/warrior, /mob/living/advanced/npc/goblin/mage)
		var/turf/turf_to_spawn = get_step(T, pick(NORTH,SOUTH,EAST,WEST))
		var/mob/living/spawnGoblin = new choose_goblin(turf_to_spawn)
		spawnGoblin.delete_on_death = TRUE
		INITIALIZE(spawnGoblin)
		GENERATE(spawnGoblin)
		FINALIZE(spawnGoblin)

/mob/living/simple/goblin_king/proc/summon_totems(var/angered = FALSE)
	var/spawn_amount = angered ? 3 : 1
	do_say("We refuse to die, the totems will aid us!")
	var/turf/T = get_turf(src)
	for(var/i=1,i<=spawn_amount,i++)
		var/totem_to_spawn = pick(
			/obj/structure/totem/sacred_flame, /obj/structure/totem/stamina_deal, /obj/structure/totem/health_heal,
			/obj/structure/totem/projectile/ice_crystal, /obj/structure/totem/projectile/fireball, /obj/structure/totem/projectile/lightning_bolt)
		var/turf/turf_to_spawn = get_step(T, pick(NORTH,SOUTH,EAST,WEST))
		if(is_wall(turf_to_spawn))
			continue
		var/obj/structure/totem/summoned_totem = new totem_to_spawn(turf_to_spawn)
		summoned_totem.affecting_faction = loyalty_tag
		summoned_totem.ranged_limited = FALSE
		summoned_totem.owner = src
		summoned_totem.totem_remove_time = SECONDS_TO_DECISECONDS(120) + world.time
		summoned_totem.leveled_effect = 3 //basically, a person with lvl.100 magic
		INITIALIZE(summoned_totem)
		GENERATE(summoned_totem)
		FINALIZE(summoned_totem)

/mob/living/simple/goblin_king/proc/screech(var/angered = FALSE)
	do_say("Suffer our wraith invaders, suffer!")
	play_sound('sound/voice/xeno/queen_screech.ogg',get_turf(src), range_min = VIEW_RANGE, range_max = VIEW_RANGE*3)
	var/stun_time = angered ? 40 : 20
	for(var/mob/living/L in view(VIEW_RANGE,src))
		if(L.loyalty_tag == src.loyalty_tag)
			continue
		L.add_status_effect(STUN,20,stun_time)
