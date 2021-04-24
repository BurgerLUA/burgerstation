/obj/hud/button/vr_spectate
	name = "spectate"


/obj/hud/button/vr_spectate/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()

	if(!SSvirtual_reality || !SSvirtual_reality.current_virtual_reality)
		return .

	if(!caller.client)
		return .

	if(!istype(caller,/mob/living))
		return .

	var/mob/living/L = caller

	var/virtual_reality/VR = SSvirtual_reality.current_virtual_reality

	var/list/team_list = VR.teams[L.loyalty_tag]
	if(!length(team_list))
		return FALSE
	team_list = team_list.Copy()
	team_list += "Cancel"

	var/mob/living/desired_spectate = input("Who do you wish to spectate?","Spectate","Cancel") as null|anything in team_list
	if(!desired_spectate || desired_spectate == "Cancel")
		return .

	if(!L.dead || desired_spectate.qdeleting)
		caller.to_chat(span("warning","Failed to spectate."))
		return .

	L.client.spectate(desired_spectate)