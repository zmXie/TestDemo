//
//  ViewController.m
//  PodTest
//
//  Created by xzm on 2018/8/9.
//  Copyright © 2018年 xzm. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "webcontroller.h"

@interface TestCell : UITableViewCell

- (void)setContent:(NSString *)content;

@end

@implementation TestCell
{
    UILabel *contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgView];
        
        contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.layer.cornerRadius = 10;
        contentLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:contentLabel];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.width.height.mas_equalTo(40);
            make.top.equalTo(self.contentView);
        }];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(60);
            make.right.equalTo(self.contentView).offset(-40);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    contentLabel.text = content;
}

@end



@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testBlock];
//    [self testGroup];
//    [self testSemaphore];
//    [self testDic];
//    [self testArray];
//    [self testStr];
//    [self testMethod];
//    [self addTableView];
//    [self addLabel];
}

- (void)testGroup
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"1");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"2");
        dispatch_group_leave(group);
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"3");
    
    //结果，分别打印1，2，3
    //dispatch_group_wait会根据group中是否还有任务在执行来阻塞当前线程，一般不会放在主线程里面执行，否则会造成页面假死；dispatch_group_enter进入group执行任务，dispatch_group_leave离开group，表示这个任务已完成，一般总是成双成对
}

- (void)testSemaphore
{
    __block NSInteger count = 0;
    dispatch_block_t doTask = ^{
        sleep(1);
        count ++;
        NSLog(@"%ld",count);
    };
    
    //创建信号量，并指定信号量的初值为1，如果小于0则会返回NULL
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    
    for (int i = 0; i < 5; i ++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //等待信号量，当信号值>0时，使信号值-1，当信号值为0时，会阻塞当前线程
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            doTask();
            //发送信号量，使信号值+1
            dispatch_semaphore_signal(lock);
        });
    }
    
    //结果：在多线程环境下，doTask任务是一个接一个执行的
    //从而保证了线程安全，每一个线程里面做的事情不会被其他线程所干扰
}

- (void)injected
{
    [self addLabel];
}

- (void)addLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.frame) - 20, 200)];
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerClass:[TestCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setContent:@"符合度我你日哦恶女逼人保护任务承诺触怒诶人女巨人捕IE通你重复我人家爱情胡歌我入户率 纳福IE日女URIE噢牛逼VR偶"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[NSClassFromString(@"MessageViewController") new] animated:YES];
}




- (void)testArray
{
    NSString *a = nil;
    
    NSArray *emptyArr = @[];
    [emptyArr arrayByAddingObject:a];
    
    NSArray *singleArr = @[@"1"];
    [singleArr objectAtIndex:2];
    
    NSArray *multiArr = @[@"1",@"2",a];
    NSLog(@"数组第4个元素：%@",[multiArr objectAtIndex:3]);
    
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:@"1"];
    [mArr objectAtIndex:2];
    [mArr addObject:a];
    NSLog(@"可变数组:%@",mArr);
    
}

- (void)testDic
{
    NSString *sex = nil;
    NSDictionary *dic = @{@"name":@"小明",
                          @"age":@"18",
                          @"sex":sex,
                          @"hobby":@"play"
                          };
    NSLog(@"字典输出:%@",dic);
}

- (void)testStr
{
    NSString *str = @"abc";
    [str substringFromIndex:4];
}

- (void)testMethod
{
    [self performSelector:@selector(goToDetail) withObject:nil];
}

- (void)testBlock
{
    int a = 10;
    __block NSString *b = @"b";
    NSArray *c = @[@"c"];
    NSLog(@"内存地址1：%p",b); //打印b指针指向的对象的内存地址
    NSLog(@"内存地址1：%x",&b); //打印b指针本身的内存地址（指针是一个变量，其本身也是有内存地址的）
    void (^ testBlock)(void) = ^{
        NSLog(@"内存地址3：%p",b);
        NSLog(@"内存地址3：%x",&b);
        NSLog(@"a==%d",a);
        NSLog(@"b==%@",b);
        NSLog(@"c==%@",c);
    };
    a++;
    b = @"b2";
    c = @[@"c2"];
    NSLog(@"内存地址2：%p",b);
    NSLog(@"内存地址2：%x",&b);
    testBlock();
    
    //结果：testBlock中输出a==10,b==@"b2",c==@[@"c"]
    //block捕捉变量的a c，对其进行指针拷贝，所以在外部a c的指针跟block内部a c的指针是不同的，那么改变外部指针指向，不会影响block内部的a c
    //__block修饰的变量，在被block捕捉的时候，会将指针从栈区copy到堆区，在block内外b都是同一个指针，所以在外部操作b指针，在block内部b同样会改变
}

- (IBAction)goDetail:(id)sender
{
    [self.navigationController pushViewController:[webcontroller new] animated:YES];
}


@end
