/obj/structure/interactive/localmachine/harvestable_flora
	name = "harvestable flora"
	desc = "Harvest me!"

	var/obj/item/item_to_harvest


/obj/structure/interactive/localmachine/harvestable_flora/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller

		var/atom/defer_object = object.defer_click_on_object()

		if(!is_inventory(defer_object))
			A.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
			return TRUE

		var/obj/hud/inventory/I = defer_object

		var/obj/item/created_item = new item_to_harvest(src.loc)
		created_item.on_spawn()
		created_item.update_icon()
		created_item.transfer_item(I)
		A.to_chat(span("notice","You harvest from \the [src.name]."))
		disallowed_mobs += A
		clear_existing_images(A)

	return TRUE

/obj/structure/interactive/localmachine/harvestable_flora/nitrogen_flower

	name = "nitrogen flower"

	icon = 'icons/obj/structure/flora/nitrogenflower.dmi'
	icon_state = "1"

	item_to_harvest = /obj/item/container/food/plant/nitrogen_flower

/obj/structure/interactive/localmachine/harvestable_flora/nitrogen_flower/New(var/desired_loc)
	icon_state = "[rand(1,4)]"
	return ..()


/obj/structure/interactive/localmachine/harvestable_flora/oxygen_fruit

	name = "oxygen fruit"

	icon = 'icons/obj/structure/flora/oxygen_fruit.dmi'
	icon_state = "1"

	item_to_harvest = /obj/item/container/food/plant/oxygen_fruit