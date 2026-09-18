###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = 8086
COMPILER = "MASM32"
TARGET = Release
SHELL = C:\Windows\system32\cmd.exe

## Tools general options
ASMFLAGS=/c /Zd /Zi
LDFLAGS=/CODEVIEW

## Processing Tools
ASM=ml.exe
LD=link16.exe
#  C:/Users/27147/Desktop/微机原理三级项目/8086/Release/Release.exe: TOOL=LD
#     C:/Users/27147/Desktop/微机原理三级项目/8086/Release/main.obj: TOOL=ASM
#        C:/Users/27147/Desktop/微机原理三级项目/8086/main.asm

# Build tree:
all:	Release

Release:	Release.exe

Release.exe:	main.obj 
	$(LD) $(LDFLAGS) main.obj,Release.exe,nul.map,,,

main.obj:	../main.asm 
	$(ASM) $(ASMFLAGS) ../main.asm

# tidy - delete all temporary files which are not involved in the target generation
tidy:

# cleanup - delete all generated files
clean:	tidy
	rm -rf Release.exe
	rm -rf main.obj
