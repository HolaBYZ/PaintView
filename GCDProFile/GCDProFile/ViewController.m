//
//  ViewController.m
//  GCDProFile
//
//  Created by 栗子哇 on 2018/11/16.
//  Copyright © 2018 NineTon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/*
 *使用GCD 的多线程
 *优点：有很多串行并线队列多线程，block实现线程方法，高级，好用，方法多。
 *缺点：在很多不需要高级控制线程的场景可以不用使用GCD
 */
-(void)GCDFunction{
    NSLog(@"GCDFunction start");
    //获取一个队列
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //dispatch_async：异步方式执行方法（最常用）
//        dispatch_async(defaultQueue, ^{
//            [self function1];
//        });
    
    //dispatch_sync：同步方式使用场景，比较少用，一般与异步方式进行调用
//        dispatch_async(defaultQueue, ^{
//           NSMutableArray *array = [self GCD_sync_Function];
//           dispatch_async(dispatch_get_main_queue(), ^{
//               //利用获取的arry在主线程中更新UI
//
//           });
//        });
    
    //dispatch_once：一次性执行，常常用户单例模式.这种单例模式更安全
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            // code to be executed once
//            NSLog(@"dispatch_once");
//        });
    
    //dispatch_after 延迟异步执行
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
//        dispatch_after(popTime, defaultQueue, ^{
//            NSLog(@"dispatch_after");
//        });
    
    
    //dispatch_group_async 组线程可以实现线程之间的串联和并联操作
        dispatch_group_t group = dispatch_group_create();
        NSDate *now = [NSDate date];
        //做第一件事 2秒
        dispatch_group_async(group, defaultQueue, ^{
            [NSThread sleepForTimeInterval:2];
             NSLog(@"work 1 done");
        });
        //做第二件事 5秒
        dispatch_group_async(group, defaultQueue, ^{
            [NSThread sleepForTimeInterval:5];
            NSLog(@"work 2 done");
        });
        //两件事都完成后会进入方法进行通知
        dispatch_group_notify(group, defaultQueue, ^{
            NSLog(@"dispatch_group_notify");
            NSLog(@"%f",[[NSDate date]timeIntervalSinceDate:now]);//总共用时5秒，因为2个线程同时进行
        });
    
    
//    dispatch_barrier_async :作用是在并行队列中，等待前面的队列执行完成后在继续往下执行
        dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"work 1 done");
        });
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"work 2 done");
        });
        //等待前面的线程完成后执行
        dispatch_barrier_async(concurrentQueue, ^{
             NSLog(@"dispatch_barrier_async");
        });
    
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"work 3 done");
        });
    
    
    
    //dispatch_semaphore 信号量的使用，串行异步操作
    //    dispatch_semaphore_create　　　创建一个semaphore
    //　　 dispatch_semaphore_signal　　　发送一个信号
    //　　 dispatch_semaphore_wait　　　　等待信号
    /*应用场景1：马路有2股道，3辆车通过 ，每辆车通过需要2秒
     *条件分解:
     马路有2股道 <=>  dispatch_semaphore_create(2) //创建两个信号
     三楼车通过 <=> dispatch_async(defaultQueue, ^{ } 执行三次
     车通过需要2秒 <=>  [NSThread sleepForTimeInterval:2];//线程暂停两秒
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_async(defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"carA pass the road");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"carB pass the road");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"carC pass the road");
        dispatch_semaphore_signal(semaphore);
    });
    
    //应用场景2 ：原子性保护，保证同时只有一个线程进入操作
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //    for(int i=0 ;i< 10000 ;i++){
    //        dispatch_async(defaultQueue, ^{
    //            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //            NSLog(@"i:%d",i);
    //            dispatch_semaphore_signal(semaphore);
    //        });
    //    }
    
    
    NSLog(@"GCDFunction end");
}



@end
