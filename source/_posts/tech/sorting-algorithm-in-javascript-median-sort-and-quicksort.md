title: Sorting Algorithm in JavaScript - Quicksort and Heap Sort
date: 2016-01-18 19:33:27-05:00
category: tech
tags: [Sort,Algorithm,JS] 
series: Sorting Algorithm in JavaScript
---

Last time we have finished the four different sorting algorithms including : [insertion sort and selection sort](http://taoalpha.me/blog/2015/10/29/tech-javascript-sorting-algorithm-1/), [bubble sort and merge sort](http://taoalpha.me/blog/2015/10/29/tech-javascript-sorting-algorithm-2/).

Now let's continue playing with another one or two.

## Median Sort and Quicksort

### Median Sort

Similiar with merge sort, we still use divide and conquer, the basic approach for many problems, but what if we use some statistical information about the array that need to be sorted? Like the median of the array.

If we know the median, we can sort the array into 2 distinct subarrays of about half the size: left with all elements smaller than the median, and right with all elements bigger or equal to median. And we keep doing this for all subarrays, finally we will get a sorted array.

That gives us the MEDIAN SORT.

### Quicksort

Median sort is a nice start, but it still has one problem: how to find the the median of an array? Before we atually put our efforts on solving this problem, we should consider about another problem: how about we use some other attributes instead of median? Our purpose is divide the array into two parts, we don't need them to be the same size. By thinking this way, we may consider choose any value in the array and use this value as a separator and divide the array into subarrays.

This is quicksort, and the value we choose as a separator is called pivot.


Now let's show the code:

``` javascript
var quickSort = (list,left,right) => {
  var idx;
  if(list.length <= 1){
    return list
  }

  // left and right  must be number, default value :  0 and list.length - 1
  left = (left^0) !== left ? 0 : left
  right = (right^0) !== right ? list.length-1 : right

  // divide the array from left to right into two subarrays
  // return the index of the separator
  idx = partition(list,left,right) 

  if(left < idx - 1){
    // keep doing quicksort on left subarray until it can not be separated again
    quickSort(list,left,idx - 1)
  }
  if(idx < right){
    // keep doing quicksort on right subarray until it can not be separated again
    quickSort(list,idx,right)
  }
  return list
}

var partition = (list,begin,end) => {
  var pivot = Math.floor(Math.random()*(tail-head+1)+head), // random pivot index 
      pivot_value = list[pivot]; // pivot value

  // divide into two subarrays using the pivot value with two pointers
  while(begin <= end){
    
    // skip all 'good' ones in right
    while(list[end]>pivot_value){
      end --
    }

    // skip all 'good' ones in left 
    while(list[begin]<pivot_value){
      begin ++
    }

    // swap the 'bad' pairs to make them 'good'
    if(begin <= end){
      swap(list,begin,end)
      begin ++
      end --
    }
  }

  // return the separator line
  return begin
}

// swap function
var swap = (list,first,second) => {
  var temp = list[first]
  list[first] = list[second]
  list[second] = temp
}
```

With all comments, the code should be easy to understand.

Quicksort is famous and popular for its speed especially after linux start using it as the default sorting algorithm. Normally, if we know nothing about the distribution of our array and speed is the most important reason you consider about, then use quicksort.

In above example, we choose the pivot randomly. Normally, its good enough for using. But actually there are a lot of strategies and researches on how to choose a good pivot. Like always choose the first or last or middle, or use median, median-of-k...etc But normally, using randomly pivot will give you an average O(nlogn). If you want to learn more about these strategies, just google it :)


## Heap Sort

Before we go to the concept and code, we should know what is a heap:

{% blockquote WikiPedia https://en.wikipedia.org/wiki/Heap_(data_structure) Heap (data structure) - wikipedia %}
a heap is a specialized tree-based data structure that satisfies the heap property: If A is a parent node of B then the key of node A is ordered with respect to the key of node B with the same ordering applying across the heap.

In a max heap, the keys of parent nodes are always greater than or equal to those of the children and the highest key is in the root node. In a min heap, the keys of parent nodes are less than or equal to those of the children and the lowest key is in the root node. 
{% endblockquote %}

Got any inspirations ? Think this way: Max heap => the head of the heap is the max of the array. This is true for any max heap, so we remove the max and rebuild a heap with rest elements, we get the second largest... Yeah, you got it ?! :)

Now what we need to do is using array represent the heap which is pretty much a array tree:

for any element with index - idx:

- left child : idx*2 + 1
- right child: idx*2 + 2

Show me the code !!!

``` javascript
// heapSort - here we use max heap
var heapSort = (list) => {
  buildHeap(list);  // now we have the max value
  for(var i = list.length-1;i>=1;i--){
    // always put max value to the end of the current heap
    // so the end of the array will always be sorted and gradually expanded to the entire array
    swap(list,0,i); 

    // since we change the head of the heap
    // so we need redo the heap to get the new max of the heap
    heapify(list,0,i); 
  }
  return list
}
buildHeap(list){
  // start from the second last level of the tree which is the parent of the last element
  var mid = Math.floor(list.length / 2) - 1;
  for(var i = mid;i>=0;i--){
    // make sure every node of the tree is heapify
    heapify(list,i,list.length)
  }
}
heapify(list,idx,len){
  // len means the number of elements current heap has

  var left = 2*idx + 1,
      right = 2*idx + 2,
      largest;  // temp value to store the index of largest element of this tree unit

  largest = left < len && list[left] > list[idx] ? left: idx;
  largest = right < len && list[right] > list[len] ? right : largest;

  // if we have a new largest, swap it and redo heapify to make sure entire heap is correct
  if(largest !== idx){
    swap(list,largest,idx)
    heapify(list,largest,len)
  }
}
// swap function - same as before
```

Heap Sort is really fast, sometimes it is even faster than quicksort since it will guarantee the O(nlogn) even in the worst case. But normally in average case, the quicksort is a little faster.

## BTW

I believe I still have 2 posts for this serie, one will talk about the radix, and the other will be the counting and bucket sort. See ya.
