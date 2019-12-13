/proc/subtypesof(prototype)
	return (typesof(prototype) - prototype)

/proc/listclearnulls(list/L)
	var/start_len = L.len
	var/list/N = new(start_len)
	L -= N
	return L.len < start_len

/proc/english_list(var/list/input, nothing_text = "nothing", and_text = " and ", comma_text = ", ", final_comma_text = "", quote = "" )
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


/proc/pickweight(list/L) //Credit to Nanako for most of this code.
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


//ListSort by Kuraudo
/proc/ls_heapsort(list/L)
	var/heap_size = L.len
	for(var/i=L.len*0.5, i>=1, --i)
		ls_heapify(L, i, heap_size)
	for(var/i=L.len, i>=2, --i)
		L.Swap(i, 1)
		ls_heapify(L, 1, --heap_size)

/proc/ls_heapsort_cmp(list/L, cmp)
	var/heap_size = L.len
	for(var/i=L.len*0.5, i>=1, --i)
		ls_heapify_cmp(L, i, heap_size, cmp)
	for(var/i=L.len, i>=2, --i)
		L.Swap(i, 1)
		ls_heapify_cmp(L, 1, --heap_size, cmp)

/proc/ls_heapify(list/A, i, heap_size)
	var/l
	var/r
	var/upper

	for()
		l = i+i
		r = l+1

		if(l<=heap_size && A[l]>A[i])
			upper = l
		else
			upper = i

		if(r<=heap_size && A[r]>A[upper])
			upper = r

		if(upper != i)
			A.Swap(upper, i)
			i = upper
		else break

/proc/ls_heapify_cmp(list/A, i, heap_size, cmp)
	var/l
	var/r
	var/upper

	for()
		l = i+i
		r = l+1

		if(l<=heap_size && call(cmp)(A[l],A[i])>0)
			upper = l
		else
			upper = i

		if(r<=heap_size && call(cmp)(A[r],A[upper])>0)
			upper = r

		if(upper != i)
			A.Swap(upper, i)
			i = upper
		else break

/proc/ls_quicksort(list/L, start=1, end=L.len)
	if(start < end)
		var/q = ls_partition(L, start, end)
		ls_quicksort(L, start, q-1)
		ls_quicksort(L, q+1, end)

/proc/ls_quicksort_cmp(list/L, cmp, start=1, end=L.len)
	if(start < end)
		var/q = ls_partition_cmp(L, cmp, start, end)
		ls_quicksort_cmp(L, cmp, start, q-1)
		ls_quicksort_cmp(L, cmp, q+1, end)

/proc/ls_partition(list/L, p, r)
	var/pivot
	var/m = (p + r) * 0.5
	if(L[p] > L[m])
		L.Swap(p, m)
	if(L[p] > L[r])
		L.Swap(p, r)
	if(L[m] > L[r])
		L.Swap(m, r)
	pivot = r-1
	if(r-p > 2)
		r--
		L.Swap(m, pivot)
		for()
			while(L[++p] < L[pivot]);
			while(L[--r] > L[pivot]);
			if(p < r)
				L.Swap(p, r)
			else
				break
		L.Swap(p, pivot)
		return p
	else return m

/proc/ls_partition_cmp(list/L, cmp, p, r)
	var/pivot
	var/m = (p + r) * 0.5
	if(call(cmp)(L[p],L[m]) > 0)
		L.Swap(p, m)
	if(call(cmp)(L[p],L[r]) > 0)
		L.Swap(p, r)
	if(call(cmp)(L[m],L[r]) > 0)
		L.Swap(m, r)
	pivot = r-1
	if(r-p > 2)
		r--
		L.Swap(m, pivot)
		for()
			while(call(cmp)(L[++p],L[pivot]) < 0);
			while(call(cmp)(L[--r],L[pivot]) > 0);
			if(p < r)
				L.Swap(p, r)
			else
				break
		L.Swap(p, pivot)
		return p
	else return m


//InsertionSort by Lummox JR
proc/InsertionSort(list/L)
    var/i,len=L.len,first,last,k,v
    for(i=2, i<=len, ++i)
        // look for an index from 1 to i-1 where L[i] belongs
        // this is a binary insertion sort, so it uses a binary search
        first = 1
        last = i-1
        v = L[i]   // make this L[L[i]] to sort by associated value
        while(first <= last)
            k = round((first+last) / 2)
            // if sorting by associated values, change L[k] to L[L[k]]
            if(v >= L[k]) first = k + 1
            else last = k - 1
        L.Insert(first, v)
        // cut after insertion, to keep the associated value intact
        L.Cut(i+1,i+2)

//Aurora Sorting, tweaked.
/proc/sortByKey(var/list/L, var/key)
	if(L.len < 2)
		return L
	var/middle = L.len / 2 + 1
	return mergeKeyedLists(sortByKey(L.Copy(0, middle), key), sortByKey(L.Copy(middle), key), key)

/proc/mergeKeyedLists(var/list/L, var/list/R, var/key)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while(Li <= L.len && Ri <= R.len)
		if(L[Li][key] > R[Ri][key])
			// Works around list += list2 merging lists; it's not pretty but it works
			result += "temp item"
			result[result.len] = R[Ri++]
		else
			result += "temp item"
			result[result.len] = L[Li++]

	if(Li <= L.len)
		return (result + L.Copy(Li, 0))
	return (result + R.Copy(Ri, 0))


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


// Converts a string into a list by splitting the string at each delimiter found. (discarding the seperator)
/proc/text2list(text, delimiter="\n") //Stolen from Aurora
	var/delim_len = length(delimiter)
	if (delim_len < 1)
		return list(text)

	. = list()
	var/last_found = 1
	var/found

	do
		found       = findtext(text, delimiter, last_found, 0)
		.          += copytext(text, last_found, found)
		last_found  = found + delim_len
	while (found)

// Case sensitive version of /proc/text2list().
/proc/text2listEx(text, delimiter="\n") //Stolen from Aurora
	var/delim_len = length(delimiter)
	if (delim_len < 1)
		return list(text)

	. = list()
	var/last_found = 1
	var/found

	do
		found       = findtextEx(text, delimiter, last_found, 0)
		.          += copytext(text, last_found, found)
		last_found  = found + delim_len
	while (found)

/proc/text2numlist(text, delimiter="\n") //Stolen from Aurora
	var/list/num_list = list()
	for(var/x in text2list(text, delimiter))
		num_list += text2num(x)
	return num_list