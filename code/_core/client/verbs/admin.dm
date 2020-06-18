/client/verb/ban(var/target_ckey as text,var/ban_duration_minutes = -1 as num, var/ban_reason = "No reason given." as message)

	set name = "Ban ckey"
	set category = "Admin"

	ban_duration_minutes = text2num(ban_duration_minutes)

	if(!ban_duration_minutes)
		return FALSE

	if(!SSban)
		return FALSE

	if(!target_ckey)
		return FALSE

	SSban.add_ckey_ban(target_ckey,ckey,ban_reason,ban_duration_minutes == -1 ? -1 : world.realtime + ban_duration_minutes*60)
	return TRUE