double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int i_max , i_min = 0;
    int *A, *B, m, n;
    // 确保 szie_A > size_B
    if (nums1Size > nums2Size) {
        i_max = nums1Size;
        m = nums1Size;
        n = nums2Size;
        A = nums1;
        B = nums2;
    } else {
        i_max = nums2Size;
        m = nums2Size;
        n = nums1Size;
        A = nums2;
        B = nums1;
    }
    // 二分查找起点
    int halfsize = (nums1Size + nums2Size + 1) / 2;
    while (i_min < i_max) {
        int i = (i_min + i_max) / 2;
        int j = halfsize - i;
        if (i < m && B[j-1] > A[i]) { // i is too small
            i_min = i + 1;
        } else if (i > 0 && A[i-1] > B[j]) { // i is too large
            i_max = i - 1;
        } else { // i is perfect
            int maxLeft;
            if (i == 0)
                maxLeft = B[j-1];
            else if (j == 0)
                maxLeft = A[i-1];
            else {
                if (A[i-1] > B[j-1])
                    maxLeft = A[i-1];
                else
                    maxLeft = B[j-1];
            }
            
            if ((nums1Size + nums2Size) % 2)
                return maxLeft;
            
            int minRight;
            if (i == m)
                minRight = B[j];
            else if (j == n)
                minRight = A[i];
            else {
                if (A[i] > B[j])
                    minRight = B[j];
                else
                    minRight = A[i];
            }
            return (maxLeft + minRight) / 2.0;
        }
    }
}