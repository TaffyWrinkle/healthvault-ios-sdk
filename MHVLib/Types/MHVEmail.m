//
// MHVEmail.m
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
#import "MHVEmail.h"

static NSString *const c_element_description = @"description";
static NSString *const c_element_isPrimary = @"is-primary";
static NSString *const c_element_address = @"address";

@implementation MHVEmail

- (instancetype)initWithEmailAddress:(NSString *)email
{
    self = [super init];
    if (self)
    {
        _address = [[MHVEmailAddress alloc] initWith:email];
        MHVCHECK_NOTNULL(_address);
    }
    return self;
}

- (NSString *)description
{
    return [self toString];
}

- (NSString *)toString
{
    return (self.address) ? self.address.value : c_emptyString;
}

+ (MHVVocabIdentifier *)vocabForType
{
    return [[MHVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"email-types"];
}

- (MHVClientResult *)validate
{
    MHVVALIDATE_BEGIN

    MHVVALIDATE(self.address, MHVClientError_InvalidEmail);

    MHVVALIDATE_SUCCESS
}

- (void)serialize:(XWriter *)writer
{
    [writer writeElement:c_element_description value:self.type];
    [writer writeElement:c_element_isPrimary content:self.isPrimary];
    [writer writeElement:c_element_address content:self.address];
}

- (void)deserialize:(XReader *)reader
{
    self.type = [reader readStringElement:c_element_description];
    self.isPrimary = [reader readElement:c_element_isPrimary asClass:[MHVBool class]];
    self.address = [reader readElement:c_element_address asClass:[MHVEmailAddress class]];
}

@end

@implementation MHVEmailCollection

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.type = [MHVEmail class];
    }
    return self;
}

- (MHVEmail *)itemAtIndex:(NSUInteger)index
{
    return (MHVEmail *)[self objectAtIndex:index];
}

@end
