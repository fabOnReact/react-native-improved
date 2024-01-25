# react-native-improved


- **Supports only react-native 0.73**.
- Support for other versions will be added in the future ([#18](https://github.com/fabOnReact/react-native-improved/issues/18)).

Provides different react-native iOS, Android and JS API fixes/PRs.

- Text: PR https://github.com/facebook/react-native/pull/41770
- TextInput: PR https://github.com/facebook/react-native/pull/29070
- Modal: PR https://github.com/facebook/react-native/pull/31498

## Set-up

In package.json

```diff
 "scripts": {
+  "postinstall": "yarn patch"
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

## Feature Requests

If you want to ask for additional features in this library, you can open an [issue](https://github.com/fabriziobertoglio1987/react-native-improved/issues). I will follow-up with your request.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.


## License

MIT
