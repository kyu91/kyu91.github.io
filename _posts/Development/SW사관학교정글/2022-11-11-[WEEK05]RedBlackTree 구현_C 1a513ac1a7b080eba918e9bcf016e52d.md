---
layout: post
title: "[WEEK05]RedBlackTree 구현_C"
date: 2022-11-11
categories:
  - Development
  - SW사관학교정글
tags:
  - 정글후기
  - 개발공부
  - C
  - RBTree
description: Red Black Tree 구현 및 정리
---

# [WEEK05]RedBlackTree 구현_C

해당 내용은 정확하지 않을 수 있습니다.

그래서 당연히 귀한 시간 내주시어 지적해 주시면 감사 드리겠습니다.


## **Red Black Tree란?**

자세한 개념 정리는 정리가 잘 되어있는 블로그들이 많아 생략.

1. 자료 구조 중 하나이다.

2. 자가균형이진 탐색 트리이다.

3. 쉬운말로 자료(값)을 삽입하고 삭제하여도 해당 트리는 스스로 균형을 유지한다.

- > 이말인 즉, 해당 트리를 탐색 하였을때 아주 효율적인 탐색이 가능하다.

---

## **Red Black Tree 특징**

1. (균형)이진탐색트리

2. 노드는 Rad/Black 중 하나씩만 갖어야 한다.

3. Root노드는 Black이여야 한다.

4. leaf node는 Black이여야 한다.

5. Rad node의 자식노드는 무조건 Black

6. 각 노드는 leaf node로 가는 길에 black node의 개수는 항상 같다(항상 logN으로 되는것을 증명될때 사용된다)

---

## **코드(C)**

```c
#include "rbtree.h"
#include <stdlib.h>
#include <stdio.h>

rbtree *new_rbtree(void) {
  rbtree *p = (rbtree *)calloc(1, sizeof(rbtree));
  // TODO: initialize struct if needed
  node_t *nil_node = (node_t*)calloc(1,sizeof(node_t));
  nil_node->color = RBTREE_BLACK;
  nil_node->key = 0;

  p->nil = nil_node;
  p->root = p->nil;
  return p;
}

void postorder_delete(node_t *root, node_t *nil){   // 후위순회로 삭제

  if (nil == root) return;
  postorder_delete(root->left, nil);
  postorder_delete(root->right, nil);
  free(root);
}

void delete_rbtree(rbtree *t) {
  // TODO: reclaim the tree nodes's memory
  postorder_delete(t->root, t->nil);
  free(t->nil);

  free(t);

}

void left_rotate(rbtree *t, node_t *x){

  node_t* y = x->right;

  x->right = y->left;
  if (y->left != t->nil){

    y -> left->parent = x;
  }

  y->parent = x->parent;

  if(x->parent == t->nil){

    t->root = y;
  }else if (x == x->parent->left){

    x->parent->left = y;
  }else{

    x->parent->right = y;
  }
  y -> left = x;
  x -> parent = y;
}

void right_rotate(rbtree *t, node_t *y){

  node_t *x = y->left;
  y->left = x->right;
  if (x->right != t->nil){

    x -> right->parent = y;
  }

  x->parent = y->parent;

  if(y->parent == t->nil){
    t->root = x;
  }else if (y == y->parent->left){
    y->parent->left = x;
  }else{

    y->parent->right = x;
  }

  x -> right = y;
  y -> parent = x;
}

void insertFixup(rbtree *t, node_t *z)
{
  while (z->parent->color == RBTREE_RED)
  {       // 일단 부모의 색이 red면 시작
    if (z->parent == z->parent->parent->left)   // z의 부모가 z할무니의 왼쪽 자식이면
    {
      node_t *y = z->parent->parent->right;     // 할무니의 오른쪽 자식로 할당 = 삼촌!
      if (y->color == RBTREE_RED)               //부모의 색이 red인데 삼촌도 red면
      {
        z->parent->color = RBTREE_BLACK;
        y->color = RBTREE_BLACK;
        z->parent->parent->color = RBTREE_RED;
        z = z->parent->parent;                  // 색 바꾸고 할무니한테 가라!
      }else
      {
        if (z == z->parent->right)          // z가 부모의 오른쪽 자식이면
        {
          z = z->parent;                          // 부모를 루트로 왼쪽 회전
          left_rotate(t, z);
        }
        z->parent->color = RBTREE_BLACK;
        z->parent->parent->color = RBTREE_RED;
        right_rotate(t, z->parent->parent);
      }
    }
    else                                        // z의 부모가 z할무니의 오른쪽 자식이면
    {
      node_t *y = z->parent->parent->left;             // 할무니의 왼쪽 자식로 할당 = 삼촌!
      if (y->color == RBTREE_RED)               // 부모의 색이 red인데 삼촌도 red면
      {
        z->parent->color = RBTREE_BLACK;
        y->color = RBTREE_BLACK;
        z->parent->parent->color = RBTREE_RED;
        z = z->parent->parent;                  // 색 바꾸고 할무니한테 가라!
      }else
      {
        if (z == z->parent->left)          // z가 부모의 왼쪽 자식이면
        {
          z = z->parent;                          // 부모를 루트로 왼쪽 회전
          right_rotate(t, z);
        }
        z->parent->color = RBTREE_BLACK;
        z->parent->parent->color = RBTREE_RED;
        left_rotate(t, z->parent->parent);
      }
    }
  }
  t->root -> color = RBTREE_BLACK;
}

// node_t *rbtree_insert(rbtree *, const key_t);
node_t *rbtree_insert(rbtree *t, const key_t key) {
  // TODO: implement insert
  node_t *z = (node_t*)calloc(1,sizeof(node_t));  // 새 노드 메모리 할당
  z->key = key;                                   // 새 노드에 우선 메모리 할당

  node_t *y = t->nil;                           // 임시 포인터(nil)
  node_t *x = t->root;                          // 임시 포인터(Root)
  while (x != t->nil)                           //root 노드가 nil이 아니면 반복문 시작
  {
    y = x;
    if(z -> key < x->key){
      x = x->left;                             //root노드의 값과 새노드의 값을 비교하며 내려감
    }
    else x = x->right;
  }

  z->parent = y;                                //반복문을 지나 오나 안지나나 새노드의 부모를 y로 할당
  if (y == t->nil) t -> root = z;               //y가 nil일 경우 새노드를 root!
  else if (z -> key < y->key) y->left = z;        //y보다 작으면 왼쪽 크면 오른쪽으로 새노드 넣어
  else y->right = z;

  z->left = t -> nil;                           //새노드 정보 할당
  z->right = t -> nil;
  z->color = RBTREE_RED;

  insertFixup(t, z);
  return z;
}

node_t *rbtree_find(const rbtree *t, const key_t key) {
  // TODO: implement find
  node_t *x = t->root;

  while (x != t->nil)
  {
    if (x->key > key){
      x = x->left;
    }else if(x->key < key){
      x = x->right;
    }else{
      break;
    }
  };

  if (x == t->nil) {
    return NULL;
  }
  else {
    return x;
  }
}

node_t *erase_min(node_t *n, node_t *nil){
  node_t *min = n;
  while (n != nil)
  {
    min = n;
    n = n->left;
  }
  return min;
}

node_t *rbtree_min(const rbtree *t) {
  // TODO: implement find
  node_t *min;
  min = erase_min(t->root, t->nil);
  return min;
}

node_t *rbtree_max(const rbtree *t) {
  // TODO: implement find
  node_t *x = t->root;
  node_t *max = t->root;
  while (x != t->nil)
  {
    max = x;
    x = x->right;
  };
  return max;
}

void rbtree_erase_fixup(rbtree *t, node_t *x){
  while (x != t->root && x->color==RBTREE_BLACK)
  {
    if(x == x->parent->left){                       // 왼쪽에 붙어 있을때
      node_t *w = x->parent->right;                 // 임시 노드에 형제 노드 할당
      if(w->color == RBTREE_RED){                   // 형제가 red일때
        w->color = RBTREE_BLACK;
        x->parent->color = RBTREE_RED;
        left_rotate(t, x->parent);
        w = x->parent->right;
      }                                             // 형제 왼쪽 자식이 블랙이면서 오른쪽 자식도 블랙일때
      if(w->left->color == RBTREE_BLACK && w->right->color == RBTREE_BLACK){
        w->color = RBTREE_RED;
        x = x->parent;
      }else{                                        // 형제 자식 중 하나라도 레드면
        if (w->right->color == RBTREE_BLACK){
          w->left->color = RBTREE_BLACK;
          w->color = RBTREE_RED;
          right_rotate(t, w);
          w = x->parent->right;
        }
        w->color = x->parent->color;
        x->parent->color = RBTREE_BLACK;
        w->right->color = RBTREE_BLACK;
        left_rotate(t, x->parent);
        x = t->root;
      }
    }else{                                          // 오른쪽에 붙어 있을때
      node_t *w = x->parent->left;
      if(w->color == RBTREE_RED){
        w->color = RBTREE_BLACK;
        x->parent->color = RBTREE_RED;
        right_rotate(t, x->parent);
        w = x->parent->left;
      }
      if(w->left->color == RBTREE_BLACK && w->right->color == RBTREE_BLACK){
        w->color = RBTREE_RED;
        x = x->parent;
      }else{
        if (w->left->color == RBTREE_BLACK){
          w->right->color = RBTREE_BLACK;
          w->color = RBTREE_RED;
          left_rotate(t, w);
          w = x->parent->left;
        }
        w->color = x->parent->color;
        x->parent->color = RBTREE_BLACK;
        w->left->color = RBTREE_BLACK;
        right_rotate(t, x->parent);
        x = t->root;
      }
    }
  }
  x->color = RBTREE_BLACK;
}

void rbtree_transplant(rbtree *t, node_t *u, node_t *v){

  if (u->parent == t->nil){
    t->root = v;
  }else if (u == u->parent->left){
    u->parent->left = v;
  }else{
    u->parent->right = v;
  }
  v->parent = u->parent;
}

int rbtree_erase(rbtree *t, node_t *d_node) {     // 삭제할 노드 받음
  // TODO: implement erase
  node_t *cur = d_node;                           // 삭제할 노드 임시 노드로 할당
  color_t cur_color = cur->color;                 // 제거할 노드의 색 저장 변수
  node_t *x;                                      // 임시 노드

  if (d_node->left == t->nil)                     // 삭제할 노드의 왼쪽이 nil일떄
  {                                               // 삭제할 놈과 그 오른쪽 자식의 부모들을 바꿈
    x = d_node->right;
    rbtree_transplant(t, d_node, d_node->right);
  }else if (d_node->right == t->nil){             // 오른쪽 놈이 nil이면
    x = d_node->left;                             // 외쪽 자식의 부모와 삭제할 부모 바꿔
    rbtree_transplant(t, d_node, d_node->left);
  }else{                                          // 만약 두자식 다 있으면
    cur = erase_min(d_node->right, t->nil);       // 오른쪽의 최소값 찾아(이분탐색 삭제와 동일)
    cur_color = cur->color;                       // 오른쪽 최소값의 색을 저장(이분탐색 삭제와 다른점)
    x = cur->right;
    if (cur->parent == d_node){                   // 최솟값의 부모가 삭제할 놈이면 cur를 cur의 오른쪽 부모로
      x->parent = cur;
    }else {                                       // 삭제할 놈이 아니면 최솟값 노드와 그 오른쪽 자식의 부모를 서로 바꾸고
      rbtree_transplant(t, cur, cur->right);
      cur->right = d_node->right;                 // 최솟값 자식을 삭제할 놈의 자식으로 붙힘
      cur->right->parent = cur;
    }
    rbtree_transplant(t, d_node, cur);            // 두 조건이 모두 아니면 최솟값을 삭제할 놈으로 대치하고 색은 삭제할 노드 색으로
    cur->left = d_node->left;
    cur->left->parent = cur;
    cur->color = d_node->color;
  }
  free(d_node);                                   // 노드 삭제
  d_node = NULL;

  if(cur_color == RBTREE_BLACK){
    rbtree_erase_fixup(t, x);                     // 아래에서 삭제했던 놈이 블랙이면 rbtree 규칙에 위반 되므로 fixup과정 진행!
  }
  t->nil->parent = NULL;
  t->nil->right = NULL;
  t->nil->left = NULL;
  t->nil->color = RBTREE_BLACK;

  return 0;
}
                                                // 전위 순회로 어레이 만듬(오름차순)
void inorder_getarr(node_t *root, node_t *nil, key_t *arr, int *index){
  if (root == nil) return;
  inorder_getarr(root -> left, nil, arr, index);
  arr[(*index)++] = root->key;                  // 설명 해줘요
  inorder_getarr(root -> right, nil, arr, index);
}

int rbtree_to_array(const rbtree *t, key_t *arr, const size_t n) {
  // TODO: implement to_array
  int *index = calloc(1, sizeof(int));
  inorder_getarr(t->root, t->nil, arr, index);
  free(index);
  return 0;
}

```

---

## **배운 점**

대부분이 수도코드에서 참고한 코드이지만 매우매우 신기한 자료구조를 배워서 나름 재미는 있었다.

모든 수에 대한 탐색 시간이 logN 이라니.

C의 포인터에 대해 공부하는 부분도 크게 도움이 되었다.