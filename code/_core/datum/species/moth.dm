/species/moth/
	name = "Moth"
	desc = "Still furry."
	id = "moth"
	flags_species = SPECIES_MOTH
	bite_size = 5

	flags_chargen = CHARGEN_SKIN | CHARGEN_SEX | CHARGEN_HAIR | CHARGEN_BEARD //CHARGEN_MARKINGS | CHARGEN_WINGS maybe when these actually matter I will uncomment 'em -V

	flags_flavor_love = FLAG_FLAVOR_COOKED | FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_MEAT | FLAG_FLAVOR_FISH | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_JUNK | FLAG_FLAVOR_FAT | FLAG_FLAVOR_DAIRY
	flags_flavor_hate = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_NECRO | FLAG_FLAVOR_MEDICINE


	default_color_eye = "#FFFFFF"
	default_color_skin = "#F7D896"
	default_color_hair = "#FFFFFF"

	default_icon_hair = 'icons/mob/living/advanced/hair/moth_hair_face.dmi' //doing this was cursed but I wanted things to be consistent
	default_icon_state_hair = "none"

	default_icon_hair_face = 'icons/mob/living/advanced/hair/moth_hair_head.dmi' //second verse same as the first
	default_icon_state_hair_face = "none"

	default_hairstyle_chargen_male = 1
	default_hairstyle_chargen_female = 1


	accent = list(
		"o" = "ø",
		"ae" = "æ",
		"a" = "å"
	)

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/moth,
		BODY_HEAD = /obj/item/organ/head/moth,
		BODY_GROIN = /obj/item/organ/groin/moth,
		BODY_LEG_RIGHT = /obj/item/organ/leg/moth,
		BODY_LEG_LEFT = /obj/item/organ/leg/moth/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/moth,
		BODY_FOOT_LEFT = /obj/item/organ/foot/moth/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/moth,
		BODY_ARM_LEFT = /obj/item/organ/arm/moth/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/moth,
		BODY_HAND_LEFT = /obj/item/organ/hand/moth/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/moth,
		BODY_EYE_LEFT = /obj/item/organ/eye/moth/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/moth,
		BODY_EAR_LEFT = /obj/item/organ/ear/moth/left,
		BODY_WINGS = /obj/item/organ/wings/moth,
		BODY_ANTENNAE = /obj/item/organ/antennae/moth,

		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_HEART = /obj/item/organ/internal/heart,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys

	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/moth/female,
		BODY_HEAD = /obj/item/organ/head/moth/female,
		BODY_GROIN = /obj/item/organ/groin/moth/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/moth,
		BODY_LEG_LEFT = /obj/item/organ/leg/moth/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/moth,
		BODY_FOOT_LEFT = /obj/item/organ/foot/moth/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/moth,
		BODY_ARM_LEFT = /obj/item/organ/arm/moth/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/moth,
		BODY_HAND_LEFT = /obj/item/organ/hand/moth/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/moth,
		BODY_EYE_LEFT = /obj/item/organ/eye/moth/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/moth,
		BODY_EAR_LEFT = /obj/item/organ/ear/moth/left,
		BODY_WINGS = /obj/item/organ/wings/moth,
		BODY_ANTENNAE = /obj/item/organ/antennae/moth,

		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_HEART = /obj/item/organ/internal/heart,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

	inherent_traits = list(
		/trait/flamability/fire_retardant,
		/trait/intoxication_regen/light_drinker

	)
