#define BANLIST_KEYS_DIR "data/server/banlist_keys.json"
#define BANLIST_ADDRESS_DIR "data/server/banlist_address.json"
#define BANLIST_COMPUTER_DIR "data/server/banlist_computer_id.json"

SUBSYSTEM_DEF(ban)
	name = "Ban Subsystem"
	desc = "Handle banning and ban checks."
	priority = SS_ORDER_FIRST

	var/list/bans_keys = list("example_ckey" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))
	var/list/bans_address = list("192.167.255.256" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))
	var/list/bans_computer_ids = list("1234567890" = list("admin" = "burgerbb", "reason" = "For being an example.", "expires" = -1))

/subsystem/ban/Initialize()

	var/bans_keys_changed = 0
	var/bans_address_changed = 0
	var/bans_computer_changed = 0

	//Get the banlist
	if(fexists(BANLIST_KEYS_DIR))
		bans_keys = json_decode(rustg_file_read(BANLIST_KEYS_DIR))
	else
		bans_keys_changed = 1

	if(fexists(BANLIST_ADDRESS_DIR))
		bans_address = json_decode(rustg_file_read(BANLIST_ADDRESS_DIR))
	else
		bans_address_changed = 1

	if(fexists(BANLIST_COMPUTER_DIR))
		bans_computer_ids = json_decode(rustg_file_read(BANLIST_COMPUTER_DIR))
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
		rustg_file_write(json_encode(bans_keys),BANLIST_KEYS_DIR)

	if(bans_address_changed)
		rustg_file_write(json_encode(bans_address),BANLIST_ADDRESS_DIR)

	if(bans_computer_changed)
		rustg_file_write(json_encode(bans_computer_ids),BANLIST_COMPUTER_DIR)

	log_subsystem(name,"Tracking [length(bans_keys)] banned ckeys.")
	log_subsystem(name,"Tracking [length(bans_address)] banned ip addresses.")
	log_subsystem(name,"Tracking [length(bans_computer_ids)] banned computer ids.")

	log_subsystem(name,"Unbanned [length(bans_keys_changed)] ckeys due to time.")
	log_subsystem(name,"Unbanned [length(bans_address_changed)] ip addresses due to time.")
	log_subsystem(name,"Unbanned [length(bans_computer_changed)] computer ids due to time.")

	initialized = TRUE

	return TRUE

/world/IsBanned(key,address,computer_id,type)

	log_admin("New [type] connection from [address](ckey: [key], computer_id: [computer_id]).")

	if(!SSban || !SSban.initialized)
		return list("Login" = FALSE, "reason" = "Server isn't setup!",message = "Try rejoining again in a minute!")

	if(SSban.bans_keys[key])
		log_admin("Ckey [key]([address]) tried connecting to the server, but they were ckey banned.")
		var/list/ban_data = SSban.bans_keys[key]
		var/message = "Adminstrator [ban_data["admin"]] banned this ckey [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your ckey has been banned from accessing the server.", "message" = message)

	if(SSban.bans_computer_ids[computer_id])
		log_admin("Ckey [key]([address]) tried connecting to the server, but they were computer id banned.")
		var/list/ban_data = SSban.bans_computer_ids[computer_id]
		var/message = "Adminstrator [ban_data["admin"]] banned this computer [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your computer ID has been banned from accessing the server.", "message" = message)

	if(SSban.bans_address[address])
		log_admin("Ckey [key]([address]) tried connecting to the server, but they were IP banned.")
		var/list/ban_data = SSban.bans_address[address]
		var/message = "Adminstrator [ban_data["admin"]] banned this IP address [ban_data["expires"] == -1 ? "forever" : "for [get_nice_time(ban_data["expires"] - world.realtime)]"] with the reason of: [ban_data["reason"]]"
		return list("Login" = FALSE, "reason" = "Your IP address has been banned from accessing the server.", "message" = message)

	return FALSE

/subsystem/ban/proc/add_ckey_ban(var/desired_ckey,var/admin_ckey = "SERVER",var/reason = "No reason specified.",var/expires = world.realtime + 86400)

	bans_keys[desired_ckey] = list("admin" = admin_ckey, "reason" = reason, "expires" = expires)

	for(var/ckey in all_clients)
		var/client/C = all_clients[ckey]
		if(desired_ckey == ckey)
			C << span("danger","You have been banned from the server.\n\
			Banning Admin: [admin_ckey]\n\
			Reason: [reason]\n\
			Duration: [expires == -1 ? "Forever" : get_nice_time(expires - world.realtime)]")
			del(C)

	rustg_file_write(json_encode(bans_keys),BANLIST_KEYS_DIR)

	log_admin("[desired_ckey] was added to the ckey banlist by [admin_ckey] for [get_nice_time(expires - world.realtime)] with the reason of: [reason].")

	return TRUE

/subsystem/ban/proc/remove_ckey_ban(var/ckey,admin_ckey)
	if(bans_keys[ckey])
		bans_keys -= ckey
		log_admin("[ckey] was removed from the ckey banlist by [admin_ckey].")