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

	damage_type = /damagetype/unarmed/fists/

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

	if(is_living(loc))
		var/mob/living/L = loc
		if(!L.boss)
			var/turf/T = get_turf(src)
			var/did_drop = FALSE
			for(var/k in inventories)
				var/obj/hud/inventory/I = k
				if(I.worn)
					continue
				if(length(I.drop_objects(T)))
					did_drop = TRUE
			if(did_drop)
				L.visible_message(span("warning","\The [L.name]'s [src.name] recoils from their injury!"),span("danger","You cry in pain as your [src.name] recoils from your injury!"))
				return TRUE

	return .

/obj/item/organ/hand/get_damage_type(var/atom/attacker,var/atom/victim)

	if(is_living(attacker))
		var/mob/living/L = attacker
		switch(L.intent)
			if(INTENT_HARM)
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

	armor = /armor/reptile

	damage_type = /damagetype/unarmed/claw

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

	armor = /armor/reptile

	damage_type = /damagetype/unarmed/claw

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

	armor = /armor/diona


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

	armor = /armor/cyborg
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

//Cyborg 2
/obj/item/organ/hand/gopro
	name = "right advanced cyborg hand"
	icon = 'icons/mob/living/advanced/species/gopro.dmi'

	armor = /armor/cyborg
	health = /health/obj/item/organ/synthetic

/obj/item/organ/hand/gopro/left
	name = "left advanced cyborg hand"
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

	armor = /armor/beefman

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

	armor = /armor/skeleton

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

	if(!is_living(victim))
		return /damagetype/unarmed/claw

	var/mob/living/victim_as_living = victim
	var/mob/living/advanced/A = attacker

	var/list/possible_damage_types
	if(victim_as_living.grabbing_hand)
		if(victim_as_living.grabbing_hand.grab_level >= 2)
			return /damagetype/unarmed/bite //Start biting.
		possible_damage_types = list()
		possible_damage_types[/damagetype/unarmed/claw] = 50
		possible_damage_types[/damagetype/unarmed/fists/grab] = 25 //Reinforce grab.
		possible_damage_types[/damagetype/unarmed/bite] = 10
	else
		if(A.horizontal || victim_as_living.horizontal) //Always grab when self or target is horizontal, and not grabbed
			return /damagetype/unarmed/fists/grab
		possible_damage_types = list()
		possible_damage_types[/damagetype/unarmed/claw] = 100
		possible_damage_types[/damagetype/unarmed/fists/disarm] = 10
		possible_damage_types[/damagetype/unarmed/fists/grab] = 40

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

	armor = /armor/goblin

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