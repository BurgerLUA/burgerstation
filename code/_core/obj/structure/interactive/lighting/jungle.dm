var/global/list/valid_jungle_colors = list(
	"#FFD319",
	"#FF901F",
	"#FF2975",
	"#F222FF",
	"#F222FF"
)

/obj/structure/interactive/lighting/jungle
	name = "jungle light"
	icon = 'icons/obj/structure/flora/jungle_lights.dmi'
	icon_state = ""
	layer = LAYER_FLOOR_SCENERY

	alpha = 255

	desired_light_power = 0.5
	desired_light_range = 5
	desired_light_color = "#FFFFFF"

	var/max_types = 0

/obj/structure/interactive/lighting/jungle/update_atom_light()
	if(on)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE

/obj/structure/interactive/lighting/jungle/Initialize()
	desired_light_color = pick(valid_jungle_colors)
	icon_state = "[initial(icon_state)][rand(1,max_types)]"
	. = ..()

/obj/structure/interactive/lighting/jungle/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/lighting/jungle/update_overlays()
	. = ..()
	var/image/I = new(icon,"[icon_state]_light")
	I.color = desired_light_color
	add_overlay(I)

/obj/structure/interactive/lighting/jungle/stick
	name = "jungle lightstick"
	icon_state = "stick"
	max_types = 9
	desired_light_range = 2

/obj/structure/interactive/lighting/jungle/flower
	name = "jungle lightflower"
	icon_state = "flower"
	max_types = 2
	desired_light_range = 6

/obj/structure/interactive/lighting/jungle/lamp
	name = "jungle lightlamp"
	icon_state = "lamp"
	max_types = 2
	desired_light_range = 4

/obj/structure/interactive/lighting/jungle/mine
	name = "jungle lightbud"
	icon_state = "mine"
	max_types = 5
	desired_light_range = 5