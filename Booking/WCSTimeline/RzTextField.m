//
//  RzTextField.h
//  YRTextField
//
//  Created by Yogesh Raj on 02/06/17.
//  Copyright © 2017 RzGames. All rights reserved.
//

#import "RzTextField.h"

@implementation RzTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
        [self applyStyle];
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self applyStyle];
}

- (void)applyStyle
{
    //[self setBorderStyle:UITextBorderStyleLine];
    
    [self setFont: [UIFont systemFontOfSize:17]];
    
    if ([self respondsToSelector:@selector(setTintColor:)])
        [self setTintColor:[UIColor whiteColor]];

    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setNeedsAppearance:(id)sender
{
    YRTextField *textField = (YRTextField*)sender;
    
    if (![textField isEnabled])
        [self setBackgroundColor:[UIColor whiteColor]];
    else if (![textField isValid])
        [self setBackgroundColor:[UIColor whiteColor]];
    else
        [self setBackgroundColor:[UIColor whiteColor]];
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 5);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
    [layer setBorderWidth: 0.8];
    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
    
    [layer setCornerRadius:3.0];
    [layer setShadowOpacity:1.0];
    [layer setShadowColor:[UIColor redColor].CGColor];
    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
}

- (void) drawPlaceholderInRect:(CGRect)rect {
#if __IPHONE_OS_VERSION_MIN_REQUIRED == __IPHONE_7_0
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
    [self.placeholder drawInRect:CGRectInset(rect, 5, 5) withAttributes:attributes];
#endif
}

@end
