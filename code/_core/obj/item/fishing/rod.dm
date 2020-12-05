/obj/item/fishing/rod // there are two rods, this is the correct one, other is located next to summon books
	name = "fishing rod"
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_2
	weight = 2
	var/lavaproof = 0
	var/lcolor = "#FFFFFF"
	var/nice_bait = 0
	var/break_on_failure = 0
	var/break_on_success = 0
	var/win = 0
	var/win_time = 0
	var/timemin = 3
	var/timemax = 9
	var/react = 9
	var/bobsprite = null
	var/catchsound = "sound/ui/message_ping.ogg"
	var/fishing = 0
	var/fishingzone = 0
	var/wished_fishingzone = 0
	var/mintime = 0
	var/maxtime = 0
	var/list/obj/item/effrewards = list()
	var/list/obj/item/wekrewards = list()
	var/fish_loc

	var/obj/item/fishing/lure
	var/obj/item/fishing/line
	var/obj/item/fishing/bait

/obj/item/fishing/rod/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("lure")
	SAVEATOM("line")
	SAVEATOM("bait")
	return .

/obj/item/fishing/rod/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("lure")
	LOADATOM("line")
	LOADATOM("bait")
	update_rod_stats()
	return .

/obj/item/fishing/rod/proc/get_line()
	return line

/obj/item/fishing/rod/proc/get_lure()
	return lure

/obj/item/fishing/rod/proc/get_bait()
	return bait

/obj/item/fishing/rod/proc/update_rod_stats()
	if(line)
		var/obj/item/fishing/line/L = get_line()
		lavaproof = L.lavaproof
		break_on_failure = L.break_on_failure
		break_on_success = L.break_on_success
		lcolor = L.color
	if(lure)
		var/obj/item/fishing/lure/L = get_lure()
		bobsprite = L.bobsprite
		catchsound = L.catchsound
	if(bait)
		var/obj/item/fishing/bait/L = get_bait()
		effrewards = L.effrewards
		wekrewards = L.wekrewards
		nice_bait = L.nice_bait
		wished_fishingzone = L.wished_fishingzone
	update_overlays()
	update_sprite()
	return

/obj/item/fishing/rod/update_overlays()
	. = ..()
	if(line)
		var/image/I = new/image('icons/obj/item/fishing/rod.dmi',"string")
		I.color = lcolor
		add_overlay(I)
	return .


/obj/item/fishing/rod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)
	if(fishing == 0)
		if(bait && is_inventory(object))
			var/obj/hud/inventory/I = object
			if(I.add_held_object(bait))
				caller.to_chat(span("notice","You remove \the [bait.name]."))
				bait = null
				update_rod_stats()
				return
		if(lure && is_inventory(object))
			var/obj/hud/inventory/I = object
			if(I.add_held_object(lure))
				caller.to_chat(span("notice","You remove \the [lure.name]."))
				lure = null
				update_rod_stats()
				return
		if(line && is_inventory(object))
			var/obj/hud/inventory/I = object
			if(I.add_held_object(line))
				caller.to_chat(span("notice","You remove \the [line.name]."))
				line = null
				update_rod_stats()
				return
		if(istype(object,/obj/item/))
			if(istype(object,/obj/item/fishing/line/))
				var/obj/item/fishing/line/P = object
				if(line)
					caller.to_chat(span("notice","You swap out \the [line.name] for \the [P.name]."))
					line.drop_item(get_turf(caller))
					update_rod_stats()
					line = null
				else
					caller.to_chat(span("notice","You insert \the [P.name] into \the [src.name]."))

				line = P
				P.drop_item(src)
				update_rod_stats()

				return TRUE

			if(istype(object,/obj/item/fishing/lure/))
				var/obj/item/fishing/lure/P = object
				if(lure)
					caller.to_chat(span("notice","You swap out \the [lure.name] for \the [P.name]."))
					lure.drop_item(get_turf(caller))
					update_rod_stats()
					lure = null
				else
					caller.to_chat(span("notice","You insert \the [P.name] onto \the [src.name]."))

				lure = P
				P.drop_item(src)
				update_rod_stats()

				return TRUE

			if(istype(object,/obj/item/fishing/bait/))
				var/obj/item/fishing/bait/P = object
				if(bait)
					caller.to_chat(span("notice","You swap out \the [bait.name] for \the [P.name]."))
					bait.drop_item(get_turf(caller))
					update_rod_stats()
					bait = null
				else
					caller.to_chat(span("notice","You attach \the [P.name] to \the [src.name]."))

				bait = P
				P.drop_item(src)
				update_rod_stats()

				return TRUE
	return ..()

/obj/item/fishing/rod/think()
	var/turf/T = get_turf(fish_loc)
	if(world.time > maxtime)
		play(catchsound,T)
		win++
		return FALSE
	if(world.time > mintime)
		if(win_time == 0)
			play(catchsound,T)
			win++
			win_time++
	return TRUE

/obj/item/fishing/rod/proc/get_reward(var/mob/caller as mob,var/atom/object,location,control,params)

	var/rewards
	if(fishingzone == wished_fishingzone)
		rewards = effrewards
	else rewards = wekrewards
	var/list/spawned_loot = CREATE_LOOT(rewards,get_turf(src.loc))
	for(var/k in spawned_loot)
		var/obj/item/I = k
		animate(I,pixel_x = rand(-8,8),pixel_y = rand(-8,8),time=5)
	if(nice_bait == 0)
		bait = null
		update_rod_stats()
	return

/obj/item/fishing/rod/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(fishing == 1)
		stop_thinking(src)
		var/turf/simulated/hazard/T = get_turf(fish_loc)
		fishing--
		T.fishing--
		T.fishtime()
		if(win > 1)
			if(break_on_failure > 0)
				var/check = (rand(0,100))
				if(check < break_on_failure)
					line = null
					caller.to_chat(span("notice","Your line snaps!"))
					return
			caller.to_chat(span("notice","It got away..."))
			return
		if(win == 1)
			caller.to_chat(span("notice","You caught something!"))
			if(break_on_success > 0)
				var/check = (rand(0,100))
				if(check < break_on_success)
					line = null
					caller.to_chat(span("notice","Your line also snaps in the process..."))
			get_reward()
			return
		caller.to_chat(span("notice","You reel back in."))
		return FALSE
	var/turf/L = object
	if(istype(L,/turf/simulated/hazard/))
		if(object.name == "salty water")
			fishingzone = 1
		if(object.name == "water")
			fishingzone = 2
		if(object.name == "lava") // shit redundant but hey ynever know if new tiles get added :flushed:
			if(lavaproof == 1 & !wekrewards)
				fishingzone = 10
			else return
		var/turf/simulated/hazard/T = get_turf(object)
		if(!line)
			caller.to_chat(span("notice","You need a line for this."))
			return FALSE
		if(!lure)
			caller.to_chat(span("notice","You need a lure for this."))
			return FALSE
		if(!bait)
			caller.to_chat(span("notice","You need bait for this."))
			return FALSE
		if(fishing == 0)
			fish_loc = T
			T.bobsprite = bobsprite
			T.fishing++
			mintime = world.time + SECONDS_TO_DECISECONDS(rand(timemin,timemax))
			maxtime = mintime + react
			T.fishtime()
			fishing++
			win = 0
			win_time = 0
			start_thinking(src)
		caller.to_chat(span("notice","You cast a line."))
	return

/obj/item/fishing/rod/get_examine_list(var/mob/living/advanced/caller)

	. = ..()

	if(line) . += span("notice","It has \the [line.name] equipped.")
	else . += span("notice","It has no line.")
	if(lure) . += span("notice","It has \the [lure.name] equipped.")
	else . += span("notice","It has no lure.")
	if(bait) . += span("notice","It has \the [bait.name] equipped.")
	else . += span("notice","It has no bait.")
	return .

/obj/item/fishing/rod/basic
	name = "basic fishing rod"
	desc = "back on da fishin spot"
	desc_extended = "An aquatic genocide device. Requires a line, a lure and bait."
	icon = 'icons/obj/item/fishing/rod.dmi'
	value = 150

/obj/item/fishing/rod/dumb
	name = "dumb fishing rod"
	desc = "hrngrnh fisheing"
	desc_extended = "A funny fish larceny tool."
	icon = 'icons/obj/item/weapons/melee/clubs/shovel.dmi'
	value = 1069
