//
//  FISViewController.m
//  pickinFruit
//
//  Created by Joe Burgess on 7/3/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

- (IBAction)spin:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.fruitsArray = @[@"Apple",
                         @"Orange",
                         @"Banana",
                         @"Pear",
                         @"Grape",
                         @"Kiwi",
                         @"Mango",
                         @"Blueberry",
                         @"Raspberry"];
    
    self.fruitPicker.delegate = self;
    self.fruitPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)spin:(id)sender {
    
    
    
    [self.fruitPicker selectRow:[self randomRow] inComponent:0 animated:YES];
    [self.fruitPicker selectRow:[self randomRow] inComponent:1 animated:YES];
    [self.fruitPicker selectRow:[self randomRow] inComponent:2 animated:YES];
    
    
    NSString *firstComponentString = self.fruitsArray[[self.fruitPicker selectedRowInComponent:0]];
    NSString *secondComponentString = self.fruitsArray[[self.fruitPicker selectedRowInComponent:1]];
    NSString *thirdComponentString = self.fruitsArray[[self.fruitPicker selectedRowInComponent:2]];
    
    NSString *result = @"You lost!";
    
    if ([firstComponentString isEqualToString:secondComponentString] && [secondComponentString isEqualToString:thirdComponentString]) {
        result = @"You won!";
    }
    
    UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Result" message:result preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    UIAlertAction *spinAgain = [UIAlertAction actionWithTitle:@"SpinAgain" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self spin:self.fruitPicker];}];
    [alertCont addAction:cancel];
    [alertCont addAction:cancel];
    
    [self presentViewController:alertCont animated:YES completion:nil];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 6;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.fruitsArray[row];
}

-(NSInteger)randomRow{
    return arc4random() % [self.fruitsArray count];
    
}
@end
