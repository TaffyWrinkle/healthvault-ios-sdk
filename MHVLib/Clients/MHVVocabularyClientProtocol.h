//
// MHVVocabularyClientProtocol.h
// HVLib
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

#import "MHVClientProtocol.h"
#import "MHVVocabularyKey.h"
#import "MHVVocabularyCodeItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol for HealthVault vocabulary clients
 */
@protocol MHVVocabularyClientProtocol <MHVClientProtocol>

/**
 * Retrieves a collection of key information for identifying and describing the vocabularies in the system.
 *
 * @param completion A completion block. On success will give an MHVVocabularyKeyCollection. On error will give the error info.
 */
- (void)getVocabularyKeysWithCompletion:(void(^)(MHVVocabularyKeyCollection *_Nullable vocabularyKeys, NSError *_Nullable error))completion;


/**
 * Retrieves lists of vocabulary things for the specified vocabulary in the user's current culture.
 *
 * @param key The key for the vocabulary to fetch.
 * @param cultureIsFixed Healthvault looks for the vocabulary things for the culture info specified by the system. If this parameter is set to NO or is not specified and if things are not found for the specified culture then things for the default fallback culture will be returned. If this parameter is set to YES then fallback will not occur.
 * @param completion A completion block. On success will give the matching MHVVocabularyCodeItem. On error will give the error info.
 */
- (void)getVocabularyWithKey:(MHVVocabularyKey *)key
              cultureIsFixed:(NSNumber *_Nullable)cultureIsFixed
                  completion:(void(^)(MHVVocabularyCodeSet *_Nullable vocabulary, NSError *_Nullable error))completion;


/**
 * Retrieves lists of vocabulary things for the specified vocabularies in the user's current culture.
 *
 * @param vocabularyKeys An array of VocabularyKeys identifying the requested vocabularies.
 * @param cultureIsFixed Healthvault looks for the vocabulary things for the culture info specified by the system. If this parameter is set to NO or is not specified and if things are not found for the specified culture then things for the default fallback culture will be returned. If this parameter is set to YES then fallback will not occur.
 * @param completion A completion block. On success will give one of the specified vocabularies and its things, or empty strings. On error will give the error info.
 */
- (void)getVocabulariesWithVocabularyKeys:(MHVVocabularyKeyCollection *)vocabularyKeys
                           cultureIsFixed:(NSNumber *_Nullable)cultureIsFixed
                               completion:(void(^)(MHVVocabularyCodeSetCollection * _Nullable vocabularies, NSError *_Nullable error))completion;


/**
 * Searches a specific vocabulary and retrieves the matching vocabulary things.
 *
 * @param searchValue The search string to use.
 * @param searchMode The type of search mode to perform.
 * @param vocanularyKey The key to perform the search on.
 * @param maxResults The maximum number of results to return. If null, all matching results are returned, up to a maximum number defined by the service config value with key maxResultsPerVocabularyRetrieval.
 * @param completion A completion block. On success will give a MHVVocabularyCodeSetCollection populated with entries matching the search criteria. On error will give the error info.
 */
- (void)searchVocabularyWithSearchValue:(NSString *)searchValue
                             searchMode:(MHVSearchMode)searchMode
                             vocabularyKey:(MHVVocabularyKey *_Nullable)vocabularyKey
                             maxResults:(NSNumber *_Nullable)maxResults
                             completion:(void(^)(MHVVocabularyCodeSetCollection *_Nullable vocabularyKeys, NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
