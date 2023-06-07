/obj/item/experience_scroll/skill
	var/skill

	overlay_icon_state = "gem"

	value = 1

/obj/item/experience_scroll/skill/get_base_value()
	if(!skill)
		return 0
	return 750 * level_to_give

/obj/item/experience_scroll/skill/get_examine_list()
	. = ..()
	. += div("notice","Reading \the [src.name] will grant [skill] experience.")

/obj/item/experience_scroll/skill/gain_knowledge(var/mob/living/advanced/A)

	if(!skill)
		return FALSE

	var/experience/E = A.get_skill(skill)
	var/experience_to_add = E.level_to_xp(level_to_give) - E.level_to_xp(level_to_give-1)
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
	skill = SKILL_MAGIC
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/summoning
	name = "scroll of summoning"
	skill = SKILL_SUMMONING
	value = 2000

	overlay_color = COLOR_BLUE

/obj/item/experience_scroll/skill/medicine
	name = "scroll of medicine"
	skill = SKILL_MEDICINE
	value = 2000

	overlay_color = COLOR_BLUE

/*
/obj/item/experience_scroll/skill/lesser
	name = "skill manual"
	desc = "Knowledge in the palms of your hands."
	desc_extended = "A special manual that increases the reader's experience by a certain amount. One time use."

	icon = 'icons/obj/item/books.dmi'
	icon_state = "book"

	skill = null
	value = 1000

	overlay_icon_state = null
	overlay_color = null

	rarity = RARITY_RARE

	level_to_give = 3

/obj/item/experience_scroll/skill/lesser/Initialize()
	. = ..()
	icon_state = pick(icon_states(icon))

/obj/item/experience_scroll/skill/lesser/melee
	name = "fencing manual"
	skill = SKILL_MELEE

/obj/item/experience_scroll/skill/lesser/unarmed
	name = "close quarters combat manual"
	skill = SKILL_UNARMED

/obj/item/experience_scroll/skill/lesser/prayer
	name = "religious rites and ceremonies"
	skill = SKILL_PRAYER

/obj/item/experience_scroll/skill/lesser/ranged
	name = "firearms handling manual"
	skill = SKILL_RANGED

/obj/item/experience_scroll/skill/lesser/precision
	name = "anatomy booklet"
	skill = SKILL_PRECISION

/obj/item/experience_scroll/skill/lesser/survival
	name = "survival guide"
	skill = SKILL_SURVIVAL

/obj/item/experience_scroll/skill/lesser/magic
	name = "magic tome"
	skill = SKILL_MAGIC

/obj/item/experience_scroll/skill/lesser/summoning
	name = "summoning tome"
	skill = SKILL_SUMMONING

/obj/item/experience_scroll/skill/lesser/medicine
	name = "first aid booklet"
	skill = SKILL_MEDICINE
*/