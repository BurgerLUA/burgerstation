/obj/weather
	icon = null
	screen_loc = "CENTER"
	plane = PLANE_WEATHER



//Snow
/obj/weather/snow
	particles = new/particles/snow
/*
/particles/snow
	width = SCREEN_SIZE
	height = SCREEN_SIZE
	count = 2000
	spawning = 12
	lifespan = SECONDS_TO_DECISECONDS(6)
	fade = SECONDS_TO_DECISECONDS(2)

	position = generator("box", list(-SCREEN_SIZE*0.5,SCREEN_SIZE*0.5,0), list(SCREEN_SIZE*0.5,SCREEN_SIZE*0.5,50))

	gravity = list(0,-3)
	friction = 0.2
	drift = generator("sphere", 0, 2)
*/