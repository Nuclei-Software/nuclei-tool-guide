Testing PlantUML Support
========================

Class diagram
--------------

.. uml::
   :caption: A caption with **bold** text

   Foo <|-- Bar

Sequence diagram
------------------

.. uml::

   Alice -> Bob: Hello!
   Alice <- Bob: Hi!

Sequence diagram in Japanese, read from external file:

.. uml:: /asserts/uml/seq.uml

scale: 50%:

.. uml::
   :scale: 50 %

   Foo <|-- Bar

width: 20%:

.. uml::
   :width: 20 %

   Foo <|-- Bar

height: 400px:

.. uml::
   :height: 400px

   Foo <|-- Bar

width: 100px * 100%:

.. uml::
   :scale: 100 %
   :width: 100px

   Foo <|-- Bar

200x600px:

.. uml::
   :width:  200px
   :height: 600px

   Foo <|-- Bar

UML Cases
---------------

.. uml::
   :caption: Caption with **bold** and *italic*
   :width: 20mm
   :align: center

   Foo <|-- Bar

.. uml::
   :scale: 100 %
   :align: center

   Foo <|-- Bar

.. uml::
   :align: center

   Alice -> Bob: Hi!
   Alice <- Bob: How are you?

.. uml::
   :caption: Binary and Clock
   :align: center

   clock clk with period 1
   binary "Enable" as EN

   @0
   EN is low

   @5
   EN is high

   @10
   EN is low