title: OJ Parentheses Problems 1
date: 2016-01-31 11:43:37-05:00
category: OJ
tags: [LeetCode, Parentheses]
---

## 20. Valid Parentheses

### Question

{% blockquote LeetCode https://leetcode.com/problems/valid-parentheses/ 20. Valid Parentheses %}
Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
{% endblockquote %}

Tags: Stack, String, Easy

### Answers

#### Stack or Queue

``` javascript
/**
 * @param {string} s
 * @return {boolean}
 */

var isValid = function(s) {
  var list = [];
  while (s.length != 0) {
    if (list.length != 0 && ( s[0] == ")" && list[0] == "(" || s[0] == "]" && list[0] == "[" || s[0] == "}" && list[0] == "{")) {
      // The order or () {} [] is important, since the left one must show before the right one
      // remove if we have a match pair
      list.shift();
    }else{
      // add all unmatch one to the list
      list.unshift(s[0]);
    }
    s = s.slice(1);
  }

  if (list.length != 0){
    return false;
  }
  return true;
}
```
Runtime: 156 ms

The solution above uses the Queue structure, but you definitely can use stack, I tried, the time cost are pretty much same.

#### HashTable

Same as before. just use a hashmap to save some lines of code.

``` javascript
/**
 * @param {string} s
 * @return {boolean}
 */
var isValid = function(s) {
  var map = {
    ")":"(",
    "}":"{",
    "]":"["
  };
  var stack = [];
  for (var i = 0; i < s.length; i++) {
    if (s[i] == "(" || s[i] == "[" || s[i] == "{") {
      stack.push(s[i]);
    } else {
      if (map[s[i]] != stack.pop()) {
        // not a match
        return false
      }
    }
  }
  return stack.length == 0
}
```

Runtime: 160 ms

## 22. Generate Parentheses

### Question

{% blockquote LeetCode https://leetcode.com/problems/generate-parentheses/ 22. Generate Parentheses %}
Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given n = 3, a solution set is:

"((()))", "(()())", "(())()", "()(())", "()()()"
{% endblockquote %}

Tags: Backtracking, String, Medium

### Answer

Classical backtracking questions. The most important part is to determine the exit condition.

``` javascript
/**
 * @param {number} n
 * @return {string[]}
 */
var generateParenthesis = function(n) {
  var output = [];
  dfs(n,n,"",output);
  return output
};
var dfs = function(left, right, res, output) {
  if (left > right || left < 0 || right < 0) {
    // exit when out of bound
    // exit when right appears before left
    return
  }
  if (left == 0 && right == 0){
    // correct result
    output.push(res)
    return
  }
  dfs(left-1,right,res+"(",output)
  dfs(left,right-1,res+")",output)
}
```
Runtime: 140 ms

## 241. Different Ways to Add Parentheses

### Question

{% blockquote LeetCode https://leetcode.com/problems/different-ways-to-add-parentheses/ 241. Different Ways to Add Parentheses %}
Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are +, - and *.

Example 1
Input: "2-1-1".

((2-1)-1) = 0
(2-(1-1)) = 2
Output: [0, 2]


Example 2
Input: "2*3-4*5"

(2*(3-(4*5))) = -34
((2*3)-(4*5)) = -14
((2*(3-4))*5) = -10
(2*((3-4)*5)) = -10
(((2*3)-4)*5) = 10
Output: [-34, -14, -10, -10, 10]

{% endblockquote %}

Tags: Divide and Conquer, Medium

### Answer

[Here is the origin answer post](https://leetcode.com/discuss/48488/c-4ms-recursive-%26-dp-solution-with-brief-explanation)

``` javascript
/**
 * @param {string} input
 * @return {number[]}
 */
var diffWaysToCompute = function(input) {
  var result = [], i;
  for (i = 0; i < input.length; i++){
    var c = input[i];
    if (c == "+" || c == "-" || c == "*") {
      var result1 = diffWaysToCompute(input.slice(0,i));
      var result2 = diffWaysToCompute(input.slice(i+1));
      for (var j = 0; j < result1.length; j++) {
        for (var t = 0; t < result2.length; t++) {
          if (c == "+") {
            result.push(result1[j] + result2[t]);
          } else if (c == "-") {
            result.push(result1[j] - result2[t]);
          } else {
            result.push(result1[j] * result2[t]);
          }
        }
      }
    }
  }

  if (result.length == 0) {
    result.push(Number(input));
  }
  return result
};
```
Runtime : 168 ms


There is another solution in the same post with DP or hashtable more accuracy. Since we calculate the substring all the time, so we can just store them in a hashmap and check whether we have calculated it or not before we do the calculation. 

``` javascript
/**
 * @param {string} input
 * @return {number[]}
 */
var diffWaysToCompute = function(input) {
  var map = {};
  return computeWithDP(input,map);
}

var computeWithDP = function(input,dpMap) {
  var result = [], i;
  for (i = 0; i < input.length; i++){
    var c = input[i];
    if (c == "+" || c == "-" || c == "*") {
      var result1, result2, substr = input.slice(0,i);
      if (dpMap[substr]) {
        result1 = dpMap[substr];
      } else {
        result1 = computeWithDP(substr, dpMap);
      }

      substr = input.slice(i + 1);

      if (dpMap[substr]) {
        result2 = dpMap[substr];
      } else {
        result2 = computeWithDP(substr, dpMap);
      }

      for (var j = 0; j < result1.length; j++){
        for (var t = 0; t < result2.length; t++){
          if (c == "+") {
            result.push(result1[j] + result2[t]);
          } else if (c == "-") {
            result.push(result1[j] - result2[t]);
          } else {
            result.push(result1[j] * result2[t]);
          }
        }
      }
    }
  }

  if (result.length == 0) {
    result.push(Number(input));
  }
  dpMap[input] = result;
  return result
}
```
Runtime: 160 ms


There are still two hardquestions about the parentheses... but I don't think I can solve it by myself... even I see the answer... I don't think I can come up with it after today...

So I will just leave them to .... future... :)
