/obj/item/organ/head
	name = "head"
	id = BODY_HEAD
	desc = "So no head?"
	icon_state = BODY_HEAD_MALE
	worn_layer = LAYER_MOB_HEAD
	inventories = list(
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/ear
	)

	attach_flag = BODY_TORSO

	enable_wounds = TRUE

	hud_id = "body_head"

	can_be_targeted = TRUE

	target_bounds_x_min = 12
	target_bounds_x_max = 20

	target_bounds_y_min = 23
	target_bounds_y_max = 29

	base_miss_chance = 20

	health_base = 50

	reagents = /reagent_container/limb

	damage_coefficient = 2

	gib_icon_state = "gibhead"

	has_life = TRUE

/obj/item/organ/head/get_damage_type(var/atom/attacker,var/atom/victim)
	if(attached_organ)
		return /damagetype/unarmed/bite/
	. = ..()

/obj/item/organ/head/female
	icon_state = BODY_HEAD_FEMALE

//Reptile
/obj/item/organ/head/reptile
	name = "reptile head"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	defense_rating = REPTILE_ARMOR

/obj/item/organ/head/reptile/female
	icon_state = BODY_HEAD_FEMALE

//Reptile Advanced
/obj/item/organ/head/reptile_advanced
	name = "advanced reptile head"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	defense_rating = REPTILE_ARMOR

/obj/item/organ/head/reptile_advanced/female
	icon_state = BODY_HEAD_FEMALE


//Diona
/obj/item/organ/head/diona
	name = "diona head"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	icon_state = BODY_HEAD
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR


//cyborg
/obj/item/organ/head/cyborg
	name = "cyborg head"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	desc = "An organ."

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic


//beef
/obj/item/organ/head/beefman
	name = "beef head"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'
	desc = "An organ."

	defense_rating = MEATMEN_ARMOR


//skeleton
/obj/item/organ/head/skeleton
	name = "skeleton head"
	icon = 'icons/mob/living/advanced/species/skeleton.dmi'
	desc = "An organ."

	defense_rating = SKELETON_ARMOR

	projectile_dodge_chance = 5

	can_gib = FALSE


//skeleton
/obj/item/organ/head/monkey
	name = "monkey head"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'
	desc = "An organ."

/obj/item/organ/head/monkey/female
	icon_state = BODY_HEAD_FEMALE


//skeleton
/obj/item/organ/head/goblin
	name = "goblin head"
	icon = 'icons/mob/living/advanced/species/goblin.dmi'
	desc = "An organ."

	defense_rating = GOBLIN_ARMOR

/obj/item/organ/head/goblin/female
	icon_state = BODY_HEAD_FEMALE


/obj/item/organ/head/moth
	name = "moth head"
	icon = 'icons/mob/living/advanced/species/moth.dmi'
	desc = "An organ."

/obj/item/organ/head/moth/female
	icon_state = BODY_HEAD_FEMALE

/obj/item/organ/head/golem
	name = "golem head"
	icon = 'icons/mob/living/advanced/species/golem.dmi'
	desc = "An organ."

/obj/item/organ/head/abductor
	name = "abductor head"
	icon = 'icons/mob/living/advanced/species/abductor.dmi'
	desc = "An organ."