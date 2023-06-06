/obj/hud/button/
	name = "button"
	desc = "This button does something, I think."

	icon = 'icons/hud/hud.dmi'
	icon_state = null

	var/is_static = TRUE //Is the button anchored?

	layer = LAYER_HUD
	plane = PLANE_HUD

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/essential = FALSE

	flags_hud = FLAG_HUD_NONE

	mouse_opacity = 1

	has_quick_function = TRUE

	var/interact_check = FALSE

/obj/hud/button/quick(var/mob/living/advanced/caller,var/atom/object,location,params)

	if(alpha == 0)
		return FALSE

	if(mouse_opacity == 0)
		return FALSE

	return src.clicked_on_by_object(caller,null,location,null,params)

/obj/hud/button/Destroy()
	. = ..()
	if(bad_delete) CRASH("[src.get_debug_name()] was deleted incorrectly!")


/obj/hud/button/proc/show(var/should_show=TRUE,var/draw_speed=SECONDS_TO_DECISECONDS(1))
	if(should_show)
		animate(src,alpha= initial(alpha),time=draw_speed)
		mouse_opacity = initial(mouse_opacity)
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(draw_speed))
		mouse_opacity = 0

/obj/hud/button/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	play_sound_target('sound/ui/tap-muted.ogg',caller, sound_setting = SOUND_SETTING_UI)
	if(interact_check)
		INTERACT_CHECK
	return TRUE