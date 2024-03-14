# react-native-improved


- **Supports ONLY react-native 0.73**.
- Supports only old architechture (new architechture is WIP)
- Support for other versions will be added in the future ([#24](https://github.com/fabOnReact/react-native-improved/issues/24)).

Provides different react-native iOS, Android and JS API fixes/PRs.

- Text: PR https://github.com/facebook/react-native/pull/41770
- TextInput: PR https://github.com/facebook/react-native/pull/29070
- Modal: PR https://github.com/facebook/react-native/pull/31498

## Set-up

In package.json

```diff
 "scripts": {
+  "postinstall": "yarn run react-native-patch"
 }
```

Then

## npm

```sh
npm install react-native-improved --save-dev
```

## yarn v1

```sh
yarn add react-native-improved --dev
```

## yarn v2, v3, v4

```sh
yarn add react-native-improved --dev
```

create a file `.yarnrc.yml` (or add to your existing one) with:

```
nodeLinker: node-modules
```

## Feature Requests

If you want to ask for additional features in this library, you can open an [issue](https://github.com/fabriziobertoglio1987/react-native-improved/issues). I will follow-up with your request.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.


## License

MIT
