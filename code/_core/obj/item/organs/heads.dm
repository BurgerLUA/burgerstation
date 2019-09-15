/obj/item/organ/head
	name = "head"
	id = BODY_HEAD
	desc = "An organ."
	icon_state = BODY_HEAD_MALE
	worn_layer = LAYER_MOB_HEAD
	break_threshold = 25
	health_max = 50
	inventories = list(
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/glasses,
		/obj/hud/inventory/organs/special
	)

	attach_flag = BODY_TORSO

	enable_wounds = TRUE

	hud_id = "body_head"

/obj/item/organ/head/initialize_blends()
	..()
	add_blend("blush", desired_color = "#00FF00", desired_blend = ICON_MULTIPLY, desired_icon = 'icons/mob/living/advanced/species/human.dmi', desired_icon_state = "none", desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)
	add_blend("lips", desired_color = "#00FF00", desired_blend = ICON_MULTIPLY, desired_icon = 'icons/mob/living/advanced/species/human.dmi', desired_icon_state = "none", desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)

/obj/item/organ/head/female
	desc = "A head. Female variant"
	icon_state = BODY_HEAD_FEMALE

//Reptile
/obj/item/organ/head/reptile
	name = "reptile head"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."

	inventories = list(
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/glasses
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
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/glasses
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
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/glasses
	)
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	enable_glow = TRUE
	enable_detail = TRUE


//cyborg
/obj/item/organ/head/cyborg
	name = "cyborg head"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	desc = "An organ."

	inventories = list(
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/glasses
	)