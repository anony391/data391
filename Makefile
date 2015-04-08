#define a makefile variable for the java compiler
JCC = javac

default: Logout.class GetOnePic.class GetBigPic.class GetFullPic.class CreateNewRadiology.class UpdateRadiology.class connmaker.class sqlcontroller.class

GetOnePic.class: ./WEB-INF/classes/GetOnePic.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/GetOnePic.java

Logout.class: ./WEB-INF/classes/Logout.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/Logout.java


GetBigPic.class: ./WEB-INF/classes/GetBigPic.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/GetBigPic.java	

GetFullPic.class: ./WEB-INF/classes/GetFullPic.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/GetFullPic.java	

CreateNewRadiology.class: ./WEB-INF/classes/CreateNewRadiology.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/CreateNewRadiology.java

UpdateRadiology.class: ./WEB-INF/classes/UpdateRadiology.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/UpdateRadiology.java



connmaker.class: ./WEB-INF/classes/connectionmaker/connmaker.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/connectionmaker/connmaker.java

sqlcontroller.class: ./WEB-INF/classes/sqlcontrol/sqlcontroller.java
	$(JCC) -cp ":/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/javax.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/commons-fileupload-1.0.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/ojdbc6.jar:/cshome/rdejesus/catalina/webapps/data391/WEB-INF/lib/cos.jar" ./WEB-INF/classes/sqlcontrol/sqlcontroller.java

clean:
	rm ./WEB-INF/classes/*.class
	rm ./WEB-INF/classes/sqlcontrol/*.class
	rm ./WEB-INF/classes/connectionmaker/*.class
