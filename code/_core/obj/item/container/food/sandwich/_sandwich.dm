/obj/item/container/food/sandwich
	name = "sandwich"
	desc = "A clusterfuck of food."

	size = 3

	is_container = TRUE
	container_max_size = 2

	dynamic_inventory_count = 8

	icon = 'icons/obj/items/consumable/food/dynamic_bread.dmi'
	icon_state = "bun_bottom"

	scale_sprite = FALSE

/obj/item/container/food/sandwich/on_spawn()
	reagents.add_reagent("bread_flour_white",5)


/obj/item/container/food/sandwich/get_reagents_to_eat()

	var/total_reagents = reagents.volume_current

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT || !IT.reagents)
			continue
		total_reagents += IT.reagents.volume_current

	var/reagent_container/temp/T = new()

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT || !IT.reagents)
			continue
		IT.reagents.transfer_reagents_to(T, bite_size * (IT.reagents.volume_current/total_reagents), FALSE )
		IT.reagents.update_container()

	reagents.transfer_reagents_to(T, bite_size * (reagents.volume_current/total_reagents))

	return T

/obj/item/container/food/sandwich/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	I.Blend(reagents.color,ICON_MULTIPLY)

	overlays.Cut()

	var/offset_y = -2

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT)
			continue
		IT.pixel_y = offset_y
		overlays += IT
		offset_y += 4

	icon = I

	return ..()


/obj/item/container/food/sandwich/update_inventory()
	. = ..()
	update_icon()
	return .


/obj/item/container/food/sandwich/burger
	name = "burger"
	icon_state = "bun_bottom"


/obj/item/container/food/sandwich/bread
	name = "sandwich"
	icon_state = "bun_bottom"