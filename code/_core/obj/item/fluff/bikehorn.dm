obj/item/fluff/bikehorn
	name = "bike horn"
	desc = "PRAISE BE TO THE HONKMOTHER!"
	desc_extended = "You guessed it - Makes the signature HONK sound when used in your hand. Please don't spam."
	icon = 'icons/obj/item/fluff/bikehorn.dmi'
	damage_type = /damagetype/item/light

	attack_delay = 4
	attack_delay_max = 10

	value = 2500

	icon_state_held_left = "held_left"
	icon_state_held_right = "held_right"

obj/item/fluff/bikehorn/click_self(var/atom/caller)
	. = ..()
		play('sound/items/bikehorn.ogg',src)
	return .