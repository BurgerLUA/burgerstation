/obj/hud/button/
	name = "button"
	desc = "This button does something, I think."

	icon = 'icons/hud/hud.dmi'
	icon_state = "slot"

	var/is_static = TRUE //Is the button anchored?

	layer = LAYER_HUD
	plane = PLANE_HUD

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/essential = FALSE

	var/flags = FLAGS_HUD_NONE

	mouse_opacity = 1

	has_quick_function = TRUE

	var/delete_on_no_owner = TRUE

	var/bad_delete = TRUE

/obj/hud/button/quick(var/mob/living/advanced/caller,var/atom/object,location,params)

	if(alpha == 0)
		return FALSE

	if(mouse_opacity == 0)
		return FALSE

	return src.clicked_on_by_object(caller,null,location,null,params)

/obj/hud/button/Destroy()
	if(bad_delete)
		CRASH_SAFE("Warning: [src.get_debug_name()] was deleted incorrectly.")
	. = ..()

/obj/hud/button/proc/show(var/should_show=TRUE,var/draw_speed=2)
	if(should_show)
		var/initial_alpha = initial(alpha)
		animate(src,alpha= initial_alpha ? initial_alpha : 255,time=SECONDS_TO_DECISECONDS(draw_speed))
		var/initial_mouse = initial(mouse_opacity)
		mouse_opacity = initial_mouse ? initial_mouse : 1
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(draw_speed))
		mouse_opacity = 0

/obj/hud/button/proc/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_button(src)

	if(!desired_owner && delete_on_no_owner)
		bad_delete = FALSE
		qdel(src)
		return TRUE

	owner = desired_owner
	if(owner)
		owner.add_button(src)
		update_sprite()

	return TRUE

/obj/hud/button/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	play_sound_target('sound/ui/tap-muted.ogg',caller, sound_setting = SOUND_SETTING_UI)
	INTERACT_CHECK
	return TRUE