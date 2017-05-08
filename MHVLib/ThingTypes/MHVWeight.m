//
// Weight.m
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

#import "MHVCommon.h"
#import "MHVWeight.h"

static NSString *const c_typeid = @"3d34d87e-7fc1-4153-800f-f56592cb0d17";
static NSString *const c_typename = @"weight";

static const xmlChar *x_element_when = XMLSTRINGCONST("when");
static const xmlChar *x_element_value = XMLSTRINGCONST("value");

@implementation MHVWeight

- (double)inPounds
{
    return (self.value) ? self.value.inPounds : NAN;
}

- (void)setInPounds:(double)inPounds
{
    MHVENSURE(self.value, MHVWeightMeasurement);
    self.value.inPounds = inPounds;
}

- (void)setInKg:(double)inKg
{
    MHVENSURE(self.value, MHVWeightMeasurement);
    self.value.inKg = inKg;
}

- (double)inKg
{
    return (self.value) ? self.value.inKg : NAN;
}

- (instancetype)initWithKg:(double)kg andDate:(NSDate *)date
{
    MHVCHECK_NOTNULL(date);

    self = [super init];
    if (self)
    {
        _value = [[MHVWeightMeasurement alloc] initWithKg:kg];
        MHVCHECK_NOTNULL(_value);

        _when = [[MHVDateTime alloc] initWithDate:date];
        MHVCHECK_NOTNULL(_when);
    }

    return self;
}

- (instancetype)initWithPounds:(double)pounds andDate:(NSDate *)date
{
    MHVCHECK_NOTNULL(date);

    self = [super init];
    if (self)
    {
        _value = [[MHVWeightMeasurement alloc] initWithPounds:pounds];
        MHVCHECK_NOTNULL(_value);

        _when = [[MHVDateTime alloc] initWithDate:date];
        MHVCHECK_NOTNULL(_when);
    }

    return self;
}

- (NSDate *)getDate
{
    return [self.when toDate];
}

- (NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [self.when toDateForCalendar:calendar];
}

- (NSString *)stringInPounds
{
    return [self stringInPoundsWithFormat:@"%.2f"];
}

- (NSString *)stringInKg
{
    return [self stringInKgWithFormat:@"%.3f"];  // 3rd place precision to support Grams
}

- (NSString *)stringInPoundsWithFormat:(NSString *)format
{
    return (self.value) ? [self.value stringInPounds:format] : c_emptyString;
}

- (NSString *)stringInKgWithFormat:(NSString *)format
{
    return (self.value) ? [self.value stringInKg:format] : c_emptyString;
}

- (NSString *)toString
{
    return (self.value) ? [self.value toString] : c_emptyString;
}

- (NSString *)description
{
    return [self toString];
}

- (MHVClientResult *)validate
{
    MHVVALIDATE_BEGIN;

    MHVVALIDATE(self.when, MHVClientError_InvalidWeight);
    MHVVALIDATE(self.value, MHVClientError_InvalidWeight);

    MHVVALIDATE_SUCCESS;
}

- (void)serialize:(XWriter *)writer
{
    [writer writeElementXmlName:x_element_when content:self.when];
    [writer writeElementXmlName:x_element_value content:self.value];
}

- (void)deserialize:(XReader *)reader
{
    self.when = [reader readElementWithXmlName:x_element_when asClass:[MHVDateTime class]];
    self.value = [reader readElementWithXmlName:x_element_value asClass:[MHVWeightMeasurement class]];
}

+ (NSString *)typeID
{
    return c_typeid;
}

+ (NSString *)XRootElement
{
    return c_typename;
}

+ (MHVItem *)newItem
{
    return [[MHVItem alloc] initWithType:[MHVWeight typeID]];
}

+ (MHVItem *)newItemWithKg:(double)kg andDate:(NSDate *)date
{
    MHVWeight *weight = [[MHVWeight alloc] initWithKg:kg andDate:date];

    MHVCHECK_NOTNULL(weight);

    MHVItem *item = [[MHVItem alloc] initWithTypedData:weight];

    return item;
}

+ (MHVItem *)newItemWithPounds:(double)pounds andDate:(NSDate *)date
{
    MHVWeight *weight = [[MHVWeight alloc] initWithPounds:pounds andDate:date];

    MHVCHECK_NOTNULL(weight);

    MHVItem *item = [[MHVItem alloc] initWithTypedData:weight];

    return item;
}

- (NSString *)typeName
{
    return NSLocalizedString(@"Weight", @"Weight Type Name");
}

@end
