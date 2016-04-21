title: OJ water problems
date: 2016-02-13 13:55:19-05:00
category: OJ
tags: [LeetCode, Two Pointers]
---

## 11. Container With Most Water

### Problem

{% blockquote LeetCode https://leetcode.com/problems/container-with-most-water/ 11. Container With Most Water%}
Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

Note: You may not slant the container.
{% endblockquote %}

Tags: Array, Two Pointers, Medium

### Answers

Two pointers, keep tracking the max area.

``` javascript
/**
 * @param {number[]} height
 * @return {number}
 */
var maxArea = function(height) {
  var i = 0, j = height.length - 1, max = 0;
  while (i<j) {
    max = Math.max(max,Math.min(height[j] , height[i]) * (j - i));
    if (height[i] < height[j]) {
      i ++;
    }else{
      j --;
    }
  }
  return max;
}; 
```
Runtime:  116 ms

## 42. Trapping Rain Water

### Problem

{% blockquote LeetCode https://leetcode.com/problems/trapping-rain-water/ 42. Trapping Rain Water %}
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example, 
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.
{% endblockquote %}

Tags: Array, Stack, Two Pointers

### Answers

Different with previous question, now we need to keep tracking the trapping water. Consider collection the water on each cell: every cell how much mater you can collect depends on the smaller one of the max height of your left bars and the max height of your right bars.

``` javascript
/**
 * @param {number[]} height
 * @return {number}
 */
var trap = function(height) {
  var i,j, left = [], right = [], max = 0, res = 0;
  for (i = 0; i < height.length; i++) {
    // store the max high left bar of each position
    max = Math.max(max,height[i]);
    left[i] = max;
  }
  max = 0;
  for (i = height.length - 1; i >= 0; i--) {
    // store the max high righ bar of each position
    max = Math.max(max,height[i]);
    right[i] = max;
  }
  for (i = 0; i < height.length; i++) {
    var temp = Math.min(left[i],right[i]);
    if(temp > height[i]) {
      res += temp - height[i]
    }
  }
  return res
}; 
```
Runtime: 144 ms

Actually we don't need the two list storing the maxLeft and maxRight, since every max value we only will use once and both maxLeft and maxRight are depends on the bars on the left or right of the current bar. So we can just use two numbers track it.

Then you can simplify your code:

``` javascript
/**
 * @param {number[]} height
 * @return {number}
 */
var trap = function(height) {
  var i = 0, j = height.length - 1, leftMax = 0, rightMax = 0, res = 0;
  while(i<=j){
    leftMax = Math.max(leftMax,height[i]);
    rightMax = Math.max(rightMax,height[j]);
    if (leftMax < rightMax) {
      res += (leftMax - height[i]);       // leftmax is smaller than rightmax, so the (leftmax-A[a]) water can be stored
      i++;
    }else{
      res += (rightMax - height[j]);
      j--;
    }
  }
return res;
};
```

Runtime: 124 ms


Two pointers is a really good solution for some classical questions like KSum, Palindrome Problems...
