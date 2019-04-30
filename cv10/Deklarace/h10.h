#define NSYMS 20	/* maximum number of symbols */

struct symtab
{
  char *name;
  int type;
} symtab[NSYMS];
/*
struct printparam
{
  int number;
  char *string;
  struct printparam *next;
};
 */
void freebuffer();
