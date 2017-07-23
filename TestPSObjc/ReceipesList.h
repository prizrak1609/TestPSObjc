//
//  ViewController.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceipesList : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ServerDelegate>
@end

NS_ASSUME_NONNULL_END
