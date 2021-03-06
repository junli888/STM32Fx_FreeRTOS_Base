#STM32 USB Library makefile
#
#Jeff Ciesielski <jeff.ciesielski@gmail.com>

ifneq ($(STM32_USB_LIBS),)

valid_c_files = $(sort $(filter-out $(wildcard $(1)/*template.c), $(wildcard $(1)/*.c)))

ST_USB_BASE = $(LIB_PATH)/STM32_USB-Host-Device_Lib_V2.1.0/Libraries

ifneq ($(STM32_USB_DEV),)
#Device Library
ST_USB_DEV_BASE = $(ST_USB_BASE)/STM32_USB_Device_Library

#Core libraries
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_BASE)/Core/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_BASE)/Core/inc/

#Class libraries
ST_USB_DEV_CLASS_BASE = $(ST_USB_DEV_BASE)/Class

#Audio
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_CLASS_BASE)/audio/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_CLASS_BASE)/audio/inc/

#CDC
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_CLASS_BASE)/cdc/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_CLASS_BASE)/cdc/inc/

#DFU
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_CLASS_BASE)/dfu/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_CLASS_BASE)/dfu/inc/

#HID
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_CLASS_BASE)/hid/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_CLASS_BASE)/hid/inc/

#MSC
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_DEV_CLASS_BASE)/msc/src)
LIB_INCLUDES      += -I$(ST_USB_DEV_CLASS_BASE)/msc/inc/

endif #USB_DEV

ifneq ($(STM32_USB_HOST),)
#Host Library
ST_USB_HOST_BASE = $(ST_USB_BASE)/STM32_USB_HOST_Library

#Core libraries
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_HOST_BASE)/Core/src)
LIB_INCLUDES      += -I$(ST_USB_HOST_BASE)/Core/inc/

#Class Libraries
ST_USB_HOST_CLASS_BASE = $(ST_USB_HOST_BASE)/Class

#HID
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_HOST_CLASS_BASE)/HID/src)
LIB_INCLUDES      += -I$(ST_USB_HOST_CLASS_BASE)/HID/inc/

#MSC
STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_HOST_CLASS_BASE)/MSC/src)
LIB_INCLUDES      += -I$(ST_USB_HOST_CLASS_BASE)/MSC/inc/

endif #USB_HOST

ifneq ($(STM32_USB_OTG),)
#OTG Library
ST_USB_OTG_BASE = $(ST_USB_BASE)/STM32_USB_OTG_Driver

STM32_USB_C_FILES += $(call valid_c_files,$(ST_USB_OTG_BASE)/src)
LIB_INCLUDES      += -I$(ST_USB_OTG_BASE)/inc

endif #USB_OTG

BASE_LIBS += stm32_usb

endif #STM32_USB_LIBS
