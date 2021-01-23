/menu/paper/
	file = 'html/paper.html'
	resources = list(
		"markdown.js" = 'html/markdown.js'
	)

/menu/paper/open(var/user)
	winset(user, "map.paper","is-visible=true")
	sleep(1)
	user << output(file, "map.paper")

/menu/paper/on_load(var/user)

	run_function(usr,"set_reference",list2params(list("\ref[src]")))

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	if(P.active_paper && length(P.active_paper.data))
		set_text(P,sanitize(P.active_paper.data[P.active_paper.last_page],3000,extra = FALSE),P.active_paper.name,P.active_paper.last_page,length(P.active_paper.data),P.active_paper.editable)

/menu/paper/close(var/user)
	winset(user,"map.paper","is-visible=false")
	winset(user,"map.map","focus=true")
	winset(user,"control.input","focus=false")

/menu/paper/proc/set_text(var/user,var/text,var/title,var/page_current,var/page_max,var/editable=FALSE)

	var/function_name = "set_text"
	var/function_args = list2params(list(text,title,page_current,page_max,editable))

	run_function(user,function_name,function_args)
	if(is_player(user))
		var/mob/living/advanced/player/P = user
		if(P.active_paper)
			P.active_paper.last_page = page_current

/menu/paper/run_function(var/user, var/function_name,var/args)
	user << output(args, "map.paper:[function_name]")

/menu/paper/Topic(href,href_list)

	if(href_list && usr && is_player(usr))

		var/mob/living/advanced/player/P = usr

		if(href_list["change_page"])
			var/desired_page = clamp(text2num(href_list["change_page"]),1,length(P.active_paper.data))
			set_text(P,sanitize(P.active_paper.data[desired_page],3000,extra = FALSE),P.active_paper.name,desired_page,length(P.active_paper.data),P.active_paper.editable)

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

					if(desired_new_text && length(desired_new_text))
						P.active_paper.data[desired_page] = desired_new_text
						set_text(P,sanitize(P.active_paper.data[desired_page],3000,extra = FALSE),P.active_paper.name,desired_page,length(P.active_paper.data),P.active_paper.editable)

	return ..()