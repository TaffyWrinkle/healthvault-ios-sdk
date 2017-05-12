//
// MHVBlock.h
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

// --------------------------------------
//
// Standard Lambda definitions
//
// --------------------------------------
typedef void (^MHVAction) (void);
typedef BOOL (^MHVPredicate) (void);
typedef void (^MHVNotify) (id sender);
typedef BOOL (^MHVHandler) (id value);
typedef BOOL (^MHVFilter) (id value);
typedef id (^MHVFunc) (id value);
typedef id (^MHVFactory) (id key);


void safeInvokeAction(MHVAction action);
void safeInvokeActionInMainThread(MHVAction action);
void safeInvokeActionEx(MHVAction action, BOOL useMainThread);
BOOL safeInvokePredicate(MHVPredicate predicate);
void safeInvokeNotify(MHVNotify notify, id sender);
BOOL safeInvokeHandler(MHVHandler handler, id value);