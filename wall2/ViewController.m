//
//  ViewController.m
//  wall2
//
//  Created by Sathish Chinniah on 28/12/15.
//  Copyright © 2015 Sathish Chinniah. All rights reserved.
//
//////
#import "ViewController.h"

@interface ViewController ()
{
    
    NSDate *firstdate;
}

@end

@implementation ViewController
@synthesize flabel;
@synthesize slabel;
@synthesize tlabel;
@synthesize folabel;
@synthesize fivlabel;
@synthesize sixlabel;
@synthesize sevenlabel;
@synthesize dateLabel;
//@synthesize walletView;
@synthesize leftBtn;
@synthesize rightBtn;
@synthesize NumberLabel;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    firstdate = [NSDate date];
    //    firstdate = [NSDate dateWithTimeInterval:-(5*86400) sinceDate:firstdate];
    
    firstdate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-6 toDate:[NSDate date] options:nil];
    //
    
    
    NSArray *jsonObject;
    jsonObject = @[@{@"Id1":@"mad",
                     @"people1":@"300"},
                   @{@"Id2":@"normal",
                     @"people2":@"9",@"total2":@"4"}];
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    
    
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
    
    
    
    NSDictionary *dict = [jsonArray objectAtIndex:0];
    NSDictionary *dict2 = [jsonArray objectAtIndex:1];
    
    
    NumberLabel.text = [dict2 valueForKey:@"total2"];
    

    
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM,yyyy"];
    dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
    dateLabel.text = [dateFormat stringFromDate: firstdate];
    
    [self dateChange];
    

    
    
}

-(void)dateChange
{
    NSArray *labelArray = @[flabel, slabel, tlabel, folabel, fivlabel,sixlabel,sevenlabel];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    dateFormatter.dateFormat = @"ddMMM";
    for (NSInteger i = 0; i < 7; ++i) {
        NSDate *nextDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:i toDate:firstdate options:nil];
        UILabel *label = (UILabel *)labelArray[i];
        label.text = [dateFormatter stringFromDate:nextDate];
        if (i==6) {
            dateFormatter.dateFormat=@"MMM,yyyy";
            dateLabel.text = [[dateFormatter stringFromDate:nextDate] capitalizedString];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            if ([[dateFormat stringFromDate:nextDate] isEqualToString:[dateFormat stringFromDate:[NSDate date]]])
            {
                rightBtn.enabled = false;
                //It's the same day
            }
            else
            {
                rightBtn.enabled = true;
            }
        }
    }
}
- (IBAction)calRight:(id)sender {
    
    
    
    
    /////
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:7 toDate:firstdate options:nil];
    [self dateChange];
    //////
    
    
}

- (IBAction)calLeft:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:firstdate options:nil];
    [self dateChange];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
