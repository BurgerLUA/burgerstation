/mob/living/advanced/npc/zombie
	name = "zombie"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/zombie
	class = "zombie"

	species = "human"

	loot_drop_in_corpse = TRUE

	var/outfit_to_use = "zombie"
	var/spear_chance = 0

	loot_drop = "zombie"

/mob/living/advanced/npc/zombie/New(loc,desired_client,desired_level_multiplier)

	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done

	return ..()


/mob/living/advanced/npc/zombie/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#5D7F00")
	change_organ_visual("hair_head", desired_color = "#111111")
	change_organ_visual("eye", desired_color = "#FF0000")

	update_all_blends()
	add_outfit(outfit_to_use)

	if(spear_chance)
		pickup(new /obj/item/weapon/melee/spear(src.loc),FALSE)

	return .


/mob/living/advanced/npc/zombie/winter
	outfit_to_use = "zombie_winter"
	loot_drop = "zombie"
	spear_chance = 100