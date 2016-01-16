title: OJ LeetCode NSum Problem
date: 2016-01-13 15:19:20-05:00
category: OJ
tags: [LeetCode,HashTable]
---


## 1. Two Sum

### Question

{% blockquote LeetCode https://leetcode.com/problems/two-sum/ 1. 2Sum %}
Given an array of integers, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.

You may assume that each input would have exactly one solution.

Input: numbers={2, 7, 11, 15}, target=9
Output: index1=1, index2=2
{% endblockquote %}

Tags: Array, Hash Table

### Answers

#### IndexOf

Before we think about hashtable, the more strightforward idea is that we subtract the current number from the target and then check whether the result is in the rest of the list or not.

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  for(var i = 0;i<nums.length;i++){
    var secondIndexOffset = nums.slice(i+1,nums.length).indexOf(target - nums[i])
    if(secondIndexOffset>-1){
      return [i+1,i+secondIndexOffset+2]
    }
  }
};
```
Runtime: 456 ms

Or we use while to save some time:

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  for(var i = 0;i<nums.length;i++){
    var j = i+1
    while(j<nums.length){
      if(nums[i]+nums[j] == target){
        return [i+1,j+1]
      }
    }
  }
}
```
Runtime: 336 ms

#### hashtable

The previous answer can solve the problem but it is too slow, it is O(n^2) way too slow. We need to speed it up.

Since we can assume each input would have exactly one solution which means that there should not have duplicate number in the nums or the duplicate numbers wouldn't affect the result, so we can use a hashtable store all the numbers and the index of them to speed up the process.

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  var mapper = {}
  for(var i =0;i<nums.length;i++){
    mapper[nums[i]] = i+1
  }
  for(i = 0;i<nums.length;i++){
    var remain = target - nums[i]
    if(mapper[remain] && mapper[remain] -1 !== i){
      return [i+1,mapper[remain]]
    }
  }
};
```
Runtime: 140 ms

### Personal Follow Up

if we can not assume that each input would have exactly one solution, then how to solve it?

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  var output = []
  for(var i = 0;i<nums.length;i++){
    var j = i+1
    while(j<nums.length){
      if(nums[i]+nums[j] == target){
        output.push(i,j)
      }
    }
  }
  return output
}
```

If we want get all possible and no duplicate combinations(using values instead of indices) of two sum:

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  var i = 0, j = nums.length-1
  var output = []
  nums.sort( (a,b)=> a - b)
  while(i<j){
    if(nums[i]+nums[j] == target){
      output.push([nums[i],nums[j]])
      i ++
      j --
      // remove the duplicate values
      while(i<j && nums[i] == nums[i-1]){
        i++
      }
      while(i<j && nums[j] == nums[j+1]){
        j--
      }
    }else if(nums[i]+nums[j] > target){
      j -- 
    }else{
      i ++
    }
  }
  return output
}
```

Use hash table:

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
  var output = [],nnums = [],amapper = {}
  for(var i = 0;i<nums.length;i++){
    if(!amapper[nums[i]]){
      nnums.push(nums[i])
      amapper[nums[i]] = 1
    }else{
      amapper[nums[i]] ++
    }
  }
  // build the hash of all elements and remove the duplicates

  // store all possible combinations
  for(var i = 0;i<nnums.length;i++){
    for(var j = i+1;j<nnums.length;j++){
      var sum = nnums[i]+nnums[j]
      if(sum == target){
        output.push([nnums[i],nnums[j]])
      }
    }
  }

  // consider about the special case that two sub elements are same
  if(amapper[target/2] >=2){output.push([target/2,target/2])}
  return output
}
```

Compared with the two pointers method, this one would be a little slower - test with replacing this one with previous one in the findNSum function below.

## 18. 4Sum

### Question

{% blockquote LeetCode https://leetcode.com/problems/4sum/ 18. 4Sum %}
Given an array S of n integers, are there elements a, b, c, and d in S such that a + b + c + d = target? Find all unique quadruplets in the array which gives the sum of target.

Note:
Elements in a quadruplet (a,b,c,d) must be in non-descending order. (ie, a ≤ b ≤ c ≤ d). The solution set must not contain duplicate quadruplets.

For example, given array S = {1 0 -1 0 -2 2}, and target = 0.

A solution set is:

(-1,  0, 0, 1)

(-2, -1, 1, 2)

(-2,  0, 0, 2)
{% endblockquote %}

Tags: Array, Hash Table, Two Pointers, Medium

### Answers

#### reduce to 2Sum

``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[][]}
 */
var fourSum = function(nums, target) {
  // sort
  nums.sort( (a,b)=> a - b)
  var output = []
  findNSum(nums,target,4,[],output)
  return output
};

var findNSum = (nums,target,N,result,output)=>{
  // base exit case
  if(nums.length < N || N < 2) return

  // 2Sum like before but don't need to sort the list again
  if(N==2){
    // can replace below with any one of these 2Sum ways
    var i = 0, j = nums.length-1
    while(i<j){
      if(nums[i]+nums[j] == target){
        output.push(result.concat([nums[i],nums[j]]))
        i ++
        j --
        // remove the duplicate values
        while(i<j && nums[i] == nums[i-1]){
          i++
        }
        while(i<j && nums[j] == nums[j+1]){
          j--
        }
      }else if(nums[i]+nums[j] > target){
        j -- 
      }else{
        i ++
      }
    }
  }else{
    for(var i = 0;i<nums.length;i++){
      if(i==0 || (i>0 && nums[i-1] != nums[i])){
        // recursively call findNSum
        findNSum(nums.slice(i+1,nums.length), target-nums[i],N-1,result.concat([nums[i]]),output)
      }
    }
  }
}
```

Runtime: 328 ms

Since the nums is sorted, we can use pruning during the for loop to save a lot of time:

```
// add this within the for loop before the recursion
if(nums[i]*N > target || nums[nums.length-1]*N < target) break
```
Runtime: 228


#### Using Hash Table

Think about using the hashtable store all value of two pairs, and then treat it like a twoSum problem, but will use a lot space.


## Summary

All NSum problems can be solved by the same way.
