/mob/living/advanced/npc/zombie/bloated

	name = "bloated zombie"
	loadout = /loadout/zombie/bloated

	level = 30

	health_base = 500
	stamina_base = 50
	mana_base = 100

	movement_delay = DECISECONDS_TO_TICKS(16)

	sex = MALE
	gender = MALE


/mob/living/advanced/npc/zombie/bloated/Finalize()
	. = ..()
	add_status_effect(FAT,100,-1, force = TRUE)
