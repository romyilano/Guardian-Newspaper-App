//
//  SearchChoicesViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/23/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchChoicesViewController : UIViewController <UITextFieldDelegate,  UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)searchBtnPressed:(UIButton *)sender;
- (IBAction)clearBtnPressed:(UIButton *)sender;

@end
