title: OJ LeetCode Sort 1
category: OJ
date: 2016-01-03 22:42:13-05:00
tags: [OJ,Sort,LeetCode]
series: LeetCode Practice
---

## Aside

This is a new category special for coding practice. I will use this category record all the coding problems I met and solved or unsolved.

And of course, all answers I list will be written in JavaScript :)

## 242. Valid Anagram

tag: sort, easy

### Question 

{% blockquote LeetCode https://leetcode.com/problems/valid-anagram 242. Valid Anagram %}

Given two strings s and t, write a function to determine if t is an anagram of s.

For example,
s = "anagram", t = "nagaram", return true.
s = "rat", t = "car", return false.

Note:
You may assume the string contains only lowercase alphabets.

Follow up:
What if the inputs contain unicode characters? How would you adapt your solution to such case?

{% endblockquote %}

### Answers

#### HashTable

``` javascript
/**
 * @param {string} s
 * @param {string} t
 * @return {boolean}
 */
var isAnagram = function(s, t) {
  var letterMap = {}
  s.split('').forEach( (v) =>{
    letterMap[v] = letterMap[v] || 0
    letterMap[v] ++
  }
  t.split('').forEach( (v) =>{
    letterMap[v] = letterMap[v] || 0
    letterMap[v] --
  }
  for(var i in letterMap){
    if(letterMap[i] != 0){
      return false
    }
  }
  return true
}
// should be O(n) both for time complexisity and space complexity
```
Pass the online judge, Runtime: 212 ms.


#### sort

``` javascript
/**
 * @param {string} s
 * @param {string} t
 * @return {boolean}
 */
var isAnagram = function(s, t) {
  return s.split('').sort().join("") == t.split("").sort().join("")
}
```
Pass and the run time is : 180-200 ms

The runtime of javascript is so unstable, seems that they actually run the code in user's browser :)

I guess these two methods are most common ways to solve this easy problem. I looked at the dicuss and didn't find any new ways, so I guess that's it.

About how to deal with the unicode. I tested it under nodejs, and the default sort function can handle the unicode by itself :) And also even it can not, we can also encoding it and save the unicode as a string and do it like the normal english letter.


## 75. Sort Colors

tag: sort, medium

### Question 
{% blockquote LeetCode https://leetcode.com/problems/sort-colors/ 75. Sort Colors %}
Given an array with n objects colored red, white or blue, sort them so that objects of the same color are adjacent, with the colors in the order red, white and blue.

Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

Note:
You are not suppose to use the library's sort function for this problem.
Modify the nums in-place.

Follow up:
A rather straight forward solution is a two-pass algorithm using counting sort.
First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.

Could you come up with an one-pass algorithm using only constant space?
{% endblockquote %}

### Answers

#### Sort

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var sortColors = function(nums) {
  // insertion sort
  for(var i = 1;i<nums.length;i++){
    var temp = nums[i]
    for(var j=i-1; j>=0;j--){
      if(temp< nums[j]){
        nums[j+1] = nums[j]
      }else{
        break
      }
    }
    nums[j+1] = temp
  }
};
```
Runtime: 152 ms

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var sortColors = function(nums) {
  // counting sort
  var bucket = [0,0,0]
  nums.forEach( (v) => {
    v == 0?bucket[0]++ : v == 1 ? bucket[1]++ : bucket[2] ++
  })
  var j = 0
  bucket.forEach( (v,i) =>{
    while(v>0){
      nums[j++] = i
      v--
    }
  })
};
```
Runtime: 152 ms

#### One pass

Move all 0s to the head of the array and all 2s to the tail, using `unshift()` and `push()`.

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var sortColors = function(nums) {
  var len = nums.length
  for(var i = 0;i<len;i++){
    if(nums[i] == 0){
      nums.unshift(nums.splice(i,1)[0])
    }else if(nums[i] == 2){
      nums.push(nums.splice(i,1)[0])
      i--
      len --
    }
  }
};
```
runtime: 160ms

Same idea but using swap instead of `unshift()` and `push()`.

``` javascript
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var sortColors = function(nums) {
  var head = 0,tail = nums.length-1
  for(var i = 0;i<=tail;i++){
    if(nums[i] == 0){
      var temp = nums[i]
      nums[i] = nums[head]
      nums[head] = temp
      head ++
    }else if(nums[i] == 2){
      var temp = nums[i]
      nums[i] = nums[tail]
      nums[tail] = temp
      tail --
      i --
    }
  }
};
```
Runtime : 156ms

## 148. Sort List

tag: sort, medium

### Question

{% blockquote LeetCode https://leetcode.com/problems/sort-list/ 148. Sort List %}
Sort a linked list in O(n log n) time using constant space complexity.
{% endblockquote %}

### Answers

constant space => in-place
O(nlogn) => quick-sort(worst O(n^2)),merge-sort

``` javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var sortList = function(head) {
   // merge sort 
   // deal with the one node situation
   if(head == null || head.next == null){return head}
   return mergeSort(head, null);
};
var mergeSort = (head,tail) => {
  if(head.next == tail){
    head.next = null
    return head
  }
  var middle = findMiddle(head,tail)
  var left = mergeSort(head,middle)
  var right = mergeSort(middle,tail)
  return merge(left,right)
}
var merge = (left,right) =>{
  var head = new ListNode(-1), node = head
  while(left != null && right != null){
    if(left.val < right.val){
      node.next = left
      node = left
      left = left.next
    }else{
      node.next = right 
      node = right
      right = right.next
    }
  }
  var remail = null
  if(left == null && right != null){
    remail = right
  }else if(left != null && right == null){
    remail = left
  }
  node.next = remail
  return head.next
}
var findMiddle = (head,tail) =>{
  // find the middle node given the head and tail
  var slow = head,fast = head
  tail = tail || null
  while(fast != tail){
    fast = fast.next
    if(fast != tail){
      fast = fast.next
    }
    slow = slow.next
  }
  return slow
}
```
Runtime: 252 ms

Didn't try quick sort, but according to the discuss of this problem, seems it doesn't work(will TLE, maybe because of the worst case), and the code would be very complex.


ghat's it. Everytime I solve several problems, I will post on this blog under the OJ category. :)
