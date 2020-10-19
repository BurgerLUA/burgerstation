/client/verb/ban(var/target_ckey as text,var/ban_duration_minutes = -1 as num, var/ban_reason = "No reason given." as message)

	set name = "Ban ckey"
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



/client/verb/force_random_event()
	set name = "Force Random Event"
	set category = "Admin"

	var/confirm = input("Are you sure you want to trigger a random event?","Random Event Trigger.") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	SSevents.next_event_time = 0

/client/verb/get_players()
	set name = "Get Players"
	set category = "Admin"

	for(var/k in all_clients)
		var/client/C = all_clients[k]
		src.to_chat(C.get_debug_name())

	return TRUE


/client/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "Spawn Object"
	set desc = "Spawn an object."
	set category = "Debug"

	if(!object)
		return FALSE

	if(object[1] != "/")
		object = "/" + object

	var/last_checker = copytext(object,-1,0)
	if(last_checker == "/")
		object = copytext(object,1,-1)

	var/valid_path = text2path(object)

	if(!valid_path)
		usr.to_chat("\"[object]\" isn't a valid path.")
		return FALSE

	var/list/valid_objects = typesof(valid_path)

	var/valid_count = length(valid_objects)

	if(!valid_count)
		usr.to_chat("\"[object]\" returned no valid types.")
		return FALSE

	if(valid_count == 1)
		var/datum/A = valid_objects[1]
		A = new A(usr.loc)
		INITIALIZE(A)
		GENERATE(A)
		FINALIZE(A)
		return TRUE

	var/selection = input("Spawn object.","Spawn object") as null|anything in valid_objects

	if(selection)
		var/datum/A = selection
		A = new A(usr.loc)
		INITIALIZE(A)
		FINALIZE(A)
		if(isobj(A))
			var/obj/O = A
			GENERATE(O)
		return TRUE

/client/verb/change_variable(var/datum/object as anything, var/desired_varable_key as text, var/desired_varable_value as anything)
	set name = "Change Variable"
	set category = "Admin"

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

/client/verb/add_new_wikibot_entry(var/wikibot_question as text,var/wikibot_answer as text)
	set category = "Admin"
	set name = "Add New Wikibot Entry"

	if(!wikibot_question || !wikibot_answer)
		return FALSE

	var/list/new_question_keys = splittext(wikibot_question," ")

	if(SSwikibot)
		SSwikibot.add_new_wikibot_key(new_question_keys,wikibot_answer)

/client/verb/var_edit(var/object as anything in view())
	set name = "Variable Edit"
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


/client/verb/smite_living()

	set name = "Smite Living"
	set category = "Admin"

	var/list/valid_targets = list()

	for(var/k in all_players)
		valid_targets += k

	for(var/mob/living/L in view(src.mob,VIEW_RANGE))
		valid_targets |= L

	var/mob/living/L = input("What do you wish to crush?","Crush Target") as null|anything in valid_targets

	if(!L) return FALSE

	var/confirm = input("Are you sure you want to crush [L.name]? This will kill them instantly...","Cursh Confirmation","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confirm != "Yes") return FALSE

	var/turf/T = get_turf(L)
	play('sound/meme/cbt.ogg',T)
	CALLBACK("\ref[L]_smite",15,L,/mob/living/proc/smite)


/mob/living/proc/smite()
	var/turf/T = get_turf(src)
	new/obj/effect/temp/fist(T,4,"#FFFFFF")
	play('sound/effects/anima_fragment_attack.ogg',T)
	on_crush()