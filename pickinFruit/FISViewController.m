//
//  FISViewController.m
//  pickinFruit
//
//  Created by Joe Burgess on 7/3/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property (strong, nonatomic) UIAlertView *spinnerAlertView;

- (IBAction)spin:(id)sender;

@end

@implementation FISViewController

static NSInteger const numberOfComponents = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.fruitPicker.delegate = self;
    self.fruitPicker.dataSource = self;
    
    self.fruitsArray = @[@"Apple",@"Orange",@"Banana",@"Pear",@"Grape", @"Kiwi", @"Mango", @"Blueberry", @"Raspberry"];
    
    self.fruitPicker.accessibilityLabel = @"FruitSpinner";
    self.fruitPicker.accessibilityIdentifier = @"FruitSpinner";
    
    self.spinButton.accessibilityLabel = @"SpinButton";
    self.spinButton.accessibilityIdentifier = @"SpinButton";
    


}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.fruitsArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.fruitsArray[row];
}

- (NSInteger)getRandomFruit {
    return arc4random_uniform([self.fruitsArray count]);
}

- (IBAction)spin:(id)sender {
    
    [self.fruitPicker selectRow:[self getRandomFruit] inComponent:0 animated:YES];
    [self.fruitPicker selectRow:[self getRandomFruit] inComponent:1 animated:YES];
    [self.fruitPicker selectRow:[self getRandomFruit] inComponent:2 animated:YES];
    
    NSString *spinResultMessage = @"You lost!";
    
    NSString *fruitOne = self.fruitsArray[[self.fruitPicker selectedRowInComponent:0]];
    NSString *fruitTwo = self.fruitsArray[[self.fruitPicker selectedRowInComponent:1]];
    NSString *fruitThree = self.fruitsArray[[self.fruitPicker selectedRowInComponent:2]];
    
    if ( [fruitOne isEqualToString:fruitTwo] && [fruitTwo isEqualToString:fruitThree])
    {
        spinResultMessage = @"You Won!";
    }
    
    self.spinnerAlertView = [[UIAlertView alloc] initWithTitle:@"Drumroll please..." message:spinResultMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Re-spin", nil];
    
    self.spinnerAlertView.delegate = self;
    
    [self.spinnerAlertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self spin:nil];
    }
}

@end
