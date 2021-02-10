/obj/structure/interactive/fax_machine
	name = "fax machine"
	desc = "The cheapest way to send data!"
	desc_extended = "An outdated relic of the past still being used today. It doesn't appear to be functional."

	icon = 'icons/obj/structure/fax.dmi'
	icon_state = "idle"

	var/processing = FALSE

	var/obj/item/paper/stored_paper

	pixel_y = 4

/obj/structure/interactive/fax_machine/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/hud/inventory/I = object
		if(stored_paper)
			if(processing)
				caller.to_chat(span("warning","\The [src.name] is too busy processing!"))
				return TRUE
			if(I.add_object(stored_paper))
				visible_message(span("notice","\The [caller.name] picks up \the [stored_paper.name] from \the [src.name]."),span("notice","You pick up \the [stored_paper.name] from \the [src.name]."))
				stored_paper = null
				update_sprite()
		else
			caller.to_chat(span("warning","\The [src.name] is empty!"))
		return TRUE

	if(is_paper(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)

		if(stored_paper)
			caller.to_chat(span("warning","\The [src.name] already has paper inside!"))
			return TRUE

		var/obj/item/paper/P = object

		if(!length(P.data))
			caller.to_chat(span("warning","\The [src.name] rejects the blank [P.name]!"))
			return TRUE

		if(P.icon != 'icons/obj/item/paper.dmi')
			caller.to_chat(span("warning","\The [P.name] is too big to be put in \the [src.name]."))
			return TRUE

		P.drop_item(src)
		stored_paper = P
		processing = TRUE
		update_sprite()
		process_data(caller,P.data)
		CALLBACK("finish_processing_\ref[src]",SECONDS_TO_DECISECONDS(5),src,.proc/finish_processing,caller)

		return TRUE

	return ..()

/obj/structure/interactive/fax_machine/update_icon()
	if(stored_paper)
		if(processing)
			icon_state = "send"
		else
			icon_state = "receive"
	else
		icon_state = "idle"
	return ..()


/obj/structure/interactive/fax_machine/proc/process_data(var/mob/caller,var/list/data_to_process = list())
	return TRUE

/obj/structure/interactive/fax_machine/proc/finish_processing(var/mob/caller)
	processing = FALSE
	update_sprite()
	return TRUE

/obj/structure/interactive/fax_machine/cargo/process_data(var/mob/caller,var/list/data_to_process = list())

	var/list/required_data = list(
		"Requisitioner's Name", //Real-name of the player. It's basically a lock saying only this person can open it. Leave blank for anyone to open.
		"Item ID", //The unique item ID of the item you're ordering.
		"Quantity" //How much of this item you want.
	)

	var/list/found_data = list()
	if(length(data_to_process))
		for(var/line in splittext(data_to_process[1],"\n"))
			var/list/split_line = splittext(line,":")
			if(length(split_line) < 2)
				continue
			var/found_pos = required_data.Find(split_line[1])
			if(!found_pos)
				continue
			var/desired_key = split_line[1]
			var/desired_value = trim(copytext(line,length(desired_key)+2,0))
			found_data[desired_key] = trim(desired_value)

	var/real_quantity = found_data["Quantity"] ? clamp(text2num(found_data["Quantity"]),0,10) : 0
	if(length(found_data) && found_data["Requisitioner's Name"] && found_data["Item ID"] && real_quantity)
		var/atom/movable/stored_item = SScargo.cargo_id_to_type[found_data["Item ID"]]
		if(!stored_item)
			return ..()
		var/obj/marker/cargo/C = locate() in world
		var/obj/structure/interactive/crate/secure/cargo/SC = new(get_turf(C))
		INITIALIZE(SC)
		FINALIZE(SC)
		for(var/i=1,i<=real_quantity,i++)
			var/atom/movable/M = new stored_item.type(SC)
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			M.force_move(SC)

		SC.close()
		SC.lock()
		SC.owner_name = "[found_data["Requisitioner's Name"]]"
		SC.name = "secure cargo crate ([SC.owner_name] [found_data["Item ID"]])"
		SC.credits_required = SC.get_value()
		SC.force_move(SC.loc)

	return ..()