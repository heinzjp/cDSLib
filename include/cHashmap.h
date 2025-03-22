#ifndef C_HASHMAP_H
#define C_HASHMAP_H

#include <stdint.h>
#include <stddef.h>

#define HASHMAP_DEFAULT_SIZE 10
#define HASHMAP_LOAD_FACTOR 0.7

// Node for collisions (only for dynamic hashmap with chaining)
typedef struct Node {
    char *key;
    int value;
    struct Node *next;
} Node;

// Common Hashmap structure
typedef struct Hashmap {
    void *table;  // Pointer to either the dynamic table or static table
    size_t size;  // Size of the table
    size_t capacity;  // Capacity of the table
    float load_factor;
    int is_dynamic;  // Flag to differentiate dynamic from static hashmap
}Hashmap;


uint32_t hash(const void *key, size_t key_size, size_t table_size);
void hashmap_init_static(Hashmap *map);

#endif
