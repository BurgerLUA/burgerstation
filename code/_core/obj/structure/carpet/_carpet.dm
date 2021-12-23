/obj/structure/carpet
	name = "carpet"
	icon = 'icons/obj/structure/carpet.dmi'
	icon_state = "base"

	var/trim_icon_state
	var/trim_color = "#FFFFFF"
	var/pattern_icon_state
	var/pattern_color = "#FFFFFF"

	var/override_overlays = FALSE

	plane = PLANE_JUNK
	layer = -1000

/obj/structure/carpet/Finalize()
	. = ..()
	update_sprite()

/obj/structure/carpet/update_overlays()
	. = ..()

	if(!override_overlays)
		if(pattern_icon_state && pattern_color)
			var/image/I = new/image(icon,pattern_icon_state)
			I.color = pattern_color
			I.appearance_flags = appearance_flags | RESET_COLOR
			add_overlay(I)

		if(trim_icon_state && trim_color)
			for(var/d in DIRECTIONS_CARDINAL)
				var/obj/structure/carpet/C = locate() in get_step(src,d)
				if(C && C.type == src.type) continue
				var/image/I = new/image(icon,"[trim_icon_state]_[d]")
				I.color = trim_color
				I.appearance_flags = appearance_flags | RESET_COLOR
				add_overlay(I)

/obj/structure/carpet/red
	name = "red carpet"
	color = "#7C1717"

	trim_icon_state = "t1"
	trim_color = COLOR_GOLD
	pattern_icon_state = "p1"
	pattern_color = "#540F0F"

/obj/structure/carpet/blue
	name = "blue carpet"
	color = "#173B7A"

	trim_icon_state = "t1"
	trim_color = COLOR_GOLD
	pattern_icon_state = "p2"
	pattern_color = "#17697A"

/obj/structure/carpet/brown
	name = "brown carpet"
	color = "#7F3300"

	trim_icon_state = "t1"
	trim_color = COLOR_GOLD
	pattern_icon_state = "p3"
	pattern_color = "#AE4600"
