/damagetype/error/swing(atom/attacker,list/atom/victims = list(),atom/weapon,list/atom/hit_objects = list(),atom/blamed,damage_multiplier=1)
	CRASH("An object that shouldn't do damage ([weapon.get_debug_name()]) tried swinging!")

/damagetype/error/process_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damage_multiplier=1)
	CRASH("An object that shouldn't do damage ([weapon.get_debug_name()]) tried processing damage!")