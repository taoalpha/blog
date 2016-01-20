title: OJ Word Search Problems
date: 2016-01-19 21:17:56-05:00
category: OJ
tags: [LeetCode, Word Search, DFS]
---

## 79. Word Search

### Problem

{% blockquote LeetCode https://leetcode.com/problems/word-search/ 79. Word Search %}
Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

For example,
Given board =

[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]

word = "ABCCED", -> returns true,
word = "SEE", -> returns true,
word = "ABCB", -> returns false.

{% endblockquote %}

Tags: Array, Backtracking, Medium

### Answers


#### DFS and hashtable

The first idea hit my head is using dfs, so here is my exit condition:

- index out of bound;
- visited elements(stored in a hashtable);
- prefix not fit with target;

True condition:

- String match.

So I got my code:

``` javascript
/**
 * @param {character[][]} board
 * @param {string} word
 * @return {boolean}
 */
var exist = function(board, word) {
  var i , j, mapper = {};   // all visited elements will be marked as true within mapper
  for(i = 0;i<board.length;i++){
    for(j = 0;j<board[i].length;j++){
      if(board[i][j] == word[0]){
        // start with the first same letter
        if(dfs(board,i,j,'',word,mapper)){
          return true
        }
      }
    }
  }
  return false
};

var dfs = (board,x,y,comb,word,mapper) =>{
  if(comb == word){
    // true condition
    return true
  }
  if(mapper[x+"-"+y] || word.length < comb.length || word.indexOf(comb) !== 0){
    // exit condition 1
    return false
  }
  if(x >= board.length || x < 0 || y >= board[x].length || y < 0) {
    // exit condition 2, out of bound
    return false
  }
  mapper[x+"-"+y] = true;  // mark current elements as visited
  comb += board[x][y]
  if(dfs(board,x+1,y,comb,word,mapper) || dfs(board,x,y+1,comb,word,mapper) || dfs(board,x,y-1,comb,word,mapper) || dfs(board,x-1,y,comb,word,mapper)){
    return true
  }else{
    mapper[x+"-"+y] = false
    // recover the element for following loop
  }
}
```

You can pass with this. But it will be slow as 404ms.

#### DFS Optimization

I look at my code again, and find that since I can compare the first letter, why not just compare the current letter for each dfs. So I move it into the dfs and simplify my code with new exit and true condition:

True condition:

- All letters match;

Exit condition:

- Letter not match;
- index out of bound;
- visited elements;

And also, we don't need to store the visited elements, we can just change it and then put the origin one back after the loop;

So finally we got this:

``` javascript
/**
 * @param {character[][]} board
 * @param {string} word
 * @return {boolean}
 */
var exist = function(board, word) {
  var i , j;
  for(i = 0;i<board.length;i++){
    for(j = 0;j<board[i].length;j++){
      if(dfs(board,i,j,word,0)){
        return true
      }
    }
  }
  return false
};

var dfs = (board,x,y,word,step) =>{
  if(step == word.length){
    // all letters match, we got our word
    return true
  }
  if(x >= board.length || x < 0 || y >= board[x].length || y -1< 0) {
    // exit condition 1 - out of bound
    return false
  }
  if(board[x][y] == "\0" || board[x][y] !== word[step]){
    // exit condition 2 - visited or not same letter
    return false
  }
  var temp  = board[x][y];
  board[x][y] = "\0";   // change the visited elements to something else 
  if(dfs(board,x+1,y,word,step+1) || dfs(board,x,y+1,word,step+1) || dfs(board,x,y-1,word,step+1) || dfs(board,x-1,y,word,step+1)){
    return true
  }else{
    board[x][y] = temp;   // put the origin letter back
    return false
  }
}
```

Now with the new code, we can hit the 168 ms.

## 212. Word Search II

### Question

{% blockquote LeetCode https://leetcode.com/problems/word-search-ii/ 212. Word Search II %}
Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

For example,
Given words = ["oath","pea","eat","rain"] and board =

[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]
Return ["eat","oath"].
Note:
You may assume that all inputs are consist of lowercase letters a-z.
{% endblockquote %}

Tags: Trie, Backtracking, Hard

### Answers

#### Trie with classic way

Since this question is based on the previous one, we can just borrow our previous code here. And if you just loop through all words, it will be TLE. So you have to do pruning to stop the dfs as soon as possible.

According to the hint, we can use Trie to help us stop the dfs earlier, here I just use some code I wrote for another problem. As before, lets list the exit condition and succesful conditions for this problem:

Exit conditions:

- Out of bound;
- Visited;
- Prefix never show up in our Trie(which was built with all input words);

True conditon:

- Words is in our Trie;

``` javascript
/**
 * Trie implementation in JavaScript
 */

var TrieNode = function(){
  // # of words end here 
  this.wordsCount = 0
  // # of words will match the prefix
  this.prefixMatches = 0
  // all the node belong to this node
  this.children = {}
}

var Trie = function(){
  this.root = new TrieNode()
}

Trie.prototype.insert = function(word){
  // if not a word, return
  if(word.length <=0) return
  var node = this.root
  var i = 0
  // loop every character of the word and update associate node
  while(i<word.length){
  if(!node.children.hasOwnProperty(word[i])){
    node.children[word[i]] = new TrieNode()
  }
  node = node.children[word[i]] 
  if(i == word.length-1){
    node.wordsCount ++
  }else{
    node.prefixMatches ++
  }
  i ++
  }
}

Trie.prototype.startsWith = function(prefix){
  // if not a word, return
  if(prefix.length <=0) return false
  var node = this.root
  var i = 0
  // loop every character of the word and find whether there is any match
  while(i<prefix.length){
  if(!node.children.hasOwnProperty(prefix[i])){
    return false
  }
  node = node.children[prefix[i]] 
  if(i == prefix.length-1 && (node.prefixMatches !== 0 || node.wordsCount !== 0)){
    return true
  }
  i ++
  }
  return false
} 
Trie.prototype.search = function(word){
  // if not a word, return
  if(word.length <=0) return false
  var node = this.root
  var i = 0
  // loop every character of the word and find whether there is any match
  while(i<word.length){
  if(!node.children.hasOwnProperty(word[i])){
    return false
  }
  node = node.children[word[i]] 
  if(i == word.length-1 && node.wordsCount === 0){
    return false
  }
  i ++
  }
  return true
}
/**
 * @param {character[][]} board
 * @param {string[]} words
 * @return {string[]}
 */
var findWords = function(board, words) {
  var i,j, trie = new Trie(),output = new Set();
  for(i = 0; i < words.length;i++){
    trie.insert(words[i])
  }
  for(i = 0;i<board.length;i++){
    for(j = 0;j<board[i].length;j++){
      dfs(board,i,j,0,'',trie,output)
    }
  }
  var res = []
  output.forEach( (v) => {res.push(v)})
  return res
};
/**
 * @param {character[][]} board
 * @param {string} word
 * @return {boolean}
 */

var dfs = (board,x,y,str,trie,output) =>{
  // the code is pretty much same with previous word search I, but store the fit words into output asap
  if(x >= board.length || x < 0 || y >= board[x].length || y < 0) {
    // exit condition 1 - out of bound 
    return false
  }
  if(board[x][y] == "\0"){
    // exit condition 2 - visited
    return false
  }
  str += board[x][y];
  // exit condition 2 - not in our trie tree
  if(!trie.startsWith(str)){return false}

  // match condition
  if(trie.search(str)){output.add(str)}

  var temp  = board[x][y];
  board[x][y] = "\0";
  dfs(board,x+1,y,str,trie,output)
  dfs(board,x,y+1,str,trie,output)
  dfs(board,x,y-1,str,trie,output)
  dfs(board,x-1,y,str,trie,output)
  board[x][y] = temp;
}

```
Runtime: 868 ms

This is so slow... that I even can not appear in the rumtime distribution of javascript....


#### Modified Trie

According to this post: [Java 15ms easiest solution](https://leetcode.com/discuss/77851/java-15ms-easiest-solution-100-00%25). We actually don't need the entire tree structure, we can modify the structure to speed up our answer for this problem.

Here is the code in JS:

``` javascript
/**
 * @param {character[][]} board
 * @param {string[]} words
 * @return {string[]}
 */
var findWords = function(board, words) {
  var i,j,output=[], root = buildTrie(words);   // build the Trie with input words
  for(i = 0;i<board.length;i++){
    for(j = 0;j<board[i].length;j++){
      dfs(board, i, j, root, output);
    }
  }
  return output;
};

var TrieNode = function(){
  this.next = [];  // store next letter from 0 - 25 <= a - z
  this.word = '';
}

var buildTrie = function(words){
  var i, root = new TrieNode(),j;
  for(i = 0;i<words.length;i++){
    var node = root;
    for(j = 0;j<words[i].length;j++){
      var idx = words[i][j].charCodeAt(0) - 97;   // hash index of the letter, all letters are lowercase
      if(!node.next[idx]){
        node.next[idx] = new TrieNode();
      }
      node = node.next[idx];  // move the node to the end
    }
    node.word = words[i];  // store the word in the end node
  }
  return root
}

var dfs = (board,i,j,node,output) =>{
  var idx = board[i][j].charCodeAt(0) - 97;  // compute the hash index
  if(board[i][j] == '#' || !node.next[idx]) return;  // exit condition: visited or not in Trie
  node = node.next[idx];
  if(node.word != ""){
    // successful condition
    output.push(node.word);
    node.word = "";  // this is to remove the duplicates - genius!!
  }

  // same as before, backtracking
  var temp = board[i][j];
  board[i][j] = '#';
  if(i > 0) dfs(board, i - 1, j ,node, output); 
  if(j > 0) dfs(board, i, j - 1, node, output);
  if(i < board.length - 1) dfs(board, i + 1, j, node, output); 
  if(j < board[0].length - 1) dfs(board, i, j + 1, node, output); 
  board[i][j] = temp;
}
```

Runtime: 204 ms

And I beat 100% of js submissions... Compared to previous answer.. it is unbelievable fast...

### BTW

Have you ever heard about the Word-Clock ? It is a beautiful clock using words represent the time instead of the finger and hands... It is gorgeous!!! Why I mention it ? Don't you feel it is very similiar to what we did in this post ? Word search?

I will try to make a web version of this beautiful watch by using all these words search algorithms :)
