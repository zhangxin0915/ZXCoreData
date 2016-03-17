//
//  Company+CoreDataProperties.h
//  ZXCoreData
//
//  Created by macmini on 16/3/17.
//  Copyright © 2016年 macmini. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END
