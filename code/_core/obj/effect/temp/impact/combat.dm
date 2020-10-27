obj/effect/temp/impact/combat
	name = "combat effect"
	icon = 'icons/obj/effects/combat.dmi'
	duration = 3
	mouse_opacity = 0
	plane = PLANE_EFFECT

obj/effect/temp/impact/combat/New(var/desired_loc,var/desired_pixel_x,var/desired_pixel_y)
	. = ..()
	pixel_x = desired_pixel_x
	pixel_y = desired_pixel_y
	return .

/obj/effect/temp/impact/combat/smash
	icon_state = "smash"

/obj/effect/temp/impact/combat/punch
	icon_state = "punch"

/obj/effect/temp/impact/combat/bite
	icon_state = "bite"

/obj/effect/temp/impact/combat/claw
	icon_state = "claw"

/obj/effect/temp/impact/combat/kick
	icon_state = "kick"

/obj/effect/temp/impact/combat/disarm
	icon_state = "disarm"

/obj/effect/temp/impact/combat/block
	icon_state = "shield"