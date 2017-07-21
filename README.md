# HCSortAndSearchDemo

通讯录式排序搜索模型，首字母排序、中英文混排等；搜索功能强大，支持中英文互搜，联想搜索，模糊搜索等。

![image](https://github.com/honeycao/HCSortAndSearchDemo/blob/master/HCSortAndSearch.gif) 

------
## 导航
1、[功能](https://github.com/honeycao/HCSortAndSearchDemo#功能)

2、[使用方法](https://github.com/honeycao/HCSortAndSearchDemo#使用方法)

3、[Demo使用](https://github.com/honeycao/HCSortAndSearchDemo#Demo使用)

4、[Q-A](https://github.com/honeycao/HCSortAndSearchDemo#Q-A)

5、[后期完善](https://github.com/honeycao/HCSortAndSearchDemo#后期完善)

6、[备注](https://github.com/honeycao/HCSortAndSearchDemo#备注)

------

## 1、功能

* 支持对数组排序，包括字符串数组和model数组

* 按首字母排序，二级排序，或model下按照传入属性排序

* 支持多种搜索：输入内容包含在文字中也可以搜索出来，中文用英文可以进行搜索出来等，满足目前需要的搜索要求

* Demo中有四套搜索，一套是搜索栏滚动式通讯录，第二套是搜索栏固定式通讯录，第三套是单独调用搜索功能，第四套是举例说明如何传入一个model数组完美进行排序和搜索

* 做了选中之后的返回传值

## 2、使用方法

* 下载并把Demo中的`HCSortAndSearch`添加到自己项目中，相关方法如下

```obj-c
/**
*  给数组按首字母排序和分组
*@param   ary   传进来的数组(数组中可以是字符串、model)
*@param   name  如果数组中是字符组则可以为nil，如果为model，则是需要排序的属性名
*@return  返回一个以首字母为key的字典
*/
+ (NSMutableDictionary *)sortAndGroupForArray:(NSArray *)ary PropertyName:(nullable NSString *)name;

/**
*  给字符串数组进行排序
*@param   ary   字符串数组
*@return  返回排序好的数组
*/
+ (NSMutableArray *)sortForStringAry:(NSArray *)ary;

/**
*  得到一个字典的所有值
*@param   dict   传入的字典
*@return  返回一个存放字典所有值的数组
*/
+ (NSMutableArray *)getAllValuesFromDict:(NSDictionary *)dict;
```

* 如果功能如demo中的第一套和第二套，那么可以按照`SearchViewController`和`AnotherSearchViewController`来做，添加头文件`#import "ZYPinYinSearch.h"`和`#import "HCSortString.h"`
* 如果只需要搜索功能，那么可以模仿第三套功能，只需添加头文件`#import "ZYPinYinSearch.h"`
* 如果需要传入model数组，可按照第四套中对应方法来传值，添加头文件`#import "ZYPinYinSearch.h"`和`#import "HCSortString.h"`

* 对于获取选中之后的返回值方法在`ViewController`中

```obj-c
SearchViewController *search = [SearchViewController new];
//返回选中搜索的结果
[search didSelectedItem:^(NSString *item) {
cell.detailTextLabel.text = item;
}];

```
## 3、Demo使用

* 下载代码最初界面是`ViewController`，三个点击之后的页面分别是:搜索栏滚动式通讯录`SearchViewController`、搜索栏固定式通讯录`AnotherSearchViewController`和单独调用搜索功能`EasySerachViewController`
    传入Model排序搜索
* 其中`HCSortAndSearch`文件夹是集成搜索功能的代码

## 4、Q-A

`2016、6、21   版本：2.0.0`
>这次作了较大改动

* 文件和方法重定名
* 重写排序相关的方法，使之更加完善和齐全
* 解决之前不能传入model数组排序的问题
* 代码也更容易理解

`2016、5、23 update  版本：1.0.4`
* 碰到把HCSearch拖拉进文件报错的，好几次了，其实一开始就说了怎么写prefix文件，然而初学者还是不太会，所以我直接写了prefix文件模板，在本例子中prefix用或者不用不影响，具体到你自己的项目，prefix可以仿照这个来写，如果还有问题我就没得说了～.～

`2016、5、23 update  版本：1.0.3`
* 之前没注意代码中有好几处NSLog没有关闭，经有心人提醒才意识到，这次就在运行的时候关闭了自己的打印语句
* 经有心人提醒，“长”字尽然排序失败，然后用系统自带方法将“长”字转化为拼音，发现显示为”zhang“，这就导致排序错误，最后自己做了个判断吧，修复这个问题。

`2016、5、17 update  版本：1.0.2`
* 最近对之前的一些小bug进行修正和界面优化，对于搜索功能，自己测试几遍之后发现，对于搜索数据是中英文数字之外的一些字符可能就会有问题，但是不影响正常人名、地点等的搜索，所以依旧可以放心使用，后期会完善。

`2016、4、7 update  版本：1.0.1`
* 有好多同学用的时候会报错，自己总结了一下，都是由于使用了pch文件（没有用pch那应该是不会出错的），且写法有点差异导致的，头文件都按照下面格式写
```obj-c

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

//你自己用到的其他头文件也写在这里
//例如用到刷新等其他第三方
#import "MJRefresh.h"

#endif

```

## 5、后期完善
* 有时间将搜索代码进行简化。

## 6、备注
>I am a rookie ，I am not God （有建议或想法请q：331864805 ，你的点赞是我最大的动力）
