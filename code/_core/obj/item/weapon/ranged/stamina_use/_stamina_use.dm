/obj/item/weapon/ranged/stamina_use //THERE IS NO GOD HERE, ONLY CODE, HOW THE FUCK WILL THIS WORK
	name = "PSEUDOMELEE"
	desc = "I STOLE MAGIC CODE TWICE FOR THIS"
	desc_extended = "HOW THE FUCK? HOW THE FUCK DOES THIS WORK AND WHY DOES IT WORK WHEN IT DIDN'T BEFORE, WHAT THE FUCK LIES IN THE CODE, I WANT TO RIP IT OUT"
	icon = 'icons/obj/item/weapons/melee/swords/claymore.dmi'

	var/cost_stamina = 0

	var/spread_per_shot = 1 //Angle to add per shot.

	automatic = TRUE

	use_loyalty_tag = TRUE

/obj/item/weapon/ranged/stamina_use/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() < 1)
		return FALSE

	return ..()

/obj/item/weapon/ranged/stamina_use/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner)
		return 0

	if(!owner.health)
		return 1

	if(!cost_stamina)
		return 1

	return owner && cost_stamina ? FLOOR(owner.health.stamina_current / cost_stamina, 1) : 0

/obj/item/weapon/ranged/stamina_use/handle_ammo(var/mob/caller,var/bullet_position=1)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	A.health.adjust_stamina(-cost_stamina)

	A.update_health_element_icons(stamina=TRUE)

	A.stamina_regen_delay = max(A.stamina_regen_delay,10) //I'll change this if it's unreasonable.

	return null


/obj/item/weapon/ranged/stamina_use/get_heat_spread()
	return 0

/obj/item/weapon/ranged/stamina_use/get_static_spread()
	return 0

/obj/item/weapon/ranged/stamina_use/get_skill_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/stamina_use/get_movement_spread(var/mob/living/L)
	return 0


/obj/item/weapon/ranged/stamina_use/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	if(bullet_num_max <= 1)
		return list(initial_offset_x,initial_offset_y)

	var/angle = ATAN2(initial_offset_x,initial_offset_y)

	angle += ((bullet_num-1) - (bullet_num_max-1)*0.5)*spread_per_shot

	return list(cos(angle),sin(angle))