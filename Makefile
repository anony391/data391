#define a makefile variable for the java compiler
JCC = javac

default: GetOnePic.class GetBigPic.class CreateNewRadiology.class connmaker.class sqlcontroller.class

GetOnePic.class: ./WEB-INF/classes/GetOnePic.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/GetOnePic.java

GetBigPic.class: ./WEB-INF/classes/GetBigPic.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/GetBigPic.java	

CreateNewRadiology.class: ./WEB-INF/classes/CreateNewRadiology.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/CreateNewRadiology.java

connmaker.class: ./WEB-INF/classes/connectionmaker/connmaker.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/connectionmaker/connmaker.java

sqlcontroller.class: ./WEB-INF/classes/sqlcontrol/sqlcontroller.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/sqlcontrol/sqlcontroller.java

clean:
	rm ./WEB-INF/classes/*.class
	rm ./WEB-INF/classes/sqlcontrol/*.class
	rm ./WEB-INF/classes/connectionmaker/*.class
