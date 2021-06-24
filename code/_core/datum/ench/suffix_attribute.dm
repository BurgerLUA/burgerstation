/ench/suffix/attribute/
	var/attribute_id = ATTRIBUTE_STRENGTH
	desc = "Increases your #ATT by #M."
	magnitude_min = 1
	magnitude_max = 10

/ench/suffix/attribute/on_equipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.add_mob_value("[attribute_id]","ench:\ref[src]",magnitude)
	if(L.health)
		L.health.update_health_stats()

/ench/suffix/attribute/on_unequipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.remove_mob_value("[attribute_id]","ench:\ref[src]")
	if(L.health)
		L.health.update_health_stats()

/ench/suffix/attribute/get_description()
	. = ..()
	. = replacetextEx(.,"#ATT",attribute_id)

/ench/suffix/attribute/strength
	name = "Strength"
	attribute_id = ATTRIBUTE_STRENGTH

/ench/suffix/attribute/vitality
	name = "Vitality"
	attribute_id = ATTRIBUTE_VITALITY

/ench/suffix/attribute/fortitude
	name = "Fortitude"
	attribute_id = ATTRIBUTE_FORTITUDE

/ench/suffix/attribute/intelligence
	name = "Intelligence"
	attribute_id = ATTRIBUTE_INTELLIGENCE

/ench/suffix/attribute/wisdom
	name = "Wisdom"
	attribute_id = ATTRIBUTE_WISDOM

/ench/suffix/attribute/willpower
	name = "Willpower"
	attribute_id = ATTRIBUTE_WILLPOWER

/ench/suffix/attribute/dexterity
	name = "Dexterity"
	attribute_id = ATTRIBUTE_DEXTERITY

/ench/suffix/attribute/resilience
	name = "Resilience"
	attribute_id = ATTRIBUTE_RESILIENCE

/ench/suffix/attribute/endurance
	name = "Endurance"
	attribute_id = ATTRIBUTE_ENDURANCE