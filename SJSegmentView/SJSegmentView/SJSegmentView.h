//
//  SJSegmentView.h
//  SJSegmentView
//
//  Created by Sun Shijie on 2017/5/17.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SJSegmentViewDelegate

- (void)didSelectedIndex:(NSUInteger)index;

@end


@protocol SJSegmentViewDataSource

@required
- (UIColor *)selectedBgColor;
- (UIColor *)selectedTextColor;

@optional
- (UIColor *)unSelectedBgColor;      //default is white
- (UIColor *)unSelectedTextColor;    //default is black

@end

@interface SJSegmentView : UIView

@property (nonatomic, weak) id<SJSegmentViewDelegate> sjDelegate;
@property (nonatomic, weak) id<SJSegmentViewDataSource> sjDataSource;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles font:(UIFont *)font;
- (void)setSelectedIndex:(NSUInteger)index;

@end
