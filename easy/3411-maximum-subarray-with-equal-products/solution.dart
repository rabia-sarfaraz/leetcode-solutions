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