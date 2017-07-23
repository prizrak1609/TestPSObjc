//
//  RecipeCell.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "RecipeCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface RecipeCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UITextView *decriptionTextView;
@end

@implementation RecipeCell

@synthesize nameLabel;
@synthesize thumbnail;
@synthesize decriptionTextView;

- (void)setRecipeModel:(RecipeModel *)model {
    nameLabel.text = model.title;
    decriptionTextView.text = model.ingredients;
    NSURL *const imageURL = [[NSURL alloc] initWithString:model.thumbnail];
    if(imageURL) {
        thumbnail.layer.borderWidth = 1;
        [thumbnail setImageWithURL:imageURL];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    thumbnail.layer.borderColor = UIColor.clearColor.CGColor;
    thumbnail.image = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    decriptionTextView.scrollEnabled = NO;
    thumbnail.layer.masksToBounds = YES;
    thumbnail.layer.borderColor = UIColor.grayColor.CGColor;
    thumbnail.layer.cornerRadius = thumbnail.frame.size.height / 2;
}

@end
