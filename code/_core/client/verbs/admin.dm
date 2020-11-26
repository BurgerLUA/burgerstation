/client/verb/ban(var/target_ckey as text,var/ban_duration_minutes = -1 as num, var/ban_reason = "No reason given." as message)

	set name = "Ban Ckey"
	set category = "Admin"

	ban_duration_minutes = text2num(ban_duration_minutes)

	if(!ban_duration_minutes)
		return FALSE

	if(!SSban)
		return FALSE

	if(!target_ckey)
		return FALSE

	SSban.add_ckey_ban(target_ckey,ckey,ban_reason,ban_duration_minutes == -1 ? -1 : world.realtime + ban_duration_minutes*60)
	return TRUE

/client/verb/get_clients()
	set name = "Get Clients"
	set category = "Admin"

	for(var/k in all_clients)
		var/client/C = all_clients[k]
		src.to_chat(C.get_debug_name())

	return TRUE

/client/verb/change_variable(var/datum/object as anything, var/desired_varable_key as text, var/desired_varable_value as anything)
	set name = "Change Variable"
	set category = "Admin"
	set hidden = TRUE

	if(!object)
		return FALSE

	if(!desired_varable_key)
		return FALSE

	if(!desired_varable_value)
		if(isnum(object.vars[desired_varable_key]))
			desired_varable_value = input("Desired Number") as num|null

		else if(istext(object.vars[desired_varable_key]))
			desired_varable_value = input("Desired Number") as text|null

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key && desired_varable_value)
		object.vars[desired_varable_key] = desired_varable_value
		var_edit(object)

/client/verb/var_edit(var/object as anything in view())
	set name = "VarEdit"
	set category = "Admin"

	if(!object)
		return FALSE

	if(is_datum(object))

		var/datum/D = object

		var/returning_text = "<br><center>[object]</center>"

		for(var/k in D.vars)

			if(k == "vars" || k == "verbs")
				continue

			var/v = D.vars[k]
			var/line_text = "[k] = [get_value_text_for_debug(D,k,v)]"
			returning_text += "[line_text]<br>"

		src << browse("<head><style>[STYLESHEET]</style></head><body style='font-size:75%'>[span("debug",returning_text)]</body>","window=help")


/client/verb/add_new_wikibot_entry(var/wikibot_question as text,var/wikibot_answer as text)
	set category = "Admin"
	set name = "Add New Wikibot Entry"

	if(!wikibot_question || !wikibot_answer)
		return FALSE

	var/list/new_question_keys = splittext(wikibot_question," ")

	if(SSwikibot)
		SSwikibot.add_new_wikibot_key(new_question_keys,wikibot_answer)


/client/verb/bring_player()
	set name = "Bring Player"
	set category = "Admin"

	sortTim(all_mobs_with_clients,/proc/cmp_path_asc)

	var/mob/choice = input("Who would you like to bring","Bring Mob") as null|mob in all_mobs_with_clients
	if(!choice)
		to_chat("Invalid choice.")
		return FALSE

	var/turf/T = get_turf(mob)
	if(!T)
		to_chat("Invalid turf.")
		return FALSE

	choice.force_move(T)

	to_chat(span("notice","You brought \the [choice.name] to you."))
	log_admin("[src] brought [choice] to their location.")