/obj/item/experience_scroll/skill
	overlay_icon_state = "gem"

/obj/item/experience_scroll/skill/get_base_value()
	if(!type_to_give)
		return 0
	return 750 * level_to_give

/obj/item/experience_scroll/skill/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [type_to_give] experience.")

/obj/item/experience_scroll/skill/gain_knowledge(var/mob/living/advanced/A)

	if(!type_to_give)
		return FALSE

	var/experience/E = A.get_skill(type_to_give)
	var/experience_to_add = E.level_to_xp(level_to_give) - E.level_to_xp(level_to_give-1)
	A.add_skill_xp(type_to_give,experience_to_add,FALSE)

	return ..()

/obj/item/experience_scroll/skill/melee
	name = "scroll of melee"
	type_to_give = SKILL_MELEE
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/unarmed
	name = "scroll of unarmed"
	type_to_give = SKILL_UNARMED
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/prayer
	name = "scroll of prayer"
	type_to_give = SKILL_PRAYER
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/skill/ranged
	name = "scroll of ranged"
	type_to_give = SKILL_RANGED
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/precision
	name = "scroll of precision"
	type_to_give = SKILL_PRECISION
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/survival
	name = "scroll of survival"
	type_to_give = SKILL_SURVIVAL
	value = 2000

	overlay_color = COLOR_GREEN


/obj/item/experience_scroll/skill/magic
	name = "scroll of magic"
	type_to_give = SKILL_MAGIC
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/summoning
	name = "scroll of summoning"
	type_to_give = SKILL_SUMMONING
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/medicine
	name = "scroll of medicine"
	type_to_give = SKILL_MEDICINE
	value = 2000

	overlay_color = COLOR_BLUE
