/mob/living/advanced/npc/syndicate
	name = "syndicate operative"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/ranged
	class = "syndicate"

	var/list/possible_outfits = list(
		"syndicate_hardsuit" = 200,
		"syndicate_hardsuit_advanced" = 10,
		"syndicate_hardsuit_elite" = 5
	)

	var/outfit_to_level = list(
		"syndicate_hardsuit" = 1,
		"syndicate_hardsuit_advanced" = 2,
		"syndicate_hardsuit_elite" = 3
	)

	var/list/possible_weapons = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet = 1,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre = 1,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie = 1,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper = 1,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg = 1,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull = 1,
		/obj/item/weapon/ranged/bullet/magazine/smg/handheld = 1
	)

	var/list/weapon_to_magazine = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet = /obj/item/magazine/gyrojet,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre = /obj/item/magazine/pistol_12mm,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie = /obj/item/magazine/pistol_10mm,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper = /obj/item/magazine/sniper_762,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg = /obj/item/magazine/lmg_556,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull = /obj/item/magazine/shotgun_auto,
		/obj/item/weapon/ranged/bullet/magazine/smg/handheld = /obj/item/magazine/smp_9mm
	)

/mob/living/advanced/npc/syndicate/Bump(var/atom/Obstacle)

	if(istype(src,Obstacle) || istype(Obstacle,src))
		return TRUE

	return ..()


/mob/living/advanced/npc/syndicate/post_death()
	SShorde.on_killed_syndicate()
	return ..()

/mob/living/advanced/npc/syndicate/Initialize()

	var/outfit_to_use = pickweight(possible_outfits)
	level_multiplier *= outfit_to_level[outfit_to_use]

	. = ..()

	var/species/S = all_species[species]

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE)
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)

	update_all_blends()

	add_outfit(outfit_to_use)

	var/picked_weapon = pick(possible_weapons)

	/*
	var/obj/item/weapon/ranged/bullet/magazine/W = new picked_weapon(src.loc)
	W.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate
	W.stored_magazine = weapon_to_magazine[W.type]
	W.on_spawn()
	put_in_hands(W)
	if(W.can_wield)
		W.wield(src,W.loc == left_hand ? right_hand : left_hand)
	W.click_self(src)
	*/

	return .


/mob/living/advanced/npc/syndicate/double
	level_multiplier = 2

/mob/living/advanced/npc/syndicate/triple
	level_multiplier = 3

/mob/living/advanced/npc/syndicate/quadruple
	level_multiplier = 3