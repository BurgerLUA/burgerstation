/obj/item/bikehorn
	name = "bike horn"
	desc = "PRAISE BE TO THE HONKMOTHER!"
	desc_extended = "You guessed it - Makes the signature HONK sound when used in your hand."
	icon = 'icons/obj/item/fluff/bikehorn.dmi'
	damage_type = /damagetype/item/light

	value = 20

	icon_state_held_left = "held_left"
	icon_state_held_right = "held_right"

	weight = 0.25

/obj/item/bikehorn/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(20)

	var/turf/T = get_turf(src)

	play_sound('sound/items/bikehorn.ogg',T)

	create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)

	return TRUE


/obj/item/bikehorn/magic
	name = "magic bikehorn"
	value = 500
	rarity = RARITY_RARE
	value_burgerbux = 5

/obj/item/bikehorn/magic/click_self(var/mob/caller,location,control,params)

	. = ..()

	if(.)
		for(var/mob/living/L in viewers(VIEW_RANGE,caller))
			if(L.dead)
				continue
			L.do_emote("spin")


