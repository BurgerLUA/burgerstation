#define PROJECTILE_MODE_CLOCKWISE "clockwise"
#define PROJECTILE_MODE_COUNTER_CLOCKWISE "counter-clockwise"
#define PROJECTILE_MODE_BULLETHELL "bullethell"
#define PROJECTILE_MODE_CIRCLE "circle"

/ai/boss/can_man/

	use_cone_vision = FALSE

	var/mob/living/simple/can_man/owner_as_can_man

	var/projectile_count = 15
	var/projectile_delay = 10

	var/strafe_count = 10
	var/strafe_delay = 60

/ai/boss/can_man/New(var/mob/living/desired_owner)
	owner_as_can_man = desired_owner
	return ..()

/ai/boss/can_man/Destroy()
	owner_as_can_man = null
	return ..()

/ai/boss/can_man/handle_movement()

	if(projectile_count && !strafe_count)
		owner.move_dir = 0x0
		return TRUE

	if(get_dist(owner,start_turf) >= 10)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,start_turf)
		owner_as_can_man.charge_steps = 0
		return TRUE

	if(objective_attack)
		if(strafe_count)
			owner_as_can_man.move_dir = turn(get_dir(owner,objective_attack),90)
			owner_as_can_man.movement_flags = MOVEMENT_RUNNING
			strafe_count--
			return TRUE
		else
			if(strafe_delay > 0)
				strafe_delay--
			else
				strafe_delay = initial(strafe_delay)
				strafe_count = initial(strafe_count)

	if(owner_as_can_man.charge_dir)
		owner_as_can_man.move_dir = owner_as_can_man.charge_dir
		owner_as_can_man.movement_flags = MOVEMENT_RUNNING
		return TRUE

	return ..()

/ai/boss/can_man/handle_attacking()

	if(objective_attack)
		handle_projectiles()

	if(owner_as_can_man.charge_steps)
		return FALSE

	if(objective_attack && owner_as_can_man.health)

		var/health_prob_mod = 3 - (owner_as_can_man.health.health_current / owner_as_can_man.health.health_max)*2

		if(!owner_as_can_man.charge_steps && prob(10*health_prob_mod))
			owner_as_can_man.start_charge()
			return TRUE

	return ..()

/ai/boss/can_man/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_delay > 0)
		projectile_delay--
		return FALSE

	if(projectile_count > 0)
		play_sound('sound/weapons/canman_shot.ogg',get_turf(owner))
		owner.shoot_projectile(owner,objective_attack,null,null,/obj/projectile/bullet/firearm/pistol,/damagetype/ranged/bullet/pistol_8mm,16,16,0,TILE_SIZE*0.5,1,"#FF4A00",0,0,1,owner.iff_tag,owner.loyalty_tag)
		owner.set_dir(get_dir(owner,objective_attack))
		projectile_count--
	else
		projectile_count = initial(projectile_count)
		projectile_delay = initial(projectile_delay)

	return TRUE