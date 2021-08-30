# Prepare

Check [Nuclei Docker Environment](https://wiki.corp.nucleisys.com/pages/viewpage.action?pageId=4461320) to learn
about how to use podman in wuhan software environment.


The podman image we use is `rego.corp.nucleisys.com/software/docbuilder:latest`.

Here are the steps to get this image:

~~~shell
# login using your account, and passwd using CLI secret
podman login rego.corp.nucleisys.com
# Pull image
podman pull rego.corp.nucleisys.com/software/docbuilder:latest
~~~

# Build Document

Here are the steps to build the documentation:

~~~shell
# in host pc, run this podman image
podman run -it -v /home/$(whoami):/home/$(whoami) rego.corp.nucleisys.com/software/docbuilder:latest
# in docker image now
cd /path/to/your/doc
pip3 install -r requirements.txt
npm i wavedrom-cli
# build html doc, html doc will be saved in build/html
make html
# build pdf doc, pdf doc will be saed in build/latex
make latexpdf
~~~