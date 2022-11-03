/obj/item/container/edible/dynamic/pizza
	name = "pizza"
	icon = 'icons/obj/item/consumable/food/dynamic_pizza.dmi'
	icon_state = "bread_pizza"
	crafting_id = "pizza"

	cooked_icon_state = "bread_pizza"
	raw_icon_state = "dough_pizza"

	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND | KEEP_TOGETHER

	health = /health/obj/item/misc/

	scale_sprite = FALSE

	reagents = /reagent_container/food/bread

	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	var/sliced = FALSE

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

	var/cooked_percent = 0 //0 to 1 value of how much it's cooked.

/obj/item/container/edible/dynamic/pizza/sliced
	crafting_id = "pizza_slice"
	sliced = TRUE
	pixel_x = 6
	pixel_y = -1

/obj/item/container/edible/dynamic/pizza/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return !sliced

/obj/item/container/edible/dynamic/pizza/Destroy()
	. = ..()
	QDEL_NULL(reagents_toppings)

/obj/item/container/edible/dynamic/pizza/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEVAR("sliced")
	SAVEVAR("color_sauce")
	SAVEVAR("color_cheese")
	SAVELIST("topping_data")
	SAVELIST("offsets")
	if(reagents_toppings && length(reagents_toppings.stored_reagents))
		.["reagents_toppings"] = reagents.stored_reagents

/obj/item/container/edible/dynamic/pizza/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("sliced")
	LOADVAR("color_sauce")
	LOADVAR("color_cheese")
	LOADLIST("topping_data")
	LOADLIST("offsets")

/obj/item/container/edible/dynamic/pizza/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(length(object_data["reagents_toppings"]))
		for(var/r_id in object_data["reagents_toppings"])
			var/volume = object_data["reagents_toppings"][r_id]
			var/R_path = text2path(r_id)
			if(!R_path)
				log_error("Load item error: Tried loading an invalid reagent [r_id]!")
				continue
			reagents_toppings.add_reagent(R_path,volume,TNULL,FALSE)
		reagents_toppings.update_container(P)

/obj/item/container/edible/dynamic/pizza/Initialize()
	. = ..()
	for(var/k in offsets)
		offsets[k] = rand(1,3)
	if(reagents_toppings)
		reagents_toppings = new reagents_toppings(src)

/obj/item/container/edible/dynamic/pizza/Generate()
	. = ..()
	reagents.add_reagent(/reagent/nutrition/dough/flour/processed,30)

/obj/item/container/edible/dynamic/pizza/Finalize()
	. = ..()
	if(sliced)
		var/icon/I = new/icon(initial(icon),"slice_mask")
		filters += filter(type="alpha",icon=I)

/obj/item/container/edible/dynamic/pizza/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!sliced && isturf(loc))
		var/turf/T = loc
		var/original_reagents_amount = reagents.volume_current
		var/original_reagents_toppings_amount = reagents_toppings.volume_current
		for(var/i=1,i<=8,i++)
			var/obj/item/container/edible/dynamic/pizza/sliced/P = new(T)
			INITIALIZE(P)
			P.topping_data = topping_data.Copy()
			P.color_cheese = color_cheese
			P.color_sauce = color_sauce
			reagents.transfer_reagents_to(P.reagents,original_reagents_amount/8)
			reagents_toppings.transfer_reagents_to(P.reagents_toppings,original_reagents_toppings_amount/8)
			FINALIZE(P)
		qdel(src)

/obj/item/container/edible/dynamic/pizza/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!sliced && istype(object,/obj/item/container) && object.reagents && object.reagents.volume_current && !istype(object,/obj/item/container/edible/dynamic/pizza))
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

/obj/item/container/edible/dynamic/pizza/update_sprite()

	var/total_raw = 0
	var/total_cooked = 0

	for(var/id in reagents.stored_reagents)
		var/reagent/R = REAGENT(id)
		var/volume = reagents.stored_reagents[id]
		if(R.flags_reagent & FLAG_REAGENT_RAW)
			total_raw += volume
		else
			total_cooked += volume

	cooked_percent = total_cooked/(total_raw+total_cooked)

	if(reagents)
		color = reagents.color

	. = ..()

/obj/item/container/edible/dynamic/pizza/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = "none"

/obj/item/container/edible/dynamic/pizza/update_overlays()

	. = ..()

	if(color_sauce)
		var/image/I = new/image(icon,"sauce")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = color_sauce
		add_overlay(I)

	if(color_cheese)
		var/image/I = new/image(icon,"cheese")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = color_cheese
		add_overlay(I)

	for(var/k in topping_data)
		var/list/v = topping_data[k]
		for(var/i=1,i<=length(v),i++)
			var/local_offset = 1 + (i+offsets[k] % 2)
			var/image/topping = new/image(icon,"topping_[k]_[local_offset]")
			topping.appearance_flags = src.appearance_flags | RESET_COLOR
			topping.color = v[i]
			add_overlay(topping)

/obj/item/container/edible/dynamic/pizza/update_underlays()

	. = ..()

	var/cooked_alpha = CEILING(cooked_percent*255,1)
	var/raw_alpha = 255 - cooked_alpha

	var/image/cooked = new/image(icon,"pizza_cooked")
	cooked.alpha = cooked_alpha
	cooked.appearance_flags = src.appearance_flags
	add_underlay(cooked)

	var/image/raw = new/image(icon,"pizza_raw")
	raw.alpha = raw_alpha
	raw.appearance_flags = src.appearance_flags
	add_underlay(raw)


/obj/item/container/edible/dynamic/pizza/get_reagents_to_consume(var/mob/living/consumer) //I know its shitcode to do this but what can you do.

	var/total_reagents = max(reagents_toppings.volume_current,reagents.volume_current)

	var/calculated_bites = get_calculated_bites(consumer,total_reagents)
	var/reagent_container/temp/T = new(src,1000)

	if(calculated_bites < 1)
		calculated_bites = 1

	reagents.transfer_reagents_to(T, reagents.volume_current/calculated_bites)
	reagents_toppings.transfer_reagents_to(T, reagents_toppings.volume_current/calculated_bites)

	return T.qdeleting ? null : T


/obj/item/container/edible/dynamic/pizza/mushroom/Generate()
	. = ..()
	reagents_toppings.add_reagent(/reagent/nutrition/tomato,10)
	color_sauce = "#C90000"

	reagents_toppings.add_reagent(/reagent/nutrition/cheese/cheddar,10)
	color_cheese = "#FF9F00"

	reagents_toppings.add_reagent(/reagent/nutrition/meat/cow/cooked,20)
	topping_data["large"] += "#6B3731"

	reagents_toppings.add_reagent(/reagent/nutrition/porcini,10)
	topping_data["medium"] += "#68593E"

	reagents_toppings.add_reagent(/reagent/nutrition/capsaicin,5)
	topping_data["small"] += "#EF3232"