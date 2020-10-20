/rank/
	var/name = "Rank Name"
	var/desc = "Rank Description"
	var/id

	var/permissions = FLAG_PERMISSION_NONE
	var/protection = 0 //Higher equals better.
	var/list/verbs = list()

/rank/user/ //Don't need to add this to the config.
	name = "User"
	id = "USER"
	desc = "The default rank for players. They have no special commands or actions."
	permissions = FLAG_PERMISSION_NONE
	protection = 1

/rank/donator/bronze
	name = "Bronze Member"
	id = "BRONZE"
	desc = "A bronze donator."
	permissions = FLAG_PERMISSION_BRONZE
	protection = 2

/rank/donator/silver
	name = "Silver Member"
	id = "SILVER"
	desc = "A silver donator."
	permissions = FLAG_PERMISSION_SILVER
	protection = 3

/rank/donator/gold
	name = "Gold Member"
	id = "GOLD"
	desc = "A gold donator."
	permissions = FLAG_PERMISSION_GOLD
	protection = 4

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
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN | FLAG_PERMISSION_GAMEMASTER
	protection = 98

/rank/head_administrator/
	name = "Head Administrator"
	id = "HEADADMIN"
	desc = "Head Administrators can control the server to a stronger degree."
	permissions = FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_ADMIN | FLAG_PERMISSION_GAMEMASTER
	protection = 99

/rank/developer/
	name = "Developer"
	id = "DEV"
	desc = "Developers have access to debugging information and other commands that help with development."
	permissions = FLAG_PERMISSION_DEVELOPER
	protection = 5

/rank/gamemaster/
	name = "Gamemaster"
	id = "GAMEMASTER"
	desc = "Gamemasters have control over gamemaster related commands."
	permissions = FLAG_PERMISSION_GAMEMASTER
	protection = 5

/rank/host/
	name = "Host"
	id = "HOST"
	desc = "Hosts have all the power."
	protection = 100
	permissions = FLAG_PERMISSION_HOST | FLAG_PERMISSION_ADMIN | FLAG_PERMISSION_MODERATOR | FLAG_PERMISSION_DEVELOPER | FLAG_PERMISSION_GAMEMASTER