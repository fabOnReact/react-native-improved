import { AppRegistry } from 'react-native';
import { name as appName } from './app.json';
import RNTesterApp from './src/RNTesterAppShared';

AppRegistry.registerComponent(appName, () => RNTesterApp);
