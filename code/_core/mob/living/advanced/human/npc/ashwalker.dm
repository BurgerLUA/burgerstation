/mob/living/advanced/npc/ashwalker
	name = "ashwalker villager"
	desc = "Walker of the ash."
	desc_extended = "A more primitive cousin to the lizardmen that NanoTrasen hires, these bipedal Ashwalkers tend to hunt in lava-infested regions for meat and leather. They're hostile to anything that isn't their own kin."


	ai = /ai/advanced/ashwalker


	species = "reptile"

	var/loadout_to_use = /loadout/ashwalker/
	var/loadout_to_use_female = /loadout/ashwalker/female

	loyalty_tag = "Ashwalker"
	iff_tag = "Ashwalker"

	level = 8

/mob/living/advanced/npc/ashwalker/New(loc,desired_client,desired_level_multiplier)

	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done

	. = ..()

/mob/living/advanced/npc/ashwalker/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	var/skin_color = sex == MALE ? rgb(rand(75,120),rand(75,120),rand(75,120)) : rgb(rand(120,200),rand(120,200),rand(120,200))
	var/rand_col = rand(50,200)

	change_organ_visual("skin", desired_color = skin_color)

	if(sex == MALE)
		change_organ_visual("hair_face", desired_color = pick("#FFF0BE","#808080","#FFED96",rgb(rand_col,rand_col,rand_col)), desired_icon_state = pick(S.all_hair_face))
		equip_loadout(loadout_to_use)
	else
		change_organ_visual("hair_head", desired_color = skin_color, desired_icon_state = pick(S.all_hair_head))
		equip_loadout(loadout_to_use_female)

	update_all_blends()

/mob/living/advanced/npc/ashwalker/Generate()
	drops_gold = RAND_PRECISE(0.5,1.25) * level * (1/SSeconomy.credits_per_gold)
	. = ..()

/mob/living/advanced/npc/ashwalker/hunter
	name = "ashwalker hunter"
	loadout_to_use = /loadout/ashwalker/hunter
	loadout_to_use_female = /loadout/ashwalker/hunter/female

	level = 14

/mob/living/advanced/npc/ashwalker/assassin
	name = "ashwalker assassin"

	loadout_to_use = /loadout/ashwalker/assassin
	loadout_to_use_female = /loadout/ashwalker/assassin/female

	level = 22

/mob/living/advanced/npc/ashwalker/warrior
	name = "ashwalker warrior"

	loadout_to_use = /loadout/ashwalker/warrior
	loadout_to_use_female = /loadout/ashwalker/warrior/female

	level = 50