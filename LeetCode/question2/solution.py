# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
        ll1, ll2 = l1, l2
        node = ListNode(0)
        head = node
        carry = 0
        while ll1 and ll2:
            val = (ll1.val+ll2.val+carry) % 10
            carry = (ll1.val+ll2.val+carry) // 10
            node.next = ListNode(val)
            node = node.next
            ll1 = ll1.next
            ll2 = ll2.next

        if ll1:
            node.next = ll1
        elif ll2:
            node.next = ll2
        elif carry:
            node.next = ListNode(carry)
            return head.next
        else:
            return head.next

        while node.next:
            tmp = carry + node.next.val
            node.next.val = tmp % 10
            carry = tmp // 10
            node = node.next
        if carry:
            node.next = ListNode(carry)
        return head.next

# if __name__ == "__main__":
#     l1 = ListNode(9)
#     l1.next = ListNode(9)
#     l2 = ListNode(1)
#     s = Solution()
#     rt = s.addTwoNumbers(l1,l2)
#     while rt:
#         print(rt.val)
#         rt = rt.next