#!/bin/bash

function seprator(){
        for((i=0;i<80;i++))
        do
                echo -n "*"
        done
        echo ""
}
clear
# introduction
seprator
echo " Auto-test Stress"
echo " written by Mahya MKashani"
echo " Copyright 2014. Mahya Mkashani"
echo " E-Mail : mahya.mkashani@gmail.com"

seprator


echo "First, please check Stress tool is installed or not!(your user should be root.) "

seprator

sleep 5

#installing test
i=0;
while [ $i -eq 0 ]
do
    if [ $(dpkg-query -W -f='${Status}' stress 2>/dev/null | grep -c "ok installed") -eq 1   ]
    then
       echo "Stress test is installed"
       i=1
    else
       echo "Sorry! Stress test is'nt installed, please try again."

read -r -p "Would you Install stress ?(Y/N) " response  
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    apt-get install stress
    echo "StressTest tool is installed" 
    i=1


    elif [[ $response =~ ^([nN][oO]|[nN])$ ]]
    then
    echo " you cant work with stress test because of non installization,the program is stopped"
    i=1
    exit
    
else   
      echo "you must type y/n or yes/no to continue process:"
            
      
fi
# end if for response question

   fi
# end if for install stress package
done

 if [ $(dpkg-query -W -f='${Status}' stress 2>/dev/null | grep -c "ok installed") -eq 0   ]
then
echo "sorry, Stress Test is not installed on your system. So test will be stopped!"
exit
fi
# end if for ensure about install Stress package
seprator


while true
do
# explanations of test


i=0;
echo " If this is your first time test that test your system with StressTest, please read description."
while [ $i -eq 0 ]
do

read -r -p "Would you like to know more about stress test ?(Y/N) " describe 
  
if [[ $describe =~ ^([yY][eE][sS]|[yY])$ ]]
then


echo "Stress Test has different options :"

echo "Stress Test has 4 branches: cpu test,memory test,io test,hard disk test : "
echo "1- cpu test : is spawn N workers spinning on sqrt() function,you should determine timeout after N seconds(or minute,hour,days or even years)" 
echo "range of cpu test with this config : cpu' core i7 3.4Ghz' is 5000 processes, although systems are different each other "
echo "2- memory test : has options to ensure  memory is healthy ,you should determine that  how many processes you need and for each process how many size of memory you need? "
echo "memory :test of memory has 3 section,you could choose each one for testing "
echo "2-1 memory : first test memory is to ensure about healthy by mallocate and free byte of memory nonstop"
echo "2-2 Stride memory : second test is touching byte of memory when mallocate memory then free it."
echo "2-3 hang memory : third test is mallocate byte of memory and  mallocated volume's is freed after N seconds "
echo "3- io test :is Spawn N workers that you chooose it, sppinnig on sync() function."
echo "4- hard disk test: for this test you should determine that how many process you need and for each process how many sizes of hard you need?  "

echo "Notice : if you dont know about config of your system please check it and you should check your temprature of cores of cpu and how many sizes of cpu/memory volumes is remained , if you need check temprature of cpu  please type 'sensor' and if you need check config of system type 'lshw' and 'cpuinfo' if you need check temrature of hard  please type 'hddtemp' if you need how many cpu/memory's volumes is remained type 'htop'   "
echo "Note: Numbers may be suffixed with s,m,h,d,y (time) or B,K,M,G (size)"
i=1

 elif [[ $describe =~ ^([nN][oO]|[nN])$ ]]
    then
    echo " you couldnt see description about the test"
    i=1
    
    
else   
      echo "you should type y/n or yes/no please type this words!"
               
fi



done    
seprator


# start test

i=0;
while [ $i -eq 0 ]
do
read -r -p "Would you like to start the test ?(Y/N) " starttest 
  
if [[ $starttest =~ ^([yY][eE][sS]|[yY])$ ]]
then

clear

while true
do
 clear
    echo "please choose one of the tests "
    echo "if test cpu write 'c' "
    echo "if test memory write 'm' "
    echo "if test io write 'i' "
    echo "if test hard disk write 'h' "
    echo "if exit from test 'e' "
    read -p "please choose one of the tests?(c,m,i,h,e) " cmih
    case $cmih in

#cpu test

        [Cc] ) read -p "how many processes would you  need ?" workers 
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --cpu $workers --timeout $stoptimming --verbose >verbosingcpu


                        if [ $(grep -c "successful" verbosingcpu) -eq 1 ] && [ $(grep -c "FAIL" verbosingcpu) -eq 0 ]

                         then 
                         stress --cpu $workers --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                        stress --cpu $workers --timeout $stoptimming --verbose
 
                         seprator
                          echo "****************(test  failed)****************"
                          echo "you can see log from this test in file of verbosingcpu  "
                           if [ $(grep -c "FAIL" verbosingcpu) -ge 1 ]
                           then 
                           echo "test of cpu is failed while debugging"
                           else 
                           echo "test of cpu is failed while running"   
                          fi 

                        sleep 10
                        fi

              else 
                 stress --cpu $workers --timeout $stoptimming --verbose >verbosingcpu


                        if [ $(grep -c "successful" verbosingcpu) -eq 1 ] && [ $(grep -c "FAIL" verbosingcpu) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10
                      
                         else 
                         seprator
                          echo "****************(test  failed)****************"
                          echo "you can see log from this test in file of verbosingcpu  "
                        
                           if [ $(grep -c "FAIL" verbosingcpu) -ge 1 ]
                           then 
                           echo "test of cpu is failed while debugging"
                           else 
                           echo "test of cpu is failed while running"   
                          fi 
                        sleep 10
                        fi
                 
                  

               fi;; 
# memory test
        [Mm] )  
 

              while true 
              do                   
                      clear
                       echo "please choose one of the  memory test "
                       echo "if memory test is about allocate and free volume without stop write 'v' "
                       echo "if memory test is about allocate volume by touching memory then free it, write 's' "
                       echo " if memory test is about allocate memory  after N secondes then free it(hang memory after N seconds), write 'h'"
                       echo "if exit from memory test 'x' "
                       read -p "please choose one of the tests?(v,s,h,x) " vshx
                        case $vshx in
#test of memory nonstop mallocate and free memory 

          [Vv])   
                    clear
                read -p "how many processes would you  need ?" workers 
                read -p "how much size would you need to allocate from memory ?(write digit number with sufix size(B,K,M,G),'example:10G'" sizemem
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --vm $workers --vm-bytes $sizemem --timeout $stoptimming --verbose >verbosingmem


                        if [ $(grep -c "successful" verbosingmem) -eq 1 ] && [ $(grep -c "FAIL" verbosingmem) -eq 0 ]

                         then 
                        stress --vm $workers --vm-bytes $sizemem --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                         stress --vm $workers --vm-bytes $sizemem --timeout $stoptimming --verbose
                         seprator
                          echo "****************(test  failed)****************"
                             echo "you can see log from this test in file of verbosingmem  "
                           if [ $(grep -c "FAIL" verbosingmem) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi

              else 
               stress --vm $workers --vm-bytes $sizemem --timeout $stoptimming --verbose >verbosingmem


                        if [ $(grep -c "successful" verbosingmem) -eq 1 ] && [ $(grep -c "FAIL" verbosingmem) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10
                      
                         else 
                         seprator
                          echo "****************(test  failed)****************"
                          echo "you can see log from this test in file of verbosingmem  "
                           if [ $(grep -c "FAIL" verbosingmem) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi
                 
                  

               fi;;

#test memory by touching bytes of memory allocate it then free 
           [Ss]) 
                clear
                      read -p "how many processes would you  need ?" workers 
                read -p "how much size would you need to allocate from memory for stride memory test ?(write digit number with sufix size(B,K,M,G),'example:10G'" sizemem
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --vm $workers --vm-stride $sizemem --timeout $stoptimming --verbose >verbosingmemstride


                        if [ $(grep -c "successful" verbosingmemstride) -eq 1 ] && [ $(grep -c "FAIL" verbosingmemstride) -eq 0 ]

                         then 
                        stress --vm $workers --vm-stride $sizemem --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                         stress --vm $workers --vm-stride $sizemem --timeout $stoptimming --verbose
                         seprator
                          echo "****************(test  failed)****************"

                          echo "you can see log from this test in file of verbosingmemstride  "
                           if [ $(grep -c "FAIL" verbosingmemstride) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi

              else 
               stress --vm $workers --vm-stride $sizemem --timeout $stoptimming --verbose >verbosingmemstride


                        if [ $(grep -c "successful" verbosingmemstride) -eq 1 ] && [ $(grep -c "FAIL" verbosingmemstride) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10
                      
                         else 
                         seprator
                          echo "****************(test  failed)****************"
                        echo "you can see log from this test in file of verbosingmemstride  "
                           if [ $(grep -c "FAIL" verbosingmemstride) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 

                        sleep 10
                        fi
                 
                  

               fi;;
# test of memory by allocated bytes of memory hang memory this sistuation after N secondes is freed allocated memory          
 

          [Hh])       
               clear
                read -p "how many processes would you  need ?" workers 
                read -p "how much size would you need to allocate from  memory ?(write digit number with sufix size(B,K,M,G),'example:10G'" sizemem
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                
                read -p  "how much time do you like to hang memory for allocatting and cant free it(your time should be a digit number (10)?" stoptimehang
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --vm $workers --vm-bytes $sizemem --vm-hang $stoptimehang --timeout $stoptimming --verbose >verbosingmemhang


                        if [ $(grep -c "successful" verbosingmemhang) -eq 1 ] && [ $(grep -c "FAIL" verbosingmemhang) -eq 0 ]

                         then 
                       stress --vm $workers --vm-bytes $sizemem --vm-hang $stoptimehang --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                        stress --vm $workers --vm-bytes $sizemem --vm-hang $stoptimehang --timeout $stoptimming --verbose
                         seprator
                          echo "****************(test  failed)****************"
                       echo "you can see log from this test in file of verbosingmemhang  "
                           if [ $(grep -c "FAIL" verbosingmemhang) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 

                         sleep 10
                        fi

              else 
               stress --vm $workers --vm-bytes $sizemem --vm-hang $stoptimehang --timeout $stoptimming --verbose >verbosingmemhang


                        if [ $(grep -c "successful" verbosingmemhang) -eq 1 ] && [ $(grep -c "FAIL" verbosingmemhang) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10
                      
                         else 
                         seprator
                          echo "****************(test  failed)****************"

                        echo "you can see log from this test in file of verbosingmemhang  "
                           if [ $(grep -c "FAIL" verbosingmemhang) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi
                 
                  

               fi;;
# break from test of memory    

       [Xx])   break;;
           
         *)  echo "you should type v,s,h or x character"
             sleep 5  ;;
          
                 esac
          done;;

# io test

        [Ii] )
                read -p "how many processes would you  need ?" workers 
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --io $workers --timeout $stoptimming --verbose >verbosingio


                        if [ $(grep -c "successful" verbosingio) -eq 1 ] && [ $(grep -c "FAIL" verbosingio) -eq 0 ]

                         then 
                         stress --io $workers --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                        stress --io $workers --timeout $stoptimming --verbose
 
                         seprator
                          echo "****************(test  failed)****************"
                          echo "you can see log from this test in file of verbosingio  "
                           if [ $(grep -c "FAIL" verbosingio) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi

              else 
                 stress --io $workers --timeout $stoptimming --verbose >verbosingio


                        if [ $(grep -c "successful" verbosingio) -eq 1 ] && [ $(grep -c "FAIL" verbosingio) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                   
                         sleep 10
                       else 
                         seprator
                          echo "****************(test  failed)****************"
                          echo "you can see log from this test in file of verbosingio  "
                           if [ $(grep -c "FAIL" verbosingio) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                       sleep 10                   
                       fi 
            fi;;

#hard disk test

       [Hh] )  
                read -p "how many processes would you  need ?" workers 
                read -p "how much size would you need to allocate from hard disk ?(write digit number with sufix size(B,K,M,G),'example:10G'" sizehdd
                read -p  "how much time do you like to stop the test(your time should be a digit number with suffix time (10s)?" stoptimming 
                read -p "would you like to explain more about the test?(Y/N)" description

                if [[ $description =~ ^([yY][eE][sS]|[yY])$ ]]
                then
                 stress --hdd $workers --hdd-bytes $sizehdd --timeout $stoptimming --verbose >verbosinghard


                        if [ $(grep -c "successful" verbosinghard) -eq 1 ] && [ $(grep -c "FAIL" verbosinghard) -eq 0 ]

                         then 
                          stress --hdd $workers --hdd-bytes $sizehdd --timeout $stoptimming --verbose
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10

                         else
                         stress --hdd $workers --hdd-bytes $sizehdd --timeout $stoptimming --verbose
                         seprator
                          echo "****************(test  failed)****************"
                         echo "you can see log from this test in file of verbosinghard  "
                           if [ $(grep -c "FAIL" verbosinghard) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi

              else 
                stress --hdd $workers --hdd-bytes $sizehdd --timeout $stoptimming --verbose >verbosinghard


                        if [ $(grep -c "successful" verbosinghard) -eq 1 ] && [ $(grep -c "FAIL" verbosinghard) -eq 0 ]

                         then 
                         seprator
                         echo "****************(test  passed)*****************"
                         sleep 10
                      
                         else 
                         seprator
                          echo "****************(test  failed)****************"
                           echo "you can see log from this test in file of verbosinghard  "
                           if [ $(grep -c "FAIL" verbosinghard) -ge 1 ]
                           then 
                           echo "test of memory is failed while debugging"
                           else 
                           echo "test of memory is failed while running"   
                          fi 
                        sleep 10
                        fi
                 
                  

               fi;;        
      [Ee] )      break;; 
  

      *)  echo "you should type c,m,i,h or e character"
          sleep 5   ;;

       esac
done
i=1;
elif [[ $starttest =~ ^([nN][oO]|[nN])$ ]]
then 
echo "you should stop the test!"
sleep 2
i=1;
else 
echo "you should type yes/no or y/n! "
 

fi
done
#end
clear
b=0;
while [ $b -eq 0 ]
do
read -r -p "Would you like to stop the test ?(Y/N) " stoptest   
if [[ $stoptest =~ ^([yY][eE][sS]|[yY])$ ]]
then
clear
b=1;
exit

elif [[ $stoptest =~ ^([nN][oO]|[nN])$ ]]
then
seprator 
b=1;
else 
echo "you should type y/n or yes or no type."
seprator

fi
done

done
