/client/verb/adminhelp(var/text_to_say as message)
	set name = "Adminhelp"
	set category = "Admin"

	if(!text_to_say)
		text_to_say = input("adminhelp") as message

	text_to_say = police_text(src,text_to_say,check_characters=TRUE)

	if(!text_to_say)
		return FALSE

	var/tickets_open = length(ckey_to_tickets[ckey])

	if(tickets_open)
		var/desired_input = input("You already have [tickets_open] ticket(s) open. Do you wish to create a new ticket or respond to an existing ticket?","Multiple Tickets","Cancel") as null|anything in list("Create New Ticket","Respond to Existing Ticket","Cancel")
		if(desired_input == "Respond to Existing Ticket")
			src.to_chat(span("ahelp","Click on an active ticket below to respond to it."))
			for(var/k in ckey_to_tickets[ckey])
				var/ticket/T = k
				src.to_chat(span("ahelp","<a href='?src=\ref[T];password=[T.password]'>ticket (#[T.ticket_number])</a>"))
			return TRUE
		if(!desired_input || desired_input == "Cancel")
			return TRUE

	var/ticket/T = new
	T.open(src,text_to_say,TRUE)

/client/verb/bwoink(var/ckey_to_bwoink as text, var/bwoink_message as message)
	set name = "Bwoink"
	set category = "Admin"

	if(!ckey_to_bwoink)
		var/list/valid_ckeys = list()
		for(var/k in all_clients)
			valid_ckeys += k
		ckey_to_bwoink = input("Who do you want to bwoink?","Bwoink Player") as null|anything in valid_ckeys

	if(!ckey_to_bwoink)
		src.to_chat(span("warning","Invalid ckey!"))
		return FALSE

	if(!bwoink_message)
		bwoink_message = input("Bwoink") as message

	bwoink_message = police_text(src,bwoink_message,check_characters=TRUE)

	if(!bwoink_message)
		src.to_chat(span("warning","Invalid message!"))
		return FALSE

	var/ticket/T = new
	T.open(src,bwoink_message,FALSE)
	T.join(CLIENT(ckey_to_bwoink),TRUE)

/client/verb/ban()

	set name = "Ban"
	set category = "Admin"

	var/list/possible_ckeys = list()

	possible_ckeys["Custom..."] = null
	possible_ckeys["Cancel"] = null

	for(var/k in all_mobs_with_clients)
		var/mob/M = k
		if(!M.ckey_last)
			continue
		possible_ckeys["[M.name] ([M.ckey_last])"] = M.ckey_last

	var/desired_ckey = input("Who do you wish to ban?","Ban Player","Cancel") as null|anything in possible_ckeys

	if(desired_ckey == "Custom...")
		desired_ckey = input("Please enter the Ckey you wish to ban.","Custom Ckey") as null|text
	else if(desired_ckey)
		desired_ckey = possible_ckeys[desired_ckey]

	if(!desired_ckey)
		src.to_chat(span("notice","You decide not to ban anyone."))
		return TRUE

	var/ban_durations = list(
		"One Hour" = 60,
		"Twelve Hours" = 60*12,
		"One Day" = 60*24,
		"Three Days" = 60*24*3,
		"One Week" = 60*24*7,
		"One Month" = 60*24*31,
		"One Year" = 60*24*365,
		"Forever" = -1,
		"Custom..." = "Custom",
		"Cancel" = null
	)

	var/desired_ban_duration = input("How long would you like to ban [desired_ckey] for?","Ban Duration","Cancel") as null|anything in ban_durations

	if(desired_ban_duration == "Custom...")
		desired_ban_duration = input("Please enter the ban duration, in minutes, that you'd like to ban for.","Custom Ban Duration",60*24) as num|null
	else if(desired_ban_duration)
		desired_ban_duration = ban_durations[desired_ban_duration]

	if(!desired_ban_duration)
		src.to_chat(span("notice","You decide not to ban anyone."))
		return TRUE

	var/desired_ban_reason = input("What is the ban reason?","Ban Reason","No reason specified.") as null|message

	if(!desired_ban_reason)
		src.to_chat(span("notice","You decide not to ban anyone."))
		return TRUE

	if(ban_raw(desired_ckey,desired_ban_duration,desired_ban_reason))
		src.to_chat(span("notice","Ban successfully applied."))
	else
		src.to_chat(span("warning","There was an issue applying a ban."))

	return TRUE

/client/proc/ban_raw(var/target_ckey as text,var/ban_duration_minutes = -1 as num, var/ban_reason = "No reason given." as message)

	ban_duration_minutes = text2num(ban_duration_minutes)

	if(!ban_duration_minutes)
		return FALSE

	if(!SSban)
		return FALSE

	if(!target_ckey)
		return FALSE

	return SSban.add_ckey_ban(target_ckey,ckey,ban_reason,ban_duration_minutes == -1 ? -1 : world.realtime + ban_duration_minutes*60)

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
			if(!isnum(desired_varable_value))
				return FALSE
		else if(istext(object.vars[desired_varable_key]))
			desired_varable_value = input("Desired Text") as text|null
			if(!desired_varable_value)
				return FALSE

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key)
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
		to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(mob)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	choice.force_move(T)

	to_chat(span("notice","You brought \the [choice.name] to you."))
	log_admin("[src] brought [choice] to their location.")


/client/verb/apply_fuckup()
	set name = "Apply Fuckup (DANGER)"
	set category = "Admin"

	var/list/valid_fuckups = list()
	for(var/k in SSfuckup.all_fuckups)
		var/fuckup/FU = k
		valid_fuckups[FU.name] = FU

	valid_fuckups["Cancel"] = "Cancel"

	var/fuckup_choice = input("What fuckup would you like to apply?","Fuckup","Cancel") as null|anything in valid_fuckups

	if(!fuckup_choice || fuckup_choice == "Cancel")
		return TRUE

	var/confirm = input("Are you absolutely sure you wish to apply this fuckup? Type \"Confirm\" to confirm.") as null|text
	if(confirm != "Confirm")
		return TRUE

	src.to_chat(span("notice","Applying [fuckup_choice] fuckup..."))

	var/fuckup/FU = valid_fuckups[fuckup_choice]

	SSfuckup.apply_fuckup(FU)