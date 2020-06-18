/rank/
	var/name = "Rank Name"
	var/desc = "Rank Description"
	var/id

	var/permissions = FLAG_PERMISSION_NONE
	var/protection = 0
	var/list/verbs = list()

/rank/proc/add_verbs(var/client/C)
	C.verbs.Cut()
	return TRUE

/rank/user/
	name = "User"
	id = "USER"
	desc = "The default rank for players. They have no special commands or actions."
	permissions = FLAG_PERMISSION_NONE
	protection = 1

/rank/moderator/
	name = "Moderator"
	id = "MOD"
	desc = "Moderators can moderate with commands such as kick, ban, and mute."
	permissions = FLAG_PERMISSION_MODERATOR
	protection = 97

/rank/administrator/
	name = "Administrator"
	id = "ADMIN"
	desc = "Administrators can control the server to a stronger degree."
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN
	protection = 98

/rank/head_administrator/
	name = "Head Administrator"
	id = "HEADADMIN"
	desc = "Head Administrators can control the server to a stronger degree."
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN
	protection = 99

/rank/developer/
	name = "Developer"
	id = "DEV"
	desc = "Developers have access to debugging information and other commands that help with development."
	permissions = FLAG_PERMISSION_DEVELOPER
	protection = 2

/rank/developer/
	name = "Gamemaster"
	id = "GAMEMASTER"
	desc = "Gamemasters have control over gamemaster related commands."
	permissions = FLAG_PERMISSION_GAMEMASTER
	protection = 2

/rank/host/
	name = "Host"
	id = "HOST"
	desc = "Hosts have all the power."
	protection = 100
	permissions = FLAG_PERMISSION_HOST | FLAG_PERMISSION_ADMIN | FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_DEVELOPER | FLAG_PERMISSION_GAMEMASTER