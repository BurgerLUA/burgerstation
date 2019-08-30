/mob/living/advanced/player/debug
	name = "debug player"



/mob/living/advanced/player/debug/Initialize()

	..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon = 'icons/mob/living/advanced/hair/face.dmi', desired_icon_state = "facial_wise_s")
	update_all_blends()
	add_outfit("wizard")
	pickup(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	pickup(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .