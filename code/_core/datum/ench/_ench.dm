//New enchantment system.


/ench/
	var/name
	var/desc
	var/magnitude = 0
	var/magnitude_min = 0
	var/magnitude_max = 100

	var/rarity = 1

/ench/proc/generate()
	magnitude = rand(magnitude_min,magnitude_max)
	return TRUE

/ench/proc/get_description()
	. = desc
	. = replacetextEx(.,"#M",magnitude)

/ench/proc/on_equipped(var/mob/living/L,var/obj/item/clothing/C)
	return TRUE

/ench/proc/on_unequipped(var/mob/living/L,var/obj/item/clothing/C)
	return TRUE

/ench/suffix/

/ench/prefix/