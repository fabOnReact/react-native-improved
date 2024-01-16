# react-native-improved

Provides react-native components with different fixes (only tested on the old architecture):

- TextImproved https://github.com/facebook/react-native/pull/41770

## Set-up

In package.json

```diff
 "scripts": {
+  "postinstall": "./node_modules/react-native-improved/src/react_native_renderer_patch.sh"
 }
```

Then

## npm

```sh
npm install react-native-improved
```

## yarn

```sh
yarn add react-native-improved
```

## Usage

```js
import { TextImproved } from 'react-native-improved';

// ...

<TextImproved>A new text with additional fixes</TextImproved>;
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
