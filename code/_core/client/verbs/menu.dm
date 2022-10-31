/client/verb/open_discord()
	set name = "Open Discord"
	set category = "Menu"
	to_chat(span("notice","Opening discord in your browser."))
	src << link("https://discord.gg/yEaV92a")

/client/verb/open_github()
	set name = "Open Github"
	set category = "Menu"
	to_chat(span("notice","Opening github in your browser."))
	src << link("https://github.com/BurgerLUA/burgerstation")


/client/verb/open_patreon()
	set name = "Open Patreon"
	set category = "Menu"
	to_chat(span("notice","Opening patreon in your browser."))
	src << link("https://www.patreon.com/burgerstation")



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
