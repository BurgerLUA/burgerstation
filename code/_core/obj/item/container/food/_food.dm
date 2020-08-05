/obj/item/container/food
	name = "food"
	desc = "Edible reagent"
	desc_extended = "Edible."

	var/bite_size = 5 //How many reagents to remove per bite?
	var/bite_count = 0 //How many times someone has taken a bite from this.
	consume_verb = "take a bite out of"

	reagents = /reagent_container/food/

	var/scale_sprite = TRUE

	var/remove_on_no_reagents = TRUE

	var/original_volume = 0 //For cooking and stuff.

	value = 10

	drop_sound = 'sound/items/drop/food.ogg'

/obj/item/container/food/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["original_volume"] = original_volume
	return .

/obj/item/container/food/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["original_volume"]) original_volume = object_data["original_volume"]
	return .

/obj/item/container/food/Generate()
	original_volume = reagents.volume_current
	return ..()

/obj/item/container/food/update_icon()

	if(scale_sprite)
		var/matrix/M = matrix()
		var/scale_math = max(0.5 + (original_volume/reagents.volume_max)*0.5)
		M.Scale(scale_math)
		transform = M
	else
		transform = matrix()

	return ..()


/obj/item/container/food/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/food/feed(var/mob/caller,var/mob/living/target)
	. = ..()
	if(. && reagents.volume_current <= 0)
		qdel(src)
	return .

/obj/item/container/food/get_reagents_to_consume()

	var/total_reagents = reagents.volume_current

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT || !IT.reagents)
			continue
		total_reagents += IT.reagents.volume_current

	var/calculated_bites = 1 + FLOOR(total_reagents/(BITE_SIZE*2),1)

	var/reagent_container/temp/T = new(src,1000)

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_held_object()
		if(!IT || !IT.reagents)
			continue
		IT.reagents.transfer_reagents_to(T, IT.reagents.volume_current/calculated_bites, FALSE )
		IT.reagents.update_container()

	reagents.transfer_reagents_to(T, reagents.volume_current/calculated_bites)

	return T.qdeleting ? null : T

