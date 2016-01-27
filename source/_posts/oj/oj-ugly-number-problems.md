title: OJ Ugly Number Problems
date: 2016-01-24 21:09:04-05:00
category: OJ
tags: [LeetCode, Numbers]
---

## 263. Ugly Number

### Question

{% blockquote LeetCode https://leetcode.com/problems/ugly-number/ 263. Ugly Number %}
Write a program to check whether a given number is an ugly number.

Ugly numbers are positive numbers whose prime factors only include 2, 3, 5. For example, 6, 8 are ugly while 14 is not ugly since it includes another prime factor 7.

Note that 1 is typically treated as an ugly number.
{% endblockquote %}

Tags: Math, Easy

### Answers

I think there is only one way to solve this problem efficiently, which is based on the math fact of this problem.

Based on the definition, if we keep dividing the number by 2, 3 or 5, and finally we get 1, then it should be a ugly number, otherwise it would be something else.

``` javascript
/**
 * @param {number} num
 * @return {boolean}
 */
var isUgly = function(num) {
  // num is not prime and divide by 2, 3, 5 
  if(num<1){return false}
  if(num === 1){return true}
  num = num % 5 === 0 ? num / 5 : (num % 3 === 0) ? (num / 3) : (num % 2 === 0) ? (num / 2) : "true";
  if(num === "true"){
    return false;
  }
  return isUgly(num)
};

```
Runtime: 208 ms

We can simplify above code with an for and while loop.

``` javascript
/**
 * @param {number} num
 * @return {boolean}
 */
var isUgly = function(num) {
  for (var p of [2, 3, 5]){
    while (num && num % p == 0) {
      num /= p;
    }
  }
  return num == 1;
};
```
Runtime: 224 ms

## 264. Ugly Number II

### Question

{% blockquote LeetCode https://leetcode.com/problems/ugly-number-ii/ 264. Ugly Number II %}
Write a program to find the n-th ugly number.

Ugly numbers are positive numbers whose prime factors only include 2, 3, 5. For example, 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 is the sequence of the first 10 ugly numbers.

Note that 1 is typically treated as an ugly number.
{% endblockquote %}

Tags: Dynamic Programming, Heap, Math, Medium

### Answers

#### Using isUgly

``` javascript
/**
 * @param {number} n
 * @return {number}
 */
var nthUglyNumber = function(n) {
    console.log(n)
    if(n <= 0) return false; // get rid of corner cases 
    if(n == 1) return 1; // base case
    var count=1,i=0,num = 1;
    for(i = 1;count <= n;i++){
        if(isUgly(i)){
            count ++;
            num = i;
        }
    }
    return num
};
var isUgly = function(num) {
  // num is not prime and divide by 2, 3, 5 
  if(num<1){return false}
  if(num === 1){return true}
  num = num % 5 === 0 ? num / 5 : (num % 3 === 0) ? (num / 3) : (num % 2 === 0) ? (num / 2) : "true";
  if(num === "true"){
    return false;
  }
  return isUgly(num)
};
```

Sadly, it will be TLE since it is so slow....

#### DP

This is a classic DP problem if you treat every n-th is a status, and we can find:

- f(0) = 1
- f(1) = min(f(0)*2,f(0)*3,f(0)*5)
- f(2) = min(f(1)*2,f(0)*3,f(0)*5)
...

Just be careful about the number like 6, since it can be got from 2*3 or 3*2, so we need update both pointers stand for 2 and 3.

``` javascript
/**
 * @param {number} n
 * @return {number}
 */
var nthUglyNumber = function(n) {
  if(n <= 0) return false; // get rid of corner cases 
  if(n == 1) return 1; // base case
  var p2 = 0, p3 = 0, p5 = 0; //pointers for 2, 3, 5
  var f = [];
  f[0] = 1;
  for(var i  = 1; i < n ; i ++){
    f[i] = Math.min(f[p2]*2,f[p3]*3,f[p5]*5);
    if(f[i] == f[p2]*2) p2++; 
    if(f[i] == f[p3]*3) p3++;
    if(f[i] == f[p5]*5) p5++;
  }
  return f[n-1];
};
```
Runtime: 212 ms

## 313. Super Ugly Number

### Question

{% blockquote LeetCode https://leetcode.com/problems/super-ugly-number/ 313. Super Ugly Number %}
Write a program to find the nth super ugly number.

Super ugly numbers are positive numbers whose all prime factors are in the given prime list primes of size k. For example, [1, 2, 4, 7, 8, 13, 14, 16, 19, 26, 28, 32] is the sequence of the first 12 super ugly numbers given primes = [2, 7, 13, 19] of size 4.

Note:
(1) 1 is a super ugly number for any given primes.
(2) The given numbers in primes are in ascending order.
(3) 0 < k ≤ 100, 0 < n ≤ 106, 0 < primes[i] < 1000.
{% endblockquote %}

Tags: Math, Heap, Medium

### Answers

#### DP

We can use same code as before, just replace the hardcode 2,3,5 with a prime list.

``` javascript
/**
 * @param {number} n
 * @param {number[]} primes
 * @return {number}
 */
var nthSuperUglyNumber = function(n, primes) {
  if(n <= 0) return false; // get rid of corner cases 
  if(n == 1) return 1; // base case
  var p = [];
  for(var i = 0;i<primes.length;i++){
    p[i] = {
      prime : primes[i],
      count:0
    };
  }
  var f = [];
  f[0] = 1;
  for(var i  = 1; i < n ; i ++){
    f[i] = Math.min.apply(null,p.map( (a) => { return f[a.count]*a.prime } ) );
    for(j = 0;j<p.length;j++){
      if(f[p[j].count]*p[j].prime == f[i]) p[j].count ++; 
    }
  }
  return f[n-1];
};
```

Runtime: 404 ms

#### Heap

As usally, though I got accepted for the dp solution, but it is so slow... So I open the discussion and look through some best votes answers, find [this nice solution](https://leetcode.com/discuss/81411/java-three-methods-23ms-58ms-with-heap-performance-explained):

``` javascript
/**
 * @param {number} n
 * @param {number[]} primes
 * @return {number}
 */
var nthSuperUglyNumber = function(n, primes) {
  var res = [1],
      idxs = [],
      i,j;
  for (i = 1; i < n; i++) {
    res[i] = Math.pow(2,31) - 1;

    for (j = 0; j < primes.length; j++){
      idxs[j] = idxs[j] || 0;
      res[i] = Math.min(res[i],primes[j] * res[idxs[j]]);
    }
    for (j = 0; j < idxs.length; j++){
      if (res[i] == primes[j] * res[idxs[j]]) {
        idxs[j] = idxs[j] || 0;
        idxs[j] ++;
      }
    }
  }
  return res[n-1]
}
```
Runtime: 276 ms

Actually it is pretty much the same as the DP solution... but much faster. 

We actually can combine the two for loops into one to speed up again:

```
var nthSuperUglyNumber = function(n, primes) {
  var res = [],
      idxs = [],
      vals = new Array(primes.length+1).join(1).split('').map(parseFloat),
      i,j,next = 1;
  
  for (i = 0; i < n; i++) {
    res[i] = next;
    next = Math.pow(2,31) - 1;

    for (j = 0; j < primes.length; j++){
      // skip duplicate and avoid extra multiplication
      if (vals[j] == res[i]) {
        idxs[j] = idxs[j] || 0;
        vals[j] = res[idxs[j]++] * primes[j];
      }
      next = Math.min(next,vals[j]);
    }
  }
  return res[n-1]
}
```

Runtime: 232 ms
