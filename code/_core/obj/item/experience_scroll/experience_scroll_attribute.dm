/obj/item/experience_scroll/attribute
	overlay_icon_state = "bauble"

/obj/item/experience_scroll/attribute/get_examine_list()

	. = ..()

	if(type_to_give)
		. += div("notice","Reading \the [src.name] will grant [type_to_give] experience.")

/obj/item/experience_scroll/attribute/get_base_value()
	if(!type_to_give)
		return 0
	return 1500 * level_to_give

/obj/item/experience_scroll/attribute/gain_knowledge(var/mob/living/advanced/A)

	if(!type_to_give)
		return FALSE

	var/experience/E = A.get_attribute(type_to_give)
	var/experience_to_add = E.level_to_xp(level_to_give) - E.level_to_xp(level_to_give-1)
	A.add_attribute_xp(type_to_give,experience_to_add,FALSE)

	return ..()

/obj/item/experience_scroll/attribute/strength
	name = "scroll of strength"
	type_to_give = ATTRIBUTE_STRENGTH
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/fortitude
	name = "scroll of fortitude"
	type_to_give = ATTRIBUTE_FORTITUDE
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/vitality
	name = "scroll of vitality"
	type_to_give = ATTRIBUTE_VITALITY
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/attribute/intelligence
	name = "scroll of intelligence"
	type_to_give = ATTRIBUTE_INTELLIGENCE
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/willpower
	name = "scroll of willpower"
	type_to_give = ATTRIBUTE_WILLPOWER
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/wisdom
	name = "scroll of wisdom"
	type_to_give = ATTRIBUTE_WISDOM
	value = 2000

	overlay_color = COLOR_BLUE


/obj/item/experience_scroll/attribute/dexterity
	name = "scroll of dexterity"
	type_to_give = ATTRIBUTE_DEXTERITY
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/resilience
	name = "scroll of resilience"
	type_to_give = ATTRIBUTE_RESILIENCE
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/endurance
	name = "scroll of endurance"
	type_to_give = ATTRIBUTE_ENDURANCE
	value = 2000

	overlay_color = COLOR_GREEN
