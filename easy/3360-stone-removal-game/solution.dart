class Solution {
  bool canAliceWin(int n) {
    int remove = 10;
    bool aliceTurn = true;

    while (n >= remove) {
      n -= remove;
      remove--;
      aliceTurn = !aliceTurn;
    }

    // Agar loop ke baad aliceTurn true hai, iska matlab Alice move nahi kar sakti -> Bob jeeta (false)
    // Agar aliceTurn false hai, toh Alice ne aakhri move kiya tha -> Alice jeeti (true)
    return !aliceTurn;
  }
}