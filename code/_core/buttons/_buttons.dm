/obj/button/
	name = "button"
	desc = "This button does something, I think."

	icon = 'icons/hud/inventory.dmi'
	icon_state = "slot"

	var/mob/owner //The mob that owns this button

	var/is_static = TRUE //Is the button anchored?


/obj/button/proc/update_owner(var/mob/desired_owner) //Can also be safely used as an updater.

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_button(src)

	owner = desired_owner
	owner.add_button(src)

	return TRUE
