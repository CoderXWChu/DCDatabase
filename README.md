# DCDatabase
Use DCDatabase, Just need one code to achieve  cache models.

### 如何安装

安装
==============

### CocoaPods

1. 在 Podfile 中添加  `pod 'DCDatabase'`。
2. 导入 \<DCDatabase/DCDatabase.h\>。


### 手动安装

1. 下载 DCDatabase 文件夹内的所有内容。
2. 将 DCDatabase 内的源文件添加(拖放)到你的工程。
3. 注意:需添加依赖`libsqlite3`.


使用
==============

###保存模型数据到本地数据库

```objc
    // 哪个线程调用，在哪个线程执行
    [[DCDatabase shareInstance] saveToDatabaseWithArray:datas autoRollback:YES];

    // 子线程调用
    [[DCDatabase shareInstance] saveToDatabaseWithArray:datas autoRollback:YES callBack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"保存模型数据到本地数据库成功！:)");
        }else {
            NSLog(@"保存模型数据到本地数据库失败！:(");
        }
    }];

    // 刷新数据库模型数据，将本地数据库模型数据删除后，再执行保存操作
    [[DCDatabase shareInstance] refreshDataWithArray:self.dataSource autoRollback:NO callBack:^(BOOL isFinish) {

    }];

```

###从本地数据库获取模型数据

```objc
    // 获取所有本地数据
    [[DCDatabase shareInstance] getAllWithClassName:NSStringFromClass(DCCourseModel.class) callBack:^(NSArray * _Nullable datas) {

    }];

    // 获取根据模型某属性进行排序后的数据
    [[DCDatabase shareInstance] getDataWithClassName:NSStringFromClass(DCCourseModel.class) attribute:KEYPATH(self.model, createtime) isRise:YES callBack:^(NSArray * _Nullable models) {
        self.tableViewModel.dataSource = [NSMutableArray arrayWithArray:models];
        [self.tableView reloadData];
    }];

```

###删除本地数据库模型数据

```objc

    // 删除所有数据
    [[DCDatabase shareInstance] removeAllWithClassName:NSStringFromClass(DCCourseModel.class) callBack:^(BOOL result) {

    }];

```

#### 更多 API 参照 DCDatabase.h 



许可证
==============
DCDatabase 使用 MIT 许可证，详情见 LICENSE 文件。

