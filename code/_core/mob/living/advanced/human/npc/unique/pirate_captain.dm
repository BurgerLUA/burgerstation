/mob/living/advanced/npc/unique/pirate_captain
	name = "Captain Condom"
	id = "captain"
	desc = "The one and only."
	desc = "The infamous Captain Condom. They lead a skeleton crew of murderous skeletons called the murderboners."
	species = "skeleton"
	sex = MALE
	gender = MALE
	boss_music = "skeletons"
	boss = TRUE
	ai = /ai/advanced/skeleton

	class = /class/pirate
	level_multiplier = 3

	health_base = 1200

	loyalty_tag = "Skeleton"
	iff_tag = "Skeleton"

/mob/living/advanced/npc/unique/pirate_captain/Initialize()
	. = ..()
	equip_loadout(/loadout/pirate/captain)
	return .

/mob/living/advanced/npc/unique/pirate_mate
	name = "HOS COOL"
	desc = "THE FUCKING COOLEST."
	desc_extended = "Captain Condom's second in command, but we all know he's the one in charge."
	species = "skeleton"
	sex = MALE
	gender = MALE

	class = /class/pirate
	level_multiplier = 2

	health_base = 1200

	loyalty_tag = "Skeleton"
	iff_tag = "Skeleton"
	ai = /ai/advanced/skeleton

/mob/living/advanced/npc/unique/pirate_mate/Initialize()
	. = ..()
	equip_loadout(/loadout/pirate/mate)
	return .

/mob/living/advanced/npc/pirate_crew
	name = "skeleton crew"
	desc = "RATTLE ME BONES."
	desc = "A skeleton pirate belonging to Captain Condom's crew of pirates."
	species = "skeleton"
	sex = MALE
	gender = MALE
	var/desired_loadout = /loadout/pirate/crew
	class = /class/pirate

	loyalty_tag = "Skeleton"
	iff_tag = "Skeleton"
	ai = /ai/advanced/skeleton


/mob/living/advanced/npc/pirate_crew/Initialize()
	. = ..()
	equip_loadout(desired_loadout)
	return .

/mob/living/advanced/npc/pirate_crew/ranged
	name = "skeleton crew marksman"
	desired_loadout = /loadout/pirate/crew/ranged

/mob/living/advanced/npc/pirate_crew/magic
	name = "skeleton crew mage"
	desired_loadout = /loadout/pirate/crew/magic

/mob/living/advanced/npc/pirate_crew/melee
	name = "skeleton crew brawler"
	desired_loadout = /loadout/pirate/crew/melee