/ai/boss/can_man/

	enemy_tags = list("NanoTrasen")

	assistance = 0
	aggression = 1

	attack_distance_min = 0
	attack_distance_max = 1

	distance_target_min = 1
	distance_target_max = VIEW_RANGE*1.5

	var/mob/living/simple/can_man/owner_as_can_man

	//0 = normal
	//1 = revving up
	//2 = shooting
	//3 = revving down
	var/minigun_state = 0
	var/strafe_latch = 0


	//0 = normal
	//1 = shooting
	var/missile_state = 0
	var/list/stored_missile_turfs = list()
	var/missile_spam_left = 0

	var/last_objective_attack

/ai/boss/can_man/Destroy()
	. = ..()
	last_objective_attack = null

/ai/boss/can_man/handle_attacking()

	if(missile_state > 0)
		return TRUE

	if(minigun_state > 0)
		if(objective_attack && minigun_state == 2)
			if(objective_attack == last_objective_attack)
				owner_as_can_man.shoot_minigun(objective_attack)
			else
				CALLBACK_REMOVE("\ref[src]_minigun_finish")
				finish_minigun()
			return TRUE
		return TRUE

	var/target_distance = get_dist(owner,objective_attack)

	if(target_distance > 3 && missile_spam_left > 0)
		call_missiles()
		missile_spam_left -= 1
		return TRUE

	if(prob(target_distance > 3 ? 50 : 5))
		rev_minigun()
		return TRUE

	if(missile_spam_left <= 0 && !prob(80))
		missile_spam_left = 5
		return TRUE

	. = ..()


/ai/boss/can_man/handle_movement()

	//Missile attack.
	if(missile_state > 0)
		return TRUE

	//Minigun attack.
	if(owner_as_can_man && owner_as_can_man.health && minigun_state != 0)
		var/health_percent = owner_as_can_man.health.health_current / owner_as_can_man.health.health_max
		if(health_percent >= 0.5 || minigun_state != 2)
			//Hold still.
			owner.move_dir = 0x0
			last_movement_proc = "canman_minigun"
			return TRUE
		if(health_percent >= 0.25)
			//Strafe
			if(!strafe_latch)
				strafe_latch = pick(-90,90)
			var/desired_dir = get_dir(owner,objective_attack)
			desired_dir = turn(desired_dir,strafe_latch)
			owner.move_dir = 0x0
			last_movement_proc = "canman_minigun"
			return TRUE
		//Free movement otherwise.

	. = ..()

	if(owner.move_dir)
		owner.move_dir = get_true_4dir(owner.move_dir)


/ai/boss/can_man/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_can_man = desired_owner
	return ..()

/ai/boss/can_man/Destroy()
	owner_as_can_man = null
	return ..()

/ai/boss/can_man/proc/rev_minigun()

	if(minigun_state != 0)
		return

	if(!owner_as_can_man || owner_as_can_man.dead || owner_as_can_man.qdeleting)
		return

	if(!objective_attack)
		return

	var/turf/T = get_turf(objective_attack)
	if(!T)
		return

	minigun_state = 1
	play_sound('sound/mob/can_man/rev_start.ogg',get_turf(owner_as_can_man))
	CALLBACK("\ref[src]_minigun_start",15,src,src::start_minigun())

	owner_as_can_man.set_dir(get_dir(owner_as_can_man,T))

	last_objective_attack = objective_attack

	return TRUE

/ai/boss/can_man/proc/start_minigun()

	if(minigun_state != 1)
		return

	if(!owner_as_can_man || owner_as_can_man.dead || owner_as_can_man.qdeleting)
		return

	minigun_state = 2

	CALLBACK("\ref[src]_minigun_finish",30,src,src::finish_minigun())

	return TRUE



/ai/boss/can_man/proc/finish_minigun()

	if(minigun_state != 2)
		return

	if(!owner_as_can_man || owner_as_can_man.dead || owner_as_can_man.qdeleting)
		return

	minigun_state = 3
	play_sound('sound/mob/can_man/rev_stop.ogg',get_turf(owner_as_can_man))
	CALLBACK("\ref[src]_minigun_reset",15,src,src::reset_minigun())

	return TRUE


/ai/boss/can_man/proc/reset_minigun()

	if(minigun_state != 3)
		return

	if(!owner_as_can_man || owner_as_can_man.dead || owner_as_can_man.qdeleting)
		return

	minigun_state = 0
	strafe_latch = 0x0

	return TRUE

/ai/boss/can_man/proc/call_missiles()

	if(missile_state != 0)
		return

	missile_state = 1

	play_sound('sound/effects/terminal_alert.ogg',get_turf(owner_as_can_man))

	for(var/i=1,i<=3,i++)
		CALLBACK("\ref[src]_call_missile_[i]",10 + i*10,src,src::shoot_missile())

	CALLBACK("\ref[src]_finish_missiles",30 + 3*10,src,src::finish_missiles())


/ai/boss/can_man/proc/finish_missiles()
	missile_state = 0
	stored_missile_turfs.Cut()
	return TRUE


/ai/boss/can_man/proc/shoot_missile()

	if(!owner_as_can_man || owner_as_can_man.dead || owner_as_can_man.qdeleting)
		return

	if(!objective_attack)
		return

	var/turf/T = get_turf(objective_attack)

	if(!T)
		return

	if(T in stored_missile_turfs)
		for(var/i=1,i<=5,i++)
			var/turf/next_turf = locate(T.x + rand(-5,5),T.y + rand(-5,5) ,T.z)
			if(next_turf)
				T = next_turf
			if(!(T in stored_missile_turfs))
				break

	stored_missile_turfs += T

	owner_as_can_man.summon_missile(T)