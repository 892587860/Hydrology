package com.hydro.mapper;

import com.hydro.model.TimingPackets;

public interface TimingPacketsMapper {
    int insert(TimingPackets record);

    int insertSelective(TimingPackets record);
}