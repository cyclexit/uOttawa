/*
 * author: cyclexit
 * start from: 2020-09-24 10:55
 */
#include <bits/stdc++.h>

using namespace std;

int solve(vector<int>& v, int l, int r, vector<int>& len) {
  if (l == r) {
    return len[l] = v[l];
  }
  int mid = (l + r) / 2;
  int lmax = solve(v, l, mid, len);
  int rmax = solve(v, mid + 1, r, len);
  if (v[mid] && v[mid + 1]) {
    int temp = len[mid];
    len[mid] += len[mid + 1];
    len[mid + 1] += temp;
  }
  // test
  // for (int x : len) {
  //   cout << x << " ";
  // }
  // cout << '\n';
  // do the merge
  int mid_max = len[mid];
  return max(mid_max, max(lmax, rmax));
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  cout.tie(0);
  int n;
  cin >> n;
  vector<int> v(n); // bit-array
  for (int i = 0; i < n; ++i) {
    cin >> v[i];
  }
  vector<int> len(n, 0);
  int ans = solve(v, 0, n - 1, len);
  cout << ans << '\n';
  return 0;
}