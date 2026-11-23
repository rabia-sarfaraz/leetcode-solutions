class ProductOfNumbers {
  List<int> _prefix = [1];

  ProductOfNumbers() {
    _prefix = [1];
  }

  void add(int num) {
    if (num == 0) {
      // Zero aane par pichli history reset kar dein
      _prefix = [1];
    } else {
      _prefix.add(_prefix.last * num);
    }
  }

  int getProduct(int k) {
    int n = _prefix.length - 1;
    
    // Agar k valid non-zero elements se zyada hai, toh beech mein 0 aaya tha
    if (k > n) return 0;

    return _prefix[n] ~/ _prefix[n - k];
  }
}