//
//  ViewController.m
//  Regra de 3
//
//  Created by Paulo Khouri on 11/8/11.
//  Copyright (c) 2011 Mobilitate. All rights reserved.
//

#import "ViewController.h"
#import "RegexKitLite.h"
#import "InneractiveAd.h"

@implementation ViewController
@synthesize quantity1;
@synthesize price1;
@synthesize quantity2;
@synthesize price2;
@synthesize result;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)calc
{
    CGFloat fQuantity1 = [self.quantity1.text floatValue];
    CGFloat fPrice1 = [self.price1.text floatValue];
    CGFloat fQuantity2 = [self.quantity2.text floatValue];
    CGFloat fPrice2 = [self.price2.text floatValue];
    CGFloat rPrice = 0;

    if (fQuantity1 > fQuantity2 && fPrice1 > fPrice2) 
    {
        rPrice = (fQuantity1 * fPrice2) / fQuantity2;
        if (fPrice1 > rPrice) 
        {
            rPrice = fPrice1 - rPrice;
            
            [result setText:[NSString stringWithFormat:@"Compensa mais comprar o segundo produto, por uma diferença de R$%.2f!!", rPrice]];
        } else if (fPrice1 < rPrice)
        {
            rPrice = rPrice - fPrice1;
            [result setText:[NSString stringWithFormat:@"Compensa mais comprar o primeiro produto, por uma diferença de R$%.2f!!", rPrice]];
        }
    } 
    else if (fQuantity1 < fQuantity2 && fPrice1 < fPrice2)
    {
        rPrice = (fQuantity2 * fPrice1) / fQuantity1;
        if (fPrice2 > rPrice) 
        {
            rPrice = fPrice2 - rPrice;
            [result setText:[NSString stringWithFormat:@"Compensa mais comprar o primeiro produto, por uma diferença de R$%.2f!!", rPrice]];
        } else if (fPrice2 < rPrice) {
            rPrice = rPrice - fPrice2;
            [result setText:[NSString stringWithFormat:@"Compensa mais comprar o segundo produto, por uma diferença de R$%.2f!!", rPrice]];
        }
    } else if (fQuantity1 > fQuantity2 && fPrice1 < fPrice2)
    {
        [result setText:[NSString stringWithFormat:@"Já que o primeiro produto tem a quantidade maior e o preco menor, não resta dúvida, concorda?"]];
    } else if (fQuantity1 < fQuantity2 && fPrice1 > fPrice2)
    {
        [result setText:[NSString stringWithFormat:@"Já que o segundo produto tem a quantidade maior e o preco menor, não resta dúvida, concorda?"]];
    }
    else if (fQuantity1 == fQuantity2 && fPrice1 != fPrice2)
    {
        [result setText:[NSString stringWithFormat:@"Já que ambos possuem a mesma quantidade, por que não levar o mais barato?!?!"]];
    } 
    else if (fPrice1 == fPrice2 && fQuantity1 != fQuantity2)
    {
        [result setText:[NSString stringWithFormat:@"Já que ambos possuem o mesmo preço, por que não levar o que contém mais?!?!", rPrice]];
    }
    else if ([self.price1.text isEqualToString:@""] || [self.price2.text isEqualToString:@""] || [self.quantity1.text isEqualToString:@""] || [self.quantity2.text isEqualToString:@""]) {
        [result setText:@"Ooopsss, você não está se esquecendo de nada não?"];
    }
    else {
        [result setText:@"Ó, os valores estão equivalentes ;)"];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isMatchedByRegex:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"]) {
        return true;
    }
    return false;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            [self.price1 becomeFirstResponder];
            break;
        case 2:
            [self.quantity2 becomeFirstResponder];
            break;
        case 3:
            [self.price2 becomeFirstResponder];
            break;
        default:
            [self.price2 resignFirstResponder];
            [self calc];
            break;
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self.quantity1.text isEqualToString:@""] && ![self.price1.text isEqualToString:@""] && ![self.quantity2.text isEqualToString:@""] && ![self.price2.text isEqualToString:@""]) {
        [self calc];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //If ! show Mobilitate's logo :)
    [InneractiveAd DisplayAd:@"Mobilitate_Compare_iPhone" withType:IaAdType_Banner withRoot:self.view withReload:120];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    [background release];
    
	[self.quantity1 setTag:1];
    [self.quantity1 setDelegate:self];
    [self.price1 setTag:2];
    [self.price1 setDelegate:self];
    [self.quantity2 setTag:3];
    [self.quantity2 setDelegate:self];
    [self.price2 setTag:4];
    [self.price2 setDelegate:self];
}

- (void)viewDidUnload
{
    [self setQuantity1:nil];
    [self setPrice1:nil];
    [self setQuantity2:nil];
    [self setPrice2:nil];
    [self setResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationLandscapeLeft || interfaceOrientation != UIInterfaceOrientationLandscapeRight);
    }
    return YES;
}

- (void)dealloc {
    [quantity1 release];
    [price1 release];
    [quantity2 release];
    [price2 release];
    [result release];
    [super dealloc];
}
@end
