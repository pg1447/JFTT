#define NOEMPTY -1233
#define EMPTY -1234
#define TRUE 1
#define FALSE 0

struct elem{
        int value;
        struct elem* next;
};

struct stack{
        struct elem* top;
};

void pop(struct stack* st, int x);
int push(struct stack* st);
int count(struct stack* st, char c);
int isEmpty(struct stack* st);
int my_pow(int a, int b);
void get_result(struct stack* st);
void cleanStack(struct stack* st);
void handleError(struct stack* st, const char* msg);
