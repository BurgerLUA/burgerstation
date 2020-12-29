/obj/item/runtime
	name = "flaw in the world"
	desc = "oh god oh fuck"
	desc_extended = "What the fuck is this? How did you get it? ANSWER ME."
	value = -1

/obj/item/runtime/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	ASSERT(null) //Force a fake error.
	return TRUE