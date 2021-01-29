/mob/living/advanced/npc/clockwork_cultist
	name = "clockwork cultist"
	desc = "Hail Ratvar!"
	desc_extended = "A cultist of Ratvar."
	enable_AI = TRUE
	ai = /ai/advanced/clockwork_cult
	class = /class/clockwork_cult

	var/loadout/loadout_to_use = /loadout/clockwork_cult

	health_base = 100
	mana_base = 100
	stamina_base = 100

	armor_base = list(
		HOLY = DAMAGE_CLUB,
		DARK = -DAMAGE_CLUB
	)

	level_multiplier = 2

/mob/living/advanced/npc/clockwork_cultist/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/clockwork_cult)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/clockwork_cult)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .