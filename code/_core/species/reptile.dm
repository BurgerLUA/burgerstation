/datum/species/reptile/
	name = "Reptile"
	desc = "Fucking furries"
	spawning_organs_male = list(
		BODY_HEAD = /obj/item/organ/head/reptile,
		BODY_TORSO = /obj/item/organ/torso/reptile,
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
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left
	)

	spawning_organs_female = list(
		BODY_HEAD = /obj/item/organ/head/reptile/female,
		BODY_TORSO = /obj/item/organ/torso/reptile/female,
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
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left
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