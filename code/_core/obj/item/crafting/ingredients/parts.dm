//Miscellaneous parts that can't be listed anywhere.

//Scrap for really-really cheap crafting recipes, or for refining into steel/iron.
/obj/item/crafting/ingredient/part/scrap
	name = "scrap metal"
	desc = "Stout Shako for two refined!"
	desc_extended = "Large heap of unsorted scrap metal: rods, nuts, bolts, tubes, etc. Might be useful for crafting."
	value = 150
	crafting_id = "scrap"

//Electronic components for crafts of various electronic things.
/obj/item/crafting/ingredient/part/electronics
	name = "electronic components"
	desc = "Electronically warfared."
	desc_extended = "Mixed assortment of various electornic parts of all kinds and purposes: empty circuits, capacitors, diodes, small wires, such stuff. Possibly useful for making something electornic."
	icon_state = "electronics"
	value = 500
	crafting_id = "electronics"

//Duct tape for more DIY recipes, as well as Gauss mag crafts.
/obj/item/crafting/ingredient/part/tape
	name = "duct tape"
	desc = "Fixes (almost) anything!"
	desc_extended = "Cheap grey duct tape of unknown origin. Smells faintly of motor oil."
	icon_state = "tape"
	value = 100
	crafting_id = "tape"

//Air regulation system for all/most hardsuits',NBCs'/SEVAs' and other air-circulated suits' crafting recipes.
/obj/item/crafting/ingredient/part/air_regulator
	name = "air regulation system"
	desc = "Keeps CO2 inside and O2 outside. Or was it the other way around?.."
	desc_extended = "Rather complex, space-grade air circulator and filter combo commonly seen inside NBC suits, hardsuits and mechas (although at a bigger scale). Used in the making of aforementioned equipment."
	icon_state = "air_regulator"
	value = 750
	crafting_id = "air_regulator"

//Phoron canister used for flammables and combustables. If it's space-age and volatile, this was used in its creation. (Also, muh flamethrower.)
/obj/item/crafting/ingredient/part/p_tank
	name = "phoron tank"
	desc = "Keep it closed."
	desc_extended = "An air tank made to keep air inside until it's ready to be released. This one is full of phoron."
	icon_state = "p_tank"
	value = 750
	crafting_id = "p_tank"
//Rub rub sandpaper.
/obj/item/crafting/ingredient/part/sandpaper
	name = "sandpaper"
	desc = "coarse and rough"
	desc_extended = "A piece of paper covered in rough grains of sand. Useful for smoothing metals."
	icon_state = "sand_paper"
	value = 10
//Doesnt go boom
/obj/item/crafting/ingredient/part/gunpowder
	name = "gunpowder"
	desc = "Kaboom?"
	desc_extended = "Some gunpowder wrapped in a nice package."
	icon_state = "gunpowder"
	value = 5
	amount_max = 100
//Mold for casings, 
/obj/item/crafting/ingredient/part/casing_mold
	name = "casing mold"
	desc = "Just need some brass"
	desc_extended = "A mold to make bullet casings."
	icon_state = "casing_mold"
	value = 100
	amount_max = 1
//the actual bullet casing.
/obj/item/crafting/ingredient/part/bullet_casings
	name = "bullet casings"
	desc = "How they fit every caliber? Theres a lot of them."
	desc_extended = "A large amount of bullet casings, in serveral calibers."
	icon_state = "bullet_casings"
	value = 25
	amount_max = 100
//box
/obj/item/crafting/ingredient/part/metal_box
	name = "empty metal box"
	desc = "An empty metal box."
	desc_extended = "An empty metal box, much to small to hold anything other than cogs and parts."
	icon_state = "box"
	value = 100
	amount_max = 100