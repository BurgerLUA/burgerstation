/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

/obj/item/weapon/ranged/bullet/magazine/click_self(var/atom/caller)
	caller.to_chat(span("notice","You cock \the [src]."))

	caller << icon_state_held_left
	caller << icon_state_held_right

/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	name = "assault rifle"
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'

	can_wield = TRUE

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/update_icon()

	if(wielded)
		icon_state_held_left = "wielded_left"
		icon_state_held_right = "wielded_right"
	else
		var/open_text = open ? "_open" : ""
		icon_state_held_left = "[initial(icon_state_held_left)][open_text]"
		icon_state_held_right = "[initial(icon_state_held_right)][open_text]"

	if(open)
		icon_state = "[initial(icon_state)]_open"
	else
		icon_state = initial(icon_state)




	..()