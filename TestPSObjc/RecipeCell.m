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

- (void)setModel:(RecipeModel *)model {
    _nameLabel.text = model.title;
    _decriptionTextView.text = model.ingredients;
    NSURL *const imageURL = [[NSURL alloc] initWithString:model.thumbnail];
    if(imageURL) {
        _thumbnail.layer.borderWidth = 1;
        [_thumbnail setImageWithURL:imageURL];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _thumbnail.layer.borderColor = UIColor.clearColor.CGColor;
    _thumbnail.image = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _decriptionTextView.scrollEnabled = NO;
    _thumbnail.layer.masksToBounds = YES;
    _thumbnail.layer.borderColor = UIColor.grayColor.CGColor;
    _thumbnail.layer.cornerRadius = _thumbnail.frame.size.height / 2;
}

@end
