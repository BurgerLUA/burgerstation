/obj/item/organ/head
	name = "head"
	id = BODY_HEAD
	desc = "An organ."
	icon_state = BODY_HEAD_MALE
	worn_layer = LAYER_MOB_HEAD
	health_max = 50
	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)

/obj/item/organ/head/female
	desc = "A head. Female variant"
	icon_state = BODY_HEAD_FEMALE


/obj/item/organ/head/reptile
	name = "reptile head"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."
	health_max = 75
	inventories = list(
		/obj/inventory/organs/head,
		/obj/inventory/organs/face,
		/obj/inventory/organs/glasses
	)
	flags_organ = FLAG_ORGAN_BEAST_HEAD

/obj/item/organ/head/reptile/female
	icon_state = BODY_HEAD_FEMALE