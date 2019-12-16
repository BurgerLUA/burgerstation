/mob/living/advanced/npc/ashwalker
	name = "ashwalker villager"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/ashwalker
	class = "ashwalker"

	species = "reptile"

	loot_drop_in_corpse = TRUE

	var/outfit_to_use = "ashwalker"
	var/shield_chance = 0
	var/spear_chance = 25

	loot_drop = "ashwalker"

/mob/living/advanced/npc/ashwalker/New(loc,desired_client,desired_level_multiplier)

	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done

	. = ..()

	level_multiplier *= rand(90,150)/100

	return .


/mob/living/advanced/npc/ashwalker/Initialize()

	. = ..()

	var/skin_color = sex == MALE ? rgb(rand(75,120),rand(75,120),rand(75,120)) : rgb(rand(120,200),rand(120,200),rand(120,200))

	if(sex == FEMALE)
		outfit_to_use = outfit_to_use + "_female"

	var/rand_col = rand(50,200)
	var/horn_color =  sex == MALE ? pick("#FFF0BE","#808080","#FFED96",rgb(rand_col,rand_col,rand_col)) : skin_color

	var/horns_to_use = sex == MALE ? "horns" : pick("frills_long","frills_short","frills_aqua")

	change_organ_visual("skin", desired_color = skin_color)
	change_organ_visual("hair_head", desired_color = horn_color, desired_icon_state = horns_to_use)

	update_all_blends()
	add_outfit(outfit_to_use)


	if(prob(shield_chance))
		pickup(new /obj/item/weapon/melee/shield(src.loc),TRUE)

	if(spear_chance)
		pickup(new /obj/item/weapon/melee/spear(src.loc),FALSE)

	return .

/mob/living/advanced/npc/ashwalker/hunter
	name = "ashwalker hunter"
	level_multiplier = 1.25
	spear_chance = 100

/mob/living/advanced/npc/ashwalker/warrior
	name = "ashwalker warrior"
	level_multiplier = 1.5
	outfit_to_use = "ashwalker_warrior"
	spear_chance = 100
	shield_chance = 50

	loot_drop = "ashwalker_warrior"