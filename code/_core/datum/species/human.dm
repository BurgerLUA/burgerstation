/species/human/
	name = "Human"
	desc = "Vanilla as fuck."
	id = "human"
	flags_species = SPECIES_HUMAN

	flags_chargen = CHARGEN_COLOR_SKIN | CHARGEN_COLOR_EYE | CHARGEN_COLOR_HAIR | CHARGEN_STYLE_HAIR | CHARGEN_SEX

	default_color_eye = "#000000"
	default_color_skin = "#e0b19d"
	default_color_hair = "#000000"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso,
		BODY_HEAD = /obj/item/organ/head,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye,
		BODY_EYE_LEFT = /obj/item/organ/eye/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear,
		BODY_EAR_LEFT = /obj/item/organ/ear/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys

	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/female,
		BODY_HEAD = /obj/item/organ/head/female,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye,
		BODY_EYE_LEFT = /obj/item/organ/eye/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear,
		BODY_EAR_LEFT = /obj/item/organ/ear/left,

		/*
		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
		*/
	)

	chargen_hair_colors = list(
		"black" = "#ffffff",
		"grey" = "#5e5954",
		"dark brown" = "#60330d",
		"blond" = "#d3c276",
		"light brown" = "#9e5625"
	)

	chargen_skin_colors = list(
		"pale" = "#fff3e8",
		"white" = "#ffd6ba",
		"tan" = "#e0b19d",
		"dark" = "#bc9784",
		"darker" = "#997563",
		"ebony" = "#63493c",
		"black" = "#35241c"
	)

	chargen_eye_colors = list(
		"black" = "#000000",
		"blue" = "#66c4ff",
		"brown" = "#6b431f",
		"dark brown" = "#3d220a",
		"green" = "#435b1d",
		"grey" = "#999999"
	)