//
//  ViewController.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "ViewController.h"
#import "BaseDataSourceImp.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showCalendar:(id)sender {
    if (_calendarView.appear){
        [_calendarView hide];
    }
    else {
        [_calendarView showInView:self.view];
    }
}

- (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

- (void)calendarViewDidSelectDay:(CalendarView *)calendarView calDay:(CalDay *)calDay {
    NSArray *selectedDates = calendarView.selectedDateArray;
    if (calendarView.allowsMultipleSelection){
        for (NSDate *date in selectedDates){
            ITTDINFO(@"selected date %@", [self stringFromDate:date formate:@"yyyy-MM-dd"]);
        }
    }
    else {
        ITTDINFO(@"selected date %@", [self stringFromDate:calendarView.selectedDate formate:@"yyyy-MM-dd"]);
    }
}

- (NSDate *)theDateRelativeTodayWithInterval:(NSInteger)interval {
    return [NSDate dateWithTimeIntervalSinceNow:(24 * 60 * 60 * interval)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // For popup
    _calendarView = [CalendarView viewFromNib];
    BaseDataSourceImp *dataSource = [[BaseDataSourceImp alloc] init];
    _calendarView.dataSource = dataSource;
    _calendarView.delegate = self;
    _calendarView.frame = CGRectMake(8, 40, 309, 350);
    _calendarView.allowsMultipleSelection = NO;
    NSDate *minimumDate = [NSDate date];
    _calendarView.minimumDate = minimumDate;
    _calendarView.maximumDate = [self theDateRelativeTodayWithInterval:20];
//    [_calendarView showInView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    BaseDataSourceImp *dataSource = [[BaseDataSourceImp alloc] init];
    CalendarView *calendarView = [CalendarView viewFromNib];
    calendarView.frame = self.targetView.frame;// targetView
    calendarView.dataSource = dataSource;
    calendarView.delegate = self;
    [calendarView showInView:self.view];

    NSLog(@"%@", [self.view performSelector:@selector(recursiveDescription)]);
}

- (void)viewDidUnload {
    [self setTargetView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
