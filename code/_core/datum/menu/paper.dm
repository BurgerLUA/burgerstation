/menu/paper/
	name = "Paper"
	id = "paper"

	file = 'html/paper.html'

/menu/paper/open(var/user)
	cache_resources(user)
	winset(user, "map.paper","is-visible=true")
	sleep(1)
	user << output(file, "map.paper")

/menu/paper/on_load(var/user)

	run_function(usr,"set_reference","'\ref[src]'")

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	if(P.active_paper && length(P.active_paper.data))
		set_text(P,P.active_paper.data[1],P.active_paper.name,1,length(P.active_paper.data))

/menu/paper/close(var/user)
	winset(user, "map.paper","is-visible=false")
	winset(user,"map.map","focus=true")
	winset(user,"main.input","focus=false")

/menu/paper/proc/set_text(var/user,var/text,var/title,var/page_current,var/page_max)
	run_function(user,"set_text","'[text]','[title]',[page_current],[page_max]")

/menu/paper/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "map.paper:eval")

/menu/paper/Topic(href,href_list)

	if(href_list && href_list["change_page"] && usr && is_player(usr))
		var/mob/living/advanced/player/P = usr
		var/desired_page = Clamp(text2num(href_list["change_page"]),1,length(P.active_paper.data))
		set_text(P,P.active_paper.data[desired_page],P.active_paper.name,desired_page,length(P.active_paper.data))

	return ..()