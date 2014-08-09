//
//  NPSubItem.m
//  iOrtho
//
//  Created by Arthur Hemmer on 07/08/14.
//  Copyright (c) 2014 Appsss. All rights reserved.
//

//Views
#import "AHSubitemView.h"

//Categories
#import "UIImage+Overlay.h"

@interface AHSubitemView ()

@property (nonatomic) UIImageView *thumbnail;

@property (nonatomic) UILabel *titleLabel;

@end

@implementation AHSubitemView

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        [self.titleLabel setTextColor:self.selectedColor];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
        [self.thumbnail setImage:[self.image imageWithColor:self.selectedColor]];
    } else {
        UIColor *tintColor = [UIColor colorWithWhite:.6f alpha:1.f];
        [self.titleLabel setTextColor:tintColor];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [self.thumbnail setImage:[self.image imageWithColor:tintColor]];
    }
}

#pragma mark - Layout
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    UIColor *grayColor = [UIColor colorWithWhite:.6f alpha:1.f];
    static const float kHorizontalSpacing = 10.f;
    static const float kVerticalSpacing = 5.f;
    
    [self setBackgroundColor:[UIColor colorWithWhite:.9f alpha:1.f]];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, .5f)];
    [sep setBackgroundColor:[UIColor colorWithWhite:.7f alpha:1.f]];
    [self addSubview:sep];
    
    if (!self.thumbnail) {
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.thumbnail setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.thumbnail];
    }
    
    CGRect tFrame = CGRectZero;
    tFrame.size.height = frame.size.height - 5*kVerticalSpacing;
    tFrame.size.width = tFrame.size.height;
    tFrame.origin.x = kHorizontalSpacing;
    tFrame.origin.y = (frame.size.height - tFrame.size.height)/2.f;
    [self.thumbnail setFrame:tFrame];
    [self.thumbnail setImage:[self.image imageWithColor:grayColor]];
    
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [self.titleLabel setTextColor:grayColor];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:self.titleLabel];
    }
    
    CGRect lFrame = CGRectZero;
    lFrame.size.height = frame.size.height - 2 * kVerticalSpacing;
    lFrame.size.width = frame.size.width - 3 * kVerticalSpacing - tFrame.size.width;
    lFrame.origin.x = 2 * kHorizontalSpacing + tFrame.size.width;
    lFrame.origin.y = kVerticalSpacing;
    [self.titleLabel setFrame:lFrame];
    [self.titleLabel setText:self.title];
}

#pragma mark - Gestures
-(void)tapGestureRecognized:(UITapGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        !self.didSelectSubitem ?: self.didSelectSubitem(self);
    }
}

#pragma mark - Initialisation
-(void)setup
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tapGestureRecognized:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end
