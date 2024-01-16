#!/bin/bash
rm ./node_modules/react-native/Libraries/Renderer/implementations/ReactNativeRenderer-dev.js
cp ./node_modules/react-native-improved/src/ReactNativeRenderer-dev.js ./node_modules/react-native/Libraries/Renderer/implementations/ReactNativeRenderer-dev.js
