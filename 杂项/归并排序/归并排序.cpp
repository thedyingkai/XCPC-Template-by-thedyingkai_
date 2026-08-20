#include "../../template/start.cpp"

struct MergeSorter {
    vector<int> a, temp;
    i64 inv_count = 0;
    MergeSorter(int n) {
        a.resize(n + 1);
        temp.resize(n + 1);
    }
    void sort(int n) { sort(n, less<int>{}); }
    void sort(int n, auto compare) {
        assert(0 <= n && n < (int) a.size());
        inv_count = 0;
        mergeSort(1, n, compare);
    }
    void mergeSort(int start, int end, auto& compare) {
        if(start >= end) return;
        int mid = start + (end - start) / 2;
        mergeSort(start, mid, compare);
        mergeSort(mid + 1, end, compare);
        mergeArray(start, mid, end, compare);
    }
    void mergeArray(int start, int mid, int end, auto& compare) {
        int i = start, j = mid + 1, k = start;
        while(i <= mid && j <= end) {
            if(!compare(a[j], a[i]))
                temp[k++] = a[i++];
            else
                temp[k++] = a[j++], inv_count += mid - i + 1;
        }
        while(i <= mid) temp[k++] = a[i++];
        while(j <= end) temp[k++] = a[j++];
        for(int idx = start; idx <= end; idx++) a[idx] = temp[idx];
    }
};
