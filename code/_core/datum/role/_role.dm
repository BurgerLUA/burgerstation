/role/
	var/name = "Roll Name"
	var/desc = "Roll Description"
	var/id = null

	var/permissions = FLAG_PERMISSION_NONE
	var/protection = 0
	var/list/verbs = list()

/role/proc/add_verbs(var/client/C)
	C.verbs.Cut()
	return TRUE

/role/user/
	name = "User"
	id = "user"
	desc = "The default rank for players. They have no special commands or actions."
	permissions = FLAG_PERMISSION_NONE
	protection = 1

/role/moderator/
	name = "Moderator"
	id = "mod"
	desc = "Moderators can moderate with commands such as kick, ban, and mute."
	permissions = FLAG_PERMISSION_MODERATOR
	protection = 97

/role/administrator/
	name = "Administrator"
	id = "admin"
	desc = "Administrators can control the server to a stronger degree."
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN
	protection = 98

/role/head_administrator/
	name = "Head Administrator"
	id = "head"
	desc = "Head Administrators can control the server to a stronger degree."
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN
	protection = 99

/role/developer/
	name = "Developer"
	id = "dev"
	desc = "Developers have access to debugging information and other commands that help with development."
	permissions = FLAG_PERMISSION_DEVELOPER
	protection = 2

/role/developer/
	name = "Gamemaster"
	id = "gamemaster"
	desc = "Gamemasters have control over gamemaster related commands."
	permissions = FLAG_PERMISSION_GAMEMASTER
	protection = 2

/role/host/
	name = "Host"
	id = "host"
	desc = "Hosts have all the power."
	protection = 100
	permissions = FLAG_PERMISSION_HOST | FLAG_PERMISSION_ADMIN | FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_DEVELOPER | FLAG_PERMISSION_GAMEMASTER