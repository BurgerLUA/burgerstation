/mob/living/advanced/npc/ashwalker
	name = "ashwalker villager"
	ai = /ai/advanced/ashwalker
	class = /class/ashwalker

	species = "reptile"

	var/loadout_to_use = /loadout/ashwalker/
	var/shield_chance = 0
	var/spear_chance = 25

	loyalty_tag = "Ashwalker"
	iff_tag = "Ashwalker"

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
		loadout_to_use = loadout_to_use + "_female"

	var/rand_col = rand(50,200)
	var/horn_color =  sex == MALE ? pick("#FFF0BE","#808080","#FFED96",rgb(rand_col,rand_col,rand_col)) : skin_color

	var/horns_to_use = sex == MALE ? "horns" : pick("frills_long","frills_short","frills_aqua")

	change_organ_visual("skin", desired_color = skin_color)
	change_organ_visual("hair_head", desired_color = horn_color, desired_icon_state = horns_to_use)

	update_all_blends()
	equip_loadout(loadout_to_use)


	if(prob(shield_chance))
		put_in_hands(new /obj/item/weapon/melee/shield(src.loc),TRUE)

	if(spear_chance)
		put_in_hands(new /obj/item/weapon/melee/spear(src.loc),FALSE)

	return .

/mob/living/advanced/npc/ashwalker/hunter
	name = "ashwalker hunter"
	level_multiplier = 1.25
	spear_chance = 100

/mob/living/advanced/npc/ashwalker/warrior
	name = "ashwalker warrior"
	level_multiplier = 1.5
	loadout_to_use = /loadout/ashwalker/warrior
	spear_chance = 100
	shield_chance = 50