/obj/hud/button/robust/
	flags = FLAGS_HUD_SPECIAL
	has_quick_function = FALSE
	maptext_width = TILE_SIZE
	maptext_height = TILE_SIZE

/obj/hud/button/robust/piece/
	var/obj/hud/button/robust/board/linked_board

/obj/hud/button/robust/piece/Destroy()
	if(linked_board)
		linked_board.linked_pieces -= src
		linked_board = null


/obj/hud/button/robust/piece/attack
	name = "attack"
	maptext = "<center>ATTACK</center>"

/obj/hud/button/robust/piece/regen
	name = "regen"
	maptext = "<center>REGEN</center>"

/obj/hud/button/robust/piece/heal
	name = "heal"
	maptext = "<center>HEAL</center>"


/obj/hud/button/robust/piece/player_stats
	name = "your stats"

/obj/hud/button/robust/piece/antag_stats
	name = "enemy stats"

/obj/hud/button/robust/board

	var/list/linked_pieces = list()

	var/obj/hud/button/robust/player_stats/linked_player_stats
	var/obj/hud/button/robust/antag_stats/linked_antag_stats