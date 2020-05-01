/mob/living/advanced/npc/syndicate
	name = "syndicate operative"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/
	class = "syndicate"

	var/list/possible_outfits = list(
		"syndicate_soldier" = 200,
		"syndicate_hardsuit" = 10,
		"syndicate_hardsuit_advanced" = 5,
		"syndicate_hardsuit_elite" = 3
	)

	var/loadout_to_level = list(
		"syndicate_soldier" = 1,
		"syndicate_hardsuit" = 2,
		"syndicate_hardsuit_advanced" = 4,
		"syndicate_hardsuit_elite" = 8
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

	var/map_spawn = FALSE

/mob/living/advanced/npc/syndicate/Bump(var/atom/Obstacle)

	if(istype(src,Obstacle) || istype(Obstacle,src))
		return TRUE

	return ..()


/mob/living/advanced/npc/syndicate/post_death()
	SShorde.on_killed_syndicate()
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

	for(var/i=1,i<=2,i++)
		var/picked_weapon = pick(possible_weapons)
		var/obj/item/weapon/ranged/bullet/magazine/W = new picked_weapon(src.loc)
		W.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate
		W.stored_magazine = weapon_to_magazine[W.type]
		INITIALIZE(W)
		SPAWN(W)
		if(i==1)
			right_hand.add_held_object(W)
			left_hand.wield_object(null,W)
			W.click_self(src)
		else
			W.quick_equip(src)

	return .

/mob/living/advanced/npc/syndicate/map
	map_spawn = TRUE

/mob/living/advanced/npc/syndicate/map/double
	level_multiplier = 2

/mob/living/advanced/npc/syndicate/map/triple
	level_multiplier = 3

/mob/living/advanced/npc/syndicate/map/quadruple
	level_multiplier = 3


