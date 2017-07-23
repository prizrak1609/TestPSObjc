//
//  Server.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "Server.h"
#import "Database.h"
#import "RecipeModel.h"
@import AFNetworking;

@interface Server ()
@property(nonatomic, weak) id<ServerDelegate> delegate;
@end

@implementation Server {
    Database *_database;
    NSString *_baseURLPath;
}

@synthesize delegate = _delegate;

- (instancetype)initWithDelegate:(id<ServerDelegate>)delegate {
    self = [super init];
    if(self) {
        _delegate = delegate;
        _baseURLPath = @"http://www.recipepuppy.com/api/";
        _database = [[Database alloc] init];
        NSError *const error = [_database openOrCreate];
        if(error) {
            [_delegate errorWithNSError:error];
        }
    }
    return self;
}

- (void)searchText:(ServerRecipeModelsArrayCompletion)completion {
    [self searchText:@"" completion:completion];
}

- (void)searchText:(NSString *)text completion:(ServerRecipeModelsArrayCompletion)completion {
    NSError *error;
    completion([_database getAllRecipesWithError:&error]);
    if(error) {
        [_delegate errorWithNSError:error];
        return;
    }
    NSDictionary *parameters;
    if(text.length == 0) {
        parameters = @{@"i" : @"onions,garlic", @"q" : @"omelet", @"p" : @"3"};
    } else {
        parameters = @{@"q" : text};
    }
    NSMutableURLRequest *const request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                       URLString:_baseURLPath
                                                                                      parameters:parameters
                                                                                           error:nil];
    __weak typeof(self) const weakSelf = self;
    NSURLSessionDataTask *const dataTask = [[AFHTTPSessionManager manager] dataTaskWithRequest:request
                                                                             completionHandler:
                                            ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                __strong typeof(weakSelf) const strongSelf = weakSelf;
                                                if(error) {
                                                    [strongSelf.delegate errorWithNSError:error];
                                                } else {
                                                    NSArray<id> *const resultArray = [responseObject objectForKey:@"results"];
                                                    NSMutableArray<RecipeModel *> *const result = [[NSMutableArray alloc] init];
                                                    for(id jsonItem in resultArray) {
                                                        RecipeModel *model = [[RecipeModel alloc] initFromJSON:jsonItem];
                                                        [result addObject:model];
                                                    }
                                                    NSError *error = [strongSelf->_database deleteRecipes];
                                                    if(error) {
                                                        [strongSelf.delegate errorWithNSError:error];
                                                    }
                                                    error = [strongSelf->_database createRecipes:result];
                                                    if(error) {
                                                        [strongSelf.delegate errorWithNSError:error];
                                                    }
                                                    completion(result);
                                                }
                                            }];
    [dataTask resume];
}

@end
