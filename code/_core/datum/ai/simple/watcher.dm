/ai/watcher
	var/mob/living/simple/npc/watcher/owner_as_watcher
	attack_distance_min = 4
	attack_distance_max = 8

	var/projectile_delay = SECONDS_TO_DECISECONDS(5)
	var/projectile_count = 2

/ai/watcher/handle_attacking()

	if(objective_attack)
		handle_projectiles()

	return ..()

/ai/watcher/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	if(projectile_delay > 0)
		projectile_delay--
		return FALSE

	if(projectile_count > 0)
		play('sound/weapons/freeze.ogg',get_turf(owner))
		owner.shoot_projectile(owner,objective_attack,null,null,/obj/projectile/magic/crystal/ice,/damagetype/ranged/laser/freezegun,16,16,0,TILE_SIZE*0.5,1,"#FFFFFF",0,0,1,owner.iff_tag,owner.loyalty_tag)
		owner.set_dir(get_dir(owner,objective_attack))
		projectile_count--
	else
		projectile_count = initial(projectile_count)
		projectile_delay = initial(projectile_delay)

	return TRUE