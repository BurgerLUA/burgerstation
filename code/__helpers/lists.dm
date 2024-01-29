#define ADD_SORTED(list, A, cmp_proc) if(!list.len) {list.Add(A)} else {list.Insert(FindElementIndex(A, list, cmp_proc), A)}

/proc/subtypesof(prototype)
	return (typesof(prototype) - prototype)

/proc/listclearnulls(list/L)
	var/start_len = L.len
	var/list/N = new(start_len)
	L -= N
	return L.len < start_len


/proc/list2text(list/L,Start=1,End=0,nothing_text = "nothing", and_text = " and ", comma_text = ", ", final_comma_text = "", quote = "")
	. = L.Copy(Start,End)
	return english_list(.,nothing_text,and_text,comma_text,final_comma_text,quote)

/proc/english_list(list/input, nothing_text = "nothing", and_text = ", and ", comma_text = ", ", final_comma_text = "", quote = "")
	var/total = input.len
	if (!total)
		return "[nothing_text]"
	else if (total == 1)
		return "[quote][input[1]][quote]"
	else if (total == 2)
		return "[quote][input[1]][quote][and_text][quote][input[2]][quote]"
	else
		var/output = ""
		var/index = 1
		while (index < total)
			if (index == total - 1)
				comma_text = final_comma_text

			output += "[quote][input[index]][quote][comma_text]"
			index++

		return "[output][and_text][quote][input[index]][quote]"

/* old shit that didn't work
/proc/pickweight(list/L,rarity=0) //Credit to Nanako for some of this code. Rarity should be between 0 and 1. Higher rarities mean that lower weights are picked more.
	if(!L) CRASH("pickweight() invalid list provided!")
	rarity = clamp(rarity,0,1)
	var/highest = 0
	var/lowest = -1
	var/item

	//First pass.
	for(item in L)
		if(isnull(L[item]))
			L[item] = 1
		if(L[item] <= 0)
			continue
		if(lowest == -1)
			lowest = L[item]
			highest = L[item]
		else
			lowest = min(lowest,L[item])
			highest = max(highest,L[item])

	//Second pass.
	var/total = 0
	if(rarity > 0 && highest != lowest)
		for(item in L)
			var/rarity_mod = 1 - (L[item]/highest)*rarity
			L[item] = L[item]*rarity_mod
			total += L[item]

	//Final pass.
	total *= rand() //rand() is precise
	for (item in L)
		total -= L[item]
		if (total <= 0)
			return item
	return null
*/

/*
/proc/pickweight(list/list_to_pick) //Stolen from /tg/
	var/total = 0
	var/item
	for(item in list_to_pick)
		if(!isnum(list_to_pick[item]))
			list_to_pick[item] = 1
		else
			list_to_pick[item] = CEILING(list_to_pick[item],1)
		total += list_to_pick[item]
	total = rand(0, total)
	for(item in list_to_pick)
		total -= list_to_pick[item]
		if(total <= 0 && list_to_pick[item])
			return item

	return null
*/

/proc/pickweight(list/list_to_pick,rarity) //Stolen from /tg/ with changes by burger.
	var/total = 0

	var/item
	for(item in list_to_pick)
		if(!isnum(list_to_pick[item]))
			list_to_pick[item] = 1
		else
			list_to_pick[item] = CEILING(list_to_pick[item],1)
		total += list_to_pick[item]

	// A lower total is better.
	// https://www.desmos.com/calculator/eh8dy1z0ga
	if(isnum(rarity))
		var/modifier = max( (75-rarity)/75, rand() ** (rarity/100) )
		modifier = FLOOR(total*modifier,1)
		total = rand(modifier,total)
	else
		total = rand(0, total)

	for(item in list_to_pick)
		total -= list_to_pick[item]
		if(total <= 0 && list_to_pick[item])
			return item

	return null



#define value_or_null(the_list,key) the_list[key] ? the_list[key] : null

/proc/get_best_key(list/input)

	var/best_key = null
	var/best_value = null

	for(var/key in input)
		var/value = input[key]
		if(!best_key)
			best_key = key
			best_value = value
			continue
		if(value >= best_value)
			best_key = key
			best_value = value
			continue

	return best_key

/proc/get_last_value(list/L)

	if(!L || !length(L))
		return null

	for(var/i=length(L),i>=1,i--)
		if(L[i])
			return L[i]

	return null

/proc/get_first_missing_value(list/L)

	if(!L || !length(L))
		return FALSE

	for(var/i=1,i<=length(L),i++)
		if(!L[i])
			return i

	return FALSE


/proc/get_best_key_assoc(list/L,highest = TRUE)

	var/initialized = FALSE
	var/best_key
	var/best_value

	for(var/k in L)
		var/v = L[k]
		if(!initialized)
			best_key = k
			best_value = v
			initialized = TRUE
			continue

		if(highest)
			if(v > best_value)
				best_key = k
				best_value = v
				continue
		else
			if(v < best_value)
				best_key = k
				best_value = v
				continue

	return best_key

/proc/text2numlist(text, delimiter="\n") //Stolen from Aurora
	var/list/num_list = list()
	for(var/x in jointext(text, delimiter))
		num_list += text2num(x)
	return num_list

//Credit goes to AJX.
/proc/sort_by_closest(list/L,atom/target)
	var/atom/A
	var/atom/B

	for(var/r=1,r<length(L),r++)
		for(var/i=1,i<length(L),i++)
			A = L[i]
			B = L[i+1]
			if(get_dist_real(target,A) > get_dist_real(target,B))
				L.Swap(i,i+1)

/proc/sort_by_closest_assoc(list/L,atom/target)

	var/atom/A
	var/atom/B

	for(var/r=1,r<length(L),r++)
		for(var/i=1,i<length(L),i++)
			A = L[i]
			A = L[A]
			B = L[i+1]
			B = L[B]
			if(get_dist_real(target,A) > get_dist_real(target,B))
				L.Swap(i,i+1)


/proc/is_assoc_list(list/L) //Credit to SpaceManiac for providing this

	try
		if(!islist(L) || !length(L))
			return FALSE

		for(var/k in L)
			if(!isnum(k) && !isnull(L["[k]"]))
				return TRUE

		return FALSE

	catch()
		return FALSE

/proc/make_associative(list/flat_list)
	. = list()
	for(var/thing in flat_list)
		.[thing] = TRUE

/proc/make_associative_count(list/flat_list)
	. = list()
	for(var/thing in flat_list)
		.[thing]++

/proc/assoc_list_strip_value(list/input)
	var/list/ret = list()
	for(var/key in input)
		ret += key
	return ret


//Credit to /tg/station for these shuffle procs.
///Randomize: Return the list in a random order
/proc/shuffle(list/inserted_list)
	if(!inserted_list)
		return
	inserted_list = inserted_list.Copy()

	for(var/i in 1 to inserted_list.len - 1)
		inserted_list.Swap(i, rand(i, inserted_list.len))

	return inserted_list

///same as shuffle, but returns nothing and acts on list in place
/proc/shuffle_inplace(list/inserted_list)
	if(!inserted_list)
		return

	for(var/i in 1 to inserted_list.len - 1)
		inserted_list.Swap(i, rand(i, inserted_list.len))

//replaces old reverseList ~Carnie
/proc/reverseList(list/L, start=1, end=0)
	if(L.len)
		start = start % L.len
		end = end % (L.len+1)
		if(start <= 0)
			start += L.len
		if(end <= 0)
			end += L.len + 1

		--end
		while(start < end)
			L.Swap(start++,end--)

	return L


/proc/get_real_length(list/L)

	if(!L)
		return 0

	var/list_length = length(L)

	var/actual_length = 0

	for(var/i=1,i<=list_length,i++)
		if(L[i])
			actual_length++

	return actual_length
