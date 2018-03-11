date: 2016-01-19 7:00:00
title: JavaScript Sorting Algorithm - Radix Sort and Bucket Sort
category: tech
description: Two basic sorting algorithms, radix and bucket.
tags: [sort,algorithm]
series: The way I learn Algorithm
author: taoalpha
---

## Comparison based sorting algorithms
We have discussed all popular comparison based sorting algorithms: [insertion sort and selection sort](http://taoalpha.github.io/blog/2015/10/29/tech-javascript-sorting-algorithm-1/), [bubble sort and merge sort](http://taoalpha.github.io/blog/2015/10/29/tech-javascript-sorting-algorithm-2/), [Quicksort and Heap Sort](http://taoalpha.github.io/blog/2016/01/19/tech-sorting-algorithm-in-javascript-median-sort-and-quicksort/).

All these algorithms are great under most of conditions, but their lower bound is O(nlogn), they can not do better.

If for some reason, we want to achieve better than nLogn, we have to find some other ways.

About why the lower bound of all comparison based sorting algorithms is nlogn ?

## Why nlogn
For any array with n elements, it has n! possible orders. Since we are using comparison based, suppose we are building a decision tree for all these possible orders, and h is the height of the decision tree and also is how many number of comparisons we need to get down to the leaves. Then we should have:

2^h >= n! which means: the total number of leaves should be enough to cover all possible orders of our array.

Then we would get h >= nlogn for approximation.

## Non-Comparison based sorting algorithms
So if we want to get over the nlogn, we have to ask help from some non-comparison based ways.

If you knew or heard about the sorting algorithms, you should know we have several famous non-comparison based sorting algorithms: counting sort, bucket sort and radix sort.

And lets talk about them today, one by one :)

### Counting Sort
Imagine this situation:

You have a deck of playing cards in random order(without jokers), and you want to sort them into the ascending order from A to K. What you gonna do ? Possibly you will count the cards and group them into 13 groups from A to K, and then combine these groups from A to K.

This is a classical counting sort. Once we are sure how many groups we have in our array or we know that the elements in our array are coming from a distribution from a to b. Then we can group them into (b - a + 1) buckets and loop over the array, put elements into proper buckets and then combine them.

Here is the code:

``` javascript
// counting sort
countingSort(list){
  var bucket = [],idx = 0;

  // assign each element to its bucket
  for(var i = 0;i<list.length;i++){
    bucket[list[i]] = bucket[list[i]] || 0
    bucket[list[i]] ++
  }

  // now combine all the buckets
  for(i = 0; i< bucket.length;i++){
    while(bucket[i] && bucket[i] > 0){
      // skip empty buckets and loop over every elements in a bucket
      list[idx++] = i;
      bucket[i] --;
    }
  }
  return list
}
```

### Bucket Sort
The counting sort is amazing fast : O(n+k), k is the number of buckets we have. But it costs too much space, and if we don’t know the distribution of elements, it maybe have a lot of empty buckets which is a waste of space.

Bucket sort is an optimization of counting sort, instead of only assigning same elements into one bucket, it will put several elements into one bucket but make sure the it is ascending from the point of buckets which means: for i,j buckets, if i < j, we know any elements in i will smaller than any elements in j.

By doing this, we can divide the entire array into a lot of small subarrays, and now we can just use any comparison based sorting algorithm to sort the small arrays.

Same as counting sort, if we have a wonderful distribution of our elements, it would be O(n + klogb), k is the number of buckets and b is the number of elements in one bucket, to sort the entire array. But the worst case, all elements assigned into the same buckets, it will degrade to the comparison based sorting algorithm we use, but only when you choose a really bad method to group.

``` javascript
// bucketSort
bucketSort(list,bucketCount){
  // only for numbers
  var min = Math.min.apply(Math,list),  // get the min
      buckets = [],
      bucket_count = bucketCount || 200

  // build the bucket and distribute the elements in the list
  for(var i = 0;i<list.length;i++){
    // this is a simple hash function that will make sure the basic rule of bucket sort
    var newIndex = Math.floor( (list[i] - min) / bucket_count );  

    buckets[newIndex] = buckets[newIndex] || []
    buckets[newIndex].push(list[i])
  }
  // refill the elements into the list
  var idx = 0
  for(i = 0;i<buckets.length;i++){
    if(typeof buckets[i] !== "undefined"){
      // select those non-empty buckets
      insertionSort(buckets[i]);  // use any sorting algorithm would be fine
      // sort the elements in the bucket
      for(var j = 0;j<buckets[i].length;j++){
        list[idx++] = buckets[i][j]
      }
    }
  }
  return list
}
```

### Radix Sort
Counting sort and Bucket sort are great, but they are too space-consuming and sometimes they are even slower than comparison based ones. Like if we have a really sparse array coming from 0 to n^2, then counting sort would down to O(n^2), and also if we don’t know the distribution of all elements in the array, we might choose an unefficient way to do the hash part for bucket sort, we could still get O(n^2).

Radix is here to help us out of this trouble. The idea of Radix Sort is to do digit by digit sort starting from least significant digit to most significant digit. Radix sort uses counting sort as a subroutine to sort.

For example: we have: [101, 203, 5, 87, 76, 48], using radix sort:

[101,203,5,76,87,48] <- last digits
[101,203,5,48,76,87] <- second last digits
[5,48,76,87,101,203] <- the first digits
Using zero when the number doesn’t have this digit.

Now lets show the code:

``` javascript
// helper function to get the last nth digit of a number
var getDigit = function(num,nth){
  // get last nth digit of a number
  var ret = 0;
  while(nth--){
    ret = num % 10
    num = Math.floor((num - ret) / 10)
  }
  return ret
}

// radixSort
radixSort(list){
  var max = Math.floor(Math.log10(Math.max.apply(Math,list))),  
      // get the length of digits of the max value in this array
      digitBuckets = [],
      idx = 0;

  for(var i = 0;i<max+1;i++){

    // rebuild the digit buckets according to this digit
    digitBuckets = []
    for(var j = 0;j<list.length;j++){
      var digit = getDigit(list[j],i+1);

      digitBuckets[digit] = digitBuckets[digit] || [];
      digitBuckets[digit].push(list[j]);
    }

    // rebuild the list according to this digit
    idx = 0
    for(var t = 0; t< digitBuckets.length;t++){
      if(digitBuckets[t] && digitBuckets[t].length > 0){
        for(j = 0;j<digitBuckets[t].length;j++){
          list[idx++] = digitBuckets[t][j];
        }
      }
    }
  }
  return list
}
```

The time complexity for radix sort is : O(d*(n+b)), d is the number of digits the array has, b is the buckets we have, normal it is 10 for base 10 system.

Cool ha :)

## BTW
Since I combine radix sort with bucket sort and counting sort, so this is the last post about sorting algorithms. But for this serie, I think I will have another post talking about when we should use which algorithm.

See ya.

Oh, and also, I combine all these codes together and create a gist for it: Soting Algorithms in JS.