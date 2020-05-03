/client/Topic(href,href_list,hsrc)

	if(!usr || usr != mob)
		return

	if(findtext(href,"<script",1,0))
		LOG_ADMIN("Attempted use of scripts within a topic call, by [src]/[usr].")
		return

	/*
	if(next_allowed_topic > world.time)
		to_chat(span("danger","You're sending information too fast! Please wait [next_allowed_topic - world.time] second\s!"))
		return FALSE
	*/

	/*
	if(length(href_list) > 32)
		to_chat(span("danger","No."))
		return FALSE

	if(length(href) > 1000)
		to_chat(span("danger","No!"))
		return FALSE
	*/

	if(length(href_list))
		if(href_list["change_key"])
			//Changing Macros
			var/key = href_list["change_key"]
			if(key == "quit")
				var/confirm = input("Are you sure you want to quit? All unsaved changes will be lost.","Quit Macro Editor","No") in list("Yes","No","Cancel")
				if(confirm == "Yes")
					winset(usr, "browser(edit_macros)","is-visible:false")
			else if(key == "load")
				var/confirm = input("Are you sure you want to clear your changes?","Clear Changes","No") in list("Yes","No","Cancel")
				if(confirm == "Yes")
					macros.macros = controls.loaded_data
			else if(key == "save")
				var/confirm = input("Are you sure you want to save your macros, overwriting saved data?","Save Macros","No") in list("Yes","No","Cancel")
				if(confirm == "Yes")
					controls.loaded_data = macros.macros
					controls.save()
			else if(key == "reset")
				var/confirm = input("Are you sure you want to reset your macros?","Reset Macros","No") in list("Yes","No","Cancel")
				if(confirm == "Yes")
					macros.macros = DEFAULT_MACROS
					to_chat(span("notice","Successfully reset macros."))
			else if(key == "new")
				var/new_key = input("What would you like the new key to be? Leave blank to cancel.","New Key Bind") as text | null
				if(new_key)
					var/new_command = input("What would you like the new command to be? Leave blank to cancel.","New Command Bind") as text | null
					if(new_command)
						macros.macros[new_key] = new_command
						to_chat(span("notice","Successfully added new command '[new_command]' to key '[new_key]'"))
			else
				var/new_command = input("What command would you like to bind '[key]' to? Leave blank to cancel.","Change Existing Bind") as text | null
				if(new_command)
					macros.macros[key] = new_command
					to_chat(span("notice","Successfully added '[new_command]' to '[key]'."))

			if(key != "quit")
				edit_macros()













		/*
		if(href_list["chat_examine"])
			var/datum/actual_reference = locate(href_list["chat_examine"])

			if(is_client(actual_reference))


			else if(is_atom(actual_reference))

		*/

		/*
		if(href_list["var_edit_ref"])
			var/datum/actual_reference = locate(href_list["var_edit_ref"])
			if(actual_reference)
				var_edit(actual_reference)

		if(href_list["var_edit_other"] && href_list["var_edit_other_ref"])
			var/datum/actual_reference = locate(href_list["var_edit_other_ref"])
			var/actual_key = href_list["var_edit_other"]

			if(actual_reference && actual_key && actual_reference.vars[actual_key])

				var/current_value = actual_reference.vars[actual_key]

				if(current_value)

					spawn()
						var/new_value = null

						if(isnum(current_value))
							new_value = input("Desired Number") as num|null

						else if(istext(current_value))
							new_value = input("Desired Number") as text|null

						if(new_value)
							change_variable(actual_reference,actual_key,new_value)
			*/

		if(href_list["done_loading"])
			send_load(src.mob,href_list["done_loading"])

	. = ..()

	next_allowed_topic = world.time + 1

	return .