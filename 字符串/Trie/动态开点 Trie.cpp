#include <template/start.cpp>

struct Trie {
    static const int SZ = 26;
    struct Node {
        Node* next[SZ];
        int count;
        Node() : count(0) { memset(next, 0, sizeof(next)); }
    };
    Node* root;
    i64 nodeCount;
    Trie() {
        root = new Node();
        nodeCount = 1;
    }
    void insert(const string& s) {
        Node* cur = root;
        for(char c : s) {
            int id = c - 'a';
            if(!cur->next[id]) cur->next[id] = new Node(), nodeCount++;
            cur = cur->next[id], cur->count++;
        }
    }
    int find(const string& s) const {
        Node* cur = root;
        for(char c : s) {
            int id = c - 'a';
            if(!cur->next[id]) return 0;
            cur = cur->next[id];
        }
        return cur->count;
    }
};
int main() {
    int n;
    cin >> n;
    Trie trie;
    for(int i = 0; i < n; i++) {
        string s;
        cin >> s;
        trie.insert(s);
    }
    cout << trie.nodeCount << endl;
}
