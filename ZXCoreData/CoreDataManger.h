//
//  CoreDataManger.h
//  ZXCoreData
//
//  Created by macmini on 16/3/16.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManger : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (id)sharedInstance;

-(void)insertCoreDataTest;
- (void)queryCoreDataTest;
-(void)deleteCoreDataTest;
- (void)updateCoreDataTestWithName:(NSString *)theName;

//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;



@end
