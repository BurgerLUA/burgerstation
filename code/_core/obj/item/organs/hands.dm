/obj/item/organ/hand
	name = "right hand"
	id = BODY_HAND_RIGHT
	desc = "A right hand."
	icon_state = BODY_HAND_RIGHT
	worn_layer = LAYER_MOB_HANDS
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held,
		/obj/hud/inventory/organs/ring/nw,
		/obj/hud/inventory/organs/ring/sw
	)

	damage_type = null

	attach_flag = BODY_ARM_RIGHT

	enable_wounds = TRUE

	hud_id = "body_hand_right"

	can_be_targeted = TRUE

	target_bounds_x_min = 8
	target_bounds_x_max = 11

	target_bounds_y_min = 11
	target_bounds_y_max = 15

	base_miss_chance = 20

	health_base = 25

	damage_coefficient = 0.5

	has_pain = TRUE

	block_defense = list(
		ATTACK_TYPE_UNARMED = 1,
		ATTACK_TYPE_MELEE = 0.25,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	gib_icon_state = "gibarm"

	has_life = TRUE

/obj/item/organ/hand/on_pain()

	. = ..()

	var/turf/T = get_turf(src)
	var/did_drop = FALSE
	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		if(I.worn)
			continue
		if(length(I.drop_objects(T)))
			did_drop = TRUE
	if(did_drop && is_advanced(loc))
		var/mob/living/advanced/A = loc
		A.visible_message(span("warning","\The [A.name]'s [src.name] recoils from their injury!"),span("danger","You cry in pain as your [src.name] recoils from your injury!"))

	return . || did_drop

/obj/item/organ/hand/get_damage_type(var/atom/attacker,var/atom/victim)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.attack_flags & CONTROL_MOD_KICK)
			return /damagetype/unarmed/foot
		switch(L.intent)
			if(INTENT_HARM)
				var/trait/unarmed/U = L.get_trait_by_category(/trait/unarmed/)
				if(U) return U.damage_type
				. = /damagetype/unarmed/fists/
			if(INTENT_DISARM)
				. = /damagetype/unarmed/fists/disarm
			if(INTENT_HELP)
				. = /damagetype/unarmed/fists/help
			if(INTENT_GRAB)
				. = /damagetype/unarmed/fists/grab

	if(!.)
		. = ..()

	if(. == /damagetype/unarmed/fists/ && damage_type) //Overridden
		return damage_type

/obj/item/organ/hand/left
	name = "left hand"
	id = BODY_HAND_LEFT
	desc = "A left hand."
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

//Reptile Advanced
/obj/item/organ/hand/reptile
	name = "right reptile hand"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'

	defense_rating = REPTILE_ARMOR

/obj/item/organ/hand/reptile/left
	name = "left reptile hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

//Reptile Advanced
/obj/item/organ/hand/reptile_advanced
	name = "right advanced reptile hand"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

	defense_rating = REPTILE_ARMOR

/obj/item/organ/hand/reptile_advanced/left
	name = "left advanced reptile hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14


//Diona
/obj/item/organ/hand/diona
	name = "right diona hand"
	icon = 'icons/mob/living/advanced/species/diona.dmi'

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR


/obj/item/organ/hand/diona/left
	name = "left diona hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14


//Cyborg
/obj/item/organ/hand/cyborg
	name = "right cyborg hand"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic

/obj/item/organ/hand/cyborg/left
	name = "left cyborg hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14


//Beefman
/obj/item/organ/hand/beefman
	name = "right beef hand"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'
	damage_type = /damagetype/unarmed/beef/

	defense_rating = MEATMEN_ARMOR

/obj/item/organ/hand/beefman/get_damage_type(var/atom/attacker,var/atom/victim)
	return damage_type

/obj/item/organ/hand/beefman/left
	name = "left beef hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

//Stand
/obj/item/organ/hand/stand
	name = "right fast hand"

/obj/item/organ/hand/stand/get_damage_type(var/atom/attacker,var/atom/victim)
	return /damagetype/unarmed/fists/stand

/obj/item/organ/hand/stand/left
	name = "left fast hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14


//Skeleton
/obj/item/organ/hand/skeleton
	name = "right skeleton hand"
	icon = 'icons/mob/living/advanced/species/skeleton.dmi'

	defense_rating = SKELETON_ARMOR

	projectile_dodge_chance = 10

	can_gib = FALSE

/obj/item/organ/hand/skeleton/left
	name = "left skeleton hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14




//Skeleton
/obj/item/organ/hand/monkey
	name = "right monkey hand"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'

/obj/item/organ/hand/monkey/left
	name = "left monkey hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14




//Zombie
/obj/item/organ/hand/zombie
	name = "right zombie hand"

/obj/item/organ/hand/zombie/get_damage_type(var/atom/attacker,var/atom/victim)

	var/mob/living/advanced/A = attacker
	var/obj/hud/inventory/I = A.inventories_by_id[src.id]

	if(A.horizontal) //Always grab when horizontal.
		if(I && !I.grabbed_object)
			return /damagetype/unarmed/fists/grab

	var/list/possible_damage_types = list(
		/damagetype/unarmed/claw = 6
	)

	if(!I.grabbed_object)
		possible_damage_types[/damagetype/unarmed/fists/disarm] = 1
		possible_damage_types[/damagetype/unarmed/fists/grab] = 2
	else if(I.grab_level >= 2)
		possible_damage_types[/damagetype/unarmed/bite] = 100
	else
		possible_damage_types[/damagetype/unarmed/fists/grab] = 4

	return pickweight(possible_damage_types)

/obj/item/organ/hand/zombie/left
	name = "left zombie hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14


//Goblin
/obj/item/organ/hand/goblin
	name = "right goblin hand"
	icon = 'icons/mob/living/advanced/species/goblin.dmi'

	defense_rating = GOBLIN_ARMOR

/obj/item/organ/hand/goblin/left
	name = "left goblin hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

//Moth
/obj/item/organ/hand/moth
	name = "right moth hand"
	icon = 'icons/mob/living/advanced/species/moth.dmi'

/obj/item/organ/hand/moth/left
	name = "left moth hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14




//Moth
/obj/item/organ/hand/golem
	name = "right golem hand"
	icon = 'icons/mob/living/advanced/species/golem.dmi'

/obj/item/organ/hand/golem/left
	name = "left golem hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14



//Abductor
/obj/item/organ/hand/abductor
	name = "right abductor hand"
	icon = 'icons/mob/living/advanced/species/abductor.dmi'

/obj/item/organ/hand/abductor/left
	name = "left abductor hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held,
		/obj/hud/inventory/organs/ring/ne,
		/obj/hud/inventory/organs/ring/se
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14