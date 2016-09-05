//
//  ViewController.m
//  DEMO-DCDatabase
//
//  Created by DanaChu on 16/9/5.
//  Copyright © 2016年 DanaChu. All rights reserved.
//

#import "ViewController.h"
#import "DCDatabase.h"
#import "DCCache.h"
#import "Person.h"


#define PersonClass NSStringFromClass(Person.class)

@interface ViewController ()
@property (nonatomic, assign) NSUInteger i; ///< <#注释#>
@property (nonatomic, strong) Person *p; ///< <#注释#>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 多用户情况下，首次使用 DCDatabase 时调用此方法，比如可以在用户登录后调用。
    [DCDatabase shareInstanceWithUserName:@"Username1"];
    
    
    //switch
    //************************begain***********************
     [self insertData];
     
     [self getData];
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self insertData];
     });
     
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self insertData];
     });
     
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self updateData];
     });
     
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self removeWithCondition];
     });
     
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self insertData];
     });
     
     [self updateData];
     
     [self getData];
     
     NSLog(@"wozuixian");
     
     /*/ // **********************end************************/
    
    NSArray *arr = @[@"我第一", @"你第二", @"他第三"];
    [DCCache setObject:arr forKey:@"arr"];
    NSArray *getArr = [DCCache objectForKey:@"arr"];
    NSLog(@"getArr = %@", getArr);
    
    
    NSDictionary *dict = @{@"1":@"我第一", @"2": @"你第二", @"3":@"他第三"};
    [DCCache setObject:dict forKey:@"dict"];
    NSArray *getDict= [DCCache objectForKey:@"dict"];
    NSLog(@"getDict = %@", getDict);
    
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"test.plist" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    [DCCache setFile:data forKey:@"file"];
    DCCacheItem *item = [DCCache fileItemForKey:@"file"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"test1.plist"];
    [item.data writeToFile:path atomically:YES];
    NSDictionary *testArr = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSLog(@"testPlist = %@", testArr);
    
    
    
    //    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"test1.plist"];
    //    [item.data writeToFile:path atomically:YES];
    //    NSArray *testArr = [NSJSONSerialization JSONObjectWithData:item.data options:kNilOptions error:nil];
    //    NSLog(@"testPlist = %@", testArr);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self deleteTableWithNum:12];
    });
}

- (void)deleteTableWithNum:(NSUInteger)i
{
    [ShareDCDatabase deleteTableWithClassName:PersonClass callBack:^(BOOL result) {
        NSLog(@"%@", result ?@"删除表格成功":@"删除表格失败");
    }];
}

- (void)getData
{
    [ShareDCDatabase getAllWithClassName:PersonClass];
    [ShareDCDatabase getAllWithClassName:PersonClass callBack:^(NSArray * _Nonnull datas) {
        
        NSLog(@"datas.count = %ld",datas.count);
        
        NSLog(@"Person.count = %ld", [ShareDCDatabase dataRowsWithClassName:PersonClass]);
        
        for (Person *c in datas) {
            if(!c.data){
                NSLog(@"%@", c);
            }
            NSLog(@" +++++++++++ \n age = %lu, \n isBoy = %d, \n name = %@, \n dogsNum = %d, \n catNum = %ld, \n  score = %f , \n friends = %@, \n info = %@, \n data = %@ " , (unsigned long)c.age, c.isBoy, c.name, c.dogsNum, (long)c.catNum, c.score, c.friends, c.info, [[NSString alloc]initWithData:c.data encoding:NSUTF8StringEncoding]);
        }
        //
        
        /*
         Person *p1 = [[Person alloc]init];
         p1.isBoy = YES;
         p1.name = @"褚小伟";
         p1.age = arc4random_uniform(27);
         p1.dogsNum = 5;
         p1.catNum = 3;
         p1.score = 99.5;
         p1.friends = @[@"张三", @"李四", @"王五"];
         p1.info = @{@"isAKey":@"哈哈"};
         p1.data = [@"woshidata" dataUsingEncoding:NSUTF8StringEncoding];
         _p = p1;
         */
    }];
    
    [ShareDCDatabase saveToDatabaseWithArray:@[_p] autoRollback:YES callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"获取数据成功");
        }else {
            NSLog(@"获取数据失败");
        }
    }];
    
}

- (void)removeWithCondition
{
    BOOL finish = [ShareDCDatabase removeDataWithClassName:PersonClass condition:@"age < 10"];
    if (finish) {
        NSLog(@"移除数据成功");
    }else {
        NSLog(@"移除数据失败");
    }
    [ShareDCDatabase removeDataWithClassName:PersonClass condition:@"age < 10" callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"移除数据成功");
        }else {
            NSLog(@"移除数据失败");
        }
    }];
    
}

- (void)removeAll{
    [ShareDCDatabase removeAllWithClassName:PersonClass];
    [ShareDCDatabase removeAllWithClassName:PersonClass callBack:^(BOOL result) {
        NSLog(@"%@",result ? @"删除成功" : @"删除失败");
    }];
}

- (void)insertData
{
    Person *p1 = [[Person alloc]init];
    p1.isBoy = YES;
    p1.name = @"王小明";
    p1.age = arc4random_uniform(27);
    p1.dogsNum = 5;
    p1.catNum = 3;
    p1.score = 99.5;
    p1.friends = @[@"张三", @"李四", @"王五"];
    p1.info = @{@"isAKey":@"哈哈"};
    p1.data = [@"woshidata" dataUsingEncoding:NSUTF8StringEncoding];
    _p = p1;
    
    BOOL finish = [ShareDCDatabase saveToDatabaseWithObject:_p];
    if (finish) {
        NSLog(@"保存数据成功");
    }else {
        NSLog(@"保存数据失败");
    }
    [ShareDCDatabase saveToDatabaseWithObject:_p callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"保存数据成功");
        }else {
            NSLog(@"保存数据失败");
        }
    }];
    BOOL isFinish =  [ShareDCDatabase saveToDatabaseWithArray:@[_p] autoRollback:YES];
    if (isFinish) {
        NSLog(@"保存数据成功");
    }else {
        NSLog(@"保存数据失败");
    }
    [ShareDCDatabase saveToDatabaseWithArray:@[_p] autoRollback:YES callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"保存数据成功");
        }else {
            NSLog(@"保存数据失败");
        }
    }];
}

- (void)updateData
{
    BOOL finish = [ShareDCDatabase updateDataWithClassName:PersonClass attribute:@"catNum" toValue:@"4" condition:@"age == 25"];
    if (finish) {
        NSLog(@"更新数据成功");
    }else {
        NSLog(@"更新数据失败");
    }
    [ShareDCDatabase updateDataWithClassName:PersonClass attribute:@"catNum" toValue:@"12" condition:@"age == 16" callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"更新数据成功");
        }else {
            NSLog(@"更新数据失败");
        }
    }];
}

@end
