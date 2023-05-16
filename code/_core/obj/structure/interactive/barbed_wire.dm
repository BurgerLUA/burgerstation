/obj/structure/interactive/barbed_wire
	name = "barbed wire"
	desc = "Ouch!"
	desc_extended = "An ancient, almost torturous design meant to inhibit the movement of soldiers and civilians while using as little materials as possible."

	icon = 'icons/obj/structure/barbed_wire.dmi'
	icon_state = "wire"

	health = /health/construction/barbed_wire
	health_base = 300

	density = TRUE

	hazardous = TRUE

	plane = PLANE_MOVABLE
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE

/obj/structure/interactive/barbed_wire/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	if(is_living(O))
		var/mob/living/L = O
		if(L.health)
			L.health.adjust_loss_smart(brute=rand(5,10))
			if(L.health.organic)
				L.add_status_effect(SLOW,40,40)

/obj/structure/interactive/barbed_wire/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)