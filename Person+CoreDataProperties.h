//
//  Person+CoreDataProperties.h
//  ZXCoreData
//
//  Created by macmini on 16/3/17.
//  Copyright © 2016年 macmini. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *cardID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Company *company;

@end

NS_ASSUME_NONNULL_END
