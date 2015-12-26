date: 2015-10-29 4:00:00
title: Sorting Algorithm in JavaScript - Bubble Sort and Merge Sort
category: tech 
description: Two more sorting algorithms.
tags: [Sorting,Algorithm,JS] 
series: Sorting Algorithm in JavaScript
author: taoalpha
language: en
---

## Introduction

Bubble sort is really cool but not so useful, it seems that you will never use it... But merge sort is really cool since it is really fast.

## Bubble Sort

So what is bubble sort, according to wikipedia:

> Bubble sort, sometimes referred to as sinking sort, is a simple sorting algorithm that repeatedly steps through the list to be sorted, compares each pair of adjacent items and swaps them if they are in the wrong order. The pass through the list is repeated until no swaps are needed, which indicates that the list is sorted. 

The whole process of sorting is like the bigger element "bubble" to the end of the list.

- **Input:** A list of numbers with random order
- **Procedures:**
  - Start from the head of the list, and compare every two adjacent numbers and swap them if they are in wrong order;
  - Record whether you did any swaps or not, if no, your list has been sorted, otherwise, you need to step 1 again;
- **Output:** A sorted list

If you like, you can do a small optimization to the procedures above: since every iteration we will make sure the bigger element will "bubble" to the end of the list, so everytime we don't need to check the last elements(they are already in ordered), and we will reduce the length for each iteration.

Here is a nice gif from wikipedia: ![bubble sort](https://upload.wikimedia.org/wikipedia/commons/c/c8/Bubble-sort-example-300px.gif)

The time complexity for bubble sort would be : O(n^2) for worst case, O(n) for best case, and O(n^2) on average.

The space complexity for bubble sort would be O(1) since we only need one space used to do the swap.


Now lets do the code:

``` javascript
// bubbleSort
function bubbleSort(list){
  var swapped
  var len = list.length
  do{
    swapped = false
    for(var j = 0;j< len-1;j++){
      reads += 2
      if(list[j]>list[j+1]){
        this.swap(list,j,j+1)
        swapped = true
        writes += 2
      }
    }
    len = len - 1
    // since everytime we will move the largest element to the end of the list, we can reduce the number of iteration without considering the last element every iteration
  }while(swapped)

  return list
}
```

## Merge Sort

Now we met all three different kinds of sorting, all of them have a O(n^2) of time complexity on average.

Lets do something faster: Merge Sort.

Imagine you separate your list into several really small lists with only one element or zero element in each of them. Then you merge every two small lists into one sorted list, and keep doing it repeatly.(it's easy because you are merging two sorted lists)


The whole procedures will be:

- Split the list recursively;
- Merge the small lists until you merge them all;

Since we always split by half, the number of small lists we will have would be log(n), and the total cost would be close to (n / 2 * log(n)) on average(since we have at least 1 element list to merge with zero one, at most n/2 elements list to merge with n/2 elements). So the time complexity would be O(nlog(n)) all the time, and the space complexity would be O(n) since we will save origin input list with n small lists.

``` javascript
// mergeSort
function mergeSort(list){
  if(list.length <= 1) return list
  var mid = Math.floor(list.length / 2)
  return merge(mergeSort(list.slice(0,mid)),mergeSort(list.slice(mid)))
}
function merge(left,right){
  var nl = []
  var il = 0, ir = 0
  while(il<left.length && ir<right.length){
    if(left[il] < right[ir]){
      nl.push(left[il++])
    }else{
      nl.push(right[ir++])
    }
    // don't use shift because shift will actually cause a lot I/Os 
  }
  nl = nl.concat(left.slice(il)).concat(right.slice(ir))
  return nl
}
```

## Summary

Merge sort is kind useful, and if we don't have quick sort which I will talk about next post, it would be a really good choice to do sorting. And even we have quick sort, merge sort still exists in many languages as part of their default sorting algorithm.

And also there are several optimizations for merge sort, if you are interested in, you can search it on google.

That's all for today. Good night!
