/client/verb/ghost()
	set name = "Ghost"
	set desc = "Abandon your body and become a ghost."
	set category = "Game"

	if(!mob)
		to_chat("You have no body to abandon!")
		return FALSE

	if(!is_living(mob))
		to_chat("You have no body to abandon!")
		return FALSE

	var/mob/living/L = mob

	if(!L.dead)
		to_chat("You can't abandon your body while alive!")
		return FALSE

	var/choice = input("Are you sure you want to abandon your body and become a ghost? You will no longer be able to be revived.","Abandon Body.","Cancel") in list("Yes","No","Cancel")

	if(choice == "Yes")
		make_ghost(mob.loc)
		to_chat("You abandon your body...")
