/obj/item/experience_scroll/skill
	var/skill
	var/experience_amount

	overlay_icon_state = "gem"

/obj/item/experience_scroll/skill/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [experience_amount]xp into [skill].")
	return .

/obj/item/experience_scroll/skill/gain_knowledge(var/mob/living/advanced/A)
	if(!skill || !experience_amount)
		return FALSE
	A.add_skill_xp(skill,experience_amount)
	return ..()

/obj/item/experience_scroll/skill/melee
	name = "scroll of melee"
	skill = SKILL_MELEE
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/unarmed
	name = "scroll of unarmed"
	skill = SKILL_UNARMED
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_RED

/obj/item/experience_scroll/skill/prayer
	name = "scroll of prayer"
	skill = SKILL_PRAYER
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_RED


/obj/item/experience_scroll/skill/ranged
	name = "scroll of ranged"
	skill = SKILL_RANGED
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/precision
	name = "scroll of precision"
	skill = SKILL_PRECISION
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_GREEN

/obj/item/experience_scroll/skill/survival
	name = "scroll of survival"
	skill = SKILL_SURVIVAL
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_GREEN


/obj/item/experience_scroll/skill/magic
	name = "scroll of magic"
	skill = SKILL_MAGIC
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/sorcery
	name = "scroll of sorcery"
	skill = SKILL_SORCERY
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/medicine
	name = "scroll of medicine"
	skill = SKILL_MEDICINE
	experience_amount = 5000
	value = 2000

	overlay_color = COLOR_BLUE