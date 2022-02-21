/obj/item/container/edible/dynamic/pizza
	name = "dough"
	icon = 'icons/obj/item/consumable/food/dynamic_pizza.dmi'
	icon_state = "bread_pizza"
	crafting_id = "pizza"

	cooked_icon_state = "bread_pizza"
	raw_icon_state = "dough_pizza"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

	reagents = /reagent_container/food/bread

	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	var/color_sauce
	var/color_cheese

	var/reagent_container/reagents_toppings = /reagent_container/food/toppings

	var/list/topping_data = list(
		"small" = list(),
		"medium" = list(),
		"large" = list()
	)

	var/list/offsets = list(
		"small" = 0,
		"medium" = 0,
		"large" = 0
	)

/obj/item/container/edible/dynamic/pizza/Generate()
	. = ..()
	reagents.add_reagent(/reagent/nutrition/dough/flour/processed,30)

/obj/item/container/edible/dynamic/pizza/Initialize()
	. = ..()
	if(reagents_toppings)
		reagents_toppings = new reagents_toppings(src)

/obj/item/container/edible/dynamic/pizza/Destroy()
	. = ..()
	QDEL_NULL(reagents_toppings)

/obj/item/container/edible/dynamic/pizza/Generate()
	. = ..()
	for(var/k in offsets)
		offsets[k] = rand(1,3)

/obj/item/container/edible/dynamic/pizza/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/container) && object.reagents && object.reagents.volume_current && !istype(object,/obj/item/container/edible/dynamic/pizza))
		var/valid = FALSE
		var/obj/item/I = object
		if(I.allow_reagent_transfer_to && I.allow_reagent_transfer_from) //Sauce
			if(!color_sauce)
				color_sauce = I.reagents.color
			else
				color_sauce = blend_colors(color_sauce,I.reagents.color,0.5) //Lazy, I know but it saves on vars and processing.
			I.reagents.transfer_reagents_to(src.reagents_toppings,min(10,I.reagents.volume_current),caller = caller)
			caller.to_chat(span("notice","You sauce up \the [initial(src.name)]."))
			return TRUE
		else if(istype(I,/obj/item/container/edible/dynamic/cheese))
			if(!color_cheese)
				color_cheese = I.reagents.color
			else
				color_cheese = blend_colors(color_cheese,I.reagents.color,0.5) //Lazy, I know but it saves on vars and processing.
			valid = TRUE
		else if(istype(I,/obj/item/container/edible))
			valid = TRUE
			switch(I.reagents.volume_current)
				if(0 to 5)
					if(length(topping_data["small"]) < 3)
						topping_data["small"] += I.reagents.color
				if(5 to 10)
					if(length(topping_data["medium"]) < 3)
						topping_data["medium"] += I.reagents.color
				if(10 to INFINITY)
					if(length(topping_data["large"]) < 3)
						topping_data["large"] += I.reagents.color
		if(valid)
			update_sprite()
			caller.to_chat(span("notice","You add \the [I.name] to \the [initial(src.name)]."))
			I.reagents.transfer_reagents_to(src.reagents_toppings,I.reagents.volume_current,caller = caller)
			qdel(I)
		else
			caller.to_chat(span("warning","You can't reasonably find a way to add \the [I.name] to \the [initial(src.name)]..."))

		return TRUE

	. = ..()

/obj/item/container/edible/dynamic/pizza/update_overlays()

	. = ..()

	if(color_sauce)
		var/image/I = new/image(icon,"sauce")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.color = color_sauce
		add_overlay(I)

	if(color_cheese)
		var/image/I = new/image(icon,"cheese")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.color = color_cheese
		add_overlay(I)

	for(var/k in topping_data)
		var/list/v = topping_data[k]
		for(var/i=1,i<=length(v),i++)
			var/local_offset = 1 + (i+offsets[k] % 2)
			var/image/topping = new/image(icon,"topping_[k]_[local_offset]")
			topping.appearance_flags = appearance_flags | RESET_COLOR
			topping.color = v[i]
			add_overlay(topping)

/obj/item/container/edible/dynamic/pizza/get_reagents_to_consume(var/mob/living/consumer) //I know its shitcode to do this but what can you do.

	var/total_reagents = max(reagents_toppings.volume_current,reagents.volume_current)

	var/calculated_bites = get_calculated_bites(consumer,total_reagents)
	var/reagent_container/temp/T = new(src,1000)

	if(calculated_bites < 1)
		calculated_bites = 1

	reagents.transfer_reagents_to(T, reagents.volume_current/calculated_bites)
	reagents_toppings.transfer_reagents_to(T, reagents_toppings.volume_current/calculated_bites)

	return T.qdeleting ? null : T


/obj/item/container/edible/dynamic/pizza/update_sprite()

	if(reagents)
		color = reagents.color

	. = ..()