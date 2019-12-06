/mob/living/advanced/npc/dummy
	name = "feral greytider"
	ai = /ai/dummy
	class = "dummy"
	species = "dummy"

/mob/living/advanced/npc/dummy/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#EFC700")
	change_organ_visual("hair_head", desired_color = "#EFC700", desired_icon_state = "none")
	update_all_blends()

	add_outfit("shopkeeper_outfit")

	var/list/possible_weapons = list(
		/obj/item/weapon/melee/toolbox/red,
		/obj/item/weapon/melee/toolbox/green,
		/obj/item/weapon/melee/toolbox/blue
	)

	var/picked_weapon = pick(possible_weapons)

	var/obj/item/weapon/W = new picked_weapon(src.loc)
	pickup(W)

	return .