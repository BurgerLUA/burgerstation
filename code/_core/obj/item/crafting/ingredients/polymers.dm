//Basically, polymers will function as your material replacement in case there's no required special material
//available at burgerstation/on you and you don't want to code one/search for one,
//hence they're also really fucking expensive.
//Idea and the concept of "sentient universal material " was taken from the Atomic Heart's idea of polymers, as well
//as Samosbor's idea of semi-sentient "selfbuilder" technology that could build entire blocks of so called Gigakhruschevka.

//basic material for most cheap crafting recipes, like Beta or Gamma ingredient, or additional smelting,
//so it should be widely available.
/obj/item/crafting/ingredient/polymer/alpha
	name = "polymer Alpha"
	desc = "Who knew your grip was smart?"
	desc_extended = "Metal box of contained semi-sentient polymers capable of taking on any shape or form. Alpha variation is the weakest one both in terms of intelligence and durability, capable of taking on forms and chemical compositions of components that don't require much accuracy."
	value = 1000
	crafting_id = "alpha"

//more specialised material meant to be used for some low-end equipment.
/obj/item/crafting/ingredient/polymer/beta
	name = "polymer Beta"
	desc = "Who knew your helmet was smart?"
	desc_extended = "Metal box of contained semi-sentient polymers capable of taking on any shape or form. Beta variation was developed in the early days of Revolutionaries' uprising by one of their leading scientists, becoming a successor to Alpha variation both in terms of intelligence and chemical variety."
	icon_state = "beta"
	value = 2000
	crafting_id = "beta"

//go-to material for most medium-grade crafts, like vests or such.
/obj/item/crafting/ingredient/polymer/gamma
	name = "polymer Gamma"
	desc = "Who knew your hardsuit was smart?"
	desc_extended = "Metal box of contained semi-sentient polymers capable of taking on any shape or form. Gamma variation is used for creation of hazardous environment equipment, EVA gear and other applications that'd require nanometric precision."
	icon_state = "gamma"
	value = 3000
	crafting_id = "gamma"

//High-grade material for most of the high-end crafts that don't involve boss materials.
/obj/item/crafting/ingredient/polymer/epsilon
	name = "polymer Epsilon"
	desc = "Who knew your nuclear reactor was smart?"
	desc_extended = "Metal box of contained semi-sentient polymers capable of taking on any shape or form. Epsilon variation is rarely used for anything that doesn't involve nuclear levels of precision, however, it's frequently used by especially wealthy soldiers for creation of custom variations of their equipment."
	icon_state = "epsilon"
	value = 4000
	crafting_id = "epsilon"

//this polymer below should be REALLY FUCKING RARE and LITERALLY ONLY DROPPED BY BOSSES, for boss-level equipment.
/obj/item/crafting/ingredient/polymer/omega
	name = "experimental polymer Omega"
	desc = "Who knew your... universe was smart?"
	desc_extended = "Specially designed container of completely sentient polymers capable of taking on any shape or form. Omega variation is an early prototype of an improved malfunctioning Tetha polymer that obliterated an entire Space Russian research facility, theoretically capable of rewriting laws of the universe itself when used correctly. Used for creation of god-tier equipment."
	icon_state = "omega"
	value = 6000
	value_burgerbux = 1 //no vendor and trash bullshit.
	crafting_id = "omega"