/mob/living/advanced/npc/evil_wizard
	name = "Merlin"
	id = "merlin"
	ai = /ai/advanced/ranged/
	class = /class/wizard

	force_spawn = TRUE
	boss = TRUE

/mob/living/advanced/npc/evil_wizard/Initialize()

	. = ..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon_state = "facial_wise_s")
	update_all_blends()
	equip_loadout(/loadout/wizard/evil)

	var/obj/item/weapon/ranged/magic/staff/basic/B = new(src.loc)
	INITIALIZE(B)
	GENERATE(B)
	var/obj/item/weapon/ranged/magic/tome/lightning/L = new(src.loc)
	INITIALIZE(L)
	GENERATE(L)
	put_in_hands(B,FALSE)
	put_in_hands(L,TRUE)

	