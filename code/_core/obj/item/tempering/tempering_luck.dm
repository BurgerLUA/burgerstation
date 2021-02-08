/obj/item/tempering/luck
	name = "lucky four leaf clover"
	desc = "Lucky!"
	desc_extended = "A very rare four leaf clover. Grants +1 luck to an item when used, up to 100 luck. If the improvement results in a luck value below 40, it will set the object's luck to 40."
	icon_state = "luck"

	increase = 1
	limit = 100
	minimum = 40

	temper_whitelist = /obj/item/

	value = 3000

/obj/item/tempering/luck/can_temper(var/mob/caller,var/obj/item/I)

	if(I.luck >= limit)
		caller.to_chat(span("warning","\The [I.name] cannot be improved any further!"))
		return FALSE

	return ..()

/obj/item/tempering/luck/on_temper(var/mob/caller,var/obj/item/I)

	if(I.luck + increase > limit)
		I.luck = limit
	else if(I.luck + increase < minimum)
		I.luck = minimum
	else
		I.luck += increase

	return ..()

/obj/item/tempering/luck/double
	name = "double lucky four leaf clover"
	desc = "Even luckier!"
	desc_extended = "An very rare conjoined four leaf clover. Grants +10 luck to an item when used, up to 100 luck. If the improvement results in a luck value below 40, it will set the object's luck to 40."
	icon_state = "luck2"

	increase = 10
	limit = 100
	minimum = 40

	value = 30000
	value_burgerbux = 30000