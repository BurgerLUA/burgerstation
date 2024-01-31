//Doesn't work.

/obj/item/storage/bagofhoarding
	name = "ancient bag of hoarding"
	desc = "we just warframe now"
	desc_extended = "A peculiar bag that can hold unlimited amounts of specific rare currencies. Can be dyed."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "moneybag"
	value = 10000
	var/hoard = 0				// how many inside
	var/targetitem				// this one is used for the base item roots, look further down for comments
	var/obj/item/goods			// targeted goods
	container_whitelist = list(
		/obj/item/currency/telecrystals,
		/obj/item/currency/magic_token,
		/obj/item/currency/gold_coin,
		/obj/item/currency/prize_ticket,
		/obj/item/currency/dosh,
		/obj/item/coin/antag_token
	)
	dynamic_inventory_count = 0
	is_container = FALSE
	dyeable = TRUE
	color = "#D8C1B0"
	value_burgerbux = 1

/obj/item/storage/bagofhoarding/get_value()
	. = ..()
	if(goods && hoard > 0)
		. += goods.get_value()*hoard

/obj/item/storage/bagofhoarding/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("hoard")
	SAVEPATH("targetitem")
	SAVEATOM("goods")

/obj/item/storage/bagofhoarding/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("hoard")
	LOADPATH("targetitem")
	LOADATOM("goods")
	if(!goods  || !targetitem)
		targetitem = null
		goods = null
		hoard = 0


/obj/item/storage/bagofhoarding/get_examine_details_list(mob/examiner)
	. = ..()
	if(goods && hoard > 0)
		. += span("notice","It currently holds [hoard] [initial(goods.name)]\s.")
	else
		. += span("notice","It does not currently hold anything.")

/obj/item/storage/bagofhoarding/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(hoard)
		if(istype(object,/obj/hud/inventory))
			var/mob/living/advanced/C = caller
			var/maxstack = goods.amount_max
			if(hoard <= maxstack)
				maxstack = hoard
			if((goods.amount_max == 1) || (hoard == 1))
				var/obj/item/M = new goods.type
				M.drop_item(get_turf(caller))
				C.put_in_hands(M,params)
				C.to_chat(span("notice","You take out a single [M.name]."))
				hoard--
				INTERACT_DELAY(1)
				if (!hoard)
					caller.to_chat(span("notice","The [src.name] is now empty."))
					goods = null
					return TRUE
				return TRUE
			var/choice = input("How many do you want to take out?","Total: [hoard] Max: [maxstack]") as null|num
			INTERACT_CHECK
			if(!choice) return TRUE
			if(choice >= maxstack)
				var/obj/item/M = new goods.type
				M.amount = maxstack
				M.update_sprite()
				hoard -= maxstack
				M.drop_item(get_turf(caller))
				C.put_in_hands(M,params)
			else if(choice < maxstack)
				var/obj/item/M = new goods.type
				M.amount = choice
				M.update_sprite()
				hoard -= choice
				M.drop_item(get_turf(caller))
				C.put_in_hands(M,params)
			if (!hoard)
				caller.to_chat(span("notice","\The [src.name] is now empty."))
				goods = null
			return TRUE
		var/obj/item/I = object
		if(ispath(I.type,targetitem))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			hoard += I.amount
			if(length(inventory_sounds))
				play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.2)
			qdel(I)
			return TRUE

	if(!hoard)
		var/obj/item/I = object
		var/obj/O
		for(var/allofem in container_whitelist)
			O = allofem
			if(ispath(I.type,O))
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				var/choice = input("Would you like to deposit [I.name] in \the [src.name]?","Hoarding Time") as null|anything in list("Yes","No")
				if(choice == "Yes")
					INTERACT_CHECK
					INTERACT_CHECK_OBJECT
					if(ispath(I.type,/obj/item/currency/telecrystals))	//i dont know how else to do this because like "goods" doesnt work here
						targetitem = /obj/item/currency/telecrystals	//otherwise things like obj/.../telecrystals/goblins and /treasure break
					if(ispath(I.type,/obj/item/currency/magic_token))	//cuz it needs to be shortened back to telecrystals/
						targetitem = /obj/item/currency/magic_token		//keeping the targetitem var is also important for some shit like the desc
					if(ispath(I.type,/obj/item/currency/gold_coin))			//works around it so eh good enough absolute shitcode but smiling imp emoji
						targetitem = /obj/item/currency/gold_coin
					if(ispath(I.type,/obj/item/currency/prize_ticket))
						targetitem = /obj/item/currency/prize_ticket
					if(ispath(I.type,/obj/item/currency/dosh))
						targetitem = /obj/item/currency/dosh
					if(ispath(I.type,/obj/item/coin/antag_token))
						targetitem = /obj/item/coin/antag_token
					goods = I
					hoard = I.amount
					I.amount = 1
					if(length(inventory_sounds))
						play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.2)
					caller.to_chat(span("notice","The [src.name] now accepts [I.name]\s."))
					qdel(I)
					return TRUE
	return ..()
