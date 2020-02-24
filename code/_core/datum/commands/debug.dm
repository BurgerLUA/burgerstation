/commands/debug/verb/add_new_wikibot_entry(var/wikibot_question as text,var/wikibot_answer as text)
	set category = "Debug"
	set name = "Add New Wikibot Entry"

	if(!wikibot_question || !wikibot_answer)
		return FALSE

	var/list/new_question_keys = splittext(wikibot_question," ")

	if(SSWikibot)
		SSWikibot.add_new_wikibot_key(new_question_keys,wikibot_answer)

/commands/debug/verb/print_garbage()

	set category = "Debug"
	set name = "Print Debug"

	if(!length(ref_id_to_warning))
		usr.to_chat("Nothing has been found in the garbage warning system.")
		return TRUE

	var/final_text = "<h1>Found [length(ref_id_to_warning)] objects that refuse to be deleted.</h1>"

	for(var/ref_id in ref_id_to_warning)
		var/warning_count = ref_id_to_warning[ref_id]
		var/o_type = qdel_refs_to_type[ref_id]
		var/var_edit_text = "<a href=?var_edit_ref=[ref_id]>[ref_id]</a>"
		final_text += "<br>[var_edit_text]([o_type]) = ~[warning_count] seconds"

	usr << browse("<head><style>[STYLESHEET]</style></head><body>[final_text]</body>","window=garbage")


/commands/debug/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "Spawn Object"
	set desc = "Spawn an object."
	set category = "Debug"

	if(!object)
		return FALSE

	if(object[1] != "/")
		object = "/" + object

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
		var/datum/A = valid_count[1]
		A = new A(usr.loc)
		if(isobj(A))
			var/obj/O = A
			O.on_spawn()
		return TRUE

	var/selection = input("Spawn object.","Spawn object") as null|anything in valid_objects

	if(selection)
		var/datum/A = selection
		A = new A(usr.loc)
		if(isobj(A))
			var/obj/O = A
			O.on_spawn()
		return TRUE

/commands/debug/verb/populate_world(var/number_to_create = 5 as num)

	set name = "Populate World"
	set category = "Debug"

	var/turf/simulated/floor/valid_floors = list()

	for(var/turf/simulated/floor/F in range(100,usr))
		var/valid_turf = TRUE
		for(var/atom/movable/A in F.contents)
			if(A.density)
				valid_turf = FALSE
				break

		if(!valid_turf)
			continue

		valid_floors += F

	number_to_create = Clamp(number_to_create,1,100)

	for(var/i=1,i<=number_to_create,i++)
		var/turf/T = pick(valid_floors)
		var/mob/living/advanced/player/debug/P = new(T)
		P.Initialize()
		step(P,pick(NORTH,EAST,SOUTH,WEST))



/commands/debug/verb/set_attribute(var/mob/mob as mob)

	set name = "Set Attribute Level"
	set category = "Debug"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.attributes)
		valid_choices += k

	var/chosen_attribute = input("Which attribute do you wish to modify?","Modify Attribute") as null|anything in valid_choices

	if(!chosen_attribute)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_attribute] to?","Modify Attribute") as num|null

	if(!chosen_value)
		return

	chosen_value = chosen_value

	L.set_attribute_level(chosen_attribute,chosen_value)

	L << "Your [chosen_attribute] is now [L.get_attribute_level(chosen_attribute)]."


/commands/debug/verb/set_skill(var/mob/mob as mob)

	set name = "Set Skill Level"
	set category = "Cheat"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.skills)
		valid_choices += k

	var/chosen_skill = input("Which skill do you wish to modify?","Modify Skill") as null|anything in valid_choices

	if(!chosen_skill)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_skill] to?","Modify Skill") as num|null

	if(!chosen_value)
		return

	chosen_value = chosen_value

	L.set_skill_level(chosen_skill,chosen_value)

	L << "Your [chosen_skill] is now [L.get_skill_level(chosen_skill)]."



/commands/debug/verb/change_variable(var/datum/object as anything in view(), var/desired_varable_key as text, var/desired_varable_value as anything)

	set name = "Change Variable"
	set category = "Debug"

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key && desired_varable_value)
		object.vars[desired_varable_key] = desired_varable_value


/commands/debug/verb/var_edit(var/object as anything in view())
	set name = "Variable Edit"
	set category = "Debug"

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

