/obj/item/clothing/belt/bandoliers
	var/list/stored_bullets = list()

	var/bullet_count = 0 //How many bullets are in the belt in total.
	var/max_bullets = 100 //The maximum number of bullets the belt can hold. Duh.

	var/next_regen = 0 //How long until it can be restocked again
	var/can_be_restocked = FALSE //If someone can use a premium restocker to fill this with bullets, false by default. If you want to be able to restock your bandolier, make sure to define this as true.

	var/bullet_type = /obj/item/bullet_cartridge //The one specific kind of bullet that this belt can hold. I should probably make it a list so you can add more storable bullets but oh well.
	var/bullet_type_premium = /obj/item/bullet_cartridge //Only for ammo restocking purposes, don't need to worry about this if it can't be restocked. Otherwise, make sure it's set to the premium version of the bullet your belt can hold

	var/num_overlays = 0 //The number of overlays the belt sprite has, so it can update at an equal interval and also won't try adding overlays to belts that have none

/obj/item/clothing/belt/bandoliers/proc/update_bullet_count()
	bullet_count = 0
	for(var/k in stored_bullets)
		var/v = stored_bullets[k]
		bullet_count += v

/obj/item/clothing/belt/bandoliers/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	.["stored_bullets"] = list()
	for(var/k in stored_bullets)
		var/v = stored_bullets[k]
		.["stored_bullets"][k] = v

/obj/item/clothing/belt/bandoliers/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	for(var/k in object_data["stored_bullets"])
		var/v = object_data["stored_bullets"][k]
		stored_bullets[text2path_safe(k)] = v

/obj/item/clothing/belt/bandoliers/Finalize()
	. = ..()
	update_bullet_count()
	update_sprite()

/obj/item/clothing/belt/bandoliers/update_icon()
	. = ..()
	icon_state_worn = initial(icon_state_worn)
	if(num_overlays == 0)
		if(bullet_count)
			icon_state_worn = "[icon_state_worn]_filled"
			icon_state = "full"
		else
			icon_state = "inventory"
	else
		if(bullet_count)
			icon_state_worn = "[icon_state_worn]_filled"

/obj/item/clothing/belt/bandoliers/update_overlays()
	. = ..()
	if(num_overlays > 0)
		var/step = max_bullets/num_overlays
		if(bullet_count)
			var/image/I = new/image(icon,"bullet_[CEILING(bullet_count/step,1)]")
			add_overlay(I)

/obj/item/clothing/belt/bandoliers/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,bullet_type))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		var/obj/item/bullet_cartridge/C = object

		if(caller.attack_flags & CONTROL_MOD_DISARM)
			if(!stored_bullets[C.type])
				caller.to_chat(span("warning","There are no charges of that type left in \the [src.name]!"))
				return TRUE
			var/amount_added = C.add_item_count(1)
			if(amount_added)
				stored_bullets[C.type] -= amount_added
				if(stored_bullets[C.type] <= 0)
					stored_bullets -= C.type
				bullet_count -= amount_added
				caller.to_chat(span("notice","You add a charge to your hand. There are [stored_bullets[C.type]] charges of that type left."))
				update_sprite()
		else
			var/amount_added = -C.add_item_count(-min(C.amount,max(0,max_bullets - bullet_count)))
			if(amount_added)
				if(!stored_bullets[C.type])
					stored_bullets[C.type] = amount_added
				else
					stored_bullets[C.type] += amount_added
				bullet_count += amount_added
				update_sprite()
		return TRUE

	if(istype(object,/obj/item/bullet_cartridge)&&!istype(object,stored_bullets))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		caller.to_chat(span("warning","This type of bullet won't fit into the [src.name]!"))
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		if(!length(stored_bullets))
			caller.to_chat(span("warning","There are no bullets left!"))
			return TRUE

		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/C = pickweight(stored_bullets)
		if(!C)
			C = initial(bullet_type)
		C = new C(get_turf(src))
		var/amount_to_grab = 1
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			amount_to_grab = min(stored_bullets[C.type],C.amount_max)
		C.amount = amount_to_grab
		stored_bullets[C.type] -= amount_to_grab
		bullet_count -= amount_to_grab
		caller.to_chat(span("notice","You take [amount_to_grab] bullet\s from \the [src.name]. There are [stored_bullets[C.type]] bullets of that type left."))
		if(stored_bullets[C.type] <= 0)
			stored_bullets -= C.type
		INITIALIZE(C)
		FINALIZE(C)
		I.add_object(C)
		update_sprite()
		return TRUE

	. = ..()

/obj/item/clothing/belt/bandoliers/proc/take_bullet(var/mob/caller,var/obj/hud/inventory/I)//This proc is for the AI to be able to use bullets from the bag
	if(!length(stored_bullets))
		caller.to_chat(span("warning","There are no charges left!"))
		return FALSE
	var/obj/item/bullet_cartridge/C = pickweight(stored_bullets)
	C = new C(get_turf(src))
	C.amount = 1
	stored_bullets[C.type] -= 1
	caller.to_chat(span("notice","You take 1 charge from \the [src.name]. There are [stored_bullets[C.type]] charges left."))
	if(stored_bullets[C.type] <= 0)
		stored_bullets -= C.type
	INITIALIZE(C)
	FINALIZE(C)
	I.add_object(C)
	update_sprite()
	return TRUE
