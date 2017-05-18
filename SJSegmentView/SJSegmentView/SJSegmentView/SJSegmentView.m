//
//  SJSegmentView.m
//  SJSegmentView
//
//  Created by Sun Shijie on 2017/5/17.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "SJSegmentView.h"

@interface SJSegmentView()

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *segments;
@property (nonatomic, strong) UIFont *font;

@end

@implementation SJSegmentView
{
    NSUInteger _segmentCount;
    CGFloat _seperateLineWidth;
    CGFloat _segmentWidth;
    CGFloat _segmentHeight;
    UIColor *_selectedTextColor;
    UIColor *_unSelectedBgColor;
    UIColor *_unSelectedTextColor;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles font:(UIFont *)font
{
    if (titles.count <= 0) {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _titles = titles;
        if (!font) {
            font = [UIFont systemFontOfSize:12];
        }
        _font = font;
        _segmentCount = titles.count;
        _seperateLineWidth = 1;
        _segmentWidth = (frame.size.width - (_segmentCount - 1) * _seperateLineWidth)/_segmentCount;
        _segmentHeight = frame.size.height;
        _selectedTextColor = [UIColor whiteColor];
        _unSelectedBgColor = [UIColor whiteColor];
        _unSelectedTextColor = [UIColor blackColor];
       
        [self createSegments];
    }
    return self;
}

- (void)createSegments
{
    NSMutableArray *segmentsArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    for (NSUInteger index = 0; index < _segmentCount; index++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = _font;
        button.tag = index;
        [button addTarget:self action:@selector(didSelectedButtonIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        [segmentsArray addObject:button];
        [self addSubview:button];
        
    }
    _segments = [segmentsArray copy];
}


- (void)layoutSubviews
{
    [self drawBorder];
    [self drawSeparatLine];
    
    [_segments enumerateObjectsUsingBlock:^(UIButton *segment, NSUInteger idx, BOOL * _Nonnull stop) {
         segment.frame = CGRectMake(idx * (_segmentWidth + _seperateLineWidth), 0, _segmentWidth, _segmentHeight);
        [segment setTitle:_titles[idx] forState:UIControlStateNormal];
        
    }];
    
    [self setSelectedIndex:0];
}

- (void)drawBorder
{
    UIColor *selectedBgColor = [self.sjDataSource selectedBgColor];
    self.layer.borderColor = [selectedBgColor CGColor];
    self.layer.borderWidth = 1;
}

-(void)drawSeparatLine
{
    self.backgroundColor = [self.sjDataSource selectedBgColor];
}


- (void)setSelectedIndex:(NSUInteger)index
{
    if (_segments.count > index) {
        
        UIColor *selectedBgColor = [self.sjDataSource selectedBgColor];
        
        
        UIColor *selectedTextColor = nil;
        if ([self.sjDataSource respondsToSelector:@selector(selectedTextColor)]) {
            selectedTextColor = [self.sjDataSource selectedTextColor];
            if (!selectedTextColor) {
                selectedTextColor = _selectedTextColor;
            }
        }else{
            selectedTextColor = _selectedTextColor;
        }
        
        UIColor *unSelectedBgColor = nil;
        if ([self.sjDataSource respondsToSelector:@selector(unSelectedBgColor)]) {
            unSelectedBgColor = [self.sjDataSource unSelectedBgColor];
            if (!unSelectedBgColor) {
                unSelectedBgColor = _unSelectedBgColor;
            }
        }else{
            unSelectedBgColor = _unSelectedBgColor;
        }
        
        UIColor *unSelectedTextColor = nil;
        if ([self.sjDataSource respondsToSelector:@selector(unSelectedTextColor)]) {
            unSelectedTextColor = [self.sjDataSource unSelectedTextColor];
            if (!unSelectedTextColor) {
                unSelectedTextColor = _unSelectedTextColor;
            }
        }else{
            unSelectedTextColor = _unSelectedTextColor;
        }
        
        [_segments enumerateObjectsUsingBlock:^(UIButton *segment, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( index == idx) {
                [segment setBackgroundColor:selectedBgColor];
                [segment setTitleColor:selectedTextColor forState:UIControlStateNormal];
                
            }else{
                [segment setBackgroundColor:unSelectedBgColor];
                [segment setTitleColor:unSelectedTextColor forState:UIControlStateNormal];
            }
        }];
        
        if([self.sjDelegate respondsToSelector:@selector(didSelectedIndex:)])
        {
            [self.sjDelegate didSelectedIndex:index];
        }
        
    }
}


- (void)didSelectedButtonIndex:(UIButton *)button
{
    [self setSelectedIndex:button.tag];
}



@end
