#import "TestPlugin.h"

#ifdef __cplusplus
extern "C"{
#endif

char* alloChar(const char*v){
    char* cNew = (char*)malloc((strlen(v)+1) * sizeof(wchar_t));
    strcpy(cNew, v);
    return cNew;
}

const char* s2c(NSString* v){
    return [v UTF8String];
}

NSString* c2s(const char *v){
    return [NSString stringWithCString: v encoding:NSUTF8StringEncoding];
}

void test_(){
    [TestPlugin Test];
}

long test_long_(long v){
    return (NSInteger)[TestPlugin TestLong:(NSInteger)v];
}

float test_float_(float v){
    return [TestPlugin TestFloat:v];
}

void test_string0_(const char* v){
    NSLog(@"test_string0_[%s]", v);
}

char* test_string_(const char* v){
    NSString *s = [TestPlugin TestString:c2s(v)];
    const char*c = s2c(s);
    char* cNew = alloChar(c);
    return cNew;
}

typedef const char * CSZ;
char* test_string_in_(CSZ& v){
    NSString *s = [TestPlugin TestString:c2s(v)];
    const char*c = s2c(s);
    char* cNew = alloChar(c);
    return cNew;
}

const char* test_string_out_( CSZ& v){
    NSString *s;
    [TestPlugin TestStringOut:&s];
  
    const char *c = s2c(s);
    v = alloChar(c);
    const char* vv = alloChar(c);

    return vv;
}

const char* test_string_ref_(CSZ& v){
    NSString *s = [TestPlugin TestString:c2s(v)];
    [TestPlugin TestStringOut:&s];
    const char*c = s2c(s);

    v = alloChar(c);
    const char* vv = alloChar(c);

    return vv;
}

void test_intarray_(const int* v, int num){
    NSMutableArray *array = [NSMutableArray array];
    for(int i=0; i<num; i++){
        [array addObject:[NSNumber numberWithInteger:(NSInteger)v[i]]];
    }
    
    [TestPlugin TestIntArray:array];
    
}

void test_intarray_ref_(int** v, int* num){
    NSLog(@"Obj-C::test_intarray_ref_");
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"TestArray %d, %d, %d", **v, *(*v+1), (*v)[2]);
    for(int i=0; i<*num; i++){
        [array addObject:[NSNumber numberWithInteger:(NSInteger)((*v)[i])]];
    }

    [TestPlugin TestIntArrayRef:array];
    
    *num = (int)[array count];
    int* r = (int*)malloc((*num) *sizeof(int));
    
    for(int i=0; i<(*num); i++){
        r[i] = (int)[[array objectAtIndex:i] intValue];
    }
    
    NSLog(@"TestArray num=%d %d, %d, %d, %d", *num, *r, *(r+1), *(r+2), r[3]);

    *v = r;
}

void test_intarray_ref2_(int** v, int* num){
    test_intarray_ref_(v,num);
}



void* test_pointer_(void* v){
    return v;
}
void* test_pointer2_get_(int n){
    return 0;
}
int test_pointer2_(void* v){
    return 1;
}

C_Rect* test_rect_(C_Rect* v){
    return [TestPlugin TestRect:v];
}

/*
 [DllImport("__Internal")]
 private static extern void test_intarray_(int[] hoge, int num);
 [DllImport("__Internal")]
 private static extern void test_intarray_ref_(ref int[] hoge, ref int num);
 [DllImport("__Internal")]
 private static extern IntPtr test_pointer_(IntPtr ptr);
 [DllImport("__Internal")]
 private static extern IntPtr test_pointer2_get_(int n);
 [DllImport("__Internal")]
 private static extern int test_pointer2_(IntPtr v);
 [DllImport("__Internal")]
 private static extern CS_Rect test_rect_(CS_Rect v);

 */



#ifdef __cplusplus
}
#endif


@implementation TestPlugin

+ (void)Test{
    NSLog(@"HelloWorld!");
}

+ (NSInteger)TestLong: (NSInteger)v{
    NSLog(@"TestLong %ld", (long)v);
    return v;
}

+ (float)TestFloat: (float)v{
    NSLog(@"TestFloat %f", v);
    return v;
}

+ (NSString*)TestString: (NSString*)v{
    NSLog(@"TestString %@", v);
    return v;
}
+ (NSString*)TestStringIn: (NSString*)v{
    NSLog(@"TestString %@", v);
    return v;
}
+ (NSString*)TestStringOut: (NSString**)v{
    NSString* hoge = @"New String";
    *v = hoge;
    return *v;
}
+ (NSString*)TestStringRef: (NSString**)v{
    [*v stringByAppendingString: @" Ref"];
    return *v;
}

+ (C_Rect*)TestRect: (C_Rect*)v{
    NSLog(@"TestRect %d", v->x);
    
    return v;
}

+ (void)TestIntArray: (NSMutableArray *)v{
    NSLog(@"TestArray %d, %d, %d", [[v objectAtIndex:0] intValue], [[v objectAtIndex:1] intValue], [[v objectAtIndex:2] intValue]);
}

+ (void)TestIntArrayRef: (NSMutableArray *)v{
    [v addObject:[NSNumber numberWithInteger:99]];
}

@end




/*
  #import "ViewController.h"
  ViewController *vwcView;
  void init_()
  {
    vwcView = [[ViewController alloc] init];
    [vwcView initImageView];
  }
  void open_(int intImageNum)
  {
    [vwcView addImageView: intImageNum];
  }
  void close_()
  {
    [vwcView removeImageView];
  }
*/
