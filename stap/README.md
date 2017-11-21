# trace_udp.stp

Simplest systemtap script which prints time of processing UDP packet inside kernel function udp_queue_rcv_skb.
You should use guru mode to have ability execute pure C functions inside script.

For more details see https://sourceware.org/systemtap.
