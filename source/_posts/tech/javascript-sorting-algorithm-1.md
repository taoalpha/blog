date: 2015-10-29 4:00:00
title: Sorting Algorithm in JavaScript - Insertion Sort and Selection Sort
category: tech 
description: Sorting Alogorithm is one of the most frequently used algorithms and we have many different kinds of sorting algorithms. In order to understand javascript better and do more practice, I will implement several famous sorting algorithms in JavaScript.
tags: [JS,Algorithm,Sorting] 
series: Sorting Algorithm in JavaScript
author: taoalpha
language: en
---

## Sorting Algorithm

As the most important and fundamental algorithm, sorting algorithm is always the best start to learn algorithm.

Among all the different sorting algorithms, we have 10 algorithms which are used a lot in practice, and I will introduce all these ten algorithms one by one. 

Today we will talk about: Selection Sort and Insertion Sort.

## Selection Sort

Selection Sort is one of the most fundamental sort algorithms you would learn from any book about algorithm. The method and theory based on is really easy and clear:

- **input:** a list of numbers need to be sorted
- **procedures:**
  - create a new list to save the sorted elements
  - select the minimum element from the input list and push it into the new list, and remove it from the input list
  - repeat the second step until we don't have any more elements in input list
- **output:** the list you created to save the sorted elements

Easy, huh ? Let's calculate the cost: the average time complexity would be n^2/2 which would be O(n^2), since we need check the input list n times with n/2 elements to check every time; and since we are using a new list to save the output, it would be O(n) space.

Can we optimize it ? Yes and no. For time complexity, we can not do any optimization since it is the theory that selection sort is using, we have nothing to do with that. But for space complexity, we can do something.

We can actually do the sort in-place which means we can sort the list within the list and return the same list as the input except it is sorted.

In order to do that, we can change the procedures to:

- **input:** a list of numbers need to be sorted
- **procedures:**
  - start from the first element, we loop over the list from it to the end of the list and select the minimum element from the input list and swap it with it(start element);
  - repeat it until we reach the last element of the input list(now the start element and the end element would all be the last element)
- **output:** the input list 

By doing this way, we just need two spaces, one is used to save the index of the minimum element, another is used during the swap to save the one of the value that need to be swapped later. The space complexity would be O(1).

``` javascript
function selectionSort(list){
    for(var i = 0; i < list.length; i++){
      var min = i
      for(var j = i+1;j<list.length; j++){
        if(list[min]>list[j]){
          min = j
        }
      }
      var temp = list[i]
      list[i] = list[min]
      list[min] = temp
    }
    return list
  }
```

Selection Sort is easy but not efficient, since it always costs O(n^2) even your input list is sorted when you pass it in.

## Insertion Sort

Now we come to insertion sort which would a little more efficient than selection sort.

The theory is: consider the left part of the input list as sorted, and insert the new element into the proper position, since if one element always means it is sorted, so we always can do that by starting from the second element.

The procedures:

- start from the second element(if you don't have second element, you are done);
- compare every element in the left(sorted part), if it is greater than your start element, shift it to the right by 1, if it is less than your start element, insert your start element before it;
- repeat until the end of the list;

Time Complexity: O(n) in the best case(the list is sorted already), O(n^2) in the worst case, on average, it would be similiar to selection sort with O(n^2).

Space Complexity: O(1)

Lets implement it into real code:

``` javascript
function insertionSort(list){
  for(var i = 1; i < list.length;i++){
    var temp = list[i]
    var j = i
    while(j>0 && list[j-1]>temp){
      list[j] = list[j-1]
      j--
    }
    list[j] = temp
    // use shift instead of swap can reduce the cost of writing -- nearly 50%
    // if you use swap, it will slower than selectionSort
  }
  return list
}
```

Some people may be used to achieve insertion sort by using the swap too. You can, you just need compare and swap it with previous one until it reaches the right position. But the cost would be high since you will double your writes with swap.

> I actually calculate the time cost in javascript, most of time, if you use swap, your insertion sort would be slower than selection sort.


## Special Note

In general, insertion sort would be faster than selection sort if you implement it in right way. But in some special cases, you may find selection sort is faster.

The different between selection sort and insertion sort:

- selection sort reads the list a lot(n * (n+1) / 2, n is the length of the list) but only writes into the list a few times(= 2 * (the length of your list));
- insertion sort reads the list a lot too, but fewer than the selection sort(the worst case would be same with selection, best case would be equal to the length of the list), and meantime, it will write into the list much more times than selection sort(nearly the same with reading times);

So if it costs much more on reading instead of writing, you may consider choosing selection sort instead of insertion sort.


## Summary

That's all I think you should know about selection sort and insertion sort. Next post I will discuss about bubble sort and merge sort with you. See ya!
