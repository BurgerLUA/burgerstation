/obj/item/material/shard
	name = "shard"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "shard"

	amount_max = 1
	amount_max_icon = 1


	material_multiplier = 0.5

/obj/item/material/shard/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,3)]"
	return ..()