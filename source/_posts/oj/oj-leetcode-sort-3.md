title: OJ LeetCode Sort 3
category: OJ
date: 2016-01-06 17:23:37-05:00
tags: [OJ,LeetCode,Sort]
---


## 324. Wiggle Sort II

### Question

{% blockquote LeetCode https://leetcode.com/problems/wiggle-sort-ii/ 324. Wiggle Sort II%}
Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example:
(1) Given nums = [1, 5, 1, 1, 6, 4], one possible answer is [1, 4, 1, 5, 1, 6]. 
(2) Given nums = [1, 3, 2, 2, 3, 1], one possible answer is [2, 3, 1, 3, 1, 2].

Note:
You may assume all input has valid answer.

Follow Up:
Can you do it in O(n) time and/or in-place with O(1) extra space?
{% endblockquote %}

Tags: medium, sort

### Answers

#### Sort and insert

After several examples, you will find a pretty clear relation between the output and the input: all the small numbers will follow by a larger number. So how about we sort the list first and insert smaller half of the list into the larger half.

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var wiggleSort = function(nums) {
    nums.sort( (a,b)=>{return a-b})
    var mid = Math.floor(nums.length / 2)
    var left = nums.splice(0,mid+1)
    for(var i = 0,j=0;i<=mid;i++){
        nums.splice(j,0,left[i])
        j += 2
    }
};
```

T: O(n^2) - since the splice is O(n) too, S: O(1) - though we store half of the list, but all we use is n space in total all the time

One disadvantage of this method is that it alwasy has a result even when there should not be one. But since the question said we can assume all input has valid answer...so..

#### Sort and Replace

Now we use a little more space to speed up our answer.

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var wiggleSort = function(nums) {
    var sorted = nums.slice(0).sort( (a,b) => {return a-b});
    // copy the origin list and sort the copy-list as sorted
    var mid = Math.ceil(nums.length / 2),i=0,p=0
    // mid is the start index of large half
    for(; i < sorted.length; i++){
        if(i % 2 === 0) nums[i] = sorted[p++];
        // start with small number -> all index with even number should be smaller number(start from 0)
        else nums[i] = sorted[mid++];
        // all index with odd number should be larger number, use large half of the sorted list
    }
}
```

T: O(n), S: O(n)


## 164. Maximum Gap

### Question

{% blockquote leetcode https://leetcode.com/problems/maximum-gap/ 164. Maximum Gap %}
Given an unsorted array, find the maximum difference between the successive elements in its sorted form.

Try to solve it in linear time/space.

Return 0 if the array contains less than 2 elements.

You may assume all elements in the array are non-negative integers and fit in the 32-bit signed integer range.
{% endblockquote %}

Tags: Sort, Hard

### Answers

#### Bucket Sort

We still need use sort, question is which sort we should choose. Since required linear time/space, we have to use bucket sort, and the core problem would be how to decide the number of buckets we want to set. 

According to the [Pigeonhole principle](https://en.wikipedia.org/wiki/Pigeonhole_principle), the maximumGap >= (max_value - min_value) / (len - 1), so we use this minMaxGap as our number of buckets (to make sure that the distribution of our numbers in different buckets are as equal as possible).

``` javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var maximumGap = function(nums) {
  if(nums.length < 2) return 0
  var min = Math.min.apply(Math,nums)
  var max = Math.max.apply(Math, nums)
  var bucketCount = Math.ceil((max - min) / (nums.length - 1))

  var buckets = []
  for(var i = 0;i<nums.length;i++){
    var remain = Math.floor((nums[i] - min) / bucketCount);
    if(!buckets[remain]) buckets[remain] = []
    buckets[remain].push(nums[i]);
  }
  var sorted = []
  for(i = 0;i<buckets.length;i++){
    if(buckets[i]){
      buckets[i].sort( (a,b)=>{return a-b})
      sorted = sorted.concat(buckets[i])
    }
  }
  
  var maxGap = 0
  for(i = 1; i< sorted.length;i++){
    if(sorted[i]-sorted[i-1] > maxGap){
      maxGap = sorted[i] - sorted[i-1]
    }
  }
  return maxGap
}
```
Runtime: 240 ms

#### Bucket Sort Speed Up

In the above answer, we sorted the list using bucket sort and insertion sort, then calculate the maxGap among all these numbers. But actually we don't need sort the list, we only need to calculate the distance between the min of next bucket and the max of previous bucket, the maxGap must be the max of them, also since we only the max and min of the bucket, we don't even need to store all the numers in the bucket, we just store the max and min.

``` javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var maximumGap = function(nums) {
  if(nums.length < 2) return 0
  var min = Math.min.apply(Math,nums)
  var max = Math.max.apply(Math, nums)
  var bucketCount = Math.ceil((max - min) / (nums.length - 1))
  if(bucketCount == 0) bucketCount = 1
  // deal with cornercase like [1,1]

  var buckets = {}
  for(var i = 0;i<nums.length;i++){
    var remain = Math.floor((nums[i] - min) / bucketCount);
    if(!buckets[remain]){
      buckets[remain] = {}
      buckets[remain].max = buckets[remain].min = nums[i];
    }else{
      if(nums[i] > buckets[remain].max){
        buckets[remain].max = nums[i]
      }
      if(nums[i] < buckets[remain].min){
        buckets[remain].min = nums[i]
      }
    }
  }
  var maxGap = 0,preMax = null
  for(i in buckets){
    if(preMax && (buckets[i].min - preMax > maxGap)){
      maxGap = buckets[i].min - preMax
    }
    preMax = buckets[i].max
  }
  return maxGap
}
```
Runtime: 168 ms


## 56. Merge Intervals

### Question

{% blockquote leetcode https://leetcode.com/problems/merge-intervals/ 56. Merge Intervals %}
Given a collection of intervals, merge all overlapping intervals.

For example,
Given [1,3],[2,6],[8,10],[15,18],
return [1,6],[8,10],[15,18].
{% endblockquote %}

Tags: Sort, Array, Hard

### Answers

#### Sort by start

First, we sort the intervals by the start of each interval, then we compare the start and end of adjacent intervals, merge if there is overlap or push the previous merged or independent interval to the final output.

``` javascript
/**
 * Definition for an interval.
 * function Interval(start, end) {
 *     this.start = start;
 *     this.end = end;
 * }
 */
/**
 * @param {Interval[]} intervals
 * @return {Interval[]}
 */
var merge = function(intervals) {
  if(intervals.length < 1) return []
  // special condition
  var output = []
  intervals.sort( (a,b) => {return a.start - b.start})    
  // sort by the start
  var prev = intervals[0]
  for(var i = 1;i<intervals.length;i++){
    if(prev.end >= intervals[i].start){
      prev = new Interval(Math.min(prev.start,intervals[i].start),Math.max(prev.end,intervals[i].end))
      // merge, need to consider several corner case, make sure the start of new interval is the min of two start, and the end should be the max
    }else{
      output.push(prev)
      prev = intervals[i]
    }
  }
  output.push(prev)
  // push the last merged or leftover interval into the output
  return output
};
```
Runtime: 200 ms

This one is pretty easy with a hard tag... can not understand why...
