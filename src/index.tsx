import createReactNativeComponentClass from 'react-native/Libraries/Renderer/shims/createReactNativeComponentClass';
import { createViewConfig } from 'react-native/Libraries/NativeComponent/ViewConfig';
import { Text, Platform } from 'react-native';

const textViewConfig = {
  validAttributes: {
    isHighlighted: true,
    isPressable: true,
    numberOfLines: true,
    ellipsizeMode: true,
    allowFontScaling: true,
    dynamicTypeRamp: true,
    maxFontSizeMultiplier: true,
    disabled: true,
    selectable: true,
    selectionColor: true,
    adjustsFontSizeToFit: true,
    minimumFontScale: true,
    textBreakStrategy: true,
    onTextLayout: true,
    onInlineViewLayout: true,
    dataDetectorType: true,
    android_hyphenationFrequency: true,
    lineBreakStrategyIOS: true,
  },
  directEventTypes: {
    topTextLayout: {
      registrationName: 'onTextLayout',
    },
    topInlineViewLayout: {
      registrationName: 'onInlineViewLayout',
    },
  },
  uiViewClassName: 'RCTTextImproved',
};

const NativeTextImproved = createReactNativeComponentClass(
  'RCTTextImproved',
  () => createViewConfig(textViewConfig)
);

export const TextViewImproved = (props) => {
  const TextComponent =
    Platform.OS == 'ios' ? (
      <Text {...props} />
    ) : (
      <NativeTextImproved {...props} />
    );
  return TextComponent;
};
