#define WEATHER_SPACING 4


SUBSYSTEM_DEF(weather)
	name = "Weather Subsystem"
	desc = "Controls weather."
	priority = SS_ORDER_LAST

	var/list/all_weather_particles = list()

/subsystem/weather/Initialize()

	if(!CONFIG("ENABLE_WEATHER",FALSE))
		return TRUE

	//Initialize weather
	for(var/k in subtypesof(/particles/weather/))
		var/particles/weather/W = new k
		all_weather_particles[W.type] = W

	for(var/z=1,z<=world.maxz,z++)
		for(var/x=1,x<=world.maxx,x+=WEATHER_SPACING)
			for(var/y=1,y<=world.maxx,y+=WEATHER_SPACING)
				var/turf/T = locate(x,y,z)
				var/obj/O = new(T)
				O.mouse_opacity = 0
				O.plane = PLANE_WEATHER
				O.layer = 0
				O.icon = null
				O.icon_state = null
				O.anchored = 2
				O.particles = all_weather_particles[/particles/weather/snow]
				var/area/A = T.loc
				A.particle_managers += O
				CHECK_TICK_HARD(95)

	return TRUE

/particles/weather/
	width = TILE_SIZE*WEATHER_SPACING*2
	height = TILE_SIZE*WEATHER_SPACING*2
	position = generator(
		"box",
		list(
			-TILE_SIZE*WEATHER_SPACING*0.5,
			TILE_SIZE*WEATHER_SPACING*0.5,
			0
		),
		list(
			TILE_SIZE*WEATHER_SPACING*0.5,
			TILE_SIZE*WEATHER_SPACING*0.5 - TILE_SIZE,
			0)
		)
	count = WEATHER_SPACING*TILE_SIZE*4
	spawning = 12
	lifespan = SECONDS_TO_DECISECONDS(4)
	fade = SECONDS_TO_DECISECONDS(2)


/particles/weather/snow
	fadein = SECONDS_TO_DECISECONDS(1)
	velocity = list(0,-3)
	gravity = list(0,-3)
	drift = generator("sphere", 0, 2)
	friction = 0.3



