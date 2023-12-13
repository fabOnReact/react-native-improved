# react-native-improved

Provides react-native components with different fixes (only tested on the old architecture):
- TextImproved https://github.com/facebook/react-native/pull/41770

## Installation

**IMPORTANT**: to use this package you need to apply a patch to react-native-renderer for dev and prod. The patch is available [here](https://github.com/fabriziobertoglio1987/react-native-improved/blob/main/example/patches/react-native%2B0.73.0%2B001%2Bfix-renderer-text-runtime.patch) and is applied with patch-package to react-native 0.73. We are waiting the merge of PR https://github.com/facebook/react/pull/27833 to remove this step.

```sh
npm install react-native-improved
```

## Usage

```js
import { TextImproved } from 'react-native-improved';

// ...

<TextImproved>A new text with additional fixes</Text>;
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
