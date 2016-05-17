# SearchDemo

通讯录式搜索模型，搜索功能强大，支持中英文互搜，联想搜索，模糊搜索等。
![image](https://github.com/honeycao/SearchDemo/blob/master/FriendSearchDemo.gif ) 

##导航


##1、功能

* 可对传进去的数据源进行分组，按首字母分组，同时可以获取到数据源中所有的首字母等

* 支持多种搜索：输入内容包含在文字中也可以搜索出来，中文用英文可以进行搜索出来等，满足目前需要的搜索要求

* 做了两套搜索，一套是固定的搜索框，另外一套是搜索框随着`tableview`滚动而滚动


##2、使用方法
* 
* 如果demo中的模型和搜索都需要，那么可以按照`SearchViewController`和`AnotherSearchViewController`来做

`2016、4、7 update`

##2、注意事项

####有好多同学用的时候会报错，自己总结了一下，都是由于使用了pch文件（没有用pch那应该是不会出错的），且写法有点差异导致的，头文件都按照下面格式写
```obj-c

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

//你自己用到的其他头文件也写在这里

#import ******

#endif

```

##3、其他
* 有问题可以联系我  qq：331864805  （你的点赞是我最大的动力）