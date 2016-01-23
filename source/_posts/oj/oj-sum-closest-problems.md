title: OJ Sum Closest Problems
date: 2016-01-21 17:12:51-05:00
category: OJ
tags: [KSum, LeetCode]
---

## 16. 3Sum Closest

### Question

{% blockquote LeetCode https://leetcode.com/problems/3sum-closest/ 16. 3Sum Closest %}
Given an array S of n integers, find three integers in S such that the sum is closest to a given number, target. Return the sum of the three integers. You may assume that each input would have exactly one solution.

For example, given array S = {-1 2 1 -4}, and target = 1.
The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
{% endblockquote %}

Tags: Medium, Two Pointers, Array

### Answers

#### Keep updating closest distance

The first idea hit my head is using the same method in [NSum Questions](http://taoalpha.me/blog/2016/01/13/oj-oj-leetcode-nsum/), but store the closest distance in a single value and keep updating it.

Here is the code:
``` javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number}
 */
var threeSumClosest = function(nums, target) {
  if(nums.length <= 0){
    return 0
  }
  if(nums.length <= 3){
    return nums.reduce( (a,sum) => sum += a )
  }
  var i,left,right,closest = Math.pow(2,31)-1;  // set initial min to maximum
  nums.sort( (a,b) => a-b );
  for(i = 0;i<nums.length-2;i++){
    // use nums.lenght -2 since there will be 3 numbers
    left = i+1;
    right = nums.length - 1;
    while(left < right){
      // update min if we can
      var sum = nums[i] + nums[left] + nums[right];
      if ( Math.abs(sum - target) < Math.abs((closest - target)) ) {
        closest = sum;
      }
      // normal loop over every possibility
      if (sum < target) {
        left ++;
      }else{
        right --;
      }
    }
  }
  return closest
};
```
Runtime : 160 ms

If there are a lot cases that atually can find the right combiantion which is the target, you can check the sum and target during the while loop, and maybe stop it earlier.

``` javascript
if(sum == target){
  return sum
}
```

Seems no simple and better solution for this one. So I will stop here.

## KSum Closest

This is not a leetcode problem. But same as KSum or NSum problems, can we summarize a general solution for KSum Closest ?

``` javascript
// pre-requirement: has to be at least one solution
var KSumClosest = function(nums, target, output, preSum, N) {
  
  if (nums.length < N || N < 2) return

  if (N == 2) {
    var i = 0,
        j = nums.length - 1;
    while (i < j) {
      var sum = preSum + nums[i] + nums[j];
      if ( Math.abs(sum - target) < Math.abs(output.ans - target) ) {
        output.ans = sum;
      }
      // normal loop over every possibility
      if (sum < target) {
        i ++;
      }else{
        j --;
      }
    }
  }else{
    var i = 0;
    for(i = 0;i<nums.length;i++){
        preSum += nums[i]
        KSumClosest(nums.slice(i+1), target, output, preSum, N - 1)
        preSum -= nums[i]
    }
  }
}
```

Accepted by previous 3sum closest.
