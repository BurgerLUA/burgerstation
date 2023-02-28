/species/cyborg/advanced
	name = "Advanced Cyborg"
	desc = "Fucking metal people."
	id = "cyborg_advanced"
	flags_species = SPECIES_CYBORG

	flags_chargen = CHARGEN_NONE

	bite_size = 20

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/gopro,
		BODY_HEAD = /obj/item/organ/head/gopro,
		BODY_GROIN = /obj/item/organ/groin/gopro,
		BODY_LEG_RIGHT = /obj/item/organ/leg/gopro,
		BODY_LEG_LEFT = /obj/item/organ/leg/gopro/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/gopro,
		BODY_FOOT_LEFT = /obj/item/organ/foot/gopro/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/gopro,
		BODY_ARM_LEFT = /obj/item/organ/arm/gopro/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/gopro,
		BODY_HAND_LEFT = /obj/item/organ/hand/gopro/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/gopro,
		BODY_EYE_LEFT = /obj/item/organ/eye/gopro/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/gopro,
		BODY_EAR_LEFT = /obj/item/organ/ear/gopro/left,

		BODY_BRAIN = /obj/item/organ/internal/brain/robotic,
		BODY_LUNGS = /obj/item/organ/internal/lungs/robotic,
		BODY_STOMACH = /obj/item/organ/internal/stomach/robotic,
		BODY_LIVER = /obj/item/organ/internal/liver/robotic,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines/robotic,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys/robotic
	)

	health = /health/mob/living/advanced/robotic

	valid_blood_types = list(
		/reagent/blood/human/ab_positive
	)

/species/cyborg/advanced/generate_blood_type()
	return /reagent/blood/human/ab_positive