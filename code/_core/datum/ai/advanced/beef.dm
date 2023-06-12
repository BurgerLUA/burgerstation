/ai/advanced/beef
	ignore_immortal = TRUE
	should_find_weapon = FALSE
	roaming_distance = VIEW_RANGE
	enable_loc_safety = FALSE
	attack_movement_obstructions = TRUE

/ai/advanced/beef/check_aggression(var/mob/living/target,var/aggression_override = src.aggression)

	if(target == hunt_target)
		return target.horizontal || is_facing(target,owner)

	return ..()

/ai/advanced/beef/should_attack_mob(var/mob/living/L,var/aggression_check=TRUE)

	if(!L.dead)
		return ..()

	if(L.qdeleting)
		return FALSE

	if(!L.override_butcher && !length(L.butcher_contents))
		return FALSE

	return TRUE

/ai/advanced/beef/handle_attacking()

	if(is_living(objective_attack) && get_dist(owner,objective_attack) <= 1)
		var/mob/living/L = objective_attack
		if(L.health && L.gib_on_butcher && L.dead && (L.override_butcher || length(L.butcher_contents)))
			var/turf/T = get_turf(owner)
			PROGRESS_BAR(owner,L,max(10,L.health.health_max*0.05),L::on_butcher(),owner,L)
			PROGRESS_BAR_CONDITIONS(owner,L,L::can_be_butchered(),owner)
			L.visible_message(span("danger","\The [owner.name] starts to devour \the [L.name]!"),span("danger","You start to butcher \the [L.name]!"))
			play_sound('sound/effects/demon_consume.ogg',T)
			return TRUE

	. = ..()
