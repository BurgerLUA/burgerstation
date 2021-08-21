/obj/item/experience_scroll/skill
	var/skill

	overlay_icon_state = "gem"

/obj/item/experience_scroll/skill/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [skill] experience.")

/obj/item/experience_scroll/skill/gain_knowledge(var/mob/living/advanced/A)

	if(!skill)
		return FALSE

	var/experience/E = A.get_skill(skill)
	var/experience_to_add = E.level_to_xp(10) - E.level_to_xp(9)
	A.add_skill_xp(skill,experience_to_add)

	return ..()

/obj/item/experience_scroll/skill/melee
	name = "scroll of melee"
	skill = SKILL_MELEE
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/unarmed
	name = "scroll of unarmed"
	skill = SKILL_UNARMED
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/prayer
	name = "scroll of prayer"
	skill = SKILL_PRAYER
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/skill/ranged
	name = "scroll of ranged"
	skill = SKILL_RANGED
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/precision
	name = "scroll of precision"
	skill = SKILL_PRECISION
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/survival
	name = "scroll of survival"
	skill = SKILL_SURVIVAL
	value = 2000

	overlay_color = COLOR_GREEN


/obj/item/experience_scroll/skill/magic
	name = "scroll of magic"
	skill = SKILL_MAGIC_DEFENSIVE
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/sorcery
	name = "scroll of sorcery"
	skill = SKILL_MAGIC_OFFENSIVE
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/medicine
	name = "scroll of medicine"
	skill = SKILL_MEDICINE
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/botany
	name = "scroll of botany"
	skill = SKILL_BOTANY
	value = 2000

	overlay_color = COLOR_BLUE
