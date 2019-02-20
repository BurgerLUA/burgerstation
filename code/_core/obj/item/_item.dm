/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/size = 1 //Size in.. uh...
	var/weight = 1 //Weight in kg

	var/list/obj/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"

	var/worn_layer = 0

	var/item_slot = SLOT_NONE

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/no_held_draw = FALSE

	var/slot_icons = FALSE //Set to true if the clothing is based on where it's slot is.

	var/ignore_other_slots = FALSE


	var/block_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	var/parry_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)


/obj/item/New(var/desired_loc)

	//force_move(desired_loc) //TODO: FIGURE THIS OUT

	for(var/i=1, i <= length(inventories), i++)
		var/obj/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)

	. = ..()

obj/item/proc/update_owner(desired_owner)
	for(var/v in inventories)
		var/obj/inventory/I = v
		I.update_owner(desired_owner)

/obj/item/proc/get_owner()
	if(is_inventory(src.loc))
		var/obj/inventory/I = src.loc
		return I.owner

	return null

/obj/item/update_icon()
	..()
	if(is_inventory(src.loc))
		var/obj/inventory/I = src.loc
		I.update_icon()

/obj/item/proc/can_be_worn()
	return FALSE

/obj/item/examine(var/atom/examiner)
	..()

	if(damage_type && all_damage_types[damage_type])

		var/damagetype/DT = all_damage_types[damage_type]

		var/list/base_damage_list = list()
		var/list/attribute_damage_list = list()
		var/list/skill_damage_list = list()

		for(var/k in DT.base_attack_damage)
			var/v = DT.base_attack_damage[k]
			if(v)
				base_damage_list += "[capitalize(k)]: [v]"

		for(var/k in DT.attribute_stats)
			var/v = DT.attribute_stats[k]
			switch(v)
				if(CLASS_S)
					v = "S"
				if(CLASS_A)
					v = "A"
				if(CLASS_B)
					v = "B"
				if(CLASS_C)
					v = "C"
				if(CLASS_D)
					v = "D"
				if(CLASS_E)
					v = "E"
				if(CLASS_F)
					v = "-"
			attribute_damage_list += "[capitalize(k)]: [v]"


		for(var/k in DT.skill_stats)
			var/v = DT.skill_stats[k]
			switch(v)
				if(CLASS_S)
					v = "S"
				if(CLASS_A)
					v = "A"
				if(CLASS_B)
					v = "B"
				if(CLASS_C)
					v = "C"
				if(CLASS_D)
					v = "D"
				if(CLASS_E)
					v = "E"
				if(CLASS_F)
					v = "-"
			skill_damage_list += "[capitalize(k)]: [v]"


		examiner.to_chat(span("notice"," Base Damage:"))
		examiner.to_chat(span("notice","  [english_list(base_damage_list, and_text = ", ")]"))

		examiner.to_chat(span("notice"," Attribute Damage:"))
		examiner.to_chat(span("notice","  [english_list(attribute_damage_list, and_text = ", ")]"))

		examiner.to_chat(span("notice"," Attribute Damage:"))
		examiner.to_chat(span("notice","  [english_list(skill_damage_list, and_text = ", ")]"))

obj/item/proc/do_automatic(caller,object,location,params)
	return TRUE

/obj/proc/on_pickup(var/obj/inventory/I)
	return

/obj/proc/on_drop(var/obj/inventory/I)
	return