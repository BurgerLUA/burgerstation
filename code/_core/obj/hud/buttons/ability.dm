var/global/list/ability_colors = list(
	HEALTH = "red",
	MANA = "blue",
	STAMINA = "green"
)


/obj/hud/button/ability
	name = "ERROR"
	var/id = null
	desc = "Slot button for quick actions."
	desc_extended = "Press this button to activate that item on the tile you're pointing. New abilities can be slotted at the ability machine in Science."
	icon_state = "square_trim"
	screen_loc = "LEFT,TOP"
	alpha = 200

	flags_hud = FLAG_HUD_MOB

	plane = PLANE_HUD
	layer = LAYER_HUD

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = 1

	mouse_opacity = 2

	has_quick_function = FALSE

	var/ability/ability
	var/image/ability_icon
	maptext_y = -5
	maptext_x = 0

/obj/hud/button/ability/New(var/desired_loc)
	. = ..()
	if(ability)
		ability = new ability

/obj/hud/button/ability/PreDestroy()
	QDEL_NULL(ability)
	. = ..()

/obj/hud/button/ability/proc/activate(var/mob/caller)

	if(ability && ability.activate(caller))
		animate(src,color="#00FF00",time=1,flags=ANIMATION_PARALLEL)
		START_THINKING(src)
	else
		animate(src,color="#FF0000",time=1,flags=ANIMATION_PARALLEL)

	animate(color="#FFFFFF",time=5)

	if(ability && ability.toggle)
		for(var/obj/hud/button/ability/B in caller.buttons)
			if(!B.ability || B.ability.category != src.ability.category)
				continue
			B.update_sprite()

	return TRUE


/obj/hud/button/ability/update_overlays()
	. = ..()
	var/image/I = IMAGE_INVISIBLE
	I.maptext = id
	add_overlay(I)
	if(ability)
		if(ability.toggle && ability.is_active(owner))
			var/image/I3 = new/image(initial(icon),"[initial(icon_state)]_selected")
			add_overlay(I3)
		var/image/I2 = new/image(ability.icon,ability.icon_state)
		I2.maptext = "<div align='right' style='color:[ability_colors[ability.resource_type]]'>[ability.cost]</div>"
		I2.maptext_x = -5
		add_overlay(I2)
		name = ability.name
		desc_extended = ability.desc
	else
		name = initial(name)
		desc_extended = initial(desc_extended)

	tooltip_text = initial(tooltip_text)
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()

/obj/hud/button/ability/think()

	. = ..()

	if(!ability)
		src.maptext = ""
		return FALSE

	if(ability.cooldown_end <= world.time)
		src.maptext = ""
		return FALSE

	var/display_number = DECISECONDS_TO_SECONDS(ability.cooldown_end - world.time)

	if(display_number <= 5)
		display_number = CEILING(display_number,0.1)
		if(!MODULUS(display_number,1))
			display_number = "[display_number].0"
	else
		display_number = CEILING(display_number,1)

	src.maptext = "<div align = 'center'>[display_number]</align>"

/obj/hud/button/ability/update_owner(var/mob/desired_owner)

	vis_contents.Cut()

	if(owner && !desired_owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.ability_buttons -= id

	. = ..()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.ability_buttons[id] = src

/obj/hud/button/ability/A
	id = "1"
	screen_loc = "LEFT,TOP"

/obj/hud/button/ability/B
	id = "2"
	screen_loc = "LEFT+1,TOP"

/obj/hud/button/ability/C
	id = "3"
	screen_loc = "LEFT+2,TOP"

/obj/hud/button/ability/D
	id = "4"
	screen_loc = "LEFT+3,TOP"