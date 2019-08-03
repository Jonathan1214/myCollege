/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */


struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2){
    struct ListNode *head, *node, *p;
    head = (struct ListNode *)malloc(sizeof(struct ListNode));
    int carry = (l1->val + l2->val) / 10;
    head->val = (l1->val + l2->val) % 10;
    head->next = NULL;
    node = head;
    while (l1->next && l2->next) {
        l1 = l1->next;
        l2 = l2->next;
        p = (struct ListNode *)malloc(sizeof(struct ListNode));
        p->val = (l1->val + l2->val + carry) % 10;
        p->next = NULL;
        carry = (l1->val + l2->val + carry) / 10;
        node->next = p;
        node = node->next;
    }
    
    if (l1->next)
        node->next = l1->next;
    else if (l2->next)
        node->next = l2->next;
    else if (carry) {
        p = (struct ListNode *)malloc(sizeof(struct ListNode));
        p->val = carry;
        p->next = NULL;
        node->next = p;
        return head;
    } else
        return head;
    
    while (node->next) {
        int tmp = carry + node->next->val;
        node->next->val = tmp % 10;
        carry = tmp / 10;
        node = node->next;
    }
    if (carry) {
        p = (struct ListNode *)malloc(sizeof(struct ListNode));
        p->val = carry;
        p->next = NULL;
        node->next = p;
    }
    return head; 
}
