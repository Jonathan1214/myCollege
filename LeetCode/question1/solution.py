class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
    '''
    枚举
    '''
        for index, item in enumerate(nums):
            for i, t in enumerate(nums[index+1:]):
                if t + item == target:
                    return [index, i+index+1]
        return []
        
    def twoSum_plus(self, nums: List[int], target: int) -> list[int]:
    '''
    使用字典构成哈希表
    '''
        hashmap = {}
        for index, num in enumerate(nums):
            another_num = target - num
            if another_num in hashmap:
                return [hashmap[another_num], index]
            hashmap[num] = index
        return None