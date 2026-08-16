#include "../../template/start.cpp"

struct MergeSorter {
    vector<int> a, temp;
    i64 inv_count = 0;
    MergeSorter(int n) {
        a.resize(n + 1);
        temp.resize(n + 1);
    }
    void sort(int n) {
        inv_count = 0;
        mergeSort(1, n);
    }
    void mergeSort(int start, int end) {
        if(start >= end) return;
        int mid = start + (end - start) / 2;
        mergeSort(start, mid);
        mergeSort(mid + 1, end);
        mergeArray(start, mid, end);
    }
    void mergeArray(int start, int mid, int end) {
        int i = start, j = mid + 1, k = start;
        while(i <= mid && j <= end) {
            if(a[i] <= a[j])
                temp[k++] = a[i++];
            else
                temp[k++] = a[j++], inv_count += mid - i + 1;
        }
        while(i <= mid) temp[k++] = a[i++];
        while(j <= end) temp[k++] = a[j++];
        for(int idx = start; idx <= end; idx++) a[idx] = temp[idx];
    }
};
