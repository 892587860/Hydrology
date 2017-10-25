package com.hydro.service;

import java.util.List;

import com.hydro.model.TimingPacket;

public interface TimingPacketService {
	int insert(TimingPacket record);

	int insertSelective(TimingPacket record);
	
	List<TimingPacket> findAll();
}
