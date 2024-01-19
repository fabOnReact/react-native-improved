/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @flow strict-local
 * @format
 */
import * as React from 'react';
import { useCallback, useLayoutEffect, useRef, useState } from 'react';
import { StyleSheet, Text, Platform } from 'react-native';
import createReactNativeComponentClass from 'react-native/Libraries/Renderer/shims/createReactNativeComponentClass';
import useMergeRefs from 'react-native/Libraries/Utilities/useMergeRefs';
import usePressability from 'react-native/Libraries/Pressability/usePressability';
import { createViewConfig } from 'react-native/Libraries/NativeComponent/ViewConfig';
import { Commands } from './TextInputCommands.js';

const textInputViewConfig = {
  uiViewClassName: 'TextView',
};

const NativeTextInputImproved = createReactNativeComponentClass(
  'TextView',
  () => createViewConfig(textInputViewConfig)
);

let RCTSinglelineTextInputNativeCommands = Commands;
let RCTMultilineTextInputNativeCommands = Commands;

function InternalTextInput(props) {
  const inputRef = React.useRef(null);

  const selection =
    props.propsSelection == null
      ? null
      : {
          start: propsSelection.start,
          end: propsSelection.end ?? propsSelection.start,
        };

  const [mostRecentEventCount, setMostRecentEventCount] = React.useState(0);

  const [lastNativeText, setLastNativeText] = React.useState(props.value);
  const [lastNativeSelectionState, setLastNativeSelection] = React.useState({
    selection,
    mostRecentEventCount,
  });

  const lastNativeSelection = lastNativeSelectionState.selection;

  const viewCommands =
    props.multiline === true
      ? RCTMultilineTextInputNativeCommands
      : RCTSinglelineTextInputNativeCommands;

  const text =
    typeof props.value === 'string'
      ? props.value
      : typeof props.defaultValue === 'string'
      ? props.defaultValue
      : '';

  // This is necessary in case native updates the text and JS decides
  // that the update should be ignored and we should stick with the value
  // that we have in JS.
  React.useLayoutEffect(() => {
    const nativeUpdate = {};

    if (lastNativeText !== props.value && typeof props.value === 'string') {
      nativeUpdate.text = props.value;
      setLastNativeText(props.value);
    }

    if (
      selection &&
      lastNativeSelection &&
      (lastNativeSelection.start !== selection.start ||
        lastNativeSelection.end !== selection.end)
    ) {
      nativeUpdate.selection = selection;
      setLastNativeSelection({ selection, mostRecentEventCount });
    }

    if (Object.keys(nativeUpdate).length === 0) {
      return;
    }

    if (inputRef.current != null) {
      viewCommands.setTextAndSelection(
        inputRef.current,
        mostRecentEventCount,
        text,
        selection?.start ?? -1,
        selection?.end ?? -1
      );
    }
  }, [
    mostRecentEventCount,
    inputRef,
    props.value,
    props.defaultValue,
    lastNativeText,
    selection,
    lastNativeSelection,
    text,
    viewCommands,
  ]);

  const setLocalRef = React.useCallback(
    (instance: TextInputInstance | null) => {
      inputRef.current = instance;

      /*
      Hi reader from the future. I'm sorry for this.

      This is a hack. Ideally we would forwardRef to the underlying
      host component. However, since TextInput has it's own methods that can be
      called as well, if we used the standard forwardRef then these
      methods wouldn't be accessible and thus be a breaking change.

      We have a couple of options of how to handle this:
      - Return a new ref with everything we methods from both. This is problematic
        because we need React to also know it is a host component which requires
        internals of the class implementation of the ref.
      - Break the API and have some other way to call one set of the methods or
        the other. This is our long term approach as we want to eventually
        get the methods on host components off the ref. So instead of calling
        ref.measure() you might call ReactNative.measure(ref). This would hopefully
        let the ref for TextInput then have the methods like `.clear`. Or we do it
        the other way and make it TextInput.clear(textInputRef) which would be fine
        too. Either way though is a breaking change that is longer term.
      - Mutate this ref. :( Gross, but accomplishes what we need in the meantime
        before we can get to the long term breaking change.
      */
      if (instance != null) {
        Object.assign(instance, {
          clear(): void {
            if (inputRef.current != null) {
              viewCommands.setTextAndSelection(
                inputRef.current,
                mostRecentEventCount,
                '',
                0,
                0
              );
            }
          },
          // TODO: Fix this returning true on null === null, when no input is focused
          isFocused(): boolean {
            return TextInputState.currentlyFocusedInput() === inputRef.current;
          },
          getNativeRef() {
            return inputRef.current;
          },
          setSelection(start, end) {
            if (inputRef.current != null) {
              viewCommands.setTextAndSelection(
                inputRef.current,
                mostRecentEventCount,
                null,
                start,
                end
              );
            }
          },
        });
      }
    },
    [mostRecentEventCount, viewCommands]
  );

  const ref = useMergeRefs(setLocalRef, props.forwardedRef);

  const _onChange = (event) => {
    const currentText = event.nativeEvent.text;
    props.onChange && props.onChange(event);
    props.onChangeText && props.onChangeText(currentText);

    if (inputRef.current == null) {
      // calling `props.onChange` or `props.onChangeText`
      // may clean up the input itself. Exits here.
      return;
    }

    setLastNativeText(currentText);
    // This must happen last, after we call setLastNativeText.
    // Different ordering can cause bugs when editing AndroidTextInputs
    // with multiple Fragments.
    // We must update this so that controlled input updates work.
    setMostRecentEventCount(event.nativeEvent.eventCount);
  };

  const _onChangeSync = (event) => {
    const currentText = event.nativeEvent.text;
    props.unstable_onChangeSync && props.unstable_onChangeSync(event);
    props.unstable_onChangeTextSync &&
      props.unstable_onChangeTextSync(currentText);

    if (inputRef.current == null) {
      // calling `props.onChange` or `props.onChangeText`
      // may clean up the input itself. Exits here.
      return;
    }

    console.log('currentText', currentText);
    setLastNativeText(currentText);
    // This must happen last, after we call setLastNativeText.
    // Different ordering can cause bugs when editing AndroidTextInputs
    // with multiple Fragments.
    // We must update this so that controlled input updates work.
    setMostRecentEventCount(event.nativeEvent.eventCount);
  };

  const _onFocus = (event) => {
    // TextInputState.focusInput(inputRef.current);
    if (props.onFocus) {
      props.onFocus(event);
    }
  };

  const useOnChangeSync =
    (props.unstable_onChangeSync || props.unstable_onChangeTextSync) &&
    !(props.onChange || props.onChangeText);

  return (
    <NativeTextInputImproved
      {...props}
      mostRecentEventCount={mostRecentEventCount}
      nativeID={props.nativeID}
      onChange={_onChange}
      onChangeSync={useOnChangeSync === true ? _onChangeSync : null}
      onContentSizeChange={props.onContentSizeChange}
      onFocus={_onFocus}
      selection={selection}
      text={text}
    />
  );
}

export const TextInputForwardRef = React.forwardRef(function TextInput(
  props,
  forwardedRef
) {
  return <InternalTextInput {...props} forwardedRef={forwardedRef} />;
});
