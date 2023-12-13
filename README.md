# react-native-improved

Improved React Components, currently only Text (Android).

## Installation

**IMPORTANT**: to be used requires to patch the react-native-renderer for dev and prop as done in this [file](https://github.com/fabriziobertoglio1987/react-native-improved/blob/main/example/patches/react-native%2B0.73.0%2B001%2Bfix-renderer-text-runtime.patch) with patch package.

```sh
npm install react-native-improved
```

## Usage

```js
import { TextImproved } from 'react-native-improved';

// ...

<TextImproved>My new text works</Text>;
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
