/obj/item/fishing/rod
	name = "fishing rod"
	desc = "Catch fish with this!"
	desc_extended = "A very standard fishing rod that allows you to fish in areas containing water. Requires a lure, a line, and some bait to function."

	icon = 'icons/obj/item/fishing/rod.dmi'
	icon_state = "inventory"

	drop_sound = 'sound/items/drop/scrap.ogg'

	size = SIZE_3
	can_rename = TRUE

	weight = 5

	var/obj/item/fishing/lure/lure
	var/obj/item/fishing/line/line
	var/obj/item/fishing/bait/bait

	var/obj/effect/fishing_bob/fishing_bob
	var/obj/effect/alert/exclaim/fishing_alert

	var/turf/simulated/liquid/fishing_turf

	var/mob/last_caller

	var/snagged_fish
	var/catch_time

	var/next_tick = 0
	var/nospam
	var/compact = FALSE

	value = 200

	rarity = RARITY_UNCOMMON

/obj/item/fishing/rod/PreDestroy()
	QDEL_NULL(lure)
	QDEL_NULL(line)
	QDEL_NULL(bait)

	QDEL_NULL(fishing_bob)
	QDEL_NULL(fishing_alert)

	. = ..()


/obj/item/fishing/rod/Destroy()
	. = ..()
	fishing_turf = null
	last_caller = null



/obj/item/fishing/rod/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("lure")
	SAVEATOM("line")
	SAVEATOM("bait")

/obj/item/fishing/rod/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("lure")
	LOADATOM("line")
	LOADATOM("bait")

/obj/item/fishing/rod/get_value()
	. = ..()
	if(line) . += line.get_value()
	if(lure) . += lure.get_value()
	if(bait) . += bait.get_value()

/obj/item/fishing/rod/update_overlays()
	. = ..()
	if(line && !compact)
		var/obj/item/fishing/line/L = line
		var/image/I = new/image('icons/obj/item/fishing/rod.dmi',"string")
		I.color = L.color
		add_overlay(I)

/obj/item/fishing/rod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(fishing_turf) //Don't do anything while fishing.
		return ..()



	if(is_inventory(object))
		var/mob/living/advanced/C = caller
		var/obj/item/object_removed
		if(bait)
			object_removed = bait
			bait = null
		else if(lure)
			object_removed = lure
			lure = null
		else if(line)
			object_removed = line
			line = null
			update_sprite()
		if(!object_removed)
			caller.to_chat(span("notice","There is nothing to remove from \the [src.name]."))
			return TRUE
		caller.to_chat(span("notice","You remove \the [object_removed.name]."))
		object_removed.drop_item(get_turf(src))
		C.put_in_hands(object_removed,params)
		return TRUE

	if(is_item(object))
		if(istype(object,/obj/item/fishing/line/))
			var/obj/item/fishing/line/P = object
			if(line)
				caller.to_chat(span("notice","You swap out \the [line.name] for \the [P.name]."))
				line.drop_item(get_turf(caller))
				line = null
			else
				caller.to_chat(span("notice","You insert \the [P.name] into \the [src.name]."))

			line = P
			P.drop_item(src)
			update_sprite()
			return TRUE

		if(istype(object,/obj/item/fishing/lure/))
			var/obj/item/fishing/lure/P = object
			if(lure)
				caller.to_chat(span("notice","You swap out \the [lure.name] for \the [P.name]."))
				lure.drop_item(get_turf(caller))
				lure = null
			else
				caller.to_chat(span("notice","You insert \the [P.name] onto \the [src.name]."))

			lure = P
			P.drop_item(src)
			return TRUE

		if(istype(object,/obj/item/fishing/bait/))
			var/obj/item/fishing/bait/P = object
			if(bait)
				caller.to_chat(span("notice","You swap out \the [bait.name] for \the [P.name]."))
				bait.drop_item(get_turf(caller))
				bait = null
			else
				caller.to_chat(span("notice","You attach \the [P.name] to \the [src.name]."))

			bait = P
			P.drop_item(src)
			return TRUE

	return ..()

/obj/item/fishing/rod/think()

	if(next_tick <= world.time)
		next_tick = world.time + SECONDS_TO_DECISECONDS(1)
		if(snagged_fish)
			var/time_since_snag = world.time - catch_time
			if(!is_inventory(src.loc) || time_since_snag >= snagged_fish) //Too slow...
				snagged_fish = null
				if(line.break_on_failure > 0 && rand(0,100) <= line.break_on_failure) //Bad line.
					last_caller?.to_chat(span("danger","Too slow... your [line.name] snaps, and you lose your [bait.name] and [lure.name]!"))
					QDEL_NULL(line)
					QDEL_NULL(bait)
					QDEL_NULL(lure)
					QDEL_NULL(fishing_bob)
					QDEL_NULL(fishing_alert)
					update_sprite()
					fishing_turf = null
					return FALSE

				if(!bait.nice_bait) //Fish stole your bait!
					last_caller?.to_chat(span("warning","Too slow... the fish steals your [bait.name]!"))
					snagged_fish = null
					fishing_turf = null
					QDEL_NULL(fishing_bob)
					QDEL_NULL(fishing_alert)
					bait.add_item_count(-1)
					if(bait.qdeleting)
						bait = null
					return FALSE

				last_caller?.to_chat(span("warning","Too slow... the fish got away..."))
				snagged_fish = null

		else if(fishing_turf)
			if(!is_inventory(src.loc))
				fishing_turf = null
				last_caller = null
				QDEL_NULL(fishing_bob)
			else if(prob(5 + lure.chance_bonus) && nospam <= world.time)
				fishing_alert = new(fishing_turf)
				snagged_fish = rand(5,20) + lure.time_bonus
				catch_time = world.time
				if(lure.catchsound)
					play_sound(lure.catchsound,get_turf(lure),range_min=VIEW_RANGE*0.5,range_max=VIEW_RANGE)
				animate(fishing_bob,pixel_y=-10,pixel_x=rand(-4,4),time=5)
				animate(fishing_bob,pixel_y=0,pixel_x=rand(-2,2),time=10)


	return ..()


/obj/item/fishing/rod/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)


	INTERACT_CHECK

	if(object.plane >= PLANE_HUD)
		return ..()

	if(fishing_turf)
		if(snagged_fish) //Caught something!
			var/mob/living/C = caller
			var/turf/T = get_step(C,C.dir)
			if(!is_floor(T))
				T = get_turf(C)
			var/score_add = (20/snagged_fish)
			var/score_mul = 1.5 - ((world.time - catch_time)/snagged_fish)
			var/score_total = (score_add + lure.rarity_bonus)*score_mul

			var/list/spawned_loot = SPAWN_LOOT(fishing_turf.fishing_rewards,T,score_total)

			caller.visible_message(
				span("notice","\The [caller.name] reels their [src.name] in!"),
				span("notice","You reel your [src.name] in!")
			)

			if(length(spawned_loot))
				var/list/object_names = list()
				for(var/k in spawned_loot)
					var/atom/movable/M = k
					object_names += M.name
				caller.to_chat(span("notice","You caught [english_list(spawned_loot)]!"))
			else
				caller.to_chat(span("notice","You fail to catch anything. At least your bait is saved..."))

			STOP_THINKING(src)
			fishing_turf = null
			nospam = null
			snagged_fish = null
			QDEL_NULL(fishing_bob)
			QDEL_NULL(fishing_alert)
			return TRUE
		else //Reel it in without catching anything.
			STOP_THINKING(src)
			fishing_turf = null
			nospam = null
			QDEL_NULL(fishing_bob)
			caller.visible_message(span("notice","\The [caller] reels their [src.name] in."),span("notice","You reel your [src.name] in."))
			return TRUE

	if(istype(object,/turf/simulated/liquid/))
		if(compact)
			caller.to_chat(span("notice","Extend your fishing rod first!"))
			return TRUE
		var/turf/simulated/liquid/H = object
		if(!H.fishing_rewards)
			caller.to_chat(span("warning","There seems to be no fish here..."))
			return TRUE
		if(!line || !lure || !bait)
			caller.to_chat(span("warning","You need a line, a lure, and bait to use \the [src.name]!"))
			return TRUE
		if(H.fishing_rewards != bait.valid_loot_type)
			caller.to_chat(span("warning","This doesn't seem to be the right bait..."))
			return TRUE
		if(!line.lavaproof && istype(object,/turf/simulated/liquid/lava))
			caller.to_chat(span("warning","You need a lavaproof fishing line in order to fish in lava!"))
			return TRUE
		INTERACT_CHECK
		INTERACT_DELAY(5)
		fishing_turf = H
		last_caller = caller
		caller.visible_message(span("notice","\The [caller] casts their [src.name] into \the [fishing_turf.name]."),span("notice","You cast your [src.name] into \the [fishing_turf.name]."))
		fishing_bob = new(fishing_turf)
		fishing_bob.icon_state = "[lure.bob_icon_state]_out"
		animate(fishing_bob,pixel_x=rand(-10,10),pixel_y=rand(-10,10),time=50)
		nospam = world.time + SECONDS_TO_DECISECONDS(1)
		START_THINKING(src)
		return TRUE

	return ..()

/obj/item/fishing/rod/get_examine_list(var/mob/living/advanced/caller)

	. = ..()

	if(line) . += span("notice","It has \the [line.name] equipped.")
	else . += span("notice","It has no line.")
	if(lure) . += span("notice","It has \the [lure.name] equipped.")
	else . += span("notice","It has no lure.")
	if(bait) . += span("notice","It has \the [bait.name] equipped.")
	else . += span("notice","It has no bait.")

/obj/item/fishing/rod/telescopic
	name = "telescopic fishing rod"
	desc = "Bass pro certified!"
	desc_extended = "A collapsable fishing rod that allows you to fish in areas containing water. Requires a lure, a line, and some bait to function."
	value = 2000
	icon = 'icons/obj/item/fishing/rodtelescopic.dmi'
	compact = TRUE
	size = SIZE_1

	rarity = RARITY_RARE

/obj/item/fishing/rod/telescopic/click_self(var/mob/caller,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(5)
	if(fishing_turf)
		return TRUE
	compact = !compact
	update_sprite()
	play_sound('sound/items/drop/accessory.ogg',get_turf(src),range_max=VIEW_RANGE*0.2)
	return TRUE

/obj/item/fishing/rod/telescopic/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("compact")

/obj/item/fishing/rod/telescopic/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("compact")

/obj/item/fishing/rod/telescopic/update_icon()

	if(!compact)
		icon_state = "[initial(icon_state)]_out"
		icon_state_held_left = "[initial(icon_state_held_left)]_out"
		icon_state_held_right = "[initial(icon_state_held_right)]_out"
		size = SIZE_3
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		size = SIZE_1
	update_held_icon()

	return ..()