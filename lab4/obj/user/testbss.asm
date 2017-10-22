
obj/user/testbss:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	cmpl $USTACKTOP, %esp
  800020:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  800026:	75 04                	jne    80002c <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  800028:	6a 00                	push   $0x0
	pushl $0
  80002a:	6a 00                	push   $0x0

0080002c <args_exist>:

args_exist:
	call libmain
  80002c:	e8 eb 00 00 00       	call   80011c <libmain>
1:	jmp 1b
  800031:	eb fe                	jmp    800031 <args_exist+0x5>
	...

00800034 <umain>:

uint32_t bigarray[ARRAYSIZE];

void
umain(int argc, char **argv)
{
  800034:	55                   	push   %ebp
  800035:	89 e5                	mov    %esp,%ebp
  800037:	83 ec 18             	sub    $0x18,%esp
	int i;

	cprintf("Making sure bss works right...\n");
  80003a:	c7 04 24 20 17 80 00 	movl   $0x801720,(%esp)
  800041:	e8 0f 02 00 00       	call   800255 <cprintf>
	for (i = 0; i < ARRAYSIZE; i++)
		if (bigarray[i] != 0)
  800046:	b8 01 00 00 00       	mov    $0x1,%eax
  80004b:	ba 20 20 80 00       	mov    $0x802020,%edx
  800050:	83 3d 20 20 80 00 00 	cmpl   $0x0,0x802020
  800057:	74 04                	je     80005d <umain+0x29>
  800059:	b0 00                	mov    $0x0,%al
  80005b:	eb 06                	jmp    800063 <umain+0x2f>
  80005d:	83 3c 82 00          	cmpl   $0x0,(%edx,%eax,4)
  800061:	74 20                	je     800083 <umain+0x4f>
			panic("bigarray[%d] isn't cleared!\n", i);
  800063:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800067:	c7 44 24 08 9b 17 80 	movl   $0x80179b,0x8(%esp)
  80006e:	00 
  80006f:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  800076:	00 
  800077:	c7 04 24 b8 17 80 00 	movl   $0x8017b8,(%esp)
  80007e:	e8 01 01 00 00       	call   800184 <_panic>
umain(int argc, char **argv)
{
	int i;

	cprintf("Making sure bss works right...\n");
	for (i = 0; i < ARRAYSIZE; i++)
  800083:	83 c0 01             	add    $0x1,%eax
  800086:	3d 00 00 10 00       	cmp    $0x100000,%eax
  80008b:	75 d0                	jne    80005d <umain+0x29>
  80008d:	b8 00 00 00 00       	mov    $0x0,%eax
		if (bigarray[i] != 0)
			panic("bigarray[%d] isn't cleared!\n", i);
	for (i = 0; i < ARRAYSIZE; i++)
		bigarray[i] = i;
  800092:	ba 20 20 80 00       	mov    $0x802020,%edx
  800097:	89 04 82             	mov    %eax,(%edx,%eax,4)

	cprintf("Making sure bss works right...\n");
	for (i = 0; i < ARRAYSIZE; i++)
		if (bigarray[i] != 0)
			panic("bigarray[%d] isn't cleared!\n", i);
	for (i = 0; i < ARRAYSIZE; i++)
  80009a:	83 c0 01             	add    $0x1,%eax
  80009d:	3d 00 00 10 00       	cmp    $0x100000,%eax
  8000a2:	75 f3                	jne    800097 <umain+0x63>
		bigarray[i] = i;
	for (i = 0; i < ARRAYSIZE; i++)
		if (bigarray[i] != i)
  8000a4:	b8 01 00 00 00       	mov    $0x1,%eax
  8000a9:	ba 20 20 80 00       	mov    $0x802020,%edx
  8000ae:	83 3d 20 20 80 00 00 	cmpl   $0x0,0x802020
  8000b5:	74 04                	je     8000bb <umain+0x87>
  8000b7:	b0 00                	mov    $0x0,%al
  8000b9:	eb 05                	jmp    8000c0 <umain+0x8c>
  8000bb:	39 04 82             	cmp    %eax,(%edx,%eax,4)
  8000be:	74 20                	je     8000e0 <umain+0xac>
			panic("bigarray[%d] didn't hold its value!\n", i);
  8000c0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8000c4:	c7 44 24 08 40 17 80 	movl   $0x801740,0x8(%esp)
  8000cb:	00 
  8000cc:	c7 44 24 04 16 00 00 	movl   $0x16,0x4(%esp)
  8000d3:	00 
  8000d4:	c7 04 24 b8 17 80 00 	movl   $0x8017b8,(%esp)
  8000db:	e8 a4 00 00 00       	call   800184 <_panic>
	for (i = 0; i < ARRAYSIZE; i++)
		if (bigarray[i] != 0)
			panic("bigarray[%d] isn't cleared!\n", i);
	for (i = 0; i < ARRAYSIZE; i++)
		bigarray[i] = i;
	for (i = 0; i < ARRAYSIZE; i++)
  8000e0:	83 c0 01             	add    $0x1,%eax
  8000e3:	3d 00 00 10 00       	cmp    $0x100000,%eax
  8000e8:	75 d1                	jne    8000bb <umain+0x87>
		if (bigarray[i] != i)
			panic("bigarray[%d] didn't hold its value!\n", i);

	cprintf("Yes, good.  Now doing a wild write off the end...\n");
  8000ea:	c7 04 24 68 17 80 00 	movl   $0x801768,(%esp)
  8000f1:	e8 5f 01 00 00       	call   800255 <cprintf>
	bigarray[ARRAYSIZE+1024] = 0;
  8000f6:	c7 05 20 30 c0 00 00 	movl   $0x0,0xc03020
  8000fd:	00 00 00 
	panic("SHOULD HAVE TRAPPED!!!");
  800100:	c7 44 24 08 c7 17 80 	movl   $0x8017c7,0x8(%esp)
  800107:	00 
  800108:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  80010f:	00 
  800110:	c7 04 24 b8 17 80 00 	movl   $0x8017b8,(%esp)
  800117:	e8 68 00 00 00       	call   800184 <_panic>

0080011c <libmain>:
const volatile struct Env *thisenv;
const char *binaryname = "<unknown>";

void
libmain(int argc, char **argv)
{
  80011c:	55                   	push   %ebp
  80011d:	89 e5                	mov    %esp,%ebp
  80011f:	83 ec 18             	sub    $0x18,%esp
  800122:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  800125:	89 75 fc             	mov    %esi,-0x4(%ebp)
  800128:	8b 75 08             	mov    0x8(%ebp),%esi
  80012b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	// set thisenv to point at our Env structure in envs[].
	// LAB 3: Your code here.
	thisenv = envs + ENVX(sys_getenvid());
  80012e:	e8 c2 12 00 00       	call   8013f5 <sys_getenvid>
  800133:	25 ff 03 00 00       	and    $0x3ff,%eax
  800138:	89 c2                	mov    %eax,%edx
  80013a:	c1 e2 07             	shl    $0x7,%edx
  80013d:	8d 84 82 00 00 c0 ee 	lea    -0x11400000(%edx,%eax,4),%eax
  800144:	a3 20 20 c0 00       	mov    %eax,0xc02020
        //cprintf("ENVX sys_get_envid(): %d\n",ENVX(sys_getenvid()));
	// save the name of the program so that panic() can use it
	if (argc > 0)
  800149:	85 f6                	test   %esi,%esi
  80014b:	7e 07                	jle    800154 <libmain+0x38>
		binaryname = argv[0];
  80014d:	8b 03                	mov    (%ebx),%eax
  80014f:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	umain(argc, argv);
  800154:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  800158:	89 34 24             	mov    %esi,(%esp)
  80015b:	e8 d4 fe ff ff       	call   800034 <umain>

	// exit gracefully
	exit();
  800160:	e8 0b 00 00 00       	call   800170 <exit>
}
  800165:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  800168:	8b 75 fc             	mov    -0x4(%ebp),%esi
  80016b:	89 ec                	mov    %ebp,%esp
  80016d:	5d                   	pop    %ebp
  80016e:	c3                   	ret    
	...

00800170 <exit>:

#include <inc/lib.h>

void
exit(void)
{
  800170:	55                   	push   %ebp
  800171:	89 e5                	mov    %esp,%ebp
  800173:	83 ec 18             	sub    $0x18,%esp
	sys_env_destroy(0);
  800176:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  80017d:	e8 b3 12 00 00       	call   801435 <sys_env_destroy>
}
  800182:	c9                   	leave  
  800183:	c3                   	ret    

00800184 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes JOS to enter the JOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt, ...)
{
  800184:	55                   	push   %ebp
  800185:	89 e5                	mov    %esp,%ebp
  800187:	56                   	push   %esi
  800188:	53                   	push   %ebx
  800189:	83 ec 20             	sub    $0x20,%esp
 * Panic is called on unresolvable fatal errors.
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes JOS to enter the JOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt, ...)
  80018c:	8d 75 14             	lea    0x14(%ebp),%esi
	va_list ap;

	va_start(ap, fmt);

	// Print the panic message
	if (argv0)
  80018f:	a1 24 20 c0 00       	mov    0xc02024,%eax
  800194:	85 c0                	test   %eax,%eax
  800196:	74 10                	je     8001a8 <_panic+0x24>
		cprintf("%s: ", argv0);
  800198:	89 44 24 04          	mov    %eax,0x4(%esp)
  80019c:	c7 04 24 e8 17 80 00 	movl   $0x8017e8,(%esp)
  8001a3:	e8 ad 00 00 00       	call   800255 <cprintf>
	cprintf("[%08x] user panic in %s at %s:%d: ",
  8001a8:	8b 1d 00 20 80 00    	mov    0x802000,%ebx
  8001ae:	e8 42 12 00 00       	call   8013f5 <sys_getenvid>
  8001b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b6:	89 54 24 10          	mov    %edx,0x10(%esp)
  8001ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8001bd:	89 54 24 0c          	mov    %edx,0xc(%esp)
  8001c1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8001c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  8001c9:	c7 04 24 f0 17 80 00 	movl   $0x8017f0,(%esp)
  8001d0:	e8 80 00 00 00       	call   800255 <cprintf>
		sys_getenvid(), binaryname, file, line);
	vcprintf(fmt, ap);
  8001d5:	89 74 24 04          	mov    %esi,0x4(%esp)
  8001d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001dc:	89 04 24             	mov    %eax,(%esp)
  8001df:	e8 10 00 00 00       	call   8001f4 <vcprintf>
	cprintf("\n");
  8001e4:	c7 04 24 b6 17 80 00 	movl   $0x8017b6,(%esp)
  8001eb:	e8 65 00 00 00       	call   800255 <cprintf>

	// Cause a breakpoint exception
	while (1)
		asm volatile("int3");
  8001f0:	cc                   	int3   
  8001f1:	eb fd                	jmp    8001f0 <_panic+0x6c>
	...

008001f4 <vcprintf>:
	b->cnt++;
}

int
vcprintf(const char *fmt, va_list ap)
{
  8001f4:	55                   	push   %ebp
  8001f5:	89 e5                	mov    %esp,%ebp
  8001f7:	81 ec 28 01 00 00    	sub    $0x128,%esp
	struct printbuf b;

	b.idx = 0;
  8001fd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800204:	00 00 00 
	b.cnt = 0;
  800207:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80020e:	00 00 00 
	vprintfmt((void*)putch, &b, fmt, ap);
  800211:	8b 45 0c             	mov    0xc(%ebp),%eax
  800214:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800218:	8b 45 08             	mov    0x8(%ebp),%eax
  80021b:	89 44 24 08          	mov    %eax,0x8(%esp)
  80021f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800225:	89 44 24 04          	mov    %eax,0x4(%esp)
  800229:	c7 04 24 6f 02 80 00 	movl   $0x80026f,(%esp)
  800230:	e8 d7 01 00 00       	call   80040c <vprintfmt>
	sys_cputs(b.buf, b.idx);
  800235:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80023b:	89 44 24 04          	mov    %eax,0x4(%esp)
  80023f:	8d 85 f8 fe ff ff    	lea    -0x108(%ebp),%eax
  800245:	89 04 24             	mov    %eax,(%esp)
  800248:	e8 6f 0d 00 00       	call   800fbc <sys_cputs>

	return b.cnt;
}
  80024d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800253:	c9                   	leave  
  800254:	c3                   	ret    

00800255 <cprintf>:

int
cprintf(const char *fmt, ...)
{
  800255:	55                   	push   %ebp
  800256:	89 e5                	mov    %esp,%ebp
  800258:	83 ec 18             	sub    $0x18,%esp

	return b.cnt;
}

int
cprintf(const char *fmt, ...)
  80025b:	8d 45 0c             	lea    0xc(%ebp),%eax
{
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
  80025e:	89 44 24 04          	mov    %eax,0x4(%esp)
  800262:	8b 45 08             	mov    0x8(%ebp),%eax
  800265:	89 04 24             	mov    %eax,(%esp)
  800268:	e8 87 ff ff ff       	call   8001f4 <vcprintf>
	va_end(ap);

	return cnt;
}
  80026d:	c9                   	leave  
  80026e:	c3                   	ret    

0080026f <putch>:
};


static void
putch(int ch, struct printbuf *b)
{
  80026f:	55                   	push   %ebp
  800270:	89 e5                	mov    %esp,%ebp
  800272:	53                   	push   %ebx
  800273:	83 ec 14             	sub    $0x14,%esp
  800276:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	b->buf[b->idx++] = ch;
  800279:	8b 03                	mov    (%ebx),%eax
  80027b:	8b 55 08             	mov    0x8(%ebp),%edx
  80027e:	88 54 03 08          	mov    %dl,0x8(%ebx,%eax,1)
  800282:	83 c0 01             	add    $0x1,%eax
  800285:	89 03                	mov    %eax,(%ebx)
	if (b->idx == 256-1) {
  800287:	3d ff 00 00 00       	cmp    $0xff,%eax
  80028c:	75 19                	jne    8002a7 <putch+0x38>
		sys_cputs(b->buf, b->idx);
  80028e:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  800295:	00 
  800296:	8d 43 08             	lea    0x8(%ebx),%eax
  800299:	89 04 24             	mov    %eax,(%esp)
  80029c:	e8 1b 0d 00 00       	call   800fbc <sys_cputs>
		b->idx = 0;
  8002a1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	}
	b->cnt++;
  8002a7:	83 43 04 01          	addl   $0x1,0x4(%ebx)
}
  8002ab:	83 c4 14             	add    $0x14,%esp
  8002ae:	5b                   	pop    %ebx
  8002af:	5d                   	pop    %ebp
  8002b0:	c3                   	ret    
	...

008002c0 <printnum_v2>:
 */

static void 
printnum_v2(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002c0:	55                   	push   %ebp
  8002c1:	89 e5                	mov    %esp,%ebp
  8002c3:	57                   	push   %edi
  8002c4:	56                   	push   %esi
  8002c5:	53                   	push   %ebx
  8002c6:	83 ec 4c             	sub    $0x4c,%esp
  8002c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8002cc:	89 d6                	mov    %edx,%esi
  8002ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8002d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002d7:	89 55 e0             	mov    %edx,-0x20(%ebp)
  8002da:	8b 45 10             	mov    0x10(%ebp),%eax
  8002dd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8002e0:	8b 7d 18             	mov    0x18(%ebp),%edi
    if (num >= base) {
  8002e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002e6:	b9 00 00 00 00       	mov    $0x0,%ecx
  8002eb:	39 d1                	cmp    %edx,%ecx
  8002ed:	72 07                	jb     8002f6 <printnum_v2+0x36>
  8002ef:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8002f2:	39 d0                	cmp    %edx,%eax
  8002f4:	77 5f                	ja     800355 <printnum_v2+0x95>
		printnum_v2(putch, putdat, num / base, base, width - 1, padc);
  8002f6:	89 7c 24 10          	mov    %edi,0x10(%esp)
  8002fa:	83 eb 01             	sub    $0x1,%ebx
  8002fd:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  800301:	89 44 24 08          	mov    %eax,0x8(%esp)
  800305:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  800309:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  80030d:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  800310:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
  800313:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  800316:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80031a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  800321:	00 
  800322:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800325:	89 04 24             	mov    %eax,(%esp)
  800328:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80032b:	89 54 24 04          	mov    %edx,0x4(%esp)
  80032f:	e8 6c 11 00 00       	call   8014a0 <__udivdi3>
  800334:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  800337:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
  80033a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80033e:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  800342:	89 04 24             	mov    %eax,(%esp)
  800345:	89 54 24 04          	mov    %edx,0x4(%esp)
  800349:	89 f2                	mov    %esi,%edx
  80034b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80034e:	e8 6d ff ff ff       	call   8002c0 <printnum_v2>
  800353:	eb 1e                	jmp    800373 <printnum_v2+0xb3>
	} else {
		// print any needed pad characters before first digit
                if(padc != '-'){
  800355:	83 ff 2d             	cmp    $0x2d,%edi
  800358:	74 19                	je     800373 <printnum_v2+0xb3>
		while (--width > 0)
  80035a:	83 eb 01             	sub    $0x1,%ebx
  80035d:	85 db                	test   %ebx,%ebx
  80035f:	90                   	nop
  800360:	7e 11                	jle    800373 <printnum_v2+0xb3>
			putch(padc, putdat);
  800362:	89 74 24 04          	mov    %esi,0x4(%esp)
  800366:	89 3c 24             	mov    %edi,(%esp)
  800369:	ff 55 e4             	call   *-0x1c(%ebp)
    if (num >= base) {
		printnum_v2(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
                if(padc != '-'){
		while (--width > 0)
  80036c:	83 eb 01             	sub    $0x1,%ebx
  80036f:	85 db                	test   %ebx,%ebx
  800371:	7f ef                	jg     800362 <printnum_v2+0xa2>
			putch(padc, putdat);
                }
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800373:	89 74 24 04          	mov    %esi,0x4(%esp)
  800377:	8b 74 24 04          	mov    0x4(%esp),%esi
  80037b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80037e:	89 44 24 08          	mov    %eax,0x8(%esp)
  800382:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  800389:	00 
  80038a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80038d:	89 14 24             	mov    %edx,(%esp)
  800390:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  800393:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  800397:	e8 34 12 00 00       	call   8015d0 <__umoddi3>
  80039c:	89 74 24 04          	mov    %esi,0x4(%esp)
  8003a0:	0f be 80 13 18 80 00 	movsbl 0x801813(%eax),%eax
  8003a7:	89 04 24             	mov    %eax,(%esp)
  8003aa:	ff 55 e4             	call   *-0x1c(%ebp)
}
  8003ad:	83 c4 4c             	add    $0x4c,%esp
  8003b0:	5b                   	pop    %ebx
  8003b1:	5e                   	pop    %esi
  8003b2:	5f                   	pop    %edi
  8003b3:	5d                   	pop    %ebp
  8003b4:	c3                   	ret    

008003b5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003b5:	55                   	push   %ebp
  8003b6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b8:	83 fa 01             	cmp    $0x1,%edx
  8003bb:	7e 0e                	jle    8003cb <getuint+0x16>
		return va_arg(*ap, unsigned long long);
  8003bd:	8b 10                	mov    (%eax),%edx
  8003bf:	8d 4a 08             	lea    0x8(%edx),%ecx
  8003c2:	89 08                	mov    %ecx,(%eax)
  8003c4:	8b 02                	mov    (%edx),%eax
  8003c6:	8b 52 04             	mov    0x4(%edx),%edx
  8003c9:	eb 22                	jmp    8003ed <getuint+0x38>
	else if (lflag)
  8003cb:	85 d2                	test   %edx,%edx
  8003cd:	74 10                	je     8003df <getuint+0x2a>
		return va_arg(*ap, unsigned long);
  8003cf:	8b 10                	mov    (%eax),%edx
  8003d1:	8d 4a 04             	lea    0x4(%edx),%ecx
  8003d4:	89 08                	mov    %ecx,(%eax)
  8003d6:	8b 02                	mov    (%edx),%eax
  8003d8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003dd:	eb 0e                	jmp    8003ed <getuint+0x38>
	else
		return va_arg(*ap, unsigned int);
  8003df:	8b 10                	mov    (%eax),%edx
  8003e1:	8d 4a 04             	lea    0x4(%edx),%ecx
  8003e4:	89 08                	mov    %ecx,(%eax)
  8003e6:	8b 02                	mov    (%edx),%eax
  8003e8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003ed:	5d                   	pop    %ebp
  8003ee:	c3                   	ret    

008003ef <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8003ef:	55                   	push   %ebp
  8003f0:	89 e5                	mov    %esp,%ebp
  8003f2:	8b 45 0c             	mov    0xc(%ebp),%eax
	b->cnt++;
  8003f5:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
  8003f9:	8b 10                	mov    (%eax),%edx
  8003fb:	3b 50 04             	cmp    0x4(%eax),%edx
  8003fe:	73 0a                	jae    80040a <sprintputch+0x1b>
		*b->buf++ = ch;
  800400:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800403:	88 0a                	mov    %cl,(%edx)
  800405:	83 c2 01             	add    $0x1,%edx
  800408:	89 10                	mov    %edx,(%eax)
}
  80040a:	5d                   	pop    %ebp
  80040b:	c3                   	ret    

0080040c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80040c:	55                   	push   %ebp
  80040d:	89 e5                	mov    %esp,%ebp
  80040f:	57                   	push   %edi
  800410:	56                   	push   %esi
  800411:	53                   	push   %ebx
  800412:	83 ec 6c             	sub    $0x6c,%esp
  800415:	8b 7d 10             	mov    0x10(%ebp),%edi
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800418:	c7 45 c8 ff ff ff ff 	movl   $0xffffffff,-0x38(%ebp)
  80041f:	eb 1a                	jmp    80043b <vprintfmt+0x2f>
	int base, lflag, width, precision, altflag,signflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
  800421:	85 c0                	test   %eax,%eax
  800423:	0f 84 66 06 00 00    	je     800a8f <vprintfmt+0x683>
				return;
			putch(ch, putdat);
  800429:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042c:	89 54 24 04          	mov    %edx,0x4(%esp)
  800430:	89 04 24             	mov    %eax,(%esp)
  800433:	ff 55 08             	call   *0x8(%ebp)
  800436:	eb 03                	jmp    80043b <vprintfmt+0x2f>
  800438:	8b 7d e4             	mov    -0x1c(%ebp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag,signflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80043b:	0f b6 07             	movzbl (%edi),%eax
  80043e:	83 c7 01             	add    $0x1,%edi
  800441:	83 f8 25             	cmp    $0x25,%eax
  800444:	75 db                	jne    800421 <vprintfmt+0x15>
  800446:	c6 45 cc 20          	movb   $0x20,-0x34(%ebp)
  80044a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80044f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  800456:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  80045b:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
  800462:	be 00 00 00 00       	mov    $0x0,%esi
  800467:	eb 06                	jmp    80046f <vprintfmt+0x63>
  800469:	c6 45 cc 2d          	movb   $0x2d,-0x34(%ebp)
  80046d:	89 c7                	mov    %eax,%edi
		precision = -1;
		lflag = 0;
		altflag = 0;
                signflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80046f:	0f b6 17             	movzbl (%edi),%edx
  800472:	0f b6 c2             	movzbl %dl,%eax
  800475:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800478:	8d 47 01             	lea    0x1(%edi),%eax
  80047b:	83 ea 23             	sub    $0x23,%edx
  80047e:	80 fa 55             	cmp    $0x55,%dl
  800481:	0f 87 60 05 00 00    	ja     8009e7 <vprintfmt+0x5db>
  800487:	0f b6 d2             	movzbl %dl,%edx
  80048a:	ff 24 95 60 19 80 00 	jmp    *0x801960(,%edx,4)
  800491:	b9 01 00 00 00       	mov    $0x1,%ecx
  800496:	eb d5                	jmp    80046d <vprintfmt+0x61>
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
  800498:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80049b:	83 eb 30             	sub    $0x30,%ebx
				ch = *fmt;
  80049e:	0f be 10             	movsbl (%eax),%edx
				if (ch < '0' || ch > '9')
  8004a1:	8d 7a d0             	lea    -0x30(%edx),%edi
  8004a4:	83 ff 09             	cmp    $0x9,%edi
  8004a7:	76 08                	jbe    8004b1 <vprintfmt+0xa5>
  8004a9:	eb 40                	jmp    8004eb <vprintfmt+0xdf>
  8004ab:	c6 45 cc 30          	movb   $0x30,-0x34(%ebp)
                        signflag = 1;
                        goto reswitch;
		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
			goto reswitch;
  8004af:	eb bc                	jmp    80046d <vprintfmt+0x61>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004b1:	83 c0 01             	add    $0x1,%eax
				precision = precision * 10 + ch - '0';
  8004b4:	8d 1c 9b             	lea    (%ebx,%ebx,4),%ebx
  8004b7:	8d 5c 5a d0          	lea    -0x30(%edx,%ebx,2),%ebx
				ch = *fmt;
  8004bb:	0f be 10             	movsbl (%eax),%edx
				if (ch < '0' || ch > '9')
  8004be:	8d 7a d0             	lea    -0x30(%edx),%edi
  8004c1:	83 ff 09             	cmp    $0x9,%edi
  8004c4:	76 eb                	jbe    8004b1 <vprintfmt+0xa5>
  8004c6:	eb 23                	jmp    8004eb <vprintfmt+0xdf>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004c8:	8b 55 14             	mov    0x14(%ebp),%edx
  8004cb:	8d 5a 04             	lea    0x4(%edx),%ebx
  8004ce:	89 5d 14             	mov    %ebx,0x14(%ebp)
  8004d1:	8b 1a                	mov    (%edx),%ebx
			goto process_precision;
  8004d3:	eb 16                	jmp    8004eb <vprintfmt+0xdf>

		case '.':
			if (width < 0)
  8004d5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8004d8:	c1 fa 1f             	sar    $0x1f,%edx
  8004db:	f7 d2                	not    %edx
  8004dd:	21 55 d8             	and    %edx,-0x28(%ebp)
  8004e0:	eb 8b                	jmp    80046d <vprintfmt+0x61>
  8004e2:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
			goto reswitch;
  8004e9:	eb 82                	jmp    80046d <vprintfmt+0x61>

		process_precision:
			if (width < 0)
  8004eb:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8004ef:	0f 89 78 ff ff ff    	jns    80046d <vprintfmt+0x61>
  8004f5:	89 5d d8             	mov    %ebx,-0x28(%ebp)
  8004f8:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  8004fb:	e9 6d ff ff ff       	jmp    80046d <vprintfmt+0x61>
				width = precision, precision = -1;
			goto reswitch;

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800500:	83 c6 01             	add    $0x1,%esi
			goto reswitch;
  800503:	e9 65 ff ff ff       	jmp    80046d <vprintfmt+0x61>
  800508:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80050b:	8b 45 14             	mov    0x14(%ebp),%eax
  80050e:	8d 50 04             	lea    0x4(%eax),%edx
  800511:	89 55 14             	mov    %edx,0x14(%ebp)
  800514:	8b 55 0c             	mov    0xc(%ebp),%edx
  800517:	89 54 24 04          	mov    %edx,0x4(%esp)
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	89 04 24             	mov    %eax,(%esp)
  800520:	ff 55 08             	call   *0x8(%ebp)
  800523:	8b 7d e4             	mov    -0x1c(%ebp),%edi
			break;
  800526:	e9 10 ff ff ff       	jmp    80043b <vprintfmt+0x2f>
  80052b:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		// error message
		case 'e':
			err = va_arg(ap, int);
  80052e:	8b 45 14             	mov    0x14(%ebp),%eax
  800531:	8d 50 04             	lea    0x4(%eax),%edx
  800534:	89 55 14             	mov    %edx,0x14(%ebp)
  800537:	8b 00                	mov    (%eax),%eax
  800539:	89 c2                	mov    %eax,%edx
  80053b:	c1 fa 1f             	sar    $0x1f,%edx
  80053e:	31 d0                	xor    %edx,%eax
  800540:	29 d0                	sub    %edx,%eax
			if (err < 0)
				err = -err;
			if (err >= MAXERROR || (p = error_string[err]) == NULL)
  800542:	83 f8 08             	cmp    $0x8,%eax
  800545:	7f 0b                	jg     800552 <vprintfmt+0x146>
  800547:	8b 14 85 c0 1a 80 00 	mov    0x801ac0(,%eax,4),%edx
  80054e:	85 d2                	test   %edx,%edx
  800550:	75 26                	jne    800578 <vprintfmt+0x16c>
				printfmt(putch, putdat, "error %d", err);
  800552:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800556:	c7 44 24 08 24 18 80 	movl   $0x801824,0x8(%esp)
  80055d:	00 
  80055e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800561:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  800565:	8b 5d 08             	mov    0x8(%ebp),%ebx
  800568:	89 1c 24             	mov    %ebx,(%esp)
  80056b:	e8 a7 05 00 00       	call   800b17 <printfmt>
  800570:	8b 7d e4             	mov    -0x1c(%ebp),%edi
		// error message
		case 'e':
			err = va_arg(ap, int);
			if (err < 0)
				err = -err;
			if (err >= MAXERROR || (p = error_string[err]) == NULL)
  800573:	e9 c3 fe ff ff       	jmp    80043b <vprintfmt+0x2f>
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800578:	89 54 24 0c          	mov    %edx,0xc(%esp)
  80057c:	c7 44 24 08 2d 18 80 	movl   $0x80182d,0x8(%esp)
  800583:	00 
  800584:	8b 45 0c             	mov    0xc(%ebp),%eax
  800587:	89 44 24 04          	mov    %eax,0x4(%esp)
  80058b:	8b 55 08             	mov    0x8(%ebp),%edx
  80058e:	89 14 24             	mov    %edx,(%esp)
  800591:	e8 81 05 00 00       	call   800b17 <printfmt>
  800596:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800599:	e9 9d fe ff ff       	jmp    80043b <vprintfmt+0x2f>
  80059e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005a1:	89 c7                	mov    %eax,%edi
  8005a3:	89 d9                	mov    %ebx,%ecx
  8005a5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005a8:	89 45 c0             	mov    %eax,-0x40(%ebp)
			break;

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ae:	8d 50 04             	lea    0x4(%eax),%edx
  8005b1:	89 55 14             	mov    %edx,0x14(%ebp)
  8005b4:	8b 30                	mov    (%eax),%esi
  8005b6:	85 f6                	test   %esi,%esi
  8005b8:	75 05                	jne    8005bf <vprintfmt+0x1b3>
  8005ba:	be 30 18 80 00       	mov    $0x801830,%esi
				p = "(null)";
			if (width > 0 && padc != '-')
  8005bf:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
  8005c3:	7e 06                	jle    8005cb <vprintfmt+0x1bf>
  8005c5:	80 7d cc 2d          	cmpb   $0x2d,-0x34(%ebp)
  8005c9:	75 10                	jne    8005db <vprintfmt+0x1cf>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005cb:	0f be 06             	movsbl (%esi),%eax
  8005ce:	85 c0                	test   %eax,%eax
  8005d0:	0f 85 a2 00 00 00    	jne    800678 <vprintfmt+0x26c>
  8005d6:	e9 92 00 00 00       	jmp    80066d <vprintfmt+0x261>
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005db:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8005df:	89 34 24             	mov    %esi,(%esp)
  8005e2:	e8 74 05 00 00       	call   800b5b <strnlen>
  8005e7:	8b 55 c0             	mov    -0x40(%ebp),%edx
  8005ea:	29 c2                	sub    %eax,%edx
  8005ec:	89 55 d8             	mov    %edx,-0x28(%ebp)
  8005ef:	85 d2                	test   %edx,%edx
  8005f1:	7e d8                	jle    8005cb <vprintfmt+0x1bf>
					putch(padc, putdat);
  8005f3:	0f be 4d cc          	movsbl -0x34(%ebp),%ecx
  8005f7:	89 5d c0             	mov    %ebx,-0x40(%ebp)
  8005fa:	89 d3                	mov    %edx,%ebx
  8005fc:	89 75 d8             	mov    %esi,-0x28(%ebp)
  8005ff:	89 7d bc             	mov    %edi,-0x44(%ebp)
  800602:	8b 7d 0c             	mov    0xc(%ebp),%edi
  800605:	89 ce                	mov    %ecx,%esi
  800607:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80060b:	89 34 24             	mov    %esi,(%esp)
  80060e:	ff 55 08             	call   *0x8(%ebp)
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800611:	83 eb 01             	sub    $0x1,%ebx
  800614:	85 db                	test   %ebx,%ebx
  800616:	7f ef                	jg     800607 <vprintfmt+0x1fb>
  800618:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  80061b:	8b 75 d8             	mov    -0x28(%ebp),%esi
  80061e:	8b 7d bc             	mov    -0x44(%ebp),%edi
  800621:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800628:	eb a1                	jmp    8005cb <vprintfmt+0x1bf>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
  80062a:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  80062e:	74 1b                	je     80064b <vprintfmt+0x23f>
  800630:	8d 50 e0             	lea    -0x20(%eax),%edx
  800633:	83 fa 5e             	cmp    $0x5e,%edx
  800636:	76 13                	jbe    80064b <vprintfmt+0x23f>
					putch('?', putdat);
  800638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063b:	89 44 24 04          	mov    %eax,0x4(%esp)
  80063f:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  800646:	ff 55 08             	call   *0x8(%ebp)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
  800649:	eb 0d                	jmp    800658 <vprintfmt+0x24c>
					putch('?', putdat);
				else
					putch(ch, putdat);
  80064b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064e:	89 54 24 04          	mov    %edx,0x4(%esp)
  800652:	89 04 24             	mov    %eax,(%esp)
  800655:	ff 55 08             	call   *0x8(%ebp)
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800658:	83 ef 01             	sub    $0x1,%edi
  80065b:	0f be 06             	movsbl (%esi),%eax
  80065e:	85 c0                	test   %eax,%eax
  800660:	74 05                	je     800667 <vprintfmt+0x25b>
  800662:	83 c6 01             	add    $0x1,%esi
  800665:	eb 1a                	jmp    800681 <vprintfmt+0x275>
  800667:	89 7d d8             	mov    %edi,-0x28(%ebp)
  80066a:	8b 7d cc             	mov    -0x34(%ebp),%edi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80066d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  800671:	7f 1f                	jg     800692 <vprintfmt+0x286>
  800673:	e9 c0 fd ff ff       	jmp    800438 <vprintfmt+0x2c>
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800678:	83 c6 01             	add    $0x1,%esi
  80067b:	89 7d cc             	mov    %edi,-0x34(%ebp)
  80067e:	8b 7d d8             	mov    -0x28(%ebp),%edi
  800681:	85 db                	test   %ebx,%ebx
  800683:	78 a5                	js     80062a <vprintfmt+0x21e>
  800685:	83 eb 01             	sub    $0x1,%ebx
  800688:	79 a0                	jns    80062a <vprintfmt+0x21e>
  80068a:	89 7d d8             	mov    %edi,-0x28(%ebp)
  80068d:	8b 7d cc             	mov    -0x34(%ebp),%edi
  800690:	eb db                	jmp    80066d <vprintfmt+0x261>
  800692:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800695:	8b 75 0c             	mov    0xc(%ebp),%esi
  800698:	89 7d d8             	mov    %edi,-0x28(%ebp)
  80069b:	8b 7d 08             	mov    0x8(%ebp),%edi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
				putch(' ', putdat);
  80069e:	89 74 24 04          	mov    %esi,0x4(%esp)
  8006a2:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  8006a9:	ff d7                	call   *%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ab:	83 eb 01             	sub    $0x1,%ebx
  8006ae:	85 db                	test   %ebx,%ebx
  8006b0:	7f ec                	jg     80069e <vprintfmt+0x292>
  8006b2:	8b 7d d8             	mov    -0x28(%ebp),%edi
  8006b5:	e9 81 fd ff ff       	jmp    80043b <vprintfmt+0x2f>
  8006ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  8006bd:	83 fe 01             	cmp    $0x1,%esi
  8006c0:	7e 10                	jle    8006d2 <vprintfmt+0x2c6>
		return va_arg(*ap, long long);
  8006c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c5:	8d 50 08             	lea    0x8(%eax),%edx
  8006c8:	89 55 14             	mov    %edx,0x14(%ebp)
  8006cb:	8b 18                	mov    (%eax),%ebx
  8006cd:	8b 70 04             	mov    0x4(%eax),%esi
  8006d0:	eb 26                	jmp    8006f8 <vprintfmt+0x2ec>
	else if (lflag)
  8006d2:	85 f6                	test   %esi,%esi
  8006d4:	74 12                	je     8006e8 <vprintfmt+0x2dc>
		return va_arg(*ap, long);
  8006d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d9:	8d 50 04             	lea    0x4(%eax),%edx
  8006dc:	89 55 14             	mov    %edx,0x14(%ebp)
  8006df:	8b 18                	mov    (%eax),%ebx
  8006e1:	89 de                	mov    %ebx,%esi
  8006e3:	c1 fe 1f             	sar    $0x1f,%esi
  8006e6:	eb 10                	jmp    8006f8 <vprintfmt+0x2ec>
	else
		return va_arg(*ap, int);
  8006e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006eb:	8d 50 04             	lea    0x4(%eax),%edx
  8006ee:	89 55 14             	mov    %edx,0x14(%ebp)
  8006f1:	8b 18                	mov    (%eax),%ebx
  8006f3:	89 de                	mov    %ebx,%esi
  8006f5:	c1 fe 1f             	sar    $0x1f,%esi
			break;

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
                        if(signflag == 1){
  8006f8:	83 f9 01             	cmp    $0x1,%ecx
  8006fb:	75 1e                	jne    80071b <vprintfmt+0x30f>
                               if((long long)num > 0){
  8006fd:	85 f6                	test   %esi,%esi
  8006ff:	78 1a                	js     80071b <vprintfmt+0x30f>
  800701:	85 f6                	test   %esi,%esi
  800703:	7f 05                	jg     80070a <vprintfmt+0x2fe>
  800705:	83 fb 00             	cmp    $0x0,%ebx
  800708:	76 11                	jbe    80071b <vprintfmt+0x30f>
                                   putch('+',putdat);
  80070a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80070d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  800711:	c7 04 24 2b 00 00 00 	movl   $0x2b,(%esp)
  800718:	ff 55 08             	call   *0x8(%ebp)
                               }
                        }
			if ((long long) num < 0) {
  80071b:	85 f6                	test   %esi,%esi
  80071d:	78 13                	js     800732 <vprintfmt+0x326>
				putch(' ', putdat);
			break;

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80071f:	89 5d b0             	mov    %ebx,-0x50(%ebp)
  800722:	89 75 b4             	mov    %esi,-0x4c(%ebp)
  800725:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800728:	b8 0a 00 00 00       	mov    $0xa,%eax
  80072d:	e9 da 00 00 00       	jmp    80080c <vprintfmt+0x400>
                               if((long long)num > 0){
                                   putch('+',putdat);
                               }
                        }
			if ((long long) num < 0) {
				putch('-', putdat);
  800732:	8b 45 0c             	mov    0xc(%ebp),%eax
  800735:	89 44 24 04          	mov    %eax,0x4(%esp)
  800739:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  800740:	ff 55 08             	call   *0x8(%ebp)
				num = -(long long) num;
  800743:	89 da                	mov    %ebx,%edx
  800745:	89 f1                	mov    %esi,%ecx
  800747:	f7 da                	neg    %edx
  800749:	83 d1 00             	adc    $0x0,%ecx
  80074c:	f7 d9                	neg    %ecx
  80074e:	89 55 b0             	mov    %edx,-0x50(%ebp)
  800751:	89 4d b4             	mov    %ecx,-0x4c(%ebp)
  800754:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800757:	b8 0a 00 00 00       	mov    $0xa,%eax
  80075c:	e9 ab 00 00 00       	jmp    80080c <vprintfmt+0x400>
  800761:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			base = 10;
			goto number;

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800764:	89 f2                	mov    %esi,%edx
  800766:	8d 45 14             	lea    0x14(%ebp),%eax
  800769:	e8 47 fc ff ff       	call   8003b5 <getuint>
  80076e:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800771:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  800774:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800777:	b8 0a 00 00 00       	mov    $0xa,%eax
			base = 10;
			goto number;
  80077c:	e9 8b 00 00 00       	jmp    80080c <vprintfmt+0x400>
  800781:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			// display a number in octal form and the form should begin with '0'
			putch('0', putdat);
  800784:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800787:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80078b:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  800792:	ff 55 08             	call   *0x8(%ebp)
			num = getuint(&ap,lflag);
  800795:	89 f2                	mov    %esi,%edx
  800797:	8d 45 14             	lea    0x14(%ebp),%eax
  80079a:	e8 16 fc ff ff       	call   8003b5 <getuint>
  80079f:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8007a2:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  8007a5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  8007a8:	b8 08 00 00 00       	mov    $0x8,%eax
                        base = 8;
			goto number;
  8007ad:	eb 5d                	jmp    80080c <vprintfmt+0x400>
  8007af:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		// pointer
		case 'p':
			putch('0', putdat);
  8007b2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8007b5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8007b9:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  8007c0:	ff 55 08             	call   *0x8(%ebp)
			putch('x', putdat);
  8007c3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8007c7:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  8007ce:	ff 55 08             	call   *0x8(%ebp)
			num = (unsigned long long)
  8007d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d4:	8d 50 04             	lea    0x4(%eax),%edx
  8007d7:	89 55 14             	mov    %edx,0x14(%ebp)
  8007da:	8b 10                	mov    (%eax),%edx
  8007dc:	b9 00 00 00 00       	mov    $0x0,%ecx
  8007e1:	89 55 b0             	mov    %edx,-0x50(%ebp)
  8007e4:	89 4d b4             	mov    %ecx,-0x4c(%ebp)
  8007e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  8007ea:	b8 10 00 00 00       	mov    $0x10,%eax
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
  8007ef:	eb 1b                	jmp    80080c <vprintfmt+0x400>
  8007f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007f4:	89 f2                	mov    %esi,%edx
  8007f6:	8d 45 14             	lea    0x14(%ebp),%eax
  8007f9:	e8 b7 fb ff ff       	call   8003b5 <getuint>
  8007fe:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800801:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  800804:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800807:	b8 10 00 00 00       	mov    $0x10,%eax
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
  80080c:	0f be 4d cc          	movsbl -0x34(%ebp),%ecx
  800810:	89 4d d0             	mov    %ecx,-0x30(%ebp)
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800813:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800816:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  80081a:	77 09                	ja     800825 <vprintfmt+0x419>
  80081c:	39 45 b0             	cmp    %eax,-0x50(%ebp)
  80081f:	0f 82 ac 00 00 00    	jb     8008d1 <vprintfmt+0x4c5>
		printnum_v2(putch, putdat, num / base, base, width - 1, padc);
  800825:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800828:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  80082c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80082f:	83 ea 01             	sub    $0x1,%edx
  800832:	89 54 24 0c          	mov    %edx,0xc(%esp)
  800836:	89 44 24 08          	mov    %eax,0x8(%esp)
  80083a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80083e:	8b 54 24 0c          	mov    0xc(%esp),%edx
  800842:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800845:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  800848:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80084b:	89 54 24 08          	mov    %edx,0x8(%esp)
  80084f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  800856:	00 
  800857:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  80085a:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
  80085d:	89 0c 24             	mov    %ecx,(%esp)
  800860:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  800864:	e8 37 0c 00 00       	call   8014a0 <__udivdi3>
  800869:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  80086c:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80086f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  800873:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  800877:	89 04 24             	mov    %eax,(%esp)
  80087a:	89 54 24 04          	mov    %edx,0x4(%esp)
  80087e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800881:	8b 45 08             	mov    0x8(%ebp),%eax
  800884:	e8 37 fa ff ff       	call   8002c0 <printnum_v2>
			putch(padc, putdat);
                }
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800889:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  80088c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  800890:	8b 74 24 04          	mov    0x4(%esp),%esi
  800894:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800897:	89 44 24 08          	mov    %eax,0x8(%esp)
  80089b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  8008a2:	00 
  8008a3:	8b 55 b0             	mov    -0x50(%ebp),%edx
  8008a6:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
  8008a9:	89 14 24             	mov    %edx,(%esp)
  8008ac:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8008b0:	e8 1b 0d 00 00       	call   8015d0 <__umoddi3>
  8008b5:	89 74 24 04          	mov    %esi,0x4(%esp)
  8008b9:	0f be 80 13 18 80 00 	movsbl 0x801813(%eax),%eax
  8008c0:	89 04 24             	mov    %eax,(%esp)
  8008c3:	ff 55 08             	call   *0x8(%ebp)
        if(padc == '-'){
  8008c6:	83 7d d0 2d          	cmpl   $0x2d,-0x30(%ebp)
  8008ca:	74 54                	je     800920 <vprintfmt+0x514>
  8008cc:	e9 67 fb ff ff       	jmp    800438 <vprintfmt+0x2c>
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum_v2(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
                if(padc != '-'){
  8008d1:	83 7d d0 2d          	cmpl   $0x2d,-0x30(%ebp)
  8008d5:	8d 76 00             	lea    0x0(%esi),%esi
  8008d8:	0f 84 2a 01 00 00    	je     800a08 <vprintfmt+0x5fc>
		while (--width > 0)
  8008de:	8b 7d d8             	mov    -0x28(%ebp),%edi
  8008e1:	83 ef 01             	sub    $0x1,%edi
  8008e4:	85 ff                	test   %edi,%edi
  8008e6:	0f 8e 5e 01 00 00    	jle    800a4a <vprintfmt+0x63e>
  8008ec:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  8008ef:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
  8008f2:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  8008f5:	89 5d dc             	mov    %ebx,-0x24(%ebp)
  8008f8:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  8008fb:	8b 75 0c             	mov    0xc(%ebp),%esi
			putch(padc, putdat);
  8008fe:	89 74 24 04          	mov    %esi,0x4(%esp)
  800902:	89 1c 24             	mov    %ebx,(%esp)
  800905:	ff 55 08             	call   *0x8(%ebp)
	if (num >= base) {
		printnum_v2(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
                if(padc != '-'){
		while (--width > 0)
  800908:	83 ef 01             	sub    $0x1,%edi
  80090b:	85 ff                	test   %edi,%edi
  80090d:	7f ef                	jg     8008fe <vprintfmt+0x4f2>
  80090f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800912:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800915:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800918:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  80091b:	e9 2a 01 00 00       	jmp    800a4a <vprintfmt+0x63e>
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
        if(padc == '-'){
           while (--width > 0)
  800920:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800923:	83 eb 01             	sub    $0x1,%ebx
  800926:	85 db                	test   %ebx,%ebx
  800928:	0f 8e 0a fb ff ff    	jle    800438 <vprintfmt+0x2c>
  80092e:	8b 75 0c             	mov    0xc(%ebp),%esi
  800931:	89 7d d8             	mov    %edi,-0x28(%ebp)
  800934:	8b 7d 08             	mov    0x8(%ebp),%edi
			putch(' ', putdat);
  800937:	89 74 24 04          	mov    %esi,0x4(%esp)
  80093b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  800942:	ff d7                	call   *%edi
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
        if(padc == '-'){
           while (--width > 0)
  800944:	83 eb 01             	sub    $0x1,%ebx
  800947:	85 db                	test   %ebx,%ebx
  800949:	7f ec                	jg     800937 <vprintfmt+0x52b>
  80094b:	8b 7d d8             	mov    -0x28(%ebp),%edi
  80094e:	e9 e8 fa ff ff       	jmp    80043b <vprintfmt+0x2f>
  800953:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            const char *null_error = "\nerror! writing through NULL pointer! (%n argument)\n";
            const char *overflow_error = "\nwarning! The value %n argument pointed to has been overflowed!\n";

            // Your code here
            char* n;
            if ((n = va_arg(ap, char *)) == NULL)
  800956:	8b 45 14             	mov    0x14(%ebp),%eax
  800959:	8d 50 04             	lea    0x4(%eax),%edx
  80095c:	89 55 14             	mov    %edx,0x14(%ebp)
  80095f:	8b 00                	mov    (%eax),%eax
  800961:	85 c0                	test   %eax,%eax
  800963:	75 2a                	jne    80098f <vprintfmt+0x583>
		  printfmt(putch,putdat,"%s",null_error);
  800965:	c7 44 24 0c cc 18 80 	movl   $0x8018cc,0xc(%esp)
  80096c:	00 
  80096d:	c7 44 24 08 2d 18 80 	movl   $0x80182d,0x8(%esp)
  800974:	00 
  800975:	8b 55 0c             	mov    0xc(%ebp),%edx
  800978:	89 54 24 04          	mov    %edx,0x4(%esp)
  80097c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80097f:	89 0c 24             	mov    %ecx,(%esp)
  800982:	e8 90 01 00 00       	call   800b17 <printfmt>
  800987:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  80098a:	e9 ac fa ff ff       	jmp    80043b <vprintfmt+0x2f>
            else if((*(int*)putdat) > 127){
  80098f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  800992:	8b 13                	mov    (%ebx),%edx
  800994:	83 fa 7f             	cmp    $0x7f,%edx
  800997:	7e 29                	jle    8009c2 <vprintfmt+0x5b6>
                  *n = *(int*)putdat;
  800999:	88 10                	mov    %dl,(%eax)
                  printfmt(putch,putdat,"%s",overflow_error);
  80099b:	c7 44 24 0c 04 19 80 	movl   $0x801904,0xc(%esp)
  8009a2:	00 
  8009a3:	c7 44 24 08 2d 18 80 	movl   $0x80182d,0x8(%esp)
  8009aa:	00 
  8009ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	89 04 24             	mov    %eax,(%esp)
  8009b5:	e8 5d 01 00 00       	call   800b17 <printfmt>
  8009ba:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  8009bd:	e9 79 fa ff ff       	jmp    80043b <vprintfmt+0x2f>
            }
            else
                  *n = *(int*)putdat;
  8009c2:	88 10                	mov    %dl,(%eax)
  8009c4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  8009c7:	e9 6f fa ff ff       	jmp    80043b <vprintfmt+0x2f>
  8009cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            break;
        }
		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009d2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8009d5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8009d9:	89 14 24             	mov    %edx,(%esp)
  8009dc:	ff 55 08             	call   *0x8(%ebp)
  8009df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
			break;
  8009e2:	e9 54 fa ff ff       	jmp    80043b <vprintfmt+0x2f>
			
		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8009ea:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8009ee:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  8009f5:	ff 55 08             	call   *0x8(%ebp)
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009f8:	8d 47 ff             	lea    -0x1(%edi),%eax
  8009fb:	80 38 25             	cmpb   $0x25,(%eax)
  8009fe:	0f 84 37 fa ff ff    	je     80043b <vprintfmt+0x2f>
  800a04:	89 c7                	mov    %eax,%edi
  800a06:	eb f0                	jmp    8009f8 <vprintfmt+0x5ec>
			putch(padc, putdat);
                }
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0b:	89 44 24 04          	mov    %eax,0x4(%esp)
  800a0f:	8b 74 24 04          	mov    0x4(%esp),%esi
  800a13:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800a16:	89 54 24 08          	mov    %edx,0x8(%esp)
  800a1a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  800a21:	00 
  800a22:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a25:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  800a28:	89 04 24             	mov    %eax,(%esp)
  800a2b:	89 54 24 04          	mov    %edx,0x4(%esp)
  800a2f:	e8 9c 0b 00 00       	call   8015d0 <__umoddi3>
  800a34:	89 74 24 04          	mov    %esi,0x4(%esp)
  800a38:	0f be 80 13 18 80 00 	movsbl 0x801813(%eax),%eax
  800a3f:	89 04 24             	mov    %eax,(%esp)
  800a42:	ff 55 08             	call   *0x8(%ebp)
  800a45:	e9 d6 fe ff ff       	jmp    800920 <vprintfmt+0x514>
  800a4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a4d:	89 54 24 04          	mov    %edx,0x4(%esp)
  800a51:	8b 74 24 04          	mov    0x4(%esp),%esi
  800a55:	8b 4d cc             	mov    -0x34(%ebp),%ecx
  800a58:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  800a5c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  800a63:	00 
  800a64:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a67:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  800a6a:	89 04 24             	mov    %eax,(%esp)
  800a6d:	89 54 24 04          	mov    %edx,0x4(%esp)
  800a71:	e8 5a 0b 00 00       	call   8015d0 <__umoddi3>
  800a76:	89 74 24 04          	mov    %esi,0x4(%esp)
  800a7a:	0f be 80 13 18 80 00 	movsbl 0x801813(%eax),%eax
  800a81:	89 04 24             	mov    %eax,(%esp)
  800a84:	ff 55 08             	call   *0x8(%ebp)
  800a87:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800a8a:	e9 ac f9 ff ff       	jmp    80043b <vprintfmt+0x2f>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a8f:	83 c4 6c             	add    $0x6c,%esp
  800a92:	5b                   	pop    %ebx
  800a93:	5e                   	pop    %esi
  800a94:	5f                   	pop    %edi
  800a95:	5d                   	pop    %ebp
  800a96:	c3                   	ret    

00800a97 <vsnprintf>:
		*b->buf++ = ch;
}

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a97:	55                   	push   %ebp
  800a98:	89 e5                	mov    %esp,%ebp
  800a9a:	83 ec 28             	sub    $0x28,%esp
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	8b 55 0c             	mov    0xc(%ebp),%edx
	struct sprintbuf b = {buf, buf+n-1, 0};

	if (buf == NULL || n < 1)
  800aa3:	85 c0                	test   %eax,%eax
  800aa5:	74 04                	je     800aab <vsnprintf+0x14>
  800aa7:	85 d2                	test   %edx,%edx
  800aa9:	7f 07                	jg     800ab2 <vsnprintf+0x1b>
  800aab:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800ab0:	eb 3b                	jmp    800aed <vsnprintf+0x56>
}

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ab2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ab5:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
  800ab9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
		return -E_INVAL;

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ac3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800aca:	8b 45 10             	mov    0x10(%ebp),%eax
  800acd:	89 44 24 08          	mov    %eax,0x8(%esp)
  800ad1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ad4:	89 44 24 04          	mov    %eax,0x4(%esp)
  800ad8:	c7 04 24 ef 03 80 00 	movl   $0x8003ef,(%esp)
  800adf:	e8 28 f9 ff ff       	call   80040c <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
  800ae4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ae7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800aed:	c9                   	leave  
  800aee:	c3                   	ret    

00800aef <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 18             	sub    $0x18,%esp

	return b.cnt;
}

int
snprintf(char *buf, int n, const char *fmt, ...)
  800af5:	8d 45 14             	lea    0x14(%ebp),%eax
{
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
  800af8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800afc:	8b 45 10             	mov    0x10(%ebp),%eax
  800aff:	89 44 24 08          	mov    %eax,0x8(%esp)
  800b03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b06:	89 44 24 04          	mov    %eax,0x4(%esp)
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	89 04 24             	mov    %eax,(%esp)
  800b10:	e8 82 ff ff ff       	call   800a97 <vsnprintf>
	va_end(ap);

	return rc;
}
  800b15:	c9                   	leave  
  800b16:	c3                   	ret    

00800b17 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
  800b1a:	83 ec 18             	sub    $0x18,%esp
		}
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
  800b1d:	8d 45 14             	lea    0x14(%ebp),%eax
{
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
  800b20:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800b24:	8b 45 10             	mov    0x10(%ebp),%eax
  800b27:	89 44 24 08          	mov    %eax,0x8(%esp)
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 04 24             	mov    %eax,(%esp)
  800b38:	e8 cf f8 ff ff       	call   80040c <vprintfmt>
	va_end(ap);
}
  800b3d:	c9                   	leave  
  800b3e:	c3                   	ret    
	...

00800b40 <strlen>:
// Primespipe runs 3x faster this way.
#define ASM 1

int
strlen(const char *s)
{
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	8b 55 08             	mov    0x8(%ebp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
  800b46:	b8 00 00 00 00       	mov    $0x0,%eax
  800b4b:	80 3a 00             	cmpb   $0x0,(%edx)
  800b4e:	74 09                	je     800b59 <strlen+0x19>
		n++;
  800b50:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  800b57:	75 f7                	jne    800b50 <strlen+0x10>
		n++;
	return n;
}
  800b59:	5d                   	pop    %ebp
  800b5a:	c3                   	ret    

00800b5b <strnlen>:

int
strnlen(const char *s, size_t size)
{
  800b5b:	55                   	push   %ebp
  800b5c:	89 e5                	mov    %esp,%ebp
  800b5e:	53                   	push   %ebx
  800b5f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  800b62:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b65:	85 c9                	test   %ecx,%ecx
  800b67:	74 19                	je     800b82 <strnlen+0x27>
  800b69:	80 3b 00             	cmpb   $0x0,(%ebx)
  800b6c:	74 14                	je     800b82 <strnlen+0x27>
  800b6e:	b8 00 00 00 00       	mov    $0x0,%eax
		n++;
  800b73:	83 c0 01             	add    $0x1,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b76:	39 c8                	cmp    %ecx,%eax
  800b78:	74 0d                	je     800b87 <strnlen+0x2c>
  800b7a:	80 3c 03 00          	cmpb   $0x0,(%ebx,%eax,1)
  800b7e:	75 f3                	jne    800b73 <strnlen+0x18>
  800b80:	eb 05                	jmp    800b87 <strnlen+0x2c>
  800b82:	b8 00 00 00 00       	mov    $0x0,%eax
		n++;
	return n;
}
  800b87:	5b                   	pop    %ebx
  800b88:	5d                   	pop    %ebp
  800b89:	c3                   	ret    

00800b8a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	53                   	push   %ebx
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  800b94:	ba 00 00 00 00       	mov    $0x0,%edx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
  800b99:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  800b9d:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  800ba0:	83 c2 01             	add    $0x1,%edx
  800ba3:	84 c9                	test   %cl,%cl
  800ba5:	75 f2                	jne    800b99 <strcpy+0xf>
		/* do nothing */;
	return ret;
}
  800ba7:	5b                   	pop    %ebx
  800ba8:	5d                   	pop    %ebp
  800ba9:	c3                   	ret    

00800baa <strcat>:

char *
strcat(char *dst, const char *src)
{
  800baa:	55                   	push   %ebp
  800bab:	89 e5                	mov    %esp,%ebp
  800bad:	53                   	push   %ebx
  800bae:	83 ec 08             	sub    $0x8,%esp
  800bb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int len = strlen(dst);
  800bb4:	89 1c 24             	mov    %ebx,(%esp)
  800bb7:	e8 84 ff ff ff       	call   800b40 <strlen>
	strcpy(dst + len, src);
  800bbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbf:	89 54 24 04          	mov    %edx,0x4(%esp)
  800bc3:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  800bc6:	89 04 24             	mov    %eax,(%esp)
  800bc9:	e8 bc ff ff ff       	call   800b8a <strcpy>
	return dst;
}
  800bce:	89 d8                	mov    %ebx,%eax
  800bd0:	83 c4 08             	add    $0x8,%esp
  800bd3:	5b                   	pop    %ebx
  800bd4:	5d                   	pop    %ebp
  800bd5:	c3                   	ret    

00800bd6 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size) {
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	56                   	push   %esi
  800bda:	53                   	push   %ebx
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be1:	8b 75 10             	mov    0x10(%ebp),%esi
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800be4:	85 f6                	test   %esi,%esi
  800be6:	74 18                	je     800c00 <strncpy+0x2a>
  800be8:	b9 00 00 00 00       	mov    $0x0,%ecx
		*dst++ = *src;
  800bed:	0f b6 1a             	movzbl (%edx),%ebx
  800bf0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
  800bf3:	80 3a 01             	cmpb   $0x1,(%edx)
  800bf6:	83 da ff             	sbb    $0xffffffff,%edx
strncpy(char *dst, const char *src, size_t size) {
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bf9:	83 c1 01             	add    $0x1,%ecx
  800bfc:	39 ce                	cmp    %ecx,%esi
  800bfe:	77 ed                	ja     800bed <strncpy+0x17>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
  800c00:	5b                   	pop    %ebx
  800c01:	5e                   	pop    %esi
  800c02:	5d                   	pop    %ebp
  800c03:	c3                   	ret    

00800c04 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
  800c04:	55                   	push   %ebp
  800c05:	89 e5                	mov    %esp,%ebp
  800c07:	56                   	push   %esi
  800c08:	53                   	push   %ebx
  800c09:	8b 75 08             	mov    0x8(%ebp),%esi
  800c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
  800c12:	89 f0                	mov    %esi,%eax
  800c14:	85 c9                	test   %ecx,%ecx
  800c16:	74 27                	je     800c3f <strlcpy+0x3b>
		while (--size > 0 && *src != '\0')
  800c18:	83 e9 01             	sub    $0x1,%ecx
  800c1b:	74 1d                	je     800c3a <strlcpy+0x36>
  800c1d:	0f b6 1a             	movzbl (%edx),%ebx
  800c20:	84 db                	test   %bl,%bl
  800c22:	74 16                	je     800c3a <strlcpy+0x36>
			*dst++ = *src++;
  800c24:	88 18                	mov    %bl,(%eax)
  800c26:	83 c0 01             	add    $0x1,%eax
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c29:	83 e9 01             	sub    $0x1,%ecx
  800c2c:	74 0e                	je     800c3c <strlcpy+0x38>
			*dst++ = *src++;
  800c2e:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c31:	0f b6 1a             	movzbl (%edx),%ebx
  800c34:	84 db                	test   %bl,%bl
  800c36:	75 ec                	jne    800c24 <strlcpy+0x20>
  800c38:	eb 02                	jmp    800c3c <strlcpy+0x38>
  800c3a:	89 f0                	mov    %esi,%eax
			*dst++ = *src++;
		*dst = '\0';
  800c3c:	c6 00 00             	movb   $0x0,(%eax)
  800c3f:	29 f0                	sub    %esi,%eax
	}
	return dst - dst_in;
}
  800c41:	5b                   	pop    %ebx
  800c42:	5e                   	pop    %esi
  800c43:	5d                   	pop    %ebp
  800c44:	c3                   	ret    

00800c45 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800c4b:	8b 55 0c             	mov    0xc(%ebp),%edx
	while (*p && *p == *q)
  800c4e:	0f b6 01             	movzbl (%ecx),%eax
  800c51:	84 c0                	test   %al,%al
  800c53:	74 15                	je     800c6a <strcmp+0x25>
  800c55:	3a 02                	cmp    (%edx),%al
  800c57:	75 11                	jne    800c6a <strcmp+0x25>
		p++, q++;
  800c59:	83 c1 01             	add    $0x1,%ecx
  800c5c:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c5f:	0f b6 01             	movzbl (%ecx),%eax
  800c62:	84 c0                	test   %al,%al
  800c64:	74 04                	je     800c6a <strcmp+0x25>
  800c66:	3a 02                	cmp    (%edx),%al
  800c68:	74 ef                	je     800c59 <strcmp+0x14>
  800c6a:	0f b6 c0             	movzbl %al,%eax
  800c6d:	0f b6 12             	movzbl (%edx),%edx
  800c70:	29 d0                	sub    %edx,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
}
  800c72:	5d                   	pop    %ebp
  800c73:	c3                   	ret    

00800c74 <strncmp>:

int
strncmp(const char *p, const char *q, size_t n)
{
  800c74:	55                   	push   %ebp
  800c75:	89 e5                	mov    %esp,%ebp
  800c77:	53                   	push   %ebx
  800c78:	8b 55 08             	mov    0x8(%ebp),%edx
  800c7b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800c7e:	8b 45 10             	mov    0x10(%ebp),%eax
	while (n > 0 && *p && *p == *q)
  800c81:	85 c0                	test   %eax,%eax
  800c83:	74 23                	je     800ca8 <strncmp+0x34>
  800c85:	0f b6 1a             	movzbl (%edx),%ebx
  800c88:	84 db                	test   %bl,%bl
  800c8a:	74 25                	je     800cb1 <strncmp+0x3d>
  800c8c:	3a 19                	cmp    (%ecx),%bl
  800c8e:	75 21                	jne    800cb1 <strncmp+0x3d>
  800c90:	83 e8 01             	sub    $0x1,%eax
  800c93:	74 13                	je     800ca8 <strncmp+0x34>
		n--, p++, q++;
  800c95:	83 c2 01             	add    $0x1,%edx
  800c98:	83 c1 01             	add    $0x1,%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  800c9b:	0f b6 1a             	movzbl (%edx),%ebx
  800c9e:	84 db                	test   %bl,%bl
  800ca0:	74 0f                	je     800cb1 <strncmp+0x3d>
  800ca2:	3a 19                	cmp    (%ecx),%bl
  800ca4:	74 ea                	je     800c90 <strncmp+0x1c>
  800ca6:	eb 09                	jmp    800cb1 <strncmp+0x3d>
  800ca8:	b8 00 00 00 00       	mov    $0x0,%eax
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
  800cad:	5b                   	pop    %ebx
  800cae:	5d                   	pop    %ebp
  800caf:	90                   	nop
  800cb0:	c3                   	ret    
	while (n > 0 && *p && *p == *q)
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb1:	0f b6 02             	movzbl (%edx),%eax
  800cb4:	0f b6 11             	movzbl (%ecx),%edx
  800cb7:	29 d0                	sub    %edx,%eax
  800cb9:	eb f2                	jmp    800cad <strncmp+0x39>

00800cbb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
	for (; *s; s++)
  800cc5:	0f b6 10             	movzbl (%eax),%edx
  800cc8:	84 d2                	test   %dl,%dl
  800cca:	74 18                	je     800ce4 <strchr+0x29>
		if (*s == c)
  800ccc:	38 ca                	cmp    %cl,%dl
  800cce:	75 0a                	jne    800cda <strchr+0x1f>
  800cd0:	eb 17                	jmp    800ce9 <strchr+0x2e>
  800cd2:	38 ca                	cmp    %cl,%dl
  800cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  800cd8:	74 0f                	je     800ce9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cda:	83 c0 01             	add    $0x1,%eax
  800cdd:	0f b6 10             	movzbl (%eax),%edx
  800ce0:	84 d2                	test   %dl,%dl
  800ce2:	75 ee                	jne    800cd2 <strchr+0x17>
  800ce4:	b8 00 00 00 00       	mov    $0x0,%eax
		if (*s == c)
			return (char *) s;
	return 0;
}
  800ce9:	5d                   	pop    %ebp
  800cea:	c3                   	ret    

00800ceb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
	for (; *s; s++)
  800cf5:	0f b6 10             	movzbl (%eax),%edx
  800cf8:	84 d2                	test   %dl,%dl
  800cfa:	74 18                	je     800d14 <strfind+0x29>
		if (*s == c)
  800cfc:	38 ca                	cmp    %cl,%dl
  800cfe:	75 0a                	jne    800d0a <strfind+0x1f>
  800d00:	eb 12                	jmp    800d14 <strfind+0x29>
  800d02:	38 ca                	cmp    %cl,%dl
  800d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  800d08:	74 0a                	je     800d14 <strfind+0x29>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d0a:	83 c0 01             	add    $0x1,%eax
  800d0d:	0f b6 10             	movzbl (%eax),%edx
  800d10:	84 d2                	test   %dl,%dl
  800d12:	75 ee                	jne    800d02 <strfind+0x17>
		if (*s == c)
			break;
	return (char *) s;
}
  800d14:	5d                   	pop    %ebp
  800d15:	c3                   	ret    

00800d16 <memset>:

#if ASM
void *
memset(void *v, int c, size_t n)
{
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 0c             	sub    $0xc,%esp
  800d1c:	89 1c 24             	mov    %ebx,(%esp)
  800d1f:	89 74 24 04          	mov    %esi,0x4(%esp)
  800d23:	89 7c 24 08          	mov    %edi,0x8(%esp)
  800d27:	8b 7d 08             	mov    0x8(%ebp),%edi
  800d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2d:	8b 4d 10             	mov    0x10(%ebp),%ecx
	char *p;

	if (n == 0)
  800d30:	85 c9                	test   %ecx,%ecx
  800d32:	74 30                	je     800d64 <memset+0x4e>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
  800d34:	f7 c7 03 00 00 00    	test   $0x3,%edi
  800d3a:	75 25                	jne    800d61 <memset+0x4b>
  800d3c:	f6 c1 03             	test   $0x3,%cl
  800d3f:	75 20                	jne    800d61 <memset+0x4b>
		c &= 0xFF;
  800d41:	0f b6 d0             	movzbl %al,%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
  800d44:	89 d3                	mov    %edx,%ebx
  800d46:	c1 e3 08             	shl    $0x8,%ebx
  800d49:	89 d6                	mov    %edx,%esi
  800d4b:	c1 e6 18             	shl    $0x18,%esi
  800d4e:	89 d0                	mov    %edx,%eax
  800d50:	c1 e0 10             	shl    $0x10,%eax
  800d53:	09 f0                	or     %esi,%eax
  800d55:	09 d0                	or     %edx,%eax
		asm volatile("cld; rep stosl\n"
  800d57:	09 d8                	or     %ebx,%eax
  800d59:	c1 e9 02             	shr    $0x2,%ecx
  800d5c:	fc                   	cld    
  800d5d:	f3 ab                	rep stos %eax,%es:(%edi)
{
	char *p;

	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
  800d5f:	eb 03                	jmp    800d64 <memset+0x4e>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			:: "D" (v), "a" (c), "c" (n/4)
			: "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
  800d61:	fc                   	cld    
  800d62:	f3 aa                	rep stos %al,%es:(%edi)
			:: "D" (v), "a" (c), "c" (n)
			: "cc", "memory");
	return v;
}
  800d64:	89 f8                	mov    %edi,%eax
  800d66:	8b 1c 24             	mov    (%esp),%ebx
  800d69:	8b 74 24 04          	mov    0x4(%esp),%esi
  800d6d:	8b 7c 24 08          	mov    0x8(%esp),%edi
  800d71:	89 ec                	mov    %ebp,%esp
  800d73:	5d                   	pop    %ebp
  800d74:	c3                   	ret    

00800d75 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  800d75:	55                   	push   %ebp
  800d76:	89 e5                	mov    %esp,%ebp
  800d78:	83 ec 08             	sub    $0x8,%esp
  800d7b:	89 34 24             	mov    %esi,(%esp)
  800d7e:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	8b 4d 10             	mov    0x10(%ebp),%ecx
	const char *s;
	char *d;
	
	s = src;
  800d88:	8b 75 0c             	mov    0xc(%ebp),%esi
	d = dst;
  800d8b:	89 c7                	mov    %eax,%edi
	if (s < d && s + n > d) {
  800d8d:	39 c6                	cmp    %eax,%esi
  800d8f:	73 35                	jae    800dc6 <memmove+0x51>
  800d91:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  800d94:	39 d0                	cmp    %edx,%eax
  800d96:	73 2e                	jae    800dc6 <memmove+0x51>
		s += n;
		d += n;
  800d98:	01 cf                	add    %ecx,%edi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800d9a:	f6 c2 03             	test   $0x3,%dl
  800d9d:	75 1b                	jne    800dba <memmove+0x45>
  800d9f:	f7 c7 03 00 00 00    	test   $0x3,%edi
  800da5:	75 13                	jne    800dba <memmove+0x45>
  800da7:	f6 c1 03             	test   $0x3,%cl
  800daa:	75 0e                	jne    800dba <memmove+0x45>
			asm volatile("std; rep movsl\n"
  800dac:	83 ef 04             	sub    $0x4,%edi
  800daf:	8d 72 fc             	lea    -0x4(%edx),%esi
  800db2:	c1 e9 02             	shr    $0x2,%ecx
  800db5:	fd                   	std    
  800db6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800db8:	eb 09                	jmp    800dc3 <memmove+0x4e>
			asm volatile("std; rep movsl\n"
				:: "D" (d-4), "S" (s-4), "c" (n/4) : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
  800dba:	83 ef 01             	sub    $0x1,%edi
  800dbd:	8d 72 ff             	lea    -0x1(%edx),%esi
  800dc0:	fd                   	std    
  800dc1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
  800dc3:	fc                   	cld    
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dc4:	eb 20                	jmp    800de6 <memmove+0x71>
			asm volatile("std; rep movsb\n"
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800dc6:	f7 c6 03 00 00 00    	test   $0x3,%esi
  800dcc:	75 15                	jne    800de3 <memmove+0x6e>
  800dce:	f7 c7 03 00 00 00    	test   $0x3,%edi
  800dd4:	75 0d                	jne    800de3 <memmove+0x6e>
  800dd6:	f6 c1 03             	test   $0x3,%cl
  800dd9:	75 08                	jne    800de3 <memmove+0x6e>
			asm volatile("cld; rep movsl\n"
  800ddb:	c1 e9 02             	shr    $0x2,%ecx
  800dde:	fc                   	cld    
  800ddf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
			asm volatile("std; rep movsb\n"
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800de1:	eb 03                	jmp    800de6 <memmove+0x71>
			asm volatile("cld; rep movsl\n"
				:: "D" (d), "S" (s), "c" (n/4) : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
  800de3:	fc                   	cld    
  800de4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				:: "D" (d), "S" (s), "c" (n) : "cc", "memory");
	}
	return dst;
}
  800de6:	8b 34 24             	mov    (%esp),%esi
  800de9:	8b 7c 24 04          	mov    0x4(%esp),%edi
  800ded:	89 ec                	mov    %ebp,%esp
  800def:	5d                   	pop    %ebp
  800df0:	c3                   	ret    

00800df1 <memcpy>:

/* sigh - gcc emits references to this for structure assignments! */
/* it is *not* prototyped in inc/string.h - do not use directly. */
void *
memcpy(void *dst, void *src, size_t n)
{
  800df1:	55                   	push   %ebp
  800df2:	89 e5                	mov    %esp,%ebp
  800df4:	83 ec 0c             	sub    $0xc,%esp
	return memmove(dst, src, n);
  800df7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfa:	89 44 24 08          	mov    %eax,0x8(%esp)
  800dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e01:	89 44 24 04          	mov    %eax,0x4(%esp)
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	89 04 24             	mov    %eax,(%esp)
  800e0b:	e8 65 ff ff ff       	call   800d75 <memmove>
}
  800e10:	c9                   	leave  
  800e11:	c3                   	ret    

00800e12 <memcmp>:

int
memcmp(const void *v1, const void *v2, size_t n)
{
  800e12:	55                   	push   %ebp
  800e13:	89 e5                	mov    %esp,%ebp
  800e15:	57                   	push   %edi
  800e16:	56                   	push   %esi
  800e17:	53                   	push   %ebx
  800e18:	8b 75 08             	mov    0x8(%ebp),%esi
  800e1b:	8b 7d 0c             	mov    0xc(%ebp),%edi
  800e1e:	8b 4d 10             	mov    0x10(%ebp),%ecx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
  800e21:	85 c9                	test   %ecx,%ecx
  800e23:	74 36                	je     800e5b <memcmp+0x49>
		if (*s1 != *s2)
  800e25:	0f b6 06             	movzbl (%esi),%eax
  800e28:	0f b6 1f             	movzbl (%edi),%ebx
  800e2b:	38 d8                	cmp    %bl,%al
  800e2d:	74 20                	je     800e4f <memcmp+0x3d>
  800e2f:	eb 14                	jmp    800e45 <memcmp+0x33>
  800e31:	0f b6 44 16 01       	movzbl 0x1(%esi,%edx,1),%eax
  800e36:	0f b6 5c 17 01       	movzbl 0x1(%edi,%edx,1),%ebx
  800e3b:	83 c2 01             	add    $0x1,%edx
  800e3e:	83 e9 01             	sub    $0x1,%ecx
  800e41:	38 d8                	cmp    %bl,%al
  800e43:	74 12                	je     800e57 <memcmp+0x45>
			return (int) *s1 - (int) *s2;
  800e45:	0f b6 c0             	movzbl %al,%eax
  800e48:	0f b6 db             	movzbl %bl,%ebx
  800e4b:	29 d8                	sub    %ebx,%eax
  800e4d:	eb 11                	jmp    800e60 <memcmp+0x4e>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
  800e4f:	83 e9 01             	sub    $0x1,%ecx
  800e52:	ba 00 00 00 00       	mov    $0x0,%edx
  800e57:	85 c9                	test   %ecx,%ecx
  800e59:	75 d6                	jne    800e31 <memcmp+0x1f>
  800e5b:	b8 00 00 00 00       	mov    $0x0,%eax
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
  800e60:	5b                   	pop    %ebx
  800e61:	5e                   	pop    %esi
  800e62:	5f                   	pop    %edi
  800e63:	5d                   	pop    %ebp
  800e64:	c3                   	ret    

00800e65 <memfind>:

void *
memfind(const void *s, int c, size_t n)
{
  800e65:	55                   	push   %ebp
  800e66:	89 e5                	mov    %esp,%ebp
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
	const void *ends = (const char *) s + n;
  800e6b:	89 c2                	mov    %eax,%edx
  800e6d:	03 55 10             	add    0x10(%ebp),%edx
	for (; s < ends; s++)
  800e70:	39 d0                	cmp    %edx,%eax
  800e72:	73 15                	jae    800e89 <memfind+0x24>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e74:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  800e78:	38 08                	cmp    %cl,(%eax)
  800e7a:	75 06                	jne    800e82 <memfind+0x1d>
  800e7c:	eb 0b                	jmp    800e89 <memfind+0x24>
  800e7e:	38 08                	cmp    %cl,(%eax)
  800e80:	74 07                	je     800e89 <memfind+0x24>

void *
memfind(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e82:	83 c0 01             	add    $0x1,%eax
  800e85:	39 c2                	cmp    %eax,%edx
  800e87:	77 f5                	ja     800e7e <memfind+0x19>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
	return (void *) s;
}
  800e89:	5d                   	pop    %ebp
  800e8a:	c3                   	ret    

00800e8b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e8b:	55                   	push   %ebp
  800e8c:	89 e5                	mov    %esp,%ebp
  800e8e:	57                   	push   %edi
  800e8f:	56                   	push   %esi
  800e90:	53                   	push   %ebx
  800e91:	83 ec 04             	sub    $0x4,%esp
  800e94:	8b 55 08             	mov    0x8(%ebp),%edx
  800e97:	8b 5d 10             	mov    0x10(%ebp),%ebx
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e9a:	0f b6 02             	movzbl (%edx),%eax
  800e9d:	3c 20                	cmp    $0x20,%al
  800e9f:	74 04                	je     800ea5 <strtol+0x1a>
  800ea1:	3c 09                	cmp    $0x9,%al
  800ea3:	75 0e                	jne    800eb3 <strtol+0x28>
		s++;
  800ea5:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea8:	0f b6 02             	movzbl (%edx),%eax
  800eab:	3c 20                	cmp    $0x20,%al
  800ead:	74 f6                	je     800ea5 <strtol+0x1a>
  800eaf:	3c 09                	cmp    $0x9,%al
  800eb1:	74 f2                	je     800ea5 <strtol+0x1a>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eb3:	3c 2b                	cmp    $0x2b,%al
  800eb5:	75 0c                	jne    800ec3 <strtol+0x38>
		s++;
  800eb7:	83 c2 01             	add    $0x1,%edx
  800eba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ec1:	eb 15                	jmp    800ed8 <strtol+0x4d>
	else if (*s == '-')
  800ec3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800eca:	3c 2d                	cmp    $0x2d,%al
  800ecc:	75 0a                	jne    800ed8 <strtol+0x4d>
		s++, neg = 1;
  800ece:	83 c2 01             	add    $0x1,%edx
  800ed1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ed8:	85 db                	test   %ebx,%ebx
  800eda:	0f 94 c0             	sete   %al
  800edd:	74 05                	je     800ee4 <strtol+0x59>
  800edf:	83 fb 10             	cmp    $0x10,%ebx
  800ee2:	75 18                	jne    800efc <strtol+0x71>
  800ee4:	80 3a 30             	cmpb   $0x30,(%edx)
  800ee7:	75 13                	jne    800efc <strtol+0x71>
  800ee9:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
  800eed:	8d 76 00             	lea    0x0(%esi),%esi
  800ef0:	75 0a                	jne    800efc <strtol+0x71>
		s += 2, base = 16;
  800ef2:	83 c2 02             	add    $0x2,%edx
  800ef5:	bb 10 00 00 00       	mov    $0x10,%ebx
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800efa:	eb 15                	jmp    800f11 <strtol+0x86>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
  800efc:	84 c0                	test   %al,%al
  800efe:	66 90                	xchg   %ax,%ax
  800f00:	74 0f                	je     800f11 <strtol+0x86>
  800f02:	bb 0a 00 00 00       	mov    $0xa,%ebx
  800f07:	80 3a 30             	cmpb   $0x30,(%edx)
  800f0a:	75 05                	jne    800f11 <strtol+0x86>
		s++, base = 8;
  800f0c:	83 c2 01             	add    $0x1,%edx
  800f0f:	b3 08                	mov    $0x8,%bl
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
  800f11:	b8 00 00 00 00       	mov    $0x0,%eax
  800f16:	89 de                	mov    %ebx,%esi

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f18:	0f b6 0a             	movzbl (%edx),%ecx
  800f1b:	89 cf                	mov    %ecx,%edi
  800f1d:	8d 59 d0             	lea    -0x30(%ecx),%ebx
  800f20:	80 fb 09             	cmp    $0x9,%bl
  800f23:	77 08                	ja     800f2d <strtol+0xa2>
			dig = *s - '0';
  800f25:	0f be c9             	movsbl %cl,%ecx
  800f28:	83 e9 30             	sub    $0x30,%ecx
  800f2b:	eb 1e                	jmp    800f4b <strtol+0xc0>
		else if (*s >= 'a' && *s <= 'z')
  800f2d:	8d 5f 9f             	lea    -0x61(%edi),%ebx
  800f30:	80 fb 19             	cmp    $0x19,%bl
  800f33:	77 08                	ja     800f3d <strtol+0xb2>
			dig = *s - 'a' + 10;
  800f35:	0f be c9             	movsbl %cl,%ecx
  800f38:	83 e9 57             	sub    $0x57,%ecx
  800f3b:	eb 0e                	jmp    800f4b <strtol+0xc0>
		else if (*s >= 'A' && *s <= 'Z')
  800f3d:	8d 5f bf             	lea    -0x41(%edi),%ebx
  800f40:	80 fb 19             	cmp    $0x19,%bl
  800f43:	77 15                	ja     800f5a <strtol+0xcf>
			dig = *s - 'A' + 10;
  800f45:	0f be c9             	movsbl %cl,%ecx
  800f48:	83 e9 37             	sub    $0x37,%ecx
		else
			break;
		if (dig >= base)
  800f4b:	39 f1                	cmp    %esi,%ecx
  800f4d:	7d 0b                	jge    800f5a <strtol+0xcf>
			break;
		s++, val = (val * base) + dig;
  800f4f:	83 c2 01             	add    $0x1,%edx
  800f52:	0f af c6             	imul   %esi,%eax
  800f55:	8d 04 01             	lea    (%ecx,%eax,1),%eax
		// we don't properly detect overflow!
	}
  800f58:	eb be                	jmp    800f18 <strtol+0x8d>
  800f5a:	89 c1                	mov    %eax,%ecx

	if (endptr)
  800f5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f60:	74 05                	je     800f67 <strtol+0xdc>
		*endptr = (char *) s;
  800f62:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  800f65:	89 13                	mov    %edx,(%ebx)
	return (neg ? -val : val);
  800f67:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800f6b:	74 04                	je     800f71 <strtol+0xe6>
  800f6d:	89 c8                	mov    %ecx,%eax
  800f6f:	f7 d8                	neg    %eax
}
  800f71:	83 c4 04             	add    $0x4,%esp
  800f74:	5b                   	pop    %ebx
  800f75:	5e                   	pop    %esi
  800f76:	5f                   	pop    %edi
  800f77:	5d                   	pop    %ebp
  800f78:	c3                   	ret    
  800f79:	00 00                	add    %al,(%eax)
	...

00800f7c <sys_cgetc>:
	syscall(SYS_cputs, 0, (uint32_t)s, len, 0, 0, 0);
}

int
sys_cgetc(void)
{
  800f7c:	55                   	push   %ebp
  800f7d:	89 e5                	mov    %esp,%ebp
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	89 1c 24             	mov    %ebx,(%esp)
  800f85:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  800f89:	ba 00 00 00 00       	mov    $0x0,%edx
  800f8e:	b8 01 00 00 00       	mov    $0x1,%eax
  800f93:	89 d1                	mov    %edx,%ecx
  800f95:	89 d3                	mov    %edx,%ebx
  800f97:	89 d7                	mov    %edx,%edi
  800f99:	51                   	push   %ecx
  800f9a:	52                   	push   %edx
  800f9b:	53                   	push   %ebx
  800f9c:	54                   	push   %esp
  800f9d:	55                   	push   %ebp
  800f9e:	56                   	push   %esi
  800f9f:	57                   	push   %edi
  800fa0:	54                   	push   %esp
  800fa1:	5d                   	pop    %ebp
  800fa2:	8d 35 aa 0f 80 00    	lea    0x800faa,%esi
  800fa8:	0f 34                	sysenter 
  800faa:	5f                   	pop    %edi
  800fab:	5e                   	pop    %esi
  800fac:	5d                   	pop    %ebp
  800fad:	5c                   	pop    %esp
  800fae:	5b                   	pop    %ebx
  800faf:	5a                   	pop    %edx
  800fb0:	59                   	pop    %ecx

int
sys_cgetc(void)
{
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0, 0);
}
  800fb1:	8b 1c 24             	mov    (%esp),%ebx
  800fb4:	8b 7c 24 04          	mov    0x4(%esp),%edi
  800fb8:	89 ec                	mov    %ebp,%esp
  800fba:	5d                   	pop    %ebp
  800fbb:	c3                   	ret    

00800fbc <sys_cputs>:
	return ret;
}

void
sys_cputs(const char *s, size_t len)
{
  800fbc:	55                   	push   %ebp
  800fbd:	89 e5                	mov    %esp,%ebp
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	89 1c 24             	mov    %ebx,(%esp)
  800fc5:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  800fc9:	b8 00 00 00 00       	mov    $0x0,%eax
  800fce:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800fd1:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd4:	89 c3                	mov    %eax,%ebx
  800fd6:	89 c7                	mov    %eax,%edi
  800fd8:	51                   	push   %ecx
  800fd9:	52                   	push   %edx
  800fda:	53                   	push   %ebx
  800fdb:	54                   	push   %esp
  800fdc:	55                   	push   %ebp
  800fdd:	56                   	push   %esi
  800fde:	57                   	push   %edi
  800fdf:	54                   	push   %esp
  800fe0:	5d                   	pop    %ebp
  800fe1:	8d 35 e9 0f 80 00    	lea    0x800fe9,%esi
  800fe7:	0f 34                	sysenter 
  800fe9:	5f                   	pop    %edi
  800fea:	5e                   	pop    %esi
  800feb:	5d                   	pop    %ebp
  800fec:	5c                   	pop    %esp
  800fed:	5b                   	pop    %ebx
  800fee:	5a                   	pop    %edx
  800fef:	59                   	pop    %ecx

void
sys_cputs(const char *s, size_t len)
{
	syscall(SYS_cputs, 0, (uint32_t)s, len, 0, 0, 0);
}
  800ff0:	8b 1c 24             	mov    (%esp),%ebx
  800ff3:	8b 7c 24 04          	mov    0x4(%esp),%edi
  800ff7:	89 ec                	mov    %ebp,%esp
  800ff9:	5d                   	pop    %ebp
  800ffa:	c3                   	ret    

00800ffb <sys_env_set_prior>:
{
	 return syscall(SYS_sbrk, 0, (uint32_t)inc, (uint32_t)0, 0, 0, 0);
}

int 
sys_env_set_prior(envid_t envid, uint32_t prior){
  800ffb:	55                   	push   %ebp
  800ffc:	89 e5                	mov    %esp,%ebp
  800ffe:	83 ec 28             	sub    $0x28,%esp
  801001:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  801004:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801007:	bb 00 00 00 00       	mov    $0x0,%ebx
  80100c:	b8 0e 00 00 00       	mov    $0xe,%eax
  801011:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801014:	8b 55 08             	mov    0x8(%ebp),%edx
  801017:	89 df                	mov    %ebx,%edi
  801019:	51                   	push   %ecx
  80101a:	52                   	push   %edx
  80101b:	53                   	push   %ebx
  80101c:	54                   	push   %esp
  80101d:	55                   	push   %ebp
  80101e:	56                   	push   %esi
  80101f:	57                   	push   %edi
  801020:	54                   	push   %esp
  801021:	5d                   	pop    %ebp
  801022:	8d 35 2a 10 80 00    	lea    0x80102a,%esi
  801028:	0f 34                	sysenter 
  80102a:	5f                   	pop    %edi
  80102b:	5e                   	pop    %esi
  80102c:	5d                   	pop    %ebp
  80102d:	5c                   	pop    %esp
  80102e:	5b                   	pop    %ebx
  80102f:	5a                   	pop    %edx
  801030:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  801031:	85 c0                	test   %eax,%eax
  801033:	7e 28                	jle    80105d <sys_env_set_prior+0x62>
		panic("syscall %d returned %d (> 0)", num, ret);
  801035:	89 44 24 10          	mov    %eax,0x10(%esp)
  801039:	c7 44 24 0c 0e 00 00 	movl   $0xe,0xc(%esp)
  801040:	00 
  801041:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  801048:	00 
  801049:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  801050:	00 
  801051:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  801058:	e8 27 f1 ff ff       	call   800184 <_panic>
}

int 
sys_env_set_prior(envid_t envid, uint32_t prior){
         return syscall(SYS_env_set_prior,1,envid, prior, 0, 0, 0);
}
  80105d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  801060:	8b 7d fc             	mov    -0x4(%ebp),%edi
  801063:	89 ec                	mov    %ebp,%esp
  801065:	5d                   	pop    %ebp
  801066:	c3                   	ret    

00801067 <sys_sbrk>:
	return syscall(SYS_ipc_recv, 1, (uint32_t)dstva, 0, 0, 0, 0);
}

int
sys_sbrk(uint32_t inc)
{
  801067:	55                   	push   %ebp
  801068:	89 e5                	mov    %esp,%ebp
  80106a:	83 ec 08             	sub    $0x8,%esp
  80106d:	89 1c 24             	mov    %ebx,(%esp)
  801070:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801074:	b9 00 00 00 00       	mov    $0x0,%ecx
  801079:	b8 0f 00 00 00       	mov    $0xf,%eax
  80107e:	8b 55 08             	mov    0x8(%ebp),%edx
  801081:	89 cb                	mov    %ecx,%ebx
  801083:	89 cf                	mov    %ecx,%edi
  801085:	51                   	push   %ecx
  801086:	52                   	push   %edx
  801087:	53                   	push   %ebx
  801088:	54                   	push   %esp
  801089:	55                   	push   %ebp
  80108a:	56                   	push   %esi
  80108b:	57                   	push   %edi
  80108c:	54                   	push   %esp
  80108d:	5d                   	pop    %ebp
  80108e:	8d 35 96 10 80 00    	lea    0x801096,%esi
  801094:	0f 34                	sysenter 
  801096:	5f                   	pop    %edi
  801097:	5e                   	pop    %esi
  801098:	5d                   	pop    %ebp
  801099:	5c                   	pop    %esp
  80109a:	5b                   	pop    %ebx
  80109b:	5a                   	pop    %edx
  80109c:	59                   	pop    %ecx

int
sys_sbrk(uint32_t inc)
{
	 return syscall(SYS_sbrk, 0, (uint32_t)inc, (uint32_t)0, 0, 0, 0);
}
  80109d:	8b 1c 24             	mov    (%esp),%ebx
  8010a0:	8b 7c 24 04          	mov    0x4(%esp),%edi
  8010a4:	89 ec                	mov    %ebp,%esp
  8010a6:	5d                   	pop    %ebp
  8010a7:	c3                   	ret    

008010a8 <sys_ipc_recv>:
	return syscall(SYS_ipc_try_send, 0, envid, value, (uint32_t) srcva, perm, 0);
}

int
sys_ipc_recv(void *dstva)
{
  8010a8:	55                   	push   %ebp
  8010a9:	89 e5                	mov    %esp,%ebp
  8010ab:	83 ec 28             	sub    $0x28,%esp
  8010ae:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  8010b1:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  8010b4:	b9 00 00 00 00       	mov    $0x0,%ecx
  8010b9:	b8 0d 00 00 00       	mov    $0xd,%eax
  8010be:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c1:	89 cb                	mov    %ecx,%ebx
  8010c3:	89 cf                	mov    %ecx,%edi
  8010c5:	51                   	push   %ecx
  8010c6:	52                   	push   %edx
  8010c7:	53                   	push   %ebx
  8010c8:	54                   	push   %esp
  8010c9:	55                   	push   %ebp
  8010ca:	56                   	push   %esi
  8010cb:	57                   	push   %edi
  8010cc:	54                   	push   %esp
  8010cd:	5d                   	pop    %ebp
  8010ce:	8d 35 d6 10 80 00    	lea    0x8010d6,%esi
  8010d4:	0f 34                	sysenter 
  8010d6:	5f                   	pop    %edi
  8010d7:	5e                   	pop    %esi
  8010d8:	5d                   	pop    %ebp
  8010d9:	5c                   	pop    %esp
  8010da:	5b                   	pop    %ebx
  8010db:	5a                   	pop    %edx
  8010dc:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  8010dd:	85 c0                	test   %eax,%eax
  8010df:	7e 28                	jle    801109 <sys_ipc_recv+0x61>
		panic("syscall %d returned %d (> 0)", num, ret);
  8010e1:	89 44 24 10          	mov    %eax,0x10(%esp)
  8010e5:	c7 44 24 0c 0d 00 00 	movl   $0xd,0xc(%esp)
  8010ec:	00 
  8010ed:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  8010f4:	00 
  8010f5:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  8010fc:	00 
  8010fd:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  801104:	e8 7b f0 ff ff       	call   800184 <_panic>

int
sys_ipc_recv(void *dstva)
{
	return syscall(SYS_ipc_recv, 1, (uint32_t)dstva, 0, 0, 0, 0);
}
  801109:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  80110c:	8b 7d fc             	mov    -0x4(%ebp),%edi
  80110f:	89 ec                	mov    %ebp,%esp
  801111:	5d                   	pop    %ebp
  801112:	c3                   	ret    

00801113 <sys_ipc_try_send>:
	return syscall(SYS_env_set_pgfault_upcall, 1, envid, (uint32_t) upcall, 0, 0, 0);
}

int
sys_ipc_try_send(envid_t envid, uint32_t value, void *srcva, int perm)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 08             	sub    $0x8,%esp
  801119:	89 1c 24             	mov    %ebx,(%esp)
  80111c:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801120:	b8 0c 00 00 00       	mov    $0xc,%eax
  801125:	8b 7d 14             	mov    0x14(%ebp),%edi
  801128:	8b 5d 10             	mov    0x10(%ebp),%ebx
  80112b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80112e:	8b 55 08             	mov    0x8(%ebp),%edx
  801131:	51                   	push   %ecx
  801132:	52                   	push   %edx
  801133:	53                   	push   %ebx
  801134:	54                   	push   %esp
  801135:	55                   	push   %ebp
  801136:	56                   	push   %esi
  801137:	57                   	push   %edi
  801138:	54                   	push   %esp
  801139:	5d                   	pop    %ebp
  80113a:	8d 35 42 11 80 00    	lea    0x801142,%esi
  801140:	0f 34                	sysenter 
  801142:	5f                   	pop    %edi
  801143:	5e                   	pop    %esi
  801144:	5d                   	pop    %ebp
  801145:	5c                   	pop    %esp
  801146:	5b                   	pop    %ebx
  801147:	5a                   	pop    %edx
  801148:	59                   	pop    %ecx

int
sys_ipc_try_send(envid_t envid, uint32_t value, void *srcva, int perm)
{
	return syscall(SYS_ipc_try_send, 0, envid, value, (uint32_t) srcva, perm, 0);
}
  801149:	8b 1c 24             	mov    (%esp),%ebx
  80114c:	8b 7c 24 04          	mov    0x4(%esp),%edi
  801150:	89 ec                	mov    %ebp,%esp
  801152:	5d                   	pop    %ebp
  801153:	c3                   	ret    

00801154 <sys_env_set_pgfault_upcall>:
	return syscall(SYS_env_set_status, 1, envid, status, 0, 0, 0);
}

int
sys_env_set_pgfault_upcall(envid_t envid, void *upcall)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	83 ec 28             	sub    $0x28,%esp
  80115a:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  80115d:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801160:	bb 00 00 00 00       	mov    $0x0,%ebx
  801165:	b8 0a 00 00 00       	mov    $0xa,%eax
  80116a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80116d:	8b 55 08             	mov    0x8(%ebp),%edx
  801170:	89 df                	mov    %ebx,%edi
  801172:	51                   	push   %ecx
  801173:	52                   	push   %edx
  801174:	53                   	push   %ebx
  801175:	54                   	push   %esp
  801176:	55                   	push   %ebp
  801177:	56                   	push   %esi
  801178:	57                   	push   %edi
  801179:	54                   	push   %esp
  80117a:	5d                   	pop    %ebp
  80117b:	8d 35 83 11 80 00    	lea    0x801183,%esi
  801181:	0f 34                	sysenter 
  801183:	5f                   	pop    %edi
  801184:	5e                   	pop    %esi
  801185:	5d                   	pop    %ebp
  801186:	5c                   	pop    %esp
  801187:	5b                   	pop    %ebx
  801188:	5a                   	pop    %edx
  801189:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  80118a:	85 c0                	test   %eax,%eax
  80118c:	7e 28                	jle    8011b6 <sys_env_set_pgfault_upcall+0x62>
		panic("syscall %d returned %d (> 0)", num, ret);
  80118e:	89 44 24 10          	mov    %eax,0x10(%esp)
  801192:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
  801199:	00 
  80119a:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  8011a1:	00 
  8011a2:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  8011a9:	00 
  8011aa:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  8011b1:	e8 ce ef ff ff       	call   800184 <_panic>

int
sys_env_set_pgfault_upcall(envid_t envid, void *upcall)
{
	return syscall(SYS_env_set_pgfault_upcall, 1, envid, (uint32_t) upcall, 0, 0, 0);
}
  8011b6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  8011b9:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8011bc:	89 ec                	mov    %ebp,%esp
  8011be:	5d                   	pop    %ebp
  8011bf:	c3                   	ret    

008011c0 <sys_env_set_status>:

// sys_exofork is inlined in lib.h

int
sys_env_set_status(envid_t envid, int status)
{
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
  8011c3:	83 ec 28             	sub    $0x28,%esp
  8011c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  8011c9:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  8011cc:	bb 00 00 00 00       	mov    $0x0,%ebx
  8011d1:	b8 09 00 00 00       	mov    $0x9,%eax
  8011d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8011d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8011dc:	89 df                	mov    %ebx,%edi
  8011de:	51                   	push   %ecx
  8011df:	52                   	push   %edx
  8011e0:	53                   	push   %ebx
  8011e1:	54                   	push   %esp
  8011e2:	55                   	push   %ebp
  8011e3:	56                   	push   %esi
  8011e4:	57                   	push   %edi
  8011e5:	54                   	push   %esp
  8011e6:	5d                   	pop    %ebp
  8011e7:	8d 35 ef 11 80 00    	lea    0x8011ef,%esi
  8011ed:	0f 34                	sysenter 
  8011ef:	5f                   	pop    %edi
  8011f0:	5e                   	pop    %esi
  8011f1:	5d                   	pop    %ebp
  8011f2:	5c                   	pop    %esp
  8011f3:	5b                   	pop    %ebx
  8011f4:	5a                   	pop    %edx
  8011f5:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  8011f6:	85 c0                	test   %eax,%eax
  8011f8:	7e 28                	jle    801222 <sys_env_set_status+0x62>
		panic("syscall %d returned %d (> 0)", num, ret);
  8011fa:	89 44 24 10          	mov    %eax,0x10(%esp)
  8011fe:	c7 44 24 0c 09 00 00 	movl   $0x9,0xc(%esp)
  801205:	00 
  801206:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  80120d:	00 
  80120e:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  801215:	00 
  801216:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  80121d:	e8 62 ef ff ff       	call   800184 <_panic>

int
sys_env_set_status(envid_t envid, int status)
{
	return syscall(SYS_env_set_status, 1, envid, status, 0, 0, 0);
}
  801222:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  801225:	8b 7d fc             	mov    -0x4(%ebp),%edi
  801228:	89 ec                	mov    %ebp,%esp
  80122a:	5d                   	pop    %ebp
  80122b:	c3                   	ret    

0080122c <sys_page_unmap>:
	return syscall(SYS_page_map, 1, srcenv, (uint32_t) srcva, dstenv, ((uint32_t) dstva)|perm, perm);
}

int
sys_page_unmap(envid_t envid, void *va)
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
  80122f:	83 ec 28             	sub    $0x28,%esp
  801232:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  801235:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801238:	bb 00 00 00 00       	mov    $0x0,%ebx
  80123d:	b8 07 00 00 00       	mov    $0x7,%eax
  801242:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801245:	8b 55 08             	mov    0x8(%ebp),%edx
  801248:	89 df                	mov    %ebx,%edi
  80124a:	51                   	push   %ecx
  80124b:	52                   	push   %edx
  80124c:	53                   	push   %ebx
  80124d:	54                   	push   %esp
  80124e:	55                   	push   %ebp
  80124f:	56                   	push   %esi
  801250:	57                   	push   %edi
  801251:	54                   	push   %esp
  801252:	5d                   	pop    %ebp
  801253:	8d 35 5b 12 80 00    	lea    0x80125b,%esi
  801259:	0f 34                	sysenter 
  80125b:	5f                   	pop    %edi
  80125c:	5e                   	pop    %esi
  80125d:	5d                   	pop    %ebp
  80125e:	5c                   	pop    %esp
  80125f:	5b                   	pop    %ebx
  801260:	5a                   	pop    %edx
  801261:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  801262:	85 c0                	test   %eax,%eax
  801264:	7e 28                	jle    80128e <sys_page_unmap+0x62>
		panic("syscall %d returned %d (> 0)", num, ret);
  801266:	89 44 24 10          	mov    %eax,0x10(%esp)
  80126a:	c7 44 24 0c 07 00 00 	movl   $0x7,0xc(%esp)
  801271:	00 
  801272:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  801279:	00 
  80127a:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  801281:	00 
  801282:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  801289:	e8 f6 ee ff ff       	call   800184 <_panic>

int
sys_page_unmap(envid_t envid, void *va)
{
	return syscall(SYS_page_unmap, 1, envid, (uint32_t) va, 0, 0, 0);
}
  80128e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  801291:	8b 7d fc             	mov    -0x4(%ebp),%edi
  801294:	89 ec                	mov    %ebp,%esp
  801296:	5d                   	pop    %ebp
  801297:	c3                   	ret    

00801298 <sys_page_map>:
	return syscall(SYS_page_alloc, 1, envid, (uint32_t) va, perm, 0, 0);
}

int
sys_page_map(envid_t srcenv, void *srcva, envid_t dstenv, void *dstva, int perm)
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
  80129b:	83 ec 28             	sub    $0x28,%esp
  80129e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  8012a1:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  8012a4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a7:	0b 7d 14             	or     0x14(%ebp),%edi
  8012aa:	b8 06 00 00 00       	mov    $0x6,%eax
  8012af:	8b 5d 10             	mov    0x10(%ebp),%ebx
  8012b2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8012b5:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b8:	51                   	push   %ecx
  8012b9:	52                   	push   %edx
  8012ba:	53                   	push   %ebx
  8012bb:	54                   	push   %esp
  8012bc:	55                   	push   %ebp
  8012bd:	56                   	push   %esi
  8012be:	57                   	push   %edi
  8012bf:	54                   	push   %esp
  8012c0:	5d                   	pop    %ebp
  8012c1:	8d 35 c9 12 80 00    	lea    0x8012c9,%esi
  8012c7:	0f 34                	sysenter 
  8012c9:	5f                   	pop    %edi
  8012ca:	5e                   	pop    %esi
  8012cb:	5d                   	pop    %ebp
  8012cc:	5c                   	pop    %esp
  8012cd:	5b                   	pop    %ebx
  8012ce:	5a                   	pop    %edx
  8012cf:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  8012d0:	85 c0                	test   %eax,%eax
  8012d2:	7e 28                	jle    8012fc <sys_page_map+0x64>
		panic("syscall %d returned %d (> 0)", num, ret);
  8012d4:	89 44 24 10          	mov    %eax,0x10(%esp)
  8012d8:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
  8012df:	00 
  8012e0:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  8012e7:	00 
  8012e8:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  8012ef:	00 
  8012f0:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  8012f7:	e8 88 ee ff ff       	call   800184 <_panic>

int
sys_page_map(envid_t srcenv, void *srcva, envid_t dstenv, void *dstva, int perm)
{
	return syscall(SYS_page_map, 1, srcenv, (uint32_t) srcva, dstenv, ((uint32_t) dstva)|perm, perm);
}
  8012fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  8012ff:	8b 7d fc             	mov    -0x4(%ebp),%edi
  801302:	89 ec                	mov    %ebp,%esp
  801304:	5d                   	pop    %ebp
  801305:	c3                   	ret    

00801306 <sys_page_alloc>:
	syscall(SYS_yield, 0, 0, 0, 0, 0, 0);
}

int
sys_page_alloc(envid_t envid, void *va, int perm)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 28             	sub    $0x28,%esp
  80130c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  80130f:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801312:	bf 00 00 00 00       	mov    $0x0,%edi
  801317:	b8 05 00 00 00       	mov    $0x5,%eax
  80131c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  80131f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801322:	8b 55 08             	mov    0x8(%ebp),%edx
  801325:	51                   	push   %ecx
  801326:	52                   	push   %edx
  801327:	53                   	push   %ebx
  801328:	54                   	push   %esp
  801329:	55                   	push   %ebp
  80132a:	56                   	push   %esi
  80132b:	57                   	push   %edi
  80132c:	54                   	push   %esp
  80132d:	5d                   	pop    %ebp
  80132e:	8d 35 36 13 80 00    	lea    0x801336,%esi
  801334:	0f 34                	sysenter 
  801336:	5f                   	pop    %edi
  801337:	5e                   	pop    %esi
  801338:	5d                   	pop    %ebp
  801339:	5c                   	pop    %esp
  80133a:	5b                   	pop    %ebx
  80133b:	5a                   	pop    %edx
  80133c:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  80133d:	85 c0                	test   %eax,%eax
  80133f:	7e 28                	jle    801369 <sys_page_alloc+0x63>
		panic("syscall %d returned %d (> 0)", num, ret);
  801341:	89 44 24 10          	mov    %eax,0x10(%esp)
  801345:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  80134c:	00 
  80134d:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  801354:	00 
  801355:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  80135c:	00 
  80135d:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  801364:	e8 1b ee ff ff       	call   800184 <_panic>

int
sys_page_alloc(envid_t envid, void *va, int perm)
{
	return syscall(SYS_page_alloc, 1, envid, (uint32_t) va, perm, 0, 0);
}
  801369:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  80136c:	8b 7d fc             	mov    -0x4(%ebp),%edi
  80136f:	89 ec                	mov    %ebp,%esp
  801371:	5d                   	pop    %ebp
  801372:	c3                   	ret    

00801373 <sys_yield>:
	 return syscall(SYS_map_kernel_page, 0, (uint32_t)kpage, (uint32_t)va, 0, 0, 0);
}

void
sys_yield(void)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
  801376:	83 ec 08             	sub    $0x8,%esp
  801379:	89 1c 24             	mov    %ebx,(%esp)
  80137c:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801380:	ba 00 00 00 00       	mov    $0x0,%edx
  801385:	b8 0b 00 00 00       	mov    $0xb,%eax
  80138a:	89 d1                	mov    %edx,%ecx
  80138c:	89 d3                	mov    %edx,%ebx
  80138e:	89 d7                	mov    %edx,%edi
  801390:	51                   	push   %ecx
  801391:	52                   	push   %edx
  801392:	53                   	push   %ebx
  801393:	54                   	push   %esp
  801394:	55                   	push   %ebp
  801395:	56                   	push   %esi
  801396:	57                   	push   %edi
  801397:	54                   	push   %esp
  801398:	5d                   	pop    %ebp
  801399:	8d 35 a1 13 80 00    	lea    0x8013a1,%esi
  80139f:	0f 34                	sysenter 
  8013a1:	5f                   	pop    %edi
  8013a2:	5e                   	pop    %esi
  8013a3:	5d                   	pop    %ebp
  8013a4:	5c                   	pop    %esp
  8013a5:	5b                   	pop    %ebx
  8013a6:	5a                   	pop    %edx
  8013a7:	59                   	pop    %ecx

void
sys_yield(void)
{
	syscall(SYS_yield, 0, 0, 0, 0, 0, 0);
}
  8013a8:	8b 1c 24             	mov    (%esp),%ebx
  8013ab:	8b 7c 24 04          	mov    0x4(%esp),%edi
  8013af:	89 ec                	mov    %ebp,%esp
  8013b1:	5d                   	pop    %ebp
  8013b2:	c3                   	ret    

008013b3 <sys_map_kernel_page>:
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0, 0);
}

int
sys_map_kernel_page(void* kpage, void* va)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
  8013b6:	83 ec 08             	sub    $0x8,%esp
  8013b9:	89 1c 24             	mov    %ebx,(%esp)
  8013bc:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  8013c0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8013c5:	b8 04 00 00 00       	mov    $0x4,%eax
  8013ca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8013cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8013d0:	89 df                	mov    %ebx,%edi
  8013d2:	51                   	push   %ecx
  8013d3:	52                   	push   %edx
  8013d4:	53                   	push   %ebx
  8013d5:	54                   	push   %esp
  8013d6:	55                   	push   %ebp
  8013d7:	56                   	push   %esi
  8013d8:	57                   	push   %edi
  8013d9:	54                   	push   %esp
  8013da:	5d                   	pop    %ebp
  8013db:	8d 35 e3 13 80 00    	lea    0x8013e3,%esi
  8013e1:	0f 34                	sysenter 
  8013e3:	5f                   	pop    %edi
  8013e4:	5e                   	pop    %esi
  8013e5:	5d                   	pop    %ebp
  8013e6:	5c                   	pop    %esp
  8013e7:	5b                   	pop    %ebx
  8013e8:	5a                   	pop    %edx
  8013e9:	59                   	pop    %ecx

int
sys_map_kernel_page(void* kpage, void* va)
{
	 return syscall(SYS_map_kernel_page, 0, (uint32_t)kpage, (uint32_t)va, 0, 0, 0);
}
  8013ea:	8b 1c 24             	mov    (%esp),%ebx
  8013ed:	8b 7c 24 04          	mov    0x4(%esp),%edi
  8013f1:	89 ec                	mov    %ebp,%esp
  8013f3:	5d                   	pop    %ebp
  8013f4:	c3                   	ret    

008013f5 <sys_getenvid>:
	return syscall(SYS_env_destroy, 1, envid, 0, 0, 0, 0);
}

envid_t
sys_getenvid(void)
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
  8013f8:	83 ec 08             	sub    $0x8,%esp
  8013fb:	89 1c 24             	mov    %ebx,(%esp)
  8013fe:	89 7c 24 04          	mov    %edi,0x4(%esp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801402:	ba 00 00 00 00       	mov    $0x0,%edx
  801407:	b8 02 00 00 00       	mov    $0x2,%eax
  80140c:	89 d1                	mov    %edx,%ecx
  80140e:	89 d3                	mov    %edx,%ebx
  801410:	89 d7                	mov    %edx,%edi
  801412:	51                   	push   %ecx
  801413:	52                   	push   %edx
  801414:	53                   	push   %ebx
  801415:	54                   	push   %esp
  801416:	55                   	push   %ebp
  801417:	56                   	push   %esi
  801418:	57                   	push   %edi
  801419:	54                   	push   %esp
  80141a:	5d                   	pop    %ebp
  80141b:	8d 35 23 14 80 00    	lea    0x801423,%esi
  801421:	0f 34                	sysenter 
  801423:	5f                   	pop    %edi
  801424:	5e                   	pop    %esi
  801425:	5d                   	pop    %ebp
  801426:	5c                   	pop    %esp
  801427:	5b                   	pop    %ebx
  801428:	5a                   	pop    %edx
  801429:	59                   	pop    %ecx

envid_t
sys_getenvid(void)
{
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0, 0);
}
  80142a:	8b 1c 24             	mov    (%esp),%ebx
  80142d:	8b 7c 24 04          	mov    0x4(%esp),%edi
  801431:	89 ec                	mov    %ebp,%esp
  801433:	5d                   	pop    %ebp
  801434:	c3                   	ret    

00801435 <sys_env_destroy>:
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0, 0);
}

int
sys_env_destroy(envid_t envid)
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
  801438:	83 ec 28             	sub    $0x28,%esp
  80143b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  80143e:	89 7d fc             	mov    %edi,-0x4(%ebp)

static inline int32_t
syscall(int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret;
	asm volatile("pushl %%ecx\n\t"
  801441:	b9 00 00 00 00       	mov    $0x0,%ecx
  801446:	b8 03 00 00 00       	mov    $0x3,%eax
  80144b:	8b 55 08             	mov    0x8(%ebp),%edx
  80144e:	89 cb                	mov    %ecx,%ebx
  801450:	89 cf                	mov    %ecx,%edi
  801452:	51                   	push   %ecx
  801453:	52                   	push   %edx
  801454:	53                   	push   %ebx
  801455:	54                   	push   %esp
  801456:	55                   	push   %ebp
  801457:	56                   	push   %esi
  801458:	57                   	push   %edi
  801459:	54                   	push   %esp
  80145a:	5d                   	pop    %ebp
  80145b:	8d 35 63 14 80 00    	lea    0x801463,%esi
  801461:	0f 34                	sysenter 
  801463:	5f                   	pop    %edi
  801464:	5e                   	pop    %esi
  801465:	5d                   	pop    %ebp
  801466:	5c                   	pop    %esp
  801467:	5b                   	pop    %ebx
  801468:	5a                   	pop    %edx
  801469:	59                   	pop    %ecx
                   "d" (a1),
                   "c" (a2),
                   "b" (a3),
                   "D" (a4)
                 : "cc", "memory");
	if(check && ret > 0)
  80146a:	85 c0                	test   %eax,%eax
  80146c:	7e 28                	jle    801496 <sys_env_destroy+0x61>
		panic("syscall %d returned %d (> 0)", num, ret);
  80146e:	89 44 24 10          	mov    %eax,0x10(%esp)
  801472:	c7 44 24 0c 03 00 00 	movl   $0x3,0xc(%esp)
  801479:	00 
  80147a:	c7 44 24 08 e4 1a 80 	movl   $0x801ae4,0x8(%esp)
  801481:	00 
  801482:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  801489:	00 
  80148a:	c7 04 24 01 1b 80 00 	movl   $0x801b01,(%esp)
  801491:	e8 ee ec ff ff       	call   800184 <_panic>

int
sys_env_destroy(envid_t envid)
{
	return syscall(SYS_env_destroy, 1, envid, 0, 0, 0, 0);
}
  801496:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  801499:	8b 7d fc             	mov    -0x4(%ebp),%edi
  80149c:	89 ec                	mov    %ebp,%esp
  80149e:	5d                   	pop    %ebp
  80149f:	c3                   	ret    

008014a0 <__udivdi3>:
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
  8014a3:	57                   	push   %edi
  8014a4:	56                   	push   %esi
  8014a5:	83 ec 10             	sub    $0x10,%esp
  8014a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ae:	8b 75 10             	mov    0x10(%ebp),%esi
  8014b1:	8b 7d 0c             	mov    0xc(%ebp),%edi
  8014b4:	85 c0                	test   %eax,%eax
  8014b6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8014b9:	75 35                	jne    8014f0 <__udivdi3+0x50>
  8014bb:	39 fe                	cmp    %edi,%esi
  8014bd:	77 61                	ja     801520 <__udivdi3+0x80>
  8014bf:	85 f6                	test   %esi,%esi
  8014c1:	75 0b                	jne    8014ce <__udivdi3+0x2e>
  8014c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8014c8:	31 d2                	xor    %edx,%edx
  8014ca:	f7 f6                	div    %esi
  8014cc:	89 c6                	mov    %eax,%esi
  8014ce:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014d1:	31 d2                	xor    %edx,%edx
  8014d3:	89 f8                	mov    %edi,%eax
  8014d5:	f7 f6                	div    %esi
  8014d7:	89 c7                	mov    %eax,%edi
  8014d9:	89 c8                	mov    %ecx,%eax
  8014db:	f7 f6                	div    %esi
  8014dd:	89 c1                	mov    %eax,%ecx
  8014df:	89 fa                	mov    %edi,%edx
  8014e1:	89 c8                	mov    %ecx,%eax
  8014e3:	83 c4 10             	add    $0x10,%esp
  8014e6:	5e                   	pop    %esi
  8014e7:	5f                   	pop    %edi
  8014e8:	5d                   	pop    %ebp
  8014e9:	c3                   	ret    
  8014ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8014f0:	39 f8                	cmp    %edi,%eax
  8014f2:	77 1c                	ja     801510 <__udivdi3+0x70>
  8014f4:	0f bd d0             	bsr    %eax,%edx
  8014f7:	83 f2 1f             	xor    $0x1f,%edx
  8014fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8014fd:	75 39                	jne    801538 <__udivdi3+0x98>
  8014ff:	3b 75 f0             	cmp    -0x10(%ebp),%esi
  801502:	0f 86 a0 00 00 00    	jbe    8015a8 <__udivdi3+0x108>
  801508:	39 f8                	cmp    %edi,%eax
  80150a:	0f 82 98 00 00 00    	jb     8015a8 <__udivdi3+0x108>
  801510:	31 ff                	xor    %edi,%edi
  801512:	31 c9                	xor    %ecx,%ecx
  801514:	89 c8                	mov    %ecx,%eax
  801516:	89 fa                	mov    %edi,%edx
  801518:	83 c4 10             	add    $0x10,%esp
  80151b:	5e                   	pop    %esi
  80151c:	5f                   	pop    %edi
  80151d:	5d                   	pop    %ebp
  80151e:	c3                   	ret    
  80151f:	90                   	nop
  801520:	89 d1                	mov    %edx,%ecx
  801522:	89 fa                	mov    %edi,%edx
  801524:	89 c8                	mov    %ecx,%eax
  801526:	31 ff                	xor    %edi,%edi
  801528:	f7 f6                	div    %esi
  80152a:	89 c1                	mov    %eax,%ecx
  80152c:	89 fa                	mov    %edi,%edx
  80152e:	89 c8                	mov    %ecx,%eax
  801530:	83 c4 10             	add    $0x10,%esp
  801533:	5e                   	pop    %esi
  801534:	5f                   	pop    %edi
  801535:	5d                   	pop    %ebp
  801536:	c3                   	ret    
  801537:	90                   	nop
  801538:	0f b6 4d f4          	movzbl -0xc(%ebp),%ecx
  80153c:	89 f2                	mov    %esi,%edx
  80153e:	d3 e0                	shl    %cl,%eax
  801540:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801543:	b8 20 00 00 00       	mov    $0x20,%eax
  801548:	2b 45 f4             	sub    -0xc(%ebp),%eax
  80154b:	89 c1                	mov    %eax,%ecx
  80154d:	d3 ea                	shr    %cl,%edx
  80154f:	0f b6 4d f4          	movzbl -0xc(%ebp),%ecx
  801553:	0b 55 ec             	or     -0x14(%ebp),%edx
  801556:	d3 e6                	shl    %cl,%esi
  801558:	89 c1                	mov    %eax,%ecx
  80155a:	89 75 e8             	mov    %esi,-0x18(%ebp)
  80155d:	89 fe                	mov    %edi,%esi
  80155f:	d3 ee                	shr    %cl,%esi
  801561:	0f b6 4d f4          	movzbl -0xc(%ebp),%ecx
  801565:	89 55 ec             	mov    %edx,-0x14(%ebp)
  801568:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80156b:	d3 e7                	shl    %cl,%edi
  80156d:	89 c1                	mov    %eax,%ecx
  80156f:	d3 ea                	shr    %cl,%edx
  801571:	09 d7                	or     %edx,%edi
  801573:	89 f2                	mov    %esi,%edx
  801575:	89 f8                	mov    %edi,%eax
  801577:	f7 75 ec             	divl   -0x14(%ebp)
  80157a:	89 d6                	mov    %edx,%esi
  80157c:	89 c7                	mov    %eax,%edi
  80157e:	f7 65 e8             	mull   -0x18(%ebp)
  801581:	39 d6                	cmp    %edx,%esi
  801583:	89 55 ec             	mov    %edx,-0x14(%ebp)
  801586:	72 30                	jb     8015b8 <__udivdi3+0x118>
  801588:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80158b:	0f b6 4d f4          	movzbl -0xc(%ebp),%ecx
  80158f:	d3 e2                	shl    %cl,%edx
  801591:	39 c2                	cmp    %eax,%edx
  801593:	73 05                	jae    80159a <__udivdi3+0xfa>
  801595:	3b 75 ec             	cmp    -0x14(%ebp),%esi
  801598:	74 1e                	je     8015b8 <__udivdi3+0x118>
  80159a:	89 f9                	mov    %edi,%ecx
  80159c:	31 ff                	xor    %edi,%edi
  80159e:	e9 71 ff ff ff       	jmp    801514 <__udivdi3+0x74>
  8015a3:	90                   	nop
  8015a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  8015a8:	31 ff                	xor    %edi,%edi
  8015aa:	b9 01 00 00 00       	mov    $0x1,%ecx
  8015af:	e9 60 ff ff ff       	jmp    801514 <__udivdi3+0x74>
  8015b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  8015b8:	8d 4f ff             	lea    -0x1(%edi),%ecx
  8015bb:	31 ff                	xor    %edi,%edi
  8015bd:	89 c8                	mov    %ecx,%eax
  8015bf:	89 fa                	mov    %edi,%edx
  8015c1:	83 c4 10             	add    $0x10,%esp
  8015c4:	5e                   	pop    %esi
  8015c5:	5f                   	pop    %edi
  8015c6:	5d                   	pop    %ebp
  8015c7:	c3                   	ret    
	...

008015d0 <__umoddi3>:
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	57                   	push   %edi
  8015d4:	56                   	push   %esi
  8015d5:	83 ec 20             	sub    $0x20,%esp
  8015d8:	8b 55 14             	mov    0x14(%ebp),%edx
  8015db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015de:	8b 7d 10             	mov    0x10(%ebp),%edi
  8015e1:	8b 75 0c             	mov    0xc(%ebp),%esi
  8015e4:	85 d2                	test   %edx,%edx
  8015e6:	89 c8                	mov    %ecx,%eax
  8015e8:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8015eb:	75 13                	jne    801600 <__umoddi3+0x30>
  8015ed:	39 f7                	cmp    %esi,%edi
  8015ef:	76 3f                	jbe    801630 <__umoddi3+0x60>
  8015f1:	89 f2                	mov    %esi,%edx
  8015f3:	f7 f7                	div    %edi
  8015f5:	89 d0                	mov    %edx,%eax
  8015f7:	31 d2                	xor    %edx,%edx
  8015f9:	83 c4 20             	add    $0x20,%esp
  8015fc:	5e                   	pop    %esi
  8015fd:	5f                   	pop    %edi
  8015fe:	5d                   	pop    %ebp
  8015ff:	c3                   	ret    
  801600:	39 f2                	cmp    %esi,%edx
  801602:	77 4c                	ja     801650 <__umoddi3+0x80>
  801604:	0f bd ca             	bsr    %edx,%ecx
  801607:	83 f1 1f             	xor    $0x1f,%ecx
  80160a:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  80160d:	75 51                	jne    801660 <__umoddi3+0x90>
  80160f:	3b 7d f4             	cmp    -0xc(%ebp),%edi
  801612:	0f 87 e0 00 00 00    	ja     8016f8 <__umoddi3+0x128>
  801618:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80161b:	29 f8                	sub    %edi,%eax
  80161d:	19 d6                	sbb    %edx,%esi
  80161f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801622:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801625:	89 f2                	mov    %esi,%edx
  801627:	83 c4 20             	add    $0x20,%esp
  80162a:	5e                   	pop    %esi
  80162b:	5f                   	pop    %edi
  80162c:	5d                   	pop    %ebp
  80162d:	c3                   	ret    
  80162e:	66 90                	xchg   %ax,%ax
  801630:	85 ff                	test   %edi,%edi
  801632:	75 0b                	jne    80163f <__umoddi3+0x6f>
  801634:	b8 01 00 00 00       	mov    $0x1,%eax
  801639:	31 d2                	xor    %edx,%edx
  80163b:	f7 f7                	div    %edi
  80163d:	89 c7                	mov    %eax,%edi
  80163f:	89 f0                	mov    %esi,%eax
  801641:	31 d2                	xor    %edx,%edx
  801643:	f7 f7                	div    %edi
  801645:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801648:	f7 f7                	div    %edi
  80164a:	eb a9                	jmp    8015f5 <__umoddi3+0x25>
  80164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  801650:	89 c8                	mov    %ecx,%eax
  801652:	89 f2                	mov    %esi,%edx
  801654:	83 c4 20             	add    $0x20,%esp
  801657:	5e                   	pop    %esi
  801658:	5f                   	pop    %edi
  801659:	5d                   	pop    %ebp
  80165a:	c3                   	ret    
  80165b:	90                   	nop
  80165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  801660:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  801664:	d3 e2                	shl    %cl,%edx
  801666:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801669:	ba 20 00 00 00       	mov    $0x20,%edx
  80166e:	2b 55 f0             	sub    -0x10(%ebp),%edx
  801671:	89 55 ec             	mov    %edx,-0x14(%ebp)
  801674:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
  801678:	89 fa                	mov    %edi,%edx
  80167a:	d3 ea                	shr    %cl,%edx
  80167c:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  801680:	0b 55 f4             	or     -0xc(%ebp),%edx
  801683:	d3 e7                	shl    %cl,%edi
  801685:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
  801689:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80168c:	89 f2                	mov    %esi,%edx
  80168e:	89 7d e8             	mov    %edi,-0x18(%ebp)
  801691:	89 c7                	mov    %eax,%edi
  801693:	d3 ea                	shr    %cl,%edx
  801695:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  801699:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  80169c:	89 c2                	mov    %eax,%edx
  80169e:	d3 e6                	shl    %cl,%esi
  8016a0:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
  8016a4:	d3 ea                	shr    %cl,%edx
  8016a6:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  8016aa:	09 d6                	or     %edx,%esi
  8016ac:	89 f0                	mov    %esi,%eax
  8016ae:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  8016b1:	d3 e7                	shl    %cl,%edi
  8016b3:	89 f2                	mov    %esi,%edx
  8016b5:	f7 75 f4             	divl   -0xc(%ebp)
  8016b8:	89 d6                	mov    %edx,%esi
  8016ba:	f7 65 e8             	mull   -0x18(%ebp)
  8016bd:	39 d6                	cmp    %edx,%esi
  8016bf:	72 2b                	jb     8016ec <__umoddi3+0x11c>
  8016c1:	39 c7                	cmp    %eax,%edi
  8016c3:	72 23                	jb     8016e8 <__umoddi3+0x118>
  8016c5:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  8016c9:	29 c7                	sub    %eax,%edi
  8016cb:	19 d6                	sbb    %edx,%esi
  8016cd:	89 f0                	mov    %esi,%eax
  8016cf:	89 f2                	mov    %esi,%edx
  8016d1:	d3 ef                	shr    %cl,%edi
  8016d3:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
  8016d7:	d3 e0                	shl    %cl,%eax
  8016d9:	0f b6 4d f0          	movzbl -0x10(%ebp),%ecx
  8016dd:	09 f8                	or     %edi,%eax
  8016df:	d3 ea                	shr    %cl,%edx
  8016e1:	83 c4 20             	add    $0x20,%esp
  8016e4:	5e                   	pop    %esi
  8016e5:	5f                   	pop    %edi
  8016e6:	5d                   	pop    %ebp
  8016e7:	c3                   	ret    
  8016e8:	39 d6                	cmp    %edx,%esi
  8016ea:	75 d9                	jne    8016c5 <__umoddi3+0xf5>
  8016ec:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8016ef:	1b 55 f4             	sbb    -0xc(%ebp),%edx
  8016f2:	eb d1                	jmp    8016c5 <__umoddi3+0xf5>
  8016f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  8016f8:	39 f2                	cmp    %esi,%edx
  8016fa:	0f 82 18 ff ff ff    	jb     801618 <__umoddi3+0x48>
  801700:	e9 1d ff ff ff       	jmp    801622 <__umoddi3+0x52>
