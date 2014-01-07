STM32Fx_FreeRTOS_Base
=====================

FreeRTOS starter project for STM32 F1 and F4 microcontrollers.

## Prerequisites
1. GNU Make
2. [gcc-arm-embedded](https://launchpad.net/gcc-arm-embedded)

## Creating a new project:
1. Create (if necessary) board and CPU definitions (see existing examples for details).
2. Create an application folder in the apps directory
3. Create a config.mk file for your application (see existing examples)
4. Store your application code in the newly created directory and edit your config.mk file appropriately

## Building
1. 'cd' to the root of base project directory
2. type 'make APP=your\_app\_name'

## Debugging
1. Install openocd with support for your JTAG dongle
2. Add an openocd.cfg to your project (see existing examples)
3. Install DDD (data display debugger) (optional)
4. Type: sudo make APP=your\_app\_name openocd (this starts the
   debugger)
5. Attach your favorite debugger (gdb/ddd/insight) to the openocd
   session (a make command for ddd is included in the makefile)
