/subsystem/unit_test/
	name = "Unit Test"
	desc = "Basically a unit test."
	priority = SS_ORDER_LAST

/subsystem/unit_test/Initialize()

	var/good_damage = 0
	var/bad_damage = 0
	var/null_damage = 0

	var/good_class = 0
	var/bad_class = 0
	var/null_class = 0

	for(var/v in subtypesof(/atom/))
		var/atom/A = v
		var/damage_type = initial(A.damage_type)
		if(damage_type)
			if(all_damage_types[damage_type])
				good_damage += 1
			else
				bad_damage += 1
				LOG_ERROR("WARNING: Atom type [A] has bad or missing damage type [damage_type]!")
		else
			null_damage += 1

	LOG_DEBUG("Checked the damage type of [good_damage + bad_damage + null_damage] atom types, with [good_damage] being good, [bad_damage] being bad, and [null_damage] being null.")

	for(var/v in subtypesof(/mob/living/))
		var/mob/living/L = v
		var/class = initial(L.class)
		if(class)
			if(all_classes[class])
				good_class += 1
			else
				bad_class += 1
				LOG_ERROR("WARNING: Living type [L] has bad or missing class [class]!")
		else
			null_class += 1


	LOG_DEBUG("Checked the class of [good_class + bad_class + null_class] living types, with [good_class] being good, [bad_class] being bad, and [null_class] being null.")

	return TRUE