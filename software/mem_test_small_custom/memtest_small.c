/**************************************************************************
 * Copyright (c) 2009 Altera Corporation, San Jose, California, USA.      *
 * All rights reserved. All use of this software and documentation is     *
 * subject to the License Agreement located at the end of this file below.*
 *************************************************************************/
/**************************************************************************
 *
 * 
 * Description
 *************** 
 * This is a test program which tests RAM memory. 
 *
 * 
 * Requirements
 ****************
 * This is a "Hosted" application. According to the ANSI C standard, hosted 
 * applications can rely on numerous system-services (including properly-
 * initialized device drivers and, in this case, STDOUT).  
 * 
 * When this program is compiled, code is added before main(), so that all 
 * devices are properly-initialized and all system-services (e.g. the <stdio>
 * library) are ready-to-use. In this hosted environment, all standard C 
 * programs will run.
 * 
 * A hosted application (like this example) does not need to concern itself 
 * with initializing devices. As long as it only calls C Standard Library 
 * functions, a hosted application can run "as if on a workstation."
 * 
 * An application runs in a hosted environment if it declares the function 
 * main(), which this application does.
 * 
 * This software example requires a STDOUT component such as a UART or 
 * JTAG UART and 2 RAM components (one for running
 * the program, and one for testing)  Therefore it can run on the following
 * hardware examples:
 * 
 * Nios Development Board, Stratix II Edition:
 * -  Standard
 * -  Full Featured
 *
 * DSP Development Board, Stratix II Edition:
 * -  Standard
 * -  Full Featured
 *
 * Nios Development Board, Stratix Edition:
 * -  Standard
 * -  Full Featured
 * 
 * Nios Development Board, Stratix Professional Edition:
 * -  Standard
 * -  Full Featured
 * 
 * Nios Development Board, Cyclone Edition:
 * -  Standard
 * -  Full Featured
 *
 * Nios Development Board, Cyclone II Edition:
 * -  Standard
 * -  Full Featured
 *
 * Note: This example will not run on the Nios II Instruction Set Simulator
 * 
 **************************************************************************/


#include <stdio.h>
#include <alt_types.h>
#include <io.h>
#include <system.h>
#include <string.h>
#include <stdlib.h>

#include "sys/alt_stdio.h"
#include "system.h"

/******************************************************************
*  Function: MenuHeader
*
*  Purpose: Prints the menu header.
*
******************************************************************/
static void MenuHeader(void)
{
  printf("\n\n");
  printf("             <---->   Nios II Memory Test.   <---->\n");
  printf("This software example tests the memory in your system to assure it\n");
  printf("is working properly.  This test is destructive to the contents of\n");
  printf("the memory it tests. Assure the memory being tested does not contain\n");
  printf("the executable or data sections of this code or the exception address\n");
  printf("of the system.\n");
}

/******************************************************************
*  Function: GetInputString
*
*  Purpose: Parses an input string for the character '\n'.  Then
*           returns the string, minus any '\r' characters it 
*           encounters.
*
******************************************************************/
void GetInputString( char* entry, int size, FILE * stream )
{
  int i;
  int ch = 0;
  
  for(i = 0; (ch != '\n') && (i < size); )
  {
    if( (ch = alt_getchar()) != '\r')
    {
      putchar(ch);
      entry[i] = ch;
      i++;
    }
  }
}

/******************************************************************
*  Function: MemGetAddressRange
*
*  Purpose: Gathers a range of memory from the user.
*
******************************************************************/
static int MemGetAddress(int* base_address)
{

  char line[12];
  char *pend;

  while(1)
  {
    /* Get the base address */
    printf("Base address to start memory test: (i.e. 0x800000)\n");
    printf(">");

    GetInputString( line, sizeof(line), stdin );
   
    /* Check the format to make sure it was entered as hex */
    
    if((*base_address = strtol(line, &pend, 16)) < 0)
    {
      printf("%s\n", line);
      printf(" -ERROR: Invalid base address entered.  Address must be in the form '0x800000'\n\n");
      continue;
    }

    break;
  }

  return(0);
}

static void WriteString(int addr, char* text)
{
	int offset = 0;
	int len = strlen(text);
	int* next = text;

	while (next < (text+len)) {
		IOWR_32DIRECT(addr, offset, next[0]);
		next++;
		offset += 4;
	}
}

static void WriteStringSecure(int addr, char* text)
{
	int offset = 0;
	int len = strlen(text);
	int* next = text;

	while (next < (text+len)) {
		ALT_CI_CUSTOM_SECURE_MEM_INSTRUCTIONS(1, next[0], addr+offset);
		next++;
		offset += 4;
	}
}

static char* ReadString(int addr, int len)
{
	int offset = 0;
	char* val = malloc(len);
	int* next = val;

	while (offset < len*4) {
		next[0] = IORD_32DIRECT(addr, offset);
		next++;
		offset += 4;
	}

	return val;
}

static char* ReadStringSecure(int addr, int len)
{
	int offset = 0;
	char* val = malloc(len);
	int* next = val;

	while (offset < len*4) {
		next[0] = ALT_CI_CUSTOM_SECURE_MEM_INSTRUCTIONS(0, 0, addr+offset);
		next++;
		offset += 4;
	}

	return val;
}

/******************************************************************
*  Function: TestRam
*
*  Purpose: Performs a full-test on the RAM specified.  The tests
*           run are:
*             - MemTestDataBus
*             - MemTestAddressBus
*             - MemTest8_16BitAccess
*             - MemTestDevice
*
******************************************************************/
static void TestRam(void)
{
  
  int memory_base;
  char* text = "Hello world";
  char* ret_val = 0;

  /* Find out what range of memory we are testing */
  MemGetAddress(&memory_base);

  printf("\n");
  printf("Testing RAM at 0x%X\n\n", memory_base);

  
  // Write initial data
  printf("Writing string \"%s\" in addr 0x%X\n", text, memory_base);
  WriteString(memory_base, text);

  // Read data
  ret_val = ReadString(memory_base, 3);
  printf("Read data \"%s\" from addr 0x%X\n", ret_val, memory_base);

  // Read secure data
  ret_val = ReadStringSecure(memory_base, 3);
  printf("Read secure data \"%s\" from addr 0x%X\n", ret_val, memory_base);

  // Write secure data
  printf("Writing secure data \"%s\" in addr 0x%X\n", text, memory_base);
  WriteStringSecure(memory_base, text);

  // Read regular data
  ret_val = ReadString(memory_base, 3);
  printf("Read data \"%s\" from addr 0x%X\n", ret_val, memory_base);

  // Read secure data
  ret_val = ReadStringSecure(memory_base, 3);
  printf("Read secure data \"%s\" from addr 0x%X\n", ret_val, memory_base);

}

/******************************************************************
*  Function: main
*
*  Purpose: Continually prints the menu and performs the actions
*           requested by the user.
* 
******************************************************************/
int main(void)
{

  int ch;

  /* Print the Header */
  MenuHeader();

  while (1)
  {
    printf("\nPress enter to continue or 'q' to quit.\n");
    ch = alt_getchar();
    putchar(ch);
    if(ch == 'q' || ch == 'Q')
    {
        printf( "\nExiting from Memory Test.\n");
	/* Add this so that it will return back to command prompt */
	printf( "%c", 0x4);
        break;
    }
    else if (ch == '\n')
    {
        TestRam();
    }
  }
  return (0);
}


/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
