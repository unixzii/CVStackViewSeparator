//
//  UIStackView+Separator.m
//  CocoaTouchPlayground
//
//  Created by 杨弘宇 on 16/6/1.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

#import <objc/runtime.h>
#import "UIStackView+Separator.h"

@interface UIStackViewSeparatorHelper : NSObject

@property (copy, nonatomic) UIColor *separatorColor;
@property (assign, nonatomic) CGFloat separatorLength;
@property (assign, nonatomic) CGFloat separatorThickness;

@property (weak, nonatomic) UIStackView *stackView;
@property (strong, nonatomic) NSMutableArray<UIView *> *separatorViews;

- (void)makeSeparators;

@end

@implementation UIStackViewSeparatorHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.separatorViews = [NSMutableArray array];
        self.separatorThickness = 1;
    }
    return self;
}

- (void)makeSeparators {
    UIStackView * __strong strongStackView = self.stackView;
    if (!strongStackView || !self.separatorColor || (self.separatorLength <= 0)) {
        return;
    }
    
    [self.separatorViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.separatorViews removeAllObjects];
    
    [strongStackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            return;
        }
        
        UIView *previousView = strongStackView.arrangedSubviews[idx - 1];
        
        UIView *separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = self.separatorColor;
        
        CGFloat center;
        if (strongStackView.axis == UILayoutConstraintAxisHorizontal) {
            center = (CGRectGetMaxX(previousView.frame) + CGRectGetMinX(obj.frame)) / 2.0;
            separatorView.frame = CGRectMake(center, (CGRectGetHeight(strongStackView.frame) - self.separatorLength) / 2.0, self.separatorThickness, self.separatorLength);
        }
        else {
            center = (CGRectGetMaxY(previousView.frame) + CGRectGetMinY(obj.frame)) / 2.0;
            separatorView.frame = CGRectMake((CGRectGetWidth(strongStackView.frame) - self.separatorLength) / 2.0, center, self.separatorLength, self.separatorThickness);
        }
        
        [strongStackView addSubview:separatorView];
        [self.separatorViews addObject:separatorView];
    }];
}

@end

#pragma mark -

static const char kHelperKey;

@implementation UIStackView (Separator)

+ (void)_swizzleMethodWithSelector:(SEL)aSelector andSelector:(SEL)anotherSelector {
    Class cls = [self class];
    
    Method oriMethod = class_getInstanceMethod(cls, aSelector);
    Method newMethod = class_getInstanceMethod(cls, anotherSelector);
    
    BOOL didAddMethod = class_addMethod(cls, aSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, anotherSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }
    else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

+ (void)load {
    [super load];
    
    [self _swizzleMethodWithSelector:@selector(layoutSubviews) andSelector:@selector(sep_layoutSubviews)];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    [self _separatorHelper].separatorColor = separatorColor;
    [[self _separatorHelper] makeSeparators];
}

- (void)setSeparatorLength:(CGFloat)separatorLength {
    [self _separatorHelper].separatorLength = separatorLength;
    [[self _separatorHelper] makeSeparators];
}

- (void)setSeparatorThickness:(CGFloat)separatorThickness {
    [self _separatorHelper].separatorThickness = separatorThickness;
    [[self _separatorHelper] makeSeparators];
}

- (UIColor *)separatorColor {
    return [self _separatorHelper].separatorColor;
}

- (CGFloat)separatorLength {
    return [self _separatorHelper].separatorLength;
}

- (CGFloat)separatorThickness {
    return [self _separatorHelper].separatorThickness;
}

- (UIStackViewSeparatorHelper *)_separatorHelper {
    UIStackViewSeparatorHelper *helper = objc_getAssociatedObject(self, &kHelperKey);
    if (!helper) {
        helper = [[UIStackViewSeparatorHelper alloc] init];
        helper.stackView = self;
        objc_setAssociatedObject(self, &kHelperKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return helper;
}

- (void)sep_layoutSubviews {
    [self sep_layoutSubviews];
    [[self _separatorHelper] makeSeparators];
}

@end
