// This guard prevent this file to be compiled in the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>

#ifndef TextViewNativeComponent_h
#define TextViewNativeComponent_h

NS_ASSUME_NONNULL_BEGIN

@interface TextView : RCTViewComponentView
@end

NS_ASSUME_NONNULL_END

#endif /* TextViewNativeComponent_h */
#endif /* RCT_NEW_ARCH_ENABLED */
