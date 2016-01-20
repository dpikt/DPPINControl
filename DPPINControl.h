//
//  DPPINControl.m
//  Created by David Pickart on 1/20/15.
//

#import <UIKit/UIKit.h>

@class DPPINLabel;

/** 
UIControl for entering a 4-digit PIN.
Changes to PIN trigger the UIControlEventEditingChanged event.
 */
@interface DPPINControl : UIControl
@property (nonatomic) NSString *PIN;
@property (nonatomic) UIFont *font;
@property (nonatomic) UIColor *highlightColor;
@property (nonatomic) UIColor *fieldBackroundColor;
@property (nonatomic) UIColor *underlineColor;
@property (nonatomic) CGFloat underlineWidth;
@end

/** 
Label for displaying PIN digits
*/
@interface DPPINLabel : UILabel
@property (nonatomic) UIColor *underlineColor;
@property (nonatomic) CGFloat underlineWidth;
@end