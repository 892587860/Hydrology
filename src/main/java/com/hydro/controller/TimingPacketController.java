package com.hydro.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.hydro.model.TimingPacket;
import com.hydro.service.TimingPacketService;

@Controller
@RequestMapping(value = "/timing")
public class TimingPacketController {

	
	@Resource
	TimingPacketService timingPacketService;
	
	@RequestMapping(value = "/getAllData")
	@ResponseBody
	public List<TimingPacket> getAllPackets() {
		 
		return timingPacketService.findAll();
	}
}
