/obj/hud/button/virtual_reality
	var/obj/structure/interactive/vr_pod/linked_pod

/obj/hud/button/virtual_reality/Destroy()
	linked_pod = null
	. = ..()

/obj/hud/button/virtual_reality/info
	name = "view virtual reality information"
	icon_state = "question"
	screen_loc = "CENTER-1,CENTER"

/obj/hud/button/virtual_reality/info/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	linked_pod.print_information()
	. = ..()

/obj/hud/button/virtual_reality/enter
	name = "enter reality pod"
	icon_state = "arrow"
	screen_loc = "CENTER,CENTER"

/obj/hud/button/virtual_reality/enter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	linked_pod.enter_virtual_reality()
	. = ..()

/obj/hud/button/virtual_reality/exit
	name = "exit virtual reality pod"
	icon_state = "view_inventory"
	screen_loc = "CENTER+1,CENTER"

/obj/hud/button/virtual_reality/exit/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	linked_pod.force_eject_user()
	. = ..()