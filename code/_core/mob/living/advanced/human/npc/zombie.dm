/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/
	class = "zombie"

	species = "human"


	var/loadout_to_use = "zombie"
	var/spear_chance = 0


/mob/living/advanced/npc/zombie/New(loc,desired_client,desired_level_multiplier)

	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done

	return ..()


/mob/living/advanced/npc/zombie/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#5D7F00")
	change_organ_visual("hair_head", desired_icon_state = "hair_a", desired_color = "#111111")
	change_organ_visual("eye", desired_color = "#FF0000")

	update_all_blends()
	equip_loadout(loadout_to_use)

	if(spear_chance)
		put_in_hands(new /obj/item/weapon/melee/spear(src.loc),FALSE)

	return .


/mob/living/advanced/npc/zombie/winter
	loadout_to_use = "zombie_winter"
	spear_chance = 100
	level_multiplier = 1.5

/mob/living/advanced/npc/zombie/desert
	loadout_to_use = "zombie_desert"
	spear_chance = 0
	level_multiplier = 2
