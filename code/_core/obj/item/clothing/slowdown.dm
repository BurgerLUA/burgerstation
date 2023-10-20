/obj/item/clothing/proc/calculate_weight()

	var/init_weight = initial(weight)

	if(init_weight != 0)
		return init_weight

	. = 1

	var/armor/A = ARMOR(armor)
	if(A)
		for(var/k in A.defense_rating)
			if(IS_INFINITY(A.defense_rating[k]))
				continue
			. += A.defense_rating[k] * SSbalance.armor_slowdown_values[k]
		. *= length(protected_limbs)

	. = max(.,0)
