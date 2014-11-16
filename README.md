AHTabBarController
==================

 A traditional UITabBarController with possibilities of adding multiple items behind every tab.


Introduction
--------
This control can be seen as an extension of Apple's UITabBarController. Though it is not a subclass, it has the same behaviour as a normal UITabBarController for tabs with a single subitem. You can, however, chose to add more subitems to one single tab which will make the tabbar animate upwards revealing all the subitems added to the tab.

![AHTabBarController](https://raw.githubusercontent.com/ArthurDevNL/AHTabBarController/master/AHTabBarController.gif)


Usage
--------
Using this control is fairly easy. For each tab you want to see in the tab bar you must create an AHTabView instance and set its image and title.

```objective-c
    AHTabView *tab = [AHTabView new];
    [tab setImage:myImage];
    [tab setTitle:@"myTitle"];
```

After you've created this tab instance you'll be able to add items to it. As explained, if you only add one subitem to a tab the menu will not be expended when a user presses on it and will behave like a normal UITabBar instead. If you add more than one item you'll see the menu expending.


```objective-c
    AHSubitemView *item1 = [AHSubitemView new];
    [item1 setImage:myImage1];
    [item1 setTitle:myTitle1];
    [item1 setViewControllerIdentifier:myViewControllerIdentifier1];
    [tab addSubitem:item1];
    
    AHSubitemView *item2 = [AHSubitemView new];
    [item2 setImage:myImage2];
    [item2 setTitle:myTitle2];
    [item2 setViewControllerIdentifier:myViewControllerIdentifier2];
    [tab addSubitem:item2];
```

When you're done creating tabs and adding subitems you must not forget to add the tabs to the tabBarController.

```objective-c
    [tabBarController.tabs addObject:tab];
```

Customization
--------
Though the amount of customizations on this control are pretty limited there are some that might come in handy.

 * Setting the highlighted tintColor of the tabs and subitems: _selectedColor_.
 * Setting the subitem height: _subitemHeight_.
 * Setting the tab bar height: _tabBarHeight_.
 * If you don't want the tab bar to animate you can set _shouldTabBarAnimate_ to NO.

CocoaPods
--------
You can easily add this control to your project by adding it to your Podfile.

```ruby
platform :ios, '7.0'
pod "AHTabBarController"
```

Todo
--------

 * Instead of setting the StoryboardID of a viewcontroller add the possibility to add the viewcontroller directly to the tab.
 * If the number of subitem exceeds the number of items that can be viewed on screen it won't do anything yet. Would be great if it would scroll though I don't recommend you add that many items to your tabs.
 * More customization features

License
--------
AHTabBarController uses the MIT License:

> Please see included [LICENSE file](https://github.com/ArthurDevNL/AHTabBarController/blob/master/LICENSE).
