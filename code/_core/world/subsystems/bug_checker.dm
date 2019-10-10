/subsystem/unit_test/
	name = "Unit Test"
	desc = "Basically a unit test."
	priority = SS_ORDER_LAST

/subsystem/unit_test/Initialize()

	var/good_damage = 0
	var/bad_damage = 0
	var/null_damage = 0

	for(var/v in subtypesof(/atom/))
		var/obj/item/I = v
		var/damage_type = initial(I.damage_type)
		if(damage_type)
			if(all_damage_types[damage_type])
				good_damage += 1
			else
				bad_damage += 1
				LOG_ERROR("WARNING: Object type [I] has bad or missing damage type [damage_type]!")
		else
			null_damage += 1

	LOG_DEBUG("Checked the damage type of [good_damage + bad_damage + null_damage] atom types, with [good_damage] being good, [bad_damage] being bad, and [null_damage] being null.")

	return TRUE