# CVStackViewSeparator

A drop-in library for adding separators in `UIStackView`.

## Screenshot
![](https://github.com/unixzii/CVStackViewSeparator/raw/master/Images/screenshot.png)

## Features
* Super easy to use, no need any subclassing, it's just a extension for native `UIStackView`.
* Supports customizing thickness, color and length.

## Usage
Take a breath.

**Step 1.** Drop the `UIStackView+Separator.m` and `UIStackView+Separator.h` to your project.

**Step 2.** Add below line of code to wherever you want to apply the separators:
```objective-c
#import "UIStackView+Separator.h"
```

**Step 3.** Grab the stack view instance and set these property:
* `separatorColor`: Color of the separator, if it was set to `nil`, then the separator won't be created.
* `separatorLength`: Length of the separator, if it was set to zero or a negative value, then the separator won't be created.
* `separatorThickness`: Width of the separator.

All done.

## Contributing
The project is not completed actually, if you want some more features, just open up a Pull Request or Issue.

## License
The project is available under the MIT license. See the LICENSE file for more info.
