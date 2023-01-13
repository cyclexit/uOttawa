/*
 * author: cyclexit
 * start from: 2020-09-10 22:39
 */
#include <bits/stdc++.h>

using namespace std;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  cout.tie(0);
  int n;
  cin >> n;
  vector<int> v(n);
  for (int i = 0; i < n; ++i) {
    cin >> v[i];
  }
  //*
  int min, max, cnt = 0;
  if (n == 1) {
    min = v[0];
    max = v[0];
  } else {
    for (int i = 0; i < n; i += 2) {
      if (i != n - 1) {
        if (++cnt && v[i] > v[i + 1]) {
          int temp = v[i];
          v[i] = v[i + 1];
          v[i + 1] = temp;
        }
      }
    }
    min = v[0];
    for (int i = 0; i < n; i += 2) {
      if (++cnt && v[i] < min) {
        min = v[i];
      }
    }
    max = v[1];
    for (int i = 1; i < n; i += 2) {
      if (++cnt && v[i] > max) {
        max = v[i];
      }
    }
  }
  //*/
  cout << "max = " << max << '\n';
  cout << "min = " << min << '\n';
  cout << "comparing times = " << cnt << '\n';
  return 0;
}