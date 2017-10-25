package com.hydro.mapper;

import java.util.List;

import com.hydro.model.TimingPacket;

public interface TimingPacketMapper {
    int insert(TimingPacket record);

    int insertSelective(TimingPacket record);
    
    List<TimingPacket> findAll();
}