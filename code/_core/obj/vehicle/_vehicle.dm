/obj/vehicle/
	name = "Vehicle"
	desc = "A large vehicle that holds a driver"

	var/mob/living/passengers //Slot 1 is a driver.
	var/passengers_max = 1

	density = 0
	opacity = 0
	anchored = 0

/obj/vehicle/New(var/desired_loc)
	..()
	passengers = list()

/obj/vehicle/Enter(atom/movable/O, atom/oldloc) //When we try to enter the vehicle.

	if(!is_living(O))
		return FALSE


	if(length(passengers) >= passengers_max)
		return FALSE
	return ..()


/obj/vehicle/Entered(atom/movable/Obj,atom/OldLoc)

	if(!is_living(Obj))
		return ..()

	var/mob/living/L = Obj
	L.driving = src
	passengers += L

	return ..()

/obj/vehicle/Exit(atom/movable/O, atom/newloc) //When we try to exit the vehicle.
	return ..()

/obj/vehicle/Exited(atom/movable/Obj, atom/newloc)
	if(!is_living(Obj))
		return ..()

	var/mob/living/L = Obj
	L.driving = null
	passengers -= L

	return ..()

/obj/vehicle/dropped_by_object(caller,object)
	if(!is_living(object) || caller != object || get_dist(caller,src) > 1)
		return ..()

	var/mob/living/L = object
	L.Move(src)

	return TRUE

