/obj/item/material/shard
	name = "shard"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "shard"

	item_count_current = 1
	item_count_max = 1
	item_count_max_icon = 1

	crafting_id = "shard"

/obj/item/material/shard/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,3)]"
	return ..()

/obj/item/material/shard/glass
	name = "glass shard"
	desc = "A shard of glass."
	desc_extended = "Careful to not step on this barefoot."
	material_id = /material/glass