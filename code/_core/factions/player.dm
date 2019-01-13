/faction/player/
	name = "Player Faction"
	id = FACTION_PLAYER
	desc = "The faction which all players are given."

	relationships = list()


/faction/player/player_hostile
	name = "Hostile Player Faction"
	id = FACTION_PLAYER_HOSTILE
	desc = "This faction is hostile to players."

	relationships = list(
		FACTION_PLAYER = RELATIONSHIP_ENEMY
	)