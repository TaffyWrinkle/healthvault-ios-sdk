//
//  MHVPredicate.m
//  Pods
//
//  Created by Nathan Malubay on 6/26/17.
//
//

#import "MHVCacheQuery.h"
#import <objc/runtime.h>
#import "MHVValidator.h"
#import "MHVStringExtensions.h"
#import "MHVArrayExtensions.h"
#import "MHVThingQuery.h"
#import "NSError+MHVError.h"

static NSDictionary *kPropertyMap;
static NSDictionary *kOperatorMap;
static NSDictionary *kIgnoreMap;
static NSString *const kPredicateVariable = @"predicateVariable";

@implementation MHVCacheQuery

+ (void)initialize
{
    kPropertyMap = @{
                     @"thingIDs" : @"thingId",
                     @"thingID" : @"thingId",
                     @"version" : @"version",
                     @"typeIDs" : @"typeId",
                     @"clientIDs" : @"clientId",
                     @"effectiveDateMin" : @"effectiveDate",
                     @"effectiveDateMax" : @"effectiveDate",
                     @"createDateMin" : @"createDate",
                     @"createDateMax" : @"createDate",
                     @"updateDateMin" : @"updateDate",
                     @"updateDateMax" : @"updateDate",
                     @"createdByAppID" : @"createdByAppID",
                     @"createdByPersonID" : @"createdByPersonID",
                     @"updatedByAppID" : @"updatedByAppID",
                     @"updatedByPersonID" : @"updatedByPersonID"
                     };
    
    kOperatorMap = @{
                     @"thingIDs" : @(NSEqualToPredicateOperatorType),
                     @"thingID" : @(NSEqualToPredicateOperatorType),
                     @"version" : @(NSEqualToPredicateOperatorType),
                     @"typeIDs" : @(NSEqualToPredicateOperatorType),
                     @"clientIDs" : @(NSEqualToPredicateOperatorType),
                     @"effectiveDateMin" : @(NSGreaterThanOrEqualToPredicateOperatorType),
                     @"effectiveDateMax" : @(NSLessThanOrEqualToPredicateOperatorType),
                     @"createDateMin" : @(NSGreaterThanOrEqualToPredicateOperatorType),
                     @"createDateMax" : @(NSLessThanOrEqualToPredicateOperatorType),
                     @"updateDateMin" : @(NSGreaterThanOrEqualToPredicateOperatorType),
                     @"updateDateMax" : @(NSLessThanOrEqualToPredicateOperatorType),
                     @"createdByAppID" : @(NSEqualToPredicateOperatorType),
                     @"createdByPersonID" : @(NSEqualToPredicateOperatorType),
                     @"updatedByAppID" : @(NSEqualToPredicateOperatorType),
                     @"updatedByPersonID" : @(NSEqualToPredicateOperatorType)
                     };
    
    kIgnoreMap = @{
                   @"view" : @"ignore",
                   };
}

- (instancetype)initWithQuery:(MHVThingQuery *)query
{
    MHVASSERT_PARAMETER(query);
    
    self = [super init];
    {
        if (self)
        {
            [self setPredicateWithQuery:query];
        }
    }
    
    return self;
}

- (BOOL)canCreateWithQuery:(MHVThingQuery *)query
{
    // If the query is nil we cannot create a predicate
    if (!query)
    {
        _error = [NSError error:[NSError MHVInvalidThingQuery] withDescription:@"MHVThingCacheQuery was initialized with a nil query parameter"];
        return NO;
    }
    
    // The cache does not support xpath predicates
    for (MHVThingFilter *filter in query.filters)
    {
        if (![NSString isNilOrEmpty:filter.xpath])
        {
            return NO;
        }
    }
    
    // The cache only supports MHVThingSection_Standard section
    if (query.view.sections | MHVThingSection_Standard)
    {
        return NO;
    }
    
    if (![NSArray isNilOrEmpty:query.view.transforms.toArray])
    {
        return NO;
    }
    
    if (![NSArray isNilOrEmpty:query.view.typeVersions.toArray])
    {
        return NO;
    }
    
    return YES;
}

- (void)setPredicateWithQuery:(MHVThingQuery *)query
{
    if (![self canCreateWithQuery:query])
    {
        _canQueryCache = [self canCreateWithQuery:query];
        return;
    }
    
    _predicate = [self predicateForObject:query];
    
//    //Create (thingId == X OR thingID == Y) part of the predicate
//    NSMutableArray<NSPredicate *> *thingIdPredicates = [NSMutableArray new];
//    
//    for (NSString *thingId in query.thingIDs)
//    {
//        NSPredicate *predicate = [MHVPredicate predicateWithKeyPath:@"thingId"
//                                                           variable:thingId
//                                                               type:NSEqualToPredicateOperatorType];
//        
//        if (predicate)
//        {
//            [thingIdPredicates addObject:predicate];
//        }
//    }
//    
//    if (thingIdsWhere.count > 0)
//    {
//        //Join all the thingId strings with OR
//        [where addObject:[NSString stringWithFormat:@"(%@)", [thingIdsWhere componentsJoinedByString:@" OR "]]];
//    }
//    
//    //Create ((thingId == X AND version == Y) OR ...) part of the predicate
//    NSMutableArray<NSString *> *thingKeysWhere = [NSMutableArray new];
//    for (MHVThingKey *thingKey in query.keys)
//    {
//        [thingKeysWhere addObject:[NSString stringWithFormat:@"(thingId == '%@' AND version == '%@')", thingKey.thingID, thingKey.version]];
//    }
//    if (thingKeysWhere.count > 0)
//    {
//        //Join all the thingId strings with OR
//        [where addObject:[NSString stringWithFormat:@"(%@)", [thingKeysWhere componentsJoinedByString:@" OR "]]];
//    }
//    
//    //Create (createDate >= 2000-01-01...) part of the predicate
//    for (MHVThingFilter *filter in query.filters)
//    {
//        NSMutableArray<NSString *> *filterWhere = [NSMutableArray new];
//        
//        //Create (typeId == X OR typeId == Y) part of the predicate
//        NSMutableArray<NSString *> *typeIdsWhere = [NSMutableArray new];
//        for (NSString *typeId in filter.typeIDs)
//        {
//            [typeIdsWhere addObject:[NSString stringWithFormat:@"typeId == '%@'", typeId]];
//        }
//        if (typeIdsWhere.count > 0)
//        {
//            //Join all the typeId strings with OR to the filter
//            [filterWhere addObject:[NSString stringWithFormat:@"(%@)", [typeIdsWhere componentsJoinedByString:@" OR "]]];
//        }
//        
//        //Add date and other filters
//        if (filter.effectiveDateMin)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"effectiveDate >= '%@'", filter.effectiveDateMin]];
//        }
//        if (filter.effectiveDateMax)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"effectiveDate <= '%@'", filter.effectiveDateMin]];
//        }
//        if (filter.createDateMin)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"createDate >= '%@'", filter.createDateMin]];
//        }
//        if (filter.createDateMax)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"createDate <= '%@'", filter.createDateMax]];
//        }
//        if (filter.updateDateMin)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"updateDate >= '%@'", filter.updateDateMin]];
//        }
//        if (filter.updateDateMax)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"updateDate <= '%@'", filter.updateDateMax]];
//        }
//        if (filter.createdByAppID)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"createdByAppID == '%@'", filter.createdByAppID]];
//        }
//        if (filter.createdByPersonID)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"createdByPersonID == '%@'", filter.createdByPersonID]];
//        }
//        if (filter.updatedByAppID)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"updatedByAppID == '%@'", filter.updatedByAppID]];
//        }
//        if (filter.updatedByPersonID)
//        {
//            [filterWhere addObject:[NSString stringWithFormat:@"updatedByPersonID == '%@'", filter.updatedByPersonID]];
//        }
//        
//        //Join all the where strings with AND
//        [where addObject:[NSString stringWithFormat:@"(%@)", [filterWhere componentsJoinedByString:@" AND "]]];
//    }
//    
//    //Join all the predicate parts with AND
//    return [NSPredicate predicateWithFormat:[where componentsJoinedByString:@" AND "]];
}

- (NSPredicate *)predicateWithPropertyName:(NSString *)propertyName
                                  variable:(NSObject *)variable
{
 
    NSNumber *operator = kOperatorMap[propertyName];
    NSString *keyPath = kPropertyMap[propertyName];
    
    if (!variable || !operator || kIgnoreMap[propertyName])
    {
        return nil;
    }
    
    NSPredicate *predicateTemplate = [NSComparisonPredicate
                                      predicateWithLeftExpression:[NSExpression expressionForKeyPath:keyPath]
                                      rightExpression:[NSExpression expressionForVariable:kPredicateVariable]
                                      modifier:NSDirectPredicateModifier
                                      type:operator.unsignedIntegerValue
                                      options:NSCaseInsensitivePredicateOption];
    
    return [predicateTemplate predicateWithSubstitutionVariables:@{
                                                                   kPredicateVariable : variable
                                                                   }];
}

- (NSPredicate *)predicateWithPropertyName:(NSString *)propertyName
                                 variables:(MHVCollection *)variables
{
    if ([NSArray isNilOrEmpty:variables.toArray])
    {
        return nil;
    }
    
    NSMutableArray<NSPredicate *> *predicates = [NSMutableArray new];
    
    for (NSString *variable in variables)
    {
        NSPredicate *predicate = [self predicateWithPropertyName:propertyName
                                                        variable:variable];
        
        if (predicate)
        {
            [predicates addObject:predicate];
        }
    }
    
    if (predicates.count < 1)
    {
        return nil;
    }
    
    return [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
}

- (NSPredicate *)predicateForObject:(NSObject *)object
{
    NSMutableArray<NSPredicate *> *predicates = [NSMutableArray new];
    
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i)
    {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        if (propertyName)
        {
            id value = [object valueForKey:propertyName];
            
            if ([propertyName isEqualToString:@"maxResults"])
            {
                _fetchLimit = (NSUInteger)value;
                
                continue;
            }
            
            NSPredicate *predicate = nil;
            
            Class propertyClass;
            
            const char *type = property_getAttributes(property);
            NSString *typeString = [NSString stringWithUTF8String:type];
            NSArray *attributes = [typeString componentsSeparatedByString:@","];
            NSString *typeAttribute = [attributes objectAtIndex:0];
            
            if ([typeAttribute hasPrefix:@"T@"])
            {
                NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
                propertyClass = NSClassFromString(typeClassName);
            }
            
            
            if ([propertyClass isSubclassOfClass:[MHVCollection class]])
            {
                predicate = [self predicateWithPropertyName:propertyName
                                                  variables:value];
            }
            else if ([propertyClass isKindOfClass:[MHVThingFilter class]])
            {
                predicate = [self predicateForObject:value];
            }
            else
            {
                predicate = [self predicateWithPropertyName:propertyName
                                                   variable:value];
            }
            
            if (predicate)
            {
                [predicates addObject:predicate];
            }
        }
    }
    
    free(properties);
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
}

@end
