/obj/item/container/food/sandwich
	name = "sandwich"
	desc = "A clusterfuck of food."
	desc_extended = "SANDWICH MAKES ME STRONG!"

	size = SIZE_2

	is_container = TRUE
	container_max_size = SIZE_1

	dynamic_inventory_count = MAX_INVENTORY_X

	dynamic_inventory_type = /obj/hud/inventory/dynamic/sandwich/

	icon = 'icons/obj/item/consumable/food/dynamic_bread.dmi'
	icon_state = "bun_bottom"

	scale_sprite = FALSE

/obj/item/container/food/sandwich/proc/sync_planes()
	return TRUE

/obj/item/container/food/sandwich/Finalize()
	update_sprite()
	return ..()


/obj/item/container/food/sandwich/Generate()
	reagents.add_reagent(/reagent/nutrition/bread/flour/processed,5)
	return ..()

/obj/item/container/food/sandwich/update_sprite()

	if(istype(reagents))
		src.color = reagents.color

	return ..()

/obj/item/container/food/sandwich/update_overlays()

	. = ..()

	var/offset_y = 2

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_object()
		if(!IT)
			continue
		var/image/IM = new/image(IT.icon,IT.icon_state)
		IM.appearance = IT.appearance
		IM.appearance_flags |= RESET_COLOR
		IM.pixel_y = offset_y + IT.pixel_height_offset
		IM.plane = FLOAT_PLANE
		add_overlay(IM)
		offset_y += IT.pixel_height

	return .


/obj/item/container/food/sandwich/update_inventory()
	. = ..()
	if(initialized)
		update_sprite()
	return .

/obj/item/container/food/sandwich/burger
	name = "burger"
	icon_state = "bun_bottom"


/obj/item/container/food/sandwich/bread
	name = "sandwich"
	icon_state = "bread_slice"