/mob/living/advanced/npc/tax_man
	name = "tax man"
	desc = "Handles your tax."
	desc_extended = "Pay your taxes or suffer the consequences."
	enable_AI = TRUE
	ai = null
	move_mod = 1
	class = /class/cyborg/
	dialogue_id = /dialogue/npc/taxman/
	anchored = TRUE

/mob/living/advanced/npc/tax_man/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(/loadout/taxman)

	return .


/mob/living/advanced/npc/tax_man/helper
	name = "tax assistant"
	desc = "Explains things to you."
	desc_extended = "Pay your taxes or suffer the consequences."