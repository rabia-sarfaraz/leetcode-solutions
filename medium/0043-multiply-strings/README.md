# Multiply Strings

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given two non-negative integers `num1` and `num2` represented as strings, return the product of `num1` and `num2`, also represented as a string.

**Note:** You must not use any built-in BigInteger library or convert the inputs to integer directly.

 

Original
Dart
**Example 1:**

```
Input: num1 = "2", num2 = "3"
Output: "6"

```

**Example 2:**

```
Input: num1 = "123", num2 = "456"
Output: "56088"

```

 

**Constraints:**

- 1 <= num1.length, num2.length <= 200
- num1 and num2 consist of digits only.
- Both num1 and num2 do not contain any leading zero, except the number 0 itself.

## Solution

**Language:** dart  
**Runtime:** 6 ms (beats 57.14%)  
**Memory:** 177.1 MB (beats 14.29%)  
**Submitted:** 2026-11-21T13:27:49.959Z  

```dart
class Solution {
  String multiply(String num1, String num2) {
    if (num1 == "0" || num2 == "0") return "0";

    int m = num1.length;
    int n = num2.length;
    List<int> pos = List.filled(m + n, 0);

    // Right to left digits ko multiply karein
    for (int i = m - 1; i >= 0; i--) {
      int d1 = num1.codeUnitAt(i) - 48; // ASCII '0' = 48
      for (int j = n - 1; j >= 0; j--) {
        int d2 = num2.codeUnitAt(j) - 48;

        int mul = d1 * d2;
        int p1 = i + j;     // Carry index
        int p2 = i + j + 1; // Current digit index

        int sum = mul + pos[p2];

        pos[p2] = sum % 10;
        pos[p1] += sum ~/ 10;
      }
    }

    // Leading zeros skip karke StringBuffer mein result banayein
    StringBuffer sb = StringBuffer();
    for (int p in pos) {
      if (!(sb.isEmpty && p == 0)) {
        sb.write(p);
      }
    }

    return sb.isEmpty ? "0" : sb.toString();
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/multiply-strings/)