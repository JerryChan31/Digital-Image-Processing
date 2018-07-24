# Digital-Image-Processing
中山大学 数字图像处理 课程项目
## 原理

先收集大量的高分辨率图像，对这些图像进行下采样得到低分辨率图像。在这些低分辨率图像中选取一个7\*7的区域，建立一个除去四角，共45个像素的LR patch。然后再取对应的高分辨率图像的对应区域作为HR patch，且只保留中心区域，对于本次放大系数为3的题目而言，HR patch中心区域的大小为9\*9。

![img1](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/2.jpg)

收集到足够多的LR-HR patch对之后，通过对这些patch对进行聚类，可以建立一个LR-HR的映射关系。聚类操作可以理解为将这些patch分为具有相似特征的patch集合。

当拿到一个需要进行超分辨的图像时，在这个图像中取同样大小的LR patch，根据前面聚类的结果判断这个LR patch属于哪一个类，并应用该类的映射关系，即可得到对应的超分辨的HR patch。

## 质量评价标准
### PSNR
峰值信噪比（英语：Peak signal-to-noise ratio，常缩写为PSNR）是一个表示信号最大可能功率和影响它的表示精度的破坏性噪声功率的比值的工程术语。由于许多信号都有非常宽的动态范围，峰值信噪比常用对数分贝单位来表示。

峰值信噪比经常用作图像压缩等领域中信号重建质量的测量方法，它常简单地通过均方误差（MSE）进行定义。两个m×n单色图像I和K，如果一个为另外一个的噪声近似，那么它们的的均方误差定义为：

![img2](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/3.png)

峰值信噪比定义为：

![img3](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/4.png)

其中，MAXI是表示图像点颜色的最大数值，如果每个采样点用 8 位表示，那么就是 255。更为通用的表示是，如果每个采样点用 B 位线性脉冲编码调制表示，那么 MAXI 就是：

![img4](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/5.png)

对于每点有RGB三个值的彩色图像来说峰值信噪比的定义类似，只是均方误差是所有方差之和除以图像尺寸再除以 3。

图像压缩中典型的峰值信噪比值在 30 到 40dB 之间，愈高愈好。

### SSIM
结构相似性指标（英文：structural similarity index，SSIM index）是一种用以衡量两张数位影像相似程度的指标。当两张影像其中一张为无失真影像，另一张为失真后的影像，二者的结构相似性可以看成是失真影像的影像品质衡量指标。相较于传统所使用的影像品质衡量指标，像是峰值信噪比（英文：PSNR），结构相似性在影像品质的衡量上更能符合人眼对影像品质的判断。

给定两个信号 x 和 y ，两者的结构相似性定义为：

![img5](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/6.png)

结构相似性指标的值越大，代表两个信号的相似性越高。

## 结果分析：

![img6](https://github.com/JerryChan31/Digital-Image-Processing/blob/master/doc/asset/1.png)

结果不如双三次插值的原因：相比原论文实现，原论文的实现加入了更多抗锯齿等细节优化，本项目只实现了其核心算法，且取样的数量和聚类书目可能有所欠缺。此外，原论文使用的LR patch是4\*4，本项目是3\*3，这是其中一个影响因素。