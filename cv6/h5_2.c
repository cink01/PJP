/* Recursive Descent Parser */
 
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>


char buffer[30];	//vstupni retezec
int i=0;		//index ve vstupnim retezci

void S();
void E();
void E1();
void T();
void T1();
void F();
void A();


 void S()
  {
    printf("\nS -> A = E");
    A();
    if(buffer[i]=='=')
   {
     printf("\nterminal =");
     i++;
     E();
   }
   else
  {
    printf("\nError v S\n");
    exit(0);
  }
}
 
 
  void A()
    {
       if(isalpha(buffer[i]))
 {
    printf("\nterminal %c",buffer[i]);
    i++;
 }
 else
 {
printf("\nError v A\n");
exit(0);
 }
    }
 
 
 
void E()
   {
     printf("\nE -> T E1");
     T();
     E1();
   }
 
void  E1()
   {
      if(buffer[i]=='+')
{
   printf("\nE1 -> +T E1");
   printf("\nterminal +");
   i++;
   T();
   E1();
}
      else
{
//printf("\nBacktrack as input symbol %c is not matching with +",buffer[i]);
printf("\nE1 -> <epsilon>");
 
}
   }
 
void T()
   {
     printf("\nT -> F T1");
     F();
     T1();
   }
 
 void  T1()
   {
      if(buffer[i]=='*')
{
   printf("\nT1 -> *F T1");
   printf("\nterminal *");
   i++;
   F();
   T1();
}
      else
{
//printf("\nBacktrack as input symbol %c is not matching with *",buffer[i]);
printf("\nT1 -> <epsilon>");
}
   }
 
void F()
  {
    printf("\nF -> ( E )");
    if(buffer[i]=='(')
     {
       printf("\nterminal (");
       i++;
       E();
   if(buffer[i]==')')
     {
       printf("\nterminal )");
       i++;
     }
    else
     {
       printf("\nError NESPAROVANE ZAVORKY v F\n");
       exit(0);
     }
    return;
   }

 
if(buffer[i]=='a')
{
//printf("\nBacktrack as input symbol %c is not matching with (E)",buffer[i]);
printf("\nF -> a");
     printf("\nterminal a");
     i++;
     return;
}
       if(buffer[i]=='b')
{
//     printf("\nBacktrack as input symbol %c is not matching with a",buffer[i]);
printf("\nF -> b");
     printf("\nterminal b");
     i++;
     return;
}
 
       printf("\nError SPATNY ARGUMENT v F\n");
       exit(0);
 
   }
 
 
void main()
 {
/*   printf("\nGrammer:- ");
   printf("\n\n S -> A=E");
   printf("\nA-> [a-z]");
   printf("\nE-> T E1");
   printf("\nT-> F T1");
   printf("\nE1-> + T E1 | ~");
   printf("\nT1-> * F T1 | ~");
   printf("\nF-> (E) | a | b");
*/
   printf("\n\nZadejte vstupni retezec:");
//   gets(buffer);
fgets(buffer, 30, stdin);
puts(buffer);	
   S();
 //  if(buffer[i]=='\0')
printf("\n\nOK, aktualni vstup je generovan zadanou gramatikou.\n");
//   else
//printf("\n\nCHYBA, vstupni retezec nepatri do zadane gramatiky!\n");
}
