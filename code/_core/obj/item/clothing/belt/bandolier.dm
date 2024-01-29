/obj/item/clothing/belt/bandolier
	name = "error bandolier"
	desc = "For the aspiring sweeper."
	desc_extended = "A not-so-fancy bandolier meant to hold a number of shotgun shells. ALT+Click to grab additional shells while already holding a shell."

	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT_OVER
	dyeable = TRUE


	value = 0
	size = SIZE_3

	var/list/stored_shells = list()

	var/shell_count = 0
	var/max_shells = 0
	var/shell_type = /obj/item/bullet_cartridge

/obj/item/clothing/belt/bandolier/get_base_value()
	return max_shells*3

//only called on Finalise to calculate the shell count from memory
/obj/item/clothing/belt/bandolier/proc/update_shell_count()
	shell_count = 0
	for(var/k in stored_shells)
		var/v = stored_shells[k]
		shell_count += v

/obj/item/clothing/belt/bandolier/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	.["stored_shells"] = list()
	for(var/k in stored_shells)
		var/v = stored_shells[k]
		.["stored_shells"][k] = v

/obj/item/clothing/belt/bandolier/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	for(var/k in object_data["stored_shells"])
		var/v = object_data["stored_shells"][k]
		stored_shells[text2path_safe(k)] = v

/obj/item/clothing/belt/bandolier/Finalize()
	. = ..()
	update_shell_count()
	update_sprite()

/obj/item/clothing/belt/bandolier/update_icon()
	. = ..()
	icon_state_worn = initial(icon_state_worn)
	if(shell_count)
		icon_state_worn = "[icon_state_worn]_filled"

/obj/item/clothing/belt/bandolier/update_overlays()
	. = ..()
	var/step = max_shells/5
	if(shell_count)
		var/image/I = new/image(icon,"shell_[CEILING(shell_count/step,1)]")
		add_overlay(I)

/obj/item/clothing/belt/bandolier/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(istype(object,shell_type))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		var/obj/item/bullet_cartridge/S = object

		if(caller.attack_flags & CONTROL_MOD_DISARM)
			if(!stored_shells[S.type])
				caller.to_chat(span("warning","There are no shells of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = S.add_item_count(1)
			if(amount_added)
				stored_shells[S.type] -= amount_added
				if(stored_shells[S.type] <= 0)
					stored_shells -= S.type
				shell_count -= amount_added
				caller.to_chat(span("notice","You add a shell to your hand. There are [stored_shells[S.type]] shells of that type left."))
				update_sprite()
		else
			var/amount_added = -S.add_item_count(-min(S.amount,max(0,max_shells - shell_count)))
			if(amount_added)
				if(!stored_shells[S.type])
					stored_shells[S.type] = amount_added
				else
					stored_shells[S.type] += amount_added
				shell_count += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/item/bullet_cartridge)&&!istype(object,shell_type))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		caller.to_chat(span("warning","This type of shell doesn't fit!"))
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		if(!length(stored_shells))
			caller.to_chat(span("warning","There are no shells left!"))
			return TRUE

		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/S = pickweight(stored_shells)
		if(!S)
			S = initial(shell_type)
		S = new S(get_turf(src))
		var/amount_to_grab = 1
		if(!(caller.attack_flags & CONTROL_MOD_DISARM))
			amount_to_grab = min(stored_shells[S.type],S.amount_max)
		S.amount = amount_to_grab
		stored_shells[S.type] -= amount_to_grab
		if(stored_shells[S.type] <= 0)
			stored_shells -= S.type
		shell_count -= amount_to_grab
		caller.to_chat(span("notice","You take [amount_to_grab] shell\s from \the [src.name]. There are [stored_shells[S.type]] shells of that type left."))
		INITIALIZE(S)
		FINALIZE(S)
		I.add_object(S)
		update_sprite()
		return TRUE

	. = ..()

/obj/item/clothing/belt/bandolier/shotgun_12
	name = "12 gauge shotgun bandolier"
	desc_extended = "A not-so-fancy bandolier meant to hold a number of 12 gauge shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_12.dmi'
	max_shells = 100
	shell_type = /obj/item/bullet_cartridge/shotgun_12
	value = 1 //Dummy value.

/obj/item/clothing/belt/bandolier/shotgun_20
	name = "20 gauge shotgun bandolier"
	desc_extended = "A dyed bandolier meant to hold a number of 20 gauge shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_20.dmi'
	max_shells = 120
	shell_type = /obj/item/bullet_cartridge/shotgun_20
	value = 1 //Dummy value.

/obj/item/clothing/belt/bandolier/shotgun_23
	name = "23x75mmR shotgun bandolier"
	desc_extended = "A surplus bandolier meant to hold a number of 23x75mmR shotgun shells. Click to grab a handful of shells, or ALT+Click to take one."
	icon = 'icons/obj/item/clothing/belts/bandolier_23.dmi'
	max_shells = 80
	shell_type = /obj/item/bullet_cartridge/shotgun_23
	value = 1 //Dummy value.