//
//  BasicSearchViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicSearchViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)searchBtnPressed:(UIButton *)sender;
- (IBAction)clearBtnPressed:(UIButton *)sender;

@end
