//
//  DPPINControl.m
//  Created by David Pickart on 1/20/15.
//

#import "DPPINControl.h"

@implementation DPPINControl
{
    DPPINLabel *_labelA;
    DPPINLabel *_labelB;
    DPPINLabel *_labelC;
    DPPINLabel *_labelD;
    
    UITextField *_hiddenField;
    NSArray *_labels;
    UIView *_clickView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        // Init labels
        _labelA = [DPPINLabel new];
        _labelB = [DPPINLabel new];
        _labelC = [DPPINLabel new];
        _labelD = [DPPINLabel new];
        
        _labels = @[_labelA, _labelB, _labelC, _labelD];
        
        // Add labels to subview and center vertically
        for (DPPINLabel *label in _labels)
        {
            [self addSubview:label];
            [label setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        }
        
        // Default visual attributes
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:@"Helvetica" size:28];
        self.textColor = [UIColor blackColor];
        self.highlightColor = [UIColor colorWithWhite:0 alpha:0.1];
        self.fieldBackroundColor = [UIColor clearColor];
        self.underlineColor = [UIColor blackColor];
        self.underlineWidth = 2;
        self.clipsToBounds = YES;
        
        self.PIN =  @"";
    
        // Add clickable view so controller can be selected
        _clickView = [UIView new];
        [_clickView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickOnPINController)]];
    
        // Add hidden field to hold the actual PIN
        _hiddenField = [UITextField new];
        _hiddenField.keyboardType = UIKeyboardTypeNumberPad;
        _hiddenField.alpha = 0.0f;
        [_hiddenField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:_hiddenField];
        [self addSubview:_clickView];
        [self configureConstraints];
    }

    return self;
}

#pragma mark Drawing

- (void)configureConstraints
{
    // Equally space the four labels
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labelA attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:2.0/13 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labelB attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:5.0/13  constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labelC attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:8.0/13 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labelD attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:11.0/13 constant:0]];
}

- (CGSize)intrinsicContentSize
{
    // Default size is based on label sizes
    return CGSizeMake(_labelA.intrinsicContentSize.width * 6, _labelA.intrinsicContentSize.height);
}

- (void)drawRect:(CGRect)rect
{
    _clickView.frame = rect;
    [super drawRect:rect];
}

- (void)updateLabelsForPIN
{
    // Clear all labels
    for (DPPINLabel *label in _labels)
    {
        label.text = @" ";
        label.backgroundColor = _fieldBackroundColor;
    }
    // Fill in PIN numbers
    for (int i = 0; i < [self.PIN length]; i++)
    {
        DPPINLabel *label = [_labels objectAtIndex:i];
        label.text = [self.PIN substringWithRange:NSMakeRange(i, 1)];
    }
    // Highlight next label
    if ([self.PIN length] < 4)
    {
        [(UILabel *)[_labels objectAtIndex:[self.PIN length]] setBackgroundColor:self.highlightColor];
    }
}


#pragma mark GUI callbacks

- (void)textFieldDidChange:(UITextField *)textField
{
    if (_hiddenField.text.length > 3)
    {
        [_hiddenField resignFirstResponder];
    }
    self.PIN = textField.text;
}

- (void)didClickOnPINController
{
    // Clear PIN if it's full
    if (_hiddenField.text.length > 3)
    {
        self.PIN = @"";
    }

    [_hiddenField becomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_hiddenField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_hiddenField resignFirstResponder];
}

#pragma mark Getters and setters

// Passing along attributes to labels...

- (void)setFont:(UIFont *)font
{
    _font = font;
    for (DPPINLabel *label in _labels)
    {
        label.font = _font;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    for (DPPINLabel *label in _labels)
    {
        label.textColor = _textColor;
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self updateLabelsForPIN];
}

- (void)setUnderlineColor:(UIColor *)underlineColor
{
    _underlineColor = underlineColor;
    for (DPPINLabel *label in _labels)
    {
        label.underlineColor = _underlineColor;
    }
}

- (void)setUnderlineWidth:(CGFloat)underlineWidth
{
    _underlineWidth = underlineWidth;
    for (DPPINLabel *label in _labels)
    {
        label.underlineWidth = _underlineWidth;
    }
}

// PIN is defined as the contents of the hidden field

- (NSString *)PIN
{
    return _hiddenField.text;
}

- (void)setPIN:(NSString *)PIN
{
    _hiddenField.text = PIN;
    [self updateLabelsForPIN];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end

#pragma mark -

@implementation DPPINLabel
{
    CALayer *_border;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
    {
        self.textAlignment = NSTextAlignmentCenter;
        
        // Default visual attributes
        self.backgroundColor= [UIColor clearColor];
        self.underlineColor = [UIColor blackColor];
        self.underlineWidth = 2;
        
        _border = [CALayer layer];
        [self.layer addSublayer:_border];
    }
    return self;
}

#pragma mark Drawing

- (void)drawRect:(CGRect)rect
{
    _border.frame = CGRectMake(0.0f, rect.size.height - self.underlineWidth, rect.size.width, self.underlineWidth);
    [super drawRect:rect];
}

- (CGSize)intrinsicContentSize
{
    // Default size is based on font size
    UITextView *sizeView = [UITextView new];
    sizeView.font = self.font;
    sizeView.text = @"__";
    [sizeView sizeToFit];
    return sizeView.frame.size;
}

#pragma mark Getters and setters

- (void)setUnderlineColor:(UIColor *)underlineColor
{
    _underlineColor = underlineColor;
    _border.backgroundColor = [_underlineColor CGColor];
}

@end

