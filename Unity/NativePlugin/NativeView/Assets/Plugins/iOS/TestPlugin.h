//
//  TestPlugin.h
//  Unity-iPhone
//
//  Created by 宮竹 祐希 on 2020/03/03.
//

#ifndef TestPlugin_h
#define TestPlugin_h
#import <Foundation/Foundation.h>

typedef struct{
    int x;
    int y;
    int width;
    int height;
} C_Rect;

@interface TestPlugin : NSObject
+ (void)Test;
+ (NSInteger)TestLong: (NSInteger)v;
+ (float)TestFloat: (float)v;
+ (NSString*)TestString: (NSString*)v;
+ (NSString*)TestStringIn: (NSString*)v;
+ (NSString*)TestStringOut: (NSString**)v;
+ (NSString*)TestStringRef: (NSString**)v;

+ (void)TestIntArray: (NSMutableArray*)v;
+ (void)TestIntArrayRef: (NSMutableArray*)v;



+ (C_Rect*)TestRect: (C_Rect*)v;



@end



#endif /* TestPlugin_h */
