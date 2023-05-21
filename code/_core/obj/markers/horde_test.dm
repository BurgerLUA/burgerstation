var/global/list/turf/horde_test_turfs = list()

/obj/marker/horde_test
	name = "horde test"

/obj/marker/horde_test/New(var/desired_loc)
	horde_test_turfs += loc
	return ..()

/obj/marker/horde_test/Finalize()
	. = ..()
	qdel(src)


var/global/list/turf/horde_test_target_turfs = list()

/obj/marker/horde_test_target
	name = "horde test target"

/obj/marker/horde_test_target/New(var/desired_loc)
	horde_test_target_turfs += loc
	return ..()

/obj/marker/horde_test_target/Finalize()
	. = ..()
	qdel(src)


var/global/list/turf/horde_test_survivor_spawn_turfs = list()

/obj/marker/horde_test_survivor
	name = "horde test survivor spawn"

/obj/marker/horde_test_survivor/New(var/desired_loc)
	horde_test_survivor_spawn_turfs += loc
	return ..()

/obj/marker/horde_test_survivor/Finalize()
	. = ..()
	qdel(src)

