/obj/item/container/food/cookable
	name = "cookable"
	health = /health/obj/item/misc/
	scale_sprite = FALSE
	var/cooked = FALSE

/obj/item/container/food/cookable/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)][cooked ? "_cooked" : ""]"
	return .

/obj/item/container/food/cookable/dough
	name = "dough"
	icon = 'icons/obj/items/consumable/food/cookable_bread.dmi'
	icon_state = "dough_ball"
	crafting_id = "dough"
	cooked = FALSE

