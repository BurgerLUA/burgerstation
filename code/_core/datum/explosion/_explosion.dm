/proc/explode(var/turf/desired_turf,var/desired_power,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty)

	var/obj/explosion_process/EP = locate() in desired_turf

	if(!EP)
		play_sound(pick('sound/effects/explosion/explosion_1.ogg','sound/effects/explosion/explosion_2.ogg','sound/effects/explosion/explosion_3.ogg'),desired_turf)
		EP = new(desired_turf)
		EP.power = desired_power
		EP.owner = desired_owner
		EP.source = desired_source
		EP.epicenter = desired_turf
		EP.loyalty_tag = desired_loyalty
		INITIALIZE(EP)
		GENERATE(EP)
		FINALIZE(EP)
	else
		EP.power += desired_power

/proc/smoke(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty,var/reagents/desired_reagents)