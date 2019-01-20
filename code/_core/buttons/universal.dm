/obj/button/equip
	name = "autoequip item"
	desc = "Automatically wears the item that you're holding."
	icon_state = "uip"
	screen_loc = "CENTER+0.5,BOTTOM+1"

/obj/button/equip/left
	icon_state = "autoeq"
	screen_loc = "CENTER-0.5,BOTTOM+1"

/obj/button/resist
	name = "resist"
	desc = "DON'T FORGET TO SMASH THAT RESIST BUTTON."
	icon_state = "resist"
	screen_loc = "RIGHT-1,BOTTOM"

/obj/button/resist_auto
	name = "toggle auto resist"
	desc = "DON'T FORGET TO SMASH THAT RESIST BUTTON."
	icon_state = "auto"
	screen_loc = "RIGHT-1,BOTTOM"


/obj/button/resist_auto/update_icon()

	if(owner.auto_resist)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()

/obj/button/resist_auto/clicked_by_object(var/mob/caller,object,location,control,params)
	owner.auto_resist = !owner.auto_resist
	update_icon()
	..()

/obj/button/hide_show_inventory
	name = "toggle inventory"
	desc = "Show/hide useless inventory."
	icon_state = "view_inventory"
	screen_loc = "LEFT,BOTTOM"

/obj/button/hide_show_inventory/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	A.toggle_inventory()

	update_icon()
	..()

/obj/button/hide_show_inventory/update_icon()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner


	if(A.draw_inventory)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()
