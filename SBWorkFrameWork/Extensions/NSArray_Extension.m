//
//  NSArray_Extension.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/16.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "NSArray_Extension.h"

@implementation NSArray(NSArray_Extension)

//去重
-(NSArray *)clearRepeat{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSNumber *number in self) {
        [dict setObject:number forKey:number];
    }
    return [dict allKeys];
}

//逆序
-(NSArray *)descAry{
    //模型比较才有用
//    NSArray *arr = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//        NSComparisonResult result = [obj1 compare:obj2];
//        return result==NSOrderedDescending;
//    }];
    
    
    return [[self reverseObjectEnumerator] allObjects];
}

@end
