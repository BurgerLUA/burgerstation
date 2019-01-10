var/global/obj/lighting_controller/lighting_controller



/obj/lighting_controller/
	name = "lighting controller"
	mouse_opacity = 0
	plane = 2
	blend_mode = BLEND_MULTIPLY

/obj/lighting_controller/New()
	lighting_controller = src
	update_icon()

/obj/lighting_controller/update_icon()

	var/sin_math = sin(curtime * (90/60))

	var/sunlevel = max(0,0.5 - (sin_math/2))
	var/moonlevel = max(0,sin_math)
	if(moonlevel > sunlevel)
		sunlevel = sunlevel * 0.25

	var/icon/darkness = new('icons/lighting.dmi',"white")
	darkness.Scale(world.maxx * TILE_SIZE,world.maxy * TILE_SIZE)

	darkness.MapColors(rgb((255 - moonlevel*(255-51)),(255 - moonlevel*(255-13)),(255 - moonlevel*(255-13))), rgb((255 - moonlevel*(255-26)),(255 - moonlevel*(255-77)),(255 - moonlevel*(255-51))), rgb((255 - moonlevel*(255-26)),(255 - moonlevel*(255-26)),(255 - moonlevel*(255-102))), rgb((255 - moonlevel*(255-0)),(255 - moonlevel*(255-0)),(255 - moonlevel*(255-0))))


