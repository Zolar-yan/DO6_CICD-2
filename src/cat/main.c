#include <getopt.h>
#include <stdio.h>

typedef struct opt {
  int b, e, n, s, t, v;
} opt;

int parser(int argc, char *argv[], opt *options);
void output(char *argv[], opt options);

void s21_cat(int b, int e, int n, int s, int t, int v, FILE *fp);

int main(int argc, char *argv[]) {
  int flag = 0;
  opt options = {0};
  flag = parser(argc, argv, &options);
  if (flag == 0) {
    output(argv, options);
  }
  return 0;
}

int parser(int argc, char *argv[], opt *options) {
  int options_index;
  int option;
  static struct option long_options[] = {{"number-nonblank", 0, 0, 'b'},
                                         {"number", 0, 0, 'n'},
                                         {"squeeze", 0, 0, 's'},
                                         {
                                             0,
                                             0,
                                             0,
                                             0,
                                         }};
  while ((option = getopt_long(argc, argv, "+benstvTE", long_options,
                               &options_index)) != -1) {
    if (option == 'b')
      options->b = 1;
    else if (option == 'e') {
      options->e = 1;
      options->v = 1;
    } else if (option == 'n')
      options->n = 1;
    else if (option == 's')
      options->s = 1;
    else if (option == 't') {
      options->t = 1;
      options->v = 1;
    } else if (option == 'v')
      options->v = 1;
    else if (option == 'T')
      options->t = 1;
    else if (option == 'E')
      options->e = 1;
    else {
      fprintf(stderr, "Use: b, e, n, s, t, v, T, E flags");
      return -1;
    }
  }
  return 0;
};

void output(char *argv[], opt options) {
  FILE *fp = fopen(argv[optind], "r");
  if (fp) {
    s21_cat(options.b, options.e, options.n, options.s, options.t, options.v,
            fp);
  } else {
    printf("No file");
  }
  fclose(fp);
}

void s21_cat(int b, int e, int n, int s, int t, int v, FILE *fp) {
  int c, first_c = 0, line_number = 1, last_line = 0, continue_func = 0,
         current_line;
  while ((c = fgetc(fp)) != EOF) {
    if (s && first_c == 0 && c == 10) {
      current_line = 1;
      if (last_line) {
        continue_func = 1;
      }
      if (continue_func == 0) last_line = current_line;
    } else {
      last_line = 0;
    }
    if (continue_func == 0) {
      if (first_c == 0) {
        if (b && c != '\n') {
          printf("%6d\t", line_number++);
        }
        if (n && !b) {
          printf("%6d\t", line_number++);
        }
        first_c = 1;
      }
      if (e && c == '\n') {
        printf("$");
      }
      if (v && c < 32 && c != 9 && c != 10) {
        printf("^%c", c + 64);
      } else if (v && c == 127) {
        printf("^%c", c - 64);
      } else if (t && c == '\t') {
        printf("^I");
      } else {
        printf("%c", c);
      }
      if (c == '\n') {
        first_c = 0;
      }
    }
    continue_func = 0;
  }
}