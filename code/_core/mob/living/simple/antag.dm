var/global/list/valid_antag_colors = list(
	"#C51111",
	"#71491E",
	"#EF7D0D",
	"#F6F658",
	"#ED54BA",
	"#6B2FBB",
	"#132ED1",
	"#38FEDB",
	"#117F2D",
	"#50EF39",
	"#D6E0F0",
	"#3F474E"
)

/mob/living/simple/antag
	name = "crewmember"
	desc = "Uh..."
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/antag.dmi'
	icon_state = "living"

	health_base = 1

	ai = /ai/traitor
	class = /class/player
	damage_type = /damagetype/npc/antag

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	size = SIZE_BOSS

	armor_base = list(
		ION = INFINITY
	)

	attack_range = 3

	movement_delay = DECISECONDS_TO_TICKS(1.5)

	stun_angle = 0

	enable_security_hud = TRUE
	enable_medical_hud = TRUE

	size = SIZE_HUMAN

/mob/living/simple/antag/Initialize()
	var/image/I = new/image(icon,"shadow")
	I.blend_mode = BLEND_MULTIPLY
	add_underlay(I)
	return ..()

/mob/living/simple/antag/Generate()

	var/chosen_color
	if(length(valid_antag_colors))
		chosen_color = pick(valid_antag_colors)
		valid_antag_colors -= chosen_color
	else
		chosen_color = random_color()

	color = chosen_color

	var/list/blood_types = list(
		/reagent/blood/human/ab_negative = 6,
		/reagent/blood/human/b_negative = 15,
		/reagent/blood/human/ab_positive = 34,
		/reagent/blood/human/a_negative = 63,
		/reagent/blood/human/o_negative = 66,
		/reagent/blood/human/b_positive = 85,
		/reagent/blood/human/a_positive = 357,
		/reagent/blood/human/o_positive = 374,
	)

	blood_type = pickweight(blood_types)

	return ..()

/mob/living/simple/antag/Finalize()
	update_sprite()
	return ..()

/mob/living/simple/antag/update_sprite()
	//Custom snowflake code.
	overlays.Cut()
	var/image/I = new/image(icon,"[icon_state]_visor")
	I.appearance_flags = RESET_COLOR
	add_overlay(I)
	return TRUE


/mob/living/simple/antag/post_death()
	icon_state = "dead"
	update_sprite()
	return ..()