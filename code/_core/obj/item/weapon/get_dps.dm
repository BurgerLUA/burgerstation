/obj/item/weapon/proc/get_dps(var/armor_to_use=0)
	return get_hits_per_second() * get_damage_per_hit(armor_to_use)