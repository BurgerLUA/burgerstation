/obj/item/container/food/raw
	name = "raw food"
	desc = "Not quite edible yet."

/obj/item/container/food/raw/dough
	name = "dough"
	icon = 'icons/obj/items/consumable/food/food_ingredients.dmi'
	icon_state = "dough"

/obj/item/container/food/raw/dough/update_icon()

	var/matrix/M = matrix()
	var/scale_math = reagents.volume_current/reagents.volume_max
	M.Scale(scale_math)
	transform = M

	return ..()
