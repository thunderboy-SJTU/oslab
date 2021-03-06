#include "ns.h"

#define MAXBUFLEN 2048

extern union Nsipc nsipcbuf;

void
input(envid_t ns_envid)
{
	binaryname = "ns_input";

	// LAB 6: Your code here:
	// 	- read a packet from the device driver
	//	- send it to the network server
	// Hint: When you IPC a page to the network server, it will be
	// reading from it for a while, so don't immediately receive
	// another packet in to the same physical page.
        int r;
        int len;
        char buf[MAXBUFLEN];
        while(1){
          while((r = sys_receive_packet((uint32_t)buf,&len))<0)
             sys_yield();
          r = sys_page_alloc(0,&nsipcbuf,PTE_P|PTE_U|PTE_W);
          if(r < 0)
             panic("error: %e",r);
          memmove(nsipcbuf.pkt.jp_data,(void*)buf,len);
          nsipcbuf.pkt.jp_len = len;

          ipc_send(ns_envid,NSREQ_INPUT,&nsipcbuf,PTE_P|PTE_U|PTE_W);    
        }  
}
