# ST Visual Debugger Generated MAKE File, based on exercise1_2.stp

ifeq ($(CFG), )
CFG=Debug
$(warning ***No configuration specified. Defaulting to $(CFG)***)
endif

ToolsetRoot=C:\PROGRA~2\STMICR~1\ST_TOO~1\asm
ToolsetBin=C:\Program Files (x86)\STMicroelectronics\st_toolset\asm
ToolsetInc=C:\Program Files (x86)\STMicroelectronics\st_toolset\asm\include
ToolsetLib=C:\Program Files (x86)\STMicroelectronics\st_toolset\asm
ToolsetIncOpts=-I="C:\Program Files (x86)\STMicroelectronics\st_toolset\asm\include" 
ToolsetLibOpts="C:\Program Files (x86)\STMicroelectronics\st_toolset\asm" 
ObjectExt=obj
OutputExt=s19 hex fin
InputName=$(basename $(notdir $<))


# 
# Debug
# 
ifeq "$(CFG)" "Debug"


OutputPath=Debug
ProjectSFile=exercise1_2
TargetSName=exercise1_2
TargetFName=exercise1_2.s19
IntermPath=$(dir $@)
ASMFLAGS_PRJ=$(ToolsetBin)\asm  -sym -li=$(IntermPath)$(InputName).lsr $< $(ToolsetIncOpts) -obj=$(IntermPath)$(InputName).$(ObjectExt) -I=..
ObjectFiles=$(OutputPath)\mapping.obj+$(OutputPath)\main_1_2.obj+$(OutputPath)\stm8s105c6.obj

all : $(OutputPath) exercise1_2.s19

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Debug\mapping.$(ObjectExt) : mapping.asm mapping.inc 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

Debug\main_1_2.$(ObjectExt) : main_1_2.asm mapping.inc ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\ST73EC~1.INC ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\STF246~1.INC 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

Debug\stm8s105c6.$(ObjectExt) : ..\stm8s105c6.asm ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\STCFC8~1.ASM 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

exercise1_2.s19 : $(OutputPath)\mapping.obj $(OutputPath)\main_1_2.obj $(OutputPath)\stm8s105c6.obj
	$(ToolsetBin)\lyn  $(ObjectFiles), $(OutputPath)\$(TargetSName).cod, " " 
	$(ToolsetBin)\obsend  $(OutputPath)\$(TargetSName).cod,f,$(OutputPath)\$(TargetSName).s19,s
	$(ToolsetBin)\abslist  $(OutputPath)\mapping.lsr -exe $(OutputPath)\exercise1_2.s19
	$(ToolsetBin)\abslist  $(OutputPath)\main_1_2.lsr -exe $(OutputPath)\exercise1_2.s19
	$(ToolsetBin)\abslist  $(OutputPath)\stm8s105c6.lsr -exe $(OutputPath)\exercise1_2.s19

clean : 
	-@erase $(OutputPath)\mapping.obj
	-@erase $(OutputPath)\main_1_2.obj
	-@erase $(OutputPath)\stm8s105c6.obj
	-@erase $(OutputPath)\exercise1_2.s19
	-@erase $(OutputPath)\exercise1_2.map
	-@erase $(OutputPath)\exercise1_2.cod
	-@erase $(OutputPath)\exercise1_2.grp
	-@erase $(OutputPath)\exercise1_2.sym
	-@erase mapping.lst
	-@erase main_1_2.lst
	-@erase stm8s105c6.lst
endif

# 
# Release
# 
ifeq "$(CFG)" "Release"


OutputPath=Release
ProjectSFile=exercise1_2
TargetSName=exercise1_2
TargetFName=exercise1_2.s19
IntermPath=$(dir $@)
ASMFLAGS_PRJ=$(ToolsetBin)\asm  -sym -li=$(IntermPath)$(InputName).lsr $< $(ToolsetIncOpts) -obj=$(IntermPath)$(InputName).$(ObjectExt) -I=..
ObjectFiles=$(OutputPath)\mapping.obj+$(OutputPath)\main_1_2.obj+$(OutputPath)\stm8s105c6.obj

all : $(OutputPath) exercise1_2.s19

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Release\mapping.$(ObjectExt) : mapping.asm mapping.inc 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

Release\main_1_2.$(ObjectExt) : main_1_2.asm mapping.inc ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\ST73EC~1.INC ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\STF246~1.INC 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

Release\stm8s105c6.$(ObjectExt) : ..\stm8s105c6.asm ..\..\..\..\..\..\..\..\PROGRA~2\STMICR~1\ST_TOO~1\asm\include\STCFC8~1.ASM 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ASMFLAGS_PRJ)

exercise1_2.s19 : $(OutputPath)\mapping.obj $(OutputPath)\main_1_2.obj $(OutputPath)\stm8s105c6.obj
	$(ToolsetBin)\lyn  $(ObjectFiles), $(OutputPath)\$(TargetSName).cod, " " 
	$(ToolsetBin)\obsend  $(OutputPath)\$(TargetSName).cod,f,$(OutputPath)\$(TargetSName).s19,s
	$(ToolsetBin)\abslist  $(OutputPath)\mapping.lsr -exe $(OutputPath)\exercise1_2.s19
	$(ToolsetBin)\abslist  $(OutputPath)\main_1_2.lsr -exe $(OutputPath)\exercise1_2.s19
	$(ToolsetBin)\abslist  $(OutputPath)\stm8s105c6.lsr -exe $(OutputPath)\exercise1_2.s19

clean : 
	-@erase $(OutputPath)\mapping.obj
	-@erase $(OutputPath)\main_1_2.obj
	-@erase $(OutputPath)\stm8s105c6.obj
	-@erase $(OutputPath)\exercise1_2.s19
	-@erase $(OutputPath)\exercise1_2.map
	-@erase $(OutputPath)\exercise1_2.cod
	-@erase $(OutputPath)\exercise1_2.grp
	-@erase $(OutputPath)\exercise1_2.sym
	-@erase mapping.lst
	-@erase main_1_2.lst
	-@erase stm8s105c6.lst
endif
