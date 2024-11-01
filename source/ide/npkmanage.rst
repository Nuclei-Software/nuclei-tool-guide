.. _npkmanage:

Nuclei Studio NPK 创建与共享
============================

Nuclei Studio 2022.04版中，提供了一个非常重要的功能，该功能主要通过提供的各种初始模板，方便开发者去创建自己的NPK组件包，并可以通过平台将自己的NPK组件包贡献出来，供其他开发者使用。

.. _npkmanage_develop_package:

开发NPK组件包
---------------

.. _npkmanage_auth_developer:

认证开发者
~~~~~~~~~~~

在创建NPK组件包前，先需要认证一个开发者帐号，获取一个唯一的owner ID,这在owner ID对应的就是前文中介绍的owner，它能方便我们对NPK进行管理。

首先，登陆芯来科技的 `RVMCU社区的网站  <https://www.rvmcu.com/user-login.html>`__ ，登陆成功后，依次进入Nuclei Studio->贡献页面，就可以看到认证按钮。

|image1|

.. |image1| image:: /asserts/nucleistudio/developer/authenticate.png


或者直接访问 `认证地址 <https://www.rvmcu.com/nucleistudio-developer.html>`__ ，按提示分别填写相关信息，其中 **开发者** 对应的开发者空间地址的后辍将会是您的owner ID。

|image2|

.. |image2| image:: /asserts/nucleistudio/developer/authenticate2.png

填写完相关内容后提交，系统审核通过后，即可完成认证。

|image3|

.. |image3| image:: /asserts/nucleistudio/developer/authenticate3.png

.. _npkmanage_create_package:

创建NPK组件包
~~~~~~~~~~~~~~

完成开发者认证后，在Nuclei Studio中新建一个Nuclei Studio组件工程,在菜单栏中，选择 ``File->New->Project->New Nuclei NPK Project`` 。

|image4|

.. |image4| image:: /asserts/nucleistudio/developer/image140.png


首次使用需要登录开发者帐号，且登录后7天有效，超过时间后需要再次登录，登录需要使用微信扫描二维码，见下图。登录成功后，owner可选框会列出绑定的相关开发者账号，其他的根据提示输入相关信息。需要变更账号时，可点击login again重新登录。

|image5|

.. |image5| image:: /asserts/nucleistudio/developer/image141.png


开发者帐号登陆成功后，依据工程向导依次填入工程名、工程类型等等相关信息。

|image6|

.. |image6| image:: /asserts/nucleistudio/developer/image143.png


选择Type时，无对应模板时，会跳出对应提示，点击确定，进入Nuclei Package Management页面，根据需要下载Template Package的对应模板，或点击下图右下角Import自行导入。

下面以ssp类型模板为例,假设你的公司名称为GreenTech, 你的SoC名称为 gt25nv, 适配的开发板为gt25nv_devkit, 采用了我们的n307FD处理器(rv32imafdc)配置, 并且配置了dsp特性， 并且提供了ilm, flash,flashxip三种下载方式。

Type选择ssp: ``Soc Support Package``

|image7|

.. |image7| image:: /asserts/nucleistudio/developer/image147.png

其次进入缺少对应模板，进入Nuclei Package Management页面，选择 ``tpl-nsdk-soc-demosoc`` ，点击 ``Download`` 下载，下载完成后关闭该页面

|image8|

.. |image8| image:: /asserts/nucleistudio/developer/image148.png


点击Next，在 ``Select a Template`` 中选择刚才下载的模板 ``tpl-nsdk-soc-demosoc`` ，左侧为模板描述和相关的文件预览，右侧为模板中部分可自定义的内容。

|image9|

.. |image9| image:: /asserts/nucleistudio/developer/image145.png


我们这里举例，公司名称为 ``GreenTech`` ，SoC名称为 ``gt25nv`` ，适配的开发板为 ``gt25nv_devkit`` ，采用了我们的n307FD处理器( ``rv32imafdc`` )配置，并且配置了dsp特性，并且提供了ilm，flash，flashxip三种下载方式。然后Nuclei RISC-V Core选择为 ``NX600`` ，经过修改后如图。

|image10|

.. |image10| image:: /asserts/nucleistudio/developer/image149.png

然后点击Finish即成功生成对应NPK组件包，再根据需要，可以打开目录查看并修改对应的文件和结构，修改完成后再导入该NPK组件包。

修改项目，根据需要自行修改。项目修改完成，导入NPK组件包。

|image11|

.. |image11| image:: /asserts/nucleistudio/developer/image146.png

按照示例创建的soc在导入时，提示缺少依赖 ``sdk-nuclei_sdk`` ，点击确定，进入 ``Nuclei Package Management`` 页面，根据提示，选中 ``sdk-nuclei_sdk`` ，点击 ``Download`` 。

|image12|

.. |image12| image:: /asserts/nucleistudio/developer/image151.png


|image13|

.. |image13| image:: /asserts/nucleistudio/developer/image150.png

下载完成后，NPK组件包工程导入成功后结果如下图 。

|image14|

.. |image14| image:: /asserts/nucleistudio/developer/image152.png

.. _npkmanage_test_package:

测试NPK组件包
--------------

.. _npkmanage_create_test_project:

创建测试项目
~~~~~~~~~~~~~~

使用导入的NPK组件包工程创建一个工程，可以在菜单栏中，选择 ``File-> New-> Project-> New Nuclei RISC-V C/C++ Project`` 。

|image15|

.. |image15| image:: /asserts/nucleistudio/developer/image153.png

点击Next，选择上面创建的soc内所包含的soc和board

|image16|

.. |image16| image:: /asserts/nucleistudio/developer/image154.png

点击Next，填入Project Name，并选择Project Example为 ``Helloworld`` ，点击 ``Finish`` ，完成测试工程的创建。

|image17|

.. |image17| image:: /asserts/nucleistudio/developer/image155.png

.. _npkmanage_workwith_test_project:

编译调试测试工程
~~~~~~~~~~~~~~~~~~

上文步骤中创建的一个工程，就是根据开发者的NPK组件包创建出来的一个测试工程，开发者可以按一个正常的工程进行对应的编码、调式、运行等操作。

鼠标点击选中上一步生成的项目N307FD，然后编译成功，后续运行等步骤略去，至此已成功创建了一个NPK组件包，并使用此NPK组件包进行了导入使用。

|image18|

.. |image18| image:: /asserts/nucleistudio/developer/image156.png


.. _npkmanage_share_package:

共享NPK组件包
---------------

.. _npkmanage_share_npk:

NPK组件包共享
~~~~~~~~~~~~~~

经过测试通过后，可以将您创建的NPK组件包分享出去，首先需要将您的NPK组件包工程导出为一个zip包，具体操作如下。

打开NPK组件包项目，双击最外层的 ``npk.yml`` ，找到其Name为 ``ssp-nsdk_gt25nv`` ，右键点击NPK组件包项目，点击 ``Export`` ，选择 ``Archive File`` ，选择需要导出的工程，然后根据提示指定导出zip文件存放的位置。

|image19|

.. |image19| image:: /asserts/nucleistudio/developer/image159.png


|image20|

.. |image20| image:: /asserts/nucleistudio/developer/image161.png


导出的zip包，可以通过rvmcu社区进行分享贡献。进入 `社区分享页面 <https://www.rvmcu.com/nucleistudio-developer.html>`__ ，依据提示信息，依次填写需要分享的NPK组件包的名称、所属类型、描述待信息，并上传刚导出的zip文件，信息提交后，待管理员审核通过后，该NPK组件包就成功贡献了，其他的开发者就可以通过Nuclei Studio的 ``Nuclei Package Management`` 页面找到您的NPK组件包，并下载使用。具体操作如下图

|image21|

.. |image21| image:: /asserts/nucleistudio/developer/image160.png


|image22|

.. |image22| image:: /asserts/nucleistudio/developer/3441.png


|image23|

.. |image23| image:: /asserts/nucleistudio/developer/image163.png



分享的npk组件包通过审核后，在Nuclei Studio中打开 ``Nuclei Package Management`` 页面，然后点击 ``Refresh`` ，刷新后即可找到刚分享的组件包。

|image24|

.. |image24| image:: /asserts/nucleistudio/developer/image164.png


.. _npkmanage_update_npk:

NPK组件包升级
~~~~~~~~~~~~~~

在NPK组件包共享后，如果有新的版本需要维护，在创建测试打包完成后，可以对原有的NPK组件包进行升级。共入 `Nuclei Studio <https://www.rvmcu.com/nucleistudio.html>`__ 页面， 找到管理组件包入口，然后进组件包管理页面，点击升级组件包，然后之前的步骤，上传NPK组件包，等待审核通过，则组件包升级完成。

|image25|

.. |image25| image:: /asserts/nucleistudio/developer/image165.png

|image26|

.. |image26| image:: /asserts/nucleistudio/developer/image166.png


|image27|

.. |image27| image:: /asserts/nucleistudio/developer/image167.png


.. _npkmanage_using_npk_in_ide:

NPK组件包在Nuclei Studio中的使用
---------------------------------

NPK组件包在Nuclei Studio中，丰富了其用户体验，通过NPK组件包我们可以定义各种不同的创建工程流程，也能很方便的将成熟的工程或者组件共享给其人。

我们所有贡献的NPK包，都在Nuclei Studio的 ``NPK Package Managment`` 中进行管理，用户可以在这里进行NPK的下载、导入、删除等操作。

|image28|

.. |image28| image:: /asserts/nucleistudio/developer/168.jpg



