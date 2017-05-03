//
//  MHVMethodFactory.m
//  MHVLib
//
//  Copyright (c) 2017 Microsoft Corporation. All rights reserved.
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
//
//

#import "MHVCommon.h"
#import "MHVMethodFactory.h"

@implementation MHVMethodFactory

-(MHVGetItemsTask *)newGetItemsForRecord:(MHVRecordReference *)record queries:(MHVItemQueryCollection *)queries andCallback:(HVTaskCompletion)callback
{
    MHVGetItemsTask* task = [MHVGetItemsTask newForRecord:record queries:queries andCallback:callback];
    task.taskName = @"GetItemsForRecord";
    return task;
}

-(MHVPutItemsTask *)newPutItemsForRecord:(MHVRecordReference *)record items:(MHVItemCollection *)items andCallback:(HVTaskCompletion)callback
{
    MHVPutItemsTask* task = [MHVPutItemsTask newForRecord:record items:items andCallback:callback];
    task.taskName = @"PutItemsForRecord";
    return task;
}

-(MHVRemoveItemsTask *)newRemoveItemsForRecord:(MHVRecordReference *)record keys:(MHVItemKeyCollection *)keys andCallback:(HVTaskCompletion)callback
{
    MHVRemoveItemsTask* task = [MHVRemoveItemsTask newForRecord:record keys:keys andCallback:callback];
    task.taskName = @"RemoveItemsForRecord";
    return task;
}

@end

@implementation MHVMethodFactory (HVMethodFactoryExtensions)

-(MHVGetItemsTask *)newGetItemsForRecord:(MHVRecordReference *)record query:(MHVItemQuery *)query andCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(query);
    
    MHVItemQueryCollection* queries = [[MHVItemQueryCollection alloc] init];
    HVCHECK_NOTNULL(queries);
    
    [queries addObject:query];
    
    MHVGetItemsTask* task = [self newGetItemsForRecord:record queries:queries andCallback:callback];
    
    return task;
    
LError:
    return nil;
}

-(MHVPutItemsTask *)newPutItemForRecord:(MHVRecordReference *)record item:(MHVItem *)item andCallback:(HVTaskCompletion)callback
{
    MHVItemCollection* items = [[MHVItemCollection alloc] initWithItem:item];
    HVCHECK_NOTNULL(items);
    
    MHVPutItemsTask* putItems = [self newPutItemsForRecord:record items:items andCallback:callback];
    
    return putItems;
    
LError:
    return nil;
}

@end
