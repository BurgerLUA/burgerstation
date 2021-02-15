/obj/item/weapon/melee/crystal/
	name = "conjuring crystals"
	icon = 'icons/obj/item/weapons/melee/swords/crystal.dmi'
	desc = "A cluster of crystals used in Crystal Guardian Conjuration."
	desc_extended = "A glimmering crystal that has been used in conjuration by the Crystal Guardians since their origin."
	var/shape = 0
	damage_type = /damagetype/melee/sword/crystal
	drop_sound = 'sound/items/drop/knife.ogg'
	size = SIZE_2
	weight = 1
	value = 3000


/obj/item/weapon/melee/crystal/Finalize()
	. = ..()
	update_inventory()
	return .

/obj/item/weapon/melee/crystal/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("shape")
	return .

/obj/item/weapon/melee/crystal/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("shape")
	return .

/obj/item/weapon/melee/crystal/click_self(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(shape < 2)
		shape++
		caller.to_chat(span("notice","You alter \the shape of \the [src.name]."))
	else
		shape = 0
		caller.to_chat(span("notice","You collapse \the [src.name] back into pure crystals."))
		update_sprite()

	if(shape == 0)
		name = "conjuring crystals"
		icon = 'icons/obj/item/weapons/melee/swords/crystal.dmi'
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
		icon = 'icons/obj/item/weapons/melee/swords/crystal1.dmi'
		desc = "A crystal longsword conjured from thin air."
		desc_extended = "A glimmering crystal longsword that has been conjured by the Crystal Guardians since their origin."
		damage_type = /damagetype/melee/sword/crystal/rapier
		size = SIZE_4
		weight = 5
		value = 3000
		update_sprite()
		return TRUE

	if(shape == 2)
		name = "crystal longsword"
		icon = 'icons/obj/item/weapons/melee/swords/crystal2.dmi'
		desc = "A crystal longsword conjured from thin air."
		desc_extended = "A glimmering crystal longsword that has been conjured by the Crystal Guardians since their origin."
		damage_type = /damagetype/melee/sword/crystal/longsword
		size = SIZE_5
		weight = 8
		value = 3000
		update_sprite()
		return TRUE


	else
		return TRUE

/obj/item/weapon/melee/crystal/rapier
	name = "crystal rapier"
	icon = 'icons/obj/item/weapons/melee/swords/crystal1.dmi'
	desc = "A crystal longsword conjured from thin air."
	desc_extended = "A glimmering crystal longsword that has been conjured by the Crystal Guardians since their origin."
	damage_type = /damagetype/melee/sword/crystal/rapier
	size = SIZE_4
	weight = 5
	value = 3000
	shape = 1

/obj/item/weapon/melee/crystal/longsword
	name = "crystal longsword"
	icon = 'icons/obj/item/weapons/melee/swords/crystal2.dmi'
	desc = "A crystal longsword conjured from thin air."
	desc_extended = "A glimmering crystal longsword that has been conjured by the Crystal Guardians since their origin."
	damage_type = /damagetype/melee/sword/crystal/longsword
	size = SIZE_5
	weight = 8
	value = 3000
	shape = 2

//		icon_state = "[initial(icon_state)]1"