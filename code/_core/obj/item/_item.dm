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

/obj/item/New(var/desired_loc)
	src.loc = desired_loc

	for(var/i=1, i <= length(inventories), i++)
		var/obj/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)

	. = ..()

/obj/item/radio
	name = "radio"
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "radio"

	var/sound_to_play = 'sounds/music/clown.ogg'

/obj/item/radio/attack_self(var/atom/caller)
	//play_sound(sound_to_play,all_mobs,vector(caller.x,caller.y,caller.z))

obj/item/proc/update_owner(desired_owner)
	for(var/v in inventories)
		var/obj/inventory/I = v
		I.update_owner(desired_owner)

/obj/item/proc/can_be_worn()
	return FALSE

/obj/item/examine(var/atom/examiner)
	..()

	if(damage_type)

		var/list/base_damage_list = list()
		var/list/attribute_damage_list = list()
		var/list/skill_damage_list = list()

		for(var/k in damage_type.base_attack_damage)
			var/v = damage_type.base_attack_damage[k]
			if(v)
				base_damage_list += "[capitalize(k)]: [v]"

		for(var/k in damage_type.attribute_stats)
			var/v = damage_type.attribute_stats[k]
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


		for(var/k in damage_type.skill_stats)
			var/v = damage_type.skill_stats[k]
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
