/obj/item/clothing/belt/belt_quiver
	name = "belt quiver"
	desc = "For the aspiring archer."
	desc_extended = "A not-so-fancy belt quiver meant to hold a number of arrows. ALT+Click to grab additional arrows while already holding an arrow."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/clothing/belts/belt_quiver.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 20
	)

	rarity = RARITY_UNCOMMON
	value = 200

	var/list/stored_arrows = list()
	var/arrow_count = 0

	var/max_arrows = 200

/obj/item/clothing/belt/belt_quiver/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["stored_arrows"] = list()
	for(var/k in stored_arrows)
		var/v = stored_arrows[k]
		.["stored_arrows"][k] = v

/obj/item/clothing/belt/belt_quiver/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	for(var/k in object_data["stored_arrows"])
		var/v = object_data["stored_arrows"][k]
		stored_arrows[text2path(k)] = v

/obj/item/clothing/belt/belt_quiver/Finalize()
	. = ..()
	update_sprite()

/obj/item/clothing/belt/belt_quiver/proc/get_arrow_count()
	. = 0
	for(var/k in stored_arrows)
		var/v = stored_arrows[k]
		. += v

/obj/item/clothing/belt/belt_quiver/update_icon()

	var/arrow_count = get_arrow_count()

	icon_state_worn = initial(icon_state_worn)

	if(arrow_count)
		icon_state_worn = "[icon_state_worn]_filled"

	. = ..()

/obj/item/clothing/belt/belt_quiver/update_overlays()

	. = ..()

	var/arrow_count = get_arrow_count()

	if(arrow_count > 0)
		var/image/I = new/image(icon,"arrow_[min(5,arrow_count)]")
		add_overlay(I)


/obj/item/clothing/belt/belt_quiver/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/arrow))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/item/bullet_cartridge/arrow/A = object
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			if(!stored_arrows[A.type])
				caller.to_chat(span("warning","There are no arrows of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = A.add_item_count(1)
			if(amount_added)
				stored_arrows[A.type] -= amount_added
				if(stored_arrows[A.type] <= 0)
					stored_arrows -= A.type
				update_sprite()
		else
			var/amount_added = -A.add_item_count(-min(A.item_count_current,max(0,max_arrows - get_arrow_count())))
			if(amount_added)
				if(!stored_arrows[A.type])
					stored_arrows[A.type] = amount_added
				else
					stored_arrows[A.type] += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/hud/inventory/I = object
		if(!length(stored_arrows))
			caller.to_chat(span("warning","There are no arrows left!"))
			return TRUE
		var/obj/item/bullet_cartridge/arrow/A = pickweight(stored_arrows)
		A = new A(get_turf(src))
		A.item_count_current = 1
		stored_arrows[A.type] -= 1
		caller.to_chat(span("notice","You take 1 arrow from \the [src.name]. There are [stored_arrows[A.type]] arrows left."))
		if(stored_arrows[A.type] <= 0)
			stored_arrows -= A.type
		INITIALIZE(A)
		FINALIZE(A)
		I.add_object(A)
		update_sprite()
		return TRUE

	. = ..()