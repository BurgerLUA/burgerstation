/datum/species/diona/
	name = "Reptile"
	desc = "Fucking tree people."

	eye_color_default = "#88FF88"
	color_skin_default = "#FFFF00"
	color_hair_default = "#008800"

	hair_style_default = "diona"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/diona,
		BODY_HEAD = /obj/item/organ/head/diona,
		BODY_GROIN = /obj/item/organ/groin/diona,
		BODY_LEG_RIGHT = /obj/item/organ/leg/diona,
		BODY_LEG_LEFT = /obj/item/organ/leg/diona/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/diona,
		BODY_FOOT_LEFT = /obj/item/organ/foot/diona/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/diona,
		BODY_ARM_LEFT = /obj/item/organ/arm/diona/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/diona,
		BODY_HAND_LEFT = /obj/item/organ/hand/diona/left
	)

	spawning_buttons = list(
		/obj/button/equip,
		/obj/button/equip/left
	)