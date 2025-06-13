.. _npkoverview:

Nuclei Studio NPK 介绍
======================

在芯来RISC-V嵌入式软件开发里面引入组件(Package)的理念，主要是借鉴于npm包管理，开发出方便开发者开发，使用，分发设计好的软件组件，可以大大加快软件的迭代速度。

组件包主要由以下文件组成：

- 组件描述文件(基于YAML语言)： ``npk.yml`` 

- 组件相关代码以及说明文档

组件包会以zip包形式存在，组件包在导入使用时，需要被IDE或者其他工具进行包完整性以及可用性检查，才予以导入。

.. note::

   - 我们提供了一个开源的NPK软件包检查工具，参见 https://github.com/Nuclei-Software/npk-checker
   - 最好的NPK软件包参考项目可以参见 Nuclei SDK 以及其他线上的软件包(搜索 npk.yml 文件) https://www.rvmcu.com/nucleistudio-npk.html
   - 组件包后期会提供签名机制，在发布前先签名，然后导入软件包会验证签名，确保导入的开发包是合法身份发布，不导入不可信的开发包。

组件描述文件(npk.yml)
----------------------

组件主要分为以下几大类型，分别是：

- **csp:** Core Support Package, 例如NMSIS
- **ssp:** SoC Support Package, 例如gd32vf103的SoC的支持包
- **bsp:** Board Support Package，例如rvstar开发板板级支持的代码包
- **osp:** RTOS Support Package， 例如各类RTOS支持包
- **app:** Application Package，例如各类上层应用
- **mwp:** Middleware Package，各类第三方中间件，例如语音识别，算法库之类的
- **sdk:** Software Development Kit，一组预设定好的软件开发包，一般情况下里面会包含了CSP, SSP, BSP, APP类型的包，OSP和MWP类型的包可选加入
- **bdp:** Bundle Package, 一组package，目前仅对app有效

以下是比较特殊的类型，主要用于工具包和模版包

- **tool:** Tool Package，各类工具组件包，可放入其他需要引用或参考的文件
- **tpp:** Template Package, 模板类型，可以用于创建csp/ssp/bsp/osp/app/mwp/sdk的模板工程,该类型比较特殊，描述文件名称为 **npk_template.yml**

描述文件通用定义
~~~~~~~~~~~~~~~~~~~~~

组件描述文件示例以及详细说明参见如下：

.. code-block:: yaml

    Package Base Information
    --------------------------
    name: your_package_name                 # <MUST> 组件包名称ID，不要有空格，符合C语言命名规范，英文名称，唯一名称ID，用于dependency管理
                                            # name命名规则：唯一性，全英文，不支持特殊字符
                                            # csp类型package: csp-xxxx
                                            # ssp类型package: ssp-xxxx
                                            # bsp类型package: bsp-xxxx
                                            # osp类型package: osp-xxxx
                                            # app类型package: app-xxxx
                                            # mwp类型package: mwp-xxxx
                                            # sdk类型package: sdk-xxxx
                                            # tpp类型package: tpp-xxxx
                                            # tool类型package: tool-xxxx
    description: 简要描述软件包的功能       # <MUST> 一句话描述清楚包的主要特性与功能, English only, 20字符以内
    details: 详细描述软件包的功能           # <MUST> 描述清楚包的主要特性与功能, English only
    version: 1.2.3                          # <OPTIONAL> 可选，如不填，默认为空，建议采用SEMVER2.0版本号管理，只能数字打头, 例如1.2.3
                                            # <MUST> 针对sdk类型的package必须包含一个version tag
    type: ssp                               # <MUST> 包类型， 可选类型有csp, ssp, bsp, osp, app, mwp, sdk, tpp, tool
    os: win64                               # <MUST> OS类型，例如win32、win64、lin64、lin32,但目前组件包上传页面只支持win64和lin64,该字段只存在tool类型package
    category:                               # <OPTIONAL> 包分类，按照上面的包类型进行二次分类，主要是针对package进行分类
    keywords:                               # <MUST> 包关键字，主要用于索引与搜索
      - soc
      - risc-v
      - nuclei
    license: Apache-2.0                     # <OPTIONAL> 对应包代码所用的许可证，可选列表 GPL, GPLv2, MIT, Apache License v2, BSP等
    owner: nuclei                           # <MUST>    组件包的拥有者，便于后期进行权限查找匹配
                                            # 后期在整合到网站以后，用户在发布新的开发包的时候，需要先注册一个唯一的owner名称
                                            # 然后申请一个package name，确保name可用的情况下才可以发布新的该name的包，同时限制单用户发布的包个数。
    contributors:                           # <OPTIONAL> 组件包的代码贡献者列表
        - author_name, author_email
    homepage:                               # <OPTIONAL> 组件包的主页, 如果有的话，必须是链接

    ## Package Information
    -----------------------

    packinfo:                               # <MUST> Only for bsp/ssp type, optional for other types 用于描述SoC层面的一些信息
      core_vendor: Nuclei                   # <MUST> only for ssp, 处理器内核的供应商英文名称，如果是基于芯来的处理器内核，这里填写Nuclei
      vendor: Nuclei                        # <MUST> For ssp/bsp, <OPTIONAL> for others
                                            # For ssp, SoC或者芯片的供应商英文名称，填写对应的厂商的名称，例如 GigaDevice
                                            # For bsp, 表示板子的提供商英文名称
                                            # For others, OPTIONAL, 表示该package提供商
      name: demosoc                         # <MUST> 这里name和package name作用不一样, 用来显示具体的包名称
                                            # For ssp, 表示本组件包中SoC的具体英文名称，可以是一个系列名称，例如GD32VF103
                                            # For bsp, 板子的名称
                                            # For others, 表示该package显示名称，中英文均可，不写的话，默认使用根字段name
      doc:                                  # <OPTIONAL>, 不填的话，这里为空，不做展示
        website:                            # <OPTIONAL>, Package对应的网站
        sch:                                # <OPTIONAL> only for bsp, 表示板子的电路图
        datasheet:                          # <OPTIONAL>, package datasheet 本地地址或者是网址
        usermanual:                         # <OPTIONAL>, Package User Manual
        extra:                              # <OPTIONAL>, 额外的一些资料，列表形式(URI + DESCRIPTION)
          - uri:                            # <OPTIONAL>, file path or web link
            description:                    # <MUST> when uri is defined, description for file


    ## Package Dependency
    ----------------------

    dependencies:                           # <OPTIONAL> 列出依赖的组件包列表 owner/name:version
      - name: csp-nsdk_nmsis                # <MUST> when defined        # 1. 针对sdk类型的包，内部有一个隐形的依赖，依赖有且仅有一个bsp类型的包，
        owner: nuclei # <OPTIONAL> if not defined, it will use the owner definiton above. 用于依赖特定所有者的package， owner/name:version， 最终查找的包按照这样来找的
          version: # <OPTIONAL> when defined empty, use default as version number #    并且会自动查找当前路径下所有的npk.yml文件，并作为sdk包中一部分
                                            # 2. 除了sdk类型的包之外的其他的包，如果不是放在sdk包下面的目录，则依赖于
                                            #    sdk，则需要显式加上dependency
                                            # 3. bsp类型的package肯定会依赖一个ssp类型的package
                                            # 4. 依赖包也可以带上版本号，支持版本号条件比对, 如果不带版本号，则优先选择不带版本号的包，其次最新的包
                                            # 参考 https://docs.platformio.org/en/latest/librarymanager/config.html#version
                                            # https://docs.npmjs.com/about-semantic-versioning
                                            # 1.2.3 - an exact version number. Use only this exact version
                                            # ^1.2.3 - any compatible version (exact version for 1.x.x versions
                                            # ~1.2.3 - any version with the same major and minor versions, and an equal or greater patch version
                                            # >1.2.3 - any version greater than 1.2.3. >=, <, and <= are also possible
                                            # >0.1.0,!=0.2.0,<0.3.0 - any version greater than 0.1.0, not equal to 0.2.0 and less than 0.3.0
                                            #    例如 version: master, version: 1.2.3, version: >0.1.0
                                            # 依赖关系处理规则
                                            # 1. sdk，app类型的包可以依赖多个ssp、bsp类型的包，但是最终只会根据project wizard选择具体使用到package
                                            # 2. app/bsp/ssp/csp/osp/mwp类型的包可以依赖sdk，如果依赖了sdk类型的包，则表述该包隶属于sdk下
                                            # 3. bsp类型的包只能依赖一个ssp/csp类型的包，ssp类型的包只能依赖一个csp类型的包
                                            # 4. sdk类型的包可以依赖多个app/bsp/ssp/csp/osp/mwp类型，但是这种依赖只是建立从属关系，表示该sdk包含了这些包
                                            # 5. 一个sdk类型的包不可以依赖另一个sdk包，但是app/bsp/ssp/csp/osp/mwp却可以依赖多个sdk类型的包

    ## Package Configurations
    --------------------------

    configuration:                          # <OPTIONAL> 关于包配置的一些选项，用于Project Wizard创建以及内部参数设置
                                            # 其中sdk类型暂不支持configuration参数定义
                                            # configuration定义的配置可以互相覆盖
                                            # 覆盖规则为 app > mwp  > osp > bsp > ssp > csp
      nuclei_core:                          # <OPTIONAL> 一个配置选项，类型为choice
        default: n307fd                     # <MUST> 如果这个配置定义了，针对choice类型，默认值选择必须是choices里面列举的
        type: choice                        # <MUST> 配置类型，可选有choice, list, checkbox, multicheckbox，text
        global: true                        # <OPTIONAL> 可选为true或者false，默认为true
        description: Nuclei RISC-V Core     # <MUST> 该配置项的描述，20字以内
        choices:                            # <MUST> 当配置项type == choice时
          - name: n201                      # <MUST> item中必须包含name和description
            arch: rv32iac                   # <OPTIONAL> 仅用于表示RISC-V CORE中的ARCH信息，不建议随意使用
            abi: ilp32                      # <OPTIONAL> 仅用于表示RISC-V CORE中的ABI信息，不建议随意使用
            tune:                           # <OPTIONAL> 仅用于表示RISC-V CORE中的TUNE信息，不建议随意使用
            info:                           # <OPTIONAL> 用于自定义key-value数据的访问，例如 ${nuclei_core.info.key1} 返回的是 value1
                - name: key1                # <MUST> key in pair with value, 字符串类型，不包含任意空格
                  value: value1             # <MUST> value in pair with key，字符串类型
                - name: key2                # <MUST>
                  value: value2             # <MUST>
            description: N201 Core(ARCH=rv32iac, ABI=ilp32)    # <MUST> 描述这个item具体含义
                                            # 除了name, description之外，可能会定义其他items, 名称不定
                                            # 例如在这里就定义了 arch和abi
          - name: n201e                     # 另一个item
            arch: rv32eac
            abi: ilp32e
            description: N201E Core(ARCH=rv32eac, ABI=ilp32e)
      extra_flags:                                 # <OPTIONAL> 一个配置选项, 当前这个为text类型
        value:                                     # <MUST>, 仅接受英文字符串
        description: Extra compiler flags          # <MUST> 该配置项的描述，30字以内
      dsp_present:                                 # <OPTIONAL> 一个配置选项, 当前这个为checkbox类型
        default: 0                                 # <MUST>, 默认为0，可选0或者1
        type: checkbox                             # <MUST>, 配置类型，当前为checkbox
        global: true                               # <OPTIONAL> 可选为true或者false，默认为true
        description: P-Extension(DSP) Present      # <MUST> 该配置项的描述，30字以内
      libraries:                                   # <OPTIONAL> 一个配置选项，当前这个为multicheckbox类型
        default: [dsp, nn]                         # <MUST> 默认值, 为choices里面的组合
        type: multicheckbox                        # <MUST>, 配置类型，当前为multicheckbox
        global: true                               # <OPTIONAL> 可选为true或者false，默认为true
        description: Libraries Used                # <MUST> 该配置项的描述，30字以内
        choices:                                   # <MUST> 当配置项type == multicheckbox时
          - name: dsp                              # <MUST> item中必须包含name和description
            description: DSP Library               # <MUST> 描述这个item具体含义
                                                   # 除了name, description之外，可能会定义其他items, 名称不定
          - name: nn
            description: NN Library
          - name: ai
            description: AI Library

    ## Source Code Management
    -------------------------

    codemanage:                                 # <MUST> 这个为必选项
      installdir: demosoc                       # <MUST> 希望代码安装的目录名称，仅限英文，满足C语言命名格式
                                                # 针对sdk类型的package,会被安装到<sdk_installdir>, 如果installdir未定义，默认为SDK，如果没有任何sdk类型的package被引用，sdk_installdir也被默认设置为SDK
                                                # 针对csp类型的package，会被安装到<sdk_installdir>/<csp_installdir>目录下，TBD
                                                # 针对ssp类型的package,会被安装到<sdk_installdir>/SoC/<ssp_installdir>/Common下面
                                                # 针对bsp类型的package,会被安装到<sdk_installdir>/SoC/<ssp_installdir>/Board/<bsp_installdir>下面，如果不依赖于任何ssp类型，则安装到<sdk_installdir>/BSP/<bsp_installdir>
                                                # 针对osp类型的package,会被安装到<sdk_installdir>/OS/<osp_installdir>下面
                                                # 针对app类型的package,会被安装到<app_installdir>/目录下， 如果installdir未定义，默认为application
                                                # 针对mwp类型的package,会被安装到<sdk_installdir>/Components/<mwp_installdir>目录下
      copyfiles:                                # <MUST>待拷贝的文件或者文件夹，支持glob pattern匹配，这里是指所有的目录或者文件
        - path: ["Source/", "Include/", "demosoc.svd"]        # <MUST>待拷贝的文件或者文件夹的路径列表，支持glob pattern匹配
        - path: ["DSP_Source", "DSP_Include"]
          condition: $( ${dsp_present} == 1 )                 # <OPTIONAL> 这里的if 是一个固定的标识符，如果出现则表示要做判定，判定的方式如下
                                                              # 如dsp_present是在configuration里面定义的，根据wizard或者其他package选定而定
      incdirs:                                                # <OPTIONAL> 需要加入头文件目录列表
        - path: ["Include/"]                                  # <OPTIONAL> 需要加入头文件的目录
      libdirs:                                                # <OPTIONAL> 可选的lib库所在目录
          - path:
      ldlibs:                                                 # <OPTIONAL> 可选的需要链接的库
          - libs:

    ## Set Configuration for other packages
    ----------------------------------------

    setconfig:                                                # <OPTIONAL> 这个用于设置其他Package的选项

    # 以下选项是覆盖关系，规则app > mwp  > osp > bsp > ssp > csp
      - config: nmsislibarch
        value : ${nuclei_core.arch}p                          # <OPTIONAL> 直接设置Configuration里面的选项
        condition: $( ${dsp_present} == 1 )                   # <OPTIONAL> 根据这里dsp_present来判断是否设置nmsislibarch值
      - config: nmsislibarch
        value: ${nuclei_core.arch}
        condition: $( ${dsp_present} == 0 )

    ## Build Configuration
    -----------------------

    buildconfig:                                 # <OPTIONAL> 编译选项的配置
                                                 # 目前编译选项会将package中定义的所有的拼接在一起或者覆盖
                                                 # 以下选项是覆盖方式，app > mwp  > osp > bsp > ssp > csp
                                                 # type是一个特殊字段，用于标识特定的编译器, 目前支持gcc
                                                 # cross_prefix, prebuild_steps, postbuild_steps, description
                                                 # 其余选项是拼接的
      - type: gcc                                # <OPTIONAL> 目前只有gcc，预留其他接口
        description: Nuclei GNU Toolchain        # <MUST> For ssp
          cross_prefix: riscv-nuclei-elf-        # <OPTIONAL> 如果不写或者留空，就自动按照系统里面提供的工具链来定
        common_flags:                            # <OPTIONAL> 通用的编译选项，将会添加到cflags, asmflags, cxxflags上
          - flags: -g -fno-common -ffunction-sections -fdata-sections
          - flags: -march=${nuclei_core.arch} -mabi=${nuclei_core.abi} -mcmodel=medany
        ldflags:                                 # <OPTIONAL> 链接选项列表，留空表示没有任何选项
          - flags: -nostartfiles --specs=nosys.specs
          - flags: --specs=nano.specs
            condition: $(${newlib} != "normal")
          - flags: -u _printf_float
            condition: $(${newlib} != "nano_with_printfloat")
          - flags: -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek
        linkscript:                              # <MUST> 链接脚本的定义，必须在bsp/ssp中定义
          - script: "Source/GCC/gcc_demosoc_${.download}.ld"
              condition: $(check pattern)        # <OPTIONAL> 进行条件判断
        cflags:                                  # <OPTIONAL> C编译选项，留空表示没有任何选项
          - flags: -O3
        asmflags:                                # <OPTIONAL> ASM编译选项，留空表示没有任何选项
          - flags: -O2
        cxxflags:                                # <OPTIONAL> CXX编译选项，留空表示没有任何选项
          - flags: -O1
        common_defines:                          # <OPTIONAL> 通用的宏定义
          - defines: __RISCV_FEATURE_DSP=1
            condition: $(${dsp_present} == 1)
          - defines: DOWNLOAD_MODE_STRING=\"flashxip\"
        cdefines:                                # <OPTIONAL> C的宏定义
          - defines: __RISCV_FEATURE_DSP=1
            condition: $(${dsp_present} == 1)
          - defines: DOWNLOAD_MODE_STRING=\"flashxip\"
        asmdefines:                              # <OPTIONAL> ASM的宏定义
          - defines: __RISCV_FEATURE_DSP=1
            condition: $(${dsp_present} == 1)
          - defines: DOWNLOAD_MODE_STRING=\"flashxip\"
        cxxdefines:                              # <OPTIONAL> CXX的宏定义
          - defines: __RISCV_FEATURE_DSP=1
            condition: $(${dsp_present} == 1)
          - defines: DOWNLOAD_MODE_STRING=\"flashxip\"
        prebuild_steps:                          # <OPTIONAL> 编译前执行的命令
          command:                               # <OPTIONAL> 执行的命令行
          description:                           # <OPTIONAL> 执行的命令的描述
        postbuild_steps:                         # <OPTIONAL> 编译完成后执行的命令
          command:                               # <OPTIONAL> 执行的命令行
          description:                           # <OPTIONAL> 执行的命令的描述

    ## Debug Configuration
    ------------------------

    debugconfig:                            # <MUST> For bsp type, optional for app/ssp type
    # 目前Debug选项会将package中定义的所有的拼接在一起或者覆盖
    # type是一个特殊的字段，用于描述特定的调试器，目前支持openocd, qemu
    # 以下字段是覆盖关系：app > mwp  > osp > bsp > ssp > csp
    # description, svd
    # configs字段下面的key, value是合并关系，如果对应的key存在就覆盖，覆盖规则同上，如果不存在就合并
      - type: openocd   # <MUST> 选择的工具
        description: Nuclei OpenOCD # <MUST> For bsp type
        svd: gd32vf103.svd  # <OPTIONAL> 可选的SVD文件
        configs:
          - key: config  # openocd配置文件
            value: "openocd_gd32vf103.cfg"

      - type: qemu
        description: Nuclei QEMU
        svd:
        configs:
           - key: nuclei_core   # Nuclei RISC-V Core
             value: ${nuclei_core}
             condition:  # condition set nuclei_core key
           - key: download_mode  # Download mode
             value: ${download_mode}
           - key: riscv_arch    # RISCV ARCH
             value: ${nuclei_core.arch}
           - key: riscv_abi     # RISCV ABI
             value: ${nuclei_core.abi}
           - key: machine   # QEMU Machine
             value: gd32vf103v_rvstar

    ##Extended variable
    ## Only works on tool类型
    ## 每个包存在一个包路径，引用为npk名称-版本号，例如${tool-cmlink-1.0.0}，
    ## 其他变量的引用为npk名称-版本号-变量名，例如 ${tool-cmlink-1.0.0-proxy}
    environment:            # 扩展变量
      - key: proxy            # 变量名,
        value: bin/cmlink_gdbserver.exe        # 实际引用结果为 npk文件父路径+value，例如C:\Users\jj\nuclei-pack-npk\NPKs\XinShengTech\Tool_Package\tool-cmlink\1.0.0\cmlink\bin\cmlink_gdbserver.exe
        description: proxy location
        system: true    # 默认为false，当system为true时，该变量引用时直接使用变量名，例如${proxy}

    ## Template File Management
    ## Only works on tpp类型，该类型比较特殊，描述文件为npk_template.yml，是基于npk.yml做的扩展
    templatemanage:
      installdir: ${soc}
      files:
        build.mk.ftl: build.mk
        Common/npk.yml.ftl: Common/npk.yml
        Common/demosoc.svd.ftl: Common/${soc}.svd
        Common/Source/demosoc_common.c: Common/Source/${soc}_common.c
        Common/Source/system_demosoc.c.ftl: Common/Source/system_${soc}.c
        Common/Source/Drivers/demosoc_uart.c.ftl: Common/Source/Drivers/${soc}_uart.c
        Common/Source/GCC/intexc_demosoc.S.ftl: Common/Source/GCC/intexc_${soc}.S
        Common/Source/GCC/startup_demosoc.S.ftl: Common/Source/GCC/startup_${soc}.S
        Common/Source/Stubs: Common/Source/Stubs
        Common/Include/demosoc.h.ftl: Common/Include/${soc}.h
        Common/Include/demosoc_uart.h.ftl: Common/Include/${soc}_uart.h
        Common/Include/nuclei_sdk_soc.h.ftl: Common/Include/nuclei_sdk_soc.h
        Common/Include/system_demosoc.h.ftl: Common/Include/system_${soc}.h
        Board/nuclei_fpga_eval/openocd_demosoc.cfg: Board/${board}/openocd_${soc}.cfg
        Board/nuclei_fpga_eval/npk.yml.ftl: Board/${board}/npk.yml
        Board/nuclei_fpga_eval/Source/GCC/gcc_demosoc_ilm.ld.ftl.ftl: Board/${board}/Source/GCC/gcc_${soc}_ilm.ld
        Board/nuclei_fpga_eval/Source/GCC/gcc_demosoc_flash.ld.ftl: Board/${board}/Source/GCC/gcc_${soc}_flash.ld
        Board/nuclei_fpga_eval/Source/GCC/gcc_demosoc_flashxip.ld.ftl: Board/${board}/Source/GCC/gcc_${soc}_flashxip.ld
        Board/nuclei_fpga_eval/Include/board_nuclei_fpga_eval.h.ftl: Board/${board}/Include/board_${board}.h
        Board/nuclei_fpga_eval/Include/nuclei_sdk_hal.h.ftl: Board/${board}/Include/nuclei_sdk_hal.h


内容约定
~~~~~~~~~~~~~~

为了保证 ``npk.yml`` 文件的可读性与简约性，对 ``npk.yml`` 文件的存储制定如下约定：

* 各字段的存储顺序请保持与模板一致，数据与DICT 按读入时顺序保存
* 各字段建议适当加上注释，尤其是那种需要解释的地方
* **MUST** 类型的字段需要按照上述注释描述的规则进行检查，如果不合规请报错提示，并不予导入
* 缩进建议采用2个空格字符
* 针对一些 **OPTIONAL** 的字段可以留空或者不写该字段
* 一级字段之间增加一行空行，二级及以下字段不使用空行，第一部分基础信息一级字段间不使用空行
* 字符串建议不使用引号，除特殊语法需要
* 所有的`description`字段建议控制在20字符以内，方便排版展示，仅限英文
* 关于yaml里面多行的约定如下： https://yaml-multiline.info/

包导入规则
~~~~~~~~~~~~~~~

下面定义合法的包导入规则：

* 如果存在导入包中存在一些依赖的包(带版本匹配)，并没有被导入，则不允许导入，并提示缺乏依赖的包，请导入该包。
   * 后续包管理联网了，则可以提示是否从网上下载依赖的包，或者手动导入zip包
* 如果删除包，并且该包被其他包依赖，则提示哪些包依赖于该包，询问是否删除，如果删除以后，则在包管理中显示缺少的包
   * 后续包管理联网了，支持点击按钮下载缺失的包，或者手动导入zip包
* 如果导入相同版本的包，则提示该包已经存在，是否替换
* 如果导入不同版本的包，则提示已经存在其他版本的包，是否继续导入
* 导入的包，按照定义的类型分类显示，显示包的版本，包的name，owner，description, homepage, license

zip包内容规范
~~~~~~~~~~~~~~~~~~

下面定义合法的zip包的内容规则：

* 一个zip包中必须包含至少1个npk文件
* 包类型的判定：如果包内存在多个类型的npk文件，npk类型判定条件如下
    * sdk > ssp > bsp > osp > mwp >  csp > app
    * 如果判定出包的类型存在多个相同的npk，则该包不合法，不允许导入，并提示
* 该类型的包不允许存在多个该类型的npk文件
* 如果是 ``sdk`` 类型的包，则必须包含至少一个 ``ssp`` 和依赖于该 ``ssp`` 的 ``bsp`` 文件，以及至少一个 ``app`` 类型的文件，允许存在其他类型的包
* 如果是其他类型的包，则里面包含的其他npk，必须显式依赖于该包

包依赖关系处理
~~~~~~~~~~~~~~~~~~~

包依赖关系的处理涉及到如何能够将包拆分并形成合理的依赖关系，便于包的独立维护。这里对不同类型的包的依赖处理进行详细的分析。

依赖通过 ``dependencies`` 字段下的依赖列表来控制，支持依赖特定owner的某个name，某个version版本的包，查找规则为 ``owner/name:version`` ，如果owner未定义，则默认为该npk文件中定义的owner，如果 ``version`` 未定义，则优先在同组件包查找，否则取最新的包。

csp Core Support Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

csp类型的包是处理器内核CORE支持的软件包，目前针对Nuclei RISC-V内核，我们主要推广NMSIS这样的开源软件支持包。

一般情况下，csp类型的包是非常底层的包，这里不支持依赖 ``ssp/bsp/mwp/rtos/app`` 这样的类型的包。但是可以依赖sdk类型的包，表示该包属于依赖的sdk包的环境中。

ssp SoC Support Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ssp类型的包是SoC或者芯片的支持的软件包，例如 ``gd32vf103`` , ``demosoc`` 这样SoC的支持软件包。

ssp软件包仅可以依赖 ``csp/mwp/osp`` 这样的软件包，如果依赖了这三种类型的软件包，则表示在工程创建的时候或者是代码引入的时候，这三类软件包需要导入代码。 **而如果依赖sdk类型的软件包，则表示该ssp类型的包属于依赖的sdk类型的软件包的环境。**

理论上用户可以创建一个ssp软件包，不依赖任何 ``csp/mwp/rtos`` 的软件包，也不属于sdk类型的软件包。 **osp** 类型软件包仅可以依赖一个。

bsp Board Support Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

bsp类型的包是针对基于某款SoC/芯片做的开发板而推出的软件支持包，例如 ``gd32vf103-rvstar`` 这款开发板的bsp软件包。

bsp软件包仅可以依赖 ``ssp/csp/mwp/osp`` 这样的软件包, 如果依赖了这几种类型的软件包，则表示在工程创建的时候或者是代码引入的时候，这类软件包需要导入代码。 **而如果依赖sdk类型的软件包，则表示该ssp类型的包属于依赖的sdk类型的软件包的环境。**

理论上用户可以创建一个bsp软件包，不依赖任何软件包。 **osp** 类型软件包仅可以依赖一个。

osp OS Support Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

osp类型的包是指特定的RTOS的软件支持包，例如freertos，ucosii之类的。

osp类型的包仅可以依赖 ``ssp/csp/mwp`` 类型的软件包，如果依赖了这几种类型的软件包，则表示在工程创建的时候或者是代码引入的时候，这类软件包需要导入代码。 **而如果依赖sdk类型的软件包，则表示该ssp类型的包属于依赖的sdk类型的软件包的环境。**

mwp Middleware Support Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

mwp类型的软件包是指中间件类型的软件包，例如某个语音算法的库，某种物联网连接库如 ``mqtt`` , ``coap`` 之类。

mwp类型的包仅可以依赖 ``bsp/ssp/csp/mwp/osp`` 类型的软件包，但是不建议直接依赖 ``bsp/ssp`` ，在创建middleware的时候尽量保证其通用性，可以很好被集成到其他的软件中。

sdk Software Development Kit Package依赖
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

sdk类型的软件包是一类非常特殊的软件包，本身并不会有额外的代码引入，而是通过依赖其他类型的软件包而组织的一个特殊的包。如果是sdk类型的软件包，导入是会强制检查软件包目录下所有的 ``npk.yml`` 文件以查找其他的软件包并引入该SDK依赖中，无需 ``npk.yml`` 文件显示进行依赖，这种依赖关系并不会直接导致创建工程时的代码的导入，更多的是软件包的集合。

一个sdk类型的软件包可能会依赖多个ssp，多个bsp，多个csp，多个app，多个mwp和多个osp。更详细的内容请参见[构建SDK开发包](#构建SDK开发包)

对于属于sdk类型的软件包的其他软件包里面的依赖，优先使用都属于统一sdk软件包内部的软件包。例如：

* sdk-nuclei-sdk是一个sdk类型的软件包，内部包含了csp-nsdk_nmsis, bsp-nsdk_nuclei_fpga_eval, ssp-nsdk_demosoc, ssp-nsdk_gd32vf103, osp-nsdk_freertos, osp-nsdk_ucosii这些软件包
* 而外部也有csp-nsdk_nmsis，osp-nsdk_freertos这类的软件包，在工程创建阶段，在版本匹配满足的情况下，优先使用内部的csp-nsdk_nmsis和osp-nsdk_freertos，只有在版本匹配不满足要求的情况下，才会使用
* 在工程创建完成后，用户可以手动升级特定的包到其他版本。


模块说明
-----------

从上述描述文件中可以看出，一个标准的 ``npk.yml`` 实际是上由几个大块组成的，而在实现应用中，我们并不一定会完全用到，一个合规的 ``npk.yml`` 文件，只要拥有基本的信息，就是可以正常给Nuclei Studio使用。

Package Base Information
~~~~~~~~~~~~~~~~~~~~~~~~~~~

这一块分信息，是NPK的基础的信息，很多关键的信息在这部分内容中需要描述清楚。其中着重说明几个字段。

* **name** 

必填，NPK的名称ID，不要有空格，符合C语言命名规范，英文名称，是唯一名称ID。

* **version** 

选填，如不填，默认为空，建议采用SEMVER2.0版本号管理，只能数字打头, 例如1.2.3

* **type** 

必填， 可选类型值有csp, ssp, bsp, osp, app, mwp, sdk, tpp, tool

* **os** 

选填，标明该NPK适用于什么类型的Nuclei Studio，目前我们发行的Nuclei Studio有win64和lin64两个版本。OS类型可以填win32、win64、lin64、lin32,但目前组件包上传页面只支持win64和lin64,该字段只存在tool类型package


* **owner** 

必填，组件包的拥有者，该ID一般为认证开发者ID，便于后期进行权限查找匹配。如果该NPK仅作本地测试，可以随意。

Package Information
^^^^^^^^^^^^^^^^^^^^

**packinfo** 这一块分信息，主要是对NPK做一些说明，包括一些文档等信息，最终在Nuclei Studio中使用该NPK时，这部分信息，会在New Project的导引中显示。

Package Dependency
^^^^^^^^^^^^^^^^^^^

**dependencies** 描述的是NPK的依赖关系，为了实现NPK的复用性，减少NPK的维护成本，我们在设计时，是允许NPK实现依赖关系，一个NPK可以依赖0个以上的NPK，所以在这里dependencies是以组对象出现，每个依赖对象内需要明确NPK的 **name** **owner** **version**

Package Configurations
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Configuration** 字段是个非常特殊的字段，主要用于提供一些可配置项，以满足在工程创建时的交互场景。

不同包里面的configuration字段的下的二级字段名称可以一样，如果使用一样的名称则具备一样的含义，如果定义了一样的名称则按照如下的规则进行覆盖。

覆盖规则为：app > mwp  > osp > bsp > ssp > csp

**Configuration** 对象组会包含多个对象，而每个对象有固定的结构。

* **XXX(变量名)** 

变量名可以随意，简合c++的命名规范即可。在后面部分会以${XXX}或${XXX.XX}的方式引用。

* **default** 

默认值，可选项。

* **type** 

这个变量的类型，为了支持更丰富的UI体验，我们在NPK中定义了很多的UI组件类型，具体请参看后面章节。

* **global** 

标明此字段是否在工程创建时显示在引导页面中。

* **tips** 

对该变量的说明信息，主要用于UI的tips事件。

* **hints** 

对该变量的说明信息，如值的示例等，主要用于UI的hints事件。

* **description** 

此变量的NPK中的说明描述。

* **UI组件信息** 

支持的类型有choice, list, checkbox, multicheckbox, text等，具体信息参见

Source Code Management
~~~~~~~~~~~~~~~~~~~~~~

**codemanage** 描述的是跟模板工程有关的内容，大多的时候，我们的NPK会包括很多复杂的功能，需要创建某个一个具体的工程的时候，我们又只需要一些具体的文件，同时需要配置这些文件的信息。**codemanage** 就是将这些信息描述出来，它包含以下关键字：

* **custom** 

默认为false, 当为true时，这个installdir就表示直接安装的目录

* **srcroot** 

默认为 ``.`` ， 表示当前 ``npk.yml`` 所在目录，可以是相对路径, 例如 ``../`` ， ``../bsp`` 等；需要注意的是，设置了这个以后，对应的copyfiles/incdirs/libdirs的路径的根目录均受到影响，就会使用新设置的和这个路径

* **installdir** 

希望代码安装的目录名称，仅限英文，满足C语言命名格式

- 针对sdk类型的package,会被安装到 ``<sdk_installdir>`` , 如果installdir未定义，默认为SDK，如果没有任何sdk类型的package被引用，sdk_installdir也被默认设置为SDK

- 针对csp类型的package,会被安装到 ``<sdk_installdir>/<csp_installdir>`` 目录下，TBD

- 针对ssp类型的package,会被安装到 ``<sdk_installdir>/SoC/<ssp_installdir>/Common`` 下面

- 针对bsp类型的package,会被安装到 ``<sdk_installdir>/SoC/<ssp_installdir>/Board/<bsp_installdir>`` 下面，如果不依赖于任何ssp类型，则安装到 ``<sdk_installdir>/BSP/<bsp_installdir>``

- 针对osp类型的package,会被安装到 ``<sdk_installdir>/OS/<osp_installdir>`` 下面

- 针对app类型的package,会被安装到 ``<app_installdir>/`` 目录下， 如果installdir未定义，默认为application

- 针对mwp类型的package,会被安装到 ``<sdk_installdir>/Components/<mwp_installdir>`` 目录下

.. note::

    2023.05.26 新增 ``copyfiles/incdirs/libdirs`` 均支持 ``../../`` 这样的相对上级目录，但是安装或者设置路径的时候，均设置到 ``<installdir>`` 下面

    例如: ``path: ["../common/"]`` 就拷贝上一级目录的 ``common`` , 并放在 ``<installdir>/common`` 下面，

    如果下面有 ``common`` 这个目录，则创建 ``R1L_common`` , 如果是 ``../../common`` , 则创建 ``R2L_common`` ，

    这种方案不考虑了，直接创建同名目录，同名文件直接覆盖，建议采用 ``srcroot: ..`` 来解决问题对应的 ``incdirs/libdirs`` 

    如果遇到这种相对路径，也需要以最终安装到路径以及文件名为准


* **copyfiles** 

待拷贝的文件或者文件夹，这里是指所有的目录或者文件，支持 ``../`` 、 ``*`` 、 ``*.*`` ，给结合srcroot一起使用，

* **incdirs** 

必填，加入头文件目录列表，Nuclei Studio会进行补全，最终的路径是相对于工程根目录的路径。

* **libdirs** 

可选，lib库所在目录，Nuclei Studio会进行补全，最终的路径是相对于工程根目录的路径。

* **ldlibs** 

可选的需要链接的库，Nuclei Studio会进行补全，最终的路径是相对于工程根目录的路径。


Set Configuration for other packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**setconfig** 用来设置NPK的其他选项，遵循覆盖规则app > mwp  > osp > bsp > ssp > csp。

**setconfig** 是一个对象组，可以无限扩展，每个对象中有三个字段来描述一个对象。

* **config** 

变量名，遵循C++命名规范，一般变量XXX,在其它部分以${XXX}的方式引用

该变量名不唯一，可以通过条件进行判定生效，也遵循覆盖规则app > mwp  > osp > bsp > ssp > csp，进行自动覆盖。

* **value** 

变量的值

* **condition** 

变量的条件，只有条件生效时，该变量的该值才会生效

Build Configuration
~~~~~~~~~~~~~~~~~~~~~

设置工程的编译工具和编译选项的配置，它的关键字包含以下几个固定字段。

* **type** 

支持的编译工具的类型，值一般为gcc、clang、common。目前只支持gcc、clang两种，因为编译选项的配置有一些是相同的，为了提高代码的复用性，我们又添加common类型。

* **description** 

对此编译工具的说明。

* **toolchain_name** 

重要字段，编译工具名字。

* **cross_prefix** 

重要字段，编译工具的前缀。

* **unflags** 

在buildconfig section中的 ``common_flags/cflags/asmflags/ldflags/cxxflags`` 中生效，用于删掉之前已经定义的flags。

* **undefines** 

在buildconfig section中的 ``common_defines/cdefines/asmdefines/cxxdefines`` 中生效，用于删掉之前已经定义的defines。（字符串完全匹配，则生效）

* **common_flags** 

用的编译选项，将会添加到cflags, asmflags, cxxflags上，留空表示没有任何选项。

* **ldflags** 

链接选项列表，留空表示没有任何选项。

* **linkscript** 

链接脚本的定义，必须在bsp/ssp中定义，留空表示没有任何选项。

* **cflags** 

C编译选项，留空表示没有任何选项。

* **asmflags** 

ASM编译选项，留空表示没有任何选项。

* **cxxflags** 

CXX编译选项，留空表示没有任何选项。

* **common_defines** 

通用的宏定义，留空表示没有任何选项。

* **cdefines** 

C的宏定义，留空表示没有任何选项。

* **asmdefines** 

ASM的宏定义，留空表示没有任何选项。

* **cxxdefines** 

CXX的宏定义，留空表示没有任何选项。

* **prebuild_steps** 

    * **command** 

    编译前执行的命令，留空表示没有任何选项。

    * **description** 

    编译前执行的命令的说明，留空表示没有任何选项。

* **postbuild_steps** 

    * **command** 

    编译后执行的命令，留空表示没有任何选项。

    * **description** 

    编译后执行的命令的说明，留空表示没有任何选项。

Debug Configuration
~~~~~~~~~~~~~~~~~~~~~

设置工程的Debug类型及相关参数的配置，它的关键字包含以下几个固定字段，可以不用配，如果配置了，在工程生成的时候，Nuclei Studio会根据这里面的内容，生成了个launch文件，同时可以根据相关内容进行工程的Debug。

* **type** 

Debug类型,目前支持GDB Custom 、GDB SEGGER J-Link、 GDB OpenOCD、 GDB Nuclei QEMU、 Nuclei RVProf

* **description** 

对支持的Custom Jlink OpenOCD Qemu RVProf的说明

* **configs** 

对应的Debug类型的参数，所有的参数，都是以key-value的方式出现，因为每中Debug类型所需参数不同，对应的情况也不同，更详细的说明如下。

.. code-block:: yaml

    debugconfig:
      - type: openocd
        description: Nuclei OpenOCD
        configs:
          - key: XXXX
            value: xxxx


GDB Custom的Debug参数
^^^^^^^^^^^^^^^^^^^^^^

.. _table_ips_1:

.. table:: Arguments of GDB Custom Debug

  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | Name                                 | Reset Value                         | Description                                    |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbCLient                     | true                                | Start locally                                  |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbServer                     | true                                | Start GDB session                              |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherCommands               |                                     | gdb Client Other Commands                      |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherOptions                |                                     | gdb Client Other Options                       |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbMode                              | Commands                            | Supported types: Commands, General, and Dlink  |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerConnectionAddress           |                                     | gdb Server Connection Address                  |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerExecutable                  |                                     | gdb Server Executable                          |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | serverCheckFlag                      | Started by GNU MCU Eclipse          | server Check Flag                              |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerGdbPortNumber               | 3333                                | gdb Server Gdb Port Number                     |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerOther                       |                                     | Config options                                 |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | DEBUG_NAME                           | ${cross_prefix}gdb${cross_suffix}   | Executable path                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | ipAddress                            | localhost                           | Host name or lP address                        |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | portNumber                           | 3333                                |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | UPDATE_THREADLIST_ON_SUSPEND         | false                               | Force thread list update on suspend            |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | otherInitCommands                    |                                     | Initialization Commands                        |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | loadImage                            | true                                | Load executable                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | imageFileName                        |                                     | use File For lmage name                        |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | imageOffset                          |                                     | Executable offset (hex)                        |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForImage                      | false                               | Use file for Image                             |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForImage                | true                                |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | loadSymbols                          | true                                | Load symbols                                   |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsFileName                      |                                     |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsOffset                        |                                     | Symbols offset (hex)                           |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForSymbols              | true                                | Use project binany                             |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForSymbols                    | false                               | Use file for Symbols                           |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | doDebugInRam                         | true                                | Debug in RAM                                   |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | otherRunCommands                     |                                     | Run/Restart Commands                           |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | setPcRegister                        | false                               | Set program counter at (hex)                   |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | pcRegister                           |                                     |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | setResume                            | false                               |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | setStopAt                            | true                                | Set breakpoint at                              |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | stopAt                               | main                                |                                                |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | doContinue                           | true                                | Continue                                       |
  +--------------------------------------+-------------------------------------+------------------------------------------------+
  | svdPath                              |                                     | svd file path                                  |
  +--------------------------------------+-------------------------------------+------------------------------------------------+


GDB SEGGER J-Link的Debug参数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. _table_ips_2:

.. table:: Arguments of GDB SEGGER J-Link Debug

  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | Name                                   | Reset Value                         | Description                                    |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | arch                                   |                                     | Nuclei ARCH                                    |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | executable                             |                                     | OpenOCD Executable Name                        |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapreopts                      |                                     | Additional value, prepended to Config options  |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extraopts                         |                                     | Additional value, replacing Config  options    |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapostopts                     |                                     | Additional value, appended to Config options   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extraprecmds                       |                                     | Additional value, prepended to Commands        |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extracmds                          |                                     | Additional value, replacing Commands           |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extrapostcmds                      |                                     | Additional value, appended to Commands         |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbServer                       | true                                | Start the j-Link GDB server locally            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doConnectToRunning                     | false                               | Connect to running target                      |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerExecutable                    |                                     | Executable path                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerAllocateConsole             | true                                | Allocate console for the GDB server            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerInitRegs                    | true                                | do Gdb Server Init Regs                        |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerLocalOnly                   | true                                | do Gdb Server Local Only                       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerSilent                      | false                               | do Gdb Server Silent                           |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerVerifyDownload              | true                                | do Gdb Server Verify Download                  |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbServer                       | true                                | Start the j-Link GDB server locally            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherCommands                 | set mem inaccessible-by-default off | gdb Client Other Commands                      |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerConnection                    | usb                                 | gdb Server Connection                          |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerConnectionAddress             |                                     | gdb Server Connection Address                  |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerDebugInterface                | jtag                                | gdb Server Debug Interface                     |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerDeviceEndianness              | little                              | gdb Server Device Endianness                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerDeviceName                    |                                     | gdb Server Device Name                         |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerLog                           |                                     | gdb Server Log path                            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerGdbPortNumber                 | 2331                                | gdb Server Gdb Port Number                     |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerSwoPortNumber                 | 2332                                | gdb Server SwoPort Number                      |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerTelnetPortNumber              | 2333                                | gdb Server Telnet PortNumber                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerOther                         |                                     | gdb ServerO ther                               |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | DEBUG_NAME                             | ${cross_prefix}gdb${cross_suffix}   | Executable path                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherOptions                  |                                     | gdb Client Other Options                       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | ipAddress                              | localhost                           |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | portNumber                             | 2331                                |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerDeviceSpeed                   | auto                                | gdb Server Device Speed                        |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doFirstReset                           | false                               | Initial Reset and Halt                         |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | firstResetType                         |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | firstResetSpeed                        | 1000                                |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | enableFlashBreakpoints                 | true                                | Enable flash breakpoints                       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerAllocateSemihostingConsole  | true                                | Allocate console for semihosting and SWO       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSemihosting                      | true                                | Enable semihosting console routed to           |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSemihostingIoclientTelnet        | true                                | Telnet                                         |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSemihostingIoclientGdbClient     | false                               | GDB client                                     |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSwo                              | true                                | Enable SWO                                     |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | swoEnableTargetCpuFreq                 | 0                                   | SWO Cpu freq                                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | swoEnableTargetSwoFreq                 | 0                                   | SWO freq                                       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | swoEnableTargetPortMask                | 0x1                                 | SWO Port mask                                  |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | otherInitCommands                      |                                     | other Init Commands                            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | jtagDevice                             | GNU MCU J-Link                      |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | loadImage                              | true                                | Load executable                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | imageFileName                          |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | imageOffset                            |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForImage                        | false                               |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForImage                  | true                                |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | loadSymbols                            | true                                | Load symbols                                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsFileName                        |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsOffset                          |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForSymbols                      | false                               |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForSymbols                | true                                |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doDebugInRam                           | true                                | Debug in RAM                                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doSecondReset                          | true                                | Pre-run/Restart reset                          |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | secondResetType                        |                                     | Type (always executed at Restart)              |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | otherRunCommands                       |                                     |                                                |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | setPcRegister                          | false                               | Set program counter                            |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | pcRegister                             |                                     | Set program counter at (hex)                   |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | setStopAt                              | true                                | Set breakpoint                                 |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | stopAt                                 | main                                | Set breakpoint at                              |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | doContinue                             | true                                | Continue                                       |
  +----------------------------------------+-------------------------------------+------------------------------------------------+
  | svdPath                                |                                     | svd file path                                  |
  +----------------------------------------+-------------------------------------+------------------------------------------------+

GDB OpenOCD的Debug参数
^^^^^^^^^^^^^^^^^^^^^^^

.. _table_ips_3:

.. table:: Arguments of GDB OpenOCD Debug

  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | Name                                      | Reset Value                         | Description                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | arch                                      |                                     | Nuclei ARCH                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | executable                                |                                     | OpenOCD Executable Name                        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapreopts                         |                                     | Additional value, prepended to Config options  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extraopts                            |                                     | Additional value, replacing Config  options    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapostopts                        |                                     | Additional value, appended to Config options   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extraprecmds                          |                                     | Additional value, prepended to Commands        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extracmds                             |                                     | Additional value, replacing Commands           |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extrapostcmds                         |                                     | Additional value, appended to Commands         |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbServer                          | true                                | Start OpenocD locally                          |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerExecutable                       |                                     | Executable path                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerGdbPortNumber                    | 3333                                | GDB port                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerTelnetPortNumber                 | 4444                                | Telnet port                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerTclPortNumber                    | 6666                                | Tcl port                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherOptions                     |                                     | gdb Client Other Options                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerOther                            |                                     | Config options                                 |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerAllocateConsole                | true                                | do GdbServer Allocate Console                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerAllocateTelnetConsole          | false                               | do Gdb Server Allocate Telnet Console          |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerConnectionAddress                |                                     | gdb Server Connection Address                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbCLient                          | true                                | do Start Gdb CLient                            |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | DEBUG_NAME                                | ${cross_prefix}gdb${cross_suffix}   |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherCommands                    |                                     | Commands                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | ipAddress                                 | localhost                           | Host name or lp address                        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | portNumber                                | 3333                                | Port number                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | UPDATE_THREADLIST_ON_SUSPEND              | false                               | Force thread list update on suspend            |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doFirstReset                              | false                               | Initial Reset and Halt                         |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | firstResetType                            | init                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | otherInitCommands                         |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSemihosting                         | false                               | Enable semihosting console routed to           |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | loadImage                                 | true                                | Load executable                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForImage                           | false                               |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | imageFileName                             |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | imageOffset                               |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsFileName                           |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsOffset                             |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | loadSymbols                               | true                                | Load symbols                                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForSymbols                         | false                               |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForImage                     | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForSymbols                   | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useRemoteTarget                           | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doDebugInRam                              | true                                | Debug in RAM                                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doSecondReset                             | true                                | Pre-run/Restart reset                          |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | secondResetType                           | halt                                | Type (always executed at Restart)              |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | otherRunCommands                          |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | setPcRegister                             | false                               | Set program counter                            |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | pcRegister                                |                                     | Set program counter at (hex)                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | setStopAt                                 | true                                | Set breakpoint                                 |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | stopAt                                    | main                                | Set breakpoint at                              |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doContinue                                | true                                | Continue                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | svdPath                                   |                                     | svd file path                                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+

GDB Nuclei QEMU的参数
^^^^^^^^^^^^^^^^^^^^^^

.. _table_ips_4:

.. table:: Arguments of GDB Nuclei QEMU Debug

  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | Name                                      | Reset Value                         | Description                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | nuclei_archext                            |                                     | Nuclei archext                                 |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | extra_board                               |                                     | Nuclei DevelopBoard                            |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | extra_cpu                                 |                                     | Nuclei CPU Core                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | riscv_arch                                |                                     | Nuclei ARCH                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | executable                                |                                     | OpenOCD Executable Name                        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapreopts                         |                                     | Additional value, prepended to Config options  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extraopts                            |                                     | Additional value, replacing Config  options    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | tool_extrapostopts                        |                                     | Additional value, appended to Config options   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extraprecmds                          |                                     | Additional value, prepended to Commands        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extracmds                             |                                     | Additional value, replacing Commands           |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdb_extrapostcmds                         |                                     | Additional value, appended to Commands         |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doStartGdbServer                          | true                                | Start OpenocD locally                          |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerExecutable                       |                                     | Executable path                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbMachineBit                             |                                     | Machine Bit                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerBoardName                        |                                     | Board name                                     |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbCoreName                               |                                     | Nuclei RISC-V Core                             |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerSMPCount                         | 1                                   | Nuclei SMP Count                               |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbDownloadName                           |                                     | Download                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerOther                            | -serial stdio -nodefaults -S        | More options                                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | otherExtensions                           |                                     | other Extensions                               |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbServerGdbPortNumber                    | 1234                                | GDB port                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | isGdbServerVerbose                        | false                               | Extra verbose                                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | enableSemihosting                         | true                                | Enable Arm semihosting                         |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | disableGraphics                           | true                                | Do not open graphic windows                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doGdbServerAllocateConsole                | true                                | Allocate console for QEMU                      |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | DEBUG_NAME                                | ${cross_prefix}gdb${cross_suffix}   | Executable name                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherOptions                     |                                     | Other options                                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | gdbClientOtherCommands                    |                                     | Commands                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | ipAddress                                 | localhost                           | Host name or lp address                        |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | portNumber                                | 1234                                | Port number                                    |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doFirstReset                              | false                               | Initial Reset and Halt                         |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | otherInitCommands                         |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | loadSymbols                               | true                                | Load symbols                                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsFileName                           |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | symbolsOffset                             |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForSymbols                         | false                               |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForSymbols                   | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useRemoteTarget                           | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | loadImage                                 | true                                | Load executable                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useFileForImage                           | false                               |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | imageFileName                             |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | imageOffset                               |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | useProjBinaryForImage                     | true                                |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doDebugInRam                              | false                               | Debug in RAM                                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | otherRunCommands                          |                                     |                                                |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doSecondReset                             | true                                | Pre-run/Restart reset                          |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | setPcRegister                             | false                               | Set program counter                            |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | pcRegister                                |                                     | Set program counter at (hex)                   |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | setStopAt                                 | true                                | Set breakpoint                                 |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | stopAt                                    | main                                | Set breakpoint at                              |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | doContinue                                | true                                | Continue                                       |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+
  | svdPath                                   |                                     | SVD file path                                  |
  +-------------------------------------------+-------------------------------------+------------------------------------------------+

Nuclei RVProf的参数
^^^^^^^^^^^^^^^^^^^^

.. _table_ips_5:

.. table:: Arguments of Nuclei RVProf

  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | Name                                      | Reset Value                                 | Description                                    |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | cycleModelExecutable                      | ${cyclemodel_path}/${cyclemodel_executable} | cycleModel Executable                          |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | cycleModelExecutableTimeOut               | 20                                          | cycleModelExecutable TimeOut                   |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | cycleModelExecutableProcessorCores        | 4                                           | cycleModel Executable Processor Cores          |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | cycleModelOther                           |                                             | cycleModel Other                               |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | docycleModelAllocateConsole               | true                                        |                                                |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | docycleModelAllocateTelnetConsole         | false                                       |                                                |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | RVProfExecutable                          | ${rvprof_path}/${rvprof_executable}         | RVProf Executable                              |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | RVProfExecutableTimeOut                   | 20                                          | RVProf Executable TimeOut                      |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | RVProfOther                               |                                             | RVProf Other                                   |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | RVProfPortNumber                          | 5000                                        | RVProfPort Number                              |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | doRVProfAllocateConsole                   | true                                        |                                                |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+
  | doRVProfAllocateTelnetConsole             | false                                       |                                                |
  +-------------------------------------------+---------------------------------------------+------------------------------------------------+


Extended variable
~~~~~~~~~~~~~~~~~~
**environment** 是应用于tool类型的NPK包中的配置，当用户想要通过NPK来共享一个工具（tools类型，如cycleModel)，可以使用environment 配置。定义 **environment** 后，Nuclei Studio会自动生成几个全局变量，这些变量可以在其他的NPK中以 ``${xxx-1.0.0-XXX}`` 的方式引用。

.. note::

    - 每个包存在一个包路径，引用为npk名称-版本号，例如 ``${tool-cyclemodel-1.0.0}``

    - 其他变量的引用为npk名称-版本号-变量名，例如 ``${tool-cyclemodel-1.0.0-cyclemodel_path}`` , ``${tool-cyclemodel-1.0.0-cyclemodel_executable}``

    - 当变量的system值为true时，会额外生成一个不带版本号的变量（取最高版本），例如 ``${tool-cyclemodel-cyclemodel_executable}``

.. code-block:: yaml

    name: tool-cyclemodel
    owner: nuclei
    os:
    version: 1.0.0
    description: Nuclei Tools cyclemodel
    details: Nuclei Tools cyclemodel
    type: tool
    keywords:
      - tool
      - cyclemodel
    license: Apache-2.0
    homepage:

    ## 扩展变量  tool-cyclemodel-1.0.0与 tool-cyclemodel-1.0.0-proxy
    environment:
      - key: cyclemodel_path
        value: bin
        description: cyclemodel path
        system: true
      - key: cyclemodel_executable
        value: bin/n300_best_config_cymodel_latest
        description: cyclemodel executable
        system: true


    ## 这是另一个NPK中的代码，演示了如何使用tool-cyclemodel
    debugconfig:
      - type: rvprof
        description: Nuclei RVProf
        configs:
          - key: ncycm_path
            value: ${tool-cyclemodel-1.0.0-cyclemodel_executable}
          - key: rvprof_path
            value: ${tool-rvprof-1.0.0-rvprof_executable}

templatemanage
~~~~~~~~~~~~~~~

内部使用的配置，这里不做详细说明。

NPK中的UI组件
--------------


NPK中提供了丰富的UI组件，这些组件的字段里面都会有default, description, global这些子字段，这些字段均具备含义。

default表示默认值，description表示该选项的含义，global表示这个选项是否在工程创建时显示(true)，或者仅仅内部传参使用(false)。

* **Choice 单项选择框** 

.. code-block:: yaml

    choice_test:
      default_value: ground
      type: choice
      description: choice_test
      choices:
        - name: ground
          description: Ground Rules
          info:
            - name: app_commonflags
              value: >-
                -O3 -flto -fno-inline -funroll-loops -Wno-implicit -mexplicit-relocs
                -fno-builtin-printf -fno-common -falign-functions=4 -falign-jumps=4 -falign-loops=4
        - name: inline
          description: Inline
          info:
            - name: app_commonflags
              value: >-
                -O3 -flto -finline -funroll-loops -Wno-implicit -mexplicit-relocs -fno-builtin-printf
                -fno-common -falign-functions=4 -falign-jumps=4 -falign-loops=4 -finline-functions
        - name: best
          description: Best Effort
          info:
            - name: app_commonflags
              value: >-
                -Ofast -flto -fwhole-program -finline -funroll-loops -Wno-implicit -mexplicit-relocs
                -fno-builtin-printf -fno-common -falign-functions=4 -falign-jumps=4 -falign-loops=4
                -finline-functions

.. _figure_about_project_1:

.. figure:: /asserts/nucleistudio/npkoverview/image.png

* **list 单项选择框** 

.. code-block:: yaml

    list_test:
      default_value: rv32imac
      type: list
      global: true
      description: list_test
      value: >-
        [rv32imac,rv32imafc,rv32imafdc,rv32imacb,rv32imafcb,rv32imafdcb]

.. _figure_about_project_1_1:

.. figure:: /asserts/nucleistudio/npkoverview/image-1.png

* **checkbox 单项勾选框** 

.. code-block:: yaml

    checkbox_test:
      default_value: 0
      type: checkbox
      global: true
      description: checkbox_test


.. _figure_about_project_1_2:

.. figure:: /asserts/nucleistudio/npkoverview/image-2.png

* **multicheckbox 穿梭选择框** 

  下面提供2种写法

.. code-block:: yaml

    multicheckbox_old:
      default_value: []
      type: multicheckbox
      global: true
      description: multicheckbox_old
      choices:
        - name: b
          description: Bitmanip Extension
        - name: p
          description: Packed SIMD Extension
        - name: v
          description: Vector Extension

.. _figure_about_project_1_3:

.. figure:: /asserts/nucleistudio/npkoverview/image-3.png

.. code-block:: yaml

    multicheckbox_new:
      default_value: rv32imac
      type: multicheckbox
      global: true
      description: multicheckbox_new
      param:
        name: ["rv32imac","rv32imafc","rv32imafdc"]
        description: ["${name} description","${name} description","${name} description"]


.. _figure_about_project_1_4:

.. figure:: /asserts/nucleistudio/npkoverview/image-4.png

* **text 单行文本框** 

.. code-block:: yaml

    text_test:
      value: >-
        -O2 -funroll-all-loops -finline-limit=600 -ftree-dominator-opts
        -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting
        -fno-common -funroll-loops -finline-functions -falign-functions=4
        -falign-jumps=4 -falign-loops=4
      type: text
      description: text_test

.. _figure_about_project_1_5:

.. figure:: /asserts/nucleistudio/npkoverview/image-5.png

* **multitext 多行文本框** 

.. code-block:: yaml

    multitext_test:
      value: >-
        -O2 -funroll-all-loops -finline-limit=600 -ftree-dominator-opts
        -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting
        -fno-common -funroll-loops -finline-functions -falign-functions=4
        -falign-jumps=4 -falign-loops=4
      type: multitext
      description: multitext_test


.. _figure_about_project_1_6:

.. figure:: /asserts/nucleistudio/npkoverview/image-6.png

* **multichoice 多选下拉框** 

  下面提供2种写法

.. code-block:: yaml

    multichoice_test1:
      default_value: []
      type: multichoice
      global: true
      description: multichoice_test1
      param:
        name: ["rv32imac","rv32imafc","rv32imafdc"]
        description: ["${name} description","${name} description","${name} description"]

.. _figure_about_project_1_7:

.. figure:: /asserts/nucleistudio/npkoverview/image-7.png

.. code-block:: yaml

    multichoice_test2:
      default_value: >-
       [rv32imac,rv32imafdc]
      type: multichoice
      global: true
      description: multichoice_test2
      choices:
        - name: rv32imac      #
          description: ${name} description
        - name: rv32imafc
          description: ${name} description
        - name: rv32imafdc
          description: ${name} description


.. _figure_about_project_1_8:

.. figure:: /asserts/nucleistudio/npkoverview/image-8.png

* **cascaderchoice 级联选择框** 

.. code-block:: yaml

    cascaderchoice_test:
      default_value: >-
       [hubei,jingzhou,shashi]
      type: cascaderchoice
      global: true
      description: cascaderchoice test
      cascader_param:
        - hubei:
            - wuhan
            - jingzhou:
                - shashi
                - jianli
        - hunan:
            - changsha
            - guangdong

.. _figure_about_project_1_9:

.. figure:: /asserts/nucleistudio/npkoverview/image-9.png

* **switchbutton 开关** 

.. code-block:: yaml

    switchbutton_test:
      default_value: 0
      type: switchbutton
      global: true
      description: switchbutton test


.. _figure_about_project_1_10:

.. figure:: /asserts/nucleistudio/npkoverview/image-10.png

* **slider 数字选择框** 

.. code-block:: yaml

    slider_test:
      default_value: 0
      type: slider
      description: slider_test
      param:
        range: >-
         [0,100,1]

.. _figure_about_project_1_11:

.. figure:: /asserts/nucleistudio/npkoverview/image-11.png

* **spinner 数字选择框** 

.. code-block:: yaml

    spinner_test:
      default_value: 10
      type: spinner
      description: spinner_test
      param:
        range: >-
         [-100,100,2]


.. _figure_about_project_1_12:

.. figure:: /asserts/nucleistudio/npkoverview/image-12.png

* **multispinner 多数字选择框** 

.. code-block:: yaml

    multispinner_test:
      default_value: >-
       [3,4,6,4,6,4,6,4,6,7]
      type: multispinner
      global: true
      description: multispinner_test
      param:
        range: >-
         [-100,100,1],[-100,100,2],[-100,100,3],[-100,100,3],[-100,100,3],[-100,100,3],[-100,100,3],[-100,100,3],[-100,100,3],[-100,100,4]

.. _figure_about_project_1_13:

.. figure:: /asserts/nucleistudio/npkoverview/image-13.png

* **multicheckbox_v2 多项勾选框** 

  下面提供2种写法

.. code-block:: yaml

    multicheckbox_v2_test1:
    default_value: >-
     [rv32imac]
    type: multicheckbox_v2
    global: true
    description: multicheckbox_v2 test1
    param:
      name: ["rv32imac","rv32imafc","rv32imafdc"]
      description: ["${name} description","${name} description","${name} description"]

.. _figure_about_project_1_14:

.. figure:: /asserts/nucleistudio/npkoverview/image-14.png

.. code-block:: yaml

    multicheckbox_v2_test2:
      default_value: >-
       [rv32imac]
      type: multicheckbox_v2
      global: true
      description: multicheckbox_v2 test2
      choices:
        - name: rv32imac
          description: rv32imac
        - name: rv32imafc
          description: rv32imafc2
        - name: rv32imafdc
          description: rv32imafdc

.. _figure_about_project_1_15:

.. figure:: /asserts/nucleistudio/npkoverview/image-15.png

* **multiradio 单选框** 

  下面提供2种写法

.. code-block:: yaml

    multiradio_test1:
      default_value: rv32imac
      type: multiradio
      global: true
      description: multiradio test1
      param:
        name: ["rv32imac","rv32imafc","rv32imafdc"]
        description: ["${name} description","${name} description","${name} description"]

.. _figure_about_project_1_16:

.. figure:: /asserts/nucleistudio/npkoverview/image-16.png

.. code-block:: yaml

    multiradio_test2:
      default_value: rv32imac
      type: multiradio
      global: true
      description: multiradio test2
      choices:
        - name: rv32imac
          description: rv32imac
        - name: rv32imafc
          description: rv32imafc2
        - name: rv32imafdc
          description: rv32imafdc

.. _figure_about_project_1_17:

.. figure:: /asserts/nucleistudio/npkoverview/image-17.png

NPK的语法
---------

YAML语言
~~~~~~~~~

NPK的描述文件npk.yml，是以YAML语言来编写，所以它支持标准的YAML语法，获取更多YAML相关的信息，可以参考：https://yaml.org/

变量定义
~~~~~~~~~~

NPK的描述语言中，允许用户自义定一个变量，并在有依赖关系的NPK中的任意位置使用

.. note::

    - 例子NPK中定义了一个变量app_commonflags，在与该NPK有依赖关系的任意npk.yml文件内的任意位置，我们可以通过 ``${app_commonflags}`` 来使用app_commonflags的值。

    - 例子NPK中定义了一个list对象nuclei_core,在与该NPK有依赖关系的任意npk.yml文件内的任意位置，我们可以通过 ``${nuclei_core.arch}`` 来使用nuclei_core对象中的arch值；通过 ``${nuclei_core.abi}`` 来使用nuclei_core对象中的abi值；通过 ``${nuclei_core.tune}`` 来使用nuclei_core对象中的tune值。

.. code-block:: yaml

    configuration:
        app_commonflags:
            value:
            type: text
            description: Application Compile Flags

        nuclei_core:
            default_value: n201
            type: choice
            global: true
            description: Nuclei RISC-V Core
            choices:
              - name: n200
                arch: rv32imc
                abi: ilp32
                cmodel: medlow
                tune: nuclei-200-series
                description: N200 Core(ARCH=rv32imc, ABI=ilp32)
              - name: n201
                arch: rv32iac
                abi: ilp32
                cmodel: medlow
                tune: nuclei-200-series
                description: N201 Core(ARCH=rv32iac, ABI=ilp32)
    ## Set Configuration for other packages
    setconfig:
      - config: nmsislibarch
        value: ${nuclei_core.arch}
    ## Build Configuration
    buildconfig:
      - type: gcc
        common_flags: # flags need to be combined together across all packages
          - flags: ${app_commonflags}


关键字
~~~~~~~

为了更好的描述NPK，我们定义了一些字段，以描述出各种关系，其中大部分字段如其字面意义，这里重点介绍以下几个关键字。

* **condition** 

**condition** 在npk.yml中，使用很频繁，是自定义的一个关键字，用来处理逻辑关系，类似 **if** ，具体的使用如下。

.. code-block:: yaml

    ldflags:
      - flags: --specs=nosys.specs
        condition: $( ${stdclib} == "newlib_full" )
      - flags: --specs=nano.specs --specs=nosys.specs -u _printf_float -u _scanf_float
        condition: $( ${stdclib} == "newlib_fast" )
      - flags: --specs=nano.specs --specs=nosys.specs -u _printf_float
        condition: $( ${stdclib} == "newlib_small" )
      - flags: --specs=nano.specs --specs=nosys.specs
        condition: $( ${stdclib} == "newlib_nano" )
      - flags: --specs=${stdclib}.specs
        condition: $( startswith(${stdclib}, "libncrt") )

    # 上述描术中flags的值，由condition决定，当在不同的场景时，flags的值会不同，
    # 又因为flags是一个数组类型，所以上述例子中flags会有多个值，最终使用是，是flags的值拼接成的字符串。

* **dependencies** 

**dependencies** 在npk.yml中，用来描述NPK的依赖关系。

在很多的时候，NPK需要依赖特定owner的某个name，某个version版本的包，查找规则为 ``owner/name:version``, 如果owner未定义，则默认为该npk文件中定义的owner，如果 **version** 未定义，则优先在同组件包查找，否则取最新的包。如果所依赖的包找不到，则该NPK将无法使用。

.. note::

    例子中NPK依赖了三个npk，如下：

    - sdk-nuclei_sdk owner、 ``version`` 未定义，则优先在同组件包查找，否则取最新的包

    - tool-testmodel 明确了owner和version

    - tool-rvprof 明确了owner和version



.. code-block:: yaml

    ## Package Dependency
    dependencies:
      - name: sdk-nuclei_sdk
        version:
        owner:
      - name: tool-testmodel
        version: 1.0.0
        owner: nuclei
      - name: tool-rvprof
        version: 1.0.0
        owner: nuclei


自定函数
~~~~~~~~~

在NPK（npk.yml）中，为了更好地满足各种不同的需求，我们特意定义了一些常用的函数。

* **upper** 

将字符串变大写

.. code-block:: shell

    ${linker_script} = "test"
    $(upper("${linker_script}CD")) => TESTCD

* **lower** 

将字符串变小写

.. code-block:: shell

    ${linker_script} = "test"
    $(lower("${linker_script}cd")) => testcd

* **contains** 

判断字符串中是否包含另一个字符串

.. code-block:: shell

    ${linker_script} = "test"
    $(contains(${linker_script}, nmsis) ) => false

* **join** 

将字符串连接数组

.. code-block:: shell

    $(join([a,b,c,v], '') => abcv

* **concat** 

连接字符串成为新一字符串

.. code-block:: shell

    ${linker_script} = "test"
    $(concat(${linker_script}, v) => testv


* **strip** 

去掉字符串两端空格

.. code-block:: shell

    ${linker_script} = "   test  "
    $(strip(${linker_script})) => test


* **startswith** 

判断字符串是否以xxx开头

.. code-block:: shell

    ${linker_script} = "testabcd"
    $(startswith(${linker_script}, test)) => true

* **endswith** 

判断字符串是否以xxx结尾

.. code-block:: shell

    ${linker_script} = "testabcd"
    $(endswith(${linker_script}, test))  => false

* **arithop** 

数学运算符,支持+、- 、* 、/、% 、?(三元运算)等常用运算符，不支持++、--

.. code-block:: shell

    $(arithop(${linker_script}+22) > 1000)
    $(arithop(${linker_script}+22))
    $(arithop(${linker_script}>22?1:0))

* **npack/npack_installdir** 

npack是否包含指定的npk

npack_installdir 包含的npk的路径

.. code-block:: shell

    # a.yml
        name: mwp-a
        owner: nuclei
        copyfiles:
            - path: ["common", "abc.ld", "src/openocd.cfg", "inc"]

    # b.yml

        name: mwp-b
        owner: nuclei
        copyfiles:
            - path: ["common", "111.ld", "src", "inc"]
        debugconfig:
          - type: openocd
            description: Nuclei OpenOCD
            configs:
              - key: config
                value: "$(npack_installdir(mwp-a))/src/openocd.cfg"
                condition: $( npack(nuclei:mwp-a) )

    # 这段描述，是当b.yml如果依赖a.yml时，就可以将config的值，设置为a.yml的目录下的/src/openocd.cfg

* **list_get** 

获取数组元素中指定脚标的值

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_get(${nuclei_cache},0)) -> ic

* **list_set** 

修改数组元素中指定脚标的值

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_set(${nuclei_cache},1,aa)) -> [ic,aa,ccm]

* **list_del** 

删除数组元素中指定脚标的值

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_del(${nuclei_cache},1)) -> [ic,ccm]


* **list_add** 

在数组元素指定脚标插入值

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_add(${nuclei_cache},2,aa)) -> [ic,dc,aa,ccm]

* **list_size** 

获取数组元素list的长度

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_size(${nuclei_cache})) -> 3

* **list_sub** 

从list中指定的位置开始，截取指定长度的list

.. code-block:: shell

    ${nuclei_cache}=[ic,dc,ccm]
    $(list_sub(${nuclei_cache},1,2)) -> [dc]
    $(list_sub(${nuclei_cache},0,2)) -> [ic,dc]
    $(list_sub(${nuclei_cache},1,)) -> [dc,ccm]
    $(list_sub(${nuclei_cache},,2)) -> [ic,dc]


* **subst** 

对字符串内部的指定字符串进行替换，第三个参数可为空

.. code-block:: shell

    subst(libncrt_small,lib,) ==> ncrt_small
    subst(libncrt_small,lib,ext) ==> extncrt_small


