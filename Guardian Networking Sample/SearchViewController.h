//
//  SearchViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;

@property (strong, nonatomic) NSArray *articles;

- (IBAction)goButtonPressed:(UIButton *)sender;
- (IBAction)clearButtonPressed:(UIButton *)sender;


@end
