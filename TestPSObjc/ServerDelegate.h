//
//  ServerDelegate.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerDelegate <NSObject>
- (void)errorWithNSError:(NSError *)error;
@end
