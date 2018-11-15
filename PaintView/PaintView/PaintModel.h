//
//  PaintModel.h
//  PaintView
//
//  Created by 栗子哇 on 2018/11/15.
//  Copyright © 2018 NineTon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaintModel : NSObject

@property (nonatomic , strong) NSMutableArray *pathPoints;

@property (nonatomic , assign) CGColorRef color;

@property (nonatomic , assign) float strokeWidth;

@end

NS_ASSUME_NONNULL_END
