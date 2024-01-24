# react-native-improved

Provides different react-native iOS, Android and JS API fixes/PRs.

- Text: PR https://github.com/facebook/react-native/pull/41770
- TextInput: PR https://github.com/facebook/react-native/pull/29070

The library is still Work In Progress.

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

## License

MIT
