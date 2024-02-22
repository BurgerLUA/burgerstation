/ai/advanced/zombie

	allow_far_roaming = TRUE
	roaming_distance = VIEW_RANGE

	resist_handcuffs = FALSE
	should_find_weapon = FALSE //Citizens aren't supposed to have guns.

	target_distribution_x = list(12,12,16,20,20)
	target_distribution_y = list(8,8,8,8,16,16,16,20)

	avoid_threats = FALSE

	attack_movement_obstructions = TRUE

	use_alert_overlays = FALSE

	suicide_bomber = TRUE

	aggression = 3
	assistance = 0

	cowardice = -1

/ai/blob_spore
	target_distribution_x = list(16)
	target_distribution_y = list(25)


/ai/advanced/zombie/clown
	var/next_teleport = 0
	var/next_breathe = 0

/ai/advanced/zombie/clown/on_life()

	. = ..()

	if(objective_attack && next_breathe <= world.time)
		var/turf/T = get_turf(owner)
		next_breathe = world.time + SECONDS_TO_DECISECONDS(3.1)
		if(next_teleport < 0)
			next_teleport = world.time + SECONDS_TO_DECISECONDS(6)
			var/list/turf/possible_turfs = list()
			for(var/turf/simulated/floor/F in view(VIEW_RANGE,owner))
				CHECK_TICK(50,FPS_SERVER)
				if(F.lightness > 0.25)
					continue
				if(!F.can_teleport_to())
					continue
				possible_turfs += F
			if(length(possible_turfs))
				var/turf/new_turf = pick(possible_turfs)
				owner.force_move(new_turf)
				play_sound(pick('sound/voice/zombie/clown/cluwnelaugh1.ogg','sound/voice/zombie/clown/cluwnelaugh2.ogg','sound/voice/zombie/clown/cluwnelaugh3.ogg'),new_turf)
		else
			play_sound('sound/voice/zombie/clown/cluwnebreathe.ogg',T)

/ai/advanced/zombie/clown/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(next_teleport <= world.time && !owner.dead && objective_attack && attacker == objective_attack && damage_amount > 20)
		next_teleport = -1 //Trigger a teleport in on_life()