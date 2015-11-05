/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var ble = require('NativeModules').BluetoothLE;
var UIImagePickerManager = require('NativeModules').UIImagePickerManager;
var Firebase = require('firebase');

var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  PixelRatio,
  TouchableOpacity,
  Image,
  NativeModules: {
    UIImagePickerManager
  }
} = React;

var myFirebaseRef = new Firebase("https://memoryobjects.firebaseio.com/");

var MemoryObjects = React.createClass({
  getInitialState : function(){
    return {
      avatarSource: null
    };
  },

  avatarTapped: function() {
    const options = {
      title: null,
      quality: 0.5,
      storageOptions: {
        skipBackup: true
      }
    };

    UIImagePickerManager.showImagePicker(options, (didCancel, response) => {
      console.log('Response = ', response);

      if (didCancel) {
        console.log('User cancelled image picker');
      }
      else {
        if (response.customButton) {
          console.log('User tapped custom button: ', response.customButton);
        }
        else {
          // You can display the image using either:
          //const source = {uri: 'data:image/jpeg;base64,' + response.data, isStatic: true};
          const source = {uri: response.uri.replace('file://', ''), isStatic: true};

          this.setState({
            avatarSource: source
          });
        }
      }
    });
  },

  render: function() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Chester Testing!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <TouchableOpacity onPress={this.avatarTapped}>
          <View style={[styles.avatar, styles.avatarContainer]}>
          { this.state.avatarSource === null ? <Text>Select a Photo</Text> :
            <Image style={styles.avatar} source={this.state.avatarSource} />
          }
          </View>
        </TouchableOpacity>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  avatarContainer: {
    borderColor: '#9B9B9B',
    borderWidth: 1 / PixelRatio.get(),
    justifyContent: 'center',
    alignItems: 'center'
  },
  avatar: {
    borderRadius: 75,
    width: 150,
    height: 150
  }
});

AppRegistry.registerComponent('MemoryObjects', () => MemoryObjects);
