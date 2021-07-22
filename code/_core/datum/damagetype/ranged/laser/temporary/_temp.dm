/obj/item/weapon/ranged/energy/temporary //please, forgive me...
	charge_cost = 100
	battery = /obj/item/powercell/dummy
	size = 777 //good luck putting this anywhere
	value = -9999 //An inelegant solution, but if you somehow manage to sell this, you shouldn't profit. But if you end up losing money anyway, let a coder know.
	value_burgerbux = 1 //as funny as it would be to find this in the trash, if this somehow ends up in a vendor there would be Consequences.
	
	throwable = FALSE //lazy solution. Throwing still deletes guns, but this prevents errors.

/obj/item/weapon/ranged/energy/temporary/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","There's nothing to pry out!"))
			else
				caller.to_chat(span("warning","There's literally nothing in the gun. Someone should fix this."))
				log_error("FOR SOME REASON, [src.type] HAS NO BATTERY. I'M SORRY!")
			return TRUE

	. = ..()

/obj/item/weapon/ranged/energy/temporary/Generate()
	if(!use_loyalty_tag && ispath(firing_pin))
		firing_pin = new firing_pin(src)
		INITIALIZE(firing_pin)
		GENERATE(firing_pin)
		FINALIZE(firing_pin)
	return ..()

/obj/item/weapon/ranged/energy/temporary/on_drop()
	Destroy()

/obj/item/weapon/ranged/energy/temporary/handle_empty()
	Destroy()
