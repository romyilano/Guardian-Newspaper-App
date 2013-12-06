//
//  ViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
// Abstract: simple view controller to show latest iphone related
// articles on guardian. Just using this as a test class

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *articleButton;

@property (strong, nonatomic) NSDictionary *jsonDictionary;

- (IBAction)summonarticlebtnPressed:(UIButton *)sender;

@end