SUBSYSTEM_DEF(shuttle) //Also controls drop pods.
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

	var/next_pod_launch = -1 //Set to a value about 0 to allow pod launch.

/subsystem/shuttle/Initialize()
	log_subsystem(src.name,"Found [length(all_shuttle_controlers)] shuttle controllers.")
	return ..()

/subsystem/shuttle/on_life()

	for(var/k in all_shuttle_controlers)
		var/obj/shuttle_controller/SC = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		SC.time++
		if(SC.on_shuttle_think() == null)
			log_error("Shutting down controller for [SC]([SC.x])([SC.y])([SC.z]) as on_shuttle_think returned NULL!")
			all_shuttle_controlers -= SC
			qdel(SC)

	if(next_pod_launch > 0)

		var/time_left = DECISECONDS_TO_SECONDS(next_pod_launch - world.time)

		if(time_left >= 0)
			set_status_display("drop_pod","DROP\n[get_clock_time(time_left)]")

		if(time_left <= 0)

			next_pod_launch = world.time + SECONDS_TO_DECISECONDS(120)

			var/list/valid_pods = list()
			for(var/k in all_drop_pods)
				CHECK_TICK(75,FPS_SERVER)
				var/obj/structure/interactive/drop_pod/DP = k
				if(DP.state == POD_PRE_LAUNCH)
					valid_pods += DP

			if(length(valid_pods) && length(drop_pod_locations))
				var/drop_radius = 2 + length(valid_pods)
				var/turf/chosen_epicenter = pick(drop_pod_locations)
				var/list/valid_turfs = list()
				for(var/x=-drop_radius,x<=drop_radius,x+=2)
					for(var/y=-drop_radius,y<=drop_radius,y+=2)
						CHECK_TICK(75,FPS_SERVER)
						var/turf/T = locate(chosen_epicenter.x + x, chosen_epicenter.y + y, chosen_epicenter.z)
						if(!T)
							continue
						if(!T.is_safe_teleport())
							continue
						if(T.is_occupied())
							continue
						valid_turfs += T

				var/i=0
				for(var/k in valid_pods)
					CHECK_TICK(75,FPS_SERVER)
					if(!length(valid_turfs))
						break
					var/turf/T = pick(valid_turfs)
					valid_turfs -= T
					var/obj/structure/interactive/drop_pod/DP = k
					CALLBACK("set_state_\ref[DP]",10 + i*5,DP,/obj/structure/interactive/drop_pod/proc/set_state,POD_LAUNCHING,T)
					i++



	return TRUE