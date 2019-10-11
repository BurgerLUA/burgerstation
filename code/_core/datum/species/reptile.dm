/species/reptile/
	name = "Reptile"
	desc = "Fucking furries"
	id = "reptile"
	flags_species = SPECIES_REPTILE_FERAL

	flags_chargen = CHARGEN_COLOR_SKIN | CHARGEN_COLOR_EYE | CHARGEN_COLOR_HAIR | CHARGEN_STYLE_HAIR | CHARGEN_SEX

	default_icon_hair = 'icons/mob/living/advanced/hair/reptile_hair_head.dmi'
	default_icon_state_hair = "bald"

	default_icon_face = 'icons/mob/living/advanced/hair/reptile_hair_face.dmi'
	default_icon_state_face = "none"

	default_color_eye = "#AAAA00"
	default_color_skin = "#8CA73E"
	default_color_hair = "#fff0be"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/reptile,
		BODY_HEAD = /obj/item/organ/head/reptile,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left,
		BODY_TAIL = /obj/item/organ/tail/reptile,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/reptile/female,
		BODY_HEAD = /obj/item/organ/head/reptile/female,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left,
		BODY_TAIL = /obj/item/organ/tail/reptile,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)