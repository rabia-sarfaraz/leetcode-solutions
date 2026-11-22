# Wildcard Matching

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

Given an input string (`s`) and a pattern (`p`), implement wildcard pattern matching with support for `'?'` and `'*'` where:

- '?' Matches any single character.
- '*' Matches any sequence of characters (including the empty sequence).

The matching should cover the **entire** input string (not partial).

 

Original
Dart
**Example 1:**

```
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".

```

**Example 2:**

```
Input: s = "aa", p = "*"
Output: true
Explanation: '*' matches any sequence.

```

**Example 3:**

```
Input: s = "cb", p = "?a"
Output: false
Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.

```

 

**Constraints:**

- 0 <= s.length, p.length <= 2000
- s contains only lowercase English letters.
- p contains only lowercase English letters, '?' or '*'.

## Solution

**Language:** dart  
**Runtime:** 63 ms (beats 25.00%)  
**Memory:** 203 MB (beats 25.00%)  
**Submitted:** 2026-11-22T04:42:38.277Z  

```dart
class Solution {
  bool isMatch(String s, String p) {
    int m = s.length;
    int n = p.length;

    // dp[i][j] = s[0..i-1] matches p[0..j-1]
    List<List<bool>> dp = List.generate(
      m + 1,
      (_) => List.filled(n + 1, false),
    );

    dp[0][0] = true;

    // Jab string 's' empty ho aur pattern mein '*' ho
    for (int j = 1; j <= n; j++) {
      if (p[j - 1] == '*') {
        dp[0][j] = dp[0][j - 1];
      }
    }

    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (p[j - 1] == '?' || p[j - 1] == s[i - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else if (p[j - 1] == '*') {
          // '*' matches empty sequence OR matches one more char in s
          dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
        }
      }
    }

    return dp[m][n];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/wildcard-matching/)