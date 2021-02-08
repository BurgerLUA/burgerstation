/obj/item/fishing/rod
	name = "fishing rod"
	desc = "Catch fish with this!"
	desc_extended = "A very standard fishing rod that allows you to fish in areas containing water. Requires a lure, a line, and some bait to function."

	icon = 'icons/obj/item/fishing/rod.dmi'
	icon_state = "inventory"

	drop_sound = 'sound/items/drop/scrap.ogg'

	size = SIZE_3

	weight = 5

	var/obj/item/fishing/lure/lure
	var/obj/item/fishing/line/line
	var/obj/item/fishing/bait/bait

	var/obj/effect/fishing_bob/fishing_bob

	var/turf/simulated/hazard/fishing_turf

	var/mob/last_caller

	var/snagged_fish
	var/catch_time

	var/next_tick = 0
	var/nospam

	value = 200

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
	return .

/obj/item/fishing/rod/update_overlays()
	. = ..()
	if(line)
		var/obj/item/fishing/line/L = line
		var/image/I = new/image('icons/obj/item/fishing/rod.dmi',"string")
		I.color = L.color
		add_overlay(I)
	return .


/obj/item/fishing/rod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(fishing_turf) //Don't do anything while fishing.
		return ..()



	if(is_inventory(object))
		var/obj/hud/inventory/I = object
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
		I.add_object(object_removed)
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
					update_sprite()
					fishing_turf = null
					return FALSE

				if(!bait.nice_bait) //Fish stole your bait!
					last_caller?.to_chat(span("warning","Too slow... the fish steals your [bait.name]!"))
					snagged_fish = null
					fishing_turf = null
					QDEL_NULL(fishing_bob)
					bait.add_item_count(-1)
					if(bait.qdeleting) bait = null
					return FALSE

				last_caller?.to_chat(span("warning","Too slow... the fish got away..."))
				snagged_fish = null

		else if(fishing_turf)
			if(!is_inventory(src.loc))
				fishing_turf = null
				last_caller = null
				QDEL_NULL(fishing_bob)
			else if(prob(5 + lure.chance_bonus) && nospam <= world.time)
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
			var/score_add = (20/snagged_fish)
			var/score_mul = 1.5 - ((world.time - catch_time)/snagged_fish)
			var/loot/L = LOOT(fishing_turf.fishing_rewards)
			var/list/loot_table = L.loot_table.Copy()
			for(var/k in loot_table)
				var/v = loot_table[k]
				if(k == null)
					loot_table[k] = max(0,v - ((score_add + lure.rarity_bonus)*score_mul))
				else
					loot_table[k] = max(0,(v + score_add + lure.rarity_bonus)*score_mul)

			caller.visible_message(span("notice","\The [caller] reels their [src.name] in."),span("notice","You reel your [src.name] in."))

			var/desired_reward = pickweight(loot_table)
			if(ispath(desired_reward))
				var/atom/movable/reward = new desired_reward(get_step(caller,caller.dir))
				INITIALIZE(reward)
				GENERATE(reward)
				FINALIZE(reward)
				caller.to_chat(span("notice","You catch \a [reward.name]!"))
				if(!bait.nice_bait)
					bait.add_item_count(-1)
					if(bait.qdeleting) bait = null
			else
				caller.to_chat(span("notice","You fail to catch anything. At least your bait is saved..."))

			stop_thinking(src)
			fishing_turf = null
			nospam = null
			snagged_fish = null
			QDEL_NULL(fishing_bob)
			return TRUE
		else //Reel it in without catching anything.
			stop_thinking(src)
			fishing_turf = null
			nospam = null
			QDEL_NULL(fishing_bob)
			caller.visible_message(span("notice","\The [caller] reels their [src.name] in."),span("notice","You reel your [src.name] in."))
			return TRUE

	if(istype(object,/turf/simulated/hazard/))
		var/turf/simulated/hazard/H = object
		if(!H.fishing_rewards)
			return TRUE
		if(!line || !lure || !bait || H.type != bait.valid_turf)
			caller.to_chat(span("warning","You need a line, a lure, and the right bait in order to use \the [src.name]!"))
			return TRUE
		if(!line.lavaproof && istype(object,/turf/simulated/hazard/lava))
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
		start_thinking(src)
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
	return .