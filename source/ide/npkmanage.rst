.. _npkmanage:

Nuclei Studio NPK Creation and Sharing
======================================

Nuclei Studio 2022.04 provides an important feature: using the initial templates provided, developers can easily create their own NPK component packages and contribute them through the platform for other developers to use.

.. _npkmanage_develop_package:

Develop an NPK Component Package
--------------------------------

.. _npkmanage_auth_developer:

Authenticate as a Developer
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before creating an NPK component package, you must first authenticate a developer account to obtain a unique owner ID. This owner ID corresponds to the owner described earlier and makes NPKs easier to manage.

First, log in to Nuclei System Technology's `RVMCU community website <https://www.rvmcu.com/user-login.html>`__. After logging in, go to the Nuclei Studio -> Contribute page, where you can see the authentication button.

|image1|

.. |image1| image:: /asserts/nucleistudio/developer/authenticate.png


Alternatively, visit the `authentication page <https://www.rvmcu.com/nucleistudio-developer.html>`__ directly and fill in the required information. The suffix of the developer space address corresponding to **Developer** is your owner ID.

|image2|

.. |image2| image:: /asserts/nucleistudio/developer/authenticate2.png

After filling in the required information, submit it. Once the system review is approved, the authentication is complete.

|image3|

.. |image3| image:: /asserts/nucleistudio/developer/authenticate3.png

.. _npkmanage_create_package:

Create an NPK Component Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After completing developer authentication, create a new Nuclei Studio component project by selecting ``File-> New-> Project-> C/C++-> New Nuclei NPK Project`` in the menu bar.

|image4|

.. |image4| image:: /asserts/nucleistudio/developer/image140.png


For first-time use, log in with a developer account. The login is valid for 7 days; after that, you must log in again. Login requires scanning a QR code with WeChat, as shown in the figure below. After a successful login, the owner drop-down box lists the bound developer accounts; fill in the remaining information. To switch accounts, click login again.

|image5|

.. |image5| image:: /asserts/nucleistudio/developer/image141.png


After the developer account is logged in, fill in the project name, project type, and other related information following the project wizard.

|image6|

.. |image6| image:: /asserts/nucleistudio/developer/image143.png


When you select a Type for which no corresponding template exists, a prompt appears. Click OK to open the Nuclei Package Management page and download the corresponding Template Package as needed, or click Import in the lower right corner of the figure below to import it yourself.

The following example uses the ssp type template. Suppose your company name is GreenTech, your SoC name is gt25nv, the adapted board is gt25nv_fpga_eval, it uses the N307FD processor (rv32imafdc) configuration with DSP features configured, and it provides three download modes: ilm, flash, and flashxip.

Select ssp for Type: ``SoC Support Package``

|image7|

.. |image7| image:: /asserts/nucleistudio/developer/image147.png

When you select a Type with no related template, you are taken to the Nuclei Package Management page. On this page, select version 1.1.0 of ``tpp-nuclei_sdk``, click ``Download``, and close the page after the download is complete.

|image8|

.. |image8| image:: /asserts/nucleistudio/developer/image148.png


Click Next, and select the ``tpp-nuclei_sdk`` template you just downloaded in ``Select a Template``. The left side shows the template description and a preview of the related files; the right side shows part of the customizable content in the template.

|image9|

.. |image9| image:: /asserts/nucleistudio/developer/image145.png


In this example, the company name is ``GreenTech``, the SoC name is ``gt25nv``, the adapted board is ``gt25nv_fpga_eval``, the configuration uses the N307FD processor (``rv32imafdc``) with DSP features configured, and it provides three download modes: ilm, flash, and flashxip. The result after modification is shown in the figure.

|image10|

.. |image10| image:: /asserts/nucleistudio/developer/image149.png

Click Finish to generate the NPK component package. You can then open the directory to view and modify the files and structure as needed, and import the NPK component package after the modification is complete.

Modify the project as needed, then import the NPK component package once the modification is complete.

|image11|

.. |image11| image:: /asserts/nucleistudio/developer/image146.png

When importing the SoC package created in the example, a prompt indicates that the dependency ``sdk-nuclei_sdk`` is missing. Click OK to open the ``Nuclei Package Management`` page, select ``sdk-nuclei_sdk``, and click ``Download``.

|image12|

.. |image12| image:: /asserts/nucleistudio/developer/image151.png


|image13|

.. |image13| image:: /asserts/nucleistudio/developer/image150.png

After the download is complete and the NPK component package project has been imported successfully, the result is shown in the figure below.

|image14|

.. |image14| image:: /asserts/nucleistudio/developer/image152.png

.. _npkmanage_test_package:

Checking and Troubleshooting NPK Component Packages
---------------------------------------------------

.. _npkmanage_install_test_project:

Checking a Newly Created Package Before Import
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before importing a completed package, you can use the checking tool to verify the validity of the NPK component package and avoid import failures. Its core functions focus on compliance checks of code style, variable naming, function structure, and dependency relationships to ensure code quality.

For details about this tool, see: `Package checking tool <https://github.com/Nuclei-Software/npk-checker>`__


.. _npkmanage_install_err_project:

Handling Package Import Failures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When a package fails to import, you can identify the problem from the relevant logs. This section covers issues such as NPK file format errors and unsatisfied dependencies.

Click View log in the lower right corner of the Package Management page to open a log page that briefly describes the reason for the import failure.

|image29|

.. |image29| image:: /asserts/nucleistudio/developer/image168.png


|image30|

.. |image30| image:: /asserts/nucleistudio/developer/image169.png


When a message such as "There are file parsing exceptions" appears in the log, check the log file of that day under the ``<user directory>\nuclei-pack-npk-v2\CFGs\logs\sys\`` path for details about the problems in the related NPK files, and make the corresponding corrections.

|image31|

.. |image31| image:: /asserts/nucleistudio/developer/image170.png

|image32|

.. |image32| image:: /asserts/nucleistudio/developer/image171.png

|image33|

.. |image33| image:: /asserts/nucleistudio/developer/image172.png


.. _npkmanage_create_test_project:

Create a Test Project
~~~~~~~~~~~~~~~~~~~~~

To create a project using the imported NPK component package project, select ``File-> New-> Project-> C/C++-> New Nuclei RISC-V C/C++ Project`` in the menu bar.

|image15|

.. |image15| image:: /asserts/nucleistudio/developer/image153.png

Click Next, and select the SoC and board contained in the package created above.

|image16|

.. |image16| image:: /asserts/nucleistudio/developer/image154.png

Click Next, fill in the Project Name, select ``Simple Helloworld Demo`` for Project Example, and click ``Finish`` to complete the creation of the test project.

|image17|

.. |image17| image:: /asserts/nucleistudio/developer/image155.png

.. _npkmanage_workwith_test_project:

Build and Debug the Test Project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The project created in the steps above is a test project based on the developer's NPK component package. The developer can code, debug, run, and perform other operations on it as with a normal project.

Click to select the N307FD project generated in the previous step and build it; the build succeeds. Subsequent steps such as running are omitted here. At this point, an NPK component package has been successfully created and imported for use.

|image18|

.. |image18| image:: /asserts/nucleistudio/developer/image156.png


.. _npkmanage_share_package:

Share an NPK Component Package
------------------------------

.. _npkmanage_share_npk:

Sharing an NPK Component Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After passing the tests, you can share the NPK component package you created. First, export your NPK component package project as a zip package as follows.

Open the NPK component package project, double-click the outermost ``npk.yml`` file, and confirm that its Name is ``ssp-nsdk_gt25nv``. Then right-click the NPK component package project, click ``Export``, select ``Archive File``, select the project to export, and specify where to save the exported zip file.

|image19|

.. |image19| image:: /asserts/nucleistudio/developer/image159.png


|image20|

.. |image20| image:: /asserts/nucleistudio/developer/image161.png


The exported zip package can be shared and contributed through the RVMCU community. Go to the `community sharing page <https://www.rvmcu.com/nucleistudio-developer.html>`__, fill in the name, type, description, and other information of the NPK component package to be shared, and upload the zip file you just exported. After the information is submitted and approved by the administrator, the NPK component package is successfully contributed. Other developers can then find your NPK component package on the ``Nuclei Package Management`` page of Nuclei Studio and download it for use. The procedure is shown in the figures below.

|image21|

.. |image21| image:: /asserts/nucleistudio/developer/image160.png


|image22|

.. |image22| image:: /asserts/nucleistudio/developer/3441.png


|image23|

.. |image23| image:: /asserts/nucleistudio/developer/image163.png



After the shared NPK component package is approved, open the ``Nuclei Package Management`` page in Nuclei Studio and click ``Refresh``. The component package you just shared appears in the list.

|image24|

.. |image24| image:: /asserts/nucleistudio/developer/image164.png


.. _npkmanage_update_npk:

Upgrade an NPK Component Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After an NPK component package is shared, if a new version needs to be maintained, you can upgrade the existing NPK component package once creation, testing, and packaging are complete. Go to the `Nuclei Studio <https://www.rvmcu.com/nucleistudio.html>`__ page, find the component package management entry, open the component package management page, click Upgrade Component Package, and upload the NPK component package following the previous steps. After the review is approved, the component package upgrade is complete.

|image25|

.. |image25| image:: /asserts/nucleistudio/developer/image165.png

|image26|

.. |image26| image:: /asserts/nucleistudio/developer/image166.png


|image27|

.. |image27| image:: /asserts/nucleistudio/developer/image167.png


.. _npkmanage_using_npk_in_ide:

Using NPK Component Packages in Nuclei Studio
---------------------------------------------

NPK component packages enrich the user experience in Nuclei Studio. With NPK component packages, you can define various project creation workflows and easily share mature projects or components with others.

All contributed NPK packages are managed in ``NPK Package Management`` of Nuclei Studio, where users can download, import, delete, and perform other operations on NPKs.

|image28|

.. |image28| image:: /asserts/nucleistudio/developer/168.jpg
