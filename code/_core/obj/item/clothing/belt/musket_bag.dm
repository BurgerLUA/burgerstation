/obj/item/clothing/belt/musket_bag
	name = "musket bag"
	desc = "It's called a POWDER HORN, okay?"
	desc_extended = "A nerdy bag and nerdy horn for nerds that need to hold more ammo for flintlocks (You know who you are). ALT+Click to grab additional charges while already holding a charge."

	icon = 'icons/obj/item/clothing/belts/musket_bag.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT_OVER
	dyeable = FALSE


	value = 0
	size = SIZE_3

	var/charge_count = 0
	var/max_charges = 100
	var/charge_type = /obj/item/bullet_cartridge/flintlock

	var/next_regen = 0 //Ammo restocking functionality woo!

/obj/item/clothing/belt/musket_bag/get_base_value()
	return max_charges*3

/obj/item/clothing/belt/musket_bag/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("charge_count")

/obj/item/clothing/belt/musket_bag/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("charge_count")

/obj/item/clothing/belt/musket_bag/Finalize()
	. = ..()
	update_sprite()

/obj/item/clothing/belt/musket_bag/update_icon()
	. = ..()
	icon_state_worn = initial(icon_state_worn)
	if (charge_count > 0)
		icon_state = "full"
	else
		icon_state = "inventory"

/obj/item/clothing/belt/musket_bag/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/flintlock))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		var/obj/item/bullet_cartridge/flintlock/C = object
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			if(charge_count <= 0)
				caller.to_chat(span("warning","There are no charges left in \the [src.name]!"))
				return TRUE
			var/amount_added = C.add_item_count(1)
			if(amount_added)
				charge_count -= amount_added
				update_sprite()
		else
			var/amount_added = -C.add_item_count(-min(C.amount,max(0,max_charges - charge_count)))
			if(amount_added)
				if(charge_count <= 0)
					charge_count = amount_added
				else
					charge_count += amount_added
				update_sprite()
		return TRUE


	if(istype(object,/obj/item/bullet_cartridge)&&!istype(object,charge_type))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		caller.to_chat(span("warning","This bullet doesn't fit!"))
		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		if(charge_count <= 0)
			caller.to_chat(span("warning","There are no charges left!"))
			return TRUE

		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/C = /obj/item/bullet_cartridge/flintlock
		C = new C(get_turf(src))
		var/amount_to_grab = 1
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			amount_to_grab = min(charge_count,C.amount_max)
		C.amount = amount_to_grab
		charge_count -= amount_to_grab
		caller.to_chat(span("notice","You take [amount_to_grab] charge\s from \the [src.name]. There are [charge_count] charges left."))
		INITIALIZE(C)
		FINALIZE(C)
		I.add_object(C)
		update_sprite()
		return TRUE

/obj/item/clothing/belt/musket_bag/proc/take_charge(var/mob/caller,var/obj/hud/inventory/I)
	if(charge_count <= 0)
		caller.to_chat(span("warning","There are no charges left!"))
		return FALSE
	var/obj/item/bullet_cartridge/C = /obj/item/bullet_cartridge/flintlock
	C = new C(get_turf(src))
	C.amount = 1
	caller.to_chat(span("notice","You take 1 charge from \the [src.name]. There are [charge_count] charges left."))
	INITIALIZE(C)
	FINALIZE(C)
	I.add_object(C)
	update_sprite()
	return TRUE
