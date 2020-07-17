/obj/item/container/food/sandwich
	name = "sandwich"
	desc = "A clusterfuck of food."
	desc_extended = "SANDWICH MAKES ME STRONG!"

	size = 3

	is_container = TRUE
	container_max_size = 2

	dynamic_inventory_count = 8

	icon = 'icons/obj/item/consumable/food/dynamic_bread.dmi'
	icon_state = "bun_bottom"

	scale_sprite = FALSE

/obj/item/container/food/sandwich/Generate()
	reagents.add_reagent(/reagent/nutrition/bread/flour/processed,5)
	return ..()

/obj/item/container/food/sandwich/update_icon()

	if(istype(reagents))
		icon = initial(icon)
		icon_state = initial(icon_state)

		var/icon/I = new/icon(icon,icon_state)
		I.Blend(reagents.color,ICON_MULTIPLY)

		icon = I

	return ..()

/obj/item/container/food/sandwich/update_overlays()

	. = ..()

	var/offset_y = 2

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT)
			continue
		var/image/IM = new/image(IT.icon,IT.icon_state)
		IM.pixel_y = offset_y
		IM.color = IT.color
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
	icon_state = "bun_bottom"