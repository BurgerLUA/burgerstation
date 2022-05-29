/obj/item/weapon/proc/get_dps(var/armor_to_use=0, damage_per_hit)
	return get_hits_per_second() * damage_per_hit