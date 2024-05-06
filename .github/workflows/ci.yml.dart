on:
push:
branches:
- main

name: Template-Flutter-MVVM-Repo-Bloc

jobs:
build:
name: Build and Release new apk
runs-on: ubuntu-latest
env:
KEYSTORE: ${{ secrets.KEYSTORE }}
KEY_PATH: ${{ secrets.KEY_PATH}}
KEY_PASS: ${{ secrets.KEY_PASSWORD }}
KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
STORE_PASS: ${{ secrets.KEYSTORE_PASSWORD }}

steps:

- uses: actions/checkout@v3
- uses: actions/setup-java@v2
with:
distribution: 'zulu'
java-version: '11'

- uses: subosito/flutter-action@v2
with:
channel: 'stable'

- run: echo $KEYSTORE | base64 -di >  ${{secrets.KEY_PATH}}
- run: flutter clean
- run: flutter pub get
- run: flutter build apk -t lib/main.dart

- name: Upload Android Artifact
uses: actions/upload-artifact@v2.3.1
with:
name: Android Build Artifact
path: build/app/outputs/apk/prod/release