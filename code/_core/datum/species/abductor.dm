/species/abductor/
	name = "Abductor"
	desc = "Ayy lmao."
	id = "abductor"
	flags_species = SPECIES_ABDUCTOR

	flags_chargen = CHARGEN_EYE | CHARGEN_SKIN

	bite_size = 1

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/abductor,
		BODY_HEAD = /obj/item/organ/head/abductor,
		BODY_GROIN = /obj/item/organ/groin/abductor,
		BODY_LEG_RIGHT = /obj/item/organ/leg/abductor,
		BODY_LEG_LEFT = /obj/item/organ/leg/abductor/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/abductor,
		BODY_FOOT_LEFT = /obj/item/organ/foot/abductor/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/abductor,
		BODY_ARM_LEFT = /obj/item/organ/arm/abductor/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/abductor,
		BODY_HAND_LEFT = /obj/item/organ/hand/abductor/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/abductor,
		BODY_EYE_LEFT = /obj/item/organ/eye/abductor/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_HEART = /obj/item/organ/internal/heart,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)