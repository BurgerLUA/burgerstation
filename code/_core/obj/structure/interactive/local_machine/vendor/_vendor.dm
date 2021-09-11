var/global/list/equipped_antags = list()

/obj/structure/interactive/vending/
	name = "vending machine"
	desc = "Vends things!"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "generic"
	desc_extended = "You can use this to purchase things that are always in stock."

	var/list/obj/item/stored_objects = list()
	var/list/obj/item/stored_types = list()
	var/list/obj/item/stored_cost = list()

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	collision_dir = NORTH | EAST | SOUTH | WEST

	var/is_free = FALSE
	var/free_text = "free"
	var/obj/item/accepts_item = null //Set this to an item path to make it accept the itemcount of that item instead.

	initialize_type = INITIALIZE_LATE

	bullet_block_chance = 75

	plane = PLANE_OBJ

	pixel_y = 8

	density = TRUE

	var/markup = 1.1 //Cost multiplier from buying out of this vendor.

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

	var/price_max = 0

	var/ignore_economy = FALSE

/obj/structure/interactive/vending/Destroy()
	QDEL_CUT(stored_objects)
	QDEL_NULL(accepts_item)
	. = ..()

/obj/structure/interactive/vending/proc/spend_currency(var/mob/living/advanced/player/P,var/amount=0)

	if(P.loyalty_tag == "NanoTrasen" && SStax.check_delinquent(P))
		P.to_chat(span("warning","Error: Tax delinquency detected. All associated accounts frozen. Please pay your taxes at the nearest tax payment center."))
		return FALSE

	if(accepts_item)
		if(P.right_item && istype(P.right_item,accepts_item) && P.right_item.item_count_current >= amount)
			P.right_item.add_item_count(-amount)
		else if(P.left_item && istype(P.left_item,accepts_item) && P.left_item.item_count_current >= amount)
			P.left_item.add_item_count(-amount)
		else
			P.to_chat(span("warning","You don't have enough [accepts_item.name]s to purchase this!"))
			return FALSE
		return TRUE

	if(!is_free && !P.spend_currency(amount))
		P.to_chat(span("notice","You don't have enough credits to purchase this item!"))
		return FALSE

	return TRUE

/obj/structure/interactive/vending/proc/modify_item(var/obj/item/I,var/obj/item/base_item)
	return TRUE

/obj/structure/interactive/vending/proc/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0)

	if(!spend_currency(P,item_value))
		return null

	var/obj/item/new_item
	new_item = new associated_item.type(get_turf(src))
	modify_item(new_item,associated_item)
	INITIALIZE(new_item)
	GENERATE(new_item)
	FINALIZE(new_item)
	new_item.update_sprite()

	P.to_chat(span("notice","You vend \the [new_item.name]."))

	P.put_in_hands(new_item)

	if(!ignore_economy)
		SSeconomy.purchases_this_round["[associated_item.type]"] += 1

	return new_item

/obj/structure/interactive/vending/proc/create_item(var/obj/item/item_path,var/turf/turf_spawn)
	var/obj/item/I = new item_path(turf_spawn)
	INITIALIZE(I)
	GENERATE(I)
	FINALIZE(I)
	return I


/obj/structure/interactive/vending/Initialize()

	var/turf/T = get_turf(src)
	for(var/k in stored_types)
		create_item(k,T)
	stored_types.Cut()

	. = ..()

/obj/structure/interactive/vending/proc/get_bullshit_price(var/desired_price)

	if(accepts_item)
		return CEILING(desired_price,1)

	//Basically makes prices how they'd appear in stores.

	switch(desired_price)
		if(0 to 1)
			return CEILING(desired_price,0.01)
		if(1 to 100)
			return CEILING(desired_price,1) - 0.01

	return CEILING(desired_price,50) - 1

/obj/structure/interactive/vending/Finalize()

	. = ..()

	var/turf/T = get_turf(src)

	for(var/obj/item/I in T.contents)
		stored_objects += I
		I.drop_item(src)
		I.plane = PLANE_HUD_OBJ
		I.pixel_y = 4

	if(accepts_item)
		accepts_item = new accepts_item(src)
		INITIALIZE(accepts_item)
		GENERATE(accepts_item)
		FINALIZE(accepts_item)
		markup *= 1/accepts_item.value
		price_max = accepts_item.item_count_max

	for(var/obj/item/I in stored_objects)
		if(stored_cost[I.type])
			continue
		var/local_markup = markup
		if(!ignore_economy)
			local_markup = max(markup * (SSeconomy.price_multipliers["[I.type]"] ? SSeconomy.price_multipliers["[I.type]"] : 1),markup)
		stored_cost[I.type] = CEILING(get_bullshit_price(I.get_value()*local_markup),1)
		if(price_max)
			stored_cost[I.type] = min(price_max,stored_cost[I.type])
		if(stored_cost[I.type] <= 0)
			log_error("Warning: [I.type] is for sale, yet it has no value!")
			stored_cost -= I.type
			stored_objects -= I
			qdel(I)
		else if(!ignore_economy && !isnum(SSeconomy.purchases_this_round["[I.type]"]))
			SSeconomy.purchases_this_round["[I.type]"] = 0


/obj/structure/interactive/vending/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller) && !is_inventory(object))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	var/mob/living/advanced/player/P = caller

	if(P.active_structure == src)
		P.set_structure_unactive()
	else
		P.set_structure_active(src)

	return TRUE

/obj/structure/interactive/vending/proc/show_buttons_to(var/mob/living/advanced/A)

	var/stored_objects_length = length(stored_objects)

	var/row=0
	var/column=0

	for(var/i=1,i<=stored_objects_length,i++)
		if(row >= 8)
			row = 0
			column++
		var/obj/item/I = stored_objects[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.associated_vendor = src
		V.associated_cost = stored_cost[I.type]
		V.screen_loc = "LEFT+[1 + (column)*3],TOP-[row+1]"
		V.update_owner(A)
		V.update_sprite()
		row++

	var/obj/hud/button/close_vendor/CV = new
	CV.screen_loc = "LEFT+[1 + (column+1)*3],TOP-1"
	CV.update_owner(A)
	CV.update_sprite()

/obj/structure/interactive/vending/proc/hide_buttons_from(var/mob/living/advanced/A)

	for(var/obj/hud/button/vendor/V in A.buttons)
		V.update_owner(null)

	for(var/obj/hud/button/close_vendor/V in A.buttons)
		V.update_owner(null)

/obj/structure/interactive/vending/on_active(var/mob/living/advanced/player/P)
	show_buttons_to(P)
	return ..()

/obj/structure/interactive/vending/on_inactive(var/mob/living/advanced/player/P)
	hide_buttons_from(P)
	return ..()