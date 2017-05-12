//
// MHVTypeListViewController.h
// SDKFeatures
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

#import <UIKit/UIKit.h>
#import "MHVTypeViewController.h"
#import "MHVMoreFeatures.h"
#import "MHVFeatureActions.h"
#import "MHVStatusLabel.h"

@interface MHVTypeListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *moreButton;
@property (strong, nonatomic) IBOutlet MHVStatusLabel *statusLabel;

- (IBAction)moreFeatures:(id)sender;

//
// Classes we have demo code for in this app. We display this list in m_tableView
//
+ (NSArray *)classesForTypesToDemo;
//
// Class for the item currently selected in the TableView
//
- (Class)getSelectedClass;

@end