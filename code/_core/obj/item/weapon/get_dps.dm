/obj/item/weapon/proc/get_dps(var/damage_per_hit=0)
	return get_hits_per_second() * damage_per_hit