引入插件
```dart
  flutter_stetho: ^0.5.2
```
原作者不再更新,不支持flutter1.22版本以上,如有需要请使用下面这个仓库代替
 ```dart
dev_dependencies:
  flutter_stetho:  
    git:
      url: git://github.com/irdevp/flutter_stetho.git
      ref: master

```

打开谷歌浏览器地址栏输入`chrome://inspect/#devices`
![image.png](https://upload-images.jianshu.io/upload_images/3671684-a871742416d504fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击下面的inspect,会弹出如下窗口
![image.png](https://upload-images.jianshu.io/upload_images/3671684-3102a28a7abef61f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
当app触发http请求时就可以看到所有网络连接了,如下
![image.png](https://upload-images.jianshu.io/upload_images/3671684-5acd285e2466a6bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 如果后面遇到调试工具ui错乱的问题
下载对应的版本就可以了
*   Linux x64: [https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/827102/](https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/827102/)
*   Mac OS: [https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Mac/827102/](https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Mac/827102/)
*   Windows: [https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Win/827102/](https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Win/827102/)

相关的资料
https://github.com/facebook/stetho/issues/696#issuecomment-790760811
