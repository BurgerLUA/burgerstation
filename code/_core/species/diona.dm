/datum/species/diona/
	name = "Dionae"
	desc = "Fucking tree people."
	id = "diona"
	flags_species = SPECIES_DIONA

	flags_chargen = CHARGEN_COLOR_SKIN | CHARGEN_COLOR_DETAIL | CHARGEN_COLOR_GLOW

	default_color_eye = "#88FF88"
	default_color_skin = "#BC9D58"
	default_color_hair = "#008800"
	default_color_detail = "#719333"
	default_color_glow = "#B2F861"

	default_icon_state_hair = "diona"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/diona,
		BODY_HEAD = /obj/item/organ/head/diona,
		BODY_GROIN = /obj/item/organ/groin/diona,
		BODY_LEG_RIGHT = /obj/item/organ/leg/diona,
		BODY_LEG_LEFT = /obj/item/organ/leg/diona/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/diona,
		BODY_FOOT_LEFT = /obj/item/organ/foot/diona/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/diona,
		BODY_ARM_LEFT = /obj/item/organ/arm/diona/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/diona,
		BODY_HAND_LEFT = /obj/item/organ/hand/diona/left
	)

	chargen_skin_colors = list(
		"natural brown" = "#BC9D58",
		"albino" = "#FFFFFF",
		"edgelord" = "#222222",
	)

	chargen_detail_colors = list(
		"natural green" = "#719333",
		"blue" = "#444488",
		"red" = "#884444",
		"green" = "#448844",
	)

	chargen_glow_colors = list(
		"natural green" = "#B2F861",
		"blue" = "#0000FF",
		"red" = "#FF0000",
		"green" = "#00FF00",
		"yellow" = "#FFFF00"
	)