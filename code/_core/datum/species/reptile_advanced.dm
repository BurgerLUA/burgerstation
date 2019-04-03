/species/reptile_advanced/
	name = "Advanced Reptile"
	desc = "Fucking furries. Advanced."
	id = "reptile_advanced"
	flags_species = SPECIES_REPTILE_ADVANCED

	flags_chargen = CHARGEN_COLOR_SKIN | CHARGEN_COLOR_EYE | CHARGEN_COLOR_HAIR | CHARGEN_STYLE_HAIR | CHARGEN_SEX

	default_color_eye = "#AAAA00"
	default_color_skin = "#8CA73E"
	default_color_hair = "#fff0be"

	default_icon_state_hair = "bald"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/reptile_advanced,
		BODY_HEAD = /obj/item/organ/head/reptile_advanced,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile_advanced,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile_advanced,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile_advanced/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile_advanced,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile_advanced/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile_advanced,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile_advanced/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile_advanced,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile_advanced/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile_advanced,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile_advanced/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile_advanced,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile_advanced/left,
		BODY_TAIL = /obj/item/organ/tail/reptile_advanced
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/reptile_advanced/female,
		BODY_HEAD = /obj/item/organ/head/reptile_advanced/female,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile_advanced/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile_advanced,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile_advanced/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile_advanced,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile_advanced/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile_advanced,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile_advanced/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile_advanced,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile_advanced/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile_advanced,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile_advanced/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile_advanced,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile_advanced/left,
		BODY_TAIL = /obj/item/organ/tail/reptile_advanced
	)

	chargen_hair_colors = list(
		"bone" = "#fff0be",
		"grey" = "#888888"
	)

	chargen_skin_colors = list(
		"natural green" = "#8CA73E",
		"albino" = "#FFFFFF",
		"edgelord" = "#222222",
	)

	chargen_eye_colors = list(
		"natural yellow" = "#AAAA00",
		"orange" = "#FF8800",
		"blue" = "#444488",
		"red" = "#884444",
		"green" = "#448844",
	)