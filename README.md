# DPPINControl

Sometimes four lines is all you need for simple and versatile PIN entry.

This control comes in handy any time you want PIN entry without using a whole separate view. Customize font, size, color, and line thickness to your heart's content.

## How to use:

Add DPPINControl.h and DPPINControl.m to your project.
Then, in your view controller:

```
#import "DPPINControl.h"

...

_PINControl = [DPPINControl new];
[_PINControl addTarget:self action:@selector(onPINControl:) forControlEvents:UIControlEventEditingChanged];
[self.view addSubview:_PINControl];
```

Use autolayouts to adjust position and (optionally) size.
Then add a handler:

```
- (void)onPINControl:(id)control
{
   NSLog(@"%@", [(DPPINControl *)control PIN]);
}
```
And you're done!

## Visual examples:

![Example 1](http://i.imgur.com/XaKdly3.png)

![Example 2](http://i.imgur.com/Tw1v8gH.png)

![Example 3](http://i.imgur.com/4oCFdFl.png)
