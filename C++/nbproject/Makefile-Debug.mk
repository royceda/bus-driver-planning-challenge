#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=Cygwin_4.x-Windows
CND_DLIB_EXT=dll
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/Parser.o \
	${OBJECTDIR}/Solver.o \
	${OBJECTDIR}/main.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L../../../../Desktop/M2/lib/Linux/lib_/cplex/lib/x86_sles10_4.1/static_pic -L../../../../Desktop/M2/lib/Linux/lib_/concert/lib/x86_sles10_4.1/static_pic ../../../../Desktop/M2/lib/Linux/lib_/cplex/lib/x86_sles10_4.1/static_pic/libilocplex.a -lpthread ../../../../Desktop/M2/lib/Linux/lib_/cplex/lib/x86_sles10_4.1/static_pic/libcplex.a ../../../../Desktop/M2/lib/Linux/lib_/concert/lib/x86_sles10_4.1/static_pic/libconcert.a

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe: ../../../../Desktop/M2/lib/Linux/lib_/cplex/lib/x86_sles10_4.1/static_pic/libilocplex.a

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe: ../../../../Desktop/M2/lib/Linux/lib_/cplex/lib/x86_sles10_4.1/static_pic/libcplex.a

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe: ../../../../Desktop/M2/lib/Linux/lib_/concert/lib/x86_sles10_4.1/static_pic/libconcert.a

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/Parser.o: Parser.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -DIL_STD -I../../../../Desktop/M2/lib/Linux/lib_/cplex/include -I../../../../Desktop/M2/lib/Linux/lib_/concert/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Parser.o Parser.cpp

${OBJECTDIR}/Solver.o: Solver.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -DIL_STD -I../../../../Desktop/M2/lib/Linux/lib_/cplex/include -I../../../../Desktop/M2/lib/Linux/lib_/concert/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Solver.o Solver.cpp

${OBJECTDIR}/main.o: main.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -DIL_STD -I../../../../Desktop/M2/lib/Linux/lib_/cplex/include -I../../../../Desktop/M2/lib/Linux/lib_/concert/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main.o main.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/cpp.exe

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
