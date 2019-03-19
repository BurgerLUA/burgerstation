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


#define value_or_null(the_list,key) the_list[key] ? the_list[key] : null



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