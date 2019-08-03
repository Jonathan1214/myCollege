int* twoSum(int* nums, int numsSize, int target, int* returnSize){
    int i, j, flag = 0;
    int *return_val = NULL;
    for (i = 0; i < numsSize-1; i++) {
        int has_to_find = target - nums[i];
        for (j = i + 1; j < numsSize; j++) {
            if (nums[j] == has_to_find) {
                return_val = (int *) malloc(2*sizeof(int));
                return_val[0] = i;
                return_val[1] = j;
                *returnSize = 2;
                return return_val;
            }
        }
    }
    *returnSize = 0;
    return return_val;
}
