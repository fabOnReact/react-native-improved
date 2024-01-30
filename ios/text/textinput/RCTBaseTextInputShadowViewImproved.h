/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */

#import "RCTBaseTextShadowView.h"
#import <React/RCTBaseTextInputShadowView.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTBaseTextInputShadowViewImproved : RCTBaseTextInputShadowView

- (instancetype)initWithBridge:(RCTBridge *)bridge;

@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSString *placeholder;
@property (nonatomic, assign) NSInteger maximumNumberOfLines;
@property (nonatomic, copy, nullable) RCTDirectEventBlock onContentSizeChange;

- (void)uiManagerWillPerformMounting;

@end

NS_ASSUME_NONNULL_END
