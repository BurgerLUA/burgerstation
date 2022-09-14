/mob/living/advanced/npc/contractor_guard
	name = "nanotrasen elite guard"
	desc = "The very best assigned to guard this old man."

	ai = /ai/advanced/guarding

	dialogue_id = null

	loadout = /loadout/nanotrasen/elite

	level = 80

/mob/living/advanced/npc/contractor_guard/Generate()
	sex = pick(MALE,FEMALE)
	gender = prob(1) ? pick(MALE,FEMALE) : sex
	. = ..()

/mob/living/advanced/npc/clockwork_cultist/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
