# Maximum Subarray With Equal Products

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

You are given an array of **positive** integers `nums`.

An array `arr` is called **product equivalent** if `prod(arr) == lcm(arr) * gcd(arr)`, where:

- prod(arr) is the product of all elements of arr.
- gcd(arr) is the GCD of all elements of arr.
- lcm(arr) is the LCM of all elements of arr.

Return the length of the **longest** **product equivalent** subarray of `nums`.

 

Original
Dart
**Example 1:**

**Input:** nums = [1,2,1,2,1,1,1]

**Output:** 5

**Explanation:** 

The longest product equivalent subarray is `[1, 2, 1, 1, 1]`, where `prod([1, 2, 1, 1, 1]) = 2`, `gcd([1, 2, 1, 1, 1]) = 1`, and `lcm([1, 2, 1, 1, 1]) = 2`.

**Example 2:**

**Input:** nums = [2,3,4,5,6]

**Output:** 3

**Explanation:** 

The longest product equivalent subarray is `[3, 4, 5].`

**Example 3:**

**Input:** nums = [1,2,3,1,4,5,1]

**Output:** 5

 

**Constraints:**

- 2 <= nums.length <= 100
- 1 <= nums[i] <= 10

## Solution

**Language:** dart  
**Runtime:** 2 ms (beats 100.00%)  
**Memory:** 175 MB (beats 100.00%)  
**Submitted:** 2026-11-24T06:45:55.663Z  

```dart
import 'dart:math';

class Solution {
  int maxLength(List<int> nums) {
    int n = nums.length;
    int maxVal = 0;
    int overallLcm = 1;

    for (int x in nums) {
      maxVal = max(maxVal, x);
      overallLcm = _lcm(overallLcm, x);
    }

    int maxP = overallLcm * maxVal;
    int ans = 0;

    for (int i = 0; i < n; i++) {
      int p = 1;
      int g = 0;
      int l = 1;

      for (int j = i; j < n; j++) {
        p *= nums[j];
        g = _gcd(g, nums[j]);
        l = _lcm(l, nums[j]);

        if (p == l * g) {
          ans = max(ans, j - i + 1);
        }

        if (p > maxP) {
          break;
        }
      }
    }

    return ans;
  }

  int _gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int _lcm(int a, int b) {
    return (a ~/ _gcd(a, b)) * b;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-subarray-with-equal-products/)