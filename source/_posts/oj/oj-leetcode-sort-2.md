title: OJ LeetCode Sort 2
category: OJ
date: 2016-01-05 11:29:58-05:00
tags: [Sort,LeetCode,OJ]
---

## 147. Insertion Sort List

### Question

{% blockquote LeetCode https://leetcode.com/problems/insertion-sort-list/ 147. Insertion Sort List %}
Sort a linked list using insertion sort.
{% endblockquote %}


Tag: sort,medium

### Answer

Insertion sort as required.

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
var insertionSortList = function(head) {
  if(head == null || head.next == null){return head}
  var helper = new ListNode(-1) // need a helper node to insert the smallest node into the head of the listNode
  var outer = head // outer loop, the node that would be inserted into proper position
  var inner = helper // inner loop, the node that outer node should be inserted after
  var next = head // next loop node
  while(outer){
    // store the next node of the outer => for next loop
    next = outer.next
    // find the proper position that the outer node should inserted into
    while(inner.next && inner.next.val < outer.val){
      inner = inner.next
    }
    // insert
    outer.next = inner.next
    inner.next = outer
    // start over every outer loop
    inner = helper
    // loop for next
    outer = next
  }
  return helper.next
};
```
Runtime: 236 ms

## 274. H-Index

### Question

{% blockquote LeetCode https://leetcode.com/problems/h-index/ 274. H-Index %}
Given an array of citations (each citation is a non-negative integer) of a researcher, write a function to compute the researcher's h-index.

According to the definition of h-index on Wikipedia: "A scientist has index h if h of his/her N papers have at least h citations each, and the other N − h papers have no more than h citations each."

For example, given citations = [3, 0, 6, 1, 5], which means the researcher has 5 papers in total and each of them had received 3, 0, 6, 1, 5 citations respectively. Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, his h-index is 3.

Note: If there are several possible values for h, the maximum one is taken as the h-index.
{% endblockquote %}

Tag: sort,medium

### Answers


#### Sort first

First, we need know that the return value would be one between 0 and the length of the list.

Then, according to the definition of h-index, what we need is the max h that has at least h papers has a referrence number greater than h.

So we sort the list first, and then loop the list reversely, try to find the max fit value that let the number of papers left in the list = length - index <= citations[index]

``` javascript
/**
 * @param {number[]} citations
 * @return {number}
 */
var hIndex = function(citations) {
  if(citations.length<=0){return 0}
  var sorted = citations.sort((a,b)=>{return a - b})
  // sort in javascript is a in-place function, you don't need use another array
  // default sort function compare everything as a string
  var h_index = 0
  for(var i = sorted.length;i>=0;i--){
    if(sorted.length - i <= sorted[i]){
      h_index = Math.max(h_index,sorted.length-i)
    }
  }
  return h_index
};
```
Runtime: 152 ms


#### Hashtable

Since we use sort, the time comlexity would be O(nlogn) or even worse. We can use hashtable to speed up.

We store all the citations into one table as a 'value-count' pair, and store all value greater that length of the list into one place, since the h-index could only be the value between 0 to the length.

Now we have all possible h-indexs, what we need is to find the max fit one, the only fit rule is that the number of papers that have a referrence greater than h is greater or equal to h.

``` javascript
/**
 * @param {number[]} citations
 * @return {number}
 */
var hIndex = function(citations) {
  if(citations.length<=0){return 0}
  var countTable = {}
  for(var i = 0;i<citations.length;i++){
    var key = citations[i]
    if(citations[i] >= citations.length){
      key = citations.length
    }
    countTable[key] = countTable[key] || 0
    countTable[key] ++ 
  }
  var sum = 0
  for(h = citations.length;h>=0;h--){
    sum += countTable[h] || 0
    if(sum >=h){
      return h
    }
  }
  return 0
};
```
Runtime: 152 ms

## 179. Largest Number

### Question

{% blockquote LeetCode https://leetcode.com/problems/largest-number/ 179. Largest Number %}
Given a list of non negative integers, arrange them such that they form the largest number.

For example, given [3, 30, 34, 5, 9], the largest formed number is 9534330.

Note: The result may be very large, so you need to return a string instead of an integer.
{% endblockquote %}

Tag: sort,medium

### Answer

Consider all elements as string instead of number would solve this problem, can not use the default sort, because default sort would compare the each character, so '9' would be smaller that '96', we need to define the sort function by ourselves.

Also need to consider about some corner cases: start with 0.

``` javascript
/**
 * @param {number[]} nums
 * @return {string}
 */
var largestNumber = function(nums) {
  return nums.sort( (a,b)=>{return (b + '' + a) - (a + '' + b)}).join("").startsWith("0") ? "0" : nums.sort( (a,b)=>{return (b + '' + a) - (a + '' + b)}).join("")
  // return nums.sort( (a,b)=>{return (b + '' + a) - (a + '' + b)}).join("").replace(/^0*/g,'') || "0"
  // also we can remove all the leading 0s and it will be empty string then we can just return 0
}
```
Runtime: 176 ms

You can also use radix sort, and combine each bucket before other buckets, but the code would be very complex.
