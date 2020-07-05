/mob/living/advanced/npc/syndicate
	name = "syndicate operative"
	desc = "A member of the Syndicate crime organization."
	enable_AI = TRUE
	ai = /ai/advanced/syndicate
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/soldier

	var/list/possible_outfits = list(
		/loadout/syndicate/soldier = 75,
		/loadout/syndicate/basic = 8,
		/loadout/syndicate/advanced = 4,
		/loadout/syndicate/elite = 1
	)

	var/loadout_to_level = list(
		/loadout/syndicate/soldier = 2,
		/loadout/syndicate/basic = 4,
		/loadout/syndicate/advanced = 8,
		/loadout/syndicate/elite = 16
	)

	var/map_spawn = FALSE

/mob/living/advanced/npc/syndicate/Destroy()
	if(SShorde && src in SShorde.tracked_enemies)
		SShorde.on_killed_syndicate(src)
	return ..()

/mob/living/advanced/npc/syndicate/Bump(var/atom/Obstacle)

	if(istype(src,Obstacle) || istype(Obstacle,src))
		return TRUE

	return ..()

/mob/living/advanced/npc/syndicate/post_death()
	SShorde.on_killed_syndicate(src)
	return ..()

/mob/living/advanced/npc/syndicate/Initialize()

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

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .

/mob/living/advanced/npc/syndicate/map
	map_spawn = TRUE

/mob/living/advanced/npc/syndicate/map/double
	level_multiplier = 2

/mob/living/advanced/npc/syndicate/map/triple
	level_multiplier = 3

/mob/living/advanced/npc/syndicate/map/quadruple
	level_multiplier = 4


