//
// MHVSchedule.m
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
//

/**
* NOTE: This class is auto generated by the swagger code generator program.
* https://github.com/swagger-api/swagger-codegen.git
* Do not edit the class manually.
*/


#import "MHVSchedule.h"

@implementation MHVSchedule

+ (BOOL)shouldValidateProperties
{
    return YES;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    // initialize property's default value, if any
    
  }
  return self;
}



+ (NSDictionary *)propertyNameMap
{
    static dispatch_once_t once;
    static NSMutableDictionary *names = nil;
    dispatch_once(&once, ^{
        names = [[super propertyNameMap] mutableCopy];
        [names addEntriesFromDictionary:@{
            @"reminderState": @"reminderState",
            @"scheduledDays": @"scheduledDays",
            @"scheduledTime": @"scheduledTime"
        }];
    });
    return names;
}

+ (NSDictionary *)objectParametersMap
{
    static dispatch_once_t once;
    static NSMutableDictionary *types = nil;
    dispatch_once(&once, ^{
        types = [[super objectParametersMap] mutableCopy];
        [types addEntriesFromDictionary:@{
            @"reminderState": [MHVScheduleReminderStateEnum class],
            @"scheduledDays": [MHVScheduleScheduledDaysEnum class],
            @"scheduledTime": [MHVTime class]

        }];
    });
    return types;
}
@end
@implementation MHVScheduleReminderStateEnum

-(NSDictionary *)enumMap
{
    return @{
        @"Unknown": @"Unknown",
        @"Off": @"Off",
        @"OnTime": @"OnTime",
        @"Before5Minutes": @"Before5Minutes",
        @"Before10Minutes": @"Before10Minutes",
        @"Before15Minutes": @"Before15Minutes",
        @"Before30Minutes": @"Before30Minutes",
        @"Before1Hour": @"Before1Hour",
        @"Before2Hours": @"Before2Hours",
        @"Before4Hours": @"Before4Hours",
        @"Before8Hours": @"Before8Hours",
    };
}

+(MHVScheduleReminderStateEnum *)MHVUnknown
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Unknown"];
}
+(MHVScheduleReminderStateEnum *)MHVOff
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Off"];
}
+(MHVScheduleReminderStateEnum *)MHVOnTime
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"OnTime"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore5Minutes
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before5Minutes"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore10Minutes
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before10Minutes"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore15Minutes
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before15Minutes"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore30Minutes
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before30Minutes"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore1Hour
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before1Hour"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore2Hours
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before2Hours"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore4Hours
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before4Hours"];
}
+(MHVScheduleReminderStateEnum *)MHVBefore8Hours
{
    return [[MHVScheduleReminderStateEnum alloc] initWithString:@"Before8Hours"];
}
@end

@implementation MHVScheduleScheduledDaysEnum

-(NSDictionary *)enumMap
{
    return @{
        @"Unknown": @"Unknown",
        @"Everyday": @"Everyday",
        @"Sunday": @"Sunday",
        @"Monday": @"Monday",
        @"Tuesday": @"Tuesday",
        @"Wednesday": @"Wednesday",
        @"Thursday": @"Thursday",
        @"Friday": @"Friday",
        @"Saturday": @"Saturday",
    };
}

+(MHVScheduleScheduledDaysEnum *)MHVUnknown
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Unknown"];
}
+(MHVScheduleScheduledDaysEnum *)MHVEveryday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Everyday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVSunday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Sunday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVMonday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Monday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVTuesday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Tuesday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVWednesday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Wednesday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVThursday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Thursday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVFriday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Friday"];
}
+(MHVScheduleScheduledDaysEnum *)MHVSaturday
{
    return [[MHVScheduleScheduledDaysEnum alloc] initWithString:@"Saturday"];
}
@end
