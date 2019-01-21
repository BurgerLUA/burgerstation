/faction/arena/
	friendly_fire = FALSE
	icon = 'icons/hud/faction_overlays.dmi'

/faction/arena/red/
	name = "Team Red"
	id = "arena_red"
	icon_state = "red"
	relationships = list(
		"arena_red" = RELATIONSHIP_ALLY,
		"arena_blue" = RELATIONSHIP_ENEMY,
		"arena_green" = RELATIONSHIP_ENEMY,
		"arena_yellow" = RELATIONSHIP_ENEMY,
	)
	color = "#FF0000"

/faction/arena/blue/
	name = "Team Blue"
	id = "arena_blue"
	icon_state = "blue"
	relationships = list(
		"arena_red" = RELATIONSHIP_ENEMY,
		"arena_blue" = RELATIONSHIP_ALLY,
		"arena_green" = RELATIONSHIP_ENEMY,
		"arena_yellow" = RELATIONSHIP_ENEMY,
	)
	color = "#0000FF"

/faction/arena/green/
	name = "Team Green"
	id = "arena_green"
	icon_state = "green"
	relationships = list(
		"arena_red" = RELATIONSHIP_ENEMY,
		"arena_blue" = RELATIONSHIP_ENEMY,
		"arena_green" = RELATIONSHIP_ALLY,
		"arena_yellow" = RELATIONSHIP_ENEMY,
	)
	color = "#00FF00"

/faction/arena/yellow/
	name = "Team Yellow"
	id = "arena_yellow"
	icon_state = "yellow"
	relationships = list(
		"arena_red" = RELATIONSHIP_ENEMY,
		"arena_blue" = RELATIONSHIP_ENEMY,
		"arena_green" = RELATIONSHIP_ENEMY,
		"arena_yellow" = RELATIONSHIP_ALLY,
	)
	color = "#FFFF00"