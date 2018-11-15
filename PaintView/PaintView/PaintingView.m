//
//  PaintingView.m
//  PaintView
//
//  Created by 栗子哇 on 2018/11/15.
//  Copyright © 2018 NineTon. All rights reserved.
//

#import "PaintingView.h"
#import "PaintModel.h"

@interface PaintingView ()

@property (nonatomic , strong) NSMutableArray *pathsArray;

@property (nonatomic , assign) UIColor *currentColor;

@property (nonatomic , strong) UISlider *penWidthSlider;

@end

@implementation PaintingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return  self;
}

- (void)configureUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.currentColor = [UIColor blackColor];
    UIView *colorBoardView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 20)];
    [self addSubview:colorBoardView];
    //色板样式
    colorBoardView.layer.borderWidth = 1;
    colorBoardView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //创建每个色块
    NSArray *colors = @[[UIColor blackColor],[UIColor redColor],[UIColor blueColor], [UIColor greenColor],[UIColor yellowColor],[UIColor brownColor], [UIColor orangeColor],[UIColor whiteColor], [UIColor purpleColor],[UIColor cyanColor],[UIColor lightGrayColor]];
    for (int i = 0; i < colors.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((colorBoardView.frame.size.width /colors.count) * i, 0,  colorBoardView.frame.size.width / colors.count, 20)];
        [colorBoardView addSubview:btn];
        [btn setBackgroundColor:colors[i]];
        [btn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.penWidthSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 20)];
    self.penWidthSlider.maximumValue = 20;
    self.penWidthSlider.minimumValue = 1;
    [self addSubview:self.penWidthSlider];
}
//切换颜色
-(void)changeColor:(id)target{
    UIButton *btn = (UIButton *)target;
    self.currentColor = [btn backgroundColor];
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef cureentContext = UIGraphicsGetCurrentContext();
    for (int i = 0; i < self.pathsArray.count; i++) {
        PaintModel *model = [self.pathsArray objectAtIndex:i];
        NSMutableArray *pathPoints = model.pathPoints;
        CGMutablePathRef path = CGPathCreateMutable();
        for (int j = 0; j < pathPoints.count; j++) {
            CGPoint point = [[pathPoints objectAtIndex:j]CGPointValue] ;
            if (j == 0) {
                CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x,point.y);
            }else{
                CGPathAddLineToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            }
        }
        CGContextSetStrokeColorWithColor(cureentContext, model.color);
        CGContextSetLineWidth(cureentContext, model.strokeWidth);
        //路径添加到ct
        CGContextAddPath(cureentContext, path);
        //描边
        CGContextStrokePath(cureentContext);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PaintModel *model = [[PaintModel alloc]init];
    model.color = self.currentColor.CGColor;
    model.pathPoints =  [[NSMutableArray alloc]init];
    model.strokeWidth = self.penWidthSlider.value;
    [self.pathsArray addObject:model];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PaintModel *step = [self.pathsArray lastObject];
    NSMutableArray *pathPoints = step.pathPoints;
    /* 获取手势移动的点 **/
    CGPoint movePoint = [[touches anyObject]locationInView:self];
    [pathPoints addObject:[NSValue valueWithCGPoint:movePoint]];
    /*  通知重新渲染界面，这个方法会重新调用UIView的drawRect:(CGRect)rect方法 **/
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma  mark Setter && Getter
- (NSMutableArray *)pathsArray{
    if (!_pathsArray) {
        _pathsArray = [NSMutableArray array];
    }
    return _pathsArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
