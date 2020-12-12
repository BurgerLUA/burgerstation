/mob/living/advanced/npc/unique/knight
	name = "Knight Template"
	desc = "Using guns is DISHONORABLE."
	sex = MALE
	gender = MALE

	class = /class/pirate
	level_multiplier = 3

	health_base = 500

	loyalty_tag = "Knight"
	iff_tag = "Knight"

	ai = /ai/advanced/skeleton

	var/loadout

/mob/living/advanced/npc/unique/knight/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)
	return FALSE //Immune

/mob/living/advanced/npc/unique/knight/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	equip_loadout(loadout)

	update_all_blends()

	return .

/mob/living/advanced/npc/unique/knight/red
	name = "Red Knight"
	loadout = /loadout/knight/red

/mob/living/advanced/npc/unique/knight/blue
	name = "Blue Knight"
	loadout = /loadout/knight/blue

/mob/living/advanced/npc/unique/knight/green
	name = "Green Knight"
	loadout = /loadout/knight/green

/mob/living/advanced/npc/unique/knight/yellow
	name = "Yellow Knight"
	loadout = /loadout/knight/yellow

