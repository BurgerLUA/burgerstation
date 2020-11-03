obj/item/bikehorn
	name = "bike horn"
	desc = "PRAISE BE TO THE HONKMOTHER!"
	desc_extended = "You guessed it - Makes the signature HONK sound when used in your hand."
	icon = 'icons/obj/item/fluff/bikehorn.dmi'
	damage_type = /damagetype/item/light

	value = 20

	icon_state_held_left = "held_left"
	icon_state_held_right = "held_right"

	weight = 0.25

obj/item/bikehorn/click_self(var/mob/caller)

	. = ..()

	if(caller.can_attack(null,src))
		var/turf/T = get_turf(src)
		play('sound/items/bikehorn.ogg',T)
		create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)
		src.attack_next = world.time + 10

	return .