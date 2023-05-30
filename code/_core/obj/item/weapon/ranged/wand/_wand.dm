/obj/item/weapon/ranged/wand
	name = "wand"
	desc = "Wingardium Leviosa!"
	desc_extended = "A magic imbued wand that can fit any type of spell gem to amplify and improve its powers."
	icon_state = "inventory"

	company_type = "Wizard Federation"

	value = 0

	var/obj/item/weapon/ranged/spellgem/socketed_spellgem
	var/list/obj/item/supportgem/socketed_supportgems = list()

	automatic = TRUE

	var/wand_damage_multiplier = 1
	var/wand_mana_multiplier = 1

	dan_mode = TRUE

	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	bypass_balance_check = TRUE

	var/sockets = 0
	var/sockets_max = 7 //Absolute max is 7.

	var/list/stored_socket_overlays = list()

	var/hovering = FALSE //Cosmetic socket effects.
	var/hovering_alpha = 0

	tier_type = "wand"

	size = SIZE_2
	weight = 8

/obj/item/weapon/ranged/wand/MouseEntered(location,control,params)

	. = ..()

	if(!hovering && is_inventory(src.loc))
		hovering = TRUE
		START_THINKING(src)

/obj/item/weapon/ranged/wand/MouseExited(location,control,params)

	. = ..()

	if(hovering)
		hovering = FALSE
		START_THINKING(src)

/obj/item/weapon/ranged/wand/think()

	if(!is_inventory(src.loc))
		hovering = FALSE
		hovering_alpha = 0

	. = ..()

	if(hovering)
		hovering_alpha = min(hovering_alpha + 30,255)
	else
		hovering_alpha = max(hovering_alpha - 30,0)

	for(var/k in stored_socket_overlays)
		var/image/I = k
		I.alpha = hovering_alpha

	if(.)
		return .

	if(!hovering && hovering_alpha > 0)
		return TRUE

	if(hovering && hovering_alpha < 255)
		return TRUE

	return FALSE


/obj/item/weapon/ranged/wand/update_overlays()
	. = ..()

	for(var/k in stored_socket_overlays)
		var/obj/I = k
		vis_contents -= I
		qdel(I)
	stored_socket_overlays.Cut()

	for(var/i=1,i<=sockets,i++)
		var/x_offset = sin((i/sockets)*360)*14
		var/y_offset = cos((i/sockets)*360)*14
		var/obj/I = new(src)
		I.icon = 'icons/obj/item/spellgem.dmi'
		I.icon_state = "socket_backing"
		if(sockets == 1)
			I.pixel_x = -7
			I.pixel_y = 0
		else
			I.pixel_x = x_offset
			I.pixel_y = y_offset

		I.appearance_flags = RESET_COLOR | KEEP_TOGETHER | PIXEL_SCALE | RESET_ALPHA
		I.vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
		if(length(socketed_supportgems) >= i && socketed_supportgems[i])
			var/obj/item/supportgem/stored_gem = socketed_supportgems[i]
			var/image/G = new/image(stored_gem.icon,stored_gem.icon_state)
			G.appearance = stored_gem.appearance
			G.plane = FLOAT_PLANE
			G.layer = FLOAT_LAYER
			I.add_overlay(G)
			var/image/O = new/image('icons/obj/item/spellgem.dmi',"socket")
			I.add_overlay(O)
		add_vis_content(I)
		I.alpha = 0
		stored_socket_overlays += I

	var/obj/I = new(src)
	I.icon = 'icons/obj/item/spellgem.dmi'
	I.icon_state = "socket_backing"
	I.appearance_flags = RESET_COLOR | KEEP_TOGETHER | PIXEL_SCALE | RESET_ALPHA
	I.vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	if(sockets == 1)
		I.pixel_x = 7
		I.pixel_y = 0
	if(socketed_spellgem)
		var/image/G = new/image(socketed_spellgem.icon,socketed_spellgem.icon_state)
		G.appearance = socketed_spellgem.appearance
		G.plane = FLOAT_PLANE
		G.layer = FLOAT_LAYER
		I.add_overlay(G)
		var/image/O = new/image('icons/obj/item/spellgem.dmi',"socket")
		I.add_overlay(O)
	add_vis_content(I)
	I.alpha = 0
	stored_socket_overlays += I

/obj/item/weapon/ranged/wand/Finalize()
	sockets = min(sockets,sockets_max)
	. = ..()
	update_sprite()
	socketed_spellgem?.update_attachment_stats()

/obj/item/weapon/ranged/wand/Initialize()
	. = ..()
	sockets_max = tier + 2
	if(sockets_max <= 2)
		sockets_max = 2

/obj/item/weapon/ranged/wand/Generate()
	. = ..()
	if(sockets == 0) //Sockets are given in the wild. Old function below
		// https://www.desmos.com/calculator/eomhtrxl2v
		var/diceroll = rand(1,1000)
		var/magic_number = (500/6)**1.25
		sockets = 1 + (diceroll/magic_number)**1.3
		sockets = FLOOR(sockets,1)

/obj/item/weapon/ranged/wand/PreDestroy()
	QDEL_NULL(socketed_spellgem)
	QDEL_CUT(socketed_supportgems)
	. = ..()

/obj/item/weapon/ranged/wand/get_base_value()
	. = initial(value)
	// https://www.desmos.com/calculator/bofczfvcar
	if(sockets > 1)
		. += ((sockets*5)**3)*0.25 + (sockets**(sockets-1))*0.2
	. *= wand_damage_multiplier**1.5
	. = CEILING(.,1)


/obj/item/weapon/ranged/wand/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","Has <b>1</b> slot(s) for spell gems.")
	. += div("notice","Has <b>[sockets]</b> slot(s) for support gems.")
	. += div("notice","This wand type increases the damage of spell gems by [(wand_damage_multiplier-1)*100]%.")
	if(socketed_spellgem)
		. += div("notice","Currently socketed with <b>[socketed_spellgem.name]</b>.")
	if(length(socketed_supportgems))
		var/list/support_gem_names = list()
		for(var/k in socketed_supportgems)
			var/obj/item/I = k
			support_gem_names += I.name
		if(socketed_spellgem)
			. += div("notice","Additionally socketed with <b>[english_list(support_gem_names)]</b>.")
		else
			. += div("notice","Socketed with <b>[english_list(support_gem_names)]</b>.")


/obj/item/weapon/ranged/wand/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("socketed_spellgem")
	SAVEVAR("sockets")
	SAVELISTATOM("socketed_supportgems")

/obj/item/weapon/ranged/wand/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("socketed_spellgem")
	LOADVAR("sockets")
	LOADLISTATOM("socketed_supportgems")

/obj/item/weapon/ranged/wand/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1,var/click_called=FALSE)
	if(!socketed_spellgem)
		return FALSE
	return socketed_spellgem.shoot(caller,object,location,params,damage_multiplier,click_called)

/obj/item/weapon/ranged/wand/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && caller.attack_flags & CONTROL_MOD_DISARM)

		INTERACT_CHECK

		var/obj/hud/inventory/I = object

		var/list/objects_to_remove = socketed_supportgems + socketed_spellgem + "Cancel" //+no bitches

		INTERACT_CHECK
		INTERACT_DELAY(5)

		var/desired_removal = input("What gem would you like to remove?","Gem Removal","Cancel") as null|anything in objects_to_remove
		if(desired_removal == "Cancel" || !desired_removal)
			caller.to_chat(span("notice","You decide not to remove anything."))
			return TRUE
		var/obj/item/G = desired_removal
		if(G.loc != src)
			caller.to_chat(span("warning","That's not there anymore!"))
			return TRUE
		if(G == socketed_spellgem)
			var/obj/item/weapon/ranged/spellgem/old_spellgem = G
			socketed_spellgem = null
			G.drop_item(get_turf(caller))
			I.add_object(G)
			caller.to_chat(span("notice","You remove \the [G.name] from \the [src.name]."))
			update_sprite()
			old_spellgem.update_attachment_stats()
			return TRUE
		socketed_supportgems -= G
		G.drop_item(get_turf(caller))
		I.add_object(G)
		caller.to_chat(span("notice","You remove \the [G.name] from \the [src.name]."))
		update_sprite()
		socketed_spellgem?.update_attachment_stats()
		return TRUE

	if(istype(object,/obj/item/weapon/ranged/spellgem/))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		var/obj/item/weapon/ranged/spellgem/SG = object
		var/obj/hud/inventory/I //Hacky, but it werks.
		if(socketed_spellgem)
			I = SG.loc
			socketed_spellgem.drop_item(get_turf(src))
			socketed_spellgem.update_attachment_stats()
		if(I)
			I.add_object(socketed_spellgem)
			caller.to_chat(span("notice","You replace \the [socketed_spellgem.name] with \the [SG.name]."))
		else
			caller.to_chat(span("notice","You insert \the [SG.name] into \the [src.name]."))
		socketed_spellgem = SG
		SG.drop_item(src)
		update_sprite()
		SG.update_attachment_stats()
		return TRUE

	if(istype(object,/obj/item/supportgem))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		var/obj/item/supportgem/G = object
		if(length(socketed_supportgems) >= sockets)
			caller.to_chat(span("warning","There aren't enough sockets to support \the [G.name]!"))
			return TRUE
		socketed_supportgems += G
		G.drop_item(src)
		caller.to_chat(span("notice","You insert \the [G.name] into \the [src.name]."))
		update_sprite()
		socketed_spellgem?.update_attachment_stats()
		return TRUE



	. = ..()

/obj/item/weapon/ranged/wand/branch
	name = "branch wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/branch.dmi'

	wand_damage_multiplier = 1
	wand_mana_multiplier = 0.95

	tier = 0

	value = 100

/obj/item/weapon/ranged/wand/crafted
	name = "crafted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/crafted.dmi'

	wand_damage_multiplier = 1.1
	wand_mana_multiplier = 0.90

	tier = 1

	value = 100

/obj/item/weapon/ranged/wand/quartz
	name = "crafted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/quartz.dmi'

	wand_damage_multiplier = 1.2
	wand_mana_multiplier = 0.90

	tier = 1

	value = 100

/obj/item/weapon/ranged/wand/twisted
	name = "twisted wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/twisted.dmi'

	wand_damage_multiplier = 1.3
	wand_mana_multiplier = 0.85

	tier = 2


	value = 100

/obj/item/weapon/ranged/wand/profane
	name = "profane wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/profane.dmi'

	wand_damage_multiplier = 1.4
	wand_mana_multiplier = 0.80

	tier = 3

	value = 100

/obj/item/weapon/ranged/wand/sage
	name = "sage wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/sage.dmi'

	wand_damage_multiplier = 1.5
	wand_mana_multiplier = 0.75

	tier = 3

	value = 100
