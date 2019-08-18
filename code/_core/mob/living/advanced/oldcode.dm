/*
/mob/living/advanced/proc/update_talking_icons()
	if(is_typing || talk_type)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = 'icons/mob/living/advanced/overlays/talk.dmi'
		if(is_typing)
			spawned_overlay.icon_state = "talking"
		else
			spawned_overlay.icon_state = talk_type

		overlays += spawned_overlay

/mob/living/advanced/proc/update_faction_icons()
	for(var/v in factions)
		var/faction/F = all_factions[v]
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = F.icon
		spawned_overlay.icon_state = F.icon_state
		overlays += spawned_overlay

/mob/living/advanced/proc/update_organ_icons()
	for(var/obj/item/organ/O in organs)
		O.update_icon()
		if(is_tail(O))
			var/obj/overlay/behind_overlay = new /obj/overlay
			behind_overlay.layer = LAYER_MOB_TAIL_BEHIND
			behind_overlay.initial_icon = O.icon
			behind_overlay.initial_icon_state = "tail_behind"
			behind_overlay.color = O.color
			behind_overlay.additional_blends = O.additional_blends
			behind_overlay.update_icon()

			var/obj/overlay/front_overlay = new /obj/overlay
			front_overlay.layer = LAYER_MOB_TAIL_FRONT
			front_overlay.initial_icon = O.icon
			front_overlay.initial_icon_state = "tail_front"
			front_overlay.color = O.color
			front_overlay.additional_blends = O.additional_blends
			front_overlay.update_icon()

			overlays += front_overlay
			overlays += behind_overlay
			continue

		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.initial_icon = O.icon
		spawned_overlay.initial_icon_state = O.icon_state
		spawned_overlay.color = O.color
		spawned_overlay.additional_blends = O.additional_blends
		spawned_overlay.update_icon()
		overlays += spawned_overlay

/mob/living/advanced/proc/update_inventory_icons()
	for(var/obj/hud/inventory/I in inventory)
		if(!I.should_draw)
			continue
		for(var/obj/item/C in I.worn_objects)
			if(C.loc != I)
				continue

			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = C.worn_layer
			spawned_overlay.icon = C.icon
			spawned_overlay.initial_icon = C.icon
			spawned_overlay.color = C.color
			spawned_overlay.additional_blends = C.additional_blends

			if(C.slot_icons)
				spawned_overlay.icon_state = "[C.icon_state_worn]_[I.id]"
			else
				spawned_overlay.icon_state = C.icon_state_worn

			spawned_overlay.initial_icon_state = spawned_overlay.icon_state
			spawned_overlay.update_icon()

			overlays += spawned_overlay

		for(var/obj/item/I2 in I.held_objects)
			if(I2.loc != I)
				continue
			if(I2.no_held_draw)
				continue

			//I2.update_icon()
			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = LAYER_MOB_HELD
			spawned_overlay.icon = I2.icon
			spawned_overlay.initial_icon = I2.icon
			spawned_overlay.color = I2.color
			spawned_overlay.additional_blends = I2.additional_blends

			if(I.item_slot == SLOT_HAND_LEFT)
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_left
			else
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_right

			spawned_overlay.initial_icon_state = spawned_overlay.icon_state
			spawned_overlay.update_icon()

			overlays += spawned_overlay
*/