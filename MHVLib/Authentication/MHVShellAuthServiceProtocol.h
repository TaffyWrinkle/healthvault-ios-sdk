//
//  MHVShellAuthServiceProtocol.h
//  MHVLib
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

@class UIViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol MHVShellAuthServiceProtocol <NSObject>

- (void)provisionApplicationWithViewController:(UIViewController *_Nullable)viewController
                                      shellUrl:(NSURL *)shellUrl
                                   masterAppId:(NSUUID *)masterAppId
                              appCreationToken:(NSString *)appCreationToken
                                 appInstanceId:(NSUUID *)appInstanceId
                                    completion:(void (^)(NSString *_Nullable instanceId, NSError *_Nullable error))completion;

- (void)authorizeAdditionalRecordsWithViewController:(UIViewController *_Nullable)viewController
                                            shellUrl:(NSURL *)shellUrl
                                         masterAppId:(NSUUID *)masterAppId
                                          completion:(void (^_Nullable)(NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
