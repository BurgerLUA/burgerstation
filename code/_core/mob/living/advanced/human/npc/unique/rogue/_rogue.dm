//These are basically humanoid minibosses with loot.

/mob/living/advanced/npc/unique/rogue
	loyalty_tag = "Rogue"
	iff_tag = "Rogue"

	health_base = 2000
	stamina_base = 2000
	mana_base = 2000

	level = 100

	ai = /ai/advanced

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		DISARM = TRUE,
		GRAB = TRUE,
		PAINCRIT = TRUE
	)

/mob/living/advanced/npc/unique/rogue/Finalize()
	. = ..()
	SSbosses.tracked_rogue_crewmembers += src

/mob/living/advanced/npc/unique/rogue/PreDestroy()
	. = ..()
	SSbosses.tracked_rogue_crewmembers -= src