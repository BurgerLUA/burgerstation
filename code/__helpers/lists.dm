#define ADD_SORTED(list, A, cmp_proc) if(!list.len) {list.Add(A)} else {list.Insert(FindElementIndex(A, list, cmp_proc), A)}

/proc/subtypesof(var/prototype)
	return (typesof(prototype) - prototype)

//Checks for specific types in specifically structured (Assoc "type" = TRUE) lists ('typecaches')
#define is_type_in_typecache(A, L) (A && length(L) && L[(ispath(A) ? A : A:type)])

//returns a new list with only atoms that are in typecache L
/proc/typecache_filter_list(var/list/atoms, var/list/typecache)
	. = list()
	for(var/thing in atoms)
		var/atom/A = thing
		if (typecache[A.type])
			. += A

/proc/typecache_filter_list_reverse(var/list/atoms, var/list/typecache)
	. = list()
	for(var/thing in atoms)
		var/atom/A = thing
		if(!typecache[A.type])
			. += A

/proc/typecache_filter_multi_list_exclusion(var/list/atoms, var/list/typecache_include, var/list/typecache_exclude)
	. = list()
	for(var/thing in atoms)
		var/atom/A = thing
		if(typecache_include[A.type] && !typecache_exclude[A.type])
			. += A

//Like typesof() or subtypesof(), but returns a typecache instead of a list
/proc/typecacheof(var/path, var/ignore_root_path, var/only_root_path = FALSE)
	if(ispath(path))
		var/list/types = list()
		if(only_root_path)
			types = list(path)
		else
			types = ignore_root_path ? subtypesof(path) : typesof(path)
		var/list/L = list()
		for(var/T in types)
			L[T] = TRUE
		return L
	else if(islist(path))
		var/list/pathlist = path
		var/list/L = list()
		if(ignore_root_path)
			for(var/P in pathlist)
				for(var/T in subtypesof(P))
					L[T] = TRUE
		else
			for(var/P in pathlist)
				if(only_root_path)
					L[P] = TRUE
				else
					for(var/T in typesof(P))
						L[T] = TRUE
		return L

/proc/listclearnulls(var/list/L)
	var/start_len = L.len
	var/list/N = new(start_len)
	L -= N
	return L.len < start_len


/proc/list2text(var/list/L,var/Start=1,var/End=0,var/nothing_text = "nothing", var/and_text = " and ", var/comma_text = ", ", var/final_comma_text = "", var/quote = "")
	. = L.Copy(Start,End)
	return english_list(.,nothing_text,and_text,comma_text,final_comma_text,quote)

/proc/english_list(var/list/input, var/nothing_text = "nothing", var/and_text = " and ", var/comma_text = ", ", var/final_comma_text = "", var/quote = "")
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


/proc/pickweight(var/list/L) //Credit to Nanako for most of this code.
	var/total = 0
	var/item
	for (item in L)
		if (isnull(L[item]))
			L[item] = 1
		total += L[item]
	total = rand() * total
	for (item in L)
		total -= L[item]
		if (total <= 0)
			return item

	return null

#define value_or_null(the_list,key) the_list[key] ? the_list[key] : null

/proc/get_best_key(var/list/input)

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

//for sorting clients or mobs by ckey
/proc/sortKey(var/list/L, var/order=1)
	return sortTim(L, order >= 0 ? /proc/cmp_ckey_asc : /proc/cmp_ckey_dsc)

/proc/sortList(var/list/L, var/cmp=/proc/cmp_text_asc)
	return sortTim(L.Copy(), cmp)

//uses sortList() but uses the var's name specifically. This should probably be using mergeAtom() instead
/proc/sortNames(var/list/L, var/order=1)
	return sortTim(L, order >= 0 ? /proc/cmp_name_asc : /proc/cmp_name_dsc)

//Move a single element from position fromIndex within a list, to position toIndex
//This will preserve associations ~Carnie
/proc/moveElement(var/list/L, var/fromIndex, var/toIndex)
	if(fromIndex > toIndex)
		++fromIndex
	//else
	//	++toIndex

	L.Insert(toIndex, null)
	L.Swap(fromIndex, toIndex)
	L.Cut(fromIndex, fromIndex+1)


//Move elements [fromIndex,fromIndex+len) to [toIndex,toIndex+len)
//This will preserve associations and is much faster than copying to a new list
//or checking for associative lists and manually copying elements ~Carnie
/proc/moveRange(var/list/L, var/fromIndex, var/toIndex, var/len=1)
	var/distance = abs(toIndex - fromIndex)
	if(len > distance)	//there are more elements to be moved than the distance to be moved. Therefore the same result can be achieved (with fewer operations) by moving elements between where we are and where we are going
		if(fromIndex < toIndex)
			toIndex += len
		else
			fromIndex += len

		for(var/i=0, i<distance, ++i)
			L.Insert(fromIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(toIndex, toIndex+1)
	else
		if(fromIndex > toIndex)
			fromIndex += len
		else
			toIndex += len	//?

		for(var/i=0, i<len, ++i)
			L.Insert(toIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(fromIndex, fromIndex+1)

//Move elements from [fromIndex, fromIndex+len) to [toIndex, toIndex+len)
//Move any elements being overwritten by the move to the now-empty elements, preserving order
//Note: if the two ranges overlap, only the destination order will be preserved fully, since some elements will be within both ranges ~Carnie
/proc/swapRange(var/list/L, var/fromIndex, var/toIndex, var/len=1)
	var/distance = abs(toIndex - fromIndex)
	if(len > distance)	//there is an overlap, therefore swapping each element will require more swaps than inserting new elements
		if(fromIndex < toIndex)
			toIndex += len
		else
			fromIndex += len

		for(var/i=0, i<distance, ++i)
			L.Insert(fromIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(toIndex, toIndex+1)
	else
		if(toIndex > fromIndex)
			var/a = toIndex
			toIndex = fromIndex
			fromIndex = a

		for(var/i=0, i<len, ++i)
			L.Swap(fromIndex++, toIndex++)

//replaces reverseList ~Carnie
/proc/reverseRange(var/list/L, var/start=1, var/end=0)
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

// Insert an object A into a sorted list using cmp_proc (/code/_helpers/cmp.dm) for comparison.
// Use ADD_SORTED(list, A, cmp_proc)

// Return the index using dichotomic search
/proc/FindElementIndex(var/atom/A, var/list/L, var/cmp)
	var/i = 1
	var/j = L.len
	var/mid

	while(i < j)
		mid = round((i+j)/2)

		if(call(cmp)(L[mid],A) < 0)
			i = mid + 1
		else
			j = mid

	if(i == 1 || i ==  L.len) // Edge cases
		return (call(cmp)(L[i],A) > 0) ? i : i+1
	else
		return i

/proc/get_real_length(var/list/L)

	if(!L)
		return 0

	var/list_length = length(L)

	var/actual_length = 0

	for(var/i=1,i<=list_length,i++)
		if(L[i])
			actual_length++

	return actual_length

/proc/get_last_value(var/list/L)

	if(!L || !length(L))
		return null

	for(var/i=length(L),i>=1,i--)
		if(L[i])
			return L[i]

	return null

/proc/get_first_missing_value(var/list/L)

	if(!L || !length(L))
		return FALSE

	for(var/i=1,i<=length(L),i++)
		if(!L[i])
			return i

	return FALSE


/proc/get_best_key_assoc(var/list/L,var/highest = TRUE)

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

/proc/text2numlist(var/text, var/delimiter="\n") //Stolen from Aurora
	var/list/num_list = list()
	for(var/x in jointext(text, delimiter))
		num_list += text2num(x)
	return num_list

//Credit goes to AJX.
/proc/sort_by_closest(var/list/L,var/atom/target)
	var/atom/A
	var/atom/B

	for(var/r=1,r<length(L),r++)
		for(var/i=1,i<length(L),i++)
			A = L[i]
			B = L[i+1]
			if(get_dist_real(target,A) > get_dist_real(target,B))
				L.Swap(i,i+1)

/proc/sort_by_closest_assoc(var/list/L,var/atom/target)

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


/proc/is_assoc_list(var/list/L) //Credit to SpaceManiac for providing this

	try
		if(!islist(L) || !length(L))
			return FALSE

		for(var/k in L)
			if(!isnum(k) && !isnull(L["[k]"]))
				return TRUE

		return FALSE

	catch()
		return FALSE

/proc/make_associative(var/list/flat_list)
	. = list()
	for(var/thing in flat_list)
		.[thing] = TRUE

/proc/assoc_list_strip_value(var/list/input)
	var/list/ret = list()
	for(var/key in input)
		ret += key
	return ret



