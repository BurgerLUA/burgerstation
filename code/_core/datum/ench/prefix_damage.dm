/ench/prefix/damage/
	var/damage_id = "melee"
	desc = "Increases your #ATT by #M%."
	magnitude_min = 1
	magnitude_max = 10

/ench/prefix/damage/on_equipped(mob/living/L,obj/item/clothing/C)
	. = ..()
	L.add_mob_value("[damage_id]","ench:\ref[src]",magnitude)

/ench/prefix/damage/on_unequipped(mob/living/L,obj/item/clothing/C)
	. = ..()
	L.remove_mob_value("[damage_id]","ench:\ref[src]")