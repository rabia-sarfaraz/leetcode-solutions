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