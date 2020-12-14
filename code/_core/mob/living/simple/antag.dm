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

	mob_size = MOB_SIZE_BOSS

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = INFINITY
	)

	attack_range = 3

	movement_delay = DECISECONDS_TO_TICKS(1.5)

	stun_angle = 0

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