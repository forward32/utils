-- declare some fake protocol
p_fake_proto = Proto("fake", "Some fake protocol")
local f_seqnum = ProtoField.uint64("fake_seqnum", "seqnum", UINT64)

p_fake_proto.fields = {f_seqnum}

-- implement dissector logic
function p_fake_proto.dissector (buf, pkt, root)
  if buf:len() == 0 then return end
  pkt.cols.protocol = p_fake_proto.name

  subtree = root:add(p_fake_proto, buf(0))
  subtree:add_le(f_seqnum, buf(0,8))

  local seqnum = buf(0, 8):le_uint64()
  pkt.cols['info'] = "seqnum: "..seqnum
end

function p_fake_proto.init()
end

-- add your fake protocol to, for example, tcp dissector table for some ports
local tcp_dissector_table = DissectorTable.get("tcp.port")
tcp_dissector_table:add(55555, p_fake_proto)
