/dialogue/npc/taxman/

/dialogue/npc/taxman/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	var/next_pay = P.last_tax_payment + 604800*10
	var/next_due = P.last_tax_payment + 604800*10*2

	if(world.realtime < next_pay)
		.["hello"] = list(
			"Greetings, [P.real_name]. It seems that you are all caught up on your taxes. Your next tax due date is [time2text(next_pay,"Month DD")]. \
			Perhaps you have come to just #1?",
			"*learn about taxes"
		)
	else
		var/delinq = SStax.check_delinquent(P)
		.["hello"] = list(
			"Greetings, [P.real_name]. Have you come to #1, or perhaps #2? Your taxes are currently [delinq <= 1 ? "due today" : "overdue by [CEILING(delinq,1)] days"].",
			"*pay your taxes",
			"*learn about taxes"
		)

	var/tax_explain = SStax.get_explaination(P)
	tax_explain = replacetextEx(tax_explain,"\n","NEWLINE")
	tax_explain = "[tax_explain]NEWLINEIs this acceptable?NEWLINE#1NEWLINE#2"
	.["*pay your taxes"] = list(
		html_encode(tax_explain),
		"*Yes, pay taxes.",
		"*No, do not pay taxes."
	)

	.["*Yes, pay taxes."] = list("You shouldn't be seeing this.")
	.["*No, do not pay taxes."] = list(
		"Remember, if you do #1 1 week after your deadline, which is [time2text(next_due,"Month DD")], some special people might go after you!",
		"pay your taxes"
	)

	.["*learn about taxes"] = list(
		"As a working private mercenary of the Solarian Government, you are subject to all laws and regulations under Solarian Law, as well as its tax code. \
		As per the Ground Freedom Act of 2104, subsection 24b, you must pay a weekly tax before setting foot on any soil belonging to the Solarian Government \
		or else you waive all legal rights, life, liberties, freedoms, property, and happiness until the amount due is paid. In er... other words, we will send \
		bounty hunters after you to repo your possessions until debts are satisfied."
	)

	return .


/dialogue/npc/taxman/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, pay taxes.")
		if(SStax.can_pax_taxes(P))
			SStax.pay_taxes(P)
			P.dialogue_target_id = null
			close_menu(P,/menu/dialogue/)
		else
			P.to_chat(span("warning","You can't pay your taxes yet, you're too early!"))

	return .