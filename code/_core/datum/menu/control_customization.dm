/menu/controls/
	id = "paper"
	file = 'html/control_customization.html'

/menu/controls/open(var/user)
	cache_resources(user)
	winset(user, "map.paper","is-visible=true")
	sleep(1)
	user << output(file, "map.paper")

/menu/controls/on_load(var/user)

	run_function(usr,"set_reference","'\ref[src]'")

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	if(P.active_paper && length(P.active_paper.data))
		set_text(P,P.active_paper.data[1],P.active_paper.name,P.active_paper.last_page,length(P.active_paper.data))

/menu/controls/close(var/user)
	winset(user, "map.paper","is-visible=false")
	winset(user,"map.map","focus=true")
	winset(user,"main.input","focus=false")

/menu/controls/proc/set_text(var/user,var/text,var/title,var/page_current,var/page_max)
	var/function_name = "set_text"
	var/function_args = "\"[proper_url_encode(text)]\",\"[proper_url_encode(title)]\",[page_current],[page_max]"


	run_function(user,function_name,function_args)
	if(is_player(user))
		var/mob/living/advanced/player/P = user
		if(P.active_paper)
			P.active_paper.last_page = page_current

/menu/controls/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "map.paper:eval")

/menu/controls/Topic(href,href_list)

	if(href_list && usr && is_player(usr))

		var/mob/living/advanced/player/P = usr

		if(href_list["change_page"])
			var/desired_page = clamp(text2num(href_list["change_page"]),1,length(P.active_paper.data))
			set_text(P,P.active_paper.data[desired_page],P.active_paper.name,desired_page,length(P.active_paper.data))

		if(href_list["close"])
			close_menu(P,"paper")
			P.active_paper = null

	return ..()