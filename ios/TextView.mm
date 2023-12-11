#ifdef RCT_NEW_ARCH_ENABLED
#import "TextView.h"

#import <react/renderer/components/RNTextViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/RNTextViewSpec/EventEmitters.h>
#import <react/renderer/components/RNTextViewSpec/Props.h>
#import <react/renderer/components/RNTextViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"
#import "Utils.h"

using namespace facebook::react;

@interface TextView () <RCTTextViewViewProtocol>

@end

@implementation TextView {
    UIView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<TextViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const TextViewProps>();
    _props = defaultProps;

    _view = [[UIView alloc] init];

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<TextViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<TextViewProps const>(props);

    if (oldViewProps.color != newViewProps.color) {
        NSString * colorToConvert = [[NSString alloc] initWithUTF8String: newViewProps.color.c_str()];
        [_view setBackgroundColor: [Utils hexStringToColor:colorToConvert]];
    }

    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> TextViewCls(void)
{
    return TextView.class;
}

@end
#endif
