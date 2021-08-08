/species/golem/
	name = "Golem"
	desc = "Fucking stone people."
	id = "golem"
	flags_species = SPECIES_GOLEM

	flags_chargen = CHARGEN_SKIN

	default_color_eye = "#FFFFFF"
	default_color_skin = "#BC9D58"
	default_color_hair = "#008800"

	genderless = FALSE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/golem,
		BODY_HEAD = /obj/item/organ/head/golem,
		BODY_GROIN = /obj/item/organ/groin/golem,
		BODY_LEG_RIGHT = /obj/item/organ/leg/golem,
		BODY_LEG_LEFT = /obj/item/organ/leg/golem/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/golem,
		BODY_FOOT_LEFT = /obj/item/organ/foot/golem/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/golem,
		BODY_ARM_LEFT = /obj/item/organ/arm/golem/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/golem,
		BODY_HAND_LEFT = /obj/item/organ/hand/golem/left,

		BODY_EYE_RIGHT = /obj/item/organ/eye/golem,
		BODY_EYE_LEFT = /obj/item/organ/eye/golem/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)
	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/golem,
		BODY_HEAD = /obj/item/organ/head/golem,
		BODY_GROIN = /obj/item/organ/groin/golem,
		BODY_LEG_RIGHT = /obj/item/organ/leg/golem,
		BODY_LEG_LEFT = /obj/item/organ/leg/golem/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/golem,
		BODY_FOOT_LEFT = /obj/item/organ/foot/golem/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/golem,
		BODY_ARM_LEFT = /obj/item/organ/arm/golem/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/golem,
		BODY_HAND_LEFT = /obj/item/organ/hand/golem/left,

		BODY_EYE_RIGHT = /obj/item/organ/eye/golem,
		BODY_EYE_LEFT = /obj/item/organ/eye/golem/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

	inherent_traits = list(
		/trait/metabolism/none,
		/trait/pain_tolerant,
		/trait/flamability/fire_retardant,
		/trait/death_check/tenacious,
		/trait/intoxication_regen/seasoned_drinker,
		/trait/bleed_multiplier/hard_skin,
		/trait/general_regen/jock,
		/trait/speed/slow,
		/trait/vitality/strong
	)
