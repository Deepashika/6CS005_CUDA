// adding files to repository 

/*
 * Encrypt all the strings in a given file.
 */
 /* including c libraries */
#define _GNU_SOURCE
#include <crypt.h>
#include <malloc.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define SALT "$6$HP$"

#define PASSWD_FILE "../data/popular_passwords.txt"

#define ERROR -1
// encripting the string file 
char* encrypt_string(char* password);
FILE* open_file(char* filename);
void close_file(FILE* fp);
void read_line_in_file(FILE* fp, char** line);

// Function to Open file
FILE* open_file(char* filename) {
    FILE *fp;
    fp = fopen(filename, "r");
    return fp;
}
//function for closing file
void close_file(FILE* fp) {
    fclose(fp);
}
// read the file line by line
void read_line_in_file(FILE* fp, char** line) {
    size_t len = 0;
    ssize_t read;

    if ((read = getline(line, &len, fp)) != -1) {
        if ((*line)[read - 1] == '\n') {
            (*line)[read - 1] = '\0';
            --read;
        }
    }
}

char* encrypt_string(char* password) {
    return crypt(password, SALT);
}

int main(int argc, char **argv) {
    /* If the user has specified a file on the command line then use that.
     * Otherwise use the popular password file.
     */
    char *filename = argc > 1 ? argv[1] : PASSWD_FILE;
    char *line = NULL;
    FILE *fp = open_file(filename);

    do {
        read_line_in_file(fp, &line);
        printf("%s encrypts to: %s\n", line, encrypt_string(line));
    } while (*line != '\0');

    close_file(fp);
    if(line) free(line);
    return 0;
}
