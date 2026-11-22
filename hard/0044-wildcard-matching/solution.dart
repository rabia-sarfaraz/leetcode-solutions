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