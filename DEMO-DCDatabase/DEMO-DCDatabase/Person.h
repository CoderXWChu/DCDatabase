//
//  Person.h
//
//  Created by xiaoweiChu on 15/2/04.
//  Copyright © 2015年 xiaoweiChu. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "NSObject+Database.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name; ///< xingming
@property (nonatomic, assign) BOOL isBoy; ///< 男孩
@property (nonatomic, assign) int dogsNum; ///< 够数量
@property (nonatomic, assign) NSInteger catNum; ///< 猫数量
@property (nonatomic, assign) NSUInteger age; ///< nianling
@property (nonatomic, assign) double score; ///< fenshu
@property (nonatomic, strong) NSArray *friends; ///< pengyou
@property (nonatomic, strong) NSDictionary *info; ///< 信息
@property (nonatomic, strong) NSData *data; ///<  数据
@property (nonatomic, strong) NSString *noNeed; ///< 不需要保存

@end
