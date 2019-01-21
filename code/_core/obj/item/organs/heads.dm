/obj/item/organ/head
	name = "head"
	id = BODY_HEAD
	desc = "An organ."
	icon_state = BODY_HEAD_MALE
	worn_layer = LAYER_MOB_HEAD
	break_threshold = 25
	health_max = 50
	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)

	attach_flag = BODY_TORSO

/obj/item/organ/head/female
	desc = "A head. Female variant"
	icon_state = BODY_HEAD_FEMALE

//Reptile
/obj/item/organ/head/reptile
	name = "reptile head"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."

	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)
	flags_organ = FLAG_ORGAN_BEAST_HEAD

/obj/item/organ/head/reptile/female
	icon_state = BODY_HEAD_FEMALE

//Reptile Advanced
/obj/item/organ/head/reptile_advanced
	name = "advanced reptile head"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	desc = "An organ."

	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)
	flags_organ = FLAG_ORGAN_BEAST_HEAD

/obj/item/organ/head/reptile_advanced/female
	icon_state = BODY_HEAD_FEMALE


//Diona
/obj/item/organ/head/diona
	name = "diona head"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	icon_state = BODY_HEAD
	desc = "An organ."

	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	enable_color = TRUE
	enable_glow = TRUE