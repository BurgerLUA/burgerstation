/species/reptile/advanced
	name = "Advanced Reptile"
	desc = "Fucking furries. Advanced."
	id = "reptile_advanced"
	flags_species = SPECIES_REPTILE_ADVANCED

	bite_size = 10

	flags_chargen = CHARGEN_SKIN | CHARGEN_EYE | CHARGEN_HAIR | CHARGEN_BEARD | CHARGEN_SEX

	default_hairstyle_chargen_male = 1
	default_hairstyle_chargen_female = 1

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/reptile_advanced,
		BODY_HEAD = /obj/item/organ/head/reptile_advanced,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,
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
		BODY_TAIL = /obj/item/organ/tail/reptile_advanced,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/reptile_advanced/female,
		BODY_HEAD = /obj/item/organ/head/reptile_advanced/female,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,
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
		BODY_TAIL = /obj/item/organ/tail/reptile_advanced,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

/species/reptile/advanced/generate_blood_type()
	return /reagent/blood/reptile