/datum/species/human/
	name = "Human"
	desc = "Vanilla as fuck."

	eye_color_default = "#000000"
	skin_color_default = "#e0b19d"
	hair_color_default = "#000000"

	hair_style_default = "greytide"

	spawning_organs_male = list(
		BODY_HEAD = /obj/item/organ/head,
		BODY_TORSO = /obj/item/organ/torso,
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
		BODY_HAIR_HEAD = /obj/item/organ/hair
	)

	spawning_organs_female = list(
		BODY_HEAD = /obj/item/organ/head/female,
		BODY_TORSO = /obj/item/organ/torso/female,
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
		BODY_HAIR_HEAD = /obj/item/organ/hair
	)

	spawning_buttons = list(
		/obj/button/equip,
		/obj/button/equip/left
	)

	attribute_defaults = list(
		ATTRIBUTE_STRENGTH = 15,
		ATTRIBUTE_VITALITY = 15,
		ATTRIBUTE_FORTITUDE = 15,

		ATTRIBUTE_INTELLIGENCE = 15,
		ATTRIBUTE_RESOLVE = 15,
		ATTRIBUTE_WILLPOWER = 15,

		ATTRIBUTE_AGILITY = 15,
		ATTRIBUTE_ENDURANCE = 15,
		ATTRIBUTE_LUCK = 50
	)

	skill_defaults = list(
		SKILL_UNARMED = 5,
		SKILL_MELEE = 5,
		SKILL_RANGED = 5,

		SKILL_BLOCK = 5,
		SKILL_DODGE = 5,
		SKILL_PARRY = 5,

		SKILL_MAGIC_OFFENSIVE = 0,
		SKILL_MAGIC_DEFENSIVE = 0,
		SKILL_MAGIC_SUPPORT = 0,

		SKILL_STEALTH = 5,
		SKILL_LOCKPICKING = 5,
		SKILL_THEFT = 0,

		SKILL_ALCHEMY = 5,
		SKILL_COOKING = 5,
		SKILL_ENCHANTING = 0
	)