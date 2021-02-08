SUBSYSTEM_DEF(tax)
	name = "Tax Subsystem"
	desc = "Handles taxes and other memes."
	priority = SS_ORDER_NORMAL

	var/revenue_tax = 8
	var/sales_tax = 12

	var/list/business_tax_profit = list(
		10000,
		20000,
		35000,
		55000,
		80000,
		100000
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

	var/tax_credit_this_round = 2000
	var/processing_fee = 400

/subsystem/tax/New(var/desired_loc)
	tax_credit_this_round = rand(1000,6000)
	return ..()

/subsystem/tax/proc/can_pax_taxes(var/mob/living/advanced/player/P)
	return world.realtime >= (P.last_tax_payment + 604800) //1 week

/subsystem/tax/proc/check_delinquent(var/mob/living/advanced/player/P)

	if(P.last_tax_payment == 0)
		return -1 //Never paid taxes.

	var/yes = world.realtime - (P.last_tax_payment + 604800)

	if(yes > 0)
		return yes

	return 0


/subsystem/tax/proc/pay_taxes(var/mob/living/advanced/player/P)

	var/taxes_to_pay = get_tax_amount(P)

	if(P.currency < taxes_to_pay)
		P.to_chat(span("danger","You don't have enough credits to pay your taxes!"))
		return FALSE

	var/pay_amount = P.adjust_currency(-taxes_to_pay,FALSE)
	P.to_chat(span("notice","You have successfully paid [pay_amount] your taxes. Check back in 1 week ([time2text(world.realtime+6048000,"Month DD")]) to pay your taxes again!"))

	P.last_tax_payment = world.realtime
	P.revenue = 0
	P.expenses = 0

	return TRUE

/subsystem/tax/proc/get_bracket_tax(var/profit)

	. = 0

	for(var/i=1,i<=length(business_tax_profit),i++) //Taxing profit.
		if(profit <= 0)
			break
		var/taxable_amount = min(business_tax_profit[i],profit)
		profit -= taxable_amount
		. += taxable_amount * business_tax_percent[i] * 0.01

	. = CEILING(.,1)

	return .

/subsystem/tax/proc/get_tax_amount(var/mob/living/advanced/player/P)

	. = tax_credit_this_round
	. += -processing_fee

	. += CEILING(P.revenue * revenue_tax * 0.01,1) //Taxing revenue
	. += CEILING(P.expenses * sales_tax * 0.01,1) //Taxing expenses.

	var/profit = P.revenue - P.expenses
	. += get_bracket_tax(profit)

	return .

/subsystem/tax/proc/get_explaination(var/mob/living/advanced/player/P)

	var/bracket_tax_amount = get_bracket_tax(P.revenue - P.expenses)
	var/sales_tax_amount = CEILING(P.expenses * sales_tax * 0.01,1)
	var/revenue_tax_amount = CEILING(P.revenue * revenue_tax * 0.01,1)

	var/total_tax = bracket_tax_amount + sales_tax_amount + revenue_tax_amount

	return "Your tax total is the following:\n\
	[revenue_tax]% of your revenue (which is currently [revenue_tax_amount] credits) is taxed as revenue tax. \
	[sales_tax]% of your expenses, which are classified as \"sales\" under the current tax code, (which is currently [sales_tax_amount] credits) is taxed as sales tax. \
	Your bracket tax is a bit more complex, with [length(business_tax_percent)] different brackets between [business_tax_percent[1]]% and [business_tax_percent[length(business_tax_percent)]]% taxed on a per bracket basis, which is based on your total profit (before taxes)...\n\
	... with the math all together, you will be paying [bracket_tax_amount] credits in business tax...\n\
	... and your total tax for this week and all possible weeks you missed is [total_tax] credits...\n\
	and with eligible beneifts and processing fees added, the amount you pay will be... \
	[-processing_fee + total_tax + tax_credit_this_round] credits."
