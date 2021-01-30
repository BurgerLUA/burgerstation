/obj/item/dice
	name = "dice"
	desc = "For people who like to game."
	desc_extended = "A perfectly crafted, absolutely even dice that cannot be influenced by external factors."
	icon = 'icons/obj/item/dice.dmi'
	icon_state = null

	var/max_states = 6


/obj/item/dice/Finalize()

	var/image/I = new(icon,initial(icon_state))
	add_underlay(I)

	icon_state = "[icon_state]-[max_states]"

	return ..()

/obj/item/dice/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown and it hits an object.
	roll_dice(owner)
	return ..()

/obj/item/dice/proc/on_result(var/mob/caller,var/chosen_number,var/silent=FALSE)

	if(!silent)
		if(caller)
			caller.visible_message(span("notice","\The [caller.name] rolls \the [src.name]. It lands on [chosen_number]."))
		else
			src.visible_message(span("notice","\The [src.name] rolls. It lands on [chosen_number]."))

	return TRUE

/obj/item/dice/proc/roll_dice(var/mob/caller,var/silent=FALSE)

	var/chosen_number = rand(1,max_states)

	on_result(caller,chosen_number,silent)

	icon_state = "[initial(icon_state)]-[chosen_number]"

	return TRUE

/obj/item/dice/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	roll_dice(caller)

	return TRUE


/obj/item/dice/d6
	name = "d6"
	icon_state = "d6"
	max_states = 6

	value = 20

/obj/item/dice/d6/black
	icon_state = "de6"

	value = 20

/obj/item/dice/d20
	name = "d20"
	icon_state = "d20"
	max_states = 20

	value = 40

/obj/item/dice/d20/cursed
	name = "d20 of chance"
	icon_state = "d20_cursed"
	max_states = 20
	var/used = 0

	value = 2000

/obj/item/dice/d20/cursed/Finalize()

	. = ..()

	icon_state = "blank"

	return .

/obj/item/dice/d20/cursed/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("used")
	return .

/obj/item/dice/d20/cursed/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("used")
	return .

/obj/item/dice/d20/cursed/roll_dice(var/mob/caller,var/silent=FALSE)

	if(used)
		icon_state = "[initial(icon_state)]-[used]"
		return TRUE

	return ..()

/obj/item/dice/d20/cursed/on_result(var/mob/caller,var/chosen_number,var/silent=FALSE)

	if(!caller || silent || !is_living(caller))
		return ..()

	var/mob/living/L = caller

	. = ..()

	if(qdeleting)
		return .

	switch(chosen_number)
		if(1)
			L.to_chat(span("danger","You don't feel so good..."))
			var/mob/living/advanced/player/found_player
			for(var/mob/living/advanced/player/P in view(L))
				if(P == L || P.dead)
					continue
				found_player = P
				break
			if(found_player)
				var/list/split_name = splittext(found_player.name," ")
				var/last_name = split_name[length(split_name)]
				L.do_say("[found_player.gender == MALE ? "Mr." : "Mrs."] [last_name], I don't feel so good...")
			L.dust()
		if(2)
			L.to_chat(span("danger","Oh shi-"))
			L.smite()
		if(3)
			if(L.blood_type)
				var/reagent/R = REAGENT(L.blood_type)
				for(var/i=1,i<=9,i++)
					create_blood(/obj/effect/cleanable/blood/splatter,get_turf(src),R.color,rand(-32,32),rand(-32,32))
				L.to_chat(span("danger","Wait, where did all my blood go?!"))
				L.blood_volume = 0
			else
				if(L.health.organic)
					L.to_chat(span("danger","Woe, plague be upon me!"))
					var/turf/T = get_turf(L)
					for(var/i=1,i<=5,i++)
						CREATE(/mob/living/simple/passive/mouse/grey,T)
					L.health.adjust_loss_smart(tox=1000)
				else
					L.to_chat(span("danger","My sensors indicate I am overheating!"))
					L.health.adjust_loss_smart(burn=1000)
		if(4)
			if(L.health.organic)
				L.to_chat(span("danger","Woe, plague be upon me!"))
				var/turf/T = get_turf(L)
				for(var/i=1,i<=5,i++)
					CREATE(/mob/living/simple/passive/mouse/grey,T)
				L.health.adjust_loss_smart(tox=1000)

			else
				L.to_chat(span("danger","My sensors indicate I am overheating!"))
				L.health.adjust_loss_smart(burn=1000)
		if(5)
			L.to_chat(span("danger","Oh no I hope I don't d-"))
			L.death()
		if(6)
			L.to_chat(span("danger","I'M ON FIRE!"))
			L.ignite(60)
		if(7)
			if(L.health.organic)
				L.to_chat(span("warning","Wait why does it feel like I'm-"))
				L.intoxication = 3000
			else
				L.to_chat(span("warning","My sensors indicate I am overheating!"))
				L.health.adjust_loss_smart(burn=L.health.health_max)
		if(8)
			L.to_chat(span("warning","I feel like I put on some weight..."))
			L.nutrition_fast += L.nutrition
			L.nutrition = 0
			L.nutrition_quality = 0
		if(9)
			L.to_chat(span("notice","Wow, literally nothing happened. How lame."))
		if(10)
			L.to_chat(span("notice","Wow, my luck feels... average."))
			L.add_attribute_xp(ATTRIBUTE_LUCK,50 - L.get_attribute_level(ATTRIBUTE_LUCK))
		if(11)
			L.to_chat(span("notice","Egg."))
			CREATE(/obj/item/container/food/egg/chicken,get_turf(src))
		if(12)
			L.to_chat(span("notice","Hey, magic!"))
			CREATE(/obj/item/supply_crate/magic,get_turf(src))
		if(13)
			L.to_chat(span("notice","Wait... is 13 lucky or unlucky? Guess I'll find out with another roll..."))
			return TRUE //Don't delete.
		if(14)
			L.to_chat(span("notice","Hey, some gems! Wait..."))
			CREATE(/obj/item/currency/telecrystals/player_antagonist_spawn,get_turf(src))
		if(15)
			L.to_chat(span("notice","Hey, more magic!"))
			var/turf/T = get_turf(src)
			for(var/i=1,i<=5,i++)
				CREATE(/obj/item/supply_crate/magic,T)
		if(16)
			L.to_chat(span("notice","Hey, 16, that's pretty good. Nothing happened, but I do feel luckier..."))
			L.add_attribute_xp(ATTRIBUTE_LUCK,5)
		if(17)
			L.to_chat(span("notice","17? Such luck should be rewarded... with even more luck."))
			CREATE(/obj/item/tempering/luck/double,get_turf(src))
		if(18)
			L.to_chat(span("notice","Wait, did god drop their epi-pen?"))
			CREATE(/obj/item/container/syringe/medipen/adminomnizine,get_turf(src))
		if(19)
			L.to_chat(span("notice","I feel like a new person... with no debts!"))
			L.resurrect()
			if(is_player(L))
				var/mob/living/advanced/player/P = L
				P.currency = max(P.currency,50000)
				P.revenue = 0
				P.expenses = 0
				P.last_tax_payment = world.realtime
		if(20)
			L.to_chat(span("notice","NAT 20! I AM A GOD!"))
			CREATE(/obj/item/clothing/mask/godlike,get_turf(src))

	used = chosen_number

	return .



/obj/item/dice/d2
	name = "d2"
	icon_state = "d2"
	max_states = 2

	value = 40

/obj/item/dice/d4
	name = "d4"
	icon_state = "d4"
	max_states = 4

	value = 40

/obj/item/dice/d8
	name = "d8"
	icon_state = "d8"
	max_states = 8

	value = 40

/obj/item/dice/d10
	name = "d10"
	icon_state = "d10"
	max_states = 10

	value = 40

/obj/item/dice/d00
	name = "d00"
	icon_state = "d00"
	max_states = 10

	value = 40

/obj/item/dice/d12
	name = "d12"
	icon_state = "d12"
	max_states = 12

	value = 40