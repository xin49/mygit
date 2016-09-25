################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
/home/ning/codes/mygit/cpp/change/IniFile/test/File.cpp \
/home/ning/codes/mygit/cpp/change/IniFile/test/IPAddress.cpp \
/home/ning/codes/mygit/cpp/change/IniFile/test/IniFile.cpp \
/home/ning/codes/mygit/cpp/change/IniFile/test/IniFileHelper.cpp \
../main.cpp 

OBJS += \
./File.o \
./IPAddress.o \
./IniFile.o \
./IniFileHelper.o \
./main.o 

CPP_DEPS += \
./File.d \
./IPAddress.d \
./IniFile.d \
./IniFileHelper.d \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
File.o: /home/ning/codes/mygit/cpp/change/IniFile/test/File.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/home/ning/codes/mygit/cpp/change/IniFile/test -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

IPAddress.o: /home/ning/codes/mygit/cpp/change/IniFile/test/IPAddress.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/home/ning/codes/mygit/cpp/change/IniFile/test -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

IniFile.o: /home/ning/codes/mygit/cpp/change/IniFile/test/IniFile.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/home/ning/codes/mygit/cpp/change/IniFile/test -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

IniFileHelper.o: /home/ning/codes/mygit/cpp/change/IniFile/test/IniFileHelper.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/home/ning/codes/mygit/cpp/change/IniFile/test -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/home/ning/codes/mygit/cpp/change/IniFile/test -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


