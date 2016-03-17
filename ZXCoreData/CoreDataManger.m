//
//  CoreDataManger.m
//  ZXCoreData
//
//  Created by macmini on 16/3/16.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "CoreDataManger.h"
#import "Person.h"
#import "Company.h"

@implementation CoreDataManger

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "susu.ZXCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZXCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZXCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma makr - 增删改查
//插入数据
-(void)insertCoreDataTest
{
    NSManagedObjectContext *context = [self managedObjectContext];
    for (int i = 0 ; i < 10; i ++) {
            Person *person =  [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
            person.name = [NSString stringWithFormat:@"张新%d",i];
            person.cardID = [NSString stringWithFormat:@"2016%f",@(i + 1000).floatValue];
            person.age = @(20 + i);
            Company *company = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
            company.companyName = @"汉弘";
            person.company = company;
        }
        NSError *error;
        if(![context save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
}
// 查询数据
- (void)queryCoreDataTest
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchedObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[Person class]]) {
            Person *per = (Person *)obj;
            NSLog(@"per.name == %@ \n per.age ==  %d \n per.cardID ==  %@",per.name,per.age.integerValue,per.cardID);
        }
    }];
}
 //删除数据
 -(void)deleteCoreDataTest
 {
     NSManagedObjectContext *context = [self managedObjectContext];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];

     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setIncludesPropertyValues:NO];
     [request setEntity:entity];
     NSError *error = nil;
     NSArray *datas = [context executeFetchRequest:request error:&error];
     if (!error && datas && [datas count])
     {
         for (NSManagedObject *obj in datas)
         {
             [context deleteObject:obj];
         }
         if (![context save:&error])
         {
             NSLog(@"error:%@",error);
         }
     }
 }
//更新数据
 - (void)updateCoreDataTest
 {
    
 }

// //插入数据
// - (void)insertCoreData:(NSMutableArray*)dataArray
// {
//     NSManagedObjectContext *context = [self managedObjectContext];
//     for (News *info in dataArray) {
//     News *newsInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
//     newsInfo.newsid = info.newsid;
//     newsInfo.title = info.title;
//     newsInfo.imgurl = info.imgurl;
//     newsInfo.descr = info.descr;
//     newsInfo.islook = info.islook;
//     
//     NSError *error;
//     if(![context save:&error])
//     {
//     NSLog(@"不能保存：%@",[error localizedDescription]);
//     }
//     }
// }

 //查询
// - (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage
// {
//     NSManagedObjectContext *context = [self managedObjectContext];
//     
//     // 限定查询结果的数量
//     //setFetchLimit
//     // 查询的偏移量
//     //setFetchOffset
//     
//     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//     
//     [fetchRequest setFetchLimit:pageSize];
//     [fetchRequest setFetchOffset:currentPage];
//     
//     NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
//     [fetchRequest setEntity:entity];
//     NSError *error;
//     NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//     NSMutableArray *resultArray = [NSMutableArray array];
//     
//     for (News *info in fetchedObjects) {
//     NSLog(@"id:%@", info.newsid);
//     NSLog(@"title:%@", info.title);
//     [resultArray addObject:info];
//     }
//     return resultArray;
// }


// //删除
// -(void)deleteData
// {
//     NSManagedObjectContext *context = [self managedObjectContext];
//     NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
//     
//     NSFetchRequest *request = [[NSFetchRequest alloc] init];
//     [request setIncludesPropertyValues:NO];
//     [request setEntity:entity];
//     NSError *error = nil;
//     NSArray *datas = [context executeFetchRequest:request error:&error];
//     if (!error && datas && [datas count])
//     {
//     for (NSManagedObject *obj in datas)
//     {
//     [context deleteObject:obj];
//     }
//     if (![context save:&error])
//     {
//     NSLog(@"error:%@",error);
//     }
//     }
// }

 //更新
// - (void)updateData:(NSString*)newsId  withIsLook:(NSString*)islook
// {
//     NSManagedObjectContext *context = [self managedObjectContext];
//     
//     NSPredicate *predicate = [NSPredicate
//     predicateWithFormat:@"newsid like[cd] %@",newsId];
//     
//     //首先你需要建立一个request
//     NSFetchRequest * request = [[NSFetchRequest alloc] init];
//     [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
//     [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
//     
//     //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
//     NSError *error = nil;
//     NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
//     for (News *info in result) {
//     info.islook = islook;
//     }
//     
//     //保存
//     if ([context save:&error]) {
//     //更新成功
//     NSLog(@"更新成功");
//     }
// }


@end
