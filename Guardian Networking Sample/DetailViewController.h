//
//  DetailViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;
@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) Article *article;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
