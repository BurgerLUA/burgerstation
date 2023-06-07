/obj/item/experience_scroll/attribute
	var/attribute

	overlay_icon_state = "bauble"

	value = 1

/obj/item/experience_scroll/attribute/get_base_value()
	if(!attribute)
		return 0
 	return 1000 * level_to_give

/obj/item/experience_scroll/attribute/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [attribute] experience.")

/obj/item/experience_scroll/attribute/gain_knowledge(var/mob/living/advanced/A)

	if(!attribute)
		return FALSE

	var/experience/E = A.get_attribute(attribute)
	var/experience_to_add = E.level_to_xp(level_to_give) - E.level_to_xp(level_to_give-1)
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

/*
/obj/item/experience_scroll/attribute/lesser
	name = "atrribute manual"
	desc = "Knowledge in the palms of your hands."
	desc_extended = "A special manual that increases the reader's experience by a certain amount. One time use."

	icon = 'icons/obj/item/books.dmi'
	icon_state = "book"

	attribute = null
	value = 1000

	overlay_icon_state = null
	overlay_color = null

	rarity = RARITY_RARE

	level_to_give = 3

/obj/item/experience_scroll/attribute/lesser/Initialize()
	. = ..()
	icon_state = pick(icon_states(icon))

/obj/item/experience_scroll/attribute/lesser/strength
	name = "bodybuilding manual"
	attribute = ATTRIBUTE_STRENGTH

/obj/item/experience_scroll/attribute/lesser/fortitude
	name = "fortitude guidelines"
	attribute = ATTRIBUTE_FORTITUDE

/obj/item/experience_scroll/attribute/lesser/vitality
	name = "vitality manual"
	attribute = ATTRIBUTE_VITALITY

/obj/item/experience_scroll/attribute/lesser/intelligence
	name = "encyclopedia"
	attribute = ATTRIBUTE_INTELLIGENCE

/obj/item/experience_scroll/attribute/lesser/willpower
	name = "motivational quotes and phrases"
	attribute = ATTRIBUTE_WILLPOWER

/obj/item/experience_scroll/attribute/lesser/wisdom
	name = "book of wisdom"
	attribute = ATTRIBUTE_WISDOM

/obj/item/experience_scroll/attribute/lesser/dexterity
	name = "acrobatics manual"
	attribute = ATTRIBUTE_DEXTERITY

/obj/item/experience_scroll/attribute/lesser/resilience
	name = "interrogation tactics book"
	attribute = ATTRIBUTE_RESILIENCE

/obj/item/experience_scroll/attribute/lesser/endurance
	name = "fitness manual"
	attribute = ATTRIBUTE_ENDURANCE
*/