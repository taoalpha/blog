title: OJ Gas station
date: 2016-02-13 18:36:08-05:00
category: OJ
tags: [LeetCode, Gas Station]
---

## 134. Gas Station

### Problem

{% blockquote LeetCode https://leetcode.com/problems/gas-station/ 134. Gas Station %}
There are N gas stations along a circular route, where the amount of gas at station i is gas[i].

You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from station i to its next station (i+1). You begin the journey with an empty tank at one of the gas stations.

Return the starting gas station's index if you can travel around the circuit once, otherwise return -1.
{% endblockquote %}

Tags: Medium, Greedy

### Answers


#### Brute force

The easiest way to solve this problem will be enumerate all possible start points and check whether you can pass or not.

Time complexity would be O(n^2).

``` javascript
/**
 * @param {number[]} gas
 * @param {number[]} cost
 * @return {number}
 */
var canCompleteCircuit = function(gas, cost) {
    for (i = 0; i < gas.length; i++) {
        if(helper(gas,cost)){
           return i 
        }
        gas.push(gas.shift())
        cost.push(cost.shift())
    }
    return -1
};

var helper = function(gas, cost) {
    var i,j,preGas = 0, preCost = 0;
    for (i = 0; i < gas.length; i++) {
        if (gas[i] + preGas < cost[i] + preCost) {
            return false
        }
        preGas += gas[i];
        preCost += cost[i];
    }
    return true
}
```
Runtime: TLE.

#### Pruning

Consider about this fact: if you start from A and you could not reach C, then if you start from any gas station between A and C, could you make it to C ?

No, you can not. Why ? I observe it. But here is [a proof provided by some solutions from discussion](https://leetcode.com/discuss/4159/share-some-of-my-ideas).

> Say there is a point C between A and B -- that is A can reach C but cannot reach B. Since A cannot reach B, the gas collected between A and B is short of the cost. Starting from A, at the time when the car reaches C, it brings in gas >= 0, and the car still cannot reach B. Thus if the car just starts from C, it definitely cannot reach B.

Based on this affect, we can do some pruning for previous solution:

``` javascript
/**
 * @param {number[]} gas
 * @param {number[]} cost
 * @return {number}
 */
var canCompleteCircuit = function(gas, cost) {
  var sumGas = 0, sumCost = 0;
  for (var i = 0; i < gas.length; i++) {
    sumGas += gas[i];
    sumCost += cost[i];
  }
  // deal with no solution condition first
  if(sumGas -1-1< sumCost) {return -1}

  // now we know there definitely is a solution here.
  for (var i = 0; i < gas.length; i++) {
    var temp = helper(gas.slice(i),cost.slice(i));
    if(temp == "DONE"){
      // Now we have the start point that can go through all the rest gas stations
      return i+temp+1
    }
    // Now we now any gas stations before temp can not make it
    i = temp+i
  }
};

var helper = function(gas, cost) {
  var i,j,preGas = 0, preCost = 0;
  for (i = 0; i < gas.length; i++) {
    if (gas[i] + preGas < cost[i] + preCost) {
      // definitely can not make it from i
      return i
    }
    preGas += gas[i];
    preCost += cost[i];
  }
  return "DONE";
}
```
Runtime: 100 ms

#### Even better

Simplify the previous pruning solution with one pass. Solution from discussion.

``` javascript
var canCompleteCircuit = function(gas, cost) {
  var i, tank = 0, start = 0, total = 0;
  //if car fails at 'start', record the next station
  for(i=0;i<gas.length;i++) {
    tank += gas[i] - cost[i];  // gas left in your tank
    if(tank<0) {
      // you know you can not make it starting before i
      start = i + 1;
      total += tank;  // total gas you own along the way
      tank = 0;  // reset the tank
    }
  }
  // if the tank has fewer gas than you own, you can not make it, or you can start from current start position
  return (total + tank < 0) ? -1 : start;
}
```

Runtime: 84-90 ms

#### Two Pointers

Still could not figure out why this solution works... 

``` javascript
var canCompleteCircuit = function(gas, cost) {
  var start = gas.length - 1,
      end = 0,
      sum = gas[start] - cost[start];
  while (start > end) {
    if (sum >= 0) {
      sum += gas[end] - cost[end];
      end ++;
    } else {
      start --;
      sum += gas[start] - cost[start];
    }
  }
  return sum >= 0 ? start : -1;
}
```
Runtime: 100 ms


## Gas station series

There is some mutation problems on this gas station problem. So I just list here to broaden your eyes: 

{% blockquote DP http://sydney.edu.au/engineering/it/~mestre/slides/esa-2007.pdf Gas Station Series %}
Suppose you want to go on a road trip across the US. You start from New York City and would like to drive to San Francisco. 

Now you have a roadmap with all gas station locations and their gas prices.

You want to minimize the travel cost(gas expenses).
{% endblockquote %}

Want to see the solution ? [Check the link to see the PDF](http://sydney.edu.au/engineering/it/~mestre/slides/esa-2007.pdf).
