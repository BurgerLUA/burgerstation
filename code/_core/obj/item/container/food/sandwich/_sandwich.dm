/obj/item/container/edible/sandwich
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

/obj/item/container/edible/sandwich/proc/sync_planes()
	return TRUE

/obj/item/container/edible/sandwich/Finalize()
	update_sprite()
	return ..()


/obj/item/container/edible/sandwich/Generate()
	reagents.add_reagent(/reagent/nutrition/bread/flour/processed,5)
	return ..()

/obj/item/container/edible/sandwich/update_sprite()

	if(istype(reagents))
		src.color = reagents.color

	return ..()

/obj/item/container/edible/sandwich/update_overlays()

	. = ..()

	var/offset_y = 2

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_object()
		if(!IT)
			continue
		var/image/IM = new/image(IT.icon,IT.icon_state)
		IM.appearance = IT.appearance
		IM.plane = FLOAT_PLANE
		IM.layer = FLOAT_LAYER + i*0.01
		IM.pixel_y = offset_y + IT.pixel_height_offset
		add_overlay(IM)
		offset_y += IT.pixel_height


/obj/item/container/edible/sandwich/update_inventory()
	. = ..()
	update_sprite()

/obj/item/container/edible/sandwich/burger
	name = "burger"
	icon_state = "bun_bottom"


/obj/item/container/edible/sandwich/bread
	name = "sandwich"
	icon_state = "bread_slice"