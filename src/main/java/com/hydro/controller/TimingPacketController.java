package com.hydro.controller;

import java.util.List;


import com.hydro.model.TimingPacket;
import com.hydro.service.TimingPacketService;
import com.hydro.util.SpringContextUtil;
public class TimingPacketController {


	public List<TimingPacket> getAllPackets() {
		TimingPacketService timingPacketService =
		  (TimingPacketService)SpringContextUtil.getBean(TimingPacketService.class);
		 
		return timingPacketService.findAll();
	}
}
