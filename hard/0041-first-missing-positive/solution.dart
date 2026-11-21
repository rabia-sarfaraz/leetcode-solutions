class Solution {
  int firstMissingPositive(List<int> nums) {
    int n = nums.length;

    // Step 1: Har valid number (1 se n) ko uske sahi index (num - 1) par rakhein
    for (int i = 0; i < n; i++) {
      while (nums[i] > 0 && nums[i] <= n && nums[nums[i] - 1] != nums[i]) {
        int correctIdx = nums[i] - 1;
        int temp = nums[i];
        nums[i] = nums[correctIdx];
        nums[correctIdx] = temp;
      }
    }

    // Step 2: Pehla index dhoondein jahan nums[i] != i + 1
    for (int i = 0; i < n; i++) {
      if (nums[i] != i + 1) {
        return i + 1;
      }
    }

    // Agar 1 se n tak sab maujood hain
    return n + 1;
  }
}