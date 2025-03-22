#include "cHashmap.h"
#include <string.h>
#include <stdlib.h>

void hashmap_init(Hashmap *map) {
    map->capacity = HASHMAP_DEFAULT_SIZE;
    map->size = 0;
    map->load_factor = HASHMAP_LOAD_FACTOR;
    map->is_dynamic = 0;

    map->table = malloc(sizeof(Node*) * map->capacity);
    memset(map->table, 0, sizeof(Node*) * map->capacity);
}

uint32_t hash(const void *key, size_t key_size, size_t table_size) {
    const uint8_t *data = (const unsigned char*)key;  // Treat the key as a byte array
    uint32_t hash = 5381;  // Starting value for djb2, could be customized
    size_t i;

    // Process each byte in the key
    for (i = 0; i < key_size; i++) {
        hash = ((hash << 5) + hash) + data[i];  // hash * 33 + byte
    }

    return hash % table_size;  // Return index within table size
}
