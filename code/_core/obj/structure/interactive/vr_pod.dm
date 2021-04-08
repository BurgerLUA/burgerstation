/obj/structure/interactive/vr_pod
	name = "virtual reality pod"
	desc = "Learn something new without the risk of death in here!"
	desc_extended = "A NanoTrasen brand virtual realtiy pod that allows the user to magically hook their conciousness to a virtual world. It feels like real life!"
	icon = 'icons/obj/structure/vr_pod.dmi'
	icon_state = "idle"

	var/mob/living/advanced/player/user

	var/mob/living/advanced/player/virtual_avatar = /mob/living/advanced/player/virtual

/obj/structure/interactive/vr_pod/proc/check_virtual_avatar()

	if(istype(virtual_avatar))
		user.to_chat(span("notice","Entering existing virtual avatar..."))
		user.client.control_mob(virtual_avatar)
		return TRUE
	else
		virtual_avatar = initial(virtual_avatar)
		if(!virtual_avatar)
			log_error("WARNING: [user.get_debug_name()] tried accessing virtual reality with [src.get_debug_name()], but there was no default virtual avatar assigned!")
			return FALSE
		user.to_chat(span("notice","Initializing new virtual avatar..."))
		virtual_avatar = new virtual_avatar(get_turf(src),user.client,1)
		virtual_avatar.fallback_mob = user
		INITIALIZE(virtual_avatar)
		GENERATE(virtual_avatar)
		FINALIZE(virtual_avatar)

	return TRUE

/obj/structure/interactive/vr_pod/Entered(var/atom/movable/enterer,var/atom/oldloc)
	if(is_player(enterer))
		user = enterer
		check_virtual_avatar()
	. = ..()

/obj/structure/interactive/vr_pod/Exited(var/atom/movable/exiter,var/atom/newloc)
	if(exiter == user)
		user = null
	. = ..()

/obj/structure/interactive/vr_pod/proc/force_eject_user()
	if(user)
		user.Move(get_turf(src))
		return TRUE
	return FALSE

/obj/structure/interactive/vr_pod/proc/can_enter_pod(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(!is_player(caller))
		return FALSE

	if(user)
		return FALSE

	if(!caller.client)
		return FALSE

	return TRUE

/obj/structure/interactive/vr_pod/proc/enter_pod(var/mob/living/advanced/player/P)
	force_eject_user() //Just in case.
	P.Move(src)
	return TRUE

/obj/structure/interactive/vr_pod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_inventory(object))
		if(user)
			if(user.dead)
				caller.to_chat(span("notice","You remove \the [user]'s dead corpse from \the [src.name]."))
				force_eject_user()
				return TRUE
			caller.to_chat(span("warning","\The [src.name] is already occupied!"))
		else if(can_enter_pod(caller))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/enter_pod,caller)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_enter_pod,caller)
		return TRUE

	. = ..()