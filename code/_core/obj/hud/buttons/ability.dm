/obj/hud/button/ability
	name = "ERROR"
	var/id = null
	desc = "Slot button for quick actions."
	desc_extended = "Press this button to activate that item on the tile you're pointing."
	icon_state = "square_trim"
	screen_loc = "LEFT+0.25,TOP-0.25"
	alpha = 200

	flags = FLAGS_HUD_MOB

	plane = PLANE_HUD
	layer = 1

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = 1

	mouse_opacity = 2

	has_quick_function = FALSE

	var/ability/ability
	var/image/ability_icon
	maptext_y = 10
	maptext_x = 0

/obj/hud/button/ability/New(var/desired_loc)
	. = ..()
	if(ability)
		ability = new ability

/obj/hud/button/ability/Destroy()
	. = ..()
	QDEL_NULL(ability)

/obj/hud/button/ability/proc/activate(var/mob/caller)

	if(ability && ability.activate(caller))
		animate(src,color="#00FF00",time=1,flags=ANIMATION_PARALLEL)
		start_thinking(src)
	else
		animate(src,color="#FF0000",time=1,flags=ANIMATION_PARALLEL)

	animate(color="#FFFFFF",time=5)

	return TRUE


/obj/hud/button/ability/update_overlays()
	. = ..()
	var/image/I = IMAGE_INVISIBLE
	I.maptext = id
	add_overlay(I)
	if(ability)
		var/image/I2 = new/image(ability.icon,ability.icon_state)
		I2.maptext = "<div align='right' style='color:blue'>[ability.mana_cost]</div>"
		I2.maptext_x = -5
		add_overlay(I2)

/obj/hud/button/ability/think()

	. = ..()

	if(!ability)
		src.maptext = ""
		return FALSE

	if(ability.cooldown_end <= world.time)
		src.maptext = ""
		return FALSE

	var/display_number = ability.cooldown_end - world.time
	display_number = CEILING(display_number,0.1)

	src.maptext = "<div align = 'center'>[display_number]</align>"

/obj/hud/button/ability/update_owner(var/mob/desired_owner)

	vis_contents.Cut()

	if(owner && !desired_owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.ability_buttons -= id

	. = ..()

	if(ability)
		name = ability.name
	else
		name = "empty ability"

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.ability_buttons[id] = src

/obj/hud/button/ability/A
	id = "1"
	screen_loc = "LEFT+0.25,TOP-0.25"
	ability = /ability/quick_draw

/obj/hud/button/ability/B
	id = "2"
	screen_loc = "LEFT+1+0.25,TOP-0.25"
	ability = /ability/quick_draw/plus

/obj/hud/button/ability/C
	id = "3"
	screen_loc = "LEFT+2+0.25,TOP-0.25"

/obj/hud/button/ability/D
	id = "4"
	screen_loc = "LEFT+3+0.25,TOP-0.25"