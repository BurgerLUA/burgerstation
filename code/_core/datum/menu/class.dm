/menu/class/
	name = "Class Editor"
	id = "class_editor"
	file = 'html/chargen_class.html'
	resources = list(
		"button_blue.png" = 'html/button_blue.png',
		"button_blue_extended.png" = 'html/button_blue_extended.png',
		"button_grey.png" = 'html/button_grey.png',
		"tile.png" = 'html/tile.png'
	)
	size = "800x800"

/menu/class/open(var/mob/user)
	cache_resources(user)
	winclone(user, "window", id)
	winset(user, "browser([id])", "parent=map;type=browser;size=0x0;anchor1=0,0;anchor2=100,100;is-visible=true")
	user << output(file, "browser([id])")

/menu/class/on_load(var/mob/user)

	if(!is_advanced(user))
		return FALSE

	var/mob/living/advanced/A = user

	A.stun_time = -1
	A.paralyze_time = -1

	run_function(user,"set_reference","'\ref[src]'")

	for(var/skill_id in A.skills) //TODO: Make this just one function for each skill/attribute
		var/experience/skill/S = A.skills[skill_id]
		run_function(user,"set_description","'[skill_id]','[html_encode(S.name)]','[html_encode(S.desc)]'")
		run_function(user,"generate_min","'[skill_id]',[S.chargen_min_level]")
		run_function(user,"generate_max","'[skill_id]',[S.chargen_max_level]")
		run_function(user,"generate_value","'[skill_id]',[S.get_current_level()],'skill'")

	for(var/attribute_id in A.attributes)
		var/experience/attribute/AT = A.attributes[attribute_id]
		run_function(user,"set_description","'[attribute_id]','[html_encode(AT.name)]','[html_encode(AT.desc)]'")
		run_function(user,"generate_min","'[attribute_id]',[AT.chargen_min_level]")
		run_function(user,"generate_max","'[attribute_id]',[AT.chargen_max_level]")
		run_function(user,"generate_value","'[attribute_id]',[AT.get_current_level()],'attribute'")

	run_function(user,"set_attribute_allocation","[DEFAULT_ATTRIBUTE_ALLOCATION]")
	run_function(user,"set_skill_allocation","[DEFAULT_SKILL_ALLOCATION]")
	run_function(user,"update_values")

/menu/class/Topic(href,href_list)

	if(!href_list["command"])
		return FALSE

	if(!is_advanced(usr))
		return FALSE

	var/mob/living/advanced/A = usr

	if(href_list["command"] == "getjob")

		var/list/clean = list()

		for(var/k in href_list)
			if(k == "src" || k == "command")
				continue
			clean[k] = text2num(href_list[k])

		var/selected_job = calculate_class(A,clean)

		run_function(A,"set_job","'[selected_job]'")

	else if(href_list["command"] == "submit")

		if(!A.chargen)
			return FALSE

		A.chargen = FALSE

		for(var/k in href_list)
			if(k == "src") //Ignore
				continue
			var/v = text2num(href_list[k])

			if(A.attributes[k])
				var/experience/attribute/AT = A.attributes[k]
				AT.set_level(v)
				//usr << "Setting [AT.name] to [v]."
				continue

			if(A.skills[k])
				var/experience/skill/S = A.skills[k]
				S.set_level(v)
				//usr << "Setting [S.name] to [v]."
				continue

		stop_sound('sounds/music/menu/chargen.ogg',list(usr))

		if(!A.client)
			return