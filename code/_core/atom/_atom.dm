/atom/
	var/health_max = 100
	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)
	var/id

/atom/proc/Initialize()
	//Initialize things here

/atom/New()
	. = ..()
	Initialize()

