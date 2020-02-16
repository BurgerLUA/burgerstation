/obj/item/lottery_ticket
	name = "role lottery ticket"
	desc = "In order to prevent nepotism and discrimination, important jobs are now subject to lottery."
	desc_extended = "A digital lottery ticket that allows crewmembers to select which role they wish to participate in."
	var/list/available_roles = list()

	value = 5


///obj/item/lottery_ticket/clicked_on_by_object