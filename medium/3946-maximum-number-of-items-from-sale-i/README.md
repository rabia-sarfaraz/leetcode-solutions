# Maximum Number of Items From Sale I

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given a 2D integer array `items`, where `items[i] = [factori, pricei]` represents the `ith` item. You are also given an integer `budget`.

There are unlimited copies of each item available for purchase.You may buy any number of copies of any items such that the total cost of the purchased copies is at most `budget`.

After buying items, you may receive free copies according to the following rules:

- For each item i that you bought at least one copy of, you receive one free copy of every item j such that j != i and factori divides factorj.
- Buying multiple copies of the same item i does not give additional free copies through item i.
- The same item j can be received multiple times for free if it is received from purchases of different item types.

Return the **maximum total number of item copies** you can obtain, including both purchased copies and free copies, while spending at most `budget` on purchased items.

 

Original
Dart
**Example 1:**

**Input:** items = [[6,2],[2,6],[3,4]], budget = 9

**Output:** 4

**Explanation:**

- You can buy 2 copies of item 0 and 1 copy of item 2 for a total cost of 2 * 2 + 4 = 8, which is not greater than budget = 9.
- Buying item 2 gives 1 free copy of item 0, because factor2 = 3 divides factor0 = 6.
- You leave with 3 purchased copies and 1 free copy, for a total of 4 item copies.

**Example 2:**

**Input:** items = [[2,4],[3,2],[4,1],[6,4],[12,4]], budget = 8

**Output:** 10

**Explanation:**

- You can buy 1 copy of item 0, 1 copy of item 1, and 2 copies of item 2 for a total cost of 4 + 2 + 2 * 1 = 8.
- Buying item 0 gives 1 free copy of items 2, 3, and 4.
- Buying item 1 gives 1 free copy of items 3 and 4.
- Buying item 2 gives 1 free copy of item 4.
- Thus, you receive 6 free copies. You leave with 4 purchased copies and 6 free copies, for a total of 10 item copies.

 

**Constraints:**

- 1 <= items.length <= 1000
- items[i] = [factori, pricei]
- 1 <= factori, pricei <= 1500
- 1 <= budget <= 1500

## Solution

**Language:** dart  
**Runtime:** 42 ms (beats 100.00%)  
**Memory:** 175.7 MB (beats 100.00%)  
**Submitted:** 2026-11-27T04:35:13.877Z  

```dart
import 'dart:math';

class Solution {
  int maximumSaleItems(List<List<int>> items, int budget) {
    const int maxFactor = 1500;
    List<int> freq = List.filled(maxFactor + 1, 0);

    int minPrice = 1000000000;
    for (var item in items) {
      freq[item[0]]++;
      if (item[1] < minPrice) {
        minPrice = item[1];
      }
    }

    // Har factor f ke liye kitne items hain jinhe f divide karta hai
    List<int> divCount = List.filled(maxFactor + 1, 0);
    for (int f = 1; f <= maxFactor; f++) {
      if (freq[f] == 0) continue;
      int total = 0;
      for (int m = f; m <= maxFactor; m += f) {
        total += freq[m];
      }
      divCount[f] = total;
    }

    // 0-1 Knapsack: har item ki pehli copy lene par (1 + free_i) copies milti hain
    List<int> dp = List.filled(budget + 1, 0);

    for (var item in items) {
      int f = item[0];
      int price = item[1];
      if (price > budget) continue;

      int value = divCount[f]; // 1 (khud) + (divCount[f] - 1) (free copies) = divCount[f]

      for (int b = budget; b >= price; b--) {
        int cand = dp[b - price] + value;
        if (cand > dp[b]) {
          dp[b] = cand;
        }
      }
    }

    // Kisi bhi state mein bache hue budget se sabse saste item ki extra copies le sakte hain
    int ans = 0;
    for (int b = 0; b <= budget; b++) {
      int extraCopies = (budget - b) ~/ minPrice;
      int total = dp[b] + extraCopies;
      if (total > ans) {
        ans = total;
      }
    }

    return ans;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-number-of-items-from-sale-i/)