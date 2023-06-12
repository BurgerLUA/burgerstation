/obj/item/weapon/melee/crystal
	name = "conjuring crystals"
	icon = 'icons/obj/item/weapons/melee/swords/crystal.dmi'
	icon_state = "inventory"
	desc = "A cluster of crystals used in Crystal Guardian Conjuration."
	desc_extended = "A glimmering crystal that has been used in conjuration by the Crystal Guardians since their origin."
	var/shape = 0
	damage_type = /damagetype/melee/sword/crystal
	drop_sound = 'sound/items/drop/knife.ogg'
	size = SIZE_2
	weight = 1
	value = 3000
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	rarity = RARITY_MYTHICAL

/obj/item/weapon/melee/crystal/Finalize()
	. = ..()
	update_sprite()

/obj/item/weapon/melee/crystal/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("shape")

/obj/item/weapon/melee/crystal/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("shape")

/obj/item/weapon/melee/crystal/click_self(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(shape < 2)
		shape++
		caller.to_chat(span("notice","You alter \the shape of \the [src.name]."))
	else
		shape = 0
		caller.to_chat(span("notice","You collapse \the [src.name] back into pure crystals."))

	if(shape == 0)
		name = "conjuring crystals"
		desc = "A cluster of crystals used in Crystal Guardian Conjuration."
		desc_extended = "A glimmering crystal that has been used in conjuration by the Crystal Guardians since their origin."
		damage_type = /damagetype/melee/sword/crystal
		size = SIZE_2
		weight = 1
		value = 3000
		update_sprite()
		return TRUE

	if(shape == 1)
		name = "crystal rapier"
		desc = "A crystal rapier conjured from pure crystal essence."
		desc_extended = "A glimmering crystal rapier of new design, conjured by the Crystal Guardians."
		damage_type = /damagetype/melee/sword/crystal/rapier
		size = SIZE_4
		weight = 5
		value = 3000
		update_sprite()
		return TRUE

	if(shape == 2)
		name = "crystal longsword"
		desc = "A crystal longsword conjured from pure crystal essence."
		desc_extended = "A glimmering crystal longsword that has been conjured by the Crystal Guardians since their origin."
		damage_type = /damagetype/melee/sword/crystal/longsword
		size = SIZE_5
		weight = 8
		value = 3000
		update_sprite()
		return TRUE

	return TRUE

/obj/item/weapon/melee/crystal/update_icon()

	if(shape == 0)
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)

	if(shape == 1)
		icon_state = "[initial(icon_state)]_r"
		icon_state_held_left = "[initial(icon_state_held_left)]_r"
		icon_state_held_right = "[initial(icon_state_held_right)]_r"

	if(shape == 2)
		icon_state = "[initial(icon_state)]_ls"
		icon_state_held_left = "[initial(icon_state_held_left)]_ls"
		icon_state_held_right = "[initial(icon_state_held_right)]_ls"
	update_held_icon()
	return ..()

//These are for AI so that the weapon starts off deployed in a different state.

//DO NOT LET THESE BE PICKED UP//

/obj/item/weapon/melee/crystal/rapier
	name = "crystal rapier"
	damage_type = /damagetype/melee/sword/crystal/rapier
	size = SIZE_4
	weight = 5
	shape = 1
	value_burgerbux = 1

/obj/item/weapon/melee/crystal/longsword
	name = "crystal longsword"
	damage_type = /damagetype/melee/sword/crystal/longsword
	size = SIZE_5
	weight = 8
	shape = 2
	value_burgerbux = 1
