ios.darkmode.discovery
======================
Discovery project for iOS Dark Mode with samples and demo content.

## Table of contents

1. [Introductory remarks](#introductory)
2. [Releasing Dark Mode option](#darkmode)
    + [Settings App for option Release](#darkmodesettingsapp)
    + [Using Dark Mode option in the App](#darkmodeinsidetheapp)
3. [Custom Colors](#customcolors)
4. [Adapted Colors](#adaptedcolors)
5. [Dynamic Image](#dynamicimage)
6. [Licenses](#licenses)

## Introductory remarks <a name="introductory"></a>

Key points: Dark Mode, Custom Colors, Adapted Colors, and Dynamic Images—brought to life with [Perseus Dark Mode](https://github.com/perseusrealdeal/DarkMode.git).

| Main Screen Light  | Details Screen Light | Main Screen Dark | Details Screen Dark |
| :--------------------: | :----------------------: | :-------------------: | :---------------------: |
| <img src="Images/MainScreenLight.png" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> | <img src="Images/DetailsScreenLight.png" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> | <img src="Images/MainScreenDark.png" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> | <img src="Images/DetailsScreenDark.png" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> |

## Releasing Dark Mode option <a name="darkmode"></a>

### Settings App for option Release <a name="darkmodesettingsapp"></a>

`The first step:` describing user interface using settings bundle—screenshots and Root.plist are below.

| Settings App Screen: Option | Settings App Screen: Values |
| :-------------------------------: | :-------------------------------: |
| <img src="Images/DarkModeOptionScreen.png" width="230" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> | <img src="Images/DarkModeValuesScreen.png" width="230" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/> |

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>StringsTable</key>
    <string>Root</string>
    <key>PreferenceSpecifiers</key>
    <array>
        <dict>
            <key>Type</key>
            <string>PSMultiValueSpecifier</string>
            <key>Title</key>
            <string>Appearance Mode</string>
            <key>Key</key>
            <string>dark_mode_preference</string>
            <key>DefaultValue</key>
            <integer>0</integer>
            <key>Titles</key>
            <array>
                <string>Light</string>
                <string>Dark</string>
                <string>Auto</string>
            </array>
            <key>Values</key>
            <array>
                <integer>2</integer>
                <integer>1</integer>
                <integer>0</integer>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

`The second step:` make the option's business logic getting work.

One of the most reliable way to make the option's business logic of Dark Mode Option from Settings App getting work is processing `UIApplication.didBecomeActiveNotification` event when `viewWillAppear`/`viewWillDisappear` called.

```swift
override func viewWillAppear(_ animated: Bool)
{
    super.viewWillAppear(animated)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(theAppDidBecomeActive),
                                           name    : UIApplication.didBecomeActiveNotification,
                                           object  : nil)
}

override func viewWillDisappear(_ animated: Bool)
{
    super.viewWillDisappear(animated)
    
    NotificationCenter.default.removeObserver(self,
                                      name  : UIApplication.didBecomeActiveNotification,
                                      object: nil)
}
```

`The third step:` process Dark Mode Settings value on `UIApplication.didBecomeActiveNotification` event.

```swift
@objc func theAppDidBecomeActive()
{
    // Check Dark Mode in Settings
    if let choice = isDarkModeSettingsChanged()
    {
        changeDarkModeManually(choice)
    }
}
```
`The fourth step:` change Appearance Style if Dark Mode option has changed.

```swift
import UIKit
import PerseusDarkMode

public let DARK_MODE_SETTINGS_KEY = "dark_mode_preference"

func changeDarkModeManually(_ userChoice: DarkModeOption)
{
    // Change Dark Mode value in settings bundle
    UserDefaults.standard.setValue(userChoice.rawValue, forKey: DARK_MODE_SETTINGS_KEY)
    
    // Change Dark Mode value in Perseus Dark Mode library
    AppearanceService.DarkModeUserChoice = userChoice
    
    // Update appearance in accoring with changed Dark Mode Style
    AppearanceService.makeUp()
}

func isDarkModeSettingsChanged() -> DarkModeOption?
{
    // Load enum int value from settings
    
    let option = UserDefaults.standard.valueExists(forKey: DARK_MODE_SETTINGS_KEY) ?
        UserDefaults.standard.integer(forKey: DARK_MODE_SETTINGS_KEY) : -1
    
    // Try to cast int value to enum
    
    guard option != -1, let settingsDarkMode = DarkModeOption.init(rawValue: option)
    else { return nil }
    
    // Report change
    
    return settingsDarkMode != AppearanceService.DarkModeUserChoice ? settingsDarkMode : nil
}
```


### Using Dark Mode option in the App <a name="darkmodeinsidetheapp"></a>

TODO: Screenshots of Dark Mode Option Usage of The App. 

TODO: Sample Code.

## Custom Colors <a name="customcolors"></a>

TODO: Sample Code.

USE: Custom TEAL color based on the apple specification as a sample.

## Adapted Colors <a name="adaptedcolors"></a>

`Adapted System Colors`

TODO: Screenshot of System Colors tab.

TODO: Code Sample.

`Adapted Semantic Colors`

TODO: Screenshot of Semantic Colors tab.

TODO: Code Sample

## Dynamic Image <a name="dynamicimage"></a>

TODO: Screenshot of Dynamic Image.

TODO: Code Sample.

## Licenses <a name="licenses"></a>

`License for this app`

```
Copyright (c) 2022 Mikhail Zhigulin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

`License for the usage of HexColorConverter.swift as the third party code`

LINK: [UIColor-Hex-Swift repository](https://github.com/SeRG1k17/UIColor-Hex-Swift.git).

The top lines from the origin code used as the third party code:

```
//  StringExtension.swift
//  HEXColor-iOS
//
//  Created by Sergey Pugach on 2/2/18.
//  Copyright © 2018 P.D.Q. All rights reserved.
```
License from the root of [UIColor-Hex-Swift repository](https://github.com/SeRG1k17/UIColor-Hex-Swift.git):

```
Copyright (c) 2014 R0CKSTAR

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
