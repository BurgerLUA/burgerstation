/obj/item/clothing/belt/bandolier
	name = "bandolier"
	desc = "For the aspiring sweeper."
	desc_extended = "A not-so-fancy bandolier meant to hold a number of shotgun shells. ALT+Click to grab additional shells while already holding a shell."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_SWORD
	)

	rarity = RARITY_UNCOMMON
	value = 200

	var/list/stored_shells = list()
	var/shell_count = 0

	var/max_shells = 0

/obj/item/clothing/belt/bandolier/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["stored_shells"] = list()
	for(var/k in stored_shells)
		var/v = stored_shells[k]
		.["stored_shells"][k] = v

/obj/item/clothing/belt/bandolier/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	for(var/k in object_data["stored_shells"])
		var/v = object_data["stored_shells"][k]
		stored_shells[text2path(k)] = v

/obj/item/clothing/belt/bandolier/Finalize()
	. = ..()
	update_sprite()

/obj/item/clothing/belt/bandolier/update_icon()

	var/shell_count = length(stored_shells)

	icon_state_worn = initial(icon_state_worn)

	if(shell_count)
		icon_state_worn = "[icon_state_worn]_filled"

	. = ..()

/obj/item/clothing/belt/bandolier/update_overlays()

	. = ..()

	var/shell_count = length(stored_shells)
	var/step = max_shells/5

	if(shell_count)
		var/image/I = new/image(icon,"shell_[CEILING(shell_count/step,1)]")
		add_overlay(I)

/obj/item/clothing/belt/bandolier/shotgun_12
	desc_extended = "A not-so-fancy bandolier meant to hold a number of 12 gauge shotgun shells. ALT+Click to grab a handful of shells."
	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	max_shells = 200

/obj/item/clothing/belt/bandolier/shotgun_12/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/shotgun_12))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/item/bullet_cartridge/shotgun_12/S = object
		if(caller.attack_flags & CONTROL_MOD_ALT)
			if(!stored_shells[S.type])
				caller.to_chat(span("warning","There are no shells of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = S.add_item_count(1)
			if(amount_added)
				stored_shells[S.type] -= amount_added
				if(stored_shells[S.type] <= 0)
					stored_shells -= S.type
				update_sprite()
		else
			var/amount_added = -S.add_item_count(-min(S.item_count_current,max(0,max_shells - length(stored_shells))))
			if(amount_added)
				if(!stored_shells[S.type])
					stored_shells[S.type] = amount_added
				else
					stored_shells[S.type] += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/hud/inventory/I = object

		if(!length(stored_shells))
			caller.to_chat(span("warning","There are no shells left!"))
			return TRUE

		var/obj/item/bullet_cartridge/shotgun_12/S = pickweight(stored_shells)
		if(caller.attack_flags & CONTROL_MOD_ALT)
			S = new S(get_turf(src))
			var/amount = 0
			if(stored_shells[S.type] < 5)
				amount = stored_shells[S.type]
			else
				amount = 5
			S.item_count_current = amount
			stored_shells[S.type] -= amount
			caller.to_chat(span("notice","You take [amount] shell\s from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
			if(stored_shells[S.type] <= 0)
				stored_shells -= S.type
			INITIALIZE(S)
			FINALIZE(S)
			I.add_object(S)
			update_sprite()
			return TRUE
		S = new S(get_turf(src))
		S.item_count_current = 1
		stored_shells[S.type] -= 1
		caller.to_chat(span("notice","You take a shell from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
		if(stored_shells[S.type] <= 0)
			stored_shells -= S.type
		INITIALIZE(S)
		FINALIZE(S)
		I.add_object(S)
		update_sprite()
		return TRUE

	. = ..()

/obj/item/clothing/belt/bandolier/shotgun_20
	desc_extended = "A dyed bandolier meant to hold a number of 20 gauge shotgun shells. ALT+Click to grab a handful of shells."
	icon = 'icons/obj/item/clothing/belts/bandolier_20.dmi'
	max_shells = 240

/obj/item/clothing/belt/bandolier/shotgun_20/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/shotgun_20))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/item/bullet_cartridge/shotgun_20/S = object
		if(caller.attack_flags & CONTROL_MOD_ALT)
			if(!stored_shells[S.type])
				caller.to_chat(span("warning","There are no shells of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = S.add_item_count(1)
			if(amount_added)
				stored_shells[S.type] -= amount_added
				if(stored_shells[S.type] <= 0)
					stored_shells -= S.type
				update_sprite()
		else
			var/amount_added = -S.add_item_count(-min(S.item_count_current,max(0,max_shells - length(stored_shells))))
			if(amount_added)
				if(!stored_shells[S.type])
					stored_shells[S.type] = amount_added
				else
					stored_shells[S.type] += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/hud/inventory/I = object

		if(!length(stored_shells))
			caller.to_chat(span("warning","There are no shells left!"))
			return TRUE

		var/obj/item/bullet_cartridge/shotgun_20/S = pickweight(stored_shells)
		if(caller.attack_flags & CONTROL_MOD_ALT)
			S = new S(get_turf(src))
			var/amount = 0
			if(stored_shells[S.type] < 5)
				amount = stored_shells[S.type]
			else
				amount = 5
			S.item_count_current = amount
			stored_shells[S.type] -= amount
			caller.to_chat(span("notice","You take [amount] shell\s from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
			if(stored_shells[S.type] <= 0)
				stored_shells -= S.type
			INITIALIZE(S)
			FINALIZE(S)
			I.add_object(S)
			update_sprite()
			return TRUE
		S = new S(get_turf(src))
		S.item_count_current = 1
		stored_shells[S.type] -= 1
		caller.to_chat(span("notice","You take a shell from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
		if(stored_shells[S.type] <= 0)
			stored_shells -= S.type
		INITIALIZE(S)
		FINALIZE(S)
		I.add_object(S)
		update_sprite()
		return TRUE

	. = ..()

/obj/item/clothing/belt/bandolier/shotgun_23
	desc_extended = "A surplus bandolier meant to hold a number of 23 gauge shotgun shells. ALT+Click to grab a handful of shells."
	icon = 'icons/obj/item/clothing/belts/bandolier_23.dmi'
	max_shells = 160

/obj/item/clothing/belt/bandolier/shotgun_23/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/shotgun_23))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/item/bullet_cartridge/shotgun_23/S = object
		if(caller.attack_flags & CONTROL_MOD_ALT)
			if(!stored_shells[S.type])
				caller.to_chat(span("warning","There are no shells of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = S.add_item_count(1)
			if(amount_added)
				stored_shells[S.type] -= amount_added
				if(stored_shells[S.type] <= 0)
					stored_shells -= S.type
				update_sprite()
		else
			var/amount_added = -S.add_item_count(-min(S.item_count_current,max(0,max_shells - length(stored_shells))))
			if(amount_added)
				if(!stored_shells[S.type])
					stored_shells[S.type] = amount_added
				else
					stored_shells[S.type] += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/hud/inventory/I = object

		if(!length(stored_shells))
			caller.to_chat(span("warning","There are no shells left!"))
			return TRUE

		var/obj/item/bullet_cartridge/shotgun_23/S = pickweight(stored_shells)
		if(caller.attack_flags & CONTROL_MOD_ALT)
			S = new S(get_turf(src))
			var/amount = 0
			if(stored_shells[S.type] < 5)
				amount = stored_shells[S.type]
			else
				amount = 5
			S.item_count_current = amount
			stored_shells[S.type] -= amount
			caller.to_chat(span("notice","You take [amount] shell\s from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
			if(stored_shells[S.type] <= 0)
				stored_shells -= S.type
			INITIALIZE(S)
			FINALIZE(S)
			I.add_object(S)
			update_sprite()
			return TRUE
		S = new S(get_turf(src))
		S.item_count_current = 1
		stored_shells[S.type] -= 1
		caller.to_chat(span("notice","You take a shell from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
		if(stored_shells[S.type] <= 0)
			stored_shells -= S.type
		INITIALIZE(S)
		FINALIZE(S)
		I.add_object(S)
		update_sprite()
		return TRUE

	. = ..()
