#Intro to Objects and OO Design

Here are a few things you know about objects, and object design (as called out / described in class).  What do these things mean? What else do you know?  Look at the three examples and see if you can rebuild them with your own object space (ie cars, au, rock concerts, smurfs)

## Single Object
* everything is an object
* one super object - class Object
* class is the blueprint from which objects are instantiated
* all objects inherit from Object
* classes : initialize, attrs , self, method scope, gloable scope, instance scope, class scope, block scope

## Object Inheritance
*  SubClass < SuperClass (or ParentClass)
*  DRY up code
*  Inherit behavior and state
*  contains unique behavior and/or state : by adding additional or overwritting
*  single inheritance
*  super - calls the overwritten method in the parent
*  "is-a" relationship

## Object Composition
* object is made up of other objects - object is defined inside another object
* "has-a " relationship
* create composition by:
  * dependency injection - passing a class object into the initialize of the composed class
  * instantiation - define the class outside the composed class but instatiate insside the initialize (or other method) of the composed class
  * define and instatiate the class inside the composed class (if no access is every needed outside this class)

## Module
* Enumerable is a module
* container for behavior
* include or extends
* can use to namespace by defining other classes and modules inside a module

