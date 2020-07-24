var/global/list/active_votes = list()


/vote/ //Vote instance
	var/name = "Unknown Vote" //The name of the vote. Usually the question.
	var/list/options = list() //Just a list of possible choices.
	var/list/votes = list() //k = ckey, v = option, as a number

	var/time_limit

/vote/proc/announce()

	for(var/k in all_clients)
		var/client/C = all_clients[k]
		if(!C)
			continue
		C.to_chat("A new vote has been started.")
		C.to_chat("[name]")
		for(var/i=1,i<=length(options),i++)
			var/option = options[i]
			C.to_chat("[i]. [option]")
		C.to_chat("<a href='?vote=\ref[src]'>Click here to vote.</a>")


	active_votes |= src

	return TRUE

/vote/proc/show(var/client/C)

	. = "<h1>Vote</h1><h2>[name]</h2>"

	for(var/i=1,i<=length(options),i++)
		var/option = options[i]
		if(votes[C.ckey] == i)
			. += "<p><b>[option] (SELECTED)</b></p>"
		else
			. += "<p><a href='?vote=\ref[src];vote_option=[i]'>[option]</a></p>"

	C << browse(.,"window=Voting;display=1;size=300x300;border=0;can_close=1;can_resize=1;can_minimize=1;titlebar=1")
	C.to_chat("Opening window...")

	return TRUE

/vote/proc/add_option(var/text)
	options += text
	return TRUE

/vote/proc/remove_option(var/text)
	options -= text
	return TRUE

/vote/proc/set_vote(var/ckey,var/number)
	votes[ckey] = number
	return TRUE

/vote/proc/unset_vote(var/ckey)
	votes -= ckey
	return TRUE


/vote/Destroy()
	return ..()


/vote/proc/get_results()

	. = list()

	for(var/ckey in votes)
		var/option_num = votes[ckey]
		var/real_option = options[option_num]
		if(!.[real_option])
			.[real_option] = list()
		.[real_option] += ckey

	return .