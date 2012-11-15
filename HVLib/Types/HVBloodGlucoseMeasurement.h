//
//  HVBloodGlucoseMeasurement.h
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
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
#import "HVType.h"
#import "HVPositiveDouble.h"
#import "HVDisplayValue.h"
#import "HVConcentrationValue.h"

@interface HVBloodGlucoseMeasurement : HVType
{
@private
    HVPositiveDouble* m_mmolPerl;
    HVDisplayValue* m_display;
}

//
// Required
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* value;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue *display;

@property (readwrite, nonatomic) double mmolPerLiter;
@property (readwrite, nonatomic) double mgPerDL;

-(id) initWithMmolPerLiter:(double) value;
-(id) initWithMgPerDL:(double) value;

-(BOOL) updateDisplayValue:(double) displayValue units:(NSString *) unitValue andUnitsCode:(NSString *)code;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

+(double) mgPerDLToMmolPerLiter:(double) value;
+(double) mMolPerLiterToMgPerDL:(double) value;

@end
