/obj/item/tempering/luck
	name = "lucky four leaf clover"
	desc = "Lucky!"
	desc_extended = "A very rare four leaf clover."
	icon_state = "luck"

	increase = 1
	minimum = 50
	maximum = 100

	temper_whitelist = /obj/item/

	value = 4000

	uses_left = 4

/obj/item/tempering/luck/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Increases the luck of items by [increase]%, up to [maximum]%, with a minimum of [minimum]%.")

/obj/item/tempering/luck/can_temper(var/mob/caller,var/obj/item/I)

	if(I.luck >= maximum)
		caller.to_chat(span("warning","\The [I.name] cannot be improved any further!"))
		return FALSE

	. = ..()

/obj/item/tempering/luck/on_temper(var/mob/caller,var/obj/item/I)
	I.luck = clamp(I.luck + increase,minimum,maximum)
	. = ..()

/obj/item/tempering/luck/double
	name = "double lucky four leaf clover"
	desc = "Even luckier!"
	desc_extended = "A very rare conjoined four leaf clover."
	icon_state = "luck2"

	increase = 1
	minimum = 50
	maximum = 100

	value = 8000

	uses_left = 8