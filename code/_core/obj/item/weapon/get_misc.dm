/obj/item/weapon/proc/get_hit_count()
	return 1


/obj/item/weapon/ranged/get_hit_count()
	return bullet_count

/obj/item/weapon/ranged/bullet/get_hit_count()

	if(!SSbalance.weapon_to_bullet[src.type])
		log_error("Warning: [src.type] did not have a valid weapon_to_bullet.")
		return 0

	var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[src.type]

	return initial(BC.projectile_count)


/obj/item/weapon/proc/get_stopping_power(var/armor_to_use=0)
	return get_damage_per_hit(armor_to_use)/200

/obj/item/weapon/proc/get_shots_to_kill(var/armor_to_use=0)
	var/damage_per_hit = get_damage_per_hit(armor_to_use)
	if(damage_per_hit <= 1)
		return INFINITY
	. = 200/damage_per_hit
	. = CEILING(.,1)
	return

/obj/item/weapon/proc/get_kill_time(var/armor_to_use=0) //In seconds.

	var/hits_per_second = get_hits_per_second()

	. = (get_shots_to_kill(armor_to_use)-1)/(hits_per_second)

	var/rounding = 10/hits_per_second

	return CEILING(.,rounding)

/obj/item/weapon/proc/get_accuracy()
	return 1

/obj/item/weapon/ranged/get_accuracy(var/armor_to_use=0) //lower is more accurate.
	return get_static_spread() + heat_max*(1-max(1,get_stopping_power(armor_to_use)))



/obj/item/weapon/proc/get_reliability() //Higher is better.
	return 1



/obj/item/weapon/ranged/get_reliability() //Doesn't really work. Gotta fix later.

	var/core_spread = get_accuracy(0)

	if(core_spread <= 0)
		return 1

	var/core_spread_to_angle = core_spread*180

	var/oh_angle = 90 - core_spread_to_angle

	var/angle_math = oh_angle <= 0 ? 0 : VIEW_RANGE*0.5/tan(oh_angle)

	if(angle_math <= 1)
		return 1*(1/max(1,inaccuracy_modifier))

	return (1/(angle_math*2))*(1/max(1,inaccuracy_modifier))

/obj/item/weapon/ranged/bullet/get_reliability()

	. = ..()

	if(!SSbalance.weapon_to_bullet[src.type])
		log_error("Warning: [src.type] did not have a valid weapon_to_bullet.")
		return .

	var/obj/item/bullet_cartridge/BC = SSbalance.weapon_to_bullet[src.type]

	return .*(1/max(1,initial(BC.inaccuracy_modifier)))
