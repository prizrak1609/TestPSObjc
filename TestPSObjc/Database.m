//
//  Database.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "Database.h"
#import <sqlite3.h>

@implementation Database {
    NSString *_dbPath;
    sqlite3 *_database;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        NSURL *url = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
        if(url) {
            url = [url URLByAppendingPathComponent:@"testps.db"];
            _dbPath = url.absoluteString;
        } else {
            _dbPath = @"";
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(_database);
}

- (nullable NSError *)openOrCreate {
    if(sqlite3_open(_dbPath.UTF8String, &_database) != SQLITE_OK) {
        return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
    }
    sqlite3_stmt *createTable;
    NSString *const createReceipesString = @"create table if not exists recipes ( title text NOT NULL, href text NOT NULL, ingredients text NOT NULL, thumbnail text NOT NULL );";
    if(sqlite3_prepare_v2(_database, createReceipesString.UTF8String, -1, &createTable, nil) == SQLITE_OK) {
        if(sqlite3_step(createTable) != SQLITE_DONE) {
            return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
        }
    } else {
        return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
    }
    sqlite3_finalize(createTable);
    return nil;
}

- (NSArray<RecipeModel *> *)getAllRecipesWithError:(NSError * __autoreleasing *)error {
    if(*error) {
        *error = nil;
    }
    sqlite3_stmt *searchItem;
    NSString *const searchRecipesString = @"select * from recipes;";
    NSMutableArray<RecipeModel *> *const result = [[NSMutableArray alloc] init];
    if(sqlite3_prepare_v2(_database, searchRecipesString.UTF8String, -1, &searchItem, nil) == SQLITE_OK) {
        while(sqlite3_step(searchItem) == SQLITE_ROW) {
            RecipeModel *model = [[RecipeModel alloc] init];
            model.title = @((const char *)sqlite3_column_text(searchItem, 0));
            model.siteURLPath = @((const char *)sqlite3_column_text(searchItem, 1));
            model.ingredients = @((const char *)sqlite3_column_text(searchItem, 2));
            model.thumbnail = @((const char *)sqlite3_column_text(searchItem, 3));
            [result addObject:model];
        }
    } else {
        if(*error) {
            *error = [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
        }
    }
    sqlite3_finalize(searchItem);
    return result;
}

- (nullable NSError *)deleteRecipes {
    sqlite3_stmt *removeItem;
    NSString *const removeReceipesString = @"drop table if exists recipes;";
    if(sqlite3_prepare_v2(_database, removeReceipesString.UTF8String, -1, &removeItem, nil) == SQLITE_OK) {
        if(sqlite3_step(removeItem) != SQLITE_DONE) {
            return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
        }
    } else {
        return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
    }
    sqlite3_finalize(removeItem);
    return [self openOrCreate];
}

- (nullable NSError *)createRecipes:(NSArray<RecipeModel *> *)recipes {
    for(RecipeModel *const model in recipes) {
        sqlite3_stmt *createItem;
        NSString *const createRecipeString = @"insert into recipes (title, href, ingredients, thumbnail) values (?, ?, ?, ?);";
        if(sqlite3_prepare_v2(_database, createRecipeString.UTF8String, -1, &createItem, nil) == SQLITE_OK) {
            sqlite3_bind_text(createItem, 1, model.title.UTF8String, -1, nil);
            sqlite3_bind_text(createItem, 2, model.siteURLPath.UTF8String, -1, nil);
            sqlite3_bind_text(createItem, 3, model.ingredients.UTF8String, -1, nil);
            sqlite3_bind_text(createItem, 4, model.thumbnail.UTF8String, -1, nil);
            if(sqlite3_step(createItem) != SQLITE_DONE) {
                return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
            }
        } else {
            return [[NSError alloc] initWithDomain:@(sqlite3_errmsg(_database)) code:0 userInfo:nil];
        }
        sqlite3_finalize(createItem);
    }
    return nil;
}

@end
