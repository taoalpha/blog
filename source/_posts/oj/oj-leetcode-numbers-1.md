title: OJ LeetCode Numbers 1
date: 2016-01-16 16:22:20-05:00
category: OJ
tags: [LeetCode, Numbers]
---

## 2. Add Two Numbers

### Question

{% blockquote LeetCode https://leetcode.com/problems/add-two-numbers/ 2. Add Two Numbers %}
You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
{% endblockquote %}

Tags: Medium, Linked List, Math

### Answers

#### Common parts first

The idea is to add the common parts first and store the carry number produced every round a addition.

Then deal with the remain, just be careful about the carry.

Then if we still have a carry number, create a new node and add it to our result.

``` javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
  var head = new ListNode(-1),
      cur = head,
      carry = 0;
  while(l1 && l2){
    var nodeVal = l1.val + l2.val + carry,node = new ListNode(0);
    if(nodeVal >= 10){
      carry = 1
      node.val = nodeVal % 10
    }else{
      carry = 0
      node.val = nodeVal
    }
    cur.next = node
    cur = node
    l1 = l1.next
    l2 = l2.next
  }
  // deal with the remain
  var remain = l1 || l2
  while(remain){
    if(remain.val + carry >= 10){
      remain.val = (remain.val + carry) % 10
      carry = 1
    }else{
      remain.val += carry
      carry = 0
    }
    cur.next = remain
    cur = cur.next
    remain = remain.next
  }
  // if no remain
  if(carry>0){
      var temp = new ListNode(carry)
      cur.next = temp
  }
  return head.next
};
```

Runtime : 304ms

#### All in one loop

Actually you can find that the main logic of our two while loops are the same, we can combine them:

``` javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
  var head = new ListNode(-1),
      cur = head,
      carry = 0;
  while(l1 || l2){
    var l1val = (l1 && l1.val) || 0
    var l2val = (l2 && l2.val) || 0
    var nodeVal = l1val + l2val + carry,node = new ListNode(0);
    if(nodeVal >= 10){
      carry = 1
      node.val = nodeVal % 10
    }else{
      carry = 0
      node.val = nodeVal
    }
    cur.next = node
    cur = node
    l1 = (l1 && l1.next) || null
    l2 = (l2 && l2.next) || null
  }
  // if no remain
  if(carry>0){
      var temp = new ListNode(carry)
      cur.next = temp
  }
  return head.next
};
```
Runtime: 320ms

The two methods should be at the same time complexity.

## 9. Palindrome Number

### Question

{% blockquote LeetCode https://leetcode.com/problems/palindrome-number/ 9. Palindrome Number %}
Determine whether an integer is a palindrome. Do this without extra space.
{% endblockquote %}

Tags: Easy,Math

### Answers

Can not understand what `without extra space` means... but we can figure out some O(1) space methods...

#### Head and Tail Comparator

``` javascript
/**
 * @param {number} x
 * @return {boolean}
 */
var isPalindrome = function(x) {
  if(x<0){return false}
  var numDigits = Math.floor(Math.log10(x)) + 1,i = 1;
  while(i<=numDigits/2){
    if( (Math.floor(x % Math.pow(10,numDigits - i+1) / Math.pow(10,numDigits-i))) != 
        (Math.floor(x % Math.pow(10,i) / Math.pow(10,i-1))) ){ return false }
    i += 1
  }
  return true
};
```

Runtime: 768 ms

#### Math

It is not a pure math problem, but if you know math well, you can figure out some way like this:

- reduce the x into half
- store the reduced half into another number
- compair the two

``` javascript
/**
 * @param {number} x
 * @return {boolean}
 */
var isPalindrome = function(x) {
  if(x<0 || (x !== 0 && x % 10 == 0)) return false;
  var rev = 0; // reverse
  while(x>rev){
    rev = rev * 10 + x % 10
    x = Math.floor(x / 10)
  }
  return (x == rev || x == Math.floor(rev/10))
}
```

Runtime: 684 ms

## 17. Letter Combinations of a Phone Number

### Question

{% blockquote LeetCode https://leetcode.com/problems/letter-combinations-of-a-phone-number/ 17. Letter Combinations of a Phone Number %}
Given a digit string, return all possible letter combinations that the number could represent.
A mapping of digit to letters (just like on the telephone buttons) is given below.
Input:Digit string "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
Note:
Although the above answer is in lexicographical order, your answer could be in any order you want.
{% endblockquote %}

Tags: Medium, String, Backtracking

### Answers

#### DFS - recursion

``` javascript
/**
 * @param {string} digits
 * @return {string[]}
 */
var letterCombinations = function(digits) {
  if(digits.length<=0){return []}
  var mapper = [0,1,"abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"];
  // mapper that store all number-letters
  var output = []
  helper(digits,[],output,mapper)
  return output
}

var helper = (digits,result,output,mapper) => {
  if(digits.length == 0){
    output.push(result.join(''));
    return
  }
  for(var i = 0;i<mapper[digits[0]].length;i++){
    result.push(mapper[digits[0]][i])
    helper(digits.slice(1),result,output,mapper)
    result.pop()
  }
}
```
Runtime: 152 ms

#### DFS - iterator

Same as before, just use iterator instead of recursion

``` javascript
/**
 * @param {string} digits
 * @return {string[]}
 */
var letterCombinations = function(digits) {
  if(digits.length<=0){return []}
  var mapper = [0,1,"abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"];
  var output = [""]
  for(var i = 0;i<digits.length;i++){
    var x = digits[i]
    var temp = []
    for(var j = 0;j<mapper[x].length;j++){
      for(var t = 0;t<output.length;t++){
        temp.push(output[t]+mapper[x][j])
      }
    }
    output = temp
  }
  return output
}
```
Runtime: 156 ms

That's weird... iterator should be faster than recursion... maybe just so few test cases can not test the real difference between these two ...

#### BFS - iterator

If we consider previous one as a DFS method, then we can use BFS solve it too. Basic idea is the length of each the combination in our final output should be equal to the length of digits. And for every iteration, we use a new digit, and we also need to add every letters this digit represents to every existed combinations we have.

For example: '23'

initial => ['']
'2' => ['a','b','c']
// now add each element of 'def' to each of these three string 
'3' => ['cd','ce','cf','bd','be','bf','ad','ae','af']

``` javascript
/**
 * @param {string} digits
 * @return {string[]}
 */
var letterCombinations = function(digits) {
  if(digits.length<=0){return []}
  var mapper = [0,1,"abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"];
  var output = [""]
  for(var i = 0;i<digits.length;i++){
    var x = digits[i]
    while(output[output.length-1].length == i){
      // the length of every combination in the output should be equal to the the number of digits we used
      var t = output.pop()
      for(var j = 0;j<mapper[x].length;j++){
        output.unshift(t+mapper[x][j])
        // need to use unshift since we need add the new letter to every existed element in the output
      }
    }
  }
  return output
}
```
Runtime: 140 ms

That's it ^_^
