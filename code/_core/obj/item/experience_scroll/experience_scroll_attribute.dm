/obj/item/experience_scroll/attribute
	var/attribute

	overlay_icon_state = "bauble"

/obj/item/experience_scroll/attribute/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [attribute] experience.")

/obj/item/experience_scroll/attribute/gain_knowledge(var/mob/living/advanced/A)

	if(!attribute)
		return FALSE

	var/experience/E = A.get_attribute(attribute)
	var/experience_to_add = E.level_to_xp(10) - E.level_to_xp(9)
	A.add_attribute_xp(attribute,experience_to_add)

	return ..()

/obj/item/experience_scroll/attribute/strength
	name = "scroll of strength"
	attribute = ATTRIBUTE_STRENGTH
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/fortitude
	name = "scroll of fortitude"
	attribute = ATTRIBUTE_FORTITUDE
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/vitality
	name = "scroll of vitality"
	attribute = ATTRIBUTE_VITALITY
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/attribute/intelligence
	name = "scroll of intelligence"
	attribute = ATTRIBUTE_INTELLIGENCE
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/willpower
	name = "scroll of willpower"
	attribute = ATTRIBUTE_WILLPOWER
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/wisdom
	name = "scroll of wisdom"
	attribute = ATTRIBUTE_WISDOM
	value = 2000

	overlay_color = COLOR_BLUE


/obj/item/experience_scroll/attribute/dexterity
	name = "scroll of dexterity"
	attribute = ATTRIBUTE_DEXTERITY
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/resilience
	name = "scroll of resilience"
	attribute = ATTRIBUTE_RESILIENCE
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/endurance
	name = "scroll of endurance"
	attribute = ATTRIBUTE_ENDURANCE
	value = 2000

	overlay_color = COLOR_GREEN