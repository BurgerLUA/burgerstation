#define BANLIST_KEYS_DIR "data/server/banlist_keys.json"
#define BANLIST_ADDRESS_DIR "data/server/banlist_address.json"
#define BANLIST_COMPUTER_DIR "data/server/banlist_computer_id.json"
#define ADMINLIST_DIR "data/server/adminlist.json"

SUBSYSTEM_DEF(ban)
	name = "Ban Subsystem"
	desc = "Handle banning and ban checks."
	priority = SS_ORDER_FIRST

	var/list/bans_keys = list("example_ckey" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))
	var/list/bans_address = list("192.167.255.256" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))
	var/list/bans_computer_ids = list("1234567890" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))

	var/list/admins = list("burgerbb")

/subsystem/ban/Initialize()

	if(fexists(ADMINLIST_DIR))
		admins = json_decode(file2text(ADMINLIST_DIR))
	else
		text2file(json_encode(admins),ADMINLIST_DIR)

	LOG_DEBUG("Found [length(admins)] admins.")

	var/bans_keys_changed = 0
	var/bans_address_changed = 0
	var/bans_computer_changed = 0

	//Get the banlist
	if(fexists(BANLIST_KEYS_DIR))
		bans_keys = json_decode(file2text(BANLIST_KEYS_DIR))
		fdel(BANLIST_KEYS_DIR)
	else
		bans_keys_changed = 1

	if(fexists(BANLIST_ADDRESS_DIR))
		bans_address = json_decode(file2text(BANLIST_ADDRESS_DIR))
		fdel(BANLIST_ADDRESS_DIR)
	else
		bans_address_changed = 1

	if(fexists(BANLIST_COMPUTER_DIR))
		bans_computer_ids = json_decode(file2text(BANLIST_COMPUTER_DIR))
		fdel(BANLIST_COMPUTER_DIR)
	else
		bans_computer_changed = 1


	//Check the banlist.
	for(var/k in bans_keys)
		var/v = bans_keys[k]
		if(v["expires"] == -1)
			continue
		if(world.realtime >= v["expires"])
			bans_keys -= k
			bans_keys_changed += 1

	for(var/k in bans_address)
		var/v = bans_address[k]
		if(v["expires"] == -1)
			continue
		if(world.realtime >= v["expires"])
			bans_address -= k
			bans_address_changed += 1

	for(var/k in bans_computer_ids)
		var/v = bans_computer_ids[k]
		if(v["expires"] == -1)
			continue
		if(world.realtime >= v["expires"])
			bans_computer_ids -= k
			bans_computer_changed += 1

	//Save the banlist
	if(bans_keys_changed)
		text2file(json_encode(bans_keys),BANLIST_KEYS_DIR)

	if(bans_address_changed)
		text2file(json_encode(bans_address),BANLIST_ADDRESS_DIR)

	if(bans_computer_changed)
		text2file(json_encode(bans_computer_ids),BANLIST_COMPUTER_DIR)

	log_subsystem(name,"Tracking [length(bans_keys)] banned ckeys.")
	log_subsystem(name,"Tracking [length(bans_address)] banned ip addresses.")
	log_subsystem(name,"Tracking [length(bans_computer_ids)] banned computer ids.")

	log_subsystem(name,"Unbanned [length(bans_keys_changed)] ckeys due to time.")
	log_subsystem(name,"Unbanned [length(bans_address_changed)] ip addresses due to time.")
	log_subsystem(name,"Unbanned [length(bans_computer_changed)] computer ids due to time.")

	initialized = TRUE

	return TRUE

/world/IsBanned(key,address,computer_id,type)

	LOG_ADMIN("New [type] connection from [address](ckey: [key], computer_id: [computer_id]).")

	if(!SSban || !SSban.initialized)
		return list("Login" = FALSE, "reason" = "Server isn't setup!",message = "Try rejoining again in a minute!")

	if(SSban.bans_keys[key])
		LOG_ADMIN("Ckey [key]([address]) tried connecting to the server, but they were ckey banned.")
		var/list/ban_data = SSban.bans_keys[key]
		var/message = "Adminstrator [ban_data["admin"]] banned this ckey [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your ckey has been banned from accessing the server.", "message" = message)

	if(SSban.bans_computer_ids[computer_id])
		LOG_ADMIN("Ckey [key]([address]) tried connecting to the server, but they were computer id banned.")
		var/list/ban_data = SSban.bans_computer_ids[computer_id]
		var/message = "Adminstrator [ban_data["admin"]] banned this computer [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your computer ID has been banned from accessing the server.", "message" = message)

	if(SSban.bans_address[address])
		LOG_ADMIN("Ckey [key]([address]) tried connecting to the server, but they were IP banned.")
		var/list/ban_data = SSban.bans_address[address]
		var/message = "Adminstrator [ban_data["admin"]] banned this IP address [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your IP address has been banned from accessing the server.", "message" = message)

	return FALSE

/subsystem/ban/proc/add_ckey_ban(var/ckey,var/admin_ckey = "SERVER",var/reason = "No reason specified.",var/expires = world.realtime + 86400)

	bans_keys[ckey] = list("admin" = admin_ckey, "reason" = reason, "expires" = expires)

	for(var/client/C in all_clients)
		if(C.ckey == ckey)
			C << span("danger","You have been banned from the server.\n\
			Banning Admin: [admin_ckey]\n\
			Reason: [reason]\n\
			Duration: [expires == -1 ? "Forever" : get_nice_time(expires - world.realtime)]")
			del(C)

	fdel(BANLIST_KEYS_DIR)
	text2file(json_encode(bans_keys),BANLIST_KEYS_DIR)

	LOG_ADMIN("[ckey] was added to the ckey banlist by [admin_ckey] for [get_nice_time(expires - world.realtime)] with the reason of: [reason].")

	return TRUE

/subsystem/ban/proc/remove_ckey_ban(var/ckey,admin_ckey)
	if(bans_keys[ckey])
		bans_keys -= ckey
		LOG_ADMIN("[ckey] was removed from the ckey banlist by [admin_ckey].")

/client/verb/ban(var/target_ckey as text,var/ban_duration_minutes = -1 as num, var/ban_reason = "No reason given." as message)
	set name = "ban"
	set category = "Admin"
	set hidden = TRUE

	ban_duration_minutes = text2num(ban_duration_minutes)

	if(!ban_duration_minutes)
		return FALSE

	if(!SSban)
		return FALSE

	if(!lowertext(ckey) in SSban.admins)
		return FALSE

	if(!target_ckey)
		return FALSE

	SSban.add_ckey_ban(target_ckey,ckey,ban_reason,ban_duration_minutes == -1 ? -1 : world.realtime + ban_duration_minutes*60)
	return TRUE

/*
/client/verb/ban(var/ban_target as ,var/ban_duration as number,var/ban_reason as message)
	set name = "ban"
	set category = "Admin"
	set hidden = TRUE

	if(!lowertext(ckey) in SSban.admins)
		return FALSE


	var/ban_type = input("What would you like to ban?","Ban type.") in list("Ckey","IP Address","Computer ID")|null
	if(!ban_type)
		return FALSE

	switch(ban_type)
		if("Ckey")
			ban_target = input("Please enter the ckey that you wish to ban.","CKey Ban") as text|null
		if("IP Address")
			ban_target = input("Please enter the IP Address you wish to ban.","IP Address Ban") as text|null
		if("Computer ID")
			ban_target = input("Please enter the computer ID you wish to ban.","Computer ID Ban") as text|null
	if(!ban_target)
		return FALSE




	ban_reason = input("What is the ban reason?","Ban Reason","None.") as text|null
	if(!ban_reason)
		return FALSE

	ban_duration = input("How long would you like to apply the ban for?","Ban Duration") in list("1 hour","12 hours","1 day","3 days","1 week","1 month","Forever")|null
	var/list/ban_duration_num = list(
		"1 hour" = 3600,
		"12 hours" = 3600*12,
		"1 day" = 3600*24,
		"3 days" = 3600*24*3,
		"1 week" = 3600*24*7,
		"1 month" = 3600*24*30,
		"Forever" = -1
	)
	if(!ban_duration)
		return FALSE

	ban_duration = ban_duration_num[ban_duration]




	return TRUE
*/