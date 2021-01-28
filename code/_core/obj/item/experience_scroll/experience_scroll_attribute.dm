/obj/item/experience_scroll/attribute
	var/attribute
	var/experience_amount

	overlay_icon_state = "bauble"

/obj/item/experience_scroll/attribute/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [experience_amount]xp into [attribute].")
	return .

/obj/item/experience_scroll/attribute/gain_knowledge(var/mob/living/advanced/A)
	if(!attribute || !experience_amount)
		return FALSE
	A.add_attribute_xp(attribute,experience_amount)
	return ..()

/obj/item/experience_scroll/attribute/strength
	name = "scroll of strength"
	attribute = ATTRIBUTE_STRENGTH
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/fortitude
	name = "scroll of fortitude"
	attribute = ATTRIBUTE_FORTITUDE
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/attribute/vitality
	name = "scroll of vitality"
	attribute = ATTRIBUTE_VITALITY
	experience_amount = 2
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/attribute/intelligence
	name = "scroll of intelligence"
	attribute = ATTRIBUTE_INTELLIGENCE
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/willpower
	name = "scroll of willpower"
	attribute = ATTRIBUTE_WILLPOWER
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/attribute/wisdom
	name = "scroll of wisdom"
	attribute = ATTRIBUTE_WISDOM
	experience_amount = 2
	value = 2000

	overlay_color = COLOR_BLUE


/obj/item/experience_scroll/attribute/dexterity
	name = "scroll of dexterity"
	attribute = ATTRIBUTE_DEXTERITY
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/resilience
	name = "scroll of resilience"
	attribute = ATTRIBUTE_RESILIENCE
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/attribute/endurance
	name = "scroll of endurance"
	attribute = ATTRIBUTE_ENDURANCE
	experience_amount = 2
	value = 2000

	overlay_color = COLOR_GREEN