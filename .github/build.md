# 快速编译指南

## RST语言指南

- [Sphinx reStructuredText Primer](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html)
- [RST语法](https://3vshej.cn/rstSyntax/)

## 文档编译编译开发

请在你自己的目录下clone代码，修改完文档查看效果请执行如下命令来进行文档的编译。

> 如果你是docker环境，请把 `podman` 换成 `docker` 即可

> 如果你在芯来内网，请把 `docker.io/nucleisoftware` 替换成 `rego.corp.nucleisys.com/software`

~~~shell
# 当前已处于文档所在根目录下
podman run -it -v $(pwd):/nuclei/workspace docker.io/nucleisoftware/docbuilder:latest
# 进入到docker 环境下
# 清理之前的编译
make clean
# 编译网页文档
make all
# 编译pdf文档
make pdf
~~~

**如果需要预览文档效果，请新开一个shell环境，并运行如下命令**

~~~shell
# 环境设置 以下命令需要在芯来内部环境
source /home/share/devtools/env.sh
# 这个依赖的工具 httpserver_cli 位于 Nuclei SDK tools/scripts/nsdk_cli 中
# 预览网页，在本地浏览器中打开预览的网址
make preview
~~~


## 发送Pull Request

文档开发请创建自己的开发分支例如, `feature/update_idedoc`, 如果开发完毕，就往master分支发送pull request，请求review，review完毕，CI PASS以后
就可以合入了。

**参见如下文章**

- https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request
- https://github.com/Nuclei-Software/nuclei-tool-guide/pull/7

# Prepare

The podman image we use is `docker.io/nucleisoftware/docbuilder:latest`.

Here are the steps to get this image:

~~~shell
# Pull image
podman pull docker.io/nucleisoftware/docbuilder/docbuilder:latest
~~~

# Build Document

Here are the steps to build the documentation:

~~~shell
# in host pc, run this podman image
podman run -it -v $(pwd):/nuclei/workspace docker.io/nucleisoftware/docbuilder:latest
# in docker image now
# build html doc, html doc will be saved in build/html
make html
# build pdf doc, pdf doc will be saed in build/latex and copy to build/html/
make pdf
~~~
