/damagetype/error/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_multiplier=1)
	CRASH_SAFE("An object that shouldn't do damage tried doing damage!")
	return FALSE