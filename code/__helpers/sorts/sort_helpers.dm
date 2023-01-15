/**
 * Move a single element from position from_index within a list, to position to_index
 * All elements in the range [1,to_index) before the move will be before the pivot afterwards
 * All elements in the range [to_index, L.len+1) before the move will be after the pivot afterwards
 * In other words, it's as if the range [from_index,to_index) have been rotated using a <<< operation common to other languages.
 * from_index and to_index must be in the range [1,L.len+1]
 * This will preserve associations ~Carnie
**/
/proc/move_element(list/inserted_list, from_index, to_index)
	if(from_index == to_index || from_index + 1 == to_index) //no need to move
		return
	if(from_index > to_index)
		++from_index //since a null will be inserted before from_index, the index needs to be nudged right by one

	inserted_list.Insert(to_index, null)
	inserted_list.Swap(from_index, to_index)
	inserted_list.Cut(from_index, from_index + 1)


/**
 * Move elements [from_index,from_index+len) to [to_index-len, to_index)
 * Same as moveElement but for ranges of elements
 * This will preserve associations ~Carnie
**/
/proc/move_range(list/inserted_list, from_index, to_index, len = 1)
	var/distance = abs(to_index - from_index)
	if(len >= distance) //there are more elements to be moved than the distance to be moved. Therefore the same result can be achieved (with fewer operations) by moving elements between where we are and where we are going. The result being, our range we are moving is shifted left or right by dist elements
		if(from_index <= to_index)
			return //no need to move
		from_index += len //we want to shift left instead of right

		for(var/i in 1 to distance)
			inserted_list.Insert(from_index, null)
			inserted_list.Swap(from_index, to_index)
			inserted_list.Cut(to_index, to_index + 1)
	else
		if(from_index > to_index)
			from_index += len

		for(var/i in 1 to len)
			inserted_list.Insert(to_index, null)
			inserted_list.Swap(from_index, to_index)
			inserted_list.Cut(from_index, from_index + 1)

///Move elements from [from_index, from_index+len) to [to_index, to_index+len)
///Move any elements being overwritten by the move to the now-empty elements, preserving order
///Note: if the two ranges overlap, only the destination order will be preserved fully, since some elements will be within both ranges ~Carnie
/proc/swap_range(list/inserted_list, from_index, to_index, len=1)
	var/distance = abs(to_index - from_index)
	if(len > distance) //there is an overlap, therefore swapping each element will require more swaps than inserting new elements
		if(from_index < to_index)
			to_index += len
		else
			from_index += len

		for(var/i in 1 to distance)
			inserted_list.Insert(from_index, null)
			inserted_list.Swap(from_index, to_index)
			inserted_list.Cut(to_index, to_index + 1)
	else
		if(to_index > from_index)
			var/a = to_index
			to_index = from_index
			from_index = a

		for(var/i in 1 to len)
			inserted_list.Swap(from_index++, to_index++)

///replaces reverseList ~Carnie
/proc/reverse_range(list/inserted_list, start = 1, end = 0)
	if(inserted_list.len)
		start = start % inserted_list.len
		end = end % (inserted_list.len + 1)
		if(start <= 0)
			start += inserted_list.len
		if(end <= 0)
			end += inserted_list.len + 1

		--end
		while(start < end)
			inserted_list.Swap(start++, end--)

	return inserted_list


/*
/proc/sort_list(list/L, cmp=/proc/cmp_numeric_asc, associative, fromIndex=1, toIndex=0)
	return sort_tim(L,cmp,associative,fromIndex,toIndex)
*/