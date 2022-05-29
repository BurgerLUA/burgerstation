/mob/living/advanced/npc/unique/that_guy
	name = "That Guy"
	desc = "Hey, it's that guy."

	ai = /ai/advanced

	sex = MALE
	gender = MALE

	loyalty_tag = "Knight"
	iff_tag = "Knight"

	species = "stand"

	blood_type = /reagent/blood/human/ab_negative

	level = 60

/mob/living/advanced/npc/unique/that_guy/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#CB7F4F")

	change_organ_visual("hair_head", desired_color = "#8A5B34", desired_icon_state = "hair_crewcut_s")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)

	equip_loadout(/loadout/that_guy)

	update_all_blends()