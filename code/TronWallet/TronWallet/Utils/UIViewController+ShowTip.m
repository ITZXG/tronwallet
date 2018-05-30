//
//  UIViewController+ShowTip.m
//  TronWallet
//
//  Created by chunhui on 2018/5/29.
//  Copyright © 2018年 onesmile. All rights reserved.
//

#import "UIViewController+ShowTip.h"

@implementation UIViewController (ShowTip)

-(void)showAlert:(NSString *)title mssage:(NSString *)msg confrim:(NSString *)confirm cancel:(NSString *)cancel
{
    [self showAlert:title mssage:msg confrim:confirm cancel:cancel confirmAction:nil];
}

-(void)showAlert:(NSString *)title mssage:(NSString *)msg confrim:(NSString *)confirm cancel:(NSString *)cancel confirmAction:(void(^)(void))confirmAction
{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    if (confirm.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmAction) {
                confirmAction();
            }
        }];
        [controller addAction:action];
    }
    if (cancel.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [controller addAction:action];
    }
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)showPasswordAlert:(NSString *)title mssage:(NSString *)msg confrim:(NSString *)confirm cancel:(NSString *)cancel confirmAction:(void(^)(void))confirmAction
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Input password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }];
    
    if (confirm.length > 0) {
        __weak typeof(self) wself = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *passField  = [controller.textFields firstObject];
            NSString *pwd = [passField text];
            if (![AppWalletClient isRightPassword:pwd]) {
                
                [wself showAlert:nil mssage:@"wrong password" confrim:@"Confirm" cancel:nil];
                
                return ;
            }

            
            if (confirmAction) {
                confirmAction();
            }
        }];
        [controller addAction:action];
    }
    if (cancel.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [controller addAction:action];
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

-(MBProgressHUD *)showHud
{
    return [self showHudTitle:nil];
}

-(MBProgressHUD *)showHudTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (title) {
        hud.label.text = title;
    }
    return hud;
}



@end
