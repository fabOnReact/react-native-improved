import createReactNativeComponentClass from 'react-native/Libraries/Renderer/shims/createReactNativeComponentClass';
import { createViewConfig } from 'react-native/Libraries/NativeComponent/ViewConfig';

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
  uiViewClassName: 'TextViewImproved',
};

const NativeTextImproved = createReactNativeComponentClass(
  'TextViewImproved',
  () => createViewConfig(textViewConfig)
);

export const TextViewImproved = (props) => {
  return <NativeTextImproved {...props} />;
};
console.log('----------');
console.log('typeof TextViewImproved', typeof TextViewImproved);
console.log('typeof TextViewImproved()', typeof TextViewImproved());
console.log('----------');

// TextView.displayName = 'TextView';
