title: OJ LeetCode Substring Questions 1
date: 2016-01-15 20:52:31-05:00
category: OJ
tags: [LeetCode, Substring]
---


## 3. Longest Substring Without Repeating Characters

### Question

{% blockquote LeetCode https://leetcode.com/problems/longest-substring-without-repeating-characters/ 3. Longest Substring Without Repeating Characters %}
Given a string, find the length of the longest substring without repeating characters. For example, the longest substring without repeating letters for "abcabcbb" is "abc", which the length is 3. For "bbbbb" the longest substring is "b", with the length of 1.
{% endblockquote %}

Tags: Medium, String, Two Pointers, Hash Table

### Answers

#### Hash Table

Af first, my idea is use a hashmap as a view window to tract all the letters of current substring, and everytime we found the repeated one, we just move the loop pointer to the last position of this repeated character, and continue looping to the end. But apparently it will cost much more than O(n) for the average case. So then I thought I don't need the move the loop pointer back, just need a new pointer to indicate the start of the substring, and if I do that, I couldn't empty the view window which is the hashmap since I will lose tract of the elements between the `start and i`, so I keep all elements in the hashmap, just make sure every valid repeated character is appeared after the current `start` pointer.

Here is the code:

``` javascript
/**
 * @param {string} s
 * @return {number}
 */
var lengthOfLongestSubstring = function(s) {
  if(s.length <=0){return 0}
  var view = {}, // store the current substring
      max = 0, // store the max length
      start = 0 // store the start of the current substring
  for(var i = 0;i<s.length;i++){
    if(view[s[i]] && view[s[i]] > start){
      max = Math.max(max,i-start)
      // now we have a repeated element appeared in current substring
      start = view[s[i]]
    }
    view[s[i]] = i+1
  }
  // in case no repeated element in this string
  max = Math.max(max,i-start)
  return max
};
```

Runtime: 376 ms

#### DP

This method is borrow from the discussion [shortest O(n) DP solution with explanations](https://leetcode.com/discuss/13336/shortest-o-n-dp-solution-with-explanations). More concise!

``` javascript
/**
 * Solution (DP, O(n)):
 * 
 * Assume L[i] = s[m...i], denotes the longest substring without repeating
 * characters that ends up at s[i], and we keep a hashmap for every
 * characters between m ... i, while storing <character, index> in the
 * hashmap.
 * We know that each character will appear only once.
 * Then to find s[i+1]:
 * 1) if s[i+1] does not appear in hashmap
 *    we can just add s[i+1] to hash map. and L[i+1] = s[m...i+1]
 * 2) if s[i+1] exists in hashmap, and the hashmap value (the index) is k
 *    let m = max(m, k), then L[i+1] = s[m...i+1], we also need to update
 *    entry in hashmap to mark the latest occurency of s[i+1].
 * 
 * Since we scan the string for only once, and the 'm' will also move from
 * beginning to end for at most once. Overall complexity is O(n).
 *
 * If characters are all in ASCII, we could use array to mimic hashmap.
 */

/**
 * @param {string} s
 * @return {number}
 */
var lengthOfLongestSubstring = function(s) {
  var charIndex = {}
  var longest = 0, m = 0;

  for (var i = 0; i < s.length; i++) {
    m = Math.max((typeof charIndex[s[i]] === "undefined" ? -1:charIndex[s[i]]) + 1, m);    // automatically takes care of -1 case
    charIndex[s[i]] = i;
    longest = Math.max(longest, i - m + 1);
  }

  return longest;
}
```
Runtime: 376


## 5. Longest Palindromic Substring

### Question

{% blockquote LeetCode https://leetcode.com/problems/longest-palindromic-substring/ 5. Longest Palindromic Substring %}
Given a string S, find the longest palindromic substring in S. You may assume that the maximum length of S is 1000, and there exists one unique longest palindromic substring.
{% endblockquote %}

Tags: Medium, String

### Answers

#### two pointers

We need to take advantage of the features of the palindrom: xxx|xxx which is start from the separator, it is symetric.

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var longestPalindrome = function(s) {
  if(s.length < 2) return s
  var start = 0,end = 1;
  for(var i = 0;i<s.length;){
    if(s.length - i <= (end-start+1)/2) break; // if the number of elements left is less than half of length of current longest palindrome, then we can break safely
    var left = i, right = i; // left is from separator to left; vice versa for right
    // skil the duplicate number, set all duplicate numbers as the separator of the palindrom since duplicate numbers definitely are palindrom 
    while(right < s.length - 1 && s[right] == s[right+1]) right ++ ;
    // update the i to the right next to right, no need to loop the duplicate number
    i = right + 1
    // now expand the left and right, try to enlarge the palindrom
    while(right < s.length - 1 && left >0 && s[left-1] == s[right+1]){
      // be careful about the condition in there: use < and > because maybe have 'bbb', so the s[left-1] and s[right+1] both are undefined, and they are equal...
      left --
      right ++
    }
    // update the longest if it is
    if((right - left +1) > (end - start)){
      start = left
      end = right + 1
    }
  }
  return s.slice(start,end)
};
```
Runtime: 164 ms

#### Brute Force Check

Basic idea is loop over entire string, and everytime we loop to a new character, we check whether it would produce new palindrome of (current length + 1) or (current length + 2). From [this post](https://leetcode.com/discuss/52814/ac-relatively-short-and-very-clear-java-solution)

``` javascript
/**
 * @param {string} s
 * @return {string}
 */
var longestPalindrome = function(s) {
  if(s.length < 2) return s;
  var subs = '', currentLength = 1;
  for(var i = 1;i<s.length;i++){
    if(isPalindrome(s,i-currentLength-1,i)){
      // 
      subs = s.slice(i-currentLength-1,i+1)
      currentLength += 2
    }else if(isPalindrome(s,i-currentLength,i)){
      subs = s.slice(i-currentLength,i+1)
      currentLength += 1
    }
  }
  return subs
}

var isPalindrome(s,begin,end) => {
  if(begin<0) return false;
  while(begin < end){
    if(s[begin++] !== s[end--]) return false;
  }
  return true
}
```

Runtime: 188 ms

And the detail explanations:

> Example: "xxxbcbxxxxxa", (x is random character, not all x are equal) now we are dealing with the last character 'a'. The current longest palindrome is "bcb" with length 3.
> 1. check "xxxxa" so if it is palindrome we could get a new palindrome of length 5.
> 2. check "xxxa" so if it is palindrome we could get a new palindrome of length 4.
> 3. do NOT check "xxa" or any shorter string since the length of the new string is no bigger than current longest length.
> 4. do NOT check "xxxxxa" or any longer string because if "xxxxxa" is palindrome then "xxxx" got  from cutting off the head and tail is also palindrom. It has length > 3 which is impossible.'

Really smart!!!

