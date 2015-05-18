#!/bin/bash
##
## cPanel Bash API Helper
## David Levey 
##
## https://github.com/palmerlevey/cPanel-Bash-API-Helper
##
version='0.0.1 alpha'

apiargs=''
apip='json'
apiv='2'
curl=$(which curl)
curlargs='-ks'
debug='on'
destination=''
api_function=''
pass=''
port='2087'
protocol='https'
user='root'

function pass(){
	echo -e "\033[32m \xE2\x9C\x93 \033[00m\c"
}

function fail(){
	echo -e "\033[31m \xE2\x9C\x98 \033[00m\c"
}

function showUsage(){
	echo "cPanel Bash API Helper by David Levey - $version";
	echo "#################################################";
	echo "cpapihelper [ args ]";
	echo "";
	echo "	-ap --api-protocl";
	echo "		== The cPanel API Protocol [ xml / json ]";
	echo "		   Default: json";
	echo "";								
	echo "	-av --api-version";
	echo "		== The cPanel API Version [ 1 / 2 ]";
	echo "		   Default: 2";	
	echo "";								
	echo "	-ca --curl-args";
	echo "		== Options arguments for cURL. (man curl)";
	echo "		   Default: -ks";	
	echo "";								
	echo "	-d --destination";
	echo "		== IP address or hostname of destination server.";
	echo "		   *Required";	
	echo "		   (eg. -d 127.0.0.1)";
	echo "";								
	echo "	--debug";
	echo "		== Enables verbose output for debugging purposes.";
	echo "		   Default: on (during alpha)";		
	echo "";									
	echo "	-f --function";
	echo "		== The cPanel API function you are calling.";
	echo "		   *Required";		
	echo "";									
	echo "	-fa --function-args";
	echo "		== The arguments for the cPanel API function.";
	echo "		   *Required";		
	echo "";									
	echo "	-i --insecure";
	echo "		== Uses http and 2086 rather than secure protocols.";
	echo "		   Default: off";		
	echo "";									
	echo "	-p --pass";
	echo "		== The password for the root user (default) or declared -u user.";
	echo "		   *Required";		
	echo "";			
	echo "	-u --user";
	echo "		== If logging in as reseller or cPanel user.";
	echo "		   Default: root";		
	echo "";																
	echo "	-h --help";
	echo "		== Prints this help output.";
	echo "";							
}

while [[ $# > 1 ]]
do
var="$1"

case $var in
	-ap|--api-protocol)
		apip="$2"
		shift
	;;
	-av|--api-version)
		apiv="$2"
		shift
	;;
	-ca|--curl-args)
		curlargs="$2"
		shift
	;;
	-d|--destination)
		destination="$2"
		shift
	;;
	--debug)
		debug="on"
		shift
	;;
	-f|--function)
		api_function="$2"
		shift
	;;
	-fa|--function-args)
		apiargs="$2"
		shift
	;;	
	-i|--insecure)
		protcol='http'
		port='2086'
		shift
	;;
	-p|--pass)
		pass="$2"
		shift
	;;	
	-u|--user)
		user="$2"
		shift
	;;
	-h|--help)
		showUsage;
	;;							
	*)
		echo "Error. Something's not right.";
		echo "-h or --help for usage.";
	;;
esac
shift
done

if [[ "$debug" ==  "on" ]]; then
	echo "cPanel Shell API Helper by David Levey - $version";
	echo "#################################################";
	echo "Debug Verbose Output: ";
	echo "";
	echo "cURL Binary Path	     : ${curl}";
	echo "";
	echo "Destination		  	 : ${destination}";
	echo "Access Protocol/Port   : ${protocol}/${port}"
	echo "Login User			 : ${user}";
	echo "Login Password		 : ${pass}";
	echo "";
	echo "cPanel API Args		 : ${apiargs}";
	echo "cPanel API Protocol	 : ${apip}";
	echo "cPanel API Version	 : ${apiv}";
	echo "cPanel API Function	 : ${api_function}";
	echo "cPanel API Args		 : ${apiargs}";						
	echo "";
	echo "Syntax being executed:";
	echo "${curl} ${curlargs} -u \"${user}:${pass}\" \"${protocol}://${destination}:${port}/${apip}-api/${api_function}?api.version=${apiv}\""
	echo "";
	echo "Checking syntax for errors..."
		if [[ -z "${destination}" ]]; then 
			fail; echo "No cPanel host/ip destination defined.";
		elif [[ -z "${apiargs}" ]]; then 
			fail; echo "cPanel API arguements are NOT defined.";
		elif [[ -z "${api_function}" ]]; then 
			fail; echo "cPanel API function is NOT defined.";
		elif [[ -z "${pass}" ]]; then 
			fail; echo "API auth password is NOT defined.";
		else 
			pass; echo "Syntax SHOULD work. Remember, this is still in development."
		fi				
fi
