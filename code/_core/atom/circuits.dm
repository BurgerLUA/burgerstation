/atom/proc/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	return TRUE


/obj/item/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	last_interacted = caller
	return ..()