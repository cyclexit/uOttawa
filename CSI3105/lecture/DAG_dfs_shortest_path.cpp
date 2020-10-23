/*
 * author: cyclexit
 * start from: 2020-10-22 22:40
 */
#include <bits/stdc++.h>

using namespace std;

string to_string(bool b) {
  return (b ? "true" : "false");
}

string to_string(const char* cstr) {
  return (string) cstr;
}

string to_string(string str) {
  return str;
}

template<typename A, typename B>
string to_string(pair<A, B> p) {
  return "(" + to_string(p.first) + ", " + to_string(p.second) + ")";
}

template<typename T>
string to_string(const T& v) {
  string res = "[";
  bool first = true;
  for (const auto& x : v) {
    if (!first) res += ", ";
    first = false;
    res += to_string(x);
  }
  res += "]";
  return res;
}

void debug() {cerr << endl;}

template<typename Head, typename... Tail>
void debug(Head H, Tail... T) {
  cerr << to_string(H) << " ";
  debug(T...);
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  cout.tie(0);
  int n, m;
  cin >> n >> m;
  vector<vector<pair<int, int>>> out_edge(n);
  int u, v, w;
  for (int i = 0; i < m; ++i) {
    cin >> u >> v >> w;
    out_edge[--u].emplace_back(--v, w);
  }
  int start, end;
  cin >> start >> end;
  --start;
  --end;
  vector<int> dp(n, -1);
  vector<bool> vis(n, false);
  dp[start] = 0;
  function<void(int)> dfs = [&](int cur) {
    vis[cur] = true;
    for (pair<int, int> p : out_edge[cur]) {
      if (dp[p.first] == -1) {
        dp[p.first] = dp[cur] + p.second;
      } else {
        dp[p.first] = min(dp[p.first], dp[cur] + p.second);
      }
      dfs(p.first);
    }
  };
  dfs(start);
  debug(out_edge);
  debug(dp);
  cout << dp[end] << '\n';
  return 0;
}