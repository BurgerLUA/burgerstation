/damagetype/error/swing(var/atom/attacker,var/list/atom/victims = list(),var/atom/weapon,var/list/atom/hit_objects = list(),var/atom/blamed,var/damage_multiplier=1)
	CRASH_SAFE("An object that shouldn't do damage ([weapon.get_debug_name()]) tried doing damage!")
	return FALSE

/damagetype/error/hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)
	CRASH_SAFE("An object that shouldn't do damage ([weapon.get_debug_name()]) tried doing damage!")
	return FALSE