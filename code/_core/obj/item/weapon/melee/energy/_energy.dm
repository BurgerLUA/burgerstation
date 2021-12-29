/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	damage_type = /damagetype/melee/sword/energy
	var/damage_type_on = /damagetype/melee/sword/energy/on

/obj/item/weapon/melee/energy/can_block()
	return enabled

/obj/item/weapon/melee/energy/can_parry()
	return enabled

/obj/item/weapon/melee/energy/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(enabled) . += span("notice","It is active.")

/obj/item/weapon/melee/energy/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(3)
	enabled = !enabled
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/update_icon()

	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		if(wielded)
			icon_state_held_left = "[initial(icon_state_held_left)]_wielded_on"
			icon_state_held_right = "[initial(icon_state_held_right)]_wielded_on"
		else
			icon_state_held_left = "[initial(icon_state_held_left)]_on"
			icon_state_held_right = "[initial(icon_state_held_right)]_on"
		dan_icon_state = "[initial(dan_icon_state)]_on"
		dan_icon_state_wielded = "[initial(dan_icon_state_wielded)]_on"
		dan_icon_state_back = "[initial(dan_icon_state_back)]_on"
		damage_type = damage_type_on
	else
		icon_state = initial(icon_state)
		if(wielded)
			icon_state_held_left = "[initial(icon_state_held_left)]_wielded"
			icon_state_held_right = "[initial(icon_state_held_right)]_wielded"
		else
			icon_state_held_left = initial(icon_state_held_left)
			icon_state_held_right = initial(icon_state_held_right)
		dan_icon_state = initial(dan_icon_state)
		dan_icon_state_wielded = initial(dan_icon_state_wielded)
		dan_icon_state_back = initial(dan_icon_state_back)
		damage_type = initial(damage_type)

	update_held_icon()

	return ..()


/obj/item/weapon/melee/energy/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_item(object) && length(polymorphs))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT

			var/choice = input("What do you want to change the color of \the [src.name]?","Color Selection") as null|anything in polymorphs
			if(!choice)
				caller.to_chat(span("notice","You decide not to change \the [src.name]'s color."))
				return TRUE

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT

			var/choice_color = input("What would you like the new color to be?","Color Selection",color) as color|null

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)

			if(!choice_color)
				caller.to_chat(span("notice","You decide not to change \the [src.name]'s color."))
				return TRUE

			color = choice_color
			polymorphs[choice] = polymorphs[choice]
			caller.to_chat(span("notice","You change \the [src.name]'s color."))
			update_sprite()

			return TRUE

	return ..()

