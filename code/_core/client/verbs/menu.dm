/client/verb/open_discord()
	set name = "Open Discord"
	set category = "Menu"
	var/discord_link = CONFIG("SERVER_DISCORD",null)
	if(!discord_link)
		to_chat(span("warning","No Discord URL provided! Yell at the server owner to set one up!"))
		return TRUE
	to_chat(span("notice","Opening discord in your browser..."))
	src << link(discord_link)

/client/verb/open_github()
	set name = "Open Github"
	set category = "Menu"
	var/github_link = CONFIG("SERVER_GITHUB",null)
	if(!github_link)
		to_chat(span("warning","No Github URL provided! Yell at the server owner to set one up!"))
		return TRUE
	to_chat(span("notice","Opening Github in your browser..."))
	src << link(github_link)

/client/verb/open_patreon()
	set name = "Open Patreon"
	set category = "Menu"
	var/patreon_link = CONFIG("SERVER_PATREON",null)
	if(!patreon_link)
		to_chat(span("warning","No Patreon URL provided! Yell at the server owner to set one up!"))
		return TRUE
	to_chat(span("notice","Opening Patreon in your browser..."))
	src << link(patreon_link)

/client/verb/player_who()
	set name = "Player Who"
	set category = "Menu"

	var/list/active_players = list()

	for(var/k in all_clients)
		active_players += k

	to_chat("<b>[length(active_players)] Online Players</b><br>[english_list(active_players)]")

/client/verb/staff_who()
	set name = "Staff Who"
	set category = "Menu"

	var/list/active_staff = list()

	for(var/k in all_clients)
		//var/client/C = all_clients[k]
		if(SSadmin.stored_user_ranks[k])
			var/list/ranks = SSadmin.stored_user_ranks[k]
			active_staff += "[k] ([english_list(ranks)])"

	to_chat("<b>[length(active_staff)] Online Staff</b><br>[english_list(active_staff)]")
