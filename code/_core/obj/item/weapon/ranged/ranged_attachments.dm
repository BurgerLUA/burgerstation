/obj/item/weapon/ranged/proc/add_attachment(var/mob/activator,var/obj/item/attachment/A)

	if(!length(attachment_whitelist))
		activator.to_chat(span("warning","This weapon does not accept attachments!"))
		return FALSE

	if(!attachment_whitelist[A.type])
		activator.to_chat(span("warning","\The [A.name] cannot fit on \the [src.name]!"))
		return FALSE

	var/list/type_to_var = list(
		/obj/item/attachment/barrel/ = "attachment_barrel",
		/obj/item/attachment/sight/ = "attachment_sight",
		/obj/item/attachment/undermount/ = "attachment_undermount",
		/obj/item/attachment/stock = "attachment_stock",
		/obj/item/attachment/barrel_mod = "barrel_mod",
		/obj/item/attachment/stock_mod = "stock_mod"
	)

	for(var/k in type_to_var)
		var/v = type_to_var[k]
		if(!istype(A,k))
			continue
		var/obj/hud/inventory/INV
		var/obj/item/I
		if(vars[v])
			I = vars[v]
			activator.visible_message(span("notice","\The [activator.name] swaps out \the [I.name] on \the [src.name] for \the [A.name]."),span("notice","You swap out \the [A.name] on \the [src.name] for \the [I.name]."))
			I.drop_item(get_turf(src))
			vars[v] = null
			if(is_inventory(A.loc))
				INV = A.loc
		else
			activator.visible_message(span("notice","\The [activator.name] attaches \the [A.name] to \the [src.name]."),span("notice","You attach \the [A.name] to \the [src.name]."))
		A.drop_item(src)
		vars[v] = A
		update_sprite()
		update_attachment_stats()
		if(I && INV)
			INV.add_object(I)
		return TRUE

	return FALSE

/obj/item/weapon/ranged/proc/remove_attachment(var/mob/activator)

	var/list/attachment_variables = list(
		"attachment_barrel",
		"attachment_sight",
		"attachment_undermount",
		"attachment_stock",
		"barrel_mod",
		"stock_mod"
	)

	var/list/choice_list = list()
	for(var/k in attachment_variables)
		if(!vars[k])
			continue
		var/obj/item/attachment/A = vars[k]
		if(!A.removable)
			continue
		choice_list[A.name] = k

	if(!length(choice_list))
		return FALSE

	choice_list["Cancel"] = "Cancel"

	var/attachment_choice = input("What would you like to remove?","Attachment Removal") as null|anything in choice_list
	if(!attachment_choice || attachment_choice == "Cancel")
		activator.to_chat(span("notice","You decide not to remove anything."))
		return FALSE

	attachment_choice = choice_list[attachment_choice]

	var/obj/item/I = vars[attachment_choice]

	activator.visible_message(span("notice","\The [activator.name] removes \the [I.name] from \the [src.name]."),span("notice","You remove \the [I.name] from \the [src.name]."))
	I.drop_item(get_turf(src))
	vars[attachment_choice] = null
	update_sprite()
	update_attachment_stats()
	return I

/obj/item/weapon/ranged/proc/update_attachment_stats()

	attachment_stats = list()

	var/list/attachment_variables = list(
		"attachment_barrel",
		"attachment_sight",
		"attachment_undermount",
		"attachment_stock",
		"barrel_mod",
		"stock_mod"
	)

	var/list/modifier_count = list()

	for(var/i in attachment_variables)
		var/obj/item/attachment/A = vars[i]
		if(!A) continue
		for(var/k in A.attachment_stats)
			var/v = A.attachment_stats[k]
			attachment_stats[k] += v
			if(isnum(v)) modifier_count[k] += 1

	for(var/k in modifier_count)
		attachment_stats[k] *= (1/modifier_count[k])

	return TRUE


/obj/item/weapon/ranged/get_examine_list(var/mob/activator)

	. = ..()

	for(var/k in attachment_stats)
		var/v = attachment_stats[k]
		. += span("notice","[k]: [v]")

