obj/item/fluff/bikehorn
	name = "bike horn"
	desc = "PRAISE BE TO THE HONKMOTHER!"
	desc_extended = "You guessed it - Makes the signature HONK sound when used in your hand. Please don't spam."
	icon = 'icons/obj/item/fluff/bikehorn.dmi'
	damage_type = /damagetype/item/light

	attack_delay = 1
	attack_delay_max = 5

	value = 500

	icon_state_held_left = "held_left"
	icon_state_held_right = "held_right"

obj/item/fluff/bikehorn/click_self(var/mob/caller)

	. = ..()

	if(caller.can_attack(null,src))
		play('sound/items/bikehorn.ogg',src)
		create_alert(VIEW_RANGE,src,caller,ALERT_LEVEL_NOISE)
		src.attack_next = world.time + src.get_attack_delay(caller)

	return .