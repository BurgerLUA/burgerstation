/mob/living/advanced/npc/halo/marine
	name = "UNSC marine"
	desc = "A fellow soldier"
	desc_extended = "A low-ranking UNSC soldier tasked with defending the ship and assisting with higher ranking UNSC personnel with missions."
	enable_AI = TRUE
	ai = /ai/advanced/nanotrasen
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/soldier/
	var/loadout_to_use = /loadout/halo/unsc_soldier

/mob/living/advanced/npc/halo/marine/lobby
	ai = /ai/advanced/nanotrasen/lobby

/mob/living/advanced/npc/halo/marine/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .

/mob/living/advanced/npc/halo/urf
	name = "URF soldier"
	desc = "A fellow soldier"
	desc_extended = "A low-ranking URF soldier tasked with defending the ship and assisting with higher ranking URF personnel with missions."
	enable_AI = TRUE
	ai = /ai/advanced/halo/urf
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/soldier/second
	var/loadout_to_use = /loadout/halo/urf_soldier

/mob/living/advanced/npc/halo/urf/riflemen
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/pointmen
	loadout_to_use = /loadout/halo/urf_pointmen
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/marksmen
	loadout_to_use = /loadout/halo/urf_marksmen
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/demolitions
	loadout_to_use = /loadout/halo/urf_demolitions
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/commando
	loadout_to_use = /loadout/halo/urf_commando
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/hmg
	loadout_to_use = /loadout/halo/urf_hmg
	ai = /ai/advanced/halo/urf/firefight

/mob/living/advanced/npc/halo/urf/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .

/mob/living/advanced/npc/halo/unggoy
	name = "Unggoy Minor"
	desc = "Funny grunt"
	desc_extended = "A low-ranking Covenant unit."
	icon_state = "halo_unggoy"
	enable_AI = TRUE
	ai = /ai/advanced/halo/unggoy
	dialogue_id = /dialogue/npc/covenant
	class = /class/syndicate_soldier

	species = "unga"
	loyalty_tag = "Covenant"
	iff_tag = "Covenant"

	var/loadout_to_use = /loadout/nt/halo/covenant/unggoyminor

/mob/living/advanced/npc/halo/unggoy/lobby
	ai = /ai/advanced/halo/unggoy/lobby

/mob/living/advanced/npc/halo/unggoy/Initialize()

	. = ..()

	sex = pick(MALE,FEMALE)
	gender = sex

	equip_loadout(loadout_to_use)

	update_all_blends()



	return .

/mob/living/advanced/npc/halo/kigyar
	name = "Kig-Yar Scout"
	desc = "Deadly sniper"
	desc_extended = "A low-ranking but good trained Covenant unit."
	icon_state = "halo_kigyar1"
	enable_AI = TRUE
	ai = /ai/advanced/halo/kigyar
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/covenant

	movement_delay = 1

	species = "Kigyar"
	loyalty_tag = "Covenant"
	iff_tag = "Covenant"

	var/loadout_to_use = /loadout/nt/halo/covenant/kigyar

/mob/living/advanced/npc/halo/kigyar/Initialize()

	. = ..()

	sex = pick(MALE,FEMALE)
	gender = sex

	equip_loadout(loadout_to_use)

	update_all_blends()



	return .

/mob/living/advanced/npc/halo/kigyar/ranged
	icon_state = "halo_kigyar1"
	loadout_to_use = /loadout/nt/halo/covenant/kigyar_ranged

/mob/living/advanced/npc/halo/kigyar/ranged/lobby
	ai = /ai/advanced/halo/kigyar/lobby

/mob/living/advanced/npc/halo/elite
	name = "Elite Minor"
	desc = "Fearless warrior"
	desc_extended = "A low-ranking Elite."
	icon_state = "halo_elite"
	enable_AI = TRUE
	ai = /ai/advanced/halo/elite
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/covenant

	species = "Elite"
	loyalty_tag = "Covenant"
	iff_tag = "Covenant"

	var/loadout_to_use = /loadout/nt/halo/covenant/elite_minor

/mob/living/advanced/npc/halo/elite/Initialize()

	. = ..()

	sex = pick(MALE,FEMALE)
	gender = sex

	equip_loadout(loadout_to_use)

	update_all_blends()



	return .