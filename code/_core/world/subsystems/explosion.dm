SUBSYSTEM_DEF(explosion)
	name = "Explosion Subsystem"
	desc = "Processes explosions."
	priority = SS_ORDER_NORMAL
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/obj/explosion_process/active_explosions = list()
	var/list/obj/fire_process/active_fires = list()

	var/list/atom/damage_to_process = list()

	tick_usage_max = 95

	var/explosion_ticks = 0

	var/particles/fire_particles

/subsystem/explosion/unclog(var/mob/caller)

	damage_to_process.Cut()

	for(var/k in active_explosions)
		var/obj/explosion_process/E = k
		active_explosions -= k
		if(!E || E.qdeleting)
			continue
		qdel(E)

	for(var/k in active_fires)
		var/obj/fire_process/F = k
		active_fires -= k
		if(!F || F.qdeleting)
			continue
		qdel(F)

	. = ..()

/subsystem/explosion/Initialize()
	. = ..()
	fire_particles = new/particles/fire

/subsystem/explosion/proc/add_data(location,owner,source,epicenter,magnitude,loyalty_tag)

	if(!damage_to_process[location])
		damage_to_process[location] = list()

	if(damage_to_process[location][owner])
		damage_to_process[location][owner]["magnitude"] += magnitude
	else
		damage_to_process[location][owner] = list()
		damage_to_process[location][owner]["source"] = source
		damage_to_process[location][owner]["epicenter"] = epicenter
		damage_to_process[location][owner]["magnitude"] = magnitude
		damage_to_process[location][owner]["loyalty_tag"] = loyalty_tag

/subsystem/explosion/on_life()

	if(explosion_ticks >= 4)
		for(var/k in damage_to_process)
			var/atom/victim = k
			if(!victim || victim.qdeleting)
				damage_to_process -= k
				continue
			var/list/explosion_data = damage_to_process[k]
			for(var/j in explosion_data)
				var/atom/owner = j
				var/list/explosion_subdata = explosion_data[j]
				victim.act_explode(
					owner,
					explosion_subdata["source"],
					explosion_subdata["epicenter"],
					explosion_subdata["magnitude"],
					explosion_subdata["loyalty_tag"]
				)
				explosion_data -= j
				CHECK_TICK(tick_usage_max,FPS_SERVER)
			if(!length(explosion_data))
				damage_to_process -= k
		explosion_ticks = 1
	else
		explosion_ticks++

	for(var/k in active_explosions)
		var/obj/explosion_process/EP = k
		if(!EP || EP.qdeleting)
			active_explosions -= k
			continue
		EP.process()
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	for(var/k in active_fires)
		var/obj/fire_process/FP = k
		if(!FP || FP.qdeleting)
			active_fires -= k
			continue
		FP.process()
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

/proc/explode(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty_tag,var/velocity_dir=0x0,var/multiplier=1)

	if(desired_range <= 0)
		return FALSE

	var/desired_power = desired_range ** 3

	var/obj/explosion_process/EP = locate() in desired_turf

	if(!EP)
		play_sound(pick('sound/effects/explosion/explosion_1.ogg','sound/effects/explosion/explosion_2.ogg','sound/effects/explosion/explosion_3.ogg'),desired_turf)
		new /obj/effect/cleanable/scorch(desired_turf)
		new /obj/effect/temp/explosion(desired_turf,desired_range)
		create_alert(desired_range*2,desired_turf,desired_owner,ALERT_LEVEL_CAUTION)
		for(var/d in DIRECTIONS_ALL)
			if(!prob(80))
				continue
			new /obj/effect/temp/explosion_particle(desired_turf,desired_range*RAND_PRECISE(0.75,1.25),"#FFFFFF",d)
		EP = new(desired_turf)
		EP.power = desired_power
		EP.owner = desired_owner
		EP.multiplier = multiplier
		EP.source = desired_source
		EP.epicenter = desired_turf
		EP.loyalty_tag = desired_loyalty_tag
		EP.velocity_dir = velocity_dir
		INITIALIZE(EP)
		GENERATE(EP)
		FINALIZE(EP)
	else
		EP.power += desired_power



/proc/emp(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty_tag,var/multiplier=1)

	desired_range = min(desired_range,VIEW_RANGE)

	if(desired_range <= 0)
		return FALSE

	new /obj/effect/temp/emp_pulse(desired_turf)

	for(var/turf/T in range(desired_range,desired_turf))
		var/magnitude = (desired_range - get_dist(desired_turf,T))*multiplier
		if(T.act_emp(desired_owner,desired_source,desired_turf,magnitude,desired_loyalty_tag))
			new /obj/effect/temp/emp_sparkle(T)
		CHECK_TICK(50,FPS_SERVER)



/proc/firebomb(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty_tag,var/momentum=NORTH|EAST|SOUTH|WEST,var/multiplier=1)

	if(desired_range <= 0)
		return FALSE

	var/obj/fire_process/FP = locate() in desired_turf

	if(!FP)
		play_sound('sound/effects/firebomb.ogg',desired_turf)
		FP = new(desired_turf)
		FP.fire_power = desired_range*2
		FP.initial_fire_power = desired_range*2
		FP.loyalty_tag = desired_loyalty_tag
		FP.multiplier = multiplier
		FP.momentum = momentum
		FP.owner = desired_owner
		INITIALIZE(FP)
		FINALIZE(FP)
	else
		FP.fire_power += desired_range*2

	return TRUE

