/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions FLASH and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 *
 * It defines following symbols, which code can use without definition:
 *   __exidx_start
 *   __exidx_end
 *   __etext
 *   __data_start__
 *   __preinit_array_start
 *   __preinit_array_end
 *   __init_array_start
 *   __init_array_end
 *   __fini_array_start
 *   __fini_array_end
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 */
ENTRY(Reset_Handler)

/* WHATS UP WITH ALL THE ALIGNMENTS!?! -- Gotta make sure that CM0 */
/* parts don't end up with unaligned access hardfaults */

 SECTIONS
 {
   /* The startup code goes first into FLASH */
   .isr_vector :
   {
     . = ALIGN(4);
     KEEP(*(.isr_vector)) /* Startup code */
     . = ALIGN(4);
   } >FLASH

   /* The program code and other data goes into FLASH */
   .text :
   {
     . = ALIGN(4);
     *(.text)           /* .text sections (code) */
     . = ALIGN(4);
     *(.text*)          /* .text* sections (code) */
     . = ALIGN(4);
     *(.rodata)         /* .rodata sections (constants, strings, etc.) */
     . = ALIGN(4);
     *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
     . = ALIGN(4);
     *(.glue_7)         /* glue arm to thumb code */
     . = ALIGN(4);
     *(.glue_7t)        /* glue thumb to arm code */

     . = ALIGN(4);
     KEEP (*(.init))
     . = ALIGN(4);
     KEEP (*(.fini))

     . = ALIGN(4);
     _etext = .;        /* define a global symbols at end of code */
   } >FLASH


    .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
     .ARM : {
     __exidx_start = .;
       *(.ARM.exidx*)
       __exidx_end = .;
     } >FLASH

   .ARM.attributes : { *(.ARM.attributes) } > FLASH

   .preinit_array     :
   {
     PROVIDE_HIDDEN (__preinit_array_start = .);
     KEEP (*(.preinit_array*))
     PROVIDE_HIDDEN (__preinit_array_end = .);
   } >FLASH
   .init_array :
   {
     PROVIDE_HIDDEN (__init_array_start = .);
     KEEP (*(SORT(.init_array.*)))
     KEEP (*(.init_array*))
     PROVIDE_HIDDEN (__init_array_end = .);
   } >FLASH
   .fini_array :
   {
     PROVIDE_HIDDEN (__fini_array_start = .);
     KEEP (*(.fini_array*))
     KEEP (*(SORT(.fini_array.*)))
     PROVIDE_HIDDEN (__fini_array_end = .);
   } >FLASH

   . = ALIGN(4);
   /* used by the startup to initialize data */
   _sidata = .;

   /* Initialized data sections goes into RAM, load LMA copy after code */
   .data : AT ( _sidata )
   {
     . = ALIGN(4);
     _sdata = .;        /* create a global symbol at data start */
     . = ALIGN(4);
     *(.data)           /* .data sections */
     . = ALIGN(4);
     *(.data*)          /* .data* sections */

     . = ALIGN(4);
     _edata = .;        /* define a global symbol at data end */
   } >RAM

   /* Uninitialized data section */
   . = ALIGN(4);
   .bss :
   {
     /* This is used by the startup in order to initialize the .bss secion */
     _sbss = .;         /* define a global symbol at bss start */
     __bss_start__ = _sbss;
     . = ALIGN(4);
     *(.bss)
     . = ALIGN(4);
     *(.bss*)
     . = ALIGN(4);
     *(COMMON)

     . = ALIGN(4);
     _ebss = .;         /* define a global symbol at bss end */
     __bss_end__ = _ebss;
   } >RAM

   PROVIDE ( end = _ebss );
   PROVIDE ( _end = _ebss );

   /* User_heap_stack section, used to check that there is enough RAM left */
   ._user_heap_stack :
   {
     . = ALIGN(4);
     . = . + _Min_Heap_Size;
     . = . + _Min_Stack_Size;
     . = ALIGN(4);
   } >RAM

   /* Remove information from the standard libraries */
   /DISCARD/ :
   {
     libc.a ( * )
     libm.a ( * )
     libgcc.a ( * )
   }
 }
