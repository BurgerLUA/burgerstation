/obj/item/organ/ear
	name = "right ear"
	id = BODY_EAR_RIGHT
	desc = "A right ear."
	icon_state = BODY_EAR_RIGHT
	worn_layer = LAYER_MOB_EAR
	break_threshold = 5
	health_max = 10

	attach_flag = BODY_HEAD

	inventories = list(
		/obj/inventory/organs/right_ear
	)

	enable_wounds = TRUE

/obj/item/organ/ear/left
	name = "left ear"
	id = BODY_EAR_LEFT
	desc = "A left ear."
	icon_state = BODY_EAR_LEFT

	inventories = list(
		/obj/inventory/organs/left_ear
	)

//Reptile
/obj/item/organ/ear/reptile
	name = "right reptile earhole"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	inventories = list()
	inventories = list(
		/obj/inventory/organs/right_ear
	)

/obj/item/organ/ear/reptile/left
	name = "left reptile earhole"
	id = BODY_EAR_LEFT
	icon_state = BODY_EAR_LEFT

	inventories = list(
		/obj/inventory/organs/left_ear
	)


//Reptile Advanced
/obj/item/organ/ear/reptile_advanced
	name = "right advanced reptile earhole"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	inventories = list()
	inventories = list(
		/obj/inventory/organs/right_ear
	)

/obj/item/organ/ear/reptile_advanced/left
	name = "left advanced reptile earhole"
	id = BODY_EAR_LEFT
	icon_state = BODY_EAR_LEFT

	inventories = list(
		/obj/inventory/organs/left_ear
	)


//Diona
/obj/item/organ/ear/diona
	name = "right diona earhole"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	inventories = list()
	inventories = list(
		/obj/inventory/organs/right_ear
	)

/obj/item/organ/ear/diona/left
	name = "left diona earhole"
	id = BODY_EAR_LEFT
	icon_state = BODY_EAR_LEFT

	inventories = list(
		/obj/inventory/organs/left_ear
	)


//Reptile Advanced
/obj/item/organ/ear/cyborg
	name = "right cyborg sensor"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	inventories = list()
	inventories = list(
		/obj/inventory/organs/right_ear
	)

/obj/item/organ/ear/cyborg/left
	name = "left cyborg sensor"
	id = BODY_EAR_LEFT
	icon_state = BODY_EAR_LEFT

	inventories = list(
		/obj/inventory/organs/left_ear
	)