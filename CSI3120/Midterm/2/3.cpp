/*
 * author: cyclexit
 * start from: 2020-11-21 14:24
 */
#include <bits/stdc++.h>

using namespace std;

inline int h(int& i, int& j) {
  i = 2 * i + j - 1;
  j = i - j - 2;
  return i + j;
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  cout.tie(0);
  int m, n, w, z;
  m = 10;
  n = 3;
  w = h(m, n);
  z = h(n, m);
  cout << m << " " << n << " " << w << " " << z << '\n';
  return 0;
}
// (c) The pass-by-value approach will be easier to figure out. In this way, the value of the m and n will not change by the function h, so we don't need to track the changes made to the m and n inside the function h. However, the pass-by-reference way needs to track those changes.
// (d) No, here, call-by-need will not be more efficient. The parameters i and j must be accessed inside the function h. If call-by-need way is used, there will be more cost to access the i and j which will make the function h less efficient.