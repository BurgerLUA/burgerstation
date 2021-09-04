/mob/living/advanced/npc/goblin
	name = "goblin"
	desc = "Raiding settlements since 4506 BC."

	ai = /ai/advanced

	species = "goblin"

	pixel_z = -2

	iff_tag = "Goblin"
	loyalty_tag = "Goblin"

	var/loadout_to_use = /loadout/goblin

	blood_type = /reagent/blood/goblin

	level = 5

/mob/living/advanced/npc/goblin/Initialize()

	. = ..()

	sex = MALE
	gender = sex

	change_organ_visual("skin", desired_color = pick("#3D6300","#425125","#4E5B0E","#686342"))

	update_all_blends()

	equip_loadout(loadout_to_use)

/mob/living/advanced/npc/goblin/warrior
	name = "goblin warrior"
	loadout_to_use = /loadout/goblin/warrior
	health_base = 300
	stamina_base = 200
	mana_base = 100

	level = 12

/mob/living/advanced/npc/goblin/mage
	name = "goblin mage"
	loadout_to_use = /loadout/goblin/mage
	health_base = 200
	stamina_base = 100
	mana_base = 300

	level = 14
