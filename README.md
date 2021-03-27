# AuthPM

Created by Kononenko Yevhen and Hrytsun Yaroslav.

Flexible Swift Package Manager for Google/Facebook Authorization.
We create this SPM without Google and Facebook SDK.

## Screenshots

Main View                  |  Second Screen View
:-------------------------:|:-------------------------------:
![](http://i.piccy.info/i9/40c8e3726d56858638d76685b147303a/1616875723/41106/1422865/12899pmauthbuttonscr.jpg)|  ![](http://i.piccy.info/i9/4dcac3d927871f5f5fd14b5f466cb60f/1616875760/207432/1422865/44886SocialsView_kopyia.png)

## Installation

Insert url of this SPM in you XCode Project with `Open -> Swift Package -> Add Package Dependency`. Import this library to you `ViewController` with:
``` swift
import AuthPM
```
Then you should initiate an instance:
``` swift
let authPM = AuthPM(appId: 'YOUR_APP_ID', deepLinkingScheme: 'YOUR_URL_SCHEME')
```
After all of this operations call this function in your ViewController `viewDidLoad`.
``` swift
AuthPM.getAuthButton()
```

## Details

This implementation uses `ASWebAuthenticationSession` to securely show a web view pointing to the Facebook and Google.

## Dependencies

- [PMNetworking](https://github.com/gr-yarik/PMNetworking) - unique Networking SPM
- XCode 12.4
- Swift 5.4





