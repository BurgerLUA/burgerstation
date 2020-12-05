/obj/item/fishing/tacklebox
	name = "tackle box"
	desc = "back at da secret fishing spot"
	desc_extended = "A tackle box that can store a lot of fishing equipment, like lures and bait."
	icon = 'icons/obj/item/fishing/tackle.dmi'
	damage_type = /damagetype/item/heavy
	value = 10
	size = SIZE_2
	weight = 2
	is_container = TRUE
	container_max_size = SIZE_2
	dynamic_inventory_count = 16
	container_whitelist = list(
		/obj/item/fishing/line/,
		/obj/item/fishing/lure/,
		/obj/item/fishing/bait/
	)

/obj/item/fishing/tacklebox/red
	color = "#DE5743"

/obj/item/fishing/tacklebox/green
	color = "#8DD99A"

/obj/item/fishing/tacklebox/blue
	color = "#7BCEDB"