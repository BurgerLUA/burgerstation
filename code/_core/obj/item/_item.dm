/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/size = 1 //Size in.. uh...
	var/weight = 1 //Weight in kg

	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/container_max_size = 0 //I this item has a container, how much should it be able to hold in each slot?
	var/container_max_weight = 0 //I this item has a container, how much should it be able to hold in each slot?

	var/list/obj/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"

	var/worn_layer = 0

	var/item_slot = SLOT_NONE

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/no_held_draw = FALSE

	var/no_initial_blend = FALSE //Should we draw the initial icon when worn/held?

	var/slot_icons = FALSE //Set to true if the clothing is based on where it's slot is.

	var/ignore_other_slots = FALSE

	var/dynamic_inventory_count = 0

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

	var/soul_bound = FALSE

	var/has_quick_function = FALSE


	var/crafting_id = null

/obj/item/proc/quick(var/mob/living/advanced/caller,var/atom/object,location,control,params)
	return FALSE

/obj/item/can_be_attacked(var/atom/attacker)
	return FALSE

/obj/item/click_self(caller,location,control,params)

	if(!length(inventories))
		return FALSE

	var/mob/living/advanced/A = caller

	for(var/obj/inventory/I in A.inventory)
		if(I in inventories)
			continue
		if(!(I.flags & FLAGS_HUD_INVENTORY))
			continue
		I.alpha = 0
		I.mouse_opacity = 0

	var/opening = FALSE

	for(var/i=1,i<=length(inventories),i++)
		var/obj/inventory/I = inventories[i]
		I.update_owner(A)
		I.screen_loc = "CENTER+[i]-[(length(inventories)+1)/2],BOTTOM+1.25"
		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		for(var/obj/button/B in A.buttons)
			if(B.type != /obj/button/close_inventory) //TODO: Fix this shitcode
				continue
			B.alpha = 0
			B.mouse_opacity = 0

	for(var/obj/button/B in A.buttons)
		if(B.type != /obj/button/close_inventory) //TODO: Fix this shitcode
			continue

		B.screen_loc = "CENTER+[(length(inventories)+1)/2],BOTTOM+1.25"

		if(opening)
			animate(B,alpha=255,time=4)
			B.mouse_opacity = 2
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0

		break

	return TRUE

/obj/item/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(!is_container)
		return ..()

	if(is_inventory(object) && is_advanced(caller) && length(inventories) && get_dist(caller,src) <= 1)
		return click_self(caller,location,control,params)

	if(is_item(object))
		add_to_inventory(caller,object,TRUE)

	return 	..()

/obj/item/proc/add_to_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE)

	if(!length(inventories))
		return FALSE

	var/added = FALSE

	if(object != src)
		for(var/obj/inventory/I in inventories)
			if(I.add_object(object,FALSE))
				added = TRUE
				break

	if(enable_messages && caller)
		if(added)
			caller.to_chat(span("notice","You stuff \the [object] in your [src]."))
		else
			caller.to_chat(span("warning","You don't have enough inventory space to hold this!"))

	return added

/obj/item/New(var/desired_loc)

	//force_move(desired_loc) //TODO: FIGURE THIS OUT

	for(var/i=1, i <= length(inventories), i++)
		var/obj/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)

		if(container_max_size)
			inventories[i].max_size = container_max_size
		if(container_max_weight)
			inventories[i].max_weight = container_max_weight

	for(var/i=1, i <= dynamic_inventory_count, i++)
		var/obj/inventory/dynamic/D = new(src)
		D.id = "dynamic_[i]"
		if(container_max_size)
			D.max_size = container_max_size
		if(container_max_weight)
			D.max_weight = container_max_weight
		inventories += D

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

/obj/item/proc/get_damage_type()
	return damage_type

/obj/item/proc/get_damage_type_text(var/mob/living/advanced/A)

	var/returning_text = ""

	var/damage_type_to_use = get_damage_type()

	if(damage_type_to_use && all_damage_types[damage_type_to_use])

		var/damagetype/DT = all_damage_types[damage_type_to_use]

		var/list/base_damage_list = list()
		var/list/attribute_damage_list = list()
		var/list/skill_damage_list = list()

		for(var/k in DT.base_attack_damage)
			var/v = DT.base_attack_damage[k]
			if(v)
				base_damage_list += "[v] [k]"

		for(var/k in DT.attribute_stats)
			var/v = DT.attribute_stats[k]
			var/experience/E = A.attributes[k]
			var/grade
			switch(v)
				if(CLASS_S)
					grade = "S"
				if(CLASS_A)
					grade = "A"
				if(CLASS_B)
					grade = "B"
				if(CLASS_C)
					grade = "C"
				if(CLASS_D)
					grade = "D"
				if(CLASS_E)
					grade = "E"

			if(grade)
				attribute_damage_list += "[capitalize(k)]: [grade] ([floor(E.get_current_level()*v)] [DT.attribute_damage[k]])"

		for(var/k in DT.skill_stats)
			var/v = DT.skill_stats[k]
			var/experience/E = A.skills[k]
			var/grade
			switch(v)
				if(CLASS_S)
					grade = "S"
				if(CLASS_A)
					grade = "A"
				if(CLASS_B)
					grade = "B"
				if(CLASS_C)
					grade = "C"
				if(CLASS_D)
					grade = "D"
				if(CLASS_E)
					grade = "E"

			if(grade)
				skill_damage_list += "[capitalize(k)]: [grade] ([floor(E.get_current_level()*v)] [DT.skill_damage[k]])"

		var/combat_rating = DT.get_rating()

		var/combat_rating_text = ""
		switch(combat_rating)
			if(0 to 5)
				combat_rating_text = "E"
			if(5 to 10)
				combat_rating_text = "D"
			if(10 to 15)
				combat_rating_text = "C"
			if(15 to 20)
				combat_rating_text = "B"
			if(20 to 25)
				combat_rating_text = "A"
			if(25 to INFINITY)
				combat_rating_text = "S"


		returning_text += div("notice bold","Combat Rating:") + div("notice","[combat_rating_text] ([combat_rating])")

		if(length(base_damage_list))
			returning_text += div("notice bold","Base Damage:") + div("notice","[english_list(base_damage_list, and_text = ", ")]")

		if(length(attribute_damage_list))
			returning_text += div("notice bold","Attribute Damage:") + div("notice","[english_list(attribute_damage_list, and_text = ", ")]")

		if(length(skill_damage_list))
			returning_text += div("notice bold","Skill Damage:") + div("notice","[english_list(skill_damage_list, and_text = ", ")]")

	return returning_text



/obj/item/get_examine_text(var/mob/examiner)

	if(!is_advanced(examiner))
		return ..()

	. = ..()

	var/mob/living/advanced/A = examiner

	return . + get_damage_type_text(A)

obj/item/proc/do_automatic(caller,object,location,params)
	return TRUE

/obj/item/proc/on_pickup(var/atom/old_location,var/obj/inventory/new_location) //When the item is picked up.

	if(is_container)
		for(var/obj/inventory/I in inventories)
			I.update_owner(new_location.owner)

	return

/obj/item/proc/on_drop(var/obj/inventory/old_inventory,var/atom/new_loc)
	return

/obj/item/proc/inventory_to_list()

	var/list/returning_list = list()

	for(var/obj/inventory/I in inventories)
		if(length(I.held_objects) && I.held_objects[1])
			returning_list += I.held_objects[1]

	return returning_list


/obj/item/proc/can_be_held(var/mob/living/advanced/owner,var/obj/inventory/I)
	return TRUE

/obj/item/proc/can_be_worn(var/mob/living/advanced/owner,var/obj/inventory/I)
	return FALSE