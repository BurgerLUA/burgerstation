/obj/item/material/shard
	name = "shard"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "shard"

	item_count_current = 1
	item_count_max = 1
	item_count_max_icon = 1

	weight = WEIGHT_1

	crafting_id = "glass"
	material_id = "glass"

/obj/item/material/shard/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,3)]"
	return ..()

/obj/item/material/shard/glass/normal
	name = "glass shard"
	desc = "A shard of glass."
	crafting_id = "shard_glass_normal"
	color = COLOR_GLASS