/obj/item/container/food
	name = "food"
	desc = "Edible reagent"
	desc_extended = "Edible."

	var/bite_count = 0 //How many times someone has taken a bite from this.
	consume_verb = "take a bite out of"

	reagents = /reagent_container/food/

	var/scale_sprite = TRUE
	var/typical_volume = 23 //Standard typical volume for the sprite. Apply transform scale if needed.

	var/remove_on_no_reagents = TRUE

	drop_sound = 'sound/items/drop/food.ogg'

	has_quick_function = TRUE

/obj/item/container/food/quick(var/mob/caller,var/atom/object,location,params)
	return try_transfer_reagents(caller,caller,location,null,params)

/obj/item/container/food/Finalize()
	. = ..()
	update_sprite()

/obj/item/container/food/get_base_transform()
	. = ..()
	if(scale_sprite)
		if(typical_volume <= 0)
			color = "#FF0000"
			log_error("Warning: [src.get_debug_name()] had a typical volume of [typical_volume]!")
		else
			var/matrix/M = .
			var/scale_math = min(0.5 + (reagents.volume_current/typical_volume)*0.5,2)
			M.Scale(scale_math)


/obj/item/container/food/update_sprite()
	. = ..()
	transform = get_base_transform()

/obj/item/container/food/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/food/proc/on_consumed(var/mob/caller,var/mob/living/target) //When there are no reagents left.
	qdel(src)
	return TRUE

/obj/item/container/food/feed(var/mob/caller,var/mob/living/target)

	. = ..()

	if(reagents.volume_current <= 0)
		on_consumed(caller,target)


/obj/item/container/food/proc/get_calculated_bites(var/mob/living/caller,var/total_reagents = 1)
	return CEILING(total_reagents/get_consume_size(caller),1)

/obj/item/container/food/get_reagents_to_consume(var/mob/living/consumer)

	var/total_reagents = reagents.volume_current

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_object()
		if(!IT || !IT.reagents)
			continue
		total_reagents += IT.reagents.volume_current

	var/calculated_bites = get_calculated_bites(consumer,total_reagents)
	var/reagent_container/temp/T = new(src,1000)

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/IN = inventories[i]
		var/obj/item/IT = IN.get_top_object()
		if(!IT || !IT.reagents)
			continue
		IT.reagents.transfer_reagents_to(T, IT.reagents.volume_current/calculated_bites, FALSE )
		IT.reagents.update_container()

	if(calculated_bites < 1)
		calculated_bites = 1

	reagents.transfer_reagents_to(T, reagents.volume_current/calculated_bites)

	return T.qdeleting ? null : T

