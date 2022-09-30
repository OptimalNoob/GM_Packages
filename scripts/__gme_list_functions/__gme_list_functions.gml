///@func			ds_list_flip(list)
///@arg {list} list	| list data structure
///
///@description		| Rearranges the values of a list in reverse order.
function ds_list_flip(list) {
    for (var i = ds_list_size(list); i >= 0; i--) {
        ds_list_add(list, ds_list_find_value(list, i));
        ds_list_delete(list, i);
    }
}

///@func				ds_list_max(list)
///@arg {list} list		| list data structure
///
///@description			| Returns the maximum value in a list.
///						| If the list is empty, undefined is returned.
///						| All list elements must be comparable.
///
///@return {any}
function ds_list_max(list) {
    var n = ds_list_size(list);
    var maxv = ds_list_find_value(list, 0);
 
    for (var i = 1; i < n; i++) {
        var val = ds_list_find_value(list, i);
        if (val > maxv) maxv = val;
    }
 
    return maxv;
}

///@func			ds_list_min(list)
///@arg {list} list	| list data structure
///
///@desc			| Returns the minimum value in a list.
///					| If the list is empty, undefined is returned.
///					| All list elements must be comparable.
///
///@return {any}
function ds_list_min(list) {
    var n = ds_list_size(list);
    var minv = ds_list_find_value(list, 0);
 
    for (var i = 1; i < n; i++) {
        var val = ds_list_find_value(list, i);
        if (val < minv) minv = val;
    }
 
    return minv;
}

///@func			ds_list_sum(list)
///@arg {list} list	| list data structure
///
///@description		| Returns the sum of all values in a list.
///					| If the list is empty, undefined is returned.
///					| All list elements must be comparable.
///
///@return {any}
function ds_list_sum(list) {
    var n = ds_list_size(list);
    var sum = ds_list_find_value(list, 0);
 
    for (var i = 1; i < n; i++) sum += ds_list_find_value(list, i);
 
    return sum;
}

///@func			ds_list_mean(list)
///@arg {list} list	| list data structure
///
///@description		| Returns the arithmetic mean of values in a list.
///					| If the list is empty, undefined is returned.
///
///@return {real}
function ds_list_mean(list) {
    var n = ds_list_size(list);
    if (n == 0) return undefined;
 
    var avg = 0;
 
    for (var i = 0; i < n; i++) avg += ds_list_find_value(list, i);
    avg /= n;
 
    return avg;
}

///@func			ds_list_median(list)
///@arg {list} list	| list data structure
///
///@description		| Returns the median of the values in the given list.
///
///@return {any}
function ds_list_median(list)
{
    var n = ds_list_size(list);
    if (n == 0) return undefined;
 
    var sort = ds_list_create();
 
    for (var i = 0; i < n; i++) ds_list_add(sort, ds_list_find_value(list, i));
    ds_list_sort(sort, true);
    var middle = ds_list_find_value(sort, n div 2);
    ds_list_destroy(sort);
 
    return middle;
}

