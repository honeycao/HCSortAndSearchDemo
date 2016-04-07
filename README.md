# SearchDemo

全方位搜索功能，支持中英文互搜，联想搜索等
![image](https://github.com/honeycao/SearchDemo/blob/master/FriendSearch.gif ) 

>对网上一些搜索代码的总结，功能基本都可以

##1、实现功能

* 自动对传进去的数据分组，按首字母分组

* 支持多种搜索：输入内容包含在文字中也可以搜索出来，中文用英文可以进行搜索出来等，满足目前需要的搜索任务

* 做了两套搜索，一套是固定的搜索框，另外一套是搜索框随着`tableview`滚动而滚动

`2016、4、7 update`

##2、注意事项

####有好多同学用的时候会报错，自己总结了一下，都是由于使用了pch文件，且写法有点差异导致的，其中下面两个头文件必须这么写才可以。
```obj-c

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#endif

```

##3、其他
* 有问题可以联系我  qq：331864805  （你的点赞是我最大的动力）