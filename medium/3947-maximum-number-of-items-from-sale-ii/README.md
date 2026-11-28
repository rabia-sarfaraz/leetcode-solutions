# Maximum Number of Items From Sale II

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given a 2D integer array `items`, where `items[i] = [factori, pricei]` represents the `ith` item. You are also given an integer `budget`.

There are unlimited copies of each item available for purchase. You may buy any number of copies of any items such that the total cost of the purchased copies is at most `budget`.

After buying items, you may receive free copies according to the following rules:

- Each purchased copy of item i can give you at most one free copy of another item j.
- The free item must satisfy i != j and factori divides factorj.
- For each ordered pair (i, j), you can receive a free copy of item j from purchases of item i at most once, regardless of how many copies of item i you buy.
- The same item j can be received multiple times for free if it is received from purchases of different item types.

Return the **maximum total number of item copies** you can obtain, including both purchased copies and free copies, while spending at most `budget` on purchased items.

 

Original
Dart
**Example 1:**

**Input:** items = [[1,6],[2,4],[3,5]], budget = 19

**Output:** 5

**Explanation:**

- You can buy 2 copies of item 0 and 1 copy of item 1 for a total cost of 2 * 6 + 4 = 16, which is not greater than budget = 19.
- One purchased copy of item 0 gives 1 free copy of item 1, because factor0 = 1 divides factor1 = 2.
- The other purchased copy of item 0 gives 1 free copy of item 2, because factor0 = 1 divides factor2 = 3.
- You leave with 3 purchased copies and 2 free copies, for a total of 5 item copies.

**Example 2:**

**Input:** items = [[2,8],[1,10],[6,6],[4,12],[5,20],[5,17]], budget = 35

**Output:** 7

**Explanation:**

- You can buy 2 copies of item 0, 1 copy of item 1, and 1 copy of item 2 for a total cost of 2 * 8 + 10 + 6 = 32, which is not greater than budget = 35.
- One purchased copy of item 0 gives 1 free copy of item 2, because factor0 = 2 divides factor2 = 6.
- The other purchased copy of item 0 gives 1 free copy of item 3, because factor0 = 2 divides factor3 = 4.
- The purchased copy of item 1 gives 1 free copy of item 2, because factor1 = 1 divides factor2 = 6.
- Buying item 2 gives no free copy, because factor2 = 6 does not divide the factor of any other item.
- You leave with 4 purchased copies and 3 free copies, for a total of 7 item copies.

 

**Constraints:**

- 1 <= items.length <= 105
- items[i] = [factori, pricei]
- 1 <= factori <= items.length
- 1 <= pricei <= 109
- 1 <= budget <= 109

## Solution

**Language:** dart  
**Runtime:** 259 ms (beats 100.00%)  
**Memory:** 278.3 MB (beats 100.00%)  
**Submitted:** 2026-11-28T04:02:23.676Z  

```dart
import 'dart:math';

class Solution {
  int maximumSaleItems(List<List<int>> items, int budget) {
    int n = items.length;
    if (n == 0 || budget <= 0) return 0;

    // 1. Har factor ki frequency aur sabse kam price nikalen
    List<int> freq = List.filled(n + 1, 0);
    int minPrice = items[0][1];

    for (var item in items) {
      int f = item[0];
      int p = item[1];
      if (f <= n) freq[f]++;
      if (p < minPrice) minPrice = p;
    }

    // 2. Har factor f ke liye valid targets ki count (khud ko exclude karke)
    List<int> degForFactor = List.filled(n + 1, 0);
    for (int f = 1; f <= n; f++) {
      if (freq[f] == 0) continue;
      int total = 0;
      for (int m = f; m <= n; m += f) {
        total += freq[m];
      }
      degForFactor[f] = total - 1;
    }

    // Har double-deal unit: [price, count] jahan har unit cost `price` par `2` items deta hai
    List<List<int>> cheapDoubleDeals = [];
    List<List<int>> costlyDoubleDeals = [];

    for (var item in items) {
      int f = item[0];
      int p = item[1];
      int d = degForFactor[f];
      if (d > 0 && p <= budget) {
        if (p < 2 * minPrice) {
          cheapDoubleDeals.add([p, d]);
        } else {
          costlyDoubleDeals.add([p, d]);
        }
      }
    }

    cheapDoubleDeals.sort((a, b) => a[0].compareTo(b[0]));
    costlyDoubleDeals.sort((a, b) => a[0].compareTo(b[0]));

    int ans = 0;
    int remBudget = budget;

    // Pehle un double-deals ko lein jo minPrice se better ratio (2/p > 1/minPrice) dete hain
    for (var deal in cheapDoubleDeals) {
      int p = deal[0];
      int d = deal[1];
      int take = min(d, remBudget ~/ p);
      ans += take * 2;
      remBudget -= take * p;
    }

    // Phir bache budget se minPrice wale single items lein
    int singleTake = remBudget ~/ minPrice;
    ans += singleTake;
    remBudget -= singleTake * minPrice;

    // Aakhir mein agar budget bacha ho toh costlyDoubleDeals try karein
    for (var deal in costlyDoubleDeals) {
      int p = deal[0];
      int d = deal[1];
      int take = min(d, remBudget ~/ p);
      ans += take * 2;
      remBudget -= take * p;
    }

    return ans;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-number-of-items-from-sale-ii/)