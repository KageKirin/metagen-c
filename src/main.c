#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#include "xxhash.h"

void generateMetaFile(const char* filename, XXH128_hash_t hash);

int main(int argc, char** argv)
{
    if (argc > 1 && argc < 3)
    {
        fprintf(stderr, "wrong number of arguments\n");
    }

    if (argc < 3)
    {
        fprintf(stdout, "Metagen: generate Unity .meta files for given inputs\n");
        fprintf(stdout, "\tUsage: %s [seed] <files...>\n", argv[0]);
        fprintf(stdout, "\t[seed]: unique determinant used as seed for hashes. E.g. package name.\n");
        return -1;
    }

    XXH64_hash_t seed = XXH64(argv[1], strlen(argv[1]), 0);
    for (int i = 2; i < argc; i++)
    {
        struct stat _stat;
        if (stat(argv[i], &_stat) == 0 && _stat.st_mode & (S_IFDIR))
        {
            printf("%i ->> %s", i, argv[i]);
            XXH128_hash_t hash = XXH3_128bits_withSeed(argv[i], strlen(argv[i]), seed);

            // Mark this as a random GUID per RFC-4122 section 4.4
            char* bytes = (char*)&hash;
            unsigned char version = 4;
            bytes[6]              = (bytes[6] & 0x0F) | (version << 4);
            bytes[9]              = (bytes[9] & 0x3F) | 0x80;
            printf(": %llx%llx\n", (unsigned long long)hash.high64, (unsigned long long)hash.low64);

            generateMetaFile(argv[i], hash);
        }
    }

    return 0;
}

void generateMetaFile(const char* filename, XXH128_hash_t hash)
{
    size_t strsize = strlen(filename);
    char* metafilename = alloca(strsize + 6);
    memset(metafilename, 0, strsize + 6);
    strncpy(metafilename, filename, strsize);
    strncat(metafilename, ".meta", 5);

    printf("\t %s -> %s\n", filename, metafilename);

    FILE* fd = fopen(metafilename, "w");
    assert(fd);
    if (!fd)
    {
        fprintf(stderr, "failed to open '%s' for writing\n", metafilename);
        return;
    }

    fprintf(fd, "fileFormatVersion: 2\n");
    fprintf(fd, "guid: %llx%llx\n", (unsigned long long)hash.high64, (unsigned long long)hash.low64);
    fprintf(fd, "MonoImporter:\n");
    fprintf(fd, "  externalObjects: {}\n");
    fprintf(fd, "  serializedVersion: 2\n");
    fprintf(fd, "  defaultReferences: []\n");
    fprintf(fd, "  executionOrder: 0\n");
    fprintf(fd, "  icon: {instanceID: 0}\n");
    fprintf(fd, "  userData: \n");
    fprintf(fd, "  assetBundleName: \n");
    fprintf(fd, "  assetBundleVariant: \n");

    fclose(fd);
}
