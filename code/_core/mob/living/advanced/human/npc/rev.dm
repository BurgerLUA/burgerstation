/mob/living/advanced/npc/rev
	name = "revolutionary"
	desc = "FOR THE REVOLUTION!"
	desc_extended = "An ex-nanotrasen revolutionary soldier fighting for their right to \[EXPUNGED\]. Suprisingly, they're not syndicate backed."
	enable_AI = TRUE
	ai = /ai/advanced/syndicate
	class = /class/syndicate_soldier

	var/list/possible_outfits = list(
		//"syndicate" = 100,
		/loadout/rev/olution = 75,
		/loadout/rev/medium_heavy = 50,
		/loadout/rev/heavy = 25,
		/loadout/rev/special_forces = 5
	)

	var/loadout_to_level = list(
		//"syndicate" = 1,
		/loadout/rev/olution = 2,
		/loadout/rev/medium_heavy = 4,
		/loadout/rev/heavy = 8,
		/loadout/rev/special_forces = 16
	)

	var/map_spawn = FALSE

/mob/living/advanced/npc/rev/Destroy()
	if(SShorde && src in SShorde.tracked_enemies)
		SShorde.on_killed_syndicate(src)
	return ..()

/mob/living/advanced/npc/rev/Bump(var/atom/Obstacle)

	if(istype(src,Obstacle) || istype(Obstacle,src))
		return TRUE

	return ..()

/mob/living/advanced/npc/rev/post_death()
	SShorde.on_killed_syndicate(src)
	return ..()


/mob/living/advanced/npc/rev/Initialize()

	var/loadout_to_use = pickweight(possible_outfits)
	level_multiplier *= loadout_to_level[loadout_to_use]

	. = ..()

	var/species/S = all_species[species]

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .