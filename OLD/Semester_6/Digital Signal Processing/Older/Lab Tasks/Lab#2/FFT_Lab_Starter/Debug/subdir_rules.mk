################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
DSK_vectors_AIC23.obj: ../DSK_vectors_AIC23.ASM $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.8/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.8/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="DSK_vectors_AIC23.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FFT_LAB_starter.obj: ../FFT_LAB_starter.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.8/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.8/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="FFT_LAB_starter.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

bitrev.obj: ../bitrev.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.8/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.8/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="bitrev.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

cfftr2_dit.obj: ../cfftr2_dit.sa $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.8/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.8/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="cfftr2_dit.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


