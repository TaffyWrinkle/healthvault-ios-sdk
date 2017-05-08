//
// ItemDataTyped.h
// MHVLib
//
// Copyright (c) 2017 Microsoft Corporation. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import "MHVType.h"

@class MHVTypeSystem;

// -------------------------
//
// All Objective C equivalents of HealthVault types inherit
// from MHVItemDataTyped
//
// -------------------------
@interface MHVItemDataTyped : MHVType

// -------------------------
//
// Data
//
// -------------------------
@property (readonly, nonatomic, strong) NSString *rootElement;
@property (readonly, nonatomic, strong) NSString *type;
//
// Some types may contain RAW xml that requires further parsing
// e.g. CCR & CCD
//
@property (readonly, nonatomic) BOOL hasRawData;
@property (readonly, nonatomic) BOOL isSingleton;

- (NSDate *)getDate;
- (NSDate *)getDateForCalendar:(NSCalendar *)calendar;

+ (NSString *)typeID;
+ (NSString *)XRootElement;
- (NSString *)typeName;

+ (BOOL)isSingletonType;

@end

// -------------------------
//
// Object that maps HealthVault type information to Objective-C
//
// -------------------------
@interface MHVTypeSystem : NSObject

+ (MHVTypeSystem *)current;

- (MHVItemDataTyped *)newFromTypeID:(NSString *)typeID;
- (Class)getClassForTypeID:(NSString *)typeID;
- (NSString *)getTypeIDForClassName:(NSString *)name;
- (BOOL)addClass:(Class)class forTypeID:(NSString *)typeID;

@end
