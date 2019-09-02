obj/item/proc/get_block_mul(var/attack_type)
	return block_mul[attack_type]

obj/item/proc/get_parry_mul(var/attack_type)
	return parry_mul[attack_type]

/obj/item/proc/get_damage_type_text(var/mob/living/L)

	return "Penis." //TODO: Rewrite this.

/obj/item/get_attack_delay()

	if(!is_living(src.loc))
		return attack_delay

	var/mob/living/L = src.loc
	return attack_delay * (2 - L.get_attribute_power(ATTRIBUTE_DEXTERITY,1,100))