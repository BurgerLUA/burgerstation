SUBSYSTEM_DEF(tax)
	name = "Tax Subsystem"
	desc = "Handles taxes and other memes."
	priority = SS_ORDER_NORMAL

	var/revenue_tax = 4
	var/sales_tax = 6

	var/list/business_tax_profit = list(
		10000,
		60000,
		100000,
		190000,
		280000,
		350000
	)

	var/list/business_tax_percent = list(
		0,
		12,
		16,
		22,
		30,
		40,
		52
	)

/subsystem/tax/proc/can_pax_taxes(var/mob/living/advanced/player/P)
	return world.realtime >= (P.last_tax_payment + 604800*10) //1 week

/subsystem/tax/proc/check_delinquent(var/mob/living/advanced/player/P)
	. = world.realtime - (P.last_tax_payment + 604800*10*2) //2 weeks
	. = max(0,.)

/subsystem/tax/proc/pay_taxes(var/mob/living/advanced/player/P)

	var/taxes_to_pay = get_tax_amount(P)

	var/partial_tax = FALSE

	if(P.currency < taxes_to_pay)
		P.to_chat(span("danger","You don't have enough credits to pay your taxes in full! You paid what you could..."))
		partial_tax = TRUE

	var/pay_amount = -P.adjust_currency(-taxes_to_pay,FALSE)

	if(partial_tax)
		P.to_chat(span("warning","You have partially paid [pay_amount] of your taxes..."))
	else
		P.to_chat(span("notice","You have successfully paid [pay_amount] of your taxes. Check back in 1 week ([time2text(world.realtime+(604800*10),"Month DD")]) to pay your taxes again!"))
		P.last_tax_payment = world.realtime

	P.revenue = 0
	P.expenses = 0
	P.partial_tax = taxes_to_pay - pay_amount

	return pay_amount

/subsystem/tax/proc/get_bracket_tax(var/profit)

	. = 0

	for(var/i=1,i<=length(business_tax_profit),i++) //Taxing profit.
		if(profit <= business_tax_profit[i])
			break
		. += business_tax_profit[i] * business_tax_percent[i] * 0.01

	. = CEILING(.,1)


/subsystem/tax/proc/get_tax_amount(var/mob/living/advanced/player/P)
	. += CEILING(P.revenue * revenue_tax * 0.01,1) //Taxing revenue
	. += CEILING(P.expenses * sales_tax * 0.01,1) //Taxing expenses.
	. += CEILING(P.partial_tax,1) //Taxing taxes you didn't pay last time.
	var/profit = P.revenue - P.expenses
	. += get_bracket_tax(profit)


/subsystem/tax/proc/get_explaination(var/mob/living/advanced/player/P)

	var/bracket_tax_amount = get_bracket_tax(P.revenue - P.expenses)
	var/sales_tax_amount = CEILING(P.expenses * sales_tax * 0.01,1)
	var/revenue_tax_amount = CEILING(P.revenue * revenue_tax * 0.01,1)

	var/total_tax = bracket_tax_amount + sales_tax_amount + revenue_tax_amount

	return "Your tax total is the following:\n\
	[revenue_tax]% of your revenue (which is currently [revenue_tax_amount] credits) is taxed as revenue tax. \
	[sales_tax]% of your expenses, which are classified as \"sales\" under the current tax code, (which is currently [sales_tax_amount] credits) is taxed as sales tax. \
	You currently owe [P.partial_tax] credits in outstanding tax amount owed, interest free... \
	Your business tax is a bit more complex, with [length(business_tax_percent)] different brackets between [business_tax_percent[1]]% and [business_tax_percent[length(business_tax_percent)]]% taxed on a per bracket basis, which is based on your total profit (revenue minus expenses, before taxes)...\n\
	... with the math all together, you will be paying [bracket_tax_amount] credits in business tax...\n\
	... and your total tax for this week and all possible weeks you missed is [total_tax] credits in total."
