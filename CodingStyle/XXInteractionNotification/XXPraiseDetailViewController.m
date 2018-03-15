//
//  XXPraiseDetailViewController.m
//  XXInteractionNotificationDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXPraiseDetailViewController.h"
#import "XXInteractionNotificationLayout.h"
#import "XXInteractionNotificationCell.h"
#import "XXInteractionNotification.h"

static const NSInteger kXXInteractionNotificationPageSize = 1;

@interface XXPraiseDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<XXInteractionNotificationLayout *> *layouts;

@end

@implementation XXPraiseDetailViewController

#pragma mark - Lifecycle

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    self.layouts = @[].mutableCopy;
    
    //    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Notification
}

#pragma mark - Private methods

- (void)setUpViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[XXInteractionNotificationCell class] forCellReuseIdentifier:[XXInteractionNotificationCell cellId]];
    //    __weak __typeof(self)weakSelf = self;
    //    tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
    //        [weakSelf refetch];
    //    }];
    //    tableView.mj_footer = [MJRefreshGifHeader footerWithRefreshingBlock:^{
    //        [weakSelf fetchMore];
    //    }];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}

- (void)refetch {
    NSInteger pageNo = 1;
    [self networkAction:pageNo refresh:YES];
}

- (void)fetchMore {
    NSInteger pageNo = 1;
    if (self.layouts.count / kXXInteractionNotificationPageSize) {
        pageNo += self.layouts.count / kXXInteractionNotificationPageSize;
    }
    [self networkAction:pageNo refresh:NO];
}

- (void)networkAction:(NSInteger)pageNo refresh:(BOOL)refresh {
    __weak __typeof(self)weakSelf = self;
    [self networkActionWithpageNo:@(pageNo) pageSize:@(kXXInteractionNotificationPageSize) succeededHandler:^(XXInteractionNotification *notification) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        //        [strongSelf.tableView.mj_header endRefreshing];
        
        NSMutableArray *layoutArr = [NSMutableArray array];
        for (int i = 0; i < notification.msgList.count; ++i) {
            XXInteractionNotificationItem *item = notification.msgList[i];
            XXInteractionNotificationLayout *layout = [[XXInteractionNotificationLayout alloc] initWithInteractionNotificationItem:item type:item.type.integerValue entryType:XXInteractionNotificationEntryTypePraiseDetail];
            [layoutArr addObject:layout];
        }
        if (refresh) {
            [strongSelf.layouts removeAllObjects];
        }
        [strongSelf.layouts addObjectsFromArray:layoutArr];
        
        if ((strongSelf.layouts.count % kXXInteractionNotificationPageSize) != 0) {
            //            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            //            [strongSelf.tableView.mj_footer endRefreshing];
        }
        
        strongSelf.title = [NSString stringWithFormat:@"%@人赞过你", notification.totalCount];
        [strongSelf.tableView reloadData];
    } failedHandler:^(NSError *error) {
        // show error
    }];
}

-  (void)networkActionWithpageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize succeededHandler:(void (^)(XXInteractionNotification *))succeededHandler failedHandler:(void (^)(NSError *))failedHandler {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXInteractionNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:[XXInteractionNotificationCell cellId]];
    if (!cell) {
        cell = [[XXInteractionNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XXInteractionNotificationCell cellId]];
    }
    [cell setInteractionNotificationLayout:self.layouts[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((XXInteractionNotificationLayout *)self.layouts[indexPath.row]).height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XXInteractionNotificationLayout *layout = self.layouts[indexPath.row];
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    if (1 == interactionItem.topicDel.integerValue) {
        return;
    } else if (0 == interactionItem.topicDel.integerValue) {
        //        jump to interactionItem.call
    }
}

@end
