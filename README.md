# SearchDemo

通讯录式搜索模型，搜索功能强大，支持中英文互搜，联想搜索，模糊搜索等。
![image](https://github.com/honeycao/SearchDemo/blob/master/FriendSearchDemo.gif ) 

##导航
1、[功能](https://github.com/honeycao/SearchDemo#功能)
2、[使用方法](https://github.com/honeycao/SearchDemo#使用方法)
3、[Demo使用](https://github.com/honeycao/SearchDemo#Demo使用)
4、[Q-A](https://github.com/honeycao/SearchDemo#Q-A)
5、[后期完善](https://github.com/honeycao/SearchDemo#后期完善)
6、[备注](https://github.com/honeycao/SearchDemo#备注)

##1、功能

* 可对传进去的数据源进行分组，按首字母分组，同时可以获取到数据源中所有的首字母等

* 支持多种搜索：输入内容包含在文字中也可以搜索出来，中文用英文可以进行搜索出来等，满足目前需要的搜索要求

* Demo中有三套搜索，一套是搜索栏滚动式通讯录，第二套是搜索栏固定式通讯录，第三套是单独调用搜索功能

* 做了选中之后的返回传值

##2、使用方法
* 下载并把`HCSearch`添加到项目中
* 如果功能如demo中的第一套和第二套，那么可以按照`SearchViewController`和`AnotherSearchViewController`来做，添加头文件`#import "ZYPinYinSearch.h"`和`#import "ChineseString.h"`
* 如果只需要搜索功能，那么可以模仿第三套功能，只需添加头文件`#import "ZYPinYinSearch.h"`

* 对于获取选中之后的返回值方法在`ViewController`中
```obj-c
SearchViewController *search = [SearchViewController new];
//返回选中搜索的结果
[search didSelectedItem:^(NSString *item) {
cell.detailTextLabel.text = item;
}];

```
##3、Demo使用
* 下载代码最初界面是`ViewController`，三个点击之后的页面分别是:搜索栏滚动式通讯录`SearchViewController`、搜索栏固定式通讯录`AnotherSearchViewController`和单独调用搜索功能`EasySerachViewController`
* 其中`HCSerach`文件夹是集成搜索功能的代码

##4、Q-A
`2016、5、17 update`
* 最近对之前的一些小bug进行修正和界面优化，对于搜索功能，自己测试几遍之后发现，对于搜索数据是中英文数字之外的一些字符可能就会有问题，但是不影响正常人名、地点等的搜索，所以依旧可以放心使用，后期会完善。

`2016、4、7 update`
* 有好多同学用的时候会报错，自己总结了一下，都是由于使用了pch文件（没有用pch那应该是不会出错的），且写法有点差异导致的，头文件都按照下面格式写
```obj-c

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

//你自己用到的其他头文件也写在这里

#import ******

#endif

```

##5、后期完善
* 搜索功能包括对特殊字符的搜索和排序

##6、备注
>I am a rookie ，I am not God （有建议或想法请q：331864805 ，你的点赞是我最大的动力）