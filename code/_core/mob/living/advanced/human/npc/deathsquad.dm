/mob/living/advanced/npc/deathsquad
	name = "deathsquad commando"
	desc = "An elite member of the Deathsquad. They are tasked to leave no witnesses."
	ai = /ai/advanced/syndicate
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/soldier

	var/desired_loadout = /loadout/deathsquad

/mob/living/advanced/npc/deathsquad/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/deathsquad)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/deathsquad)

	update_all_blends()

	equip_loadout(desired_loadout)

	return .

/mob/living/advanced/npc/deathsquad/light
	desired_loadout = /loadout/deathsquad/light
	level_multiplier = 1

/mob/living/advanced/npc/deathsquad/medium
	desired_loadout = /loadout/deathsquad/medium
	level_multiplier = 2

/mob/living/advanced/npc/deathsquad/heavy
	desired_loadout = /loadout/deathsquad/heavy
	level_multiplier = 4