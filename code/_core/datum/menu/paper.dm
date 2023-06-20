/menu/paper/
	file = "html/paper.html"
	resources = list(
		"markdown.js" = 'html/markdown.js'
	)

/menu/paper/open(var/mob/user)
	winset(user, "map.paper","is-visible=true")
	sleep(1)
	user << output(file, "map.paper")

/menu/paper/on_load(var/mob/user)

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	if(!P.active_paper)
		log_error("Warning: Tried loading an active paper for [P.get_debug_name()] when they didn't have any active paper set!")
		return FALSE

	if(!length(P.active_paper.data))
		log_error("Warning: Tried loading an active paper for [P.get_debug_name()] when [P.active_paper.get_debug_name()] didn't have any paper data!")
		return FALSE

	run_function(P,"set_reference",list2params(list("\ref[src]")))

	set_text(P,P.active_paper.data[P.active_paper.last_page],P.active_paper.name,P.active_paper.last_page,length(P.active_paper.data),P.active_paper.editable)

/menu/paper/close(var/mob/user)
	winset(user,"map.paper","is-visible=false")
	winset(user,"map.map","focus=true")
	winset(user,"control.input","focus=false")

/menu/paper/proc/set_text(var/mob/user,var/text,var/title,var/page_current,var/page_max,var/editable=FALSE)

	var/function_name = "set_text"
	var/function_args = list2params(list(text,title,page_current,page_max,editable))

	run_function(user,function_name,function_args)
	if(is_player(user))
		var/mob/living/advanced/player/P = user
		if(P.active_paper)
			P.active_paper.last_page = page_current

/menu/paper/run_function(var/mob/user, var/function_name,var/args)
	user << output(args, "map.paper:[function_name]")

/menu/paper/Topic(href,href_list)

	if(href_list && is_player(usr))

		var/mob/living/advanced/player/P = usr

		if(href_list["change_page"])
			var/desired_page = clamp(text2num(href_list["change_page"]),1,length(P.active_paper.data))
			set_text(P,P.active_paper.data[desired_page],P.active_paper.name,desired_page,length(P.active_paper.data),P.active_paper.editable)

		if(href_list["close"])
			close_menu(P,/menu/paper/)
			P.active_paper = null

		if(href_list["edit"])
			if(!P.active_paper.editable)
				P.to_chat(span("notice","\The [P.active_paper.name] cannot be modifed!"))
			else
				var/desired_page = clamp(text2num(href_list["edit"]),1,length(P.active_paper.data))
				var/desired_new_text = input(P,"What should the text say?","Edit Text",P.active_paper.data[desired_page]) as message
				if(P.active_paper && desired_new_text && length(desired_new_text))
					var/regex/link_remover = new("\\\[.*\\\]\\(.*\\)","g")
					desired_new_text = link_remover.Replace(desired_new_text,"")

					var/regex/link_remover_2 = new("http.*:\\/\\/","g")
					desired_new_text = link_remover_2.Replace(desired_new_text,"")

					var/regex/link_remover_3 = new("www\\.","g")
					desired_new_text = link_remover_3.Replace(desired_new_text,"")

					desired_new_text = police_text(P.client,desired_new_text,min_length=0,max_length=3000,extra=FALSE)

					if(desired_new_text && length(desired_new_text))
						P.active_paper.data[desired_page] = desired_new_text
						set_text(P,P.active_paper.data[desired_page],P.active_paper.name,desired_page,length(P.active_paper.data),P.active_paper.editable)

	return ..()