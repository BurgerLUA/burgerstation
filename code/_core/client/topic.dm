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