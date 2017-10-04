# fake_protocol.lua
Simplest wireshark dissector which represents some fake protocol with only one field 'fake_seqnum'.
The code is simplest, for more details see https://www.wireshark.org/docs/wsdg_html_chunked/ChapterDissection.html.

Usage:
1. Implement your own `dissector.lua` (you can use this one as example);
2. Open file `/usr/share/wireshark/init.lua` and add next lines:
```
YOUR_PROTO_PATH="path_to_your_dissector_folder"
dofile(YOUR_PROTO_PATH.."dissector.lua")
```
3. Check your dissector with wireshark or tshark;

I've checked my fake protocol using tcpdump (for writing .pcap file) and tshark (for filtering):
```
$ tshark -T fields -r temp_dump.pcap -Y fake -e frame.time_epoch -e fake_seqnum -E separator=, -E quote=d
"1507148242.573100000","0"
"1507148242.673190000","0"
"1507148242.673207000","1"
"1507148242.773302000","1"
"1507148242.773318000","2"
"1507148242.873408000","2"
"1507148242.873424000","3"
"1507148242.973495000","3"
"1507148242.973503000","4"
"1507148243.073729000","4"
```
