/obj/item/weapon/ranged/proc/add_attachment(var/mob/caller,var/obj/item/attachment/A)

	if(!length(attachment_whitelist))
		caller.to_chat(span("notice","This weapon does not accept attachments!"))
		return FALSE

	if(!attachment_whitelist[A.type])
		caller.to_chat(span("notice","\The [A.name] cannot fit on \the [src.name]!"))
		return FALSE


	var/list/type_to_var = list(
		/obj/item/attachment/barrel/ = "attachment_barrel",
		/obj/item/attachment/sight/ = "attachment_sight",
		/obj/item/attachment/undermount/ = "attachment_undermount",
		/obj/item/attachment/stock = "attachment_stock"
	)

	for(var/k in type_to_var)
		if(!istype(A,k))
			continue
		if(vars[k])
			var/obj/item/I = vars[k]
			caller.to_chat(span("notice","There is already \a [I.name] attached to \the [src.name]!"))
			return FALSE
		caller.to_chat(span("notice","You attach \the [A.name] to \the [src.name]."))
		A.drop_item(src)
		vars[k] = A
		update_sprite()
		update_attachment_stats()
		return TRUE

	return FALSE

/obj/item/weapon/ranged/proc/remove_attachment(var/mob/caller)

	var/list/attachment_variables = list(
		"attachment_barrel",
		"attachment_sight",
		"attachment_undermount",
		"attachment_stock"
	)

	var/list/choice_list = list()
	for(var/k in attachment_variables)
		if(!vars[k])
			continue
		choice_list[vars[k].name] = k

	if(!length(choice_list))
		caller.to_chat(span("notice","There is nothing to remove from \the [src.name]!"))
		return FALSE

	var/attachment_choice = input("What would you like to remove?","Attachment Removal") as null|anything in choice_list
	if(!attachment_choice)
		caller.to_chat(span("notice","You decide not to remove anything."))
		return FALSE

	caller.to_chat(span("notice","You remove \the [vars[attachment_choice].name] from \the [src.name]."))
	vars[attachment_choice].drop_item(get_turf(src))
	vars[attachment_choice] = null
	update_sprite()
	update_attachment_stats()
	return TRUE

/obj/item/weapon/ranged/proc/update_attachment_stats()

	attachment_stats = list()

	var/list/attachment_variables = list(
		"attachment_barrel",
		"attachment_sight",
		"attachment_undermount",
		"attachment_stock"
	)

	for(var/i in attachment_variables)
		var/obj/item/attachment/A = vars[i]

		for(var/k in A.stats_attachment_set)
			var/v = A.stats_attachment_set[k]
			attachment_stats[k] = v

		for(var/k in A.stats_attachment_add)
			var/v = A.stats_attachment_add[k]
			attachment_stats[k] += v

		for(var/k in A.stats_attachment_mul)
			var/v = A.stats_attachment_mul[k]
			attachment_stats[k] *= v

	return TRUE