/mob/living/simple/rat_king
	name = "rat king"
	desc = "King of the underground."
	desc_extended = "A rare mutated rat from some experiment gone wrong."
	icon = 'icons/mob/living/simple/rat_king.dmi'
	icon_state = "living"

	health_base = 600
	stamina_base = 400
	mana_base = 300

	value = 300

	ai = /ai/

	damage_type = /damagetype/unarmed/claw/

	armor = /armor/demon

	size = SIZE_GIANT

	iff_tag = "Rat"
	loyalty_tag = "Rat"

	blood_type = /reagent/blood/rat
	blood_volume = 400

	soul_size = SOUL_SIZE_RARE

	level = 40


/mob/living/simple/rat_king/post_death()
	. = ..()
	icon_state = "dead"