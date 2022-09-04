/mob/living/advanced/npc/unique/sidorovich
	name = "revolutionary merchant"

	desc = "The reason I've survived in this place as long as I have is that I always keep my word. You screw a client in this place, and you're pretty likely to find a knife in your back real quick."

	species = "human"

	dialogue_id = /dialogue/npc/sidorovich/

	health = null

	anchored = TRUE

	level = 28

	var/obj/structure/interactive/vending/stored_vendor = /obj/structure/interactive/vending/sidorovich

/mob/living/advanced/npc/unique/sidorovich/Initialize()

	. = ..()

	sex = MALE
	gender = sex

	change_organ_visual("skin", desired_color = "#D3B09E")
	change_organ_visual("eye", desired_color = "#363232")
	change_organ_visual("hair_head", desired_color = "#a59890", desired_icon_state = "hair_megaeyebrows")
	change_organ_visual("hair_face", desired_color = "#a59890", desired_icon_state = "facial_hip")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen) //Or else he'll aggro. Sad!
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	equip_loadout(/loadout/sidorovich)

	update_all_blends()

	if(ispath(stored_vendor))
		stored_vendor = new stored_vendor(src)
		INITIALIZE(stored_vendor)
		GENERATE(stored_vendor)
		FINALIZE(stored_vendor)
