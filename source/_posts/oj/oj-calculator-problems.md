title: OJ Calculator Problems
date: 2016-01-30 15:18:18-05:00
category: OJ
tags: [LeetCode, Stack]
---

## 224	Basic Calculator

### Question

{% blockquote LeetCode https://leetcode.com/problems/basic-calculator/ 224	Basic Calculator %}
Implement a basic calculator to evaluate a simple expression string.

The expression string may contain open ( and closing parentheses ), the plus + or minus sign -, non-negative integers and empty spaces .

You may assume that the given expression is always valid.

Some examples:
"1 + 1" = 2
" 2-1 + 2 " = 3
"(1+(4+5+2)-3)+(6+8)" = 23

Note: Do not use the eval built-in library function.
{% endblockquote %}

Tags: Stack, Math, Medium

### Answers

#### Two Stack

First, we can use two stack, one stores numbers, the other stores the operators, and once we got the ")", we start to pop elements and operators to calculate.

``` javascript
/**
 * @param {string} s
 * @return {number}
 */
var calculate = function(s) {
  var nums = [], ops = [], number = 0, i;
  //s = s.replace(/ /g,""); // skip all spaces with replace first
  for(i = 0; i < s.length; i++){
    if(s[i] == " ") continue; // skip all spaces
    var c = s[i];
    if (c == '(' || c == '+' || c == '-') {
      // push all operators into ops and go to next position
      ops.push(c); 
      continue;
    }

    if (c == ')') {
      // remove the remaining "("
      ops.pop();
    }else if(s[i] != " "  && Number.isInteger(Number(c))){
      // for digits, combine them to get our operands
      // Number(" ") will be converted to 0 and return true for isInteger()
      number = number*10 + Number(c);
      if (i + 1 < s.length && s[i+1] != " " && Number.isInteger(Number(s[i+1]))) continue;
      // make sure we got all digits for one operand, and no out of bound
      nums.push(number);  // push the operand to our nums
      number = 0;
    }
    
    if (ops.length == 0 || ops[ops.length-1] == "(") continue;  // skip if no operators or we have finish all in this pair of parentheses

  
    // get our operator and operands
    var op2 = nums.pop(),
        op = ops.pop();
    
    // do the calculate with second operand
    if (op == "+") {
      nums[nums.length-1] += op2;
    }else if (op == "-") {
      nums[nums.length-1] -= op2;
    }
  }
  return nums.pop()  // now our nums should only have our result
}
```
Runtime: 168 ms - 180 ms


#### One Stack

Previous solution we use a second stack store the operators, but actually we don't need to do that. If we separate the whole expression into several small parts, then everytime we find a parentheses, we just store the previous result after calculation to the stack, and solve the inner part first.

And in order to do this way, we need initialize the result to 0.

``` javascript
/**
 * @param {string} s
 * @return {number}
 */
var calculate = function(s) {
  var stack = [],i,sign = 1,result = 0, number = 0;
  for (i = 0; i < s.length; i++) {
    var c = s[i];
    if (c != " " && Number.isInteger(Number(c))) {
      number = 10*number + Number(c)
    } else if (c == "+") {
      result += sign * number;
      sign = 1;  // keep the positive sign
      number = 0;  // clear the number after calculation
    } else if (c == "-") {
      result += sign * number;
      number = 0;
      sign = -1;  // make sure now we have a negative operator, this will affect the last result of next number
    } else if (c == "(") {
      // result += sign*number;  // make sure our result including the last number, actually a open parenthese would always follow another operator like + or -, and we already clear the number
      // now we need store the result to stack
      stack.push(result);
      stack.push(sign);  // store the sign, used for next operand (previous result +/- wait for next result)
      result = 0;  // clear the result and solve the inner part
      sign = 1;  // reinitialize the sign
    } else if (c == ")") {
      // now we finish the inner part
      result += sign*number;  // the end parenthese always follow a number
      result *= stack.pop();  // determine it is - or + this result
      result += stack.pop();  // now add the previous result
      number = 0;  // clear the number
    }
  }
  if (number != 0) {
    result += sign * number;  // in case we only have a number without any operators
  }
  return result;
}
```

Runtime: 176 ms


## 227. Basic Calculator II

### Question

{% blockquote LeetCode https://leetcode.com/problems/basic-calculator-ii/ 227. Basic Calculator II %}
Implement a basic calculator to evaluate a simple expression string.

The expression string contains only non-negative integers, +, -, *, / operators and empty spaces . The integer division should truncate toward zero.

You may assume that the given expression is always valid.

Some examples:
"3+2*2" = 7
" 3/2 " = 1
" 3+5 / 2 " = 5

Note: Do not use the eval built-in library function.

{% endblockquote %}

Tags: String, Medium

### Answers

#### Direct Updating Stack

Since we don't have parentheses which make this question much easier, we can just keep calculating all the * and /, then store all results into the stack, and also store the - with second operator as a negative number, then we just need to sum all the stack to get our final answer.

In order to deal with the first number, we could prepend the expression with a "0+", so we initialize the first number as 0 and first operator as "+".

``` javascript
/**
 * @param {string} s
 * @return {number}
 */
 var calculate = function(s) {
   var stack = [], num = 0, c = "+", i;
   for (i = 0; i < s.length+1; i++) {
     if (s[i] == " ") continue;  // skip all spaces
     if (Number.isInteger(Number(s[i]))) {
       num = 10 * num + Number(s[i]);
       continue;
     }else if (c == "+") {
       stack.push(num);
     }else if (c == "-") {
       stack.push(-num);
     }else if (c == "*") {
       stack.push(stack.pop()*num);  // do the calculation!
     }else if (c == "/") {
       // be careful about the negative number, since we only need the integer part
       var temp = stack.pop();
       if (temp < 0) {
         temp = Math.ceil(temp/num);
       }else{
         temp = Math.floor(temp/num);
       }
       stack.push(temp);
     }
     num = 0;
     c = s[i];  // always store the precious closest operator before current number
   }
   stack.push(num);
   return stack.reduce( (sum,v) => sum += v )
}
```
Runtime: 236 ms

Previous code would have an "out of bound" issue, but js just doesn't have this kind of error...

You can remove the continue after getting the number, and change the condition for second part with:

``` javascript
if (!Number.isInteger(Number(s[i])) || i == s.length - 1) {
  ...
  num = 0;
  c = s[i];
}
```

Runtime: 200 ms

#### No Stack

Same idea, but we don't need the stack, we just keep the previous result and always add the current result to the previous result whenever we can.
``` javascript
/**
 * @param {string} s
 * @return {number}
 */

var calculate = function(s) {
  var result = 0, cur_res = 0, op = '+', pos;
  s = s.replace(/ /g,'');
  for(pos = 0; pos < s.length;) {
    if (Number.isInteger(Number(s[pos]))) {
      var tmp = Number(s[pos]);
      while(pos++ < s.length && Number.isInteger(Number(s[pos]))) {
        tmp = tmp*10 + Number(s[pos]);
      }
      switch (op) {
        case '+' : cur_res += tmp; break;
        case '-' : cur_res -= tmp; break;
        case '*' : cur_res *= tmp; break;
        case '/' : cur_res = cur_res <= 0 ? Math.ceil(cur_res / tmp) : Math.floor(cur_res / tmp); break;
      }
    }else {
      if(s[pos] == '+' || s[pos] == '-') {
        result += cur_res;
        cur_res = 0;
      }
      op = s[pos++];
    }
  }
  return result + cur_res;
}
```

Runtime: 196 ms


## Calculator

### Question

So if we combine the two problems together, we can make a simple calculator that can do basic calculation.

### Answer

The basic idea is convert the infix notation to Polish notation or Reverse Polish notation and store them into a stack, then we can just use stack to calculate the result.

[Here is the origin solution from leetcode](https://leetcode.com/discuss/42423/28ms-code-with-stacks-for-oprand-extension-cover-also-given)

[Here is the reverse polish notation on wikipedia](https://en.wikipedia.org/wiki/Reverse_Polish_notation)

``` javascript
/**
 * @param {string} s
 * @return {number}
 */

var calculate = function(s) {
  s = "(" + s.replace(/ /g,'') + ")";
  var nums = [], ops = [], i, curNum = 0;
  for (i = 0; i < s.length; i++) {
    var c = s[i];
    if (Number.isInteger(Number(c))) {
      curNum = 10*curNum + Number(c);
    } else if (c == "(") {
      ops.push("(");
      ops.push("+");
    } else {
      var topOp = ops[ops.length-1];
      switch (topOp) {
        case "*":
        case "/":
          curNum = topOp == "/" ? Math.floor(nums.pop()/curNum) : nums.pop() * curNum;
          ops.pop();
      }
      switch (c) {
        case ")":
          if (ops[ops.length-1] == "-") {
            curNum = -curNum;
          }
          ops.pop();
          while (ops[ops.length-1] != "(") {
            curNum += ops.pop() == "-" ? -nums.pop() : nums.pop();
          }
          ops.pop();  // skip "("
          break
        default:
          ops.push(c);
          nums.push(curNum);
          curNum = 0;
      }
    }
  }
  return curNum
} 
```
Runtime: 184 ms for Basic Calculator I
Runtime: 196 ms for Basic Calculator II
