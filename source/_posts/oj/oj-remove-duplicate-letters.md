title: OJ Remove Duplicate Letters
date: 2016-01-26 13:26:53-05:00
category: OJ
tags: [LeetCode, Greedy]
---

## 316. Remove Duplicate Letters

### Question

{% blockquote LeetCode https://leetcode.com/problems/remove-duplicate-letters/ 316. Remove Duplicate Letters My Submissions Question %}
Given a string which contains only lowercase letters, remove duplicate letters so that every letter appear once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

Example:
Given "bcabc"
Return "abc"

Given "cbacdcbc"
Return "acdb"
{% endblockquote %}

Tags: Medium, Stack, Greedy

### Answers

#### Greedy

> Greedy algorithm is an algorithm that follows the problem solving heuristic of making the locally optimal choice at each stage with the hope of finding a global optimum. In many problems, a greedy strategy does not in general produce an optimal solution, but nonetheless a greedy heuristic may yield locally optimal solutions that approximate a global optimal solution in a reasonable time.

Classic problem is the coin changes problem: determine minimum number of coins to give while making change.

This problem can also be solved with greedy algorithm, we just need to determine the local optimal choice first: 

- We need find the current `smallest` letter in the string and put it into our result, `smallest` means that smallest one that could be put into the result;

Now question is how we determine the `smallest` letter:

- Condition 1: the letter is smaller than every letter appeared before it and it only appear once, then it would be our `smallest`, like "cbacb", the "a" will be our current `smallest`;
- Condition 2: the letter only appeared once and the `smallest` letter should be the first smallest letter before this letter, like "cbdcb", so the "b" will be our current `smallest`;

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var removeDuplicateLetters = function(s) {
  var i,j,res = "";
  while (s !== "") {
    var countMap = {};
    // build the countMap for current string
    for (i = 0; i < s.length; i++) {
      countMap[s[i]] = countMap[s[i]] || 0;
      countMap[s[i]] ++;
    }
    var smallestPos = 0;
    for (i = 0; i < s.length; i++) {
      if (s[smallestPos] > s[i]) {
        // update the smallest number
        smallestPos = i
      }
      // until find the letter only appeared once, and we will get the index of our smallest letter
      if (countMap[s[i]] == 1) break;
      countMap[s[i]] --;
    }
    // put the letter into our result string
    res += s[smallestPos];
    s = s.slice(smallestPos+1).replace(new RegExp(s[smallestPos],"g"),"")
  }
  return res
};
```
Runtime: 244 ms

If we build the countMap with 0 default before we do the count part, it can speed up a little.

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var removeDuplicateLetters = function(s) {
  var i,j,res = "";
  while (s !== "") {
    var countMap = {};
    // build the countMap for current string
    for (i = 0; i < 26; i++) { 
      countMap[String.fromCharCode(i + 97)] = 0
    }
    for (i = 0; i < s.length; i++) {
      countMap[s[i]] ++;
    }
    var smallestPos = 0;
    for (i = 0; i < s.length; i++) {
      if (s[smallestPos] > s[i]) {
        // update the smallest number
        smallestPos = i
      }
      // until find the letter only appeared once, and we will get the index of our smallest letter
      if (countMap[s[i]] == 1) break;
      countMap[s[i]] --;
    }
    // put the letter into our result string
    res += s[smallestPos];
    s = s.slice(smallestPos+1).replace(new RegExp(s[smallestPos],"g"),"")
  }
  return res
};
```

Runtime: 196 ms

And of course you can use recursion instead of iterator to do it, but it should be slower than iteration way.

#### Stack

This is a solution I found from the discussion: [C++ solution using stack](https://leetcode.com/discuss/73824/short-16ms-solution-using-stack-which-can-optimized-down-4ms)

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var removeDuplicateLetters = function(s) {
  var cnts = {}, stack = [], isVisited = {};
  var i,j;
  // build count mapper 
  for (i = 0; i < 26; i++) { 
    cnts[String.fromCharCode(i + 97)] = 0
  }
  for (i = 0; i < s.length; i++) {
    cnts[s[i]] ++
  }

  for (i = 0; i < s.length; i++) {
    cnts[s[i]] --;
    if (isVisited[s[i]]) continue;

    while (s[i] < stack[0] && cnts[stack[0]]) {
      // if the letter is smaller than previous smaller letter(stack[0]) and we still have some stack[0] after this letter,
      // Then we remove it from the stack
      isVisited[stack[0]] = false;
      stack.shift();
    }
    // put the smaller one we find into the stack
    stack.unshift(s[i]);
    isVisited[s[i]] = true;
  }
  return stack.reverse().join("")
}
```

Runtime: 192 ms

This is so comlicated to figure out... I don't think I can come up with this solution during any interview... maybe I can after I finish the Algoithm Class of this semester.

#### Another Way

[Easy to understand iterative Java solution](https://leetcode.com/discuss/73777/easy-to-understand-iterative-java-solution) has a really nice and easy to understand solution for this problem.

> find out the last appeared position for each letter; c - 7 b - 6 a - 2 d - 4
> find out the smallest index from the map in step 1 (a - 2);
> the first letter in the final result must be the smallest letter from index 0 to index 2;
> repeat step 2 to 3 to find out remaining letters.

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var removeDuplicateLetters = function(s) {
  var countMap = {}, res = [];
  var i,j;
  // build count mapper with letter-last index
  for (i = 0; i < s.length; i++) {
    countMap[s[i]] = i
  }

  // loop and try to find the smallest letter between each interval of last index, start from 0
  var len = Object.keys(countMap).length,
      begin = 0,
      end = findMinLastIdx(countMap);
  for (i = 0; i < len; i++) {
    var minChar = "z";
    for (j = begin; j <= end; j++) {
      if (countMap[s[j]] > -1 && s[j] < minChar) {
        minChar = s[j];
        begin = j + 1;
      }
    }
    res[i] = minChar;
    countMap[minChar] = -1
    end = findMinLastIdx(countMap);
  }
  return res.join("")
}
var findMinLastIdx = (countMap) => {
  var min = Math.pow(2,31)-1;
  for(var item in countMap){
    if(countMap[item]!=-1){
      min = Math.min(countMap[item],min)
    }
  }
  return min
}
```
Runtime: 192 ms
