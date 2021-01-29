/mob/living/advanced/npc/cultist
	name = "cultist"
	desc = "*incomprehensible gibberish*"
	desc_extended = "A cultist of Nar'sie."
	enable_AI = TRUE
	ai = /ai/advanced/cult
	class = /class/cult

	var/loadout/loadout_to_use = /loadout/cultist

	health_base = 100
	mana_base = 100
	stamina_base = 100

	armor_base = list(
		HOLY = -DAMAGE_CLUB,
		DARK = DAMAGE_CLUB
	)

	level_multiplier = 2

/mob/living/advanced/npc/cultist/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/cult)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/cult)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .

/mob/living/advanced/npc/cultist/old
	name = "ancient cultist"
	loadout_to_use = /loadout/cultist/old
	level_multiplier = 4

/mob/living/advanced/npc/cultist/hard
	name = "master cultist"
	loadout_to_use = /loadout/cultist/hard
	level_multiplier = 8