# 一、项目介绍
本项目为基于以太坊的链上简易汽车租借系统，目前拥有以下功能：

- 允许用户花费1 ether投资项目并领取测试汽车NFT；
- 查看自己拥有的汽车；
- 查看当前可租借的汽车；
- 根据汽车id查询汽车的主人及租借者；
- 选择并借用某辆还没有被租借的汽车一段时间；

项目代码主要分为智能合约部分和前端部分。
## 智能合约
主要数据结构为Car的mapping，存储了汽车id及对应的汽车信息，keys为汽车id的数组，方便遍历mapping；
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521140587-94ae8cc4-9bbc-428c-8eaa-77234f48f80c.png#averageHue=%23222121&clientId=u224acad1-6532-4&from=paste&height=285&id=u84649f4a&originHeight=428&originWidth=544&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=36199&status=done&style=none&taskId=u8ae5d2fa-226a-4e5c-8db3-a3d75e0db57&title=&width=362.6666666666667)
在构造器中发布了100辆汽车，并将它们的初始所有人设为合约地址，初始租界人都是address（0），汽车id从10000开始直至10099，将id集合交给keys数组；
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521169691-6eb4c803-fac8-4f2e-9294-4e10674475d6.png#averageHue=%23232221&clientId=u224acad1-6532-4&from=paste&height=378&id=u19167c55&originHeight=567&originWidth=554&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=54873&status=done&style=none&taskId=uf8d52a84-dc68-4877-acb5-c4bb9824d28&title=&width=369.3333333333333)
合约中还实现了QueryCarInfo(uint256 car)、QueryMyCars()、QueryMyBorrowCars()、QueryFreeCars()、PickUpNFT()、BorrowCar(uint256 car, uint256 time)等函数；
## 前端
前端我并没有使用原定的react框架而是改成了vue2（因为不熟悉），并使用了element-ui组件库；
其中核心部分在hello.html的120行开始：
首先通过new Web3(Web3.givenProvider || "http://localhost:8545")拿到web3对象，接着通过var account = await window.ethereum.enable()申请授权，获取当前账户地址，然后通过await new web3.eth.Contract获得合约对象（要传入合约对应abiJSON及合约部署地址），命名为BorrowYourCar，通过这个合约对象便可以调用合约方法实现功能；
下面的方法根据carID查询汽车信息，并将信息展示到html的表格中：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521662977-143bea83-26fc-4f1d-98f1-91fdbcae2be8.png#averageHue=%23222221&clientId=u224acad1-6532-4&from=paste&height=364&id=u284550f1&originHeight=546&originWidth=1077&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=78763&status=done&style=none&taskId=ubb800208-02a1-4553-878a-e8e512a1bd2&title=&width=718)
在调用还还可以调整发送者地址、交易的ether数量、gas限制等参数：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521770436-576da04c-fb47-4c1f-9f1c-1817cf534c1e.png#averageHue=%23222221&clientId=u224acad1-6532-4&from=paste&height=559&id=uadcd856e&originHeight=838&originWidth=1081&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=111879&status=done&style=none&taskId=u2e3a3e5e-920f-4584-8a1a-e2cb842972e&title=&width=720.6666666666666)
# 二、运行流程
## 1、首先运行ganache搭建本地私链
提供了10个用户。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521877716-c7967ecc-d120-4c88-bfe3-22c9393004ba.png#averageHue=%23232323&clientId=u224acad1-6532-4&from=paste&height=684&id=u7523de60&originHeight=1026&originWidth=1034&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=163782&status=done&style=none&taskId=uab9be7a0-c158-4ffb-94dc-0d33ae79103&title=&width=689.3333333333334)
## 2、用hardhat编译合约
由于我已经编译过，没有更新。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699521957118-b4e509ed-08f1-4cb3-8fc9-214e827311d7.png#averageHue=%23232221&clientId=u224acad1-6532-4&from=paste&height=85&id=udf61efbf&originHeight=127&originWidth=1398&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=23880&status=done&style=none&taskId=u0cd70242-9ffa-42ed-beec-7cad701e5f6&title=&width=932)
## 3、部署合约
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522047939-d1f550c2-1779-48e6-a85a-7aceb83e4a26.png#averageHue=%23242322&clientId=u224acad1-6532-4&from=paste&height=61&id=u9f947625&originHeight=91&originWidth=1761&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=28457&status=done&style=none&taskId=u584f8aae-cd37-44e3-83e5-cab8a342067&title=&width=1174)
合约部署后链上会保存：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699523015955-da4b3d32-b27a-4a02-b1e2-178536d69af3.png#averageHue=%231c1c1c&clientId=u224acad1-6532-4&from=paste&height=123&id=iJh3g&originHeight=185&originWidth=1174&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=28215&status=done&style=none&taskId=u4fdaf3cd-68fd-4c5e-9d49-4298a8310ec&title=&width=782.6666666666666)
## 4、修改html文件中的参数
在hello.html中的第332行将web3连接智能合约的函数中的第二个参数修改为上面第三部中部署好的合约地址，然后将第一个参数修改为contracts/artifacts/contracts/BorrowYourCar.sol/BorrowYourCar.json中的abi对象：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522206860-782b2e90-6a73-4a0b-8d8c-3717aefbcb0e.png#averageHue=%23232121&clientId=u224acad1-6532-4&from=paste&height=534&id=u30838020&originHeight=801&originWidth=1061&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=91581&status=done&style=none&taskId=u0e73f986-e61a-4a7d-99bc-52905d96404&title=&width=707.3333333333334)
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522195212-c9e4f1fa-91c7-474b-8586-f50b2a34f173.png#averageHue=%23222121&clientId=u224acad1-6532-4&from=paste&height=817&id=u5130d9e8&originHeight=1225&originWidth=1212&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=144907&status=done&style=none&taskId=ua67ae0fe-67d9-4b36-aefc-86290f40442&title=&width=808)
## 5、启动前端项目
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522244012-817508a1-b58b-4b8c-ac63-3822baa6f788.png#averageHue=%23222121&clientId=u224acad1-6532-4&from=paste&height=191&id=u5fa5fd80&originHeight=286&originWidth=1305&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=32524&status=done&style=none&taskId=ua98c3d90-305b-45f6-a7ce-ad24a5c9015&title=&width=870)
## 6、通过[http://localhost:8080/hello.html](http://localhost:8080/hello.html)访问项目
由于metamask钱包还未授权，web3会调用请求授权，接着从ganache中选择一个私钥导入账户
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522369522-2b40c9a1-ce85-49bb-89eb-972bc4108224.png#averageHue=%23fdfdfc&clientId=u224acad1-6532-4&from=paste&height=912&id=u644ea1d5&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=192363&status=done&style=none&taskId=u34b22bc7-1168-4634-8cb3-500ddbe57dd&title=&width=1262.6666666666667)
# 三、功能演示
## 投资领取汽车
点击投资即可
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522689381-00e32929-4b38-4a1d-b9e1-e84fd22237af.png#averageHue=%238f8e8e&clientId=u224acad1-6532-4&from=paste&height=912&id=u3b31caa6&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=160905&status=done&style=none&taskId=u3d8f4630-244d-493b-a480-3c0676692c4&title=&width=1262.6666666666667)
点击确定后会展示当前用户拥有的所有汽车；由于投资需要消耗1 ether，是一个交易，链上会记录交易信息：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522996440-6f101112-edfd-442e-b0d8-34f86a0dd3cd.png#averageHue=%231a1a1a&clientId=u224acad1-6532-4&from=paste&height=102&id=u16d6c93f&originHeight=153&originWidth=1153&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=21133&status=done&style=none&taskId=ua4398dfd-902f-4a19-8d72-ae036262ead&title=&width=768.6666666666666)
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699523051070-3a669a20-fcf1-4fb8-b994-9714ac3f9ec0.png#averageHue=%231a1a1a&clientId=u224acad1-6532-4&from=paste&height=102&id=u71e58f27&originHeight=153&originWidth=1145&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=21426&status=done&style=none&taskId=ucced8520-f0a5-4fda-912b-158f1162ae7&title=&width=763.3333333333334)
## 查询可租借的汽车
点击可租借的车
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522754030-29adfade-e88c-4298-8b3c-9d9e69ae5227.png#averageHue=%23fdfcfc&clientId=u224acad1-6532-4&from=paste&height=912&id=u37c26bdc&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=227422&status=done&style=none&taskId=ud2c717f6-79cc-44b1-8358-227f7a34a13&title=&width=1262.6666666666667)
## 查询我拥有的车
点击我拥有的车
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522784559-20dac319-acd8-4153-b58b-efb6a467fc1f.png#averageHue=%23fdfdfd&clientId=u224acad1-6532-4&from=paste&height=912&id=u43108816&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=156821&status=done&style=none&taskId=u38267129-020d-4d7e-8cc2-2a55823b731&title=&width=1262.6666666666667)
## 借车
输入车辆id及租借时间即可
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522839679-07f1708c-66f6-4b9c-8066-edee827624e8.png#averageHue=%23898989&clientId=u224acad1-6532-4&from=paste&height=467&id=ubcb0d0a5&originHeight=701&originWidth=1812&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=72591&status=done&style=none&taskId=ufecff2a6-4b17-4ad2-a704-d6c714c7c6b&title=&width=1208)
## 查看我租借的车
点击我租借的车即可
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522874144-9f9f1412-c215-4f2e-88f6-ec4cf6b811e3.png#averageHue=%23fdfdfd&clientId=u224acad1-6532-4&from=paste&height=912&id=uc8d02f95&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=146102&status=done&style=none&taskId=u1e58f74a-876e-473d-9a66-74628bc54cf&title=&width=1262.6666666666667)
## 查询车辆信息
输入车辆id后点击查询车辆信息
![image.png](https://cdn.nlark.com/yuque/0/2023/png/35639742/1699522920306-3ba21ec3-4e87-4f22-9dd5-b4a04ac78c55.png#averageHue=%23fdfdfd&clientId=u224acad1-6532-4&from=paste&height=912&id=uf07321ef&originHeight=1368&originWidth=1894&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=142953&status=done&style=none&taskId=u2a45e568-40a2-411d-98da-0cf85806e4b&title=&width=1262.6666666666667)




