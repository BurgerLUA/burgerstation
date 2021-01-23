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

	var/markup = 1.25 //Cost multiplier from buying out of this vendor.

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/vending/Destroy()
	stored_types.Cut()
	stored_objects.Cut()
	return ..()

/obj/structure/interactive/vending/proc/spend_currency(var/mob/living/advanced/player/P,var/amount=0)


	if(accepts_item)
		if(P.right_item && istype(P.right_item,accepts_item) && P.right_item.item_count_current >= amount)
			P.right_item.add_item_count(-amount)
		else if(P.left_item && istype(P.left_item,accepts_item) && P.left_item.item_count_current >= amount)
			P.left_item.add_item_count(-amount)
		else
			P.to_chat(span("warning","You don't have enough [accepts_item.name]s to purchase this!"))
			return FALSE

	if(!is_free && !P.spend_currency(amount))
		P.to_chat(span("notice","You don't have enough credits to purchase this item!"))
		return FALSE

	return TRUE


/obj/structure/interactive/vending/proc/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0)

	if(!spend_currency(P,item_value))
		return null

	var/obj/item/new_item
	new_item = new associated_item.type(get_turf(src))
	INITIALIZE(new_item)
	GENERATE(new_item)
	FINALIZE(new_item)
	new_item.update_sprite()

	P.to_chat(span("notice","You vend \the [new_item.name]."))

	P.put_in_hands(new_item)

	return new_item

/obj/structure/interactive/vending/Initialize()

	var/turf/T = get_turf(src)

	for(var/S in stored_types)
		var/obj/item/I = new S(T)
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
	stored_types.Cut()

	return ..()

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


	for(var/obj/item/I in stored_objects)
		if(stored_cost[I.type])
			continue
		stored_cost[I.type] = CEILING(I.get_value()*markup,1)
		if(stored_cost[I.type] <= 0)
			log_error("Warning: [I.type] is for sale, yet it has no value!")
			stored_cost -= I.type
			stored_objects -= I
			qdel(I)

	return .

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