/mob/living/advanced/player/debug
	name = "debug player"

/mob/living/advanced/player/debug/Initialize()

	mobdata = new(null)

	. = ..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon_state = "facial_wise_s")
	update_all_blends()
	equip_loadout("wizard")
	put_in_hands(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	put_in_hands(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

/mob/living/advanced/player/debug/on_life()
	move_dir = pick(DIRECTIONS_ALL)
	return ..()