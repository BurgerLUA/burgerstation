/ai/boss/leaper

	use_cone_vision = FALSE

	var/mob/living/simple/leaper/owner_as_leaper

	var/next_teleport = 0
	var/next_volley = 0
	var/next_spam = 0
	var/next_mass_summon = 0
	var/next_blood_attack = 0

	var/last_teleport_health_mod = 0

/ai/boss/leaper/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_leaper = desired_owner
	return ..()

/ai/boss/leaper/handle_movement()
	return FALSE

/ai/boss/leaper/handle_attacking()

	. = ..()

	if(!objective_attack)
		return .

	var/health_mod = 0.5 + (owner_as_leaper.health ? owner_as_leaper.health.health_current / owner_as_leaper.health.health_max : 1)*0.5
	if(!last_teleport_health_mod)
		last_teleport_health_mod = health_mod

	if(next_teleport <= world.time && (prob(5) || last_teleport_health_mod*0.9 >= health_mod))
		owner_as_leaper.try_teleport()
		next_teleport = world.time + SECONDS_TO_DECISECONDS(5)*health_mod
		next_volley = max(next_volley,next_volley + SECONDS_TO_DECISECONDS(2))
		next_spam = max(next_spam,next_spam + SECONDS_TO_DECISECONDS(2))
		last_teleport_health_mod = health_mod
		return .

	if(next_mass_summon <= world.time && prob(10))
		if(owner_as_leaper.check_frogs() <= 5)
			owner_as_leaper.manifest_frogs()
		next_mass_summon = world.time + SECONDS_TO_DECISECONDS(30)*health_mod
		return .

	if(next_volley <= world.time && prob(25))
		owner_as_leaper.volley_bubbles()
		next_volley = world.time + SECONDS_TO_DECISECONDS(5)*health_mod
		next_teleport = max(next_teleport,world.time + 5 + 3*6)
		return .

	if(next_blood_attack <= world.time)
		owner_as_leaper.blood_attack()
		next_blood_attack = world.time + SECONDS_TO_DECISECONDS(10)*health_mod
		return .

	if(next_spam <= world.time)
		owner_as_leaper.spam_bubbles()
		next_spam = world.time + 1 + CEILING(SECONDS_TO_DECISECONDS(10)*health_mod,1)
		next_teleport = max(next_teleport,world.time + 10)
		return .