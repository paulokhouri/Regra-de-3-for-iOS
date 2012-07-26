//
//  ViewController.h
//  Regra de 3
//
//  Created by Paulo Khouri on 11/8/11.
//  Copyright (c) 2011 Mobilitate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *quantity1;
@property (retain, nonatomic) IBOutlet UITextField *price1;
@property (retain, nonatomic) IBOutlet UITextField *quantity2;
@property (retain, nonatomic) IBOutlet UITextField *price2;
@property (retain, nonatomic) IBOutlet UILabel *result;

@end
