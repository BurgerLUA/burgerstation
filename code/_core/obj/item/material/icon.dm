/obj/item/material/update_icon()
	icon_state = "[initial(icon_state)]_[min(ceiling(item_count_current/10,1),item_count_max_icon)]"
	weight = initial(weight)*item_count_current
	return ..()