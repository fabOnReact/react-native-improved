/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */

#import "RCTModalHostView.h"
#import "RCTModalHostViewImproved.h"
#import "RCTModalHostViewControllerImproved.h"
#import "RCTModalHostViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RCTModalHostViewInteractorImproved;

@interface RCTModalHostViewImproved : RCTModalHostView

@property (nonatomic, weak) id<RCTModalHostViewInteractorImproved> delegate;
@property (nonatomic, strong) UIWindow *modalWindow;

- (void)dismissModalViewControllerWithCompletion:(void (^)(void))completion;

@end

@protocol RCTModalHostViewInteractorImproved <NSObject>

- (void)presentModalHostView:(RCTModalHostView *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;
- (void)dismissModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;
- (void)dismissModalHostViewWithCompletion:(RCTModalHostViewImproved *)modalHostView
                        withViewController:(RCTModalHostViewController *)viewController
                                  animated:(BOOL)animated completion: (void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
